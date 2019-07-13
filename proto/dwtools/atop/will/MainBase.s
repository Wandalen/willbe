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
- Willbe prepends path::in by module.dirPath, a directory which has the willfile.
- Major difference between generated out-willfiles and manually written willfile is section exported. out-willfiles has such section, manually written willfile does not.
- Output files are generated and input files are for manual editing, but the utility can help with it.

*/

/*

= Requested features

- Command .submodules.update should change back manually updated fixated submodules.
- Faster loading, perhaps without submodules
- Timelapse for transpilation
- Reflect submodules into dir with the same name as submodule

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

  _.instanceInit( will );
  Object.preventExtensions( will );

  _.assert( logger === will.logger );

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

// --
// etc
// --

function _verbosityChange()
{
  let will = this;

  _.assert( arguments.length === 0 );
  _.assert( !will.fileProvider || will.fileProvider.logger !== will.logger );

  if( will.fileProvider )
  will.fileProvider.verbosity = will.verbosity-2;

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

//

function CommonPathFor( willfilesPath )
{
  if( _.arrayIs( willfilesPath ) )
  willfilesPath = willfilesPath[ 0 ];

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( willfilesPath ) );

  let common = willfilesPath.replace( /\.will(\.\w+)?$/, '' );

  common = common.replace( /(\.im|\.ex)$/, '' );

  return common;
}

// --
// module
// --

function moduleMake( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  o = _.routineOptions( moduleMake, arguments );

  if( !o.willfilesPath )
  o.willfilesPath = o.willfilesPath || fileProvider.path.current();

  if( !o.module )
  {
    o.module = will.OpenerModule({ will : will, willfilesPath : o.willfilesPath }).preform();
  }

  o.module.moduleFind();
  o.module.openedModule.stager.stageStatePausing( 'picked', 0 );
  o.module.openedModule.stager.stageStateSkipping( 'resourcesFormed', !o.forming );
  o.module.openedModule.stager.tick();

  return o.module;
}

moduleMake.defaults =
{
  module : null,
  willfilesPath : null,
  forming : 0,
}

//

function moduleEachAt( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let con;
  let errs = [];

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  if( _.strEnds( o.selector, '::' ) )
  o.selector = o.selector + '*';

  /* */

  if( will.Resolver.selectorIs( o.selector ) )
  {

    let module = o.currentModule;
    if( !o.currentModule )
    module = o.currentModule = will.OpenerModule({ will : will, willfilesPath : path.trail( path.current() ) }).preform();
    module.moduleFind();

    con = module.openedModule.ready;
    con.then( () =>
    {
      let con2 = new _.Consequence();
      let resolved = module.openedModule.submodulesResolve({ selector : o.selector, preservingIteration : 1 });
      resolved = _.arrayAs( resolved );

      for( let s = 0 ; s < resolved.length ; s++ ) con2.keep( ( arg ) => /* !!! replace by concurrent, maybe */
      {
        let it1 = resolved[ s ];
        let module = it1.currentModule;

        let it2 = Object.create( null );
        it2.currentModule = module.openerMake(); // zzz

        if( _.arrayIs( it1.dst ) || _.strIs( it1.dst ) )
        it2.currentPath = it1.dst;
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

    module.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
    module.openedModule.stager.stageStatePausing( 'picked', 0 );
    module.openedModule.stager.tick();

  }
  else
  {

    o.selector = path.resolve( o.selector );
    con = new _.Consequence().take( null );

    let files;
    try
    {
      files = will.willfilesList
      ({
        dirPath : o.selector,
        includingInFiles : 1,
        includingOutFiles : 1,
      });
    }
    catch( err )
    {
      throw _.errBriefly( err );
    }

    let filesMap = Object.create( null );
    for( let f = 0 ; f < files.length ; f++ ) con
    .then( ( arg ) => /* !!! replace by concurrent, maybe */
    {
      let file = files[ f ];

      if( filesMap[ file.absolute ] )
      {
        return true;
      }

      let module = will.OpenerModule({ will : will, willfilesPath : file.absolute }).preform();
      // debugger;
      module.moduleFind();
      // debugger;

      let it = Object.create( null );
      it.currentModule = module;
      it.options = o;

      module.openedModule.stager.stageConsequence( 'preformed' ).then( ( arg ) =>
      {
        // debugger;
        if( o.onBegin )
        return o.onBegin( it );
        return arg;
      });

      module.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
      module.openedModule.stager.stageStatePausing( 'picked', 0 );
      module.openedModule.stager.tick();

      return module.openedModule.ready.split().keep( function( arg )
      {
        // debugger;
        _.assert( module.willfilesArray.length > 0 );
        if( module.willfilesPath )
        _.mapSet( filesMap, module.willfilesPath, true );

        let r = null;
        if( o.onEnd )
        r = o.onEnd( it );

        return r;
      })

    })
    .finally( ( err, arg ) =>
    {
      if( err )
      {
        debugger;
        if( o.onError )
        o.onError( err );
        errs.push( _.errBriefly( err ) );
        return null;
      }
      return arg;
    });

  }

  /* */

  con.finally( ( err, arg ) =>
  {
    if( errs.length )
    {
      errs.forEach( ( err, index ) => index > 0 ? _.errAttend( err ) : null );
      throw errs[ 0 ];
    }
    if( err )
    {
      errs.forEach( ( err, index ) => _.errAttend( err ) );
      throw _.err( err );
    }
    return o;
  });

  /* */

  return con;
}

moduleEachAt.defaults =
{
  currentModule : null,
  selector : null,
  onBegin : null,
  onEnd : null,
}

//

function moduleWithAt( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let con;

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  /* */

  o.selector = path.resolve( o.selector );
  con = new _.Consequence().take( null );

  let it = Object.create( null );
  it.options = o;
  it.errs = [];
  it.modulesMap = Object.create( null );

  let files;
  try
  {
    files = will.willfilesList
    ({
      dirPath : o.selector,
      includingInFiles : 1,
      includingOutFiles : 1,
    });
  }
  catch( err )
  {
    throw _.errBriefly( err );
  }

  for( let f = 0 ; f < files.length ; f++ ) con
  .then( ( arg ) => /* !!! replace by concurrent, maybe */
  {
    try
    {
      let file = files[ f ];

      let opener = will.OpenerModule({ will : will, willfilesPath : file.absolute }).preform();
      opener.moduleFind();

      if( !opener.openedModule.stager.stageStatePerformed( 'ready' ) )
      {
        debugger;
        opener.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
        opener.openedModule.stager.stageStatePausing( 'picked', 0 );
        opener.openedModule.stager.tick();
      }
      else
      {
        debugger;
      }

      return opener.openedModule.ready.split()
      .then( function( arg )
      {
        _.assert( opener.willfilesArray.length > 0 );
        _.mapSetStrictly( it.modulesMap, opener.openedModule.commonPath, opener.openedModule );
        return r;
      })
      .except( function( err )
      {
        it.errs.push( _.errBriefly( err ) );
        opener.finit();
      });
    }
    catch( err )
    {
      debugger;
      it.errs.push( _.errBriefly( err ) );
      opener.finit();
      throw err;
    }
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    {
      debugger;
      _.assert( 0, 'should not happen' );
    }
    return arg;
  });

  /* */

  con.finally( ( err, arg ) =>
  {
    if( err )
    {
      errs.forEach( ( err, index ) => _.errAttend( err ) );
      throw _.err( err );
    }
    if( errs.length )
    {
      errs.forEach( ( err, index ) => index > 0 ? _.errAttend( err ) : null );
      throw errs[ 0 ];
    }
    return o;
  });

  /* */

  return con;
}

moduleWithAt.defaults =
{
  currentModule : null,
  selector : null,
  onBegin : null,
  onEnd : null,
}

//

function moduleAt( willfilesPath )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );

  let commonPath = will.CommonPathFor( willfilesPath );

  return will.moduleWithPathMap[ commonPath ];
}

//

function moduleIdUnregister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( openedModule.id > 0 );

  _.assert( will.moduleWithIdMap[ openedModule.id ] === openedModule || will.moduleWithIdMap[ openedModule.id ] === undefined );
  delete will.moduleWithIdMap[ openedModule.id ];
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithIdMap ), openedModule ) === 0 );
  _.arrayRemoveOnceStrictly( will.modulesArray, openedModule );

  will.modulesGraphInvalidate();
}

