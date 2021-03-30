( function _BuildFrame_s_()
{

'use strict';

// if( typeof module !== 'undefined' )
// {
//
//   require( '../IncludeBase.s' );
//
// }

//

const _ = _global_.wTools;
const Parent = null;
const Self = wWillBuildFrame;
function wWillBuildFrame( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'BuildFrame';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  /* already freezed, so calling _.Copyable.prototype.finit is redundant */
  // return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let frame = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( frame );
  Object.preventExtensions( frame );

  if( o )
  frame.copy( o );

  _.assert( frame.run instanceof _.will.BuildRun );

}

//

function unform()
{
  let frame = this;
  let run = frame.run;
  let module = run.module;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( frame.formed );

  return frame;
}

//

function form()
{
  let frame = this;
  let run = frame.run;
  let module = run.module;
  let resource = frame.resource;
  let down = frame.down;
  let will = module.will;
  let fileProvider = will.fileProvider;
  const path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !frame.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( module.preformed > 0  );
  _.assert( !!resource );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( down === null || down instanceof Self );
  _.assert( run instanceof _.will.BuildRun );
  _.assert( module.preformed >= 1 );

  /* */

  frame.formed = 1;
  Object.freeze( frame );
  return frame;
}

//

function frameUp( resource2 )
{
  let frame = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let logger = will.logger;
  let resource = frame.resource;

  _.assert( arguments.length === 1 );
  _.assert( frame.formed === 1 );

  let frame2 = frame.cloneExtending
  ({
    resource : resource2,
    down : frame,
  });

  _.assert( frame2.resource === resource2 );

  frame2.form();

  return frame2;
}

//

function closesBuildGet()
{
  let frame = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let logger = will.logger;
  let resource = frame.resource;

  if( frame.resource instanceof _.will.Build )
  return frame.resource;

  _.assert( frame.down && frame.down !== frame );

  return frame.down.closesBuildGet();
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
  down : null,
  resource : null,
  run : null,
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
  root : 'root',
  context : 'context',
  exported : 'exported',
  opts : 'opts',
  build : 'build',
  module : 'module',
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
  closesBuildGet,

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
