( function _Step_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wImStep( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Step';

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
  let step = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( step );
  Object.preventExtensions( step );

  if( o )
  step.copy( o );

}

//

function unform()
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( step.formed );
  _.assert( module.stepMap[ step.name ] === step );
  _.assert( !inf || inf.stepMap[ step.name ] === step );

  /* begin */

  delete module.stepMap[ step.name ];
  if( inf )
  delete inf.stepMap[ step.name ];

  /* end */

  step.formed = 0;
  return step;
}

//

function form1()
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( !step.formed );
  _.assert( !module.stepMap[ step.name ] );
  _.assert( !inf || !inf.stepMap[ step.name ] );

  _.assert( !!im );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!im.formed );
  _.assert( !inf || !!inf.formed );
  _.assert( _.strDefined( step.name ) );

  /* begin */

  module.stepMap[ step.name ] = step;
  if( inf )
  inf.stepMap[ step.name ] = step;

  /* end */

  step.formed = 1;
  return step;
}

//

function inheritForm()
{
  let step = this;
  _.assert( arguments.length === 0 );
  _.assert( step.formed === 1 );

  /* begin */

  step._inheritForm({ visited : [] })

  /* end */

  step.formed = 2;
  return step;
}

//

function _inheritForm( o )
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 1 );
  _.assert( step.formed === 1 );
  _.assert( _.arrayIs( step.inherit ) );
  _.assertRoutineOptions( _inheritForm, arguments );

  /* begin */

  _.arrayAppendOnceStrictly( o.visited, step.name );

  step.inherit.map( ( stepName ) =>
  {
    step._inheritFrom({ visited : o.visited, stepName : stepName });
  });

  if( step.filePath && !step.stepRoutine )
  step.stepRoutine = function()
  {
    _.assert( 0, 'not implemented' );
  }

  /* end */

  return step;
}

_inheritForm.defaults=
{
  visited : null,
}

//

function _inheritFrom( o )
{
  let step = this;
  let module = step.module;
  let inf = step.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( _.strIs( o.stepName ) );
  _.assert( arguments.length === 1 );
  _.assert( step.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let step2 = module.stepMap[ o.stepName ];
  _.sure( _.objectIs( step2 ), () => 'Step ' + _.strQuote( o.stepName ) + ' does not exist' );
  _.assert( !!step2.formed );

  if( step2.formed !== 2 )
  {
    _.sure( !_.arrayHas( o.visited, step2.name ), () => 'Cyclic dependency step ' + _.strQuote( step.name ) + ' of ' + _.strQuote( step2.name ) );
    step2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( step2, _.mapNulls( step ) );
  step.copy( extend );

  if( step2.settings )
  step.settings = _.mapSupplement( step.settings, step2.settings );

}

_inheritFrom.defaults=
{
  stepName : null,
  visited : null,
}

//

function info()
{
  let step = this;
  let result = '';
  let fields = _.mapOnly( step, { name : null, inherit : null, filePath : null, settings : null } );
  fields = _.mapButNulls( fields );

  result += 'Step ' + step.name + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 2, multiline : 1 } ) + '\n';

  return result;
}

//

function StepRoutineGrab( run )
{
  let step = this;
  // let build = run.build;
  let module = run.module;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( _.objectIs( step.settings ) );
  _.assert( arguments.length === 1 );

  let settings = _.mapExtend( null, step.settings );
  settings.reflector = module.strResolve( settings.reflector );

  settings.reflector = settings.reflector.forReflect();
  _.mapSupplement( settings, settings.reflector )
  delete settings.reflector;

  if( im.verbosity >= 2 && im.verbosity <= 3 )
  {
    logger.log( 'filesReflect' );
    logger.log( _.toStr( settings.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  debugger;
  let result = fileProvider.filesReflect( settings );
  debugger;

  return result;
}

// --
// relations
// --

let Composes =
{

  name : null,
  description : null,

  inherit : _.define.own([]),
  settings : null,
  filePath : null,
  stepRoutine : null,

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
  StepRoutineGrab : StepRoutineGrab,
}

let Forbids =
{
  inherited : 'inherited',
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
