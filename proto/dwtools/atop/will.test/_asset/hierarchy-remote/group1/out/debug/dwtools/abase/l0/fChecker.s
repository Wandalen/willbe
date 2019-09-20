( function _bChecker_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
// let Object.prototype.toString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// type test
// --

function nothingIs( src )
{
  if( src === null )
  return true;
  if( src === undefined )
  return true;
  if( src === _.nothing )
  return true;
  return false;
}

//

function definedIs( src )
{
  return src !== undefined && src !== null && src !== NaN && src !== _.nothing;
}

//

function primitiveIs( src )
{
  if( !src )
  return true;
  let t = Object.prototype.toString.call( src );
  return t === '[object Symbol]' || t === '[object Number]' || t === '[object BigInt]' || t === '[object Boolean]' || t === '[object String]';
}

//

function containerIs( src )
{
  if( _.arrayLike( src ) )
  return true;
  if( _.objectIs( src ) )
  return true;
  return false;
}

//

function containerLike( src )
{
  if( _.longIs( src ) )
  return true;
  if( _.objectLike( src ) )
  return true;
  return false;
}

//

function symbolIs( src )
{
  let result = Object.prototype.toString.call( src ) === '[object Symbol]';
  return result;
}

//

function bigIntIs( src )
{
  let result = Object.prototype.toString.call( src ) === '[object BigInt]';
  return result;
}

//

function vectorIs( src )
{
  if( !_.objectIs( src ) )
  return false;
  if( !( '_vectorBuffer' in src ) )
  return false;

  if( _ObjectHasOwnProperty.call( src, 'constructor' ) )
  {
    debugger;
    return false;
  }

  return true;
}

//

function constructorIsVector( src )
{
  if( !src )
  return false;
  return '_vectorBuffer' in src.prototype;
}

//

function spaceIs( src )
{
  if( !src )
  return false;
  if( !_.Space )
  return false;
  if( src instanceof _.Space )
  return true;
}

//

function constructorIsSpace( src )
{
  if( !_.Space )
  return false;
  if( src === _.Space )
  return true;
  return false;
}

//

function consequenceIs( src )
{
  if( !src )
  return false;

  let prototype = Object.getPrototypeOf( src );
  if( !prototype )
  return false;

  return prototype.shortName === 'Consequence';
}

//

function consequenceLike( src )
{
  if( _.consequenceIs( src ) )
  return true;

  if( _.promiseIs( src ) )
  return true;

  return false;
}

//

function promiseIs( src )
{
  if( !src )
  return false;
  return src instanceof Promise;
}

//

function promiseLike( src )
{
  if( !src )
  return false;
  return _.routineIs( src.then ) && _.routineIs( src.catch ) && ( src.constructor ) && ( src.constructor.name === 'Promise' );
  // return _.routineIs( src.then ) && _.routineIs( src.catch ) && _.routineIs( src.reject ) &&  _.routineIs( src.resolve );
}

//

function typeOf( src, constructor )
{
  _.assert( arguments.length === 1 || arguments.length === 2, 'Expects single argument' );

  if( arguments.length === 2 )
  {
    return _.typeOf( src ) === constructor;
  }

  if( src === null || src === undefined )
  return null
  else if( _.numberIs( src ) || _.boolIs( src ) || _.strIs( src ) )
  {
    return src.constructor;
  }
  else if( src.constructor )
  {
    _.assert( _.routineIs( src.constructor ) && src instanceof src.constructor );
    return src.constructor;
  }
  else
  {
    return null;
  }
}

//

function isPrototypeOf( subPrototype, superPrototype )
{
  _.assert( arguments.length === 2, 'Expects two arguments, probably you meant routine prototypeOf' );
  if( subPrototype === superPrototype )
  return true;
  if( !subPrototype )
  return false;
  if( !superPrototype )
  return false;
  return Object.isPrototypeOf.call( subPrototype, superPrototype );
}

//

function prototypeHas( superPrototype, subPrototype )
{
  _.assert( arguments.length === 2, 'Expects single argument' );
  return _.isPrototypeOf( subPrototype, superPrototype );
}

//

/**
 * Is prototype.
 * @function prototypeIs
 * @param {object} src - entity to check
 * @memberof wTools
 */

function prototypeIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.primitiveIs( src ) )
  return false;
  return _ObjectHasOwnProperty.call( src, 'constructor' );
}

