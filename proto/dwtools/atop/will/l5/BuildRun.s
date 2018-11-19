( function _BuildFrame_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillBuildFrame( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'BuildFrame';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  // return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let frame = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( frame );
  Object.preventExtensions( frame );

  if( o )
  frame.copy( o );

}

//

function unform()
{
  let frame = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( frame.formed );

  /* begin */

  /* end */

  // frame.formed = 0;
  return frame;
}

//

function form()
{
  let frame = this;
  let module = frame.module;
  let build = frame.build;
  let resource = frame.resource;
  let down = frame.down;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !frame.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( module.formed === 3 );
  _.assert( build instanceof will.Build );
  _.assert( _.arrayIs( build.steps ) );
  _.assert( !!resource );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( down === null || down instanceof Self );
  _.assert( module.formed >= 1 );

  /* begin */

  if( resource instanceof will.Step )
  {

    frame.opts = _.mapExtend( null, resource.opts )
    if( resource.opts && resource.stepRoutine.stepOptions )
    _.routineOptions( resource.stepRoutine, frame.opts, resource.stepRoutine.stepOptions );

  }

  /* end */

  frame.formed = 1;
  Object.freeze( frame );
  return frame;
}

//

function run()
{
  let frame = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let build = frame.build;
  let resource = frame.resource;
  let steps = build.steps;
  let con = new _.Consequence().give( null );

  _.assert( arguments.length === 0 );
  _.assert( frame.formed === 1 );

  con.ifNoErrorThen( () => resource.form() );
  con.ifNoErrorThen( ( arg ) =>
  {
    _.assert( resource.formed === 3 )
    return arg;
  });

  con.ifNoErrorThen( () => resource.run( frame ) );

  return con;
}

//

function cloneUp( resource2 )
{
  let frame = this;
  let module = frame.module;
  let will = module.will;
  let logger = will.logger;
  let build = frame.build;
  let resource = frame.resource;

  _.assert( arguments.length === 1 );
  _.assert( frame.formed === 1 );

  let build2 = resource2 instanceof will.Build ? resource2 : build;
  let frame2 = frame.cloneExtending({ resource : resource2, build : build2, down : frame });

  _.assert( frame2.resource === resource2 );

  frame2.form();

  return frame2;
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
  module : null,
  down : null,
  build : null,
  resource : null,
  opts : null,
  context : null,
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
}

let Accessors =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  finit : finit,
  init : init,
  unform : unform,
  form : form,
  run : run,

  cloneUp : cloneUp,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
