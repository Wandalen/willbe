( function _Field_s_() {

'use strict';

let Self = _global_.wTools.field = _global_.wTools.field || Object.create( null );
let _global = _global_;
let _ = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
//
// --

function bypass()
{

  let routine = function bypass( dstContainer, srcContainer, key )
  {
    /*dstContainer[ key ] = srcContainer[ key ];*/
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

bypass.functionFamily = 'field-filter';

//

function assigning()
{

  let routine = function assigning( dstContainer, srcContainer, key )
  {
    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

assigning.functionFamily = 'field-mapper';

//

function primitive()
{

  let routine = function primitive( dstContainer, srcContainer, key )
  {
    if( !_.primitiveIs( srcContainer[ key ] ) )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

primitive.functionFamily = 'field-filter';

//

function hiding()
{

  let routine = function hiding( dstContainer, srcContainer, key )
  {
    Object.defineProperty( dstContainer, key,
    {
      value : srcContainer[ key ],
      enumerable : false,
      configurable : true,
    });
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

hiding.functionFamily = 'field-mapper';

//

function appendingAnything()
{

  let routine = function appendingAnything( dstContainer, srcContainer, key )
  {
    if( dstContainer[ key ] === undefined )
    dstContainer[ key ] = srcContainer[ key ];
    else
    dstContainer[ key ] = _.arrayAppendArrays( [], [ dstContainer[ key ], srcContainer[ key ] ] );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

appendingAnything.functionFamily = 'field-mapper';

//

function appendingArrays()
{

  let routine = function appendingArrays( dstContainer, srcContainer, key )
  {
    if( _.arrayIs( dstContainer[ key ] ) && _.arrayIs( srcContainer[ key ] ) )
    _.arrayAppendArray( dstContainer[ key ], srcContainer[ key ] );
    else
    dstContainer[ key ] = srcContainer[ key ];
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

appendingArrays.functionFamily = 'field-mapper';

//

function appendingOnce()
{

  let routine = function appendingOnce( dstContainer, srcContainer, key )
  {
    if( _.arrayIs( dstContainer[ key ] ) && _.arrayIs( srcContainer[ key ] ) )
    _.arrayAppendArrayOnce( dstContainer[ key ], srcContainer[ key ] );
    else
    dstContainer[ key ] = srcContainer[ key ];
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

appendingOnce.functionFamily = 'field-mapper';

//

function removing()
{

  let routine = function removing( dstContainer, srcContainer, key )
  {
    let dstElement = dstContainer[ key ];
    let srcElement = srcContainer[ key ];
    if( _.arrayIs( dstElement ) && _.arrayIs( srcElement ) )
    {
      if( dstElement === srcElement )
      dstContainer[ key ] = [];
      else
      _.arrayRemoveArrayOnce( dstElement, srcElement );
    }
    else if( dstElement === srcElement )
    {
      delete dstContainer[ key ];
    }
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

removing.functionFamily = 'field-mapper';

//

function notPrimitiveAssigning()
{

  let routine = function notPrimitiveAssigning( dstContainer, srcContainer, key )
  {
    if( _.primitiveIs( srcContainer[ key ] ) )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

notPrimitiveAssigning.functionFamily = 'field-mapper';

//

function assigningRecursive()
{

  let routine = function assigningRecursive( dstContainer, srcContainer, key )
  {
    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key,_.entityAssignFieldFromContainer );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

assigningRecursive.functionFamily = 'field-mapper';

//

function drop( dropContainer )
{

  debugger;

  _.assert( _.objectIs( dropContainer ) );

  let routine = function drop( dstContainer, srcContainer, key )
  {
    if( dropContainer[ key ] !== undefined )
    return false

    /*dstContainer[ key ] = srcContainer[ key ];*/
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

drop.functionFamily = 'field-filter';

// --
// src
// --

function srcDefined()
{

  let routine = function srcDefined( dstContainer, srcContainer, key )
  {
    if( srcContainer[ key ] === undefined )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter'; ;
  return routine;
}

srcDefined.functionFamily = 'field-filter';

//

function srcNull()
{

  let routine = function srcNull( dstContainer, srcContainer, key )
  {
    if( srcContainer[ key ] !== null )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter'; ;
  return routine;
}

srcNull.functionFamily = 'field-filter';

// --
// dst
// --

function dstNotConstant()
{

  let routine = function dstNotConstant( dstContainer, srcContainer, key )
  {
    let d = Object.getOwnPropertyDescriptor( dstContainer, key );
    if( !d )
    return true;
    if( !d.writable )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstAndSrcOwn.functionFamily = 'field-filter';

//

function dstAndSrcOwn()
{

  let routine = function dstAndSrcOwn( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    if( !_ObjectHasOwnProperty.call( dstContainer, key ) )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstAndSrcOwn.functionFamily = 'field-filter';

//

function dstUndefinedSrcNotUndefined()
{

  let routine = function dstUndefinedSrcNotUndefined( dstContainer, srcContainer, key )
  {
    if( dstContainer[ key ] !== undefined )
    return false;
    if( srcContainer[ key ] === undefined )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstUndefinedSrcNotUndefined.functionFamily = 'field-filter';

// --
// dstNotHas
// --

function dstNotHas()
{

  let routine = function dstNotHas( dstContainer, srcContainer, key )
  {

    // if( dstContainer[ key ] !== undefined )
    // return false;

    if( key in dstContainer )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotHas.functionFamily = 'field-filter';

//

function dstNotHasOrHasNull()
{

  let routine = function dstNotHasOrHasNull( dstContainer, srcContainer, key )
  {

    if( key in dstContainer && dstContainer[ key ] !== null )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotHasOrHasNull.functionFamily = 'field-filter';

//

function dstNotHasOrHasNil()
{

  let routine = function dstNotHasOrHasNil( dstContainer, srcContainer, key )
  {

    if( key in dstContainer && dstContainer[ key ] !== _.nothing )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotHasOrHasNil.functionFamily = 'field-filter';

//

function dstNotHasAssigning()
{

  let routine = function dstNotHasAssigning( dstContainer, srcContainer, key )
  {
    if( dstContainer[ key ] !== undefined )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotHasAssigning.functionFamily = 'field-mapper';

//

function dstNotHasAppending()
{

  let routine = function dstNotHasAppending( dstContainer, srcContainer, key )
  {
    if( key in dstContainer )
    {
      debugger;
      if( _.arrayIs( dstContainer[ key ] ) && _.arrayIs( srcContainer[ key ] ) )
      _.arrayAppendArray( dstContainer, srcContainer, key );
      return;
    }
    dstContainer[ key ] = srcContainer[ key ];
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotHasAppending.functionFamily = 'field-mapper';

//

function dstNotHasSrcPrimitive()
{

  let routine = function dstNotHasSrcPrimitive( dstContainer, srcContainer, key )
  {
    debugger;
    if( key in dstContainer )
    return false;

    if( !_.primitiveIs( srcContainer[ key ] ) )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';

  return routine;
}

dstNotHasSrcPrimitive.functionFamily = 'field-filter';

//

function dstNotHasSrcOwn()
{

  let routine = function dstNotHasSrcOwn( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    if( key in dstContainer )
    return false;

    /*dstContainer[ key ] = srcContainer[ key ];*/
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotHasSrcOwn.functionFamily = 'field-filter';

//

function dstNotHasSrcOwnAssigning()
{

  let routine = function dstNotHasSrcOwnAssigning( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return;
    if( key in dstContainer )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotHasSrcOwnAssigning.functionFamily = 'field-mapper';

//

function dstNotHasSrcOwnRoutines()
{

  let routine = function dstNotHasSrcOwnRoutines( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    if( !_.routineIs( srcContainer[ key ] ) )
    return false;
    if( key in dstContainer )
    return false;

    /*dstContainer[ key ] = srcContainer[ key ];*/

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotHasSrcOwnRoutines.functionFamily = 'field-filter';

//

function dstNotHasAssigningRecursive()
{

  let routine = function dstNotHasAssigningRecursive( dstContainer, srcContainer, key )
  {
    if( key in dstContainer )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key,_.entityAssignFieldFromContainer );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotHasAssigningRecursive.functionFamily = 'field-mapper';

// --
// dstNotOwn
// --

function dstNotOwn()
{

  let routine = function dstNotOwn( dstContainer, srcContainer, key )
  {

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotOwn.functionFamily = 'field-filter';

//

function dstNotOwnSrcOwn()
{

  let routine = function dstNotOwnSrcOwn( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return false;

    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstNotOwnSrcOwn.functionFamily = 'field-filter';

//

function dstNotOwnSrcOwnAssigning()
{

  let routine = function dstNotOwnSrcOwnAssigning( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return;

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotOwnSrcOwnAssigning.functionFamily = 'field-mapper';

//

function dstNotOwnOrUndefinedAssigning()
{

  let routine = function dstNotOwnOrUndefinedAssigning( dstContainer, srcContainer, key )
  {

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    {

      if( dstContainer[ key ] !== undefined )
      return;

    }

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotOwnOrUndefinedAssigning.functionFamily = 'field-mapper';

// //
//
// function dstNotOwnAssigning()
// {
//
//   let routine = function dstNotOwnAssigning( dstContainer, srcContainer, key )
//   {
//
//     if( _ObjectHasOwnProperty.call( dstContainer, key ) )
//     {
//
//       if( key in dstContainer )
//       return;
//
//     }
//
//     _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
//   }
//
//   routine.functionFamily = 'field-mapper';
//   return routine;
// }

//

function dstNotOwnAssigning()
{

  let routine = function dstNotOwnAssigning( dstContainer, srcContainer, key )
  {

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return;

    let srcElement = srcContainer[ key ];
    if( _.mapIs( srcElement ) || _.arrayIs( srcElement ) )
    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
    else
    dstContainer[ key ] = srcContainer[ key ];

  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotOwnAssigning.functionFamily = 'field-mapper';

//

function dstNotOwnAppending()
{

  let routine = function dstNotOwnAppending( dstContainer, srcContainer, key )
  {
    debugger;
    if( dstContainer[ key ] !== undefined )
    {
      debugger;
      if( _.arrayIs( dstContainer[ key ] ) && _.arrayIs( srcContainer[ key ] ) )
      _.arrayAppendArray( dstContainer, srcContainer, key );
    }
    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return;
    dstContainer[ key ] = srcContainer[ key ];
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

dstNotOwnAppending.functionFamily = 'field-mapper';

//

function dstNotOwnFromDefinition()
{

  let routine = function dstNotOwnFromDefinition( dstContainer, srcContainer, key )
  {

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return;

    if( _ObjectHasOwnProperty.call( dstContainer, Symbol.for( key ) ) )
    return;

    let srcElement = srcContainer[ key ];
    if( _.definitionIs( srcElement ) )
    dstContainer[ key ] = srcElement.valueGet();
    else
    dstContainer[ key ] = srcElement;

  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

//

function dstNotOwnFromDefinitionStrictlyPrimitive()
{

  let routine = function dstNotOwnFromDefinitionStrictlyPrimitive( dstContainer, srcContainer, key )
  {

    if( _ObjectHasOwnProperty.call( dstContainer, key ) )
    return;

    if( _ObjectHasOwnProperty.call( dstContainer, Symbol.for( key ) ) )
    return;

    let srcElement = srcContainer[ key ];
    if( _.definitionIs( srcElement ) )
    {
      dstContainer[ key ] = srcElement.valueGet();
    }
    else
    {
      _.assert( !_.consequenceIs( srcElement ) && ( _.primitiveIs( srcElement ) || _.routineIs( srcElement ) ), () => _.toStrShort( dstContainer ) + ' has non-primitive element ' + _.strQuote( key ) + ' use _.define.own instead' );
      dstContainer[ key ] = srcElement;
    }

  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

// --
// dstHas
// --

function dstHasMaybeUndefined()
{

  let routine = function dstHasMaybeUndefined( dstContainer, srcContainer, key )
  {
    if( key in dstContainer )
    return true;
    return false;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstHasMaybeUndefined.functionFamily = 'field-filter';

//

function dstHasButUndefined()
{

  let routine = function dstHasButUndefined( dstContainer, srcContainer, key )
  {
    if( dstContainer[ key ] === undefined )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstHasButUndefined.functionFamily = 'field-filter';

//

function dstHasSrcOwn()
{

  let routine = function dstHasSrcOwn( dstContainer, srcContainer, key )
  {
    if( !( key in dstContainer ) )
    return false;
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstHasSrcOwn.functionFamily = 'field-filter';

//

function dstHasSrcNotOwn()
{

  let routine = function dstHasSrcNotOwn( dstContainer, srcContainer, key )
  {
    if( !( key in dstContainer ) )
    return false;
    if( _ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

dstHasSrcNotOwn.functionFamily = 'field-filter';

// --
// srcOwn
// --

function srcOwn()
{

  let routine = function srcOwn( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;

    /*dstContainer[ key ] = srcContainer[ key ];*/
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

srcOwn.functionFamily = 'field-filter';

//

function srcOwnRoutines()
{

  let routine = function srcOwnRoutines( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    if( !_.routineIs( srcContainer[ key ] ) )
    return false;

    /*dstContainer[ key ] = srcContainer[ key ];*/
    return true;
  }

  routine.functionFamily = 'field-filter'; ;
  return routine;
}

srcOwnRoutines.functionFamily = 'field-filter';

//

function srcOwnAssigning()
{

  let routine = function assigning( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

srcOwnAssigning.functionFamily = 'field-mapper';

//

function srcOwnPrimitive()
{

  let routine = function srcOwnPrimitive( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return false;
    if( !_.primitiveIs( srcContainer[ key ] ) )
    return false;

    /*dstContainer[ key ] = srcContainer[ key ];*/
    return true;
  }

  routine.functionFamily = 'field-filter';
  return routine;
}

srcOwnPrimitive.functionFamily = 'field-filter';

//

function srcOwnNotPrimitiveAssigning()
{

  let routine = function srcOwnNotPrimitiveAssigning( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return;
    if( _.primitiveIs( srcContainer[ key ] ) )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

srcOwnNotPrimitiveAssigning.functionFamily = 'field-mapper';

//

function srcOwnNotPrimitiveAssigningRecursive()
{

  let routine = function srcOwnNotPrimitiveAssigningRecursive( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return;
    if( _.primitiveIs( srcContainer[ key ] ) )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key,_.entityAssignFieldFromContainer );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

srcOwnNotPrimitiveAssigningRecursive.functionFamily = 'field-mapper';

//

function srcOwnAssigningRecursive()
{

  let routine = function srcOwnAssigningRecursive( dstContainer, srcContainer, key )
  {
    if( !_ObjectHasOwnProperty.call( srcContainer, key ) )
    return;

    _.entityAssignFieldFromContainer( dstContainer, srcContainer, key,_.entityAssignFieldFromContainer );
  }

  routine.functionFamily = 'field-mapper';
  return routine;
}

srcOwnAssigningRecursive.functionFamily = 'field-mapper';

// --
//
// --

function and()
{

  let filters = [];
  let mappers = [];
  for( let a = 0 ; a < arguments.length ; a++ )
  {
    let routine = arguments[ a ];
    _.assert( _.routineIs( routine ) );
    _.assert( _.strIs( routine.functionFamily ) );
    if( routine.functionFamily === 'field-filter' )
    filters.push( routine );
    else if( routine.functionFamily === 'field-mapper' )
    mappers.push( routine );
    else throw _.err( 'Expects routine.functionFamily' );
  }

  if( mappers.length > 1 )
  throw _.err( 'can combineMethodUniform only one mapper with any number of filters' );

  let routine = function and( dstContainer, srcContainer, key )
  {

    for( let f = 0 ; f < filters.length ; f++ )
    {
      let filter = filters[ f ];

      let result = filter( dstContainer, srcContainer, key );
      _.assert( _.boolIs( result ) );
      if( result === false )
      return mappers.length ? undefined : false;
    }

    for( let m = 0 ; m < mappers.length ; m++ )
    {
      let mapper = mappers[ m ];

      let result = mapper( dstContainer, srcContainer, key );
      _.assert( result === undefined );
      return;
    }

    return mappers.length ? undefined : true;
  }

  routine.functionFamily = mappers.length ? 'field-mapper' : 'field-filter';
  return routine;
}

//

function mapperFromFilter( routine )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.routineIs( routine ), 'Expects routine but got', _.strType( routine ) );
  _.assert( _.strIs( routine.functionFamily ) );

  if( routine.functionFamily === 'field-filter' )
  {
    function r( dstContainer, srcContainer, key )
    {
      let result = routine( dstContainer, srcContainer, key );
      _.assert( _.boolIs( result ) );
      if( result === false )
      return;
      dstContainer[ key ] = srcContainer[ key ];
    }
    r.functionFamily = 'field-mapper';
    return r;
  }
  else if( routine.functionFamily === 'field-mapper' )
  {
    return routine;
  }
  else _.assert( 0,'Expects routine.functionFamily' );

}

//
//
// function mapperFromFilterRecursive( routine )
// {
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.routineIs( routine ) );
//   _.assert( _.strIs( routine.functionFamily ) );
//
//   debugger;
//
//   if( routine.functionFamily === 'field-filter' )
//   {
//     function r( dstContainer, srcContainer, key )
//     {
//       debugger;
//       let result = routine( dstContainer, srcContainer, key );
//       _.assert( _.boolIs( result ) );
//       if( result === false )
//       return;
//       dstContainer[ key ] = srcContainer[ key ];
//     }
//     r.functionFamily = 'field-mapper';
//     return r;
//   }
//   else if( routine.functionFamily === 'field-mapper' )
//   {
//     return routine;
//   }
//   else throw _.err( 'Expects routine.functionFamily' );
//
// }

// --
// setup
// --

function setup()
{

  for( let f in make )
  {
    let fi = make[ f ];

    if( fi.length )
    continue;

    fi = fi();

    if( fi.functionFamily === 'field-mapper' )
    {
      Extend.mapper[ f ] = fi;
    }
    else if( fi.functionFamily === 'field-filter' )
    {
      Extend.filter[ f ] = fi;
      Extend.mapper[ f ] = mapperFromFilter( fi );
    }
    else _.assert( 0,'unexpected' );

  }

}

// --
// make
// --

let make =
{

  //

  bypass : bypass,
  assigning : assigning,
  primitive : primitive,
  hiding : hiding,
  appendingAnything : appendingAnything,
  appendingArrays : appendingArrays,
  appendingOnce : appendingOnce,
  removing : removing,
  notPrimitiveAssigning : notPrimitiveAssigning,
  assigningRecursive : assigningRecursive,
  drop : drop,

  // src

  srcDefined : srcDefined,
  srcNull : srcNull,

  // dst

  dstNotConstant : dstNotConstant,
  dstAndSrcOwn : dstAndSrcOwn,
  dstUndefinedSrcNotUndefined : dstUndefinedSrcNotUndefined,

  // dstNotHas

  dstNotHas : dstNotHas,
  dstNotHasOrHasNull : dstNotHasOrHasNull,
  dstNotHasOrHasNil : dstNotHasOrHasNil,

  dstNotHasAssigning : dstNotHasAssigning,
  dstNotHasAppending : dstNotHasAppending,
  dstNotHasSrcPrimitive : dstNotHasSrcPrimitive,

  dstNotHasSrcOwn : dstNotHasSrcOwn,
  dstNotHasSrcOwnAssigning : dstNotHasSrcOwnAssigning,
  dstNotHasSrcOwnRoutines : dstNotHasSrcOwnRoutines,
  dstNotHasAssigningRecursive : dstNotHasAssigningRecursive,

  // dstNotOwn

  dstNotOwn : dstNotOwn,
  dstNotOwnSrcOwn : dstNotOwnSrcOwn,
  dstNotOwnSrcOwnAssigning : dstNotOwnSrcOwnAssigning,
  dstNotOwnOrUndefinedAssigning : dstNotOwnOrUndefinedAssigning,
  dstNotOwnAssigning : dstNotOwnAssigning,
  dstNotOwnAppending : dstNotOwnAppending,
  dstNotOwnFromDefinition : dstNotOwnFromDefinition,
  dstNotOwnFromDefinitionStrictlyPrimitive : dstNotOwnFromDefinitionStrictlyPrimitive,

  // dstHas

  dstHasMaybeUndefined : dstHasMaybeUndefined,
  dstHasButUndefined : dstHasButUndefined,
  dstHasSrcOwn : dstHasSrcOwn,
  dstHasSrcNotOwn : dstHasSrcNotOwn,

  // srcOwn

  srcOwn : srcOwn,
  srcOwnRoutines : srcOwnRoutines,
  srcOwnAssigning : srcOwnAssigning,
  srcOwnPrimitive : srcOwnPrimitive,
  srcOwnNotPrimitiveAssigning : srcOwnNotPrimitiveAssigning,
  srcOwnNotPrimitiveAssigningRecursive : srcOwnNotPrimitiveAssigningRecursive,
  srcOwnAssigningRecursive : srcOwnAssigningRecursive,

}

// --
// extend
// --

let Extend =
{

  make : make,
  mapper : Object.create( null ),
  filter : Object.create( null ),
  and : and,
  mapperFromFilter : mapperFromFilter,

}

setup();

Object.assign( Self, Extend );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
