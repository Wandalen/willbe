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
  let rootModule = module.rootModule;

  // debugger;
  // if( !submodule.original && rootModule.allModuleMap[ submodule.longPath ] )
  // {
  //   debugger;
  //   _.assert( rootModule.allModuleMap[ submodule.longPath ] === submodule.openedModule );
  //   delete rootModule.allModuleMap[ submodule.longPath ];
  // }

  if( submodule.openedModule )
  {
    submodule.openedModule = null;
  }

  return Parent.prototype.unform.call( submodule );
}

//

function form1()
{
  let submodule = this;

  _.assert( !!submodule.module );

  let module = submodule.module;
  let rootModule = submodule.module.rootModule;
  let willf = submodule.willf;
  let will = rootModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  /* begin */

  _.assert( !!submodule.module );

  // if( submodule.openedModule )
  // {
  //   _.assert( rootModule.allModuleMap[ submodule.longPath ] === submodule.openedModule || rootModule.allModuleMap[ submodule.longPath ] === undefined );
  //   rootModule.allModuleMap[ submodule.longPath ] = submodule.openedModule;
  // }

  rootModule.submoduleRegister( submodule );

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
    if( submodule.openedModule && !submodule.openedModule.isValid() )
    {
      let openedModule = submodule.openedModule;
      submodule.openedModule = null;
      _.assert( openedModule.submoduleAssociation.length === 0 );
      openedModule.finit();
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

  // if( !module.supermodule )
  result = submodule.open();

  result.tap( ( err, arg ) =>
  {
    // module.submoduleRegister( submodule, submodule.name );
    // module.rootModule.submoduleRegister( submodule );
    submodule.formed = 3;
  });

  /* end */

  // submodule.formed = 3;
  return result;
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
  _.assert( submodule.openedModule === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  let longPath = submodule.longPath;
  let openedModule = rootModule.moduleAt( longPath );
  if( openedModule )
  {
    submodule.openedModule = openedModule;
    return submodule.openedModule.ready.split();
  }

  // if( submodule.data )
  // {
  //   submodule._openFromData( submodule.data, longPath );
  // }
  // else
  // {
  //   submodule._openFromFile( longPath );
  // }

  submodule._openFrom
  ({
    longPath : longPath,
    data : submodule.data,
  });

  submodule.openedModule.ready.finally( ( err, arg ) =>
  {
    if( err )
    {
      debugger;
      // _.errLogOnce( err );
      if( will.verbosity >= 3 )
      logger.error( ' ! Failed to read ' + submodule.decoratedNickName + ', try to download it with ' + _.color.strFormat( '.submodules.download', 'code' ) + ' or even ' + _.color.strFormat( '.clean', 'code' ) + ' it before downloading' );
      if( will.verbosity >= 5 || !submodule.openedModule || submodule.openedModule.isOpened() )
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
      throw err;
    }
    else
    {
    }
    return arg || null;
  });

  /* */

  return submodule.openedModule.ready.split().finally( ( err, arg ) =>
  {
    return null;
  });

}

// //
//
// function _openFromData( data, longPath )
// {
//   let submodule = this;
//   let module = submodule.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let rootModule = module.rootModule;
//
//   _.assert( arguments.length === 2 );
//   _.assert( submodule.formed === 2 );
//   _.assert( submodule.openedModule === null );
//   _.assert( _.strIs( submodule.path ), 'not tested' );
//   _.assert( !submodule.original );
//   _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );
//   _.assert( !rootModule.moduleAt( submodule.longPath ) );
//
//   /* */
//
//   submodule.openedModule = will.Module
//   ({
//     will : will,
//     aliasName : submodule.name,
//     willfilesPath : longPath,
//     pickedWillfilesPath : longPath,
//     pickedWillfileData : data,
//     supermodule : module,
//   }).preform();
//
//   if( module.stager.stageStateSkipping( 'willfilesFound' ) )
//   submodule.openedModule.stager.stageStateSkipping( 'willfilesFound', 1 );
//   if( module.stager.stageStateSkipping( 'willfilesOpened' ) )
//   submodule.openedModule.stager.stageStateSkipping( 'willfilesOpened', 1 );
//
//   submodule.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
//   submodule.openedModule.willfilesFind();
//
//   submodule.openedModule.willfilesFindReady.finally( ( err, arg ) =>
//   {
//     if( err )
//     throw _.err( 'Failed to open', submodule.nickName, 'at', _.strQuote( submodule.openedModule.dirPath ), '\n', err );
//     return arg;
//   });
//
//   /* */
//
// }
//
// //
//
// function _openFromFile( longPath )
// {
//   let submodule = this;
//   let module = submodule.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let rootModule = module.rootModule;
//
//   _.assert( arguments.length === 1 );
//   _.assert( submodule.formed === 2 );
//   _.assert( submodule.openedModule === null );
//   _.assert( _.strIs( submodule.path ), 'not tested' );
//   _.assert( !submodule.original );
//   _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );
//   _.assert( !submodule.data );
//   _.assert( !rootModule.moduleAt( submodule.longPath ) );
//
//   /* */
//
//   submodule.openedModule = will.Module
//   ({
//     will : will,
//     aliasName : submodule.name,
//     willfilesPath : longPath,
//     supermodule : module,
//   }).preform();
//
//   submodule.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
//   submodule.openedModule.willfilesFind();
//
//   submodule.openedModule.willfilesFindReady.finally( ( err, arg ) =>
//   {
//     if( err )
//     throw _.err( 'Failed to open', submodule.nickName, 'at', _.strQuote( submodule.openedModule.dirPath ), '\n', err );
//     return arg;
//   });
//
//   /* */
//
//   return submodule.openedModule;
// }
//
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
  _.assert( submodule.openedModule === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );
  _.assert( !submodule.data );
  _.assert( !rootModule.moduleAt( submodule.longPath ) );

  /* */

  submodule.openedModule = will.Module
  ({
    will : will,
    aliasName : submodule.name,
    willfilesPath : o.longPath,
    supermodule : module,
    pickedWillfilesPath : o.data ? o.longPath : null,
    pickedWillfileData : o.data,
  }).preform();

  // submodule.openedModule = will.Module
  // ({
  //   will : will,
  //   aliasName : submodule.name,
  //   willfilesPath : o.longPath,
  //   supermodule : module,
  //   pickedWillfilesPath : o.longPath,
  //   pickedWillfileData : data,
  // }).preform();

  if( module.stager.stageStateSkipping( 'willfilesFound' ) )
  submodule.openedModule.stager.stageStateSkipping( 'willfilesFound', 1 );
  if( module.stager.stageStateSkipping( 'willfilesOpened' ) )
  submodule.openedModule.stager.stageStateSkipping( 'willfilesOpened', 1 );

  submodule.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
  submodule.openedModule.stager.stageStatePausing( 'willfilesFound', 0 );
  submodule.openedModule.stager.tick();

  // submodule.openedModule.willfilesFind();

  submodule.openedModule.willfilesFindReady.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( 'Failed to open', submodule.nickName, 'at', _.strQuote( submodule.openedModule.dirPath ), '\n', err );
    return arg;
  });

  /* */

  return submodule.openedModule;
}