//

function moduleIdRegister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( arguments.length === 1 );
  _.assert( openedModule.id > 0 );

  _.assert( will.moduleWithIdMap[ openedModule.id ] === openedModule || will.moduleWithIdMap[ openedModule.id ] === undefined );
  will.moduleWithIdMap[ openedModule.id ] = openedModule;
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithIdMap ), openedModule ) === 1 );
  _.arrayAppendOnceStrictly( will.modulesArray, openedModule );

  will.modulesGraphInvalidate();
}

//

function modulePathUnregister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( openedModule._registeredPath === null || openedModule._registeredPath === openedModule.commonPath );

  if( !openedModule._registeredPath )
  return;

  if( openedModule.commonPath )
  {
    _.assert( _.strIs( openedModule.commonPath ) );
    _.assert( will.moduleWithPathMap[ openedModule.commonPath ] === openedModule );
    delete will.moduleWithPathMap[ openedModule.commonPath ];
  }

  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithPathMap ), openedModule ) === 0 );

}

//

function modulePathRegister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  openedModule._registeredPath = openedModule.commonPath;

  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( openedModule.commonPath ) );

  _.assert
  (
    will.moduleWithPathMap[ openedModule.commonPath ] === openedModule || will.moduleWithPathMap[ openedModule.commonPath ] === undefined,
    () => 'Different instance of ' + openedModule.constructor.name + ' is registered at ' + openedModule.commonPath
  );
  will.moduleWithPathMap[ openedModule.commonPath ] = openedModule;
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithPathMap ), openedModule ) === 1 );

}

