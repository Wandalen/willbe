( function _MainBase_s_( ) {

'use strict';

/**
 * Aggregator of strategies to transpile JS code. It provides unified programmatic and CL interfaces to transpile/optimize/minimize/beautify code by one or several transpilers in series. More strategies could be added as plugins. Default options of transpilation can be written into a config file to avoid retyping. Use the module to utilize the power of open source transpilation tools in single package.
  @module Tools/mid/TranspilationStrategy
*/

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wTranspilationStrategy( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'TranspilationStrategy';

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
  let sys = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !sys.logger )
  sys.logger = new _.Logger({ output : _global_.logger });

  _.workpiece.initFields( sys );
  Object.preventExtensions( sys );

  if( o )
  sys.copy( o );

}

//

function unform()
{
  let sys = this;

  _.assert( arguments.length === 0 );
  _.assert( !!sys.formed );

  /* begin */

  /* end */

  sys.formed = 0;
  return sys;
}

//

function form()
{
  let sys = this;

  sys.formAssociates();

  _.assert( arguments.length === 0 );
  _.assert( !sys.formed );

  /* begin */

  /* end */

  sys.formed = 1;
  return sys;
}

//

function formAssociates()
{
  let sys = this;
  let logger = sys.logger;

  _.assert( arguments.length === 0 );
  _.assert( !sys.formed );

  if( !sys.logger )
  logger = sys.logger = new _.Logger({ output : _global_.logger });

  if( !sys.fileProvider )
  sys.fileProvider = _.FileProvider.Default();

  sys.concatenators = [];
  sys.extToConcatenatorMap = Object.create( null );

  for( let c in sys.Concatenator )
  {
    if( c === 'Abstract' )
    continue;
    new sys.Concatenator[ c ]({ sys : sys }).form();
  }

  return sys;
}

//

function multiple( o )
{
  let sys = this;
  o = o || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  o.sys = sys;

  return sys.Multiple( o );
}

// --
// relations
// --

let Composes =
{
  verbosity : 3,
}

let Aggregates =
{
}

let Associates =
{

  fileProvider : null,
  logger : null,

}

let Restricts =
{
  formed : 0,
  extToConcatenatorMap : null,
  concatenators : null,
}

let Statics =
{
  Transpiler : Object.create( null ),
  Concatenator : Object.create( null ),
  // ExtToConcatenatorMap : Object.create( null ), xxx
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,
  unform,
  form,
  formAssociates,

  multiple,

  // ident

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_global_[ Self.name ] = wTools[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
require( './IncludeMid.s' );

})();