//

function prototypeIsStandard( src )
{

  if( !_.prototypeIs( src ) )
  return false;

  if( !_ObjectHasOwnProperty.call( src, 'Composes' ) )
  return false;

  return true;
}

//

/**
 * Checks if argument( cls ) is a constructor.
 * @function constructorIs
 * @param {Object} cls - entity to check
 * @memberof wTools
 */

function constructorIs( cls )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.routineIs( cls ) && !instanceIs( cls );
}

//

/**
 * Is instance of a class.
 * @function instanceIs
 * @param {object} src - entity to check
 * @memberof wTools
 */

function instanceIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.primitiveIs( src ) )
  return false;

  if( _ObjectHasOwnProperty.call( src, 'constructor' ) )
  return false;
  else if( _ObjectHasOwnProperty.call( src, 'prototype' ) && src.prototype )
  return false;

  if( Object.getPrototypeOf( src ) === Object.prototype )
  return false;
  if( Object.getPrototypeOf( src ) === null )
  return false;

  return true;
}

//

function instanceLike( src )
{
  if( _.primitiveIs( src ) )
  return false;
  if( src.Composes )
  return true;
  return false;
}

//

function workerIs( src )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( arguments.length === 1 )
  {
    if( typeof WorkerGlobalScope !== 'undefined' && src instanceof WorkerGlobalScope )
    return true;
    if( typeof Worker !== 'undefined' && src instanceof Worker )
    return true;
    return false;
  }
  else
  {
    return typeof WorkerGlobalScope !== 'undefined';
  }
}

//

function streamIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  return _.objectIs( src ) && _.routineIs( src.pipe )
}

//

function consoleIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( console.Console )
  if( src && src instanceof console.Console )
  return true;

  if( src !== console )
  return false;

  let result = Object.prototype.toString.call( src );
  if( result === '[object Console]' || result === '[object Object]' )
  return true;

  return false;
}

//

function printerLike( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( printerIs( src ) )
  return true;

  if( consoleIs( src ) )
  return true;

  return false;
}


//

function printerIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !src )
  return false;

  let prototype = Object.getPrototypeOf( src );
  if( !prototype )
  return false;

  if( src.MetaType === 'Printer' )
  return true;

  return false;
}

//

function loggerIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.Logger )
  return false;

  if( src instanceof _.Logger )
  return true;

  return false;
}

//

function processIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  let typeOf = _.strType( src );
  if( typeOf === 'ChildProcess' || typeOf === 'process' )
  return true;

  return false;
}

//

let Inspector = null;

function processIsDebugged()
{
  _.assert( arguments.length === 0 );

  if( typeof process === 'undefined' )
  return false;

  if( Inspector === null )
  try
  {
    Inspector = require( 'inspector' );
  }
  catch( err )
  {
    Inspector = false;
  }

  if( Inspector )
  return _.strIs( Inspector.url() );

  if( !process.execArgv.length )
  return false;

  let execArgvString = process.execArgv.join();
  return _.strHasAny( execArgvString, [ '--inspect', '--inspect-brk', '--debug-brk' ] );
}

//

function definitionIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !src )
  return false;

  if( !_.define )
  return false;

  return src instanceof _.define.Definition;
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

  /* qqq : requires good tests */

  nothingIs,
  definedIs,
  primitiveIs,
  containerIs,
  containerLike,

  symbolIs,
  bigIntIs,

  vectorIs,
  constructorIsVector,
  spaceIs,
  constructorIsSpace,

  consequenceIs,
  consequenceLike,
  promiseIs,
  promiseLike,

  typeOf,
  isPrototypeOf,
  prototypeHas,
  prototypeIs,
  prototypeIsStandard,
  constructorIs,
  instanceIs,
  instanceLike,

  workerIs,
  streamIs,
  consoleIs,
  printerLike,
  printerIs,
  loggerIs,
  processIs,
  processIsDebugged,
  definitionIs,

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
