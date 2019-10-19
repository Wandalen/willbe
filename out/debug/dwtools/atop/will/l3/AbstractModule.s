( function _AbstractModule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillAbstractModule( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractModule';

// --
// inter
// --

function finit()
{
  let module = this;
  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init()
{
  let module = this;

  module[ willfileWithRoleMapSymbol ] = Object.create( null );
  module[ willfileArraySymbol ] = [];
  module[ fileNameSymbol ] = null;

  module[ willfilesPathSymbol ] = null;
  // module[ dirPathSymbol ] = null;
  module[ commonPathSymbol ] = null;
  module[ willPathSymbol ] = _.path.join( __dirname, '../Exec' );

  _.workpiece.initFields( module );
  Object.preventExtensions( module );
  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;
}

// --
// etc
// --

function isUsedManually()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );

  // xxx yyy
  // if( !module.isAuto )
  // return true;

  let found = [];
  let sys = new _.graph.AbstractGraphSystem
  ({
    onNodeIs : nodeIs,
    onNodeNameGet : nodeName,
    onOutNodesGet : nodeOutNodes,
  });
  let group = sys.nodesGroup();

  group.each({ roots : [ module ], onUp });

  return found.length > 0;

  /* */

  function onUp( node )
  {
    if( node.isAuto )
    return;
    if( node === module )
    return;
    if( module instanceof _.Will.OpenedModule )
    if( node instanceof _.Will.OpenedModule )
    return;
    found.push( node );
  }

  /* */

  function nodeIs( node )
  {
    return _.instanceIs( node );
  }

  /* */

  function nodeName( node )
  {
    return node.qualifiedName;
  }

  /* */

  function nodeOutNodes( node )
  {
    if( !node.usersGet )
    return [];
    _.assert( _.routineIs( node.usersGet ) )
    return node.usersGet();
  }

}

//

function optionsFormingForward( o )
{
  let module = this;

  _.assert( arguments.length === 1 );
  o = _.mapSupplementStructureless( o, optionsFormingForward.defaults );

  if( _.boolLike( o.all ) )
  {
    o.all = !!o.all;
    if( o.attachedWillfilesFormed === null )
    o.attachedWillfilesFormed = o.all;
    if( o.peerModulesFormed === null )
    o.peerModulesFormed = o.all;
    if( o.subModulesFormed === null )
    o.subModulesFormed = o.all;
    if( o.resourcesFormed === null )
    o.resourcesFormed = o.all;
  }

  return o;
}

optionsFormingForward.defaults = _.mapExtend( null, _.Will.UpformingDefaults );

// --
// path
// --

function _filePathSet( willfilesPath )
{
  let module = this;
  let r = Object.create( null );
  r.willfilesPath = willfilesPath;
  return module._filePathChanged1( r ).willfilesPath;
}

//

function _filePathChanged1( o )
{
  let module = this;
  return module._filePathChanged2( o );
}

_filePathChanged1.defaults =
{
  willfilesPath : null,
  exWillfilesPath : null,
  isIdentical : null,
  dirPath : null,
  localPath : null,
  commonPath : null,
}

//

function _filePathChanged2( o )
{
  let module = this;

  if( !o )
  {
    o = Object.create( null );
    o.willfilesPath = module.willfilesPath;
    o.exWillfilesPath = _.unknown;
    o.isIdentical = false;
  }

  if( !o.exWillfilesPath )
  o.exWillfilesPath = module.willfilesPath;

  _.routineOptions( _filePathChanged2, o );

  if( _.arrayIs( o.willfilesPath ) )
  {
    if( o.willfilesPath.length === 1 )
    o.willfilesPath = o.willfilesPath[ 0 ];
    else if( o.willfilesPath.length === 0 )
    o.willfilesPath = null;
  }

  if( !this.will )
  return o;

  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( o.willfilesPath )
  o.willfilesPath = path.s.normalizeTolerant( o.willfilesPath );

  o.dirPath = o.willfilesPath;
  if( _.arrayIs( o.dirPath ) )
  o.dirPath = o.dirPath[ 0 ];
  if( _.strIs( o.dirPath ) )
  o.dirPath = path.dirFirst( o.dirPath );
  if( o.dirPath === null )
  o.dirPath = module.dirPath;
  if( o.dirPath )
  o.dirPath = path.canonize( o.dirPath );

  if( o.isIdentical === undefined || o.isIdentical === null )
  o.isIdentical = o.willfilesPath === this.willfilesPath || _.entityIdentical( path.simplify( o.willfilesPath ), path.simplify( this.willfilesPath ) );

  if( o.willfilesPath && o.willfilesPath.length )
  o.commonPath = _.Will.CommonPathFor( o.willfilesPath );
  else
  o.commonPath = module.commonPath;
  o.localPath = o.commonPath;

  _.assert( arguments.length === 1 );
  _.boolIs( o.isIdentical );
  _.assert( o.dirPath === null || _.strDefined( o.dirPath ) );
  _.assert( o.dirPath === null || path.isAbsolute( o.dirPath ) );
  _.assert( o.dirPath === null || path.isNormalized( o.dirPath ) );
  _.assert( o.willfilesPath === null || path.s.allAreAbsolute( o.willfilesPath ) );
  _.assert
  (
    !module.isPreformed() || _.strDefined( o.commonPath ),
    () => `Each module requires commonPath, but ${module.absoluteName} does not have`
  );

  if( o.commonPath !== null )
  module[ fileNameSymbol ] = path.fullName( o.commonPath );
  // module[ willfilesPathSymbol ] = o.willfilesPath;

  will._pathChanged
  ({
    object : module,
    fieldName : 'willfilesPath',
    val : o.willfilesPath,
    ex : o.exWillfilesPath,
    isIdentical : o.isIdentical,
    kind : 'set',
  });

  will._pathChanged
  ({
    object : module,
    fieldName : 'dirPath',
    val : o.dirPath,
    ex : module.dirPath,
    kind : 'set',
  });

  will._pathChanged
  ({
    object : module,
    fieldName : 'commonPath',
    val : o.commonPath,
    ex : module.commonPath,
    kind : 'set',
  });

  will._pathChanged
  ({
    object : module,
    fieldName : 'localPath',
    val : o.localPath,
    ex : module.localPath,
    kind : 'set',
  });

  return o;
}

_filePathChanged2.defaults = _.mapExtend( null, _filePathChanged1.defaults );

//
// //
//
// function _filePathChanged2()
// {
//   let module = this;
//
//   _.assert( arguments.length === 0 );
//
//   module._filePathSet( module.willfilesPath );
//
// }

// --
// name
// --

function qualifiedNameGet()
{
  let module = this;
  let name = module.name;
  return 'module' + '::' + name;
}

//

function decoratedQualifiedNameGet()
{
  let module = this;
  let result = module.qualifiedName;
  return _.color.strFormat( result, 'entity' );
}

//

function decoratedAbsoluteNameGet()
{
  let module = this;
  let result = module.absoluteName;
  return _.color.strFormat( result, 'entity' );
}

// --
// willfile
// --

function willfileArraySet( willfilesArray )
{
  let module = this;
  _.assert( _.arrayIs( willfilesArray ) );

  if( module.willfilesArray === willfilesArray )
  return module.willfilesArray;

  for( let w = module.willfilesArray.length-1 ; w >= 0 ; w-- )
  {
    let willf = module.willfilesArray[ w ];
    module.willfileUnregister( willf );
  }

  for( let w = 0 ; w < willfilesArray.length ; w++ )
  {
    let willf = willfilesArray[ w ];
    module.willfileRegister( willf );
  }

  return module.willfilesArray;
}

//

function willfileUnregister( willf )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayRemoveElementOnceStrictly( module.willfilesArray, willf );

  if( willf.role )
  {
    _.each( willf.role, ( role ) =>
    {
      _.assert( module.willfileWithRoleMap[ role ] === willf )
      delete module.willfileWithRoleMap[ role ];
    });
  }

  let willfilesPath = _.arrayFlatten( _.select( module.willfilesArray, '*/filePath' ) );
  module.willfilesPath = willfilesPath;

}