_openFrom.defaults =
{
  data : null,
  longPath : null,
}

//

function resolve_body( o )
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let module2 = submodule.openedModule || module;

  _.assert( arguments.length === 1 );
  _.assert( o.currentContext === null || o.currentContext === submodule )

  o.currentContext = submodule;

  let resolved = module2.resolve.body.call( module2, o );

  return resolved;
}

_.routineExtend( resolve_body, _.Will.Resource.prototype.resolve.body );
let resolve = _.routineFromPreAndBody( _.Will.Resource.prototype.resolve.pre, resolve_body );

//

function isAvailableGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.openedModule )
  return false;

  if( !submodule.openedModule.isDownloaded )
  return false;

  if( !submodule.openedModule.isOpened() )
  return false;

  if( !submodule.openedModule.isValid() )
  return false;

  return true;
}

//

function isDownloadedGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.openedModule )
  return false;

  return submodule.openedModule.isDownloaded;
}

//

function openedModuleSet( openedModule )
{
  let submodule = this;

  if( openedModule === submodule[ openedModuleSymbol ] )
  return;

  if( submodule[ openedModuleSymbol ] )
  _.arrayRemoveOnceStrictly( submodule[ openedModuleSymbol ].submoduleAssociation, submodule );
  submodule[ openedModuleSymbol ] = null;

  if( openedModule )
  {

    _.arrayAppendOnceStrictly( openedModule.submoduleAssociation, submodule );
    submodule[ openedModuleSymbol ] = openedModule;

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
    else if( submodule.openedModule && submodule.openedModule.isValid() )
    {
      result.data = submodule.openedModule.dataExport();
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

  debugger;

  if( submodule.openedModule )
  {
    let module2 = submodule.openedModule;
    resultMap.remote = module2.remotePath;
    resultMap.local = module2.localPath;

    resultMap[ 'Exported builds' ] = _.toStr( _.mapKeys( module2.exportedMap ) );

  }

  resultMap.isDownloaded = submodule.isDownloaded;
  resultMap.isAvailable = submodule.isAvailable;

  let result = submodule._infoExport( resultMap );

  return result;
}

// --
// relations
// --

let openedModuleSymbol = Symbol.for( 'openedModule' );
let dataSymbol = Symbol.for( 'data' );

let Composes =
{

  own : 1,
  description : null,
  criterion : null,
  inherit : _.define.own([]),
  path : null,

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
  openedModule : null,
}

let Medials =
{
  data : null,
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
  openedModule : { setter : openedModuleSet },
  longPath : { getter : longPathGet },
  data : { getter : dataGet, setter : dataSet },
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  copy,

  OptionsFrom,
  unform,
  form1,
  form3,

  open,
  // _openFromData,
  // _openFromFile,
  _openFrom,

  resolve,

  isAvailableGet,
  isDownloadedGet,
  openedModuleSet,
  longPathGet,
  dataGet,
  dataSet,

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
  extend : Proto,
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