//

function modulesGraphInvalidate()
{
  let will = this;

  if( will.graphGroup )
  {
    will.graphGroup.sys.finit();
    will.graphGroup = null;
  }

}

//

function modulesGraphGroupObtain()
{
  let will = this;

  let group = will.graphGroup;
  if( group )
  return group;

  let sys = new _.graph.AbstractGraphSystem();
  group = will.graphGroup = sys.groupMake
  ({
    onNodeNameGet : ( module ) => module.nickName,
    onOutNodesFor : onOutNodesFor,
    onInNodesFor : onInNodesFor,
  });

  group.nodesAdd( will.modulesArray );

  // debugger;
  // logger.log( group.exportInfo() );
  // debugger;

  return group;

  function onOutNodesFor( module )
  {
    let result = module.submoduleMap ? _.mapVals( module.submoduleMap ) : [];
    result = result.map( ( module ) => module.opener ? module.opener : module );
    result = result.map( ( module ) => module.openedModule ? module.openedModule : module );
    return result;
  }

  function onInNodesFor( module )
  {
    if( module.supermodules )
    return module.supermodules;
    if( module.supermodule )
    return [ module.supermodule ];
    return [];
  }

}

//

function modulesTopologicalSort()
{
  let will = this;

  let group = will.modulesGraphGroupObtain();
  let sorted = group.topologicalSortCycledSourceBased();

  return sorted;
}

//

function modulesInfoExportAsTree( modules )
{
  let will = this;

  let group = will.modulesGraphGroupObtain();
  let info = group.nodesInfoExportAsTree( modules );

  return info;
}

// --
// opener
// --

function openerUnregister( opener )
{
  let will = this;

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  delete will.openerModuleWithIdMap[ opener.id ];
  _.assert( _.arrayCountElement( _.mapVals( will.openerModuleWithIdMap ), opener ) === 0 );
  _.arrayRemoveOnceStrictly( will.openersArray, opener );

}

