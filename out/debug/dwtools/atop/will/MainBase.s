( function _MainBase_s_( ) {

'use strict';

/**
 * Utility to manage modules of complex modular systems.
  @module Tools/Willbe
*/

/**
 * @file Main.bse.s
 */

/*

= Principles

- Willbe prepends all relative paths by path::in. path::out and path::temp are prepended by path::in as well.
- Willbe prepends path::in by module.dirPath, a directory which has the will-file.
- Major difference between generated out-will-files and manually written will-file is section exported. out-will-files has such section, manually written will-file does not.
- Input files are for manual editing, but the utility can help with it.

*/

/*

= Requested features

- Inherit reflector
- Predefined platform
- Faster loading, perhaps without submodules
- Option args for step shell
- Fix view filePath issue

*/

//

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
  _.assert( logger.verbosity === will.verbosity );

  if( !will.fileProvider )
  {

    let hub = _.FileProvider.Hub({ providers : [] });

    _.FileProvider.Git().providerRegisterTo( hub );
    _.FileProvider.Npm().providerRegisterTo( hub );
    _.FileProvider.Http().providerRegisterTo( hub );

    let defaultProvider = _.FileProvider.Default();
    let image = _.FileFilter.Image({ originalFileProvider : defaultProvider });
    let archive = new _.FilesGraphArchive({ imageFileProvider : image });
    image.providerRegisterTo( hub );
    hub.defaultProvider = image;

    will.fileProvider = hub;

  }

  if( !will.filesGraph )
  will.filesGraph = _.FilesGraphOld({ fileProvider : will.fileProvider });

  let logger2 = new _.Logger({ output : logger, name : 'will.providers' });

  will.fileProvider.logger = logger2;
  for( var f in will.fileProvider.providersWithProtocolMap )
  {
    let fileProvider = will.fileProvider.providersWithProtocolMap[ f ];
    fileProvider.logger = logger2;
  }

  _.assert( will.fileProvider.logger === logger2 );
  _.assert( logger.verbosity === will.verbosity );
  _.assert( will.fileProvider.logger !== will.logger );

  will._verbosityChange();

  _.assert( logger2.verbosity <= logger.verbosity );
}

//

function moduleMake( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  o = _.routineOptions( moduleMake, arguments );

  if( !o.willFilesPath && !o.dirPath )
  o.dirPath = o.dirPath || fileProvider.path.current();

  if( !o.module )
  {
    o.module = will.Module({ will : will, willFilesPath : o.willFilesPath, dirPath : o.dirPath }).preform();
  }

  _.assert( o.module.willFilesPath === o.willFilesPath || o.module.willFilesPath === o.dirPath );
  _.assert( o.module.dirPath === o.dirPath );

  o.module.willFilesFind();
  o.module.willFilesOpen();

  // debugger;
  o.module.submodulesForm();
  // debugger;

  if( o.forming )
  {
    // o.module.submodulesForm();
    o.module.resourcesForm();
  }
  else
  {
    // o.module.submodulesFormSkip();
    o.module.resourcesFormSkip();
  }

  return o.module;
}

moduleMake.defaults =
{
  module : null,
  willFilesPath : null,
  dirPath : null,
  forming : 0,
}

//

function moduleEach( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let con;

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  if( _.strEnds( o.selector, '::' ) )
  o.selector = o.selector + '*';

  if( will.Module.SelectorIs( o.selector ) )
  {

    let module = o.currentModule;
    if( !o.currentModule )
    module = o.currentModule = will.Module({ will : will, dirPath : path.current() }).preform();
    module.willFilesFind();
    module.willFilesOpen();
    module.submodulesForm();
    module.resourcesForm();

    con = module.ready;

    con.then( () =>
    {
      let con2 = new _.Consequence();
      let resolved = module.submodulesResolve({ selector : o.selector, preservingIteration : 1 });
      resolved = _.arrayAs( resolved );
      for( let s = 0 ; s < resolved.length ; s++ ) con2.keep( ( arg ) => /* !!! replace by concurrent, maybe */
      {
        let it1 = resolved[ s ];
        let module = it1.module;

        let it2 = Object.create( null );
        it2.module = module;
        it2.supermodule = module.supermodule || module;

        if( _.arrayIs( it1.dst ) || _.strIs( it1.dst ) )
        it2.currentPath = it1.dst;

        // it.module = submodule.loadedModule;
        // it.supermodule = module;
        // it.submodule = submodule;

        it2.options = o;

        if( o.onBegin )
        o.onBegin( it2 )
        if( o.onEnd )
        return o.onEnd( it2 );

        return null;
      });
      con2.take( null );
      return con2;
    });

  }
  else
  {

    o.selector = path.resolve( o.selector );
    con = new _.Consequence().take( null );

    let files = will.willFilesList
    ({
      dirPath : o.selector,
      includingInFiles : 1,
      includingOutFiles : 0,
      rerucrsive : 0,
    });

    let filesMap = Object.create( null );
    for( let f = 0 ; f < files.length ; f++ ) con.then( ( arg ) => /* !!! replace by concurrent, maybe */
    {
      let file = files[ f ];

      if( filesMap[ file.absolute ] )
      {
        return true;
      }

      let module = will.Module({ will : will, willFilesPath : file.absolute }).preform();

      module.willFilesFind();

      let it = Object.create( null );
      it.module = module;
      it.options = o;

      module.stager.stageConsequence( 'willFilesFound' ).then( ( arg ) =>
      {
        if( o.onBegin )
        return o.onBegin( it );
        return arg;
      });

      module.willFilesOpen();
      module.submodulesForm();
      module.resourcesForm();

      return module.ready.split().keep( function( arg )
      {
        _.assert( module.willFileArray.length > 0 );
        if( module.willFilesPath )
        _.mapSet( filesMap, module.willFilesPath, true );

        let r = o.onEnd( it );

        r = _.Consequence.From( r );

        r.finally( ( err, arg ) =>
        {
          if( err )
          throw err;
          return arg;
        });

        return r;
      })

    });

  }

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err );
    return o;
  });

  return con;
}

