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
  return _.instanceConstructor( Self, this, arguments );
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

function OptionsFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return o;
}

//

function unform()
{
  let submodule = this;
  let module = submodule.module;

  if( submodule.oModule )
  submodule.oModule.finit();
  submodule.oModule = null;

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

  // if( submodule.oModule )
  // {
  //   _.assert( rootModule.allModuleMap[ submodule.longPath ] === submodule.oModule || rootModule.allModuleMap[ submodule.longPath ] === undefined );
  //   rootModule.allModuleMap[ submodule.longPath ] = submodule.oModule;
  // }

  // rootModule.submoduleRegister( submodule ); // xxx

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
    if( submodule.oModule && !submodule.oModule.isValid() )
    {
      debugger; // xxx
      let oModule = submodule.oModule;
      submodule.oModule = null;
      // _.assert( oModule.submoduleAssociation.length === 0 );
      oModule.finit();
      submodule.formed = 2; // yyy
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

  // if( !module.supermodule )
  result = submodule.open();

  result.finally( ( err, arg ) =>
  {

    if( err )
    submodule.errorNotFound( err );

    // module.submoduleRegister( submodule, submodule.name );
    // module.rootModule.submoduleRegister( submodule );
    // debugger;
    // if( !err )
    submodule.formed = 3;

    return arg || null;
  });

  /* end */

  // submodule.formed = 3;
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

  if( !submodule.oModule )
  return submodule;

  debugger; xxx
  submodule.oModule.close();

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
  _.assert( submodule.oModule === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  let longPath = submodule.longPath;

  submodule._openFrom
  ({
    longPath : longPath,
    data : submodule.data,
  });

  if( submodule.oModule.error )
  {
    _.assert( !!submodule.oModule.error );
    return new _.Consequence().error( submodule.oModule.error );
  }

  return submodule.oModule.openedModule.ready;
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
  _.assert( submodule.oModule === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );
  _.assert( !submodule.data );

  /* */

  submodule.oModule = will.OpenerModule
  ({
    will : will,
    aliasName : submodule.name,
    willfilesPath : o.longPath,
    supermodule : module,
    rootModule : module.rootModule,
    pickedWillfilesPath : o.data ? o.longPath : null,
    pickedWillfileData : o.data,
  }).preform();

  if( !submodule.oModule.tryOpen() )
  {
    submodule.oModule.error = submodule.oModule.error;
    return submodule.oModule;
  }

  if( module.stager.stageStateSkipping( 'opened' ) )
  submodule.oModule.openedModule.stager.stageStateSkipping( 'opened', 1 );

  submodule.oModule.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
  submodule.oModule.openedModule.stager.stageStatePausing( 'opened', 0 );
  submodule.oModule.openedModule.stager.tick();

  submodule.oModule.openedModule.ready.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( 'Failed to open', submodule.nickName, 'at', _.strQuote( submodule.oModule.dirPath ), '\n', err );
    return arg;
  });

  /* */

  return submodule.oModule;
}

_openFrom.defaults =
{
  data : null,
  longPath : null,
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

  if( will.verbosity >= 5 || !submodule.oModule || submodule.oModule.isOpened() )
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

//

function resolve_body( o )
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let module2 = submodule.oModule || module;

  _.assert( arguments.length === 1 );
  _.assert( o.currentContext === null || o.currentContext === submodule )

  o.currentContext = submodule;

  let resolved = module2.openedModule.resolve( o );

  return resolved;
}

_.routineExtend( resolve_body, _.Will.Resource.prototype.resolve.body );
let resolve = _.routineFromPreAndBody( _.Will.Resource.prototype.resolve.pre, resolve_body );

//

function isAvailableGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.oModule )
  return false;

  if( !submodule.oModule.isDownloaded )
  return false;

  if( !submodule.oModule.isOpened() )
  return false;

  if( !submodule.oModule.isValid() )
  return false;

  return true;
}

//

function isDownloadedGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.oModule )
  return false;

  return submodule.oModule.isDownloaded;
}

//

function openedModuleSet( oModule )
{
  let submodule = this;

  if( oModule === submodule[ openedModuleSymbol ] )
  return;

  // if( submodule[ openedModuleSymbol ] )
  // _.arrayRemoveOnceStrictly( submodule[ openedModuleSymbol ].submoduleAssociation, submodule );
  submodule[ openedModuleSymbol ] = null;

  if( oModule )
  {

    // _.arrayAppendOnceStrictly( oModule.submoduleAssociation, submodule );
    submodule[ openedModuleSymbol ] = oModule;

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

  // if( src && src instanceof _.Will.OpenerModule )
  // src = src.openedModule;

  resource[ moduleSymbol ] = src;

  // _.assert( resource.module === null || resource.module instanceof _.Will.OpenerModule );
  _.assert( resource.module === null || resource.module instanceof _.Will.OpenedModule );

  return src;
}

//

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

  if( 0 )
  if( o.module === module && rootModule === module )
  {
    if( submodule.data )
    {
      result.data = submodule.data;
    }
    else if( submodule.oModule && submodule.oModule.isValid() )
    {
      result.data = submodule.oModule.dataExport();
    }
  }

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

  if( submodule.oModule )
  {
    let module2 = submodule.oModule;
    resultMap.remote = module2.remotePath;
    resultMap.local = module2.localPath;

    if( submodule.oModule.openedModule )
    resultMap[ 'Exported builds' ] = _.toStr( _.mapKeys( module2.openedModule.exportedMap ) );

  }

  resultMap.isDownloaded = submodule.isDownloaded;
  resultMap.isAvailable = submodule.isAvailable;

  let result = submodule._infoExport( resultMap );

  return result;
}

// --
// relations
// --

let openedModuleSymbol = Symbol.for( 'oModule' );
let dataSymbol = Symbol.for( 'data' );
let moduleSymbol = Symbol.for( 'module' );
let pathSymbol = Symbol.for( 'path' );

let Composes =
{

  description : null,
  criterion : null,
  inherit : _.define.own([]),
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
  data : null,
  oModule : null,
  own : 1, // xxx
}

let Medials =
{
  data : null,
  own : 1, // xxx
}

let Statics =
{
  OptionsFrom : OptionsFrom,
  MapName : 'submoduleMap',
  KindName : 'submodule',
}

let Accessors =
{
  isAvailable : { getter : isAvailableGet, readOnly : 1 },
  isDownloaded : { getter : isDownloadedGet, readOnly : 1 },
  oModule : { setter : openedModuleSet },
  longPath : { getter : longPathGet },
  path : { setter : pathSet },
  data : { getter : dataGet, setter : dataSet },
  module : { combining : 'rewrite' },
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

  init,
  copy,

  OptionsFrom,
  unform,
  form1,
  form3,

  open,
  // _openFromData,
  // _openFromFile,
  _openFrom,

  errorNotFound,
  resolve,

  isAvailableGet,
  isDownloadedGet,
  openedModuleSet,
  longPathGet,
  pathSet,
  dataGet,
  dataSet,
  moduleSet,

  dataExport,
  infoExport,

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
