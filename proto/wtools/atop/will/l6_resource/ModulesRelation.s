( function _ModulesRelation_s_()
{

'use strict';

/**
 * @classdesc Class wWillModulesRelation provides interface for founding and handling relations between modules and submodules.
 * @class wWillModulesRelation
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.Resource;
const Self = wWillModulesRelation;
function wWillModulesRelation( o )
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

function ResouceStructureFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return _.props.extend( null, o );
}

//

function unform()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;

  if( relation.formed <= 0 )
  return;

  relation.formed = -1; /* yyy */

  if( relation.opener )
  {
    let opener = relation.opener;
    _.assert( opener.superRelation === relation );
    opener.superRelation = null;
    relation.opener = null;
    opener.finit();
  }

  // return Parent.prototype.unform.call( relation );

  // if( relation.formed ) /* yyy */
  // {
  let junction = will.junctionOf( relation );
  /* xxx : not always true? */
  if( junction && junction.own( relation ) )
  junction.remove( relation );
  // }

  return Parent.prototype.unform.call( relation ); /* yyy */
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
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( relation.module instanceof _.will.Module );

  /* */

  relation.opener = _.will.ModuleOpener
  ({
    will,
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

  Parent.prototype.form1.call( relation );

  will.junctionReform( relation );

  /* end */

  // Parent.prototype.form1.call( relation ); /* yyy */
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
  let logger = will.transaction.logger;
  let result = relation;

  if( relation.formed >= 3 )
  {
    if( relation.opener && !relation.opener.isValid() )
    {
      relation.close();
    }
    else
    {
      return result;
    }
  }

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( relation.formed === 2 );
  _.assert( _.strIs( relation.path ), 'not tested' );
  _.sure( _.strIs( relation.path ) || _.arrayIs( relation.path ), 'Path resource should have "path" field' );

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

    if( !err && relation.opener.openedModule )
    relation._openEnd();

    return arg || null;
  });

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
  let logger = will.transaction.logger;
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
  let logger = will.transaction.logger;
  let rootModule = module.rootModule;

  if( relation.formed > 2 )
  relation.formed = 2;

  return relation;
}

//

function _openAct( o )
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let rootModule = module.rootModule;

  o = _.routine.options_( _openAct, arguments );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( relation.formed === 2 );
  _.assert( !!relation.opener );
  _.assert( _.strIs( relation.path ), 'not tested' );
  _.assert( !relation.original );
  _.sure( _.strIs( relation.path ) || _.arrayIs( relation.path ), 'Path resource should have "path" field' );

  if( o.longPath === null )
  o.longPath = relation.localPathGet();
  // o.longPath = relation.longPath;

  relation._wantedOpened = 1;

  if( relation.opener.isOpened() )
  {
    _.assert( relation.opener.formed === 5 );
    _.assert( !!relation.opener.willfilesPath );
    return relation.opener;
  }

  _.assert( relation.opener.localPath === o.longPath || relation.opener.remotePath === o.longPath );

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

//

function _openEnd()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let rootModule = module.rootModule;

  _.assert( relation.formed === 3 );
  _.assert( !!relation.opener.openedModule );

  // if( relation.enabled )
  will.junctionReform( relation );

  let modules2 = relation.opener.openedModule.modulesEachAll
  ({
    ... _.Will.RelationFilterOn,
    withPeers : 0,
    withStem : 1,
    recursive : 2,
  })

  modules2.forEach( ( module2 ) => module2 ? module2._nameRegister( rootModule ) : null );

}

//

function _moduleAdoptEnd()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let rootModule = module.rootModule;

  _.assert( relation.formed < 3 );
  _.assert( !!relation.opener.openedModule );

  if( relation.formed === 2 && relation._wantedOpened )
  {
    relation.formed = 3;
  }
  else
  {
  }

  relation._openEnd();

}

// --
// etc
// --

function own( object )
{
  let relation = this;
  let module = relation.module;
  let will = module.will;

  _.assert( !!object );

  if( object instanceof _.will.ModulesRelation )
  {
    if( object === relation )
    return relation;
    if( relation.opener )
    relation.opener.own( object );
  }
  else
  {
    if( relation.opener === object )
    return true;
    if( relation.opener.openedModule === object )
    return true;
    if( relation.opener )
    return relation.opener.own( object );
  }

  return false;
}

//

function ownedBy( object )
{
  let relation = this;

  if( _.arrayIs( object ) )
  return !!_.any( object, ( object ) => relation.ownedBy( object ) );

  return object.own( relation );
}

//

function submodulesRelationsFilter( o )
{
  let relation = this;

  _.assert( arguments.length === 1 );

  if( relation.opener )
  if( relation.opener.openedModule )
  return relation.opener.openedModule.submodulesRelationsFilter( o );

  return [];
}

