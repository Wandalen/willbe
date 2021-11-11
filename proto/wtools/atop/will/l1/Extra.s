( function _Extra_s_()
{

'use strict';

const _ = _global_.wTools;
_.will = _.will || Object.create( null );

// --
// implementation
// --

function isJunction( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  if( !object )
  return false;
  // if( object instanceof _.will.ModuleJunction )
  if( object instanceof _.will.AbstractJunction )
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

/* _.props.extend */Object.assign( _.will, Extension );

})();
