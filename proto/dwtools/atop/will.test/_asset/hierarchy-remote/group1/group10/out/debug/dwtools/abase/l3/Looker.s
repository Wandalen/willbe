( function _Looker_s_() {

'use strict';

/**
 * Collection of light-weight routines to traverse complex data structure. The module takes care of cycles in a data structure( recursions ) and can be used for comparison or operation on several similar data structures, for replication. Several other modules used this to traverse abstract data structures.
  @module Tools/base/Looker
*/

/**
 * @file Looker.s.
 */

/**
 * Collection of light-weight routines to traverse complex data structure.
 * @namespace Tools( module::Looker )
 * @memberof module:Tools/base/Looker
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

}

let _global = _global_;
let _ = _global_.wTools;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

_.assert( !!_realGlobal_ );

// --
// looker
// --

/**
 * Makes iterator for Looker.
 *
 * @param {Object} o - Options map
 * @function iteratorInit
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function iteratorInit( o )
{

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.objectIs( this.Iterator ) );
  _.assert( _.objectIs( this.Iteration ) );
  _.assert( _.objectIs( o.Looker ) );
  _.assert( o.Looker === this );
  _.assert( o.looker === undefined );

  /* */

  let iterator = Object.create( o.Looker );
  Object.assign( iterator, this.Iterator );
  Object.assign( iterator, o );
  if( o.iteratorExtension )
  Object.assign( iterator, o.iteratorExtension );
  Object.preventExtensions( iterator );

  delete iterator.it;

  iterator.iterator = iterator;

  if( iterator.trackingVisits )
  {
    iterator.visited = [];
  }

  if( iterator.defaultUpToken === null )
  iterator.defaultUpToken = _.strsShortest( iterator.upToken );

  if( iterator.path === null )
  iterator.path = iterator.defaultUpToken;
  iterator.lastPath = iterator.path;

  /* important assert, otherwise copying options from iteration could cause problem */
  _.assert( iterator.it === undefined );
  _.assert( _.numberIs( iterator.level ) );
  _.assert( _.strIs( iterator.defaultUpToken ) );
  _.assert( _.strIs( iterator.path ) );
  _.assert( _.strIs( iterator.lastPath ) );

  return iterator;
}

//

function iterationIs( it )
{
  if( !it )
  return false;
  if( !it.Looker )
  return false;
  if( !it.iterator )
  return false;
  if( it.iterator === it )
  return false;
  if( it.constructor !== this.constructor )
  return false;
  return true;
}

//

function iteratorIs( it )
{
  if( !it )
  return false;
  if( !it.Looker )
  return false;
  if( it.iterator !== it )
  return false;
  if( it.constructor !== this.constructor )
  return false;
  return true;
}

// --
// iterator
// --

/**
 * @function iterationInitAct
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function iterationInitAct()
{
  let it = this;

  // _.assert( arguments.length === 0 );
  // _.assert( it.level >= 0 );
  // _.assert( _.objectIs( it.iterator ) );
  // _.assert( _.objectIs( it.Looker ) );
  // _.assert( it.looker === undefined );
  // _.assert( _.numberIs( it.level ) && it.level >= 0 );
  // _.assert( _.numberIs( it.logicalLevel ) && it.logicalLevel >= 0 );

  let newIt = Object.create( it.iterator );
  Object.assign( newIt, it.Looker.Iteration );
  if( it.iterator.iterationExtension )
  Object.assign( newIt, it.iterator.iterationExtension );
  Object.preventExtensions( newIt );

  for( let k in it.Looker.IterationPreserve )
  newIt[ k ] = it[ k ];

  if( it.iterationPreserve )
  for( let k in it.iterationPreserve )
  newIt[ k ] = it[ k ];

  if( it.iterator !== it )
  newIt.down = it;

  return newIt;
}

//

/**
 * @function iterationInit
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function iterationInit()
{
  let it = this;
  let newIt = it.iterationInitAct();

  newIt.logicalLevel = it.logicalLevel + 1;

  _.assert( arguments.length === 0 );

  return newIt;
}

//

/**
 * @function iterationReinit
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function iterationReinit()
{
  let it = this;
  let newIt = it.iterationInitAct();

  newIt.logicalLevel = it.logicalLevel;

  _.assert( arguments.length === 0 );

  return newIt;
}

//

/**
 * @function select
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function select( k )
{
  let it = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( it.level >= 0 );
  _.assert( _.objectIs( it.down ) );

  it.level = it.level+1;

  let isUp = _.strIs( k ) && _.strHasAny( k, it.upToken );
  let k2 = k;
  if( isUp )
  k2 = '"' + k2 + '"';

  // if( it.path === '/d' )
  // debugger;
  if( isUp || _.arrayHas( _.arrayAs( it.upToken ), it.path ) )
  {
    it.path = it.path + k2;
  }
  else
  {
    it.path = it.path + it.defaultUpToken + k2;
  }

  // let k2 = k;
  // if( _.strIs( k2 ) && _.strHasAny( k2, it.upToken ) )
  // k2 = '"' + k2 + '"';
  //
  // it.path = k !== it.upToken ? it.path + it.defaultUpToken + k2 : it.path + k2;
  //
  // console.log( it.path );

  it.iterator.lastPath = it.path;
  it.iterator.lastSelected = it;
  it.key = k;
  it.index = it.down.childrenCounter;

  if( it.src )
  it.src = it.src[ k ];
  else
  it.src = undefined;

  return it;
}

//

/**
 * @function look
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function look()
{
  let it = this;

  _.assert( it.level >= 0 );
  _.assert( arguments.length === 0 );

  it.visiting = it.canVisit();
  if( !it.visiting )
  return it;

  it.visitUp();

  it.ascending = it.canAscend();
  if( it.ascending === false )
  {
    it.visitDown();
    return it;
  }

  it.ascend( function( eit )
  {
    eit.look();
  });

  it.visitDown();
  return it;
}

//

/**
 * @function visitUp
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function visitUp()
{
  let it = this;

  it.visitUpBegin();

  _.assert( _.routineIs( it.onUp ) );
  let r = it.onUp.call( it, it.src, it.key, it );
  _.assert( r === undefined );

  it.visitUpEnd()

}

//

/**
 * @function visitUpBegin
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */


function visitUpBegin()
{
  let it = this;

  it.ascending = true;

  _.assert( it.visiting );
  if( !it.visiting )
  return;

  if( it.down )
  it.down.childrenCounter += 1;

  if( it.iterator.trackingVisits )
  {
    if( it.visited.indexOf( it.src ) !== -1 )
    it.visitedManyTimes = true;
  }

  _.assert( it.continue );

  if( it.continue )
  it.srcChanged();

}

//

/**
 * @function visitUpEnd
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */


function visitUpEnd()
{
  let it = this;

  if( it.continue === _.dont )
  it.continue = false;
  _.assert( _.boolIs( it.continue ), () => 'Expects boolean it.continue, but got ' + _.strType( it.continue ) );

  it.visitPush();

  // if( it.iterator.trackingVisits && it.trackingVisits )
  // {
  //   it.visited.push( it.src );
  // }

}

//

/**
 * @function visitDown
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function visitDown()
{
  let it = this;

  it.visitDownBegin();

  _.assert( it.visiting );
  if( it.visiting )
  if( it.onDown )
  {
    let r = it.onDown.call( it, it.src, it.key, it );
    _.assert( r === undefined );
  }

  it.visitDownEnd();

  return it;
}

//

/**
 * @function visitDownBegin
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function visitDownBegin()
{
  let it = this;

  it.ascending = false;

  _.assert( it.visiting );
  if( !it.visiting )
  return;

  if( !it.iterable )
  it.onTerminal();

  it.visitPop();

  // if( it.iterator.trackingVisits && it.trackingVisits )
  // {
  //   _.assert( Object.is( it.visited[ it.visited.length-1 ], it.src ), () => 'Top-most visit does not match ' + it.path );
  //   it.visited.pop();
  // }
  // it.trackingVisits = 0;

}

//

/**
 * @function visitDownEnd
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function visitDownEnd()
{
  let it = this;

}

//

function visitPush()
{
  let it = this;

  if( it.iterator.trackingVisits && it.trackingVisits )
  {
    it.visited.push( it.src );
  }

}

//

function visitPop()
{
  let it = this;

  if( it.iterator.trackingVisits && it.trackingVisits )
  {
    _.assert( Object.is( it.visited[ it.visited.length-1 ], it.src ), () => 'Top-most visit does not match ' + it.path );
    it.visited.pop();
  }
  it.trackingVisits = 0;

}

//

/**
 * @function canVisit
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function canVisit()
{
  let it = this;

  if( !it.recursive && it.down )
  return false

  if( !it.visitingRoot && it.root === it.src )
  return false;

  return true
}

//

/**
 * @function canAscend
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function canAscend()
{
  let it = this;

  _.assert( _.boolIs( it.continue ) );
  _.assert( _.boolIs( it.iterator.continue ) );

  if( !it.ascending )
  return false;

  if( it.continue === false )
  return false;
  else if( it.iterator.continue === false )
  return false;
  else if( it.visitedManyTimes )
  return false;

  _.assert( _.numberIs( it.recursive ) );
  if( it.recursive > 0 )
  if( !( it.level < it.recursive ) )
  return false;

  return true;
}

// --
// handler
// --

function onUp( e,k,it )
{
}

//

function onDown( e,k,it )
{
}

//

function onTerminal()
{
  let it = this;
  return it;
}

//

function ascend( onIteration )
{
  let it = this;

  _.assert( arguments.length === 1 );
  _.assert( it.iterable !== null && it.iterable !== undefined );
  _.assert( _.routineIs( onIteration ) );
  _.assert( onIteration.length === 0 || onIteration.length === 1 );
  _.assert( !!it.continue );
  _.assert( !!it.iterator.continue );

  if( it.iterable === 'array-like' )
  {

    for( let k = 0 ; k < it.src.length ; k++ )
    {
      let eit = it.iterationInit().select( k );

      onIteration.call( it, eit );

      if( !it.continue || it.continue === _.dont )
      break;

      if( !it.iterator.continue || it.iterator.continue === _.dont )
      break;

    }

  }
  else if( it.iterable === 'map-like' )
  {

    for( let k in it.src )
    {

      if( it.own )
      if( !_ObjectHasOwnProperty.call( it.src, k ) )
      continue;

      let eit = it.iterationInit().select( k );

      onIteration.call( it, eit );

      if( !it.continue || it.continue === _.dont )
      break;

      if( !it.iterator.continue || it.iterator.continue === _.dont )
      break;

    }

  }

}

//

function srcChanged()
{
  let it = this;

  _.assert( arguments.length === 0 );

  if( _.arrayLike( it.src ) )
  {
    it.iterable = 'array-like';
  }
  else if( _.mapLike( it.src ) )
  {
    it.iterable = 'map-like';
  }
  else
  {
    it.iterable = false;
  }

}

// --
// relations
// --

/**
 * Default options for {@link module:Tools/base/Looker.Looker.look} routine.
 * @typedef {Object} Defaults
 * @property {Function} onUp
 * @property {Function} onDown
 * @property {Function} onTerminal
 * @property {Function} ascend
 * @property {Function} onIterable
 * @property {Boolean} own = 0;
 * @property {Number} recursive = Infinity
 * @property {Boolean} visitingRoot = 1
 * @property {Boolean} trackingVisits = 1
 * @property {String} upToken = '/'
 * @property {String} path = null
 * @property {Number} level = 0
 * @property {Number} logicalLevel = 0
 * @property {*} src = null
 * @property {*} root = null
 * @property {*} context = null
 * @property {Object} Looker = null
 * @property {Object} it = null
 * @property {Boolean} iterationPreserve = null
 * @property {*} iterationExtension = null
 * @property {*} iteratorExtension = null
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

let Defaults = Object.create( null );

Defaults.onUp = onUp;
Defaults.onDown = onDown;
Defaults.onTerminal = onTerminal;
Defaults.own = 0;
Defaults.recursive = Infinity;
Defaults.visitingRoot = 1;
Defaults.trackingVisits = 1;
Defaults.upToken = '/';
Defaults.defaultUpToken = null;
Defaults.path = null;
Defaults.level = 0;
Defaults.logicalLevel = 0;
Defaults.src = null;
Defaults.root = null;
Defaults.context = null;
Defaults.Looker = null;
Defaults.it = null;
Defaults.iterationPreserve = null;
Defaults.iterationExtension = null;
Defaults.iteratorExtension = null;

//

/**
 * @typedef {Object} looker
 * @property {Object} Looker
 * @property {Object} Iterator
 * @property {Object} Iteration
 * @property {Boolean} IterationPreserve
 * @property {} iterator
 * @memberof module:Tools/base/Looker.Tools( module::Looker ).Defaults
 */

let Looker = Defaults.Looker = Object.create( null );

Looker.constructor = function Looker(){};
Looker.Looker = Looker;
Looker.Iterator = null;
Looker.Iteration = null;
Looker.IterationPreserve = null;
Looker.iteratorInit = iteratorInit;
Looker.iterationIs = iterationIs,
Looker.iteratorIs = iteratorIs;

Looker.iterationInitAct = iterationInitAct;
Looker.iterationInit = iterationInit;
Looker.iterationReinit = iterationReinit;
Looker.select = select;
Looker.look = look;

Looker.visitUp = visitUp;
Looker.visitUpBegin = visitUpBegin;
Looker.visitUpEnd = visitUpEnd;
Looker.visitDown = visitDown;
Looker.visitDownBegin = visitDownBegin;
Looker.visitDownEnd = visitDownEnd;
Looker.visitPush = visitPush;
Looker.visitPop = visitPop;

Looker.canVisit = canVisit;
Looker.canAscend = canAscend;
Looker.ascend = ascend;
Looker.srcChanged = srcChanged;

//

/**
 * @typedef {Object} Iterator
 * @property {} iterator = null
 * @property {} iterationInitAct = iterationInitAct
 * @property {} iterationInit = iterationInit
 * @property {} iterationReinit = iterationReinit
 * @property {} select = select
 * @property {} look = look
 * @property {} visitUp = visitUp
 * @property {} visitUpBegin = visitUpBegin
 * @property {} visitUpEnd = visitUpEnd
 * @property {} visitDown = visitDown
 * @property {} visitDownBegin = visitDownBegin
 * @property {} visitDownEnd = visitDownEnd
 * @property {} canVisit = canVisit
 * @property {} canAscend = canAscend
 * @property {} path = null
 * @property {} lastPath = null
 * @property {} lastSelected = null
 * @property {} continue = true
 * @property {} key = null
 * @property {} error = null
 * @property {} visited = null
 * @memberof module:Tools/base/Looker.Tools( module::Looker ).Defaults.Looker
 */

let Iterator = Looker.Iterator = Object.create( null );

Iterator.iterator = null;
Iterator.path = null;
Iterator.lastPath = null;
Iterator.lastSelected = null;
Iterator.continue = true;
Iterator.key = null;
Iterator.error = null;
Iterator.visited = null;

_.mapSupplement( Iterator, Defaults );
Object.freeze( Iterator );

//

/**
 * @typedef {Object} Iteration
 * @property {} childrenCounter = 0
 * @property {} level = 0
 * @property {} logicalLevel = 0
 * @property {} path = '/'
 * @property {} key = null
 * @property {} index = null
 * @property {} src = null
 * @property {} continue = true
 * @property {} ascending = true
 * @property {} visitedManyTimes = false
 * @property {} _ = null
 * @property {} down = null
 * @property {} visiting = false
 * @property {} iterable = null
 * @property {} trackingVisits = 1
 * @memberof module:Tools/base/Looker.Tools( module::Looker ).Defaults.Looker
 */

let Iteration = Looker.Iteration = Object.create( null );
Iteration.childrenCounter = 0;
Iteration.level = 0,
Iteration.logicalLevel = 0;
Iteration.path = '/';
Iteration.key = null;
Iteration.index = null;
Iteration.src = null;
Iteration.continue = true;
Iteration.ascending = true;
Iteration.visitedManyTimes = false;
Iteration._ = null;
Iteration.down = null;
Iteration.visiting = false;
Iteration.iterable = null;
Iteration.trackingVisits = 1;
Object.freeze( Iteration );

//

/**
 * @typedef {Object} IterationPreserve
 * @property {} level = null
 * @property {} path = null
 * @property {} src = null
 * @memberof module:Tools/base/Looker.Tools( module::Looker ).Defaults.Looker
 */

let IterationPreserve = Looker.IterationPreserve = Object.create( null );
IterationPreserve.level = null;
IterationPreserve.path = null;
IterationPreserve.src = null;
Object.freeze( IterationPreserve );

//

let ErrorLooking = _.error_functor( 'ErrorLooking' );

// --
// expose
// --

function look_pre( routine, args )
{
  let o;

  if( args.length === 1 )
  {
    if( _.numberIs( args[ 0 ] ) )
    o = { accuracy : args[ 0 ] }
    else
    o = args[ 0 ];
  }
  else if( args.length === 2 )
  {
    o = { src : args[ 0 ], onUp : args[ 1 ] };
  }
  else if( args.length === 3 )
  {
    o = { src : args[ 0 ], onUp : args[ 1 ], onDown : args[ 2 ] };
  }
  else _.assert( 0,'look expects single options map, 2 or 3 arguments' );

  o.Looker = o.Looker || routine.defaults.Looker;

  if( _.boolIs( o.recursive ) )
  o.recursive = o.recursive ? Infinity : 1;

  if( o.iterationPreserve )
  o.iterationExtension = _.mapSupplement( o.iterationExtension, o.iterationPreserve );
  if( o.iterationPreserve )
  o.iteratorExtension = _.mapSupplement( o.iteratorExtension, o.iterationPreserve );

  _.routineOptionsPreservingUndefines( routine, o );
  _.assert( _.objectIs( o.Looker ), 'Expects options {o.Looker}' );
  _.assert( o.Looker.Looker === o.Looker );
  _.assert( o.looker === undefined );
  _.assert( args.length === 1 || args.length === 2 || args.length === 3 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( o.onUp === null || o.onUp.length === 0 || o.onUp.length === 3, 'onUp should expect exactly three arguments' );
  _.assert( o.onDown === null || o.onDown.length === 0 || o.onDown.length === 3, 'onUp should expect exactly three arguments' );
  _.assert( _.numberIsInt( o.recursive ), 'Expects integer {- o.recursive -}' );

  if( o.it === null || o.it === undefined )
  {
    let iterator = o.Looker.iteratorInit( o );
    o.it = iterator.iterationInit();
    return o.it;
  }
  else
  {

    // debugger; // xxx
    let iterator = o.it.iterator;
    for( let k in o )
    {
      if( iterator[ k ] === null && o[ k ] !== null && o[ k ] !== undefined )
      {
        debugger;
        iterator[ k ] = o[ k ];
      }
    }

    return o.it;
  }

}

//

function look_body( it )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( it.Looker ) );
  _.assert( _.isPrototypeOf( it.Looker, it ) );
  _.assert( it.looker === undefined );
  return it.look();
}