// {
//   let relation = this;
//   let module = relation.module;
//   let will = module.will;
//
//   o = _.routine.options_( submodulesRelationsFilter, arguments );
//
//   let result = relation.submodulesRelationsOwnFilter( o );
//   let junction = will.junctionFrom( relation );
//   let junctions = junction.submodulesJunctionsFilter( o );
//
//   // if( o.withPeers )
//   // _.arrayPrependOnce( junctions, junction );
//
//   result = _.arrayAppendArraysOnce( result, junctions.map( ( junction ) => junction.objects ) );
//
//   return result;
// }

submodulesRelationsFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,

}

//

function submodulesRelationsOwnFilter( o )
{
  let relation = this;

  _.assert( arguments.length === 1 );

  if( relation.opener )
  if( relation.opener.openedModule )
  return relation.opener.openedModule.submodulesRelationsOwnFilter( o );

  return [];
}

submodulesRelationsOwnFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,
  allVariants : 0,

}

//

function isMandatory()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  if( !relation.enabled )
  return false;
  if( relation.criterion.dev )
  return false;
  if( relation.criterion.optional )
  return false;

  return true;
}

//

function isValid()
{
  let relation = this;
  let module = relation.module;

  if( !relation.opener )
  return false;

  return relation.opener.isValid();
}

//

function isAvailableGet()
{
  let relation = this;
  let module = relation.module;

  if( !relation.opener )
  return false;

  if( !relation.opener.repo )
  return false;

  if( !relation.opener.repo.isRepository )
  return false;

  if( !relation.opener.isOpened() )
  return false;

  if( !relation.opener.isValid() )
  return false;

  return true;
}

//

function isAliveGet()
{
  let relation = this;
  return relation.formed >= 1;
}

//

function moduleSet( src )
{
  let resource = this;

  resource[ moduleSymbol ] = src;

  _.assert( resource.module === null || resource.module instanceof _.will.Module );

  return src;
}

// --
// path
// --

function localPathGet()
{
  let relation = this;
  let module = relation.module;

  if( relation.opener )
  {
    _.assert( relation.opener.formed >= 2 );
    return relation.opener.localPath;
  }

  return null; /* yyy */

  // let will = module.will;
  // let fileProvider = will.fileProvider;
  // let path = fileProvider.path;
  //
  // if( path.isGlobal( relation.path ) )
  // return null;
  //
  // return path.join( module.inPath, relation.path );
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

  return null; /* yyy */

  // let will = module.will;
  // let fileProvider = will.fileProvider;
  // let path = fileProvider.path;
  //
  // if( !path.isGlobal( relation.path ) )
  // return null;
  //
  // return path.join( module.inPath, relation.path );
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
  return path.join( relation.willf.dirPath, relation.path );
  // return path.join( module.inPath, relation.path );
}

//

