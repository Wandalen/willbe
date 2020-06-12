( function _ModuleHandle_s_( ) {

'use strict';

let _ = _global_.wTools;
let Parent = null;
let Self = wWillModuleHandle;
function wWillModuleHandle( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModuleHandle';

// --
// inter
// --

function finit()
{
  let self = this;
  let will = self.will;
  return _.Copyable.prototype.finit.apply( self, arguments );
}

//

function init( o )
{
  let self = this;
  _.workpiece.initFields( self );
  Object.preventExtensions( self );
  if( o )
  self.copy( o );
  return self;
}

//

function toModule()
{
  let self = this;
  let result = self.object;
  if( !( result instanceof _.Will.Module ) )
  result = null;
  if( result === null )
  {
    if( self.object )
    result = self.object.toModule();
    if( result === null && self.junction )
    result = self.junction.toModule();
  }
  _.assert( result === null || result instanceof _.Will.Module );
  return result;
}

//

function toOpener()
{
  let self = this;
  let result = self.object;
  if( !( result instanceof _.Will.ModuleOpener ) )
  result = null;
  if( result === null )
  {
    if( self.object )
    result = self.object.toOpener();
    if( result === null && self.junction )
    result = self.junction.toOpener();
  }
  _.assert( result === null || result instanceof _.Will.ModuleOpener );
  return result;
}

//

function toRelation()
{
  let self = this;
  let result = self.object;
  if( !( result instanceof _.Will.ModuleRelation ) )
  result = null;
  if( result === null )
  {
    if( self.object )
    result = self.object.toRelation();
    if( result === null && self.junction )
    result = self.junction.toRelation();
  }
  _.assert( result === null || result instanceof _.Will.ModuleRelation );
  return result;
}

//

function toJunction()
{
  let self = this;
  let result = self.junction;
  _.assert( result === null || result instanceof _.Will.ModuleJunction );
  return result;
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
  junction : null,
  object : null,
}

let Medials =
{
}

let Restricts =
{
}

let Statics =
{
}

let Forbids=
{
}

let Accessors =
{
}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,

  toModule,
  toOpener,
  toRelation,
  toJunction,

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
  extend : Extend,
});

_.Copyable.mixin( Self );

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

_.will[ Self.shortName ] = Self;

})();