//

function willfileRegister( willf )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  // if( module.id === 238 )
  // debugger;

  if( _.arrayIs( willf ) )
  {
    debugger;
    willf.forEach( ( willf ) => module.willfileRegister( willf ) );
    return;
  }

  _.arrayAppendOnce( module.willfilesArray, willf );

  if( willf.role )
  {
    _.each( willf.role, ( role ) =>
    {
      _.assert( !module.willfileWithRoleMap[ role ] || module.willfileWithRoleMap[ role ] === willf, 'Module already has willfile with role', role )
      module.willfileWithRoleMap[ role ] = willf;
    });
  }

  _.assert( !!module.willfilesArray.length );

  let willfilesPath = _.arrayFlatten( _.select( module.willfilesArray, '*/filePath' ) );
  module.willfilesPath = willfilesPath;

  module.isOut = _.any( module.willfilesArray, ( wfile ) => wfile.isOut );

}

//

function willfileAttach( filePath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( filePath ) );

  let o2 = Object.create( null );
  o2.filePath = filePath;

  // debugger;
  let got = will.willfileFor({ willf : o2, combining : 'supplement' });
  // debugger;

  // got.willf._read();
  // got.willf._open();

  // _.assert( !!got.willf.data );
  // _.assert( !!got.willf.structure );

  module.willfileRegister( got.willf );

  // debugger;
  return got.willf;
}

