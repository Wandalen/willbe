( function _Build_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wImBuild( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Build';

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
  let build = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( build );
  Object.preventExtensions( build );

  if( o )
  build.copy( o );

}

//

function unform()
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( build.formed );
  _.assert( module.buildMap[ build.name ] === build );
  if( inf )
  _.assert( inf.buildMap[ build.name ] === build );

  /* begin */

  delete module.buildMap[ build.name ];
  if( inf )
  delete inf.buildMap[ build.name ];

  /* end */

  build.formed = 0;
  return build;
}

//

function form1()
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( !build.formed );
  _.assert( !module.buildMap[ build.name ] );
  _.assert( !inf.buildMap[ build.name ] );

  _.assert( !!im );
  _.assert( !!module );
  _.assert( !!inf );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!im.formed );
  _.assert( !!module.formed );
  _.assert( !!inf.formed );
  _.assert( _.strDefined( build.name ) );

  /* begin */

  module.buildMap[ build.name ] = build;
  inf.buildMap[ build.name ] = build;

  /* end */

  build.formed = 1;
  return build;
}

//

function inheritForm()
{
  let build = this;
  _.assert( arguments.length === 0 );
  _.assert( build.formed === 1 );

  /* begin */

  build._inheritForm({ visited : [] })

  /* end */

  build.formed = 2;
  return build;
}

//

function _inheritForm( o )
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 1 );
  _.assert( build.formed === 1 );
  // _.assert( !build._.assert( step.formed === 1 ); );
  _.assert( _.arrayIs( build.inherit ) );
  _.assertRoutineOptions( _inheritForm, arguments );

  /* begin */

  _.arrayAppendOnceStrictly( o.visited, build.name );

  build.inherit.map( ( buildName ) =>
  {
    build._inheritFrom({ visited : o.visited, buildName : buildName });
  });

  /* end */

  build.formed = 2;
  return build;
}

_inheritForm.defaults=
{
  visited : null,
}

//

function _inheritFrom( o )
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

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
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( build.formed === 2 );

  /* begin */

  build.stepsEach( function( it )
  {
    if( it.concurrent )
    return;
    let kind = it.element.constructor.shortName;
    if( it.element instanceof im.Step )
    {
      _.sure( _.routineIs( it.element.stepRoutine ), kind, it.element.name, 'does not have step routine' );
      _.sure( it.element.formed === 2, kind, it.element.name, 'was not formed' );
    }
    else if( it.element instanceof im.Build )
    {
      _.sure( it.element.formed >= 2, kind, it.element.name, 'was not formed' );
    }
  });

  /* end */

  build.formed = 3;
  return build;
}

//
//
// function runForm( o )
// {
//   let build = this;
//   let module = build.module;
//   let inf = build.inf;
//   let im = module.im;
//
//   _.assert( arguments.length === 0 || arguments.length === 1 );
//
//   o = o || Object.create( null );
//   o.module = module;
//
//   let run = im.BuildRun( o ).form();
//
//   return run;
// }

//

function stepsEach( onEach )
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let im = module.im;

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
    _.assert( step instanceof im.Step || step instanceof im.Build );
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

//

function info()
{
  let build = this;
  let result = '';
  let fields = _.mapOnly( build, { description : null, default : null, settings : null, /*compose : null,*/ steps : null } );
  fields = _.mapButNulls( fields );

  result += 'Build ' + build.name + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';

  return result;
}

// --
// relations
// --

let Composes =
{

  name : null,
  description : null,

  default : null,
  settings : null,
  steps : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
}

let Associates =
{
  module : null,
  inf : null,
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
  inherited : 'inherited',
  compose : 'compose',
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

  finit : finit,
  init : init,

  unform : unform,
  form1 : form1,
  inheritForm : inheritForm,
  _inheritForm : _inheritForm,
  _inheritFrom : _inheritFrom,
  form3 : form3,

  stepsEach : stepsEach,

  info : info,

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

/*_.Im[ Self.shortName ] = Self;*/
_.staticDecalre
({
  prototype : _.Im.prototype,
  name : Self.shortName,
  value : Self,
});

})();
