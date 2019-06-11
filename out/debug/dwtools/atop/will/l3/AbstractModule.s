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
  return _.instanceConstructor( Self, this, arguments );
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
  _.instanceInit( module );
  Object.preventExtensions( module );
  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;
}

// --
// path
// --

function WillfilePathIs( filePath )
{
  let fname = _.path.fullName( filePath );
  let r = /\.will\.\w+/;
  if( _.strHas( fname, r ) )
  return true;
  return false;
}

//

function DirPathFromFilePaths( filePaths )
{
  let module = this;

  filePaths = _.arrayAs( filePaths );

  _.assert( _.strsAreAll( filePaths ) );
  _.assert( arguments.length === 1 );

  filePaths = filePaths.map( ( filePath ) =>
  {
    filePath = _.path.normalizeTolerant( filePath );

    let r1 = /(.*)(?:\.will(?:\.|$))[^\/]*$/;
    let parsed1 = r1.exec( filePath );
    if( parsed1 )
    filePath = parsed1[ 1 ];

    let r2 = /(.*)(?:\.(?:im|ex)(?:\.|$))[^\/]*$/;
    let parsed2 = r2.exec( filePath );
    if( parsed2 )
    filePath = parsed2[ 1 ];

    // if( parsed1 || parsed2 )
    // if( _.strEnds( filePath, '/' ) )
    // filePath = filePath + '.';

    return filePath;
  });

  let filePath = _.strCommonLeft.apply( _, _.arrayAs( filePaths ) );
  _.assert( filePath.length > 0 );
  return filePath;
}

//

function prefixPathForRole( role )
{
  let module = this;
  let result = module.prefixPathForRoleMaybe( role );

  _.assert( arguments.length === 1 );
  _.sure( _.strIs( result ), 'Unknown role', _.strQuote( role ) );

  return result;
}

//

function prefixPathForRoleMaybe( role )
{
  let module = this;

  _.assert( arguments.length === 1 );

  if( role === 'import' )
  return '.im.will';
  else if( role === 'export' )
  return '.ex.will';
  else if( role === 'single' )
  return '.will';
  else return null;

}

// //
//
// function cloneDirPathGet()
// {
//   let module = this;
//   let will = module.will;
//   let inPath = module.rootModule.inPath;
//   _.assert( arguments.length === 0 );
//   return module.CloneDirPathFor( inPath );
// }

//

function CloneDirPathFor( inPath )
{
  _.assert( arguments.length === 1 );
  return _.path.join( inPath, '.module' );
}

//

function outfilePathGet()
{
  let module = this;
  let will = module.will;
  _.assert( arguments.length === 0 );
  return module.OutfilePathFor( module.outPath, module.about.name );
}

//

function OutfilePathFor( outPath, name )
{
  _.assert( arguments.length === 2 );
  _.assert( _.path.isAbsolute( outPath ), 'Expects absolute path outPath' );
  _.assert( _.strDefined( name ), 'Module should have name, declare about::name' );
  name = _.strJoinPath( [ name, '.out.will.yml' ], '.' );
  return _.path.join( outPath, name );
}

//

function _filePathChange( willfilesPath, dirPath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let commonPath = module.commonPath;
  // let rootModule = module.rootModule;

  module.modulePathUnregister();

  if( willfilesPath )
  willfilesPath = path.s.normalizeTolerant( willfilesPath );
  if( dirPath )
  dirPath = path.normalize( dirPath );

  _.assert( arguments.length === 2 );
  _.assert( dirPath === null || _.strDefined( dirPath ) );
  _.assert( dirPath === null || path.isAbsolute( dirPath ) );
  _.assert( dirPath === null || path.isNormalized( dirPath ) );
  _.assert( willfilesPath === null || path.s.allAreAbsolute( willfilesPath ) );

  module.willfilesPath = willfilesPath;
  module._dirPathChange( dirPath );

  if( !module.remotePath || ( _.arrayIs( module.remotePath ) && module.remotePath.length === 0 ) )
  if( !path.isGlobal( dirPath ) )
  {
    // debugger;
    // module.localPath = dirPath;
  }

  module.modulePathRegister();

  return module;
}

//

function _filePathChanged()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  let dirPath = module.willfilesPath;
  if( _.arrayIs( dirPath ) )
  dirPath = dirPath[ 0 ];
  if( _.strIs( dirPath ) )
  dirPath = path.dir( dirPath );
  if( dirPath === null )
  dirPath = module.dirPath;

  module._filePathChange( module.willfilesPath, dirPath );

}

//

function inPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.s.join( module.dirPath, ( module.pathMap.in || '.' ) );
}

//

function outPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.s.join( module.dirPath, ( module.pathMap.in || '.' ), ( module.pathMap.out || '.' ) );
}

// //
//
// function commonPathGet()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   let willfilesPath = module.willfilesPath ? module.willfilesPath : module.dirPath;
//
//   if( !willfilesPath )
//   return null;
//
//   let common = module.CommonPathFor( willfilesPath );
//
//   return common;
// }

//

function CommonPathFor( willfilesPath )
{
  return _.Will.CommonPathFor.apply( _.Will, arguments );
  // if( _.arrayIs( willfilesPath ) )
  // willfilesPath = willfilesPath[ 0 ];
  //
  // _.assert( arguments.length === 1 );
  // _.assert( _.strIs( willfilesPath ) );
  //
  // let common = willfilesPath.replace( /\.will\.\w+$/, '' );
  //
  // common = common.replace( /(\.im|\.ex)$/, '' );
  //
  // return common;
}

// //
//
// function predefinedPathGet_functor( fieldName, resourceName )
// {
//
//   return function predefinedPathGet()
//   {
//     let module = this;
//
//     if( !module.will)
//     return null;
//
//     return module.pathMap[ resourceName ] || null;
//   }
//
// }
//
// //
//
// function predefinedPathSet_functor( fieldName, resourceName )
// {
//
//   return function predefinedPathSet( filePath )
//   {
//     let module = this;
//
//     // if( fieldName === 'willfilesPath' )
//     // debugger;
//
//     if( !module.will && !filePath )
//     return filePath;
//
//     if( !module.pathResourceMap[ resourceName ] )
//     {
//       let resource = new _.Will.PathResource({ module : module, name : resourceName }).form1();
//       resource.criterion = resource.criterion || Object.create( null );
//       resource.criterion.predefined = 1;
//       resource.writable = 0;
//     }
//
//     _.assert( !!module.pathResourceMap[ resourceName ] );
//
//     module.pathResourceMap[ resourceName ].path = filePath;
//
//     return filePath;
//   }
//
// }
//
// let willfilesPathGet = predefinedPathGet_functor( 'willfilesPath', 'module.willfiles' );
// let dirPathGet = predefinedPathGet_functor( 'dirPath', 'module.dir' );
// let localPathGet = predefinedPathGet_functor( 'localPath', 'local' );
// let remotePathGet = predefinedPathGet_functor( 'remotePath', 'remote' );
// let currentRemotePathGet = predefinedPathGet_functor( 'currentRemotePath', 'current.remote' );
// let willPathGet = predefinedPathGet_functor( 'willPath', 'will' );
//
// let willfilesPathSet = predefinedPathSet_functor( 'willfilesPath', 'module.willfiles' );
// let _dirPathChange = predefinedPathSet_functor( 'dirPath', 'module.dir' );
// let localPathSet = predefinedPathSet_functor( 'localPath', 'local' );
// let remotePathSet = predefinedPathSet_functor( 'remotePath', 'remote' );

// --
// name
// --

function nickNameGet()
{
  let module = this;
  let name = module.name;
  return 'module' + '::' + name;
}

//

function decoratedNickNameGet()
{
  let module = this;
  let result = module.nickName;
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
// relations
// --

let functionSymbol = Symbol.for( 'function' );
let isDownloadedSymbol = Symbol.for( 'isDownloaded' );
let aliasSymbol = Symbol.for( 'aliasName' );
let dirPathSymbol = Symbol.for( 'dirPath' );

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  will : null,
}

let Medials =
{
}

let Restricts =
{

  id : null,
  userArray : _.define.own([]),

}

let Statics =
{

  WillfilePathIs,
  DirPathFromFilePaths,
  CommonPathFor,
  CloneDirPathFor,
  OutfilePathFor,

}

let Forbids =
{

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
  oModule : 'oModule',
  Counter : 'Counter',
  moduleWithPathMap : 'moduleWithPathMap',

}

let Accessors =
{

  nickName : { getter : nickNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedNickName : { getter : decoratedNickNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },

}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,

  // path

  WillfilePathIs,
  DirPathFromFilePaths,
  prefixPathForRole,
  prefixPathForRoleMaybe,

  // commonPathGet,
  CommonPathFor,
  // cloneDirPathGet,
  CloneDirPathFor,
  outfilePathGet,
  OutfilePathFor,

  // name

  nickNameGet,
  decoratedNickNameGet,
  decoratedAbsoluteNameGet,

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
  extend : Proto,
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
