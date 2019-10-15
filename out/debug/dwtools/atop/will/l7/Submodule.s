( function _ModulesRelation_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillModulesRelation( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModulesRelation';

// --
// inter
// --

function finit( o )
{
  let relation = this;
  relation.unform();
  Parent.prototype.finit.apply( relation, arguments );
}

//

function init( o )
{
  let relation = this;
  Parent.prototype.init.apply( relation, arguments );
  return relation;
}

//

function copy( o )
{
  let relation = this;
  _.assert( arguments.length === 1 );
  return Parent.prototype.copy.call( relation, o );
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
  let relation = this;
  let module = relation.module;
  let will = module.will;

  if( !relation.formed )
  return;

  if( relation.opener )
  {
    let opener = relation.opener;
    _.assert( opener.superRelation === relation );
    opener.superRelation = null;
    relation.opener = null;
    opener.finit();
  }

  if( relation.formed )
  {
    let variant = will.variantOf( relation );
    _.assert( !!variant || !relation.enabled );
    if( variant )
    variant.remove( relation );
  }

  return Parent.prototype.unform.call( relation );
}

//

function form1()
{
  let relation = this;

  _.assert( !!relation.module );
  _.assert( !!relation.module.rootModule );

  let module = relation.module;
  let rootModule = relation.module.rootModule;
  let willf = relation.willf;
  let will = rootModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( relation.module instanceof will.OpenedModule );

  /* */

  relation.opener = will.ModuleOpener
  ({
    will : will,
    aliasName : relation.name,
    willfilesPath : relation.longPath,
    superRelation : relation,
    rootModule : module.rootModule,
    reason : 'sub',
    isAuto : 1,
  });

  relation.opener = will._openerMake({ opener : relation.opener });
  relation.opener.preform();

  _.assert( relation.opener.formed >= 2 );

  if( relation.enabled ) /* ttt */
  will.variantFrom( relation );

  /* end */

  Parent.prototype.form1.call( relation );
  return relation;
}

//

function form3()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = relation;

  if( relation.formed >= 3 )
  {
    if( relation.opener && !relation.opener.isValid() )
    {
      debugger;
      relation.close();
    }
    else
    {
      return result;
    }
  }

  _.assert( arguments.length === 0 );
  _.assert( relation.formed === 2 );
  _.assert( _.strIs( relation.path ), 'not tested' );
  _.sure( _.strIs( relation.path ) || _.arrayIs( relation.path ), 'Path resource should have "path" field' );

  /* begin */

  if( relation.enabled )
  result = relation._openAct();
  else
  result = null;

  result = _.Consequence.From( result );

  result.finally( ( err, arg ) =>
  {
    relation.formed = 3;

    if( err )
    {
      err = _.err( err );
      relation.errorNotFound( err );
    }

    return arg || null;
  });

  /* end */

  return result;
}

//

function close()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  relation._wantedOpened = 0;

  if( relation.opener )
  relation.opener.close();
  else
  relation._closeEnd();

  _.assert( relation.formed <= 2 );

  return relation;
}

//

function _closeEnd()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  if( relation.formed > 2 )
  relation.formed = 2;

  return relation;
}

//

function _moduleAdoptEnd()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  _.assert( relation.formed < 3 );
  _.assert( !!relation.opener.openedModule );

  if( relation.formed === 2 && relation._wantedOpened )
  {
    relation.formed = 3;
  }
  else
  {
    debugger;
  }

}

//

function _openAct( o )
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  o = _.routineOptions( _openAct, arguments );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( relation.formed === 2 );
  _.assert( !!relation.opener );
  _.assert( _.strIs( relation.path ), 'not tested' );
  _.assert( !relation.original );
  _.sure( _.strIs( relation.path ) || _.arrayIs( relation.path ), 'Path resource should have "path" field' );

  if( o.longPath === null )
  o.longPath = relation.longPath;

  relation._wantedOpened = 1;

  if( relation.opener.isOpened() )
  {
    _.assert( relation.opener.formed === 5 );
    _.assert( !!relation.opener.willfilesPath );
    return relation.opener;
  }

  _.assert( relation.opener.localPath === o.longPath || relation.opener.remotePath === o.longPath );
  // relation.opener.willfilesPath = o.longPath;

  if( !relation.enabled )
  return relation.opener;

  return relation.opener.open({ throwing : 1 })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, '\n', 'Failed to open', relation.absoluteName );
    return arg;
  });
}

_openAct.defaults =
{
  longPath : null,
}

// --
// accessor
// --

function isAvailableGet()
{
  let relation = this;
  let module = relation.module;

  if( !relation.opener )
  return false;

  if( !relation.opener.isDownloaded )
  return false;

  if( !relation.opener.isOpened() )
  return false;

  if( !relation.opener.isValid() )
  return false;

  return true;
}

//

function isDownloadedGet()
{
  let relation = this;
  let module = relation.module;

  if( !relation.opener )
  return false;

  return relation.opener.isDownloaded;
}

//

function localPathGet()
{
  let relation = this;
  let module = relation.module;

  if( relation.opener )
  {
    _.assert( relation.opener.formed >= 2 );
    return relation.opener.localPath;
  }

  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( path.isGlobal( relation.path ) )
  return null;

  return path.join( module.inPath, relation.path );
}

