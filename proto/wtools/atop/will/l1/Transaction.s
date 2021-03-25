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
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let transaction = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( transaction );
  Object.preventExtensions( transaction );

  if( o )
  transaction.copy( o );

  for( let p in TransactionFields )
  if( transaction[ p ] === null )
  transaction[ p ] = TransactionFields[ p ];

  Object.freeze( transaction );
}

//

let TransactionFields =
{
  v : null,
  verbosity : 3,

  ... _.Will.FilterFields,

  withSubmodules : null
}

// --
// relations
// --

let Composes =
{
  ... TransactionFields
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
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
  v : { suite : _.accessor.suite.alias({ originalName : 'verbosity' }) },
}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,

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
