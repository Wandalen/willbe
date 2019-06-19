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
// parser
// --

function StrRequestParse( srcStr )
{

  if( Self.SelectorIsScalar( srcStr ) )
  {
    let left, right;
    let splits = _.strSplit( srcStr );

    if( splits.length > 1 )
    debugger;

    for( let s = splits.length - 1 ; s >= 0 ; s-- )
    {
      let split = splits[ s ];
      if( Self.SelectorIsScalar( split ) )
      {
        left = splits.slice( 0, s+1 ).join( ' ' );
        right = splits.slice( s+1 ).join( ' ' );
      }
    }
    let result = _.strRequestParse( right );
    result.subject = left + result.subject;
    result.subjects = [ result.subject ];
    return result;
  }

  let result = _.strRequestParse( srcStr );
  return result;
}

//

function SelectorIsScalar( selector )
{
  if( !_.strIs( selector ) )
  return false;
  if( !_.strHas( selector, '::' ) )
  return false;
  return true;
}

//

function SelectorIs( selector )
{
  if( _.arrayIs( selector ) )
  {
    for( let s = 0 ; s < selector.length ; s++ )
    if( this.SelectorIs( selector[ s ] ) )
    return true;
  }
  return this.SelectorIsScalar( selector );
}

//

function SelectorIsComposite( selector )
{

  if( !this.SelectorIs( selector ) )
  return false;

  if( _.arrayIs( selector ) )
  {
    for( let s = 0 ; s < selector.length ; s++ )
    if( isComposite( selector[ s ] ) )
    return true;
  }
  else
  {
    return isComposite( selector );
  }

  /* */

  function isComposite( selector )
  {

    let splits = _.strSplitFast
    ({
      src : selector,
      delimeter : [ '{', '}' ],
    });

    if( splits.length < 5 )
    return false;

    splits = _.strSplitsCoupledGroup({ splits : splits, prefix : '{', postfix : '}' });

    if( !splits.some( ( split ) => _.arrayIs( split ) ) )
    return false;

    return true;
  }

}

function SelectorShortSplitAct( selector )
{
  _.assert( !_.strHas( selector, '/' ) );
  let result = _.strIsolateLeftOrNone( selector, '::' );
  return result;
}

//

