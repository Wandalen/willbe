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
  //   let reflectors = module.strResolve
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
  //     }).doThen( ( err, arg ) =>
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
  //       throw _.err( 'JS file should return function, but got', _.strTypeOf( step.stepRoutine ) );
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

  _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have {- stepRoutine -}' );
  _.assert( step.stepRoutine.stepOptions !== undefined, () => 'Field {- stepRoutine -} of ' + step.nickName + ' deos not have defined {- stepOptions -}' );

  if( step.opts && step.stepRoutine.stepOptions )
  {
    _.sureMapHasOnly( step.opts, step.stepRoutine.stepOptions, () => step.nickName + ' should not have options' );
    // _.mapComplement( step.opts );
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
    _.assert( resource.formed === 3 );
    _.assert( resource === step );
    _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have step routine' );

    result = step.stepRoutine( frame );

    _.assert( result !== undefined, 'Step should return something' );
  }
  catch( err )
  {
    throw _.err( 'Failed', step.nickName, 'of', build.nickName, '\n', err );
  }

  return result;
}

// //
//
// function formAndRun( run )
// {
//   let step = this;
//
//   // debugger;
//   let c = step.form();
//   // debugger;
//
//   return _.Consequence.From( c ).doThen( () =>
//   {
//     _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have step routine' );
//     return step.stepRoutine( run );
//   });
// }

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
}

// --
// declare
// --

let Proto =
{

  // inter

  init : init,
  form3 : form3,

  run : run,
  // formAndRun : formAndRun,

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