//

function _willfilesRelease( willfilesArray )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  willfilesArray = willfilesArray || module.willfilesArray;
  willfilesArray = willfilesArray.slice();

  for( let i = willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = willfilesArray[ i ];
    module.willfileUnregister( willf );
    _.assert( !willf.finitedIs() );
    if( !willf.isUsed() )
    willf.finit();
  }

}

// --
// remote
// --

function remoteIsReform()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  if( !module.superRelation )
  return end( false );

  let remotePath = module.remotePath ? path.common( module.remotePath ) : module.commonPath;
  let remoteProvider = fileProvider.providerForPath( remotePath );
  if( remoteProvider.isVcs )
  return end( true );

  return end( false );

  /* */

  function end( result )
  {
    module.isRemote = result;
    return result;
  }
}

//

function remoteIsUpToDateReform()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.downloadPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( module.remotePath );

  _.assert( !!remoteProvider.isVcs );

  let result = remoteProvider.isUpToDate
  ({
    remotePath : module.remotePath,
    localPath : module.downloadPath,
    verbosity : will.verbosity - 3,
  });

  // if( !result )
  // return end( result );

  return _.Consequence.From( result )
  .finally( ( err, arg ) =>
  {
    end( arg );
    if( err )
    throw err;
    return arg;
  });

  /* */

  function end( result )
  {
    module.isUpToDate = !!result;
    return result;
  }

}

//

function remoteLocalVersion()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( module.commonPath );
  debugger;
  return remoteProvider.versionLocalRetrive( module.downloadPath );
}

//

function remoteLatestVersion()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( module.commonPath );
  debugger;
  return remoteProvider.versionRemoteLatestRetrive( module.downloadPath )
}

//

function remoteHasLocalChanges()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  // let remoteProvider = fileProvider.providerForPath( module.remotePath );
  // return remoteProvider.hasLocalChanges( module.downloadPath );
  return _.git.hasLocalChanges({ localPath : module.downloadPath, unpushed : 0 });
}

// --
// relations
// --

let willfileWithRoleMapSymbol = Symbol.for( 'willfileWithRoleMap' );
let willfileArraySymbol = Symbol.for( 'willfilesArray' );
let fileNameSymbol = Symbol.for( 'fileName' );

let willfilesPathSymbol = Symbol.for( 'willfilesPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let willPathSymbol = Symbol.for( 'willPath' );

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  will : null,
  peerModule : null,
}

let Medials =
{
}

let Restricts =
{

  id : null,

}

let Statics =
{

}

let Forbids =
{

  mainOpener : 'mainOpener',
  exportMap : 'exportMap',
  exported : 'exported',
  export : 'export',
  downloaded : 'downloaded',
  formReady : 'formReady',
  filePath : 'filePath',
  errors : 'errors',
  associatedSubmodule : 'associatedSubmodule',
  execution : 'execution',
  allModuleMap : 'allModuleMap',
  opener : 'opener',
  Counter : 'Counter',
  moduleWithCommonPathMap : 'moduleWithCommonPathMap',
  supermoduleSubmodule : 'supermoduleSubmodule',
  configName : 'configName',
  superModules : 'superModules',
  willfilePath : 'willfilePath',
  isGitRepository : 'isGitRepository',

}

let Accessors =
{

  qualifiedName : { getter : qualifiedNameGet, combining : 'rewrite', readOnly : 1 },
  fileName : { readOnly : 1 },
  decoratedQualifiedName : { getter : decoratedQualifiedNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },

  willfilesArray : { setter : willfileArraySet },
  willfileWithRoleMap : { readOnly : 1 },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,

  // etc

  isUsedManually,
  optionsFormingForward,

  // path

  _filePathSet,
  _filePathChanged1,
  _filePathChanged2,

  // name

  qualifiedNameGet,
  decoratedQualifiedNameGet,
  decoratedAbsoluteNameGet,

  // willfile

  willfileArraySet,
  willfileUnregister,
  willfileRegister,
  willfileAttach,

  _willfilesRelease,

  // remote

  remoteIsReform,
  remoteIsUpToDateReform,
  remoteLocalVersion,
  remoteLatestVersion,
  remoteHasLocalChanges,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