//

function remotePathGet()
{
  let relation = this;
  let module = relation.module;

  if( relation.opener )
  {
    _.assert( relation.opener.formed >= 2 );
    return relation.opener.remotePath;
  }

  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !path.isGlobal( relation.path ) )
  return null;

  return path.join( module.inPath, relation.path );
}

//

function openerSet( opener )
{
  let relation = this;

  if( opener === relation[ openerSymbol ] )
  return;

  relation[ openerSymbol ] = null;

  if( opener )
  {
    relation[ openerSymbol ] = opener;
  }

}

//

function longPathGet()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.join( module.inPath, relation.path );
}

//

function pathSet( src )
{
  let relation = this;
  let module = relation.module;

  _.assert( !src || !relation.opener || relation.opener.formed < 3 );

  relation[ pathSymbol ] = src;

  if( relation.opener )
  {
    let will = module.will;
    let fileProvider = will.fileProvider;
    let path = fileProvider.path;
    relation.opener.willfilesPath = path.join( module.inPath, src );
  }

  return src;
}

//

function dataGet()
{
  let relation = this;
  let module = relation.module;
  return relation[ dataSymbol ];
}

//

function dataSet( src )
{
  let relation = this;
  let module = relation.module;
  relation[ dataSymbol ] = src;
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

function structureExport( o )
{
  let relation = this;
  let module = relation.module;
  let willf = relation.willf;
  let will = module.will;
  let rootModule = module.rootModule;

  let result = Parent.prototype.structureExport.apply( this, arguments );

  if( result === undefined )
  return result;

  return result;
}

structureExport.defaults = Object.create( _.Will.Resource.prototype.structureExport.defaults );

//

function infoExport()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let resultMap = Parent.prototype.structureExport.call( relation );
  let tab = '  ';

  if( relation.opener )
  {
    let module2 = relation.opener;
    resultMap.remote = module2.remotePath;
    resultMap.local = module2.localPath;

    if( relation.opener.openedModule )
    resultMap[ 'Exported builds' ] = _.toStr( _.mapKeys( module2.openedModule.exportedMap ) );

  }

  resultMap.isDownloaded = relation.isDownloaded;
  resultMap.isAvailable = relation.isAvailable;

  let result = relation._infoExport({ fields : resultMap });

  return result;
}

// --
// etc
// --

function isMandatory()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( !relation.enabled )
  return false;
  if( relation.criterion.dev )
  return false;
  if( relation.criterion.optional )
  return false;

  return true;
}

//

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
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( will.verbosity >= 3 )
  if( !relation.module.rootModule || relation.module.rootModule === relation.module )
  logger.error
  (
    ' ' + '!' + ' Failed to open ' + relation.decoratedQualifiedName
    + ` at ${_.color.strFormat( relation.localPath, 'path' )}`
    // + ', try to download it with ' + _.color.strFormat( '.submodules.download', 'code' ) + ' or even ' + _.color.strFormat( '.clean', 'code' ) + ' it before downloading'
    // + '\n' + err.originalMessage
  );


  err = _.err( err );

  if( will.verbosity >= 2 && !_.errIsBrief( err ) )
  {
    logger.log( _.errOnce( err ) );
  }
  else if( will.verbosity >= 5 || !relation.opener || relation.opener.isOpened() )
  {
    if( will.verbosity < 5 )
    err = _.errBrief( err );
    logger.log( _.errOnce( err ) );
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

function resolve_pre( routine, args )
{
  let resource = this;
  let module = resource.module;
  if( resource.opener && resource.opener.openedModule )
  module = resource.opener.openedModule;
  return module.resolve.pre.apply( module, arguments );
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
}

_.routineExtend( resolve_body, Parent.prototype.resolve.body );

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

// --
// relations
// --

let openerSymbol = Symbol.for( 'opener' );
let dataSymbol = Symbol.for( 'data' );
let moduleSymbol = Symbol.for( 'module' );
let pathSymbol = Symbol.for( 'path' );

let Composes =
{

  path : null,
  autoExporting : 0,
  enabled : 1,

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
  _wantedOpened : 0,
}

let Medials =
{
}

let Statics =
{
  ResouceDataFrom : ResouceDataFrom,
  MapName : 'submoduleMap',
  KindName : 'relation',
}

let Accessors =
{
  isAvailable : { getter : isAvailableGet, readOnly : 1 },
  isDownloaded : { getter : isDownloadedGet, readOnly : 1 },
  localPath : { getter : localPathGet, readOnly : 1 },
  remotePath : { getter : remotePathGet, readOnly : 1 },
  opener : { setter : openerSet },
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

  finit,
  init,
  copy,

  ResouceDataFrom,
  unform,
  form1,
  form3,

  close,
  _closeEnd,
  _moduleAdoptEnd,
  _openAct,

  // accessor

  isAvailableGet,
  isDownloadedGet,
  localPathGet,
  remotePathGet,
  openerSet,
  longPathGet,
  pathSet,
  dataGet,
  dataSet,
  moduleSet,

  // exporter

  structureExport,
  infoExport,

  // etc

  isMandatory,
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
