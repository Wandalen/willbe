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

function form2()
{
  let step = this;
  let module = step.module;

  if( step.formed >= 2 )
  return step;

  _.assert( arguments.length === 0 );
  _.assert( step.formed === 1 );
  _.assert( _.objectIs( step.opts ) || step.opts === null );

  /* */

  // step.opts = step.opts || Object.create( null );
  // if( step.name === 'custom.js' )
  // debugger;

  if( step.inherit.length === 0 && step.opts )
  for( let s in module.stepMap )
  {
    let step2 = module.stepMap[ s ];

    if( !step2.criterion || !step2.criterion.predefined )
    continue;
    if( step2.formed < 2 )
    continue;
    if( step2.uniqueOptions === null )
    continue;

    _.assert( _.objectIs( step2.uniqueOptions ) );

    if( _.mapKeys( _.mapOnly( step.opts, step2.uniqueOptions ) ).length )
    {
      step.inherit.push( step2.name );
    }

    if( step.inherit.length > 1 )
    throw _.err
    (
      'Cant deduce inherit of', step.nickName, '\n',
      'Because several steps have unique options', _.mapKeys( _.mapOnly( step.opts, step2.uniqueOptions ) )
    );

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

  // _.sure( !!step.shell ^ !!step.js ^ _.routineIs( step.stepRoutine ), 'Step should have only {-shell-} or {-js-} or {-stepRoutine-} fields' );
  // _.sure( step.shell === null || _.strIs( step.shell ) || _.arrayIs( step.shell ) );
  // _.sure( step.js === null || _.strIs( step.js ) );

  /* begin */

  // if( step.opts.reflector )
  // {
  //   let reflectors = module.resolve
  //   ({
  //     query :  step.opts.reflector,
  //     defaultPool : 'reflector',
  //     current : step,
  //     unwrappingSingle : 0,
  //   });
  //   _.assert( _.arrayIs( reflectors ) );
  //   for( let r = 0 ; r < reflectors.length ; r++ )
  //   reflectors[ r ].form();
  // }

  // if( step.currentPath )
  // step.currentPath = step.inPathResolve( step.currentPath );
  //
  // if( !step.stepRoutine )
  // {
  //
  //   if( step.shell )
  //   step.stepRoutine = function()
  //   {
  //     let shell = step.shell;
  //     if( _.arrayIs( shell ) )
  //     shell = shell.join( '\n' );
  //     return _.shell
  //     ({
  //       path : shell,
  //       currentPath : step.currentPath,
  //     }).finally( ( err, arg ) =>
  //     {
  //       if( err )
  //       throw _.errBriefly( err );
  //       return arg;
  //     });
  //   }
  //   else if( step.js )
  //   {
  //     try
  //     {
  //       // debugger;
  //       if( _.strBegins( step.js, '.' ) )
  //       step.js = fileProvider.providersWithProtocolMap.hd.path.nativize( step.inPathResolve( step.js ) );
  //       step.stepRoutine = require( step.js );
  //       if( !_.routineIs( step.stepRoutine ) )
  //       throw _.err( 'JS file should return function, but got', _.strType( step.stepRoutine ) );
  //     }
  //     catch( err )
  //     {
  //       debugger;
  //       throw _.err( 'Failed to open JS file', _.strQuote( step.js ), '\n', err );
  //     }
  //   }
  //
  // }

  // stepRoutineExport.stepOptions

  _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have {- stepRoutine -}. Failed to deduce it, try specifying "inherit" field explicitly' );
  _.assert( step.stepRoutine.stepOptions !== undefined, () => 'Field {- stepRoutine -} of ' + step.nickName + ' deos not have defined {- stepOptions -}' );

  if( step.opts && step.stepRoutine.stepOptions )
  {
    _.sureMapHasOnly( step.opts, step.stepRoutine.stepOptions, () => step.nickName + ' should not have options' );
  }

  /* end */

  _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have stepRoutine' );

  step.formed = 3;
  return step;
}

//

function run( frame )
{
  let step = this;
  let resource = frame.resource;
  let build = frame.build;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hub = will.fileProvider;
  let result;

  try
  {

    _.assert( arguments.length === 1 );
    _.assert( !!module );
    _.assert( !!will );
    _.assert( !!logger );
    _.assert( module.formed === 3 );
    _.assert( will.formed === 1 );
    _.assert( build.formed === 3 );
    _.assert( step.formed === 3 );
    _.assert( resource === step );
    _.assert( _.objectIs( frame.opts ) );
    _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have step routine' );

    // debugger;
    _.mapExtend( frame.opts, step.opts );
    if( step.opts && step.stepRoutine.stepOptions )
    _.routineOptions( step.stepRoutine, frame.opts, step.stepRoutine.stepOptions );

    result = step.stepRoutine( frame );

    _.assert( result !== undefined, 'Step should return something' );
  }
  catch( err )
  {
    throw _.err( 'Failed', step.nickName, 'of', build.nickName, '\n', err );
  }

  return result;
}

// --
// accessor
// --

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

  description : null,
  criterion : null,
  opts : null,

  // shell : null,
  // currentPath : null,
  // filePath : null,
  // js : null,

  inherit : _.define.own([]),

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
  PoolName : 'step',
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

let Proto =
{

  // inter

  init,
  form2,
  form3,
  run,

  // accessor

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
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
