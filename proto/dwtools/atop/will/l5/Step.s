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
  let inf = step.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( step.formed === 2 );
  _.sure( !!step.shell ^ !!step.js ^ _.routineIs( step.stepRoutine ), 'Step should have only {-shell-} or {-js-} or {-stepRoutine-} fields' );
  _.sure( step.shell === null || _.strIs( step.shell ) || _.arrayIs( step.shell ) );
  _.sure( step.js === null || _.strIs( step.js ) );

  /* begin */

  if( step.currentPath )
  step.currentPath = step.inPathResolve( step.currentPath );

  if( !step.stepRoutine )
  {

    if( step.shell )
    step.stepRoutine = function()
    {
      let shell = step.shell;
      if( _.arrayIs( shell ) )
      shell = shell.join( '\n' );
      return _.shell
      ({
        path : shell,
        currentPath : step.currentPath,
      }).doThen( ( err, arg ) =>
      {
        if( err )
        throw _.errBriefly( err );
        return arg;
      });
    }
    else if( step.js )
    {
      try
      {
        // debugger;
        if( _.strBegins( step.js, '.' ) )
        step.js = fileProvider.providersWithProtocolMap.hd.path.nativize( step.inPathResolve( step.js ) );
        step.stepRoutine = require( step.js );
        if( !_.routineIs( step.stepRoutine ) )
        throw _.err( 'JS file should return function, but got', _.strTypeOf( step.stepRoutine ) );
      }
      catch( err )
      {
        debugger;
        throw _.err( 'Failed to open JS file', _.strQuote( step.js ), '\n', err );
      }
    }

  }

  /* end */

  _.assert( _.routineIs( step.stepRoutine ), () => step.nickName + ' does not have stepRoutine' );

  step.formed = 3;
  return step;
}

// --
// relations
// --

let Composes =
{

  description : null,
  criterion : null,
  opts : null,
  shell : null,
  currentPath : null,
  js : null,
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