look_body.defaults = Object.create( Defaults );

//

/**
 * @function look
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

let lookAll = _.routineFromPreAndBody( look_pre, look_body );

var defaults = lookAll.defaults;
defaults.own = 0;
defaults.recursive = Infinity;

//

/**
 * @function lookOwn
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

let lookOwn = _.routineFromPreAndBody( look_pre, look_body );

var defaults = lookOwn.defaults;
defaults.own = 1;
defaults.recursive = Infinity;

//

/**
 * @function lookerIs
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function lookerIs( looker )
{
  if( !looker )
  return false;
  if( !looker.Looker )
  return false;
  return _.isPrototypeOf( looker, looker.Looker );
}

//

/**
 * @function lookIteratorIs
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function lookIteratorIs( it )
{
  if( !it )
  return false;
  if( !it.Looker )
  return false;
  if( it.iterator !== it )
  return false;
  return true;
}

//

/**
 * @function lookIterationIs
 * @memberof module:Tools/base/Looker.Tools( module::Looker )
 */

function lookIterationIs( it )
{
  if( !it )
  return false;
  if( !it.Looker )
  return false;
  if( !it.iterator )
  return false;
  if( it.iterator === it )
  return false;
  return true;
}

// --
// declare
// --

let Supplement =
{

  Looker,
  ErrorLooking,

  look : lookAll,
  lookAll,
  lookOwn,

  lookerIs,
  lookIteratorIs,
  lookIterationIs,

}

let Self = Looker;
_.mapSupplement( _, Supplement );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
