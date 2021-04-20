( function _AbstractModule1_s_()
{

'use strict';

/**
 * @classdesc Class wWillAbstractModule provides common interface modules.
 * @class wWillAbstractModule
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = null;
const Self = wWillAbstractModule1;
function wWillAbstractModule1( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractModule1';

// --
// inter
// --

function finit()
{
  let module = this;
  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init()
{
  let module = this;
  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;
}

// --
// relator
// --

function ownedBy( object )
{
  let module = this;

  if( _.arrayIs( object ) )
  return !!_.any( object, ( object ) => module.ownedBy( object ) );

  _.assert( !!object );

  return object.own( module );
}

//

function errorGet()
{
  let module = this;
  return null;
}

// --
// name
// --

function qualifiedNameGet()
{
  let module = this;
  let name = module.name;
  return 'module' + '::' + name;
}

//

function decoratedQualifiedNameGet()
{
  let module = this;
  let result = module.qualifiedName;
  return _.color.strFormat( result, 'entity' );
}

//

function decoratedAbsoluteNameGet()
{
  let module = this;
  let result = module.absoluteName;
  return _.color.strFormat( result, 'entity' );
}

//

function nameWithLocationGet()
{
  let module = this;
  // let name = _.ct.format( module.qualifiedName + '#' + module.id, 'entity' );
  let name = _.ct.format( module.qualifiedName, 'entity' );
  if( module.localPath )
  {
    let localPath = _.ct.format( module.localPath, 'path' );
    let result = `${name} at ${localPath}`;
    return result;
  }
  else
  {
    let result = `${name}`;
    return result;
  }
}

// --
// relations
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  will : null,
}

let Medials =
{
}

let Restricts =
{
  id : null,
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{

  qualifiedName : { get : qualifiedNameGet, writable : 0 },
  nameWithLocation : { writable : 0 },
  decoratedQualifiedName : { get : decoratedQualifiedNameGet, combining : 'rewrite', writable : 0 },
  decoratedAbsoluteName : { get : decoratedAbsoluteNameGet, writable : 0 },

  __ : { get : _.accessor.getter.withSymbol, writable : 0, strict : 0 },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,

  // relator

  own : null,
  ownedBy,
  errorGet,

  // name

  qualifiedNameGet,
  decoratedQualifiedNameGet,
  decoratedAbsoluteNameGet,
  nameWithLocationGet,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
