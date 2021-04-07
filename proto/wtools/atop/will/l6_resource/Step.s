( function _Step_s_()
{

'use strict';

/**
 * @classdesc Class wWillStep provides interface for forming step resources from willfile.
 * @class wWillStep
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.Resource;
const Self = wWillStep;
function wWillStep( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Step';

// --
// inter
// --

function MakeFor_body( o )
{
  let Cls = this;
  let willf = o.willf;
  let module = o.module;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  let build = o.resource.build;

  let result = Parent.MakeFor.body.apply( Cls, arguments );

  if( !build )
  return result;

  let o3 = Object.create( null );
  o3.resource = Object.create( null );
  o3.resource.criterion = _.mapExtend( null, o.resource.criterion || {} );
  o3.resource.steps = [ `step::${o.name}` ];
  o3.Importing = 1; /* xxx : ? */
  o3.module = module;
  o3.willf = willf;
  o3.name = o.name;

  if( _.strIs( build ) )
  {
    o3.name = build;
  }

  _.will.Build.MakeFor( o3 );

}

_.routineExtend( MakeFor_body, Parent.MakeFor.body );

let MakeFor = _.routine.uniteCloning_( Parent.MakeFor.head, MakeFor_body );

//

function init( o )
{
  let step = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  Parent.prototype.init.call( step );

  if( o )
  {
    if( _.mapIs( o ) )
    {
      let opts2 = _.mapBut_( null, o, step.constructor.FieldsOfInputGroups );
      _.mapDelete( o, opts2 );
      o.opts = _.mapExtend( o.opts || null, opts2 )
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

  _.assert( arguments.length === 0, 'Expects no arguments' );
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
      if( step2.uniqueOptions === null )
      continue;
      if( step === step2 )
      continue;

      step2.form2();

      _.assert( step2.formed >= 2 );
      _.assert( _.objectIs( step2.uniqueOptions ) );

      if( _.mapKeys( _.mapOnly_( null, step.opts, step2.uniqueOptions ) ).length )
      {
        step.inherit.push( step2.name );
      }

      if( step.inherit.length > 1 )
      throw _.err
      (
        'Cant deduce ancestors of', step.qualifiedName, ' to inherit them\n',
        'Several steps have such unique options', _.mapKeys( _.mapOnly_( null, step.opts, step2.uniqueOptions ) )
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

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( step.formed === 2 );
  _.assert( _.routineIs( step.stepRoutine ), () => step.qualifiedName + ' does not have {- stepRoutine -}. Failed to deduce it, try specifying "inherit" field explicitly' );
  _.assert( step.stepRoutine.stepOptions !== undefined, () => 'Field {- stepRoutine -} of ' + step.qualifiedName + ' deos not have defined {- stepOptions -}' );

  _.mapSupplement( step.opts, step.stepRoutine.stepOptions );

  if( step.opts && step.stepRoutine.stepOptions )
  {
    _.map.sureHasOnly( step.opts, step.stepRoutine.stepOptions, () => step.qualifiedName + ' should not have options' );
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
  let build = run.build;
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
    _.assert( _.routineIs( step.stepRoutine ), () => step.qualifiedName + ' does not have step routine' );

    let result = step.stepRoutine( frame );

    _.assert( result !== undefined, 'Step should return something' );

    return result;
  })
  .catch( ( err ) =>
  {
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
  // let verbosity = step.verbosity !== null ? step.verbosity : ( will.verbosity + delta );
  let verbosity = step.verbosity !== null ? step.verbosity : ( will.transaction.verbosity + delta );

  // if( will.verbosity < -delta )
  if( will.transaction.verbosity < -delta )
  verbosity = 0;
  if( verbosity > 0 )
  // if( will.verbosity <= -delta )
  if( will.transaction.verbosity <= -delta )
  verbosity = 1;
  // if( will.verbosity >= 9 )
  if( will.transaction.verbosity >= 9 )
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

let Medials =
{
  build : null,
}

let Statics =
{

  MakeFor,

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
  uniqueOptions : { get : uniqueOptionsGet, writable : 0 },
}

// --
// declare
// --

let Extension =
{

  // inter

  MakeFor,

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
  Medials,
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
