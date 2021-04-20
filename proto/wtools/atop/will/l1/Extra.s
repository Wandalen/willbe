( function _Extra_s_()
{

'use strict';

const _ = _global_.wTools;
const Self = _.will = _.will || Object.create( null );

// --
// routines
// --

function isJunction( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  if( !object )
  return false;
  if( object instanceof _.will.ModuleJunction )
  return true;
  return false;
}

// --
// relations
// --

const ModuleVariant = [ '/', '*/object', '*/module', '*/relation', '*/handle' ];

// --
// declare
// --

let Extension =
{

  isJunction,

  ModuleVariant,

}

_.mapExtend( Self, Extension );

})();
