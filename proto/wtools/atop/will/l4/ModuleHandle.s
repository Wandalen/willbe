( function _ModuleHandle_s_()
{

'use strict';

const _ = _global_.wTools;
const Parent = null;
const Self = wWillModuleHandle;
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
  self.form();
  return self;
}

//

function form()
{
  let self = this;

  if( self.will === null )
  {
    if( self.object )
    self.will = self.object.will ? self.object.will : self.object.module.will;
    else if( self.junction )
    self.will = self.junction.will;
  }

  _.assert( self.will instanceof _.Will );

  if( self.junction === null )
  self.junction = self.object.toJunction();

  _.assert( self.junction instanceof _.will.ModuleJunction );
  _.assert( !!self.object );

  return self;
}

//

function From( object, will )
{
  let cls = this;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  if( object instanceof Self )
  return object;

  let o = object;
  if( !_.mapIs( o ) )
  o = { object };

  if( will )
  o.will = will;

  _.assert( _.objectIs( o.object ) );
  _.assert( o.will instanceof _.Will );

  return cls.Self( o );
}

//

function Froms( objects, will )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.argumentsArray.like( objects ) )
  return _.filter_( null, objects, ( object ) => cls.From( object, will ) );
  else
  return cls.From( objects, will );
}

// --
// coercer
// --

function toModuleForResolver()
{
  let self = this;
  return self.toModule();
}

//

function toModule()
{
  let self = this;
  let result = self.object;
  if( !( result instanceof _.will.Module ) )
  result = null;
  if( result === null )
  {
    if( self.object )
    result = self.object.toModule();
    if( result === null && self.junction )
    result = self.junction.toModule();
  }
  _.assert( result === null || result instanceof _.will.Module );
  return result;
}

//

function toOpener()
{
  let self = this;
  let result = self.object;
  if( !( result instanceof _.will.ModuleOpener ) )
  result = null;
  if( result === null )
  {
    if( self.object )
    result = self.object.toOpener();
    if( result === null && self.junction )
    result = self.junction.toOpener();
  }
  _.assert( result === null || result instanceof _.will.ModuleOpener );
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
  _.assert( result === null || result instanceof _.will.ModuleJunction );
  return result;
}

// --
// accessor
// --

function dirPathGet()
{
  let self = this;
  if( self.junction )
  return self.junction.dirPath;
  return null;
}

//

function enabledGet()
{
  let self = this;
  if( self.junction )
  return self.junction.enabled;
  return null;
}

//

function isRemoteGet()
{
  let self = this;
  if( self.junction )
  return self.junction.isRemote;
  return null;
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
  From,
  Froms,
}

let Forbids =
{
}

let Accessors =
{
  dirPath : { get : dirPathGet, writable : 0 },
  enabled : { get : enabledGet, writable : 0 },
  isRemote : { get : isRemoteGet, writable : 0 },
}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  form,
  From,
  Froms,

  // coercer

  toModuleForResolver,
  toModule,
  toOpener,
  toRelation,
  toJunction,

  // accessor

  dirPathGet,
  enabledGet,
  isRemoteGet,

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
