( function _BuildRun_s_()
{

'use strict';

const _ = _global_.wTools;
const Parent = null;
const Self = wWillBuildRun;
function wWillBuildRun( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'BuildRun';

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
  let run = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( run );
  Object.preventExtensions( run );

  if( o )
  run.copy( o );

}

//

function unform()
{
  let run = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( run.formed > 0 );

  return run;
}

//

function form()
{
  let run = this;

  if( !run.module && run.build )
  run.module = run.build.module;
  if( !run.will && run.module )
  run.will = run.module.will;

  let module = run.module;
  let build = run.build;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !run.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( module.preformed > 0 );
  _.assert( build instanceof _.will.Build );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( module.preformed >= 1 );
  _.assert( !!run.module );
  _.assert( !!run.will );

  run.formed = 1;
  return run;
}

//

function frameUp( resource2 )
{
  let run = this;
  let module = run.module;
  let will = module.will;

  _.assert( arguments.length === 1 );
  _.assert( run.formed === 1 );

  let frame2 = new _.will.BuildFrame
  ({
    resource : resource2,
    down : null,
    run,
  });

  _.assert( frame2.resource === resource2 );

  frame2.form();

  return frame2;
}

// --
// relations
// --

let Composes =
{
  recursive : 0,
  withIntegrated : 2,
  isRoot : null,
  purging : null,
}

let Aggregates =
{
}

let Associates =
{
  exported : _.define.own([]),
  build : null,
  module : null,
  will : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
}

let Forbids =
{
  down : 'down',
  root : 'root',
  resource : 'resource',
  context : 'context',
  opts : 'opts',
}

let Accessors =
{
}

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

  frameUp,

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
_.will[ Self.shortName ] = Self;

})();
