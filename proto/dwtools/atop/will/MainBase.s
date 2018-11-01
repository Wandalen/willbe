( function _MainBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWill( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Will';

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
  let will = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( will );
  Object.preventExtensions( will );

  if( o )
  will.copy( o );

}

//

function unform()
{
  let will = this;

  _.assert( arguments.length === 0 );
  _.assert( !!will.formed );

  /* begin */

  /* end */

  will.formed = 0;
  return will;
}

//

function form()
{
  let will = this;

  will.formAssociates();

  _.assert( arguments.length === 0 );
  _.assert( !will.formed );

  /* begin */

  /* end */

  will.formed = 1;
  return will;
}

//

function formAssociates()
{
  let will = this;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !will.formed );

  if( !will.logger )
  logger = will.logger = new _.Logger({ output : _global_.logger });

  // if( !will.fileProvider )
  // will.fileProvider = _.FileProvider.Default();

  if( !will.fileProvider )
  {

    will.fileProvider = _.FileProvider.Hub({ providers : [] });

    _.FileProvider.Git().providerRegisterTo( will.fileProvider );
    _.FileProvider.Npm().providerRegisterTo( will.fileProvider );

    let defaultProvider = _.FileProvider.Default();
    defaultProvider.providerRegisterTo( will.fileProvider );
    will.fileProvider.defaultProvider = defaultProvider;

  }

  if( !will.filesGraph )
  will.filesGraph = _.FilesGraph({ fileProvider : will.fileProvider });

}

// --
// relations
// --

let Composes =
{
  verbosity : 3,
}

let Aggregates =
{
}

let Associates =
{

  fileProvider : null,
  filesGraph : null,
  logger : null,

  moduleArray : _.define.own([]),
  moduleMap : _.define.own({}),

}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  FormatVersion : '1.0.0',
}

let Forbids =
{
}

// --
// declare
// --

let Extend =
{

  // inter

  finit : finit,
  init : init,
  unform : unform,
  form : form,
  formAssociates : formAssociates,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_global_[ Self.name ] = wTools[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
{

  require( './IncludeTop.s' );

}

})();
