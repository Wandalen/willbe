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

function _inheritFrom( o )
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
  _.assert( step.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let step2 = module.stepMap[ o.ancestorName ];
  _.sure( _.objectIs( step2 ), () => 'Step ' + _.strQuote( o.ancestorName ) + ' does not exist' );
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

  step.formed = 3;
  return step;
}

//

let FilesReflect = _.routineForPreAndBody( _.FileProvider.Find.prototype.filesReflect.pre, _.FileProvider.Find.prototype.filesReflect.body );

let defaults = FilesReflect.defaults;

defaults.linking = 'hardlinkMaybe';
defaults.mandatory = 1;
defaults.dstRewritingPreserving = 1;

//

function StepRoutineGrab( run )
{
  let step = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.objectIs( step.settings ) );
  _.assert( arguments.length === 1 );

  let settings = _.mapExtend( null, step.settings );
  settings.reflector = module.strResolve( settings.reflector );

  settings.reflector = settings.reflector.optionsReflectExport();
  _.mapSupplement( settings, settings.reflector )
  delete settings.reflector;

  if( will.verbosity >= 2 && will.verbosity <= 3 )
  {
    logger.log( 'filesReflect' );
    logger.log( _.toStr( settings.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  // settings.srcFilter = settings.srcFilter || Object.create( null );
  // settings.srcFilter.prefixPath = path.join( module.dirPath, settings.srcFilter.prefixPath || '.' );
  // // settings.srcFilter.basePath = path.join( module.dirPath, settings.srcFilter.basePath || '.' );
  //
  // settings.dstFilter = settings.dstFilter || Object.create( null );
  // settings.dstFilter.prefixPath = path.join( module.dirPath, settings.dstFilter.prefixPath || '.' );
  // // settings.dstFilter.basePath = path.join( module.dirPath, settings.dstFilter.basePath || '.' );

  debugger;
  let result = step.FilesReflect.call( fileProvider, settings );
  debugger;

  return result;
}

// --
// relations
// --

let Composes =
{

  description : null,
  settings : null,
  filePath : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
  stepRoutine : null,
  predefined : false,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  FilesReflect : FilesReflect,
  StepRoutineGrab : StepRoutineGrab,
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

  _inheritFrom : _inheritFrom,
  form3 : form3,

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