function SelectorShortSplit( o )
{
  let will = this;
  let result;

  _.assertRoutineOptions( SelectorShortSplit, o );
  _.assert( arguments.length === 1 );
  _.assert( !_.strHas( o.selector, '/' ) );
  _.sure( _.strIs( o.selector ) || _.strsAreAll( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let splits = will.SelectorShortSplitAct( o.selector );

  if( !splits[ 0 ] && o.defaultResourceName )
  {
    splits = [ o.defaultResourceName, '::', o.selector ];
  }

  return splits;
}

var defaults = SelectorShortSplit.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceName = null;

//

function SelectorLongSplit( o )
{
  let will = this;
  let result = [];

  if( _.strIs( o ) )
  o = { selector : o }

  _.routineOptions( SelectorLongSplit, o );
  _.assert( arguments.length === 1 );
  _.sure( _.strIs( o.selector ) || _.strsAreAll( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let selectors = o.selector.split( '/' );

  selectors.forEach( ( selector ) =>
  {
    let o2 = _.mapExtend( null, o );
    o2.selector = selector;
    result.push( will.SelectorShortSplit( o2 ) );
  });

  return result;
}

var defaults = SelectorLongSplit.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceName = null;

//

function SelectorParse( o )
{
  let will = this;
  let result = [];

  if( _.strIs( o ) )
  o = { selector : o }

  _.routineOptions( SelectorParse, o );
  _.assert( arguments.length === 1 );
  _.sure( _.strIs( o.selector ) || _.strsAreAll( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let splits = _.strSplitFast
  ({
    src : o.selector,
    delimeter : [ '{', '}' ],
  });

  splits = _.strSplitsCoupledGroup({ splits : splits, prefix : '{', postfix : '}' });

  if( splits[ 0 ] === '' )
  splits.splice( 0, 1 );
  if( splits[ splits.length-1 ] === '' )
  splits.splice( splits.length-1, 1 );

  splits = splits.map( ( split ) =>
  {
    if( !_.arrayIs( split ) )
    return split;
    _.assert( split.length === 3 )
    if( module.SelectorIs( split[ 1 ] ) )
    {
      let o2 = _.mapExtend( null, o );
      o2.selector = split[ 1 ];
      split[ 1 ] = module.SelectorLongSplit( o2 );
    }
    return split;
  });

  return splits;
}

var defaults = SelectorParse.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceName = null;

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

  _.assert( o.module.willfilesPath === o.willfilesPath || o.module.willfilesPath === o.dirPath );

  o.module.open();
  o.module.openedModule.stager.stageStatePausing( 'opened', 0 );
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

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  if( _.strEnds( o.selector, '::' ) )
  o.selector = o.selector + '*';

  if( will.SelectorIs( o.selector ) )
  {

    let module = o.currentModule;
    if( !o.currentModule )
    module = o.currentModule = will.OpenerModule({ will : will, willfilesPath : path.current() }).preform();
    module.open();

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
        it2.currentModule = module.openerMake();

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
    module.openedModule.stager.stageStatePausing( 'opened', 0 );
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
        includingOutFiles : 0,
        // recursive : 0,
      });
    }
    catch( err )
    {
      throw _.errBriefly( err );
    }

    let filesMap = Object.create( null );
    for( let f = 0 ; f < files.length ; f++ ) con.then( ( arg ) => /* !!! replace by concurrent, maybe */
    {
      let file = files[ f ];

      if( filesMap[ file.absolute ] )
      {
        return true;
      }

      let module = will.OpenerModule({ will : will, willfilesPath : file.absolute }).preform();
      module.open();

      let it = Object.create( null );
      it.currentModule = module;
      it.options = o;

      module.openedModule.stager.stageConsequence( 'preformed' ).then( ( arg ) =>
      {
        if( o.onBegin )
        return o.onBegin( it );
        return arg;
      });

      module.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
      module.openedModule.stager.stageStatePausing( 'opened', 0 );
      module.openedModule.stager.tick();

      return module.openedModule.ready.split().keep( function( arg )
      {
        _.assert( module.willfileArray.length > 0 );
        if( module.willfilesPath )
        _.mapSet( filesMap, module.willfilesPath, true );

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

moduleEachAt.defaults =
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
  _.arrayRemoveOnceStrictly( will.moduleArray, openedModule );

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
  _.arrayAppendOnceStrictly( will.moduleArray, openedModule );

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
  _.assert( openedModule._pathRegistered === null || openedModule._pathRegistered === openedModule.commonPath );

  if( !openedModule._pathRegistered )
  return;

  if( openedModule.commonPath )
  {
    _.assert( _.strIs( openedModule.commonPath ) );
    // _.assert( will.moduleWithPathMap[ openedModule.commonPath ] === openedModule || will.moduleWithPathMap[ openedModule.commonPath ] === undefined );
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

  openedModule._pathRegistered = openedModule.commonPath;

  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( openedModule.commonPath ) );

  _.assert( will.moduleWithPathMap[ openedModule.commonPath ] === openedModule || will.moduleWithPathMap[ openedModule.commonPath ] === undefined );
  will.moduleWithPathMap[ openedModule.commonPath ] = openedModule;
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithPathMap ), openedModule ) === 1 );

}

//

function openerUnregister( opener )
{
  let will = this;

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  delete will.openerModuleWithIdMap[ opener.id ];
  _.assert( _.arrayCountElement( _.mapVals( will.openerModuleWithIdMap ), opener ) === 0 );
  _.arrayRemoveOnceStrictly( will.openerModuleArray, opener );

}

//

function openerRegister( opener )
{
  let will = this;

  _.assert( opener.id > 0 );
  will.openerModuleWithIdMap[ opener.id ] = opener;
  _.arrayAppendOnceStrictly( will.openerModuleArray, opener );
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

  if( _.strIs( o ) )
  o = { dirPath : o }

  _.routineOptions( willfilesList, o );
  _.assert( arguments.length === 1 );
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

  let o2 =
  {
    filePath : o.dirPath,
    recursive : o.recursive,
    filter : filter,
    maskPreset : 0,
  }

  debugger;
  let files = fileProvider.filesFind( o2 );
  debugger;

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
  // let opener = this;
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );

  o.will = will;
  // o.openerModule = opener;

  let willf = will.willfileAt( o.filePath );
  if( willf )
  {
    _.assert( !o.data );
    _.assert( !o.openerModule || o.openerModule === willf.openerModule );
    willf.copy( o );
  }
  else
  {

    willf = new will.Willfile( o ).form1();

  }

  return willf;

/*

  willf = new will.Willfile
  ({
    role : o.role,
    filePath : filePath,
    isOutFile : o.isOutFile,
    openerModule : opener,
    will : will,
  }).form1();

  let willfile = new will.Willfile
  ({
    will : will,
    role : 'single',
    filePath : filePath,
    openerModule : opener,
    data : opener.pickedWillfileData,
  }).form1();

*/

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
  _.arrayRemoveOnceStrictly( will.willfileArray, willf );

}

//

function willfileRegister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayAppendOnceStrictly( will.willfileArray, willf );
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

  moduleArray : _.define.own([]),
  moduleWithIdMap : _.define.own({}),
  moduleWithPathMap : _.define.own({}),

  openerModuleArray : _.define.own([]),
  openerModuleWithIdMap : _.define.own({}),

  willfileArray : _.define.own([]),
  willfileWithPathMap : _.define.own({}),

}

let Restricts =
{
  formed : 0,
}

let Statics =
{

  StrRequestParse,
  SelectorIsScalar,
  SelectorIs,
  SelectorIsComposite,
  SelectorShortSplitAct,
  SelectorShortSplit,
  SelectorLongSplit,
  SelectorParse,

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

  // parser

  StrRequestParse,
  SelectorIsScalar,
  SelectorIs,
  SelectorIsComposite,
  SelectorShortSplitAct,
  SelectorShortSplit,
  SelectorLongSplit,
  SelectorParse,

  // etc

  _verbosityChange,
  vcsFor,
  CommonPathFor,

  // module

  moduleMake,
  moduleEachAt,

  moduleAt,
  moduleIdUnregister,
  moduleIdRegister,
  modulePathUnregister,
  modulePathRegister,

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
