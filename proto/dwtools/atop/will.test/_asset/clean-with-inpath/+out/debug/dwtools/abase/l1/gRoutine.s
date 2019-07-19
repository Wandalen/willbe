( function _gRoutine_s_() {

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// routine
// --

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

  routinesComposeReturningLast,
  routinesComposeAll,
  routinesComposeAllReturningLast, /* !!! */
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
