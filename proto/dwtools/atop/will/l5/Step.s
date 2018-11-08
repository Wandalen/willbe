( function _Step_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillStep( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Step';

// --
// inter
// --

function init( o )
{
  let step = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( step );
  Object.preventExtensions( step );

  if( o )
  {
    o.opts = _.mapBut( o, step.constructor.fieldsOfCopyableGroups );
    _.mapDelete( o, o.opts );
    if( o )
    step.copy( o );
  }

}

//

function _inheritSingle( o )
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.strIs( o.ancestorName ) );
  _.assert( arguments.length === 1 );
  _.assert( step.formed >= 1 ); /* xxx */
  _.assertRoutineOptions( _inheritSingle, arguments );

  let step2 = module.stepMap[ o.ancestorName ];
  _.sure( _.objectIs( step2 ), () => 'Step ' + _.strQuote( o.ancestorName ) + ' does not exist' );
  _.assert( !!step2.formed );

  if( step2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, step2.name ), () => 'Cyclic dependency step ' + _.strQuote( step.name ) + ' of ' + _.strQuote( step2.name ) );
    step2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( step2, _.mapNulls( step ) );
  step.copy( extend );

  if( step2.criterion )
  step.criterion = _.mapSupplement( step.criterion, step2.criterion );

}

_inheritSingle.defaults=
{
  ancestorName : null,
  visited : null,
}

//

function form3()
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( step.formed === 2 );

  /* begin */

  if( step.filePath && !step.stepRoutine )
  step.stepRoutine = function()
  {
    _.assert( 0, 'not implemented' );
  }

  /* end */

  _.assert( _.routineIs( step.stepRoutine ), () => 'Step ' + step.name + ' does not have stepRoutine' );

  step.formed = 3;
  return step;
}

//

function optionsExport()
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  let result = step.dataExprot();
  // let result = _.mapOnly( step, { inherit : null, filePath : null } );

  result.inf = inf;
  result.module = module;
  result.name = step.name;

  // let o2 = _.mapOnly( step, { inherit : null, filePath : null } );
  // o2.criterion = step.criterion;
  // o2.inf = inf;
  // o2.module = module;
  // o2.name = k;

  xxx

  return result;
}

// --
// relations
// --

let Composes =
{

  description : null,
  criterion : null,
  opts : null,
  filePath : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
  stepRoutine : null,
  predefined : 0,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  MapName : 'stepMap',
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

  init : init,
  _inheritSingle : _inheritSingle,
  form3 : form3,

  optionsExport : optionsExport,

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
