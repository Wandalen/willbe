( function _Submodule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillSubmodule( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Submodule';

// --
// inter
// --

function finit( o )
{
  let submodule = this;
  submodule.unform();
  Parent.prototype.finit.apply( submodule, arguments );
}

//

function init( o )
{
  let submodule = this;
  Parent.prototype.init.apply( submodule, arguments );
  return submodule;
}

//

function copy( o )
{
  let submodule = this;
  _.assert( arguments.length === 1 );
  return Parent.prototype.copy.call( submodule, o );
}

//

function ResouceDataFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return _.mapExtend( null, o );
}

//

function unform()
{
  let submodule = this;
  let module = submodule.module;

  if( submodule.opener )
  submodule.opener.finit();
  submodule.opener = null;

  return Parent.prototype.unform.call( submodule );
}

//

function form1()
{
  let submodule = this;

  _.assert( !!submodule.module );
  _.assert( !!submodule.module.rootModule );

  let module = submodule.module;
  let rootModule = submodule.module.rootModule;
  let willf = submodule.willf;
  let will = rootModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( submodule.module instanceof will.OpenedModule );

  /* end */

  Parent.prototype.form1.call( submodule );
  return submodule;
}

//

function form3()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = submodule;

  if( submodule.formed >= 3 )
  {
    if( submodule.opener && !submodule.opener.isValid() )
    {
      debugger;
      let opener = submodule.opener;
      submodule.opener = null;
      opener.finit();
      submodule.formed = 2;
    }
    else
    {
      return result;
    }
  }

  _.assert( arguments.length === 0 );
  _.assert( submodule.formed === 2 );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  /* begin */

  result = submodule.open();

  result.finally( ( err, arg ) =>
  {

    if( err )
    submodule.errorNotFound( err );
    submodule.formed = 3;

    return arg || null;
  });

  /* end */

  return result;
}

//

function close()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  if( !submodule.opener )
  return submodule;

  debugger;
  _.assert( 0, 'not tesed' );
  submodule.opener.close();

  return submodule;
}

//

function open()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  _.assert( arguments.length === 0 );
  _.assert( submodule.formed === 2 );
  _.assert( submodule.opener === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  let longPath = submodule.longPath;

  submodule._openFrom
  ({
    longPath : longPath,
  });

  if( submodule.opener.error )
  {
    _.assert( !!submodule.opener.error );
    return new _.Consequence().error( submodule.opener.error );
  }

  // submodule.opener.openedModule.ready.finally( ( err, arg ) =>
  // {
  //   debugger;
  //   if( err )
  //   submodule.errorNotFound( err );
  //   submodule.formed = 3;
  //   return arg || null;
  // });

  return submodule.opener.openedModule.ready;
}

//

function _openFrom( o )
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  _.routineOptions( _openFrom, arguments );
  _.assert( arguments.length === 1 );
  _.assert( submodule.formed === 2 );
  _.assert( submodule.opener === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  /* */

  submodule.opener = will.OpenerModule
  ({
    will : will,
    aliasName : submodule.name,
    willfilesPath : o.longPath,
    supermodule : module,
    rootModule : module.rootModule,
  }).preform();

  // xxx : opener onReady?

  if( !submodule.opener.moduleFindTry() )
  {
    submodule.opener.error = submodule.opener.error;
    return submodule.opener;
  }

  if( module.stager.stageStateSkipping( 'opened' ) )
  submodule.opener.openedModule.stager.stageStateSkipping( 'opened', 1 );

  submodule.opener.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
  submodule.opener.openedModule.stager.stageStatePausing( 'picked', 0 );
  submodule.opener.openedModule.stager.tick();

  submodule.opener.openedModule.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( 'Failed to open', submodule.nickName, 'at', _.strQuote( submodule.opener.dirPath ), '\n', err );
    return arg;
  });

  /* */

  return submodule.opener;
}

_openFrom.defaults =
{
  longPath : null,
}

// --
// accessor
// --

function isAvailableGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.opener )
  return false;

  if( !submodule.opener.isDownloaded )
  return false;

  if( !submodule.opener.isOpened() )
  return false;

  if( !submodule.opener.isValid() )
  return false;

  return true;
}

//

function isDownloadedGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.opener )
  return false;

  return submodule.opener.isDownloaded;
}

//

function openedModuleSet( opener )
{
  let submodule = this;

  if( opener === submodule[ openedModuleSymbol ] )
  return;

  submodule[ openedModuleSymbol ] = null;

  if( opener )
  {

    submodule[ openedModuleSymbol ] = opener;

  }

}

//

function longPathGet()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.join( module.inPath, submodule.path );
}

//

function pathSet( src )
{
  let submodule = this;
  let module = submodule.module;
  submodule[ pathSymbol ] = src;
  return src;
}

//

function dataGet()
{
  let submodule = this;
  let module = submodule.module;
  return submodule[ dataSymbol ];
}

//

function dataSet( src )
{
  let submodule = this;
  let module = submodule.module;
  submodule[ dataSymbol ] = src;
}

//

function moduleSet( src )
{
  let resource = this;

  resource[ moduleSymbol ] = src;

  _.assert( resource.module === null || resource.module instanceof _.Will.OpenedModule );

  return src;
}

// --
// exporter
// --

