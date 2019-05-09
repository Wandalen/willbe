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

  if( !submodule.original && rootModule.allModuleMap[ submodule.path ] )
  {
    _.assert( rootModule.allModuleMap[ submodule.path ] === submodule.loadedModule );
    delete rootModule.allModuleMap[ submodule.path ];
  }

  if( submodule.loadedModule )
  {
    // _.arrayRemoveOnceStrictly( submodule.loadedModule.associatedSubmodules, submodule );
    submodule.loadedModule = null;
  }

  return Parent.prototype.unform.call( submodule );
}

//

function form1()
{
  let submodule = this;

  _.assert( !!submodule.module );

  let rootModule = submodule.module.rootModule;
  let willf = submodule.willf;
  let will = rootModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  /* begin */

  _.assert( !!submodule.module );
  // let module = submodule.module;
  // let rootModule = module.rootModule;
  if( submodule.loadedModule )
  {
    _.assert( rootModule.allModuleMap[ submodule.path ] === submodule.loadedModule || rootModule.allModuleMap[ submodule.path ] === undefined );
    rootModule.allModuleMap[ submodule.path ] = submodule.loadedModule;
  }

  // debugger;
  // if( !submodule.original )
  // {
  //   rootModule.allModuleMap[ submodule.path ] = submodule;
  // }

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
    if( submodule.loadedModule && submodule.loadedModule.hasAnyError() )
    {
      // debugger;
      // _.arrayRemoveOnceStrictly( submodule.loadedModule.associatedSubmodules, submodule );
      let loadedModule = submodule.loadedModule;
      submodule.loadedModule = null;
      _.assert( loadedModule.associatedSubmodules.length === 0 );
      loadedModule.finit();
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

  if( !module.supermodule )
  result = submodule._load();

  /* end */

  submodule.formed = 3;
  return result;
}

//

function _load()
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
  _.assert( submodule.loadedModule === null );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.assert( !submodule.original );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  if( rootModule.allModuleMap[ submodule.path ] )
  {
    debugger;
    submodule.loadedModule = rootModule.allModuleMap[ submodule.path ];
    return submodule.loadedModule.ready.split()
  }

  if( submodule.data )
  {
    _.assert( 0, 'not implemented' );
    submodule.data = null;
  }

  /* */

  // debugger;
  submodule.loadedModule = will.Module
  ({
    will : will,
    alias : submodule.name,
    willFilesPath : path.join( module.inPath, submodule.path ),
    supermodule : module,
    // associatedSubmodules : [ submodule ],
  }).preform();
  // debugger;

  // rootModule.allModuleMap[ submodule.path ] = submodule.loadedModule;

  submodule.loadedModule.willFilesFind({ isOutFile : 1 });
  submodule.loadedModule.willFilesOpen();
  submodule.loadedModule.submodulesFormSkip();
  submodule.loadedModule.resourcesFormSkip();
  // submodule.loadedModule.resourcesForm(); // yyy

  submodule.loadedModule.willFilesFindReady.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( 'Failed to open', submodule.nickName, 'at', _.strQuote( submodule.loadedModule.dirPath ), '\n', err );
    return arg;
  });

  submodule.loadedModule.ready.finally( ( err, arg ) =>
  {
    if( err )
    {
      if( rootModule.allModuleMap[ submodule.path ] === submodule.loadedModule )
      {
        delete rootModule.allModuleMap[ submodule.path ]
      }
      if( will.verbosity >= 3 )
      logger.error( ' ! Failed to read ' + submodule.decoratedNickName + ', try to download it with ' + _.color.strFormat( '.submodules.download', 'code' ) + ' or even ' + _.color.strFormat( '.clean', 'code' ) + ' it before downloading' );
      if( will.verbosity >= 5 || !submodule.loadedModule || submodule.loadedModule.isOpened() )
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

  return submodule.loadedModule.ready.split().finally( ( err, arg ) =>
  {
    return null;
  });

}

//

function resolve_body( o )
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let module2 = submodule.loadedModule || module;

  _.assert( arguments.length === 1 );
  _.assert( o.currentContext === null || o.currentContext === submodule )

  o.currentContext = submodule;

  let resolved = module2.resolve.body.call( module2, o );

  return resolved;
}

_.routineExtend( resolve_body, _.Will.Resource.prototype.resolve.body );
let resolve = _.routineFromPreAndBody( _.Will.Resource.prototype.resolve.pre, resolve_body );

//

function isDownloadedGet()
{
  let submodule = this;
  let module = submodule.module;

  if( !submodule.loadedModule )
  return false;

  return submodule.loadedModule.isDownloaded;
}

//

function loadedModuleSet( loadedModule )
{
  let submodule = this;

  if( loadedModule === submodule[ loadedModuleSymbol ] )
  return;

  if( submodule[ loadedModuleSymbol ] )
  _.arrayRemoveOnceStrictly( submodule[ loadedModuleSymbol ].associatedSubmodules, submodule );
  submodule[ loadedModuleSymbol ] = null;

  if( loadedModule )
  {

    // debugger;
    // _.assert( !!submodule.module );
    // let module = submodule.module;
    // let rootModule = module.rootModule;
    // _.assert( rootModule.allModuleMap[ submodule.path ] === loadedModule || rootModule.allModuleMap[ submodule.path ] === undefined );
    // rootModule.allModuleMap[ submodule.path ] = loadedModule;

    _.arrayAppendOnceStrictly( loadedModule.associatedSubmodules, submodule );
    submodule[ loadedModuleSymbol ] = loadedModule;

  }

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

function dataExport()
{
  let submodule = this;
  let module = submodule.module;
  let willf = submodule.willf;
  let will = module.will;

  let result = Parent.prototype.dataExport.apply( this, arguments );

  if( result === undefined )
  return result;

  // if( 0 )
  if( submodule.loadedModule && !submodule.loadedModule.hasAnyError() )
  {
    debugger;
    _.assert( submodule.data === null, 'not tested' );
    if( submodule.data )
    result.data = submodule.data;
    result.data = submodule.loadedModule.dataExport();
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

  if( submodule.loadedModule )
  {
    let module2 = submodule.loadedModule;
    resultMap.remote = module2.remotePath;
    resultMap.local = module2.localPath;

    resultMap[ 'Exported builds' ] = _.toStr( _.mapKeys( module2.exportedMap ) );

  }

  resultMap.isDownloaded = submodule.isDownloaded;

  let result = submodule._infoExport( resultMap );

  // if( result )
  // result += '\n';
  // result += tab + 'isDownloaded : ' + _.toStr( submodule.isDownloaded );
  //
  //
  // if( submodule.loadedModule )
  // {
  //   let module2 = submodule.loadedModule
  //
  //   result = tab + 'remote : ' + module2.remotePath + '\n' + result;
  //   result = tab + 'local : ' + module2.localPath + '\n' + result;
  //
  //   result += '\n' + tab + 'Exported builds : ' + _.toStr( _.mapKeys( module2.exportedMap ) );
  // }

  return result;
}

// --
// relations
// --

let loadedModuleSymbol = Symbol.for( 'loadedModule' );
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
  loadedModule : null,
}

let Associates =
{
}

let Restricts =
{
  data : null,
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
  isDownloaded : { getter : isDownloadedGet, readOnly : 1 },
  loadedModule : { setter : loadedModuleSet },
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

  _load,

  resolve,

  isDownloadedGet,
  loadedModuleSet,
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
