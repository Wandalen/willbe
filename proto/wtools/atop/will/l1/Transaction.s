( function _Transaction_s_()
{

'use strict';

//

let _ = _global_.wTools;
const Parent = null;
let Self = wWillTransaction;
function wWillTransaction( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Transaction';

// --
// inter
// --

function finit()
{
  let t = this;

  t.unform();

  return _.Copyable.prototype.finit.apply( t, arguments );
}

//

function init( o )
{
  let t = this;

  _.assert( arguments.length === 1 );

  t.formAssociates( o );

  _.workpiece.initFields( t );
  Object.preventExtensions( t );

  if( o )
  t.copy( o )

  t.form();
}

//

function Make( properties, will )
{
  return new _.will.Transaction({ will, ... _.mapOnly_( null, properties, _.will.Transaction.TransactionFields ) });
}

//

function unform()
{
  let t = this;
  let will = t.will;
  let logger = will.logger;
  _.assert( logger.verbosity === t.verbosity, 'Verbosity of the main logger was changed' );
  t.formed = 0;
}

//

function form()
{
  let t = this;

  for( let p in TransactionFields )
  if( t[ p ] === null )
  t[ p ] = TransactionFields[ p ];

  if( !t.withPath )
  t.withPath = _.fileProvider.path.join( _.fileProvider.path.current(), './' );

  t.formed = 1;

  // Object.freeze( t );
}

//

function formAssociates( o )
{
  let t = this;
  _.assert( o.will instanceof _.Will );

  t.will = o.will;
  t.will.transaction = t;

  // if( o.logger )
  // t.logger = o.logger;
  // else
  // t.logger = new _.Logger({ output : t.will.logger, name : 'transaction' });

  // _.assert( t.logger instanceof _.Logger );
  // _.assert( t.logger.output === t.will.logger );
}

//

function verbosityGet()
{
  let t = this;
  let will = t.will;
  let logger = will.logger;
  // let logger = t.logger;
  _.assert( t.formed === 0 || logger.verbosity === t._.verbosity, 'Verbosity of the transaction logger was changed outside of the transaction' );
  /* qqq : for Vova : logger should always exists */
  return t._.verbosity;
}

//

function verbositySet( src )
{
  let t = this;
  let will = t.will;
  let logger = will.logger;
  // let logger = t.logger;

  if( t.formed )
  return;

  t._.verbosity = src;
  logger.verbosity = src;
}

//

function withSubmodulesSet( src )
{
  let t = this;

  _.assert( arguments.length === 1 );
  _.assert( _.boolIs( src ) || _.numberIs( src ) || src === null );

  if( _.boolIs( src ) )
  src = src ? 1 : 0;

  if( t.formed )
  return t._.withSubmodules;

  if( t._.withSubmodules === src )
  return t._.withSubmodules;

  t._.withSubmodules = src;

  if( src === null )
  {
  }
  else if( src )
  {
    t._.subModulesFormedOfMain = true;
    if( src === 2 )
    {
      t._.subModulesFormedOfSub = true;
      return 2;
    }
    else
    {
      t._.subModulesFormedOfSub = false;
      return 1;
    }
  }
  else
  {
    t._.subModulesFormedOfMain = false;
    t._.subModulesFormedOfSub = false;
    return 0;
  }

}

//

function _transactionPropertyGetter_functor( propName )
{
  return function get()
  {
    let t = this;
    _.assert( t._[ propName ] === null || _.boolLike( t._[ propName ] ) || _.strDefined( t._[ propName ] ) || _.numberIs( t._[ propName ] ) );
    return t._[ propName ];
  }
}

//

function _transactionPropertySetter_functor( propName )
{
  return function set( src )
  {
    let t = this;
    if( t.formed )
    return;
    t._[ propName ] = src;
  }
}

//

let TransactionFields =
{
  verbosity : 3,
  verboseStaging : 0,

  beeping : 0,

  ... _.Will.FilterFields,

  withPath : null,
  withSubmodules : null,


  ... _.Will.IntentionFields,

  willFileAdapting : 0
}

// --
// relations
// --

let Composes =
{
  ... TransactionFields,
}

let Aggregates =
{
  isInitial : 0,
}

let Associates =
{
  will : null, /* qqq : for Vova : remove */
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  Make,
  TransactionFields,
}

let Forbids =
{
}

let Accessors =
{
  _ : { get : _.accessor.getter.withSymbol, writable : 0 },
  verbosity : { get : verbosityGet, set : verbositySet },
  withSubmodules : { get : _transactionPropertyGetter_functor( 'withSubmodules' ), set : withSubmodulesSet },
}

_.each( TransactionFields, ( val, key ) =>
{
  if( !Accessors[ key ] )
  Accessors[ key ] = { get : _transactionPropertyGetter_functor( key ), set : _transactionPropertySetter_functor( key ) }
})

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  Make,

  unform,
  form,
  formAssociates,

  verbositySet,
  withSubmodulesSet,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;
_.will[ Self.shortName ] = Self;

})();
