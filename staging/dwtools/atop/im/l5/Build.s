( function _Build_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillBuild( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Build';

// --
// inter
// --

function _inheritFrom( o )
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.strIs( o.buildName ) );
  _.assert( arguments.length === 1 );
  _.assert( build.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let build2 = module.buildMap[ o.buildName ];
  _.sure( _.objectIs( build2 ), () => 'Build ' + _.strQuote( o.buildName ) + ' does not exist' );
  _.assert( !!build2.formed );

  if( build2.formed !== 2 )
  {
    _.sure( !_.arrayHas( o.visited, build2.name ), () => 'Cyclic dependency build ' + _.strQuote( build.name ) + ' of ' + _.strQuote( build2.name ) );
    build2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( build2, _.mapNulls( build ) );
  delete extend.settings;
  build.copy( extend );

  if( build2.settings )
  build.settings = _.mapSupplement( build.settings || null, build2.settings );

}

_inheritFrom.defaults=
{
  buildName : null,
  visited : null,
}

//

function form3()
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( build.formed === 2 );

  /* begin */

  build.stepsEach( function( it )
  {
    if( it.concurrent )
    return;
    let kind = it.element.constructor.shortName;
    if( it.element instanceof will.Step )
    {
      _.sure( _.routineIs( it.element.stepRoutine ), kind, it.element.name, 'does not have step routine' );
      _.sure( it.element.formed === 2, kind, it.element.name, 'was not formed' );
    }
    else if( it.element instanceof will.Build )
    {
      _.sure( it.element.formed >= 2, kind, it.element.name, 'was not formed' );
    }
  });

  build.default = build.default ? 1 : 0;

  _.assert( build.default === 0 || build.default === 1 );

  /* end */

  build.formed = 3;
  return build;
}

//

function stepsEach( onEach )
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let will = module.will;

  each( build.steps );

  return build;

  function each( step )
  {
    if( _.arrayIs( step ) )
    inArray( step )
    else if( _.mapIs( step ) )
    inMap( step );
    else
    inElement( step );
  }

  function inElement( step )
  {
    step = module.strResolve( step );
    _.assert( step instanceof will.Step || step instanceof will.Build );
    let it = Object.create( null );
    it.element = step;
    onEach( it );
  }

  function inArray( steps )
  {
    _.assert( _.arrayIs( steps ) );
    for( let s = 0 ; s < steps.length ; s++ )
    {
      let step = steps[ s ];
      each( step );
    }
  }

  function inMap( steps )
  {
    _.assert( _.mapIs( steps ) );
    _.assertMapHasOnly( steps, { concurrent : null } );
    onEach({ concurrent : steps.concurrent });
    inArray( steps.concurrent );
  }

}

// --
// relations
// --

let Composes =
{

  description : null,
  default : null,
  settings : null,
  steps : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  MapName : 'buildMap',
}

let Forbids =
{
}

let Accessors =
{
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  _inheritFrom : _inheritFrom,

  form3 : form3,

  stepsEach : stepsEach,

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