function dataExport( o )
{
  let submodule = this;
  let module = submodule.module;
  let willf = submodule.willf;
  let will = module.will;
  let rootModule = module.rootModule;

  let result = Parent.prototype.dataExport.apply( this, arguments );

  if( result === undefined )
  return result;

  return result;
}

dataExport.defaults = Object.create( _.Will.Resource.prototype.dataExport.defaults );

//

function infoExport()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let resultMap = Parent.prototype.dataExport.call( submodule );
  let tab = '  ';

  if( submodule.opener )
  {
    let module2 = submodule.opener;
    resultMap.remote = module2.remotePath;
    resultMap.local = module2.localPath;

    if( submodule.opener.openedModule )
    resultMap[ 'Exported builds' ] = _.toStr( _.mapKeys( module2.openedModule.exportedMap ) );

  }

  resultMap.isDownloaded = submodule.isDownloaded;
  resultMap.isAvailable = submodule.isAvailable;

  let result = submodule._infoExport({ fields : resultMap });

  return result;
}

// --
// etc
// --

function pathsRebase( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let Resolver = will.Resolver;

  o = _.routineOptions( pathsRebase, arguments );
  _.assert( path.isAbsolute( o.inPath ) );
  _.assert( path.isAbsolute( o.exInPath ) );

  if( !o.relative )
  o.relative = path.relative( o.inPath, o.exInPath );

  if( o.inPath === o.exInPath )
  {
    debugger;
    return resource;
  }

  /* */

  resource.path = path.filterInplace( resource.path, ( filePath ) =>
  {
    return resource.pathRebase
    ({
      filePath : filePath,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });
  });

  return resource;
}

pathsRebase.defaults =
{
  resource : null,
  relative : null,
  inPath : null,
  exInPath : null,
}

//

function errorNotFound( err )
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( will.verbosity >= 3 )
  logger.error( ' ' + _.color.strFormat( '!', 'negative' ) + ' Failed to read ' + submodule.decoratedNickName + ', try to download it with ' + _.color.strFormat( '.submodules.download', 'code' ) + ' or even ' + _.color.strFormat( '.clean', 'code' ) + ' it before downloading' );

  if( will.verbosity >= 5 || !submodule.opener || submodule.opener.isOpened() )
  {
    if( will.verbosity < 5 )
    _.errLogOnce( _.errBriefly( err ) );
    else
    _.errLogOnce( err );
  }
  else
  {
    _.errAttend( err );
  }

  return err;
}

// --
// resolver
// --

// function resolve_body( o )
// {
//   let submodule = this;
//   let module = submodule.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let module2 = submodule.opener || module;
//
//   _.assert( arguments.length === 1 );
//   _.assert( o.currentContext === null || o.currentContext === submodule )
//
//   o.currentContext = submodule;
//
//   let resolved = module2.openedModule.resolve( o );
//
//   return resolved;
// }
//
// _.routineExtend( resolve_body, _.Will.Resource.prototype.resolve.body );
// let resolve = _.routineFromPreAndBody( _.Will.Resource.prototype.resolve.pre, resolve_body );

function resolve_pre( routine, args )
{
  let resource = this;
  let module = resource.module;
  if( resource.opener && resource.opener.openedModule )
  module = resource.opener.openedModule;
  return module.resolve.pre.apply( module, arguments );
  // return Parent.prototype.resolve.pre.apply( resource, arguments );
}

function resolve_body( o )
{
  let resource = this;
  let module = resource.module;
  if( resource.opener && resource.opener.openedModule )
  module = resource.opener.openedModule;

  _.assert( arguments.length === 1 );
  _.assert( o.currentContext === null || o.currentContext === resource )

  o.currentContext = resource;
  return module.resolve.body.call( module, o );
  // return Parent.prototype.resolve.body.call( resource, o );
}

_.routineExtend( resolve_body, Parent.prototype.resolve.body );

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

// --
// relations
// --

let openedModuleSymbol = Symbol.for( 'opener' );
let dataSymbol = Symbol.for( 'data' );
let moduleSymbol = Symbol.for( 'module' );
let pathSymbol = Symbol.for( 'path' );

let Composes =
{

  path : null,
  autoExporting : 0,

}

let Aggregates =
{
  name : null,
}

let Associates =
{
}

let Restricts =
{
  opener : null,
}

let Medials =
{
}

let Statics =
{
  ResouceDataFrom : ResouceDataFrom,
  MapName : 'submoduleMap',
  KindName : 'submodule',
}

let Accessors =
{
  isAvailable : { getter : isAvailableGet, readOnly : 1 },
  isDownloaded : { getter : isDownloadedGet, readOnly : 1 },
  opener : { setter : openedModuleSet },
  longPath : { getter : longPathGet },
  path : { setter : pathSet },
  module : { combining : 'rewrite' },
}

let Forbids =
{
  data : 'data',
  own : 'own',
}

// --
// declare
// --

let Extend =
{

  // inter

  init,
  copy,

  ResouceDataFrom,
  unform,
  form1,
  form3,

  open,
  _openFrom,

  // accessor

  isAvailableGet,
  isDownloadedGet,
  openedModuleSet,
  longPathGet,
  pathSet,
  dataGet,
  dataSet,
  moduleSet,

  // exporter

  dataExport,
  infoExport,

  // etc

  pathsRebase,
  errorNotFound,

  // resolver

  resolve,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Accessors,
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
