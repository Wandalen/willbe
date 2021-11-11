( function _AbstractJunction_s_()
{

'use strict';

/**
 * @classdesc Class wWillAbstractJunction implements interface that allows different interfaces : module, relation, opener, object as single instance.
 * @class wWillAbstractJunction
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = null;
const Self = wWillAbstractJunction;
function wWillAbstractJunction( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractJunction';

// --
// inter
// --

function finit()
{
  let junction = this;
  return _.Copyable.prototype.finit.apply( junction, arguments );
}

//

function init( o )
{
}

// --
// relations
// --

let Composes =
{
};

let Aggregates =
{
};

let Associates =
{
};

let Medials =
{
};

let Restricts =
{
};

let Statics =
{
};

let Forbids =
{
};

let Accessors =
{
};

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
  Medials,
  Restricts,
  Statics,
  Forbids,
  Accessors,
};

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

// _.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();

