( function _Transaction_s_()
{

'use strict';

//

let _ = _global_.wTools;
let Parent = null;
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

function unform()
{
  let t = this;
  let will = t.will;
  let logger = will.logger;
  _.assert( logger.verbosity === t.verbosity, 'Verbosity of the main logger was changed' );
  t.formed = 0;
  logger.verbosity = t._verbosityPrev;
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
}

//

function verbosityGet()
{
  let t = this;
  let will = t.will;
  let logger = will.logger;
  _.assert( t.formed === 0 || logger.verbosity === t._.verbosity, 'Verbosity of the main logger was changed outside of the transaction' );
  return t._.verbosity;
}

//

function verbositySet( src )
{
  let t = this;
  let will = t.will;
  let logger = will.logger;

  if( t.formed )
  return;

  if( t._verbosityPrev === null )
  t._verbosityPrev = logger.verbosity;
  logger.verbosity = src;
  t._.verbosity = src;
}

//

function _transactionPropertyGetter_functor( propName )
{
  return function get()
  {
    let t = this;
    _.assert( t._[ propName ] === null || _.boolLike( t._[ propName ] ) || _.strDefined( t._[ propName ] ) );
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
  v : 3,
  verbosity : 3,
  verboseStaging : 0,

  beeping : 0,

  ... _.Will.FilterFields,

  withPath : null,

  withSubmodules : null
}

// --
// relations
// --

let Composes =
{
  ... TransactionFields,

  isInitial : 0
}

let Aggregates =
{
}

let Associates =
{
  will : null
}

let Restricts =
{
  formed : 0,
  _verbosityPrev : null
}

let Statics =
{
  TransactionFields
}

let Forbids =
{
}

let Accessors =
{
  _ : { get : _.accessor.getter.withSymbol, writable : 0 },
  verbosity : { get : verbosityGet, set : verbositySet },
  v : { suite : _.accessor.suite.alias({ originalName : 'verbosity' }) },
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

  unform,
  form,
  formAssociates,

  verbositySet,

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

// _.staticDeclare
// ({
//   prototype : _.Will.prototype,
//   name : Self.shortName,
//   value : Self,
// });

})();
