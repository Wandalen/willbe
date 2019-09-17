( function _Step_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillStep( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Step';

// --
// inter
// --

function init( o )
{
  let step = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  Parent.prototype.init.call( step );

  if( o )
  {
    if( _.mapIs( o ) )
    {
      o.opts = _.mapBut( o, step.constructor.FieldsOfInputGroups );
      _.mapDelete( o, o.opts );
    }
    if( o )
    step.copy( o );
  }

}

//

function form2()
{
  let step = this;
  let module = step.module;

  if( step.formed >= 2 )
  return step;

  _.assert( arguments.length === 0 );
  _.assert( step.formed === 1 );
  _.assert( _.objectIs( step.opts ) || step.opts === null );

  if( step.stepRoutine )
  {
    _.mapSupplement( step.opts, step.stepRoutine.stepOptions );
  }

  /* */

  if( step.inherit.length === 0 && step.opts )
  if( !step.criterion || !step.criterion.predefined )
  {

    for( let s in module.stepMap )
    {
      let step2 = module.stepMap[ s ];

      if( !step2.criterion || !step2.criterion.predefined )
      continue;
      // if( step2.formed < 2 )
      // continue;
      if( step2.uniqueOptions === null )
      continue;
      if( step === step2 )
      continue;

      step2.form2();

      _.assert( step2.formed >= 2 );
      _.assert( _.objectIs( step2.uniqueOptions ) );

      if( _.mapKeys( _.mapOnly( step.opts, step2.uniqueOptions ) ).length )
      {
        step.inherit.push( step2.name );
      }

      if( step.inherit.length > 1 )
      throw _.err
      (
        'Cant deduce ancestors of', step.qualifiedName, ' to inherit them\n',
        'Several steps have such unique options', _.mapKeys( _.mapOnly( step.opts, step2.uniqueOptions ) )
      );

    }

  }

  /* */

  return Parent.prototype.form2.call( step );
}

//

function form3()
{
  let step = this;
  let module = step.module;
  let willf = step.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( step.formed >= 3 )
  return step;

  _.assert( arguments.length === 0 );
  _.assert( step.formed === 2 );
  _.assert( _.routineIs( step.stepRoutine ), () => step.qualifiedName + ' does not have {- stepRoutine -}. Failed to deduce it, try specifying "inherit" field explicitly' );
  _.assert( step.stepRoutine.stepOptions !== undefined, () => 'Field {- stepRoutine -} of ' + step.qualifiedName + ' deos not have defined {- stepOptions -}' );

  if( step.opts && step.stepRoutine.stepOptions )
  {
    _.sureMapHasOnly( step.opts, step.stepRoutine.stepOptions, () => step.qualifiedName + ' should not have options' );
  }

  step.formed = 3;
  return step;
}

//

function framePerform( frame )
{
  let step = this;
  let run = frame.run;
  let resource = frame.resource;
  let module = run.module;
  // let resource = frame.resource;
  let build = run.build;
  // let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hub = will.fileProvider;

  let result = _.Consequence.Try( () =>
  {

    _.assert( arguments.length === 1 );
    _.assert( !!module );
    _.assert( !!will );
    _.assert( !!logger );
    _.assert( module.preformed > 0  );
    _.assert( will.formed === 1 );
    _.assert( build.formed === 3 );
    _.assert( step.formed === 3 );
    _.assert( resource.formed === 3 );
    _.assert( resource === step );
    // _.assert( _.mapIs( run.opts ) );
    _.assert( _.routineIs( step.stepRoutine ), () => step.qualifiedName + ' does not have step routine' );

    // frame.opts = _.mapExtend( null, run.opts, step.opts );
    // if( step.opts && step.stepRoutine.stepOptions )
    // _.routineOptions( step.stepRoutine, frame.opts );
    // _.routineOptions( step.stepRoutine, run.opts, step.stepRoutine.stepOptions );

    let result = step.stepRoutine( frame );

    _.assert( result !== undefined, 'Step should return something' );

    return result;
  })
  .catch( ( err ) =>
  {
    debugger;
    throw _.err( err, '\nFailed', step.decoratedAbsoluteName );
  });

  return result;
}

// --
// etc
// --

function verbosityWithDelta( delta )
{
  let step = this;
  let will = step.module.will;
  let verbosity = step.verbosity !== null ? step.verbosity : ( will.verbosity + delta );

  if( will.verbosity < -delta )
  verbosity = 0;
  if( verbosity > 0 )
  if( will.verbosity <= -delta )
  verbosity = 1;
  if( will.verbosity >= 9 )
  verbosity = 9;

  if( verbosity < 0 )
  verbosity = 0;
  if( verbosity > 9 )
  verbosity = 9;

  return verbosity;
}

//

function uniqueOptionsGet()
{
  let step = this;

  if( !step.stepRoutine )
  return null;

  return step.stepRoutine.uniqueOptions || null;
}

// --
// relations
// --

let Composes =
{
  opts : null,
  verbosity : null,
}

let Aggregates =
{
  name : null,
  stepRoutine : null,
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
  KindName : 'step',
}

let Forbids =
{
  shell : 'shell',
  currentPath : 'currentPath',
  filePath : 'filePath',
  js : 'js',
}

let Accessors =
{
  uniqueOptions : { getter : uniqueOptionsGet, readOnly : 1 },
}

// --
// declare
// --

let Extend =
{

  // inter

  init,
  form2,
  form3,
  framePerform,

  // etc

  verbosityWithDelta,
  uniqueOptionsGet,

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
  extend : Extend,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
