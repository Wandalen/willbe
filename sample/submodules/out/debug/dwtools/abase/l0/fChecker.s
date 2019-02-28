( function _fChecker_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
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
  let t = _ObjectToString.call( src );
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
  let result = _ObjectToString.call( src ) === '[object Symbol]';
  return result;
}

//

function bigIntIs( src )
{
  let result = _ObjectToString.call( src ) === '[object BigInt]';
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
  return _.routineIs( src.then ) && _.routineIs( src.catch );
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

function prototypeOf( subPrototype, superPrototype )
{
  _.assert( arguments.length === 2, 'Expects single argument' );
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
  return _.prototypeOf( subPrototype, superPrototype );
}

//

/**
 * Is prototype.
 * @function prototypeIs
 * @param {object} src - entity to check
 * @memberof wTools#
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
 * Is constructor.
 * @function constructorIs
 * @param {object} cls - entity to check
 * @memberof wTools#
 */

function constructorIs( cls )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.routineIs( cls ) && !instanceIs( cls );
}

//

function constructorIsStandard( cls )
{

  _.assert( _.constructorIs( cls ) );

  let prototype = _.prototypeGet( cls );

  return _.prototypeIsStandard( prototype );
}

/**
 * Is instance.
 * @function instanceIs
 * @param {object} src - entity to check
 * @memberof wTools#
 */

function instanceIs( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.primitiveIs( src ) )
  return false;

  if( _ObjectHasOwnProperty.call( src,'constructor' ) )
  return false;
  else if( _ObjectHasOwnProperty.call( src,'prototype' ) && src.prototype )
  return false;

  if( Object.getPrototypeOf( src ) === Object.prototype )
  return false;
  if( Object.getPrototypeOf( src ) === null )
  return false;

  return true;
}

//

function instanceIsStandard( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.instanceIs( src ) )
  return false;

  let proto = _.prototypeGet( src );

  if( !proto )
  return false;

  return _.prototypeIsStandard( proto );
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

function processIsDebugged()
{
  _.assert( arguments.length === 0 );

  if( typeof process === 'undefined' )
  return false;

  if( !process.execArgv.length )
  return false;

  let execArgv = process.execArgv.join();
  return _.strHas( execArgv, '--inspect' );

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

  nothingIs : nothingIs,
  definedIs : definedIs,
  primitiveIs : primitiveIs,
  containerIs : containerIs,
  containerLike : containerLike,

  symbolIs : symbolIs,
  bigIntIs : bigIntIs,

  vectorIs : vectorIs,
  constructorIsVector : constructorIsVector,
  spaceIs : spaceIs,
  constructorIsSpace : constructorIsSpace,

  consequenceIs : consequenceIs,
  consequenceLike : consequenceLike,
  promiseIs : promiseIs,
  promiseLike : promiseLike,

  typeOf : typeOf,
  prototypeOf : prototypeOf,
  prototypeHas : prototypeHas,
  prototypeIs : prototypeIs,
  prototypeIsStandard : prototypeIsStandard,
  constructorIs : constructorIs,
  constructorIsStandard : constructorIsStandard,
  instanceIs : instanceIs,
  instanceIsStandard : instanceIsStandard,
  instanceLike : instanceLike,

  workerIs : workerIs,
  streamIs : streamIs,
  consoleIs : consoleIs,
  printerLike : printerLike,
  printerIs : printerIs,
  loggerIs : loggerIs,
  processIs : processIs,
  processIsDebugged : processIsDebugged,
  definitionIs : definitionIs,

}

//

Object.assign( Self, Routines );
Object.assign( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