function pathSet( src )
{
  let relation = this;
  let module = relation.module;

  _.assert( !src || !relation.opener || relation.opener.formed < 3 );

  if( src )
  src = _.Will.CommonPathNormalize( src );

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

function pathsRebase( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  // let Resolver = _.will.resolver;

  o = _.routine.options_( pathsRebase, arguments );
  _.assert( path.isAbsolute( o.inPath ) );
  _.assert( path.isAbsolute( o.exInPath ) );

  if( !o.relative )
  o.relative = path.relative( o.inPath, o.exInPath );

  if( o.inPath === o.exInPath )
  {
    return resource;
  }

  /* */

  resource.path = path.filterInplace( resource.path, ( filePath ) =>
  {
    return resource.pathRebase
    ({
      filePath,
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

// --
// coercer
// --

function toModuleForResolver()
{
  let resource = this;
  _.assert( arguments.length === 0 );
  if( !resource.opener || !resource.opener.openedModule )
  return null;
  return resource.opener.openedModule;
}

//

function toModule()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  if( relation.opener.openedModule && relation.opener.openedModule )
  return relation.opener.openedModule;
  return null;
}

//

function toOpener()
{
  let relation = this;
  return relation.opener;
}

//

function toRelation()
{
  let relation = this;
  return relation;
}

//

function toJunction()
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  return will.junctionFrom( relation );
}

// --
// exporter
// --

function exportStructure( o )
{
  let relation = this;
  let module = relation.module;
  let willf = relation.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let rootModule = module.rootModule;

  let result = Parent.prototype.exportStructure.apply( this, arguments );

  if( result === undefined )
  return result;

  if( result.path && path.s.anyAreAbsolute( result.path ) )
  {
    result.path = _.filter_( null, result.path, ( p ) =>
    {
      let protocols = path.parseFull( p ).protocols;
      if( !protocols.length )
      return path.relative( module.inPath, p );
      return p;
    });
  }

  if( result.localPath && path.s.anyAreAbsolute( result.localPath ) )
  {
    result.localPath = _.filter_( null, result.localPath, ( p ) =>
    {
      let protocols = path.parseFull( p ).protocols;
      if( !protocols.length )
      return path.relative( module.inPath, p );
      return p;
    });
  }

  if( result.remotePath && path.s.anyAreAbsolute( result.remotePath ) )
  {
    result.remotePath = _.filter_( null, result.remotePath, ( p ) =>
    {
      let protocols = path.parseFull( p ).protocols;
      if( !protocols.length )
      return path.relative( module.inPath, p );
      return p;
    });
  }

  return result;
}

exportStructure.defaults = Object.create( _.will.Resource.prototype.exportStructure.defaults );

//

/* qqq : write test */
function exportString( o )
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let resultMap = Parent.prototype.exportStructure.call( relation );
  let tab = '  ';

  o = _.routine.options_( exportString, arguments );

  if( relation.opener )
  {
    let module2 = relation.opener;
    resultMap.remote = module2.remotePath;
    resultMap.local = module2.localPath;

    if( relation.opener.openedModule )
    resultMap[ 'Exported builds' ] = _.entity.exportString( _.props.keys( module2.openedModule.exportedMap ) );

  }

  resultMap.isAvailable = relation.isAvailable;

  let result = relation._exportString({ fields : resultMap });

  return result;
}

exportString.defaults =
{
  verbosity : 2,
  it : null,
}

// --
// etc
// --

function errorNotFound( err )
{
  let relation = this;
  let module = relation.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  // if( will.verbosity >= 3 )
  if( will.transaction.verbosity >= 3 )
  if( !relation.module.rootModule || relation.module.rootModule === relation.module )
  logger.error
  (
    ' ' + '!' + ' Failed to open ' + relation.decoratedAbsoluteName
    + ` at ${_.color.strFormat( relation.localPath, 'path' )}`
    // + ', try to download it with ' + _.color.strFormat( '.submodules.download', 'code' ) + ' or even ' + _.color.strFormat( '.clean', 'code' ) + ' it before downloading'
    // + '\n' + err.originalMessage
  );


  err = _.err( err );

  // if( will.verbosity >= 2 && !_.error.isBrief( err ) )
  if( will.transaction.verbosity >= 2 && !_.error.isBrief( err ) )
  {
    logger.error( _.errOnce( err ) );
  }
  // else if( will.verbosity >= 5 || !relation.opener || relation.opener.isOpened() )
  else if( will.transaction.verbosity >= 5 || !relation.opener || relation.opener.isOpened() )
  {
    // if( will.verbosity < 5 )
    if( will.transaction.verbosity < 5 )
    err = _.errBrief( err );
    logger.error( _.errOnce( err ) );
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

function resolve_head( routine, args )
{
  let resource = this;
  let module = resource.module;
  if( resource.opener && resource.opener.openedModule )
  module = resource.opener.openedModule;

  let o = args[ 0 ];
  if( !_.mapIs( o ) )
  o = { selector : o }

  _.assert( _.aux.is( o ) );
  _.assert( o.currentContext === undefined || o.currentContext === null || o.currentContext === resource );

  o.currentContext = resource;

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );

  return module.resolve.head.call( module, routine, [ o ] );
}

function resolve_body( o )
{
  let resource = this;
  let module = resource.module;
  if( resource.opener && resource.opener.openedModule )
  module = resource.opener.openedModule;

  _.assert( arguments.length === 1 );
  // _.assert( o.currentContext === null || o.currentContext === resource );
  _.assert( o.currentContext === resource );

  // o.currentContext = resource;
  return module.resolve.body.call( module, o );
}

_.routine.extendReplacing( resolve_body, Parent.prototype.resolve.body );

let resolve = _.routine.uniteReplacing( resolve_head, resolve_body );

// --
// relations
// --

let openerSymbol = Symbol.for( 'opener' );
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
  ResouceMapFrom : ResouceStructureFrom,
  ResouceStructureFrom,
  MapName : 'submoduleMap',
  KindName : 'relation',
}

let Accessors =
{
  isAvailable : { get : isAvailableGet, writable : 0 },
  localPath : { get : localPathGet, writable : 0 },
  remotePath : { get : remotePathGet, writable : 0 },
  opener : { set : openerSet },
  longPath : { get : longPathGet },
  path : { set : pathSet },
  module : { combining : 'rewrite' },
  // resolverModule : { get : toModuleForResolver, set : 0, combining : 'rewrite' },
}


let Forbids =
{
  data : 'data',
  isGitRepository : 'isGitRepository',
  isDownloaded : 'isDownloaded',
  isRepository : 'isRepository',
  hasFiles : 'hasFiles',
}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  copy,

  ResouceMapFrom : ResouceStructureFrom,
  ResouceStructureFrom,
  unform,
  form1,
  form3,

  close,
  _closeEnd,
  _openAct,
  _openEnd,
  _moduleAdoptEnd,

  // inter-module

  own,
  ownedBy,
  submodulesRelationsFilter,
  submodulesRelationsOwnFilter,

  isMandatory,
  isValid,
  isAvailableGet,
  isAliveGet,
  moduleSet,

  // path

  localPathGet,
  remotePathGet,
  openerSet,
  longPathGet,
  pathSet,
  pathsRebase,

  // coercer

  toModuleForResolver,
  toModule,
  toOpener,
  toRelation,
  toJunction,

  // exporter

  exportStructure,
  exportString,

  // etc

  errorNotFound,
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
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