moduleEach.defaults =
{
  currentModule : null,
  selector : null,
  onBegin : null,
  onEnd : null,
}

//

function _verbosityChange()
{
  let will = this;

  _.assert( arguments.length === 0 );
  _.assert( !will.fileProvider || will.fileProvider.logger !== will.logger );

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

  let filter =
  {
    maskTerminal :
    {
      includeAny : /\.will(\.|$)/,
      excludeAny :
      [
        /\.DS_Store$/,
        /(^|\/)-/,
      ],
      includeAll : []
    }
  };

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
    maskPreset : 0,
  });
  // debugger;

  return files;
}

willFilesList.defaults =
{
  dirPath : null,
  includingInFiles : 1,
  includingOutFiles : 1,
  rerucrsive : 0,
}

//

function vcsFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( o ) )
  o = { filePath : o }

  _.assert( arguments.length === 1 );
  _.routineOptions( vcsFor, o );
  _.assert( !!will.formed );

  if( _.arrayIs( o.filePath ) && o.filePath.length === 0 )
  return null;

  if( !o.filePath )
  return null;

  let result = fileProvider.providerForPath( o.filePath );

  if( !result )
  return null

  if( !result.isVcs )
  return null

  return result;
}

vcsFor.defaults =
{
  filePath : null,
}

// --
// relations
// --

var ResourceKindToClassName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource class name' }).set
({

  'submodule' : 'Submodule',
  'step' : 'Step',
  'path' : 'PathResource',
  'reflector' : 'Reflector',
  'build' : 'Build',
  'about' : 'About',
  'execution' : 'Execution',
  'exported' : 'Exported',

});

var ResourceKindToMapName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource map name' }).set
({

  'about' : 'about',
  'submodule' : 'submoduleMap',
  'step' : 'stepMap',
  'path' : 'pathResourceMap',
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
  // moduleMap : 'moduleMap',
}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,
  unform,
  form,
  formAssociates,

  moduleMake,
  moduleEach,
  _verbosityChange,
  willFilesList,
  vcsFor,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

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
wTools[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
require( './IncludeTop.s' );

})();