//

function openerRegister( opener )
{
  let will = this;

  _.assert( opener.id > 0 );
  will.openerModuleWithIdMap[ opener.id ] = opener;
  _.arrayAppendOnceStrictly( will.openersArray, opener );
  _.assert( _.arrayCountElement( _.mapVals( will.openerModuleWithIdMap ), opener ) === 1 );

}

// --
// willfile
// --

function willfilesList( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( _.strIs( o ) )
  o = { dirPath : o }

  _.routineOptions( willfilesList, o );
  _.assert( arguments.length === 1 );
  _.assert( !!will.formed );

  let filter =
  {
    maskTerminal :
    {
      includeAny : /\.will(\.[^.]*)?$/,
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

  let o2 =
  {
    filePath : o.dirPath,
    recursive : o.recursive,
    filter : filter,
    maskPreset : 0,
  }

  // logger.log( 'willfilesList.begin' );
  let files = fileProvider.filesFind( o2 );
  // logger.log( 'willfilesList.end' );

  return files;
}

willfilesList.defaults =
{
  dirPath : null,
  includingInFiles : 1,
  includingOutFiles : 1,
  recursive : null,
}

//

function willfileAt( filePath )
{
  let will = this;
  let commonPath = will.Willfile.CommonPathFor( filePath );
  return will.willfileWithPathMap[ commonPath ];
}

//

function willfileFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );

  o.will = will;

  let willf = will.willfileAt( o.filePath );
  if( willf )
  {
    _.assert( !o.data );
    _.assert( !o.openerModule || o.openerModule === willf.openerModule );
    willf.copy( o );
  }
  else
  {
    willf = new will.Willfile( o ).preform();
  }

  return willf;
}

//

function willfileUnregister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( will.willfileWithPathMap[ willf.commonPath ] === willf );
  delete will.willfileWithPathMap[ willf.commonPath ];
  _.assert( _.arrayCountElement( _.mapVals( will.willfileWithPathMap ), willf ) === 0 );
  _.arrayRemoveOnceStrictly( will.willfilesArray, willf );

}

//

function willfileRegister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayAppendOnceStrictly( will.willfilesArray, willf );
  _.assert( will.willfileWithPathMap[ willf.commonPath ] === undefined );
  will.willfileWithPathMap[ willf.commonPath ] = willf;
  _.assert( _.arrayCountElement( _.mapVals( will.willfileWithPathMap ), willf ) === 1 );

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
  'module' : 'moduleWithNameMap',
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

  modulesArray : _.define.own([]),
  moduleWithIdMap : _.define.own({}),
  moduleWithPathMap : _.define.own({}),
  moduleWithNameMap : _.define.own({}),

  openersArray : _.define.own([]),
  openerModuleWithIdMap : _.define.own({}),

  willfilesArray : _.define.own([]),
  willfileWithPathMap : _.define.own({}),

}

let Restricts =
{
  formed : 0,
  graphGroup : null,
}

let Statics =
{

  CommonPathFor,

  ResourceKindToClassName : ResourceKindToClassName,
  ResourceKindToMapName : ResourceKindToMapName,
  ResourceKinds : ResourceKinds,
  ResourceCounter : 0,

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

  finit,
  init,
  unform,
  form,
  formAssociates,

  // etc

  _verbosityChange,
  vcsFor,
  CommonPathFor,

  // module

  moduleMake,
  moduleEachAt,
  moduleWithAt,

  moduleAt,
  moduleIdUnregister,
  moduleIdRegister,
  modulePathUnregister,
  modulePathRegister,

  modulesGraphInvalidate,
  modulesGraphGroupObtain,
  modulesTopologicalSort,
  modulesInfoExportAsTree,

  // opener

  openerUnregister,
  openerRegister,

  // willfile

  willfilesList,
  willfileAt,
  willfileFor,
  willfileUnregister,
  willfileRegister,

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
require( './IncludeMid.s' );

})();
