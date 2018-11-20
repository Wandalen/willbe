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

  let logger = will.logger = new _.Logger({ output : _global_.logger, name : 'will' });

  // debugger;

  _.instanceInit( will );
  Object.preventExtensions( will );

  _.assert( logger === will.logger );

  // debugger;

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

  if( will.formed >= 1 )
  return will;

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
  _.assert( !!logger );

  // if( !will.logger )
  // logger = will.logger = new _.Logger({ output : _global_.logger, name : 'will' });
  // debugger;

  // logger.log( 'experiment1' );

  // logger.verbosity = will.verbosity;

  _.assert( logger.verbosity === will.verbosity );

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

  let logger2 = new _.Logger({ output : logger, name : 'will.providers' });

  // debugger;
  // will.fileProvider.logger = _.Logger({ output : will.logger });
  will.fileProvider.logger = logger2;
  for( var f in will.fileProvider.providersWithProtocolMap )
  {
    let fileProvider = will.fileProvider.providersWithProtocolMap[ f ];
    fileProvider.logger = logger2;
  }

  // logger.log( 'experiment2' );

  // _.assert( will.fileProvider.logger === will.logger );
  _.assert( will.fileProvider.logger === logger2 );
  _.assert( logger.verbosity === will.verbosity );
  _.assert( will.fileProvider.logger !== will.logger );

  // debugger;
  will._verbosityChange();
  // debugger;
  _.assert( logger2.verbosity <= logger.verbosity );
}

//

function _verbosityChange()
{
  let will = this;

  _.assert( arguments.length === 0 );
  _.assert( !will.fileProvider || will.fileProvider.logger !== will.logger );

  // debugger;

  if( will.fileProvider )
  will.fileProvider.verbosity = will.verbosity-2;

}

//

function willFilesList( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( _.strIs( o ) )
  o = { dirPath : o }

  _.assert( arguments.length === 1 );
  _.routineOptions( willFilesList, o );
  _.assert( !!will.formed );

  let filter = { maskTerminal : { includeAny : /\.will(\.|$)/, excludeAny : [], includeAll : [] } };

  if( !o.includingInFiles )
  filter.maskTerminal.includeAll.push( /\.out(\.|$)/ )
  if( !o.includingOutFiles )
  filter.maskTerminal.excludeAny.push( /\.out(\.|$)/ )

  // debugger;
  let files = fileProvider.filesFind
  ({
    filePath : o.dirPath,
    recursive : o.recursive,
    filter : filter,
  });
  // debugger;

  return files;
}

willFilesList.defaults =
{
  dirPath : null,
  includingInFiles : 1,
  includingOutFiles : 0,
  rerucrsive : 0,
}

// --
// relations
// --

var ResourceKindToClassName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource class name' }).set
({

  'submodule' : 'Submodule',
  'step' : 'Step',
  'path' : 'PathObj',
  'reflector' : 'Reflector',
  'build' : 'Build',
  'about' : 'About',
  'execution' : 'Execution',
  'exported' : 'Exported',

});

var ResourceKindToMapName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource map name' }).set
({

  'submodule' : 'submoduleMap',
  'step' : 'stepMap',
  'path' : 'pathObjMap',
  'reflector' : 'reflectorMap',
  'build' : 'buildMap',
  'exported' : 'exportedMap',

});

let ResourceKinds = [ 'submodule', 'step', 'path', 'reflector', 'build', 'about', 'execution', 'exported' ];

let Composes =
{
  verbosity : 3,
  verboseStaging : 0,
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
  ResourceKindToClassName : ResourceKindToClassName,
  ResourceKindToMapName : ResourceKindToMapName,
  ResourceKinds : ResourceKinds,
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

  _verbosityChange : _verbosityChange,

  willFilesList : willFilesList,

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
