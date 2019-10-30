( function _AbstractModule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = _global_.wTools;
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
  module[ commonPathSymbol ] = null;
  module[ willPathSymbol ] = _.path.join( __dirname, '../Exec' );

  // module.statusInvalidate({ all : 1 });

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

  o.localPath = null;
  if( !path.isGlobal( o.commonPath ) )
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

// // --
// // remote
// // --
//
// // function submodulesVerify( o )
// // {
// //   let module = this;
// //   let will = module.will;
// //   let fileProvider = will.fileProvider;
// //   let path = fileProvider.path;
// //   let logger = will.logger;
// //   let totalNumber = _.mapKeys( module.submoduleMap ).length;
// //   let verifiedNumber = 0;
// //   let time = _.timeNow();
// //
// //   _.assert( module.preformed > 0  );
// //   _.assert( arguments.length === 1 );
// //
// //   _.routineOptions( submodulesVerify, o );
// //
// //   logger.up();
// //
// //   let modules = module.modulesEach({ outputFormat : '/', recursive : o.recursive, withDisabledStem : 1 });
// //   let ready = new _.Consequence().take( null );
// //
// //   _.each( modules, ( r ) =>
// //   {
// //     ready.then( () => reform( r ) )
// //     ready.then( onEach );
// //     ready.then( onEachEnd );
// //   })
// //
// //   ready.then( () =>
// //   {
// //     if( o.asMap )
// //     return { verifiedNumber, totalNumber };
// //
// //     logger.log( verifiedNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedQualifiedName + ' were verified in ' + _.timeSpent( time ) );
// //     logger.down();
// //     return verifiedNumber === totalNumber;
// //   })
// //
// //   return ready;
// //
// //   /* */
// //
// //   function onEach( r )
// //   {
// //     if( o.hasFiles )
// //     if( !r.opener.isRepository )
// //     {
// //       if( o.throwing )
// //       throw _.errBrief( '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'does not have files' );
// //       return false;
// //     }
// //
// //     _.assert
// //     (
// //       !!r.opener && r.opener.formed >= 2,
// //       () => 'Submodule', ( r.opener ? r.opener.qualifiedName : n ), 'was not preformed to verify'
// //     );
// //
// //     /* isValid */
// //
// //     if( o.isValid )
// //     if( !r.opener.isValid() )
// //     throw _.err( opener.error, '\n! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'is downloaded, but it\'s not valid.' );
// //
// //     /* is remote / enabled */
// //
// //     if( !r.opener.isRemote )
// //     return true;
// //     if( r.relation && !r.relation.enabled )
// //     return true;
// //
// //     /* repository check */
// //
// //     if( o.isRepository )
// //     if( !r.opener.isRepository )
// //     {
// //       if( o.throwing )
// //       throw _.errBrief( '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), `is downloaded, but it's not a repository` );
// //       return false;
// //     }
// //
// //     let remoteProvider = will.fileProvider.providerForPath( r.opener.remotePath );
// //
// //     /* origin check */
// //
// //     if( o.hasRemote )
// //     {
// //       let result = remoteProvider.hasRemote
// //       ({
// //         localPath : r.opener.downloadPath,
// //         remotePath : r.opener.remotePath
// //       });
// //
// //       if( !result.hasRemote )
// //       {
// //         if( o.throwing )
// //         throw _.errBrief
// //         (
// //           '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'has different origin url:',
// //           _.color.strFormat( result.originVcsPath, 'path' ), ', expected url:', _.color.strFormat( result.remoteVcsPath, 'path' )
// //         );
// //
// //         return false;
// //       }
// //     }
// //
// //     /* version check */
// //
// //     if( o.isUpToDate )
// //     {
// //       if( r.opener.isUpToDate )
// //       return true;
// //
// //       if( !o.throwing )
// //       return false;
// //
// //       let remoteParsed = remoteProvider.pathParse( r.opener.remotePath );
// //       let remoteVersion = remoteParsed.hash || 'master';
// //       let localVersion = remoteProvider.versionLocalRetrive( r.opener.downloadPath );
// //
// //       if( remoteVersion === localVersion )
// //       throw _.errBrief( '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'is not up to date!' );
// //
// //       throw _.errBrief
// //       (
// //         '! Submodule', ( r.relation ? r.relation.qualifiedName : r.module.qualifiedName ), 'has version different from that is specified in will-file!',
// //         '\nCurrent:', localVersion,
// //         '\nExpected:', remoteVersion
// //       );
// //
// //       return false;
// //     }
// //
// //     return true;
// //
// //   }
// //
// //   /*  */
// //
// //   function onEachEnd( verified )
// //   {
// //     if( verified )
// //     verifiedNumber += 1;
// //     return verified;
// //   }
// //
// //   /*  */
// //
// //   function reform( relation )
// //   {
// //     let con = new _.Consequence().take( null );
// //     con.then( () => relation.opener.preform() )
// //     con.then( () => relation.opener.repoIsDownloadedReform() )
// //     con.then( () => relation.opener.repoIsGoodReform() )
// //     con.then( () => relation.opener.repoIsUpToDateReform() )
// //     con.then( () => relation )
// //     return con;
// //   }
// //
// // }
// //
// // var defaults  = submodulesVerify.defaults = Object.create( null );
// //
// // // defaults.recursive = 1;
// // // defaults.throwing = 1;
// // // defaults.asMap = 0;
// //
// // defaults.hasFiles = 1;
// // defaults.isValid = 1;
// // defaults.isRepository = 1;
// // defaults.remoteIsValid = 1;
// // defaults.isUpToDate = 1
//
// //
//
// function statusInvalidate( o )
// {
//   let module = this;
//
//   o = _.routineOptions( statusInvalidate, arguments );
//
//   for( let k in o )
//   {
//     if( o[ k ] === null )
//     o[ k ] = o.all;
//   }
//
//   if( module.isRemote === false )
//   {
//     for( let k in o )
//     {
//       if( k === 'all' )
//       continue;
//       if( o[ k ] )
//       module._repoStatusPut( k, o[ k ] );
//       // module.__[ k ] = module.LocalRepoDefaults[ k ];
//     }
//   }
//   else
//   {
//     for( let k in o )
//     {
//       if( k === 'all' )
//       continue;
//       if( o[ k ] )
//       module._repoStatusPut( k, null );
//       // module.__[ k ] = null;
//     }
//   }
//
// }
//
// statusInvalidate.defaults =
// {
//   all : 1,
//   hasFiles : null,
//   isRepository : null,
//   isUpToDate : null,
//   remoteIsValid : null,
//   hasLocalChanges : null,
//   downloadRequired : null,
//   updateRequired : null,
//   agreeRequired : null,
// }
//
// //
//
// function status( o )
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let result = Object.create( null );
//   let ready = new _.Consequence().take( null );
//
//   o = _.routineOptions( status, arguments );
//
//   if( o.downloadRequired )
//   o.hasFiles = true;
//   if( o.updateRequired || o.agreeRequired )
//   {
//     o.isRepository = true;
//     o.isUpToDate = true;
//     o.remoteIsValid = true;
//   }
//
//   for( let k in o )
//   {
//     if( o[ k ] === null )
//     o[ k ] = o.all;
//   }
//
//   if( module.isRemote === false )
//   {
//
//     for( let k in o )
//     {
//       if( k === 'all' )
//       continue;
//       if( o[ k ] )
//       module._repoStatusPut( k, module.LocalRepoDefaults[ k ] );
//     }
//
//   }
//   else
//   {
//
//     if( o.hasFiles )
//     if( o.reset || module.hasFiles === null )
//     ready.also( hasFilesReform );
//
//     if( o.hasLocalChanges )
//     if( o.reset || module.hasLocalChanges === null )
//     ready.also( hasLocalChangesReform );
//
//     if( o.isRepository )
//     if( o.reset || module.isRepository === null )
//     ready.also( isRepositoryReform );
//
//     if( o.isUpToDate )
//     if( o.reset || module.isUpToDate === null )
//     ready.also( isUpToDateReform );
//
//     if( o.remoteIsValid )
//     if( o.reset || module.remoteIsValid === null )
//     ready.also( remoteIsValidReform );
//
//     if( o.downloadRequired )
//     if( o.reset || module.downloadRequired === null )
//     ready.then( downloadRequiredReform );
//
//     if( o.updateRequired )
//     if( o.reset || module.updateRequired === null )
//     ready.then( updateRequiredReform );
//
//     if( o.agreeRequired )
//     if( o.reset || module.agreeRequired === null )
//     ready.then( agreeRequiredReform );
//
//   }
//
//   ready.then( () => returnResult );
//   return ready
//
//   /* */
//
//   function returnResult()
//   {
//     for( let k in o )
//     {
//       if( k === 'all' )
//       continue;
//       if( o[ k ] )
//       {
//         result[ k ] = module.__[ k ];
//         _.assert( _.boolIs( result[ k ] ) );
//       }
//     }
//     return result;
//   }
//
//   /* */
//
//   function hasFilesReform()
//   {
//     let module = this;
//     let will = module.will;
//     let fileProvider = will.fileProvider;
//     let path = fileProvider.path;
//
//     _.assert( _.strDefined( module.downloadPath ) );
//     _.assert( !!module.willfilesPath );
//     _.assert( module.isRemote === true );
//
//     let remoteProvider = fileProvider.providerForPath( module.remotePath );
//     _.assert( !!remoteProvider.isVcs );
//
//     let result = remoteProvider.hasFiles
//     ({
//       localPath : module.downloadPath,
//     });
//
//     _.assert( !_.consequenceIs( result ) );
//
//     return end( result );
//
//     function end( result )
//     {
//       _.assert( _.boolLike( result ) );
//       result = !!result;
//       module._repoStatusPut( 'hasFiles', result );
//       // module.__.hasFiles = result;
//       return result;
//     }
//
//   }
//
//   /* */
//
//   function hasLocalChangesReform()
//   {
//     let module = this;
//     let will = module.will;
//     let fileProvider = will.fileProvider;
//     let path = fileProvider.path;
//
//     _.assert( !!module.willfilesPath || !!module.dirPath );
//     _.assert( arguments.length === 0 );
//
//     // qqq : use remoteProvider
//     // let remoteProvider = fileProvider.providerForPath( module.remotePath );
//     // return remoteProvider.hasLocalChanges( module.downloadPath );
//     return _.git.hasLocalChanges
//     ({
//       localPath : module.downloadPath,
//       unpushed : 1,
//       sync : 1,
//     });
//   }
//
//   /* */
//
//   function isRepositoryReform()
//   {
//
//     _.assert( _.strDefined( module.downloadPath ) );
//     _.assert( !!module.willfilesPath );
//     _.assert( module.isRemote === true );
//
//     let remoteProvider = fileProvider.providerForPath( module.remotePath );
//
//     _.assert( !!remoteProvider.isVcs );
//
//     let result = remoteProvider.isRepository
//     ({
//       localPath : module.downloadPath,
//       sync : 1,
//     });
//
//     // let result = _.git.isRepository
//     // ({
//     //   localPath : module.downloadPath,
//     // });
//
//     _.assert( !_.consequenceIs( result ) );
//
//     return end( result );
//
//     // if( !result )
//     // return end( result );
//
//     // return _.Consequence.From( result )
//     // .finally( ( err, arg ) =>
//     // {
//     //   end( arg );
//     //   if( err )
//     //   throw err;
//     //   return arg;
//     // });
//
//     function end( result )
//     {
//       // module.__.isRepository = !!result;
//       _.assert( _.boolIs( result ) );
//       module._repoStatusPut( 'isRepository', result );
//       return result;
//     }
//
//   }
//
//   /* */
//
//   function isUpToDateReform()
//   {
//
//     _.assert( _.strDefined( module.downloadPath ) );
//     _.assert( !!module.willfilesPath );
//     _.assert( module.isRemote === true );
//
//     let remoteProvider = fileProvider.providerForPath( module.remotePath );
//
//     _.assert( !!remoteProvider.isVcs );
//
//     let result = remoteProvider.isUpToDate
//     ({
//       remotePath : module.remotePath,
//       localPath : module.downloadPath,
//       verbosity : will.verbosity - 3,
//     });
//
//     // if( !result )
//     // return end( result );
//
//     return _.Consequence.From( result )
//     .finally( ( err, arg ) =>
//     {
//       end( arg );
//       if( err )
//       throw err;
//       return arg;
//     });
//
//     function end( result )
//     {
//       _.assert( _.boolIs( result ) )
//       // module.__.isUpToDate = result;
//       module._repoStatusPut( 'isUpToDate', result );
//       return result;
//     }
//
//   }
//
//   /* */
//
//   function remoteIsValidReform()
//   {
//
//     _.assert( _.strDefined( module.remotePath ) );
//
//     let remoteProvider = module.will.fileProvider.providerForPath( module.remotePath );
//     let result = remoteProvider.hasRemote
//     ({
//       localPath : module.downloadPath,
//       remotePath : module.remotePath
//     });
//
//     _.assert( _.boolIs( result.remoteIsValid ) );
//     // module.__.remoteIsValid = result.remoteIsValid;
//     module._repoStatusPut( 'remoteIsValid', result );
//   }
//
//   /* */
//
//   function downloadRequiredReform()
//   {
//     _.assert( _.boolIs( module.hasFiles ) );
//     // module.__.downloadRequired = !module.hasFiles;
//     module._repoStatusPut( 'downloadRequired', !module.hasFiles );
//   }
//
//   /* */
//
//   function updateRequiredReform()
//   {
//     _.assert( _.boolIs( module.isRepository ) );
//     _.assert( _.boolIs( module.remoteIsValid ) );
//     _.assert( _.boolIs( module.isUpToDate ) );
//     // module.__.updateRequired = !module.isRepository || !module.remoteIsValid || !module.isUpToDate;
//     module._repoStatusPut( 'updateRequired', !module.isRepository || !module.remoteIsValid || !module.isUpToDate );
//   }
//
//   /* */
//
//   function agreeRequiredReform()
//   {
//     _.assert( _.boolIs( module.isRepository ) );
//     _.assert( _.boolIs( module.remoteIsValid ) );
//     _.assert( _.boolIs( module.isUpToDate ) );
//     // module.__.agreeRequired = !module.isRepository || !module.remoteIsValid || !module.isUpToDate;
//     module._repoStatusPut( 'agreeRequired', !module.isRepository || !module.remoteIsValid || !module.isUpToDate );
//   }
//
//   // function _repoIsFresh( o )
//   // {
//   //   let opener = this;
//   //   let ready = _.Consequence().take( null );
//   //
//   //   ready
//   //   .then( () =>
//   //   {
//   //     if( o.mode === 'download' )
//   //     return hasFilesRepositoryReform();
//   //     else if( o.mode === 'update' )
//   //     return isUpdatedRepositoryReform();
//   //     else if( o.mode === 'agree' )
//   //     return isUpdatedRepositoryReform();
//   //   })
//   //   .then( function()
//   //   {
//   //     let downloading = false;
//   //     if( o.mode === 'download' )
//   //     downloading = !opener.hasFiles;
//   //     else if( o.mode === 'update' )
//   //     downloading = !opener.isUpToDate || !opener.isRepository;
//   //     else if( o.mode === 'agree' )
//   //     downloading = !opener.isUpToDate || !opener.isRepository;
//   //     _.assert( _.boolLike( downloading ) );
//   //     return !!downloading;
//   //   })
//   //   .then( ( downloading ) =>
//   //   {
//   //     if( !downloading )
//   //     if( o.mode === 'update' || o.mode === 'agree' )
//   //     {
//   //       let gitProvider = opener.will.fileProvider.providerForPath( opener.remotePath );
//   //       let result = gitProvider.hasRemote
//   //       ({
//   //         localPath : opener.downloadPath,
//   //         remotePath : opener.remotePath
//   //       });
//   //       downloading = !result.remoteIsValid;
//   //     }
//   //     return !downloading;
//   //   })
//   //
//   //   return ready;
//   //
//   //   /*  */
//   //
//   //   function isUpdatedRepositoryReform()
//   //   {
//   //     let con = new _.Consequence().take( null );
//   //     con.then( () => opener.repoIsGoodReform() )
//   //     con.then( () => opener.repoIsUpToDateReform() )
//   //     return con;
//   //   }
//   //
//   //   /* */
//   //
//   //   function hasFilesRepositoryReform()
//   //   {
//   //     let con = new _.Consequence().take( null );
//   //     con.then( () => opener.repoHasFilesReform() )
//   //     return con;
//   //   }
//   //
//   // }
//
// }
//
// status.defaults =
// {
//   ... statusInvalidate.defaults,
//   all : 0,
//   reset : 0,
// }
//
// //
//
// function _statusGetter_functor( fieldName )
// {
//   return function get()
//   {
//     let module = this;
//
//     _.assert( module.__[ fieldName ] === null || _.boolIs( module.__[ fieldName ] ) );
//
//     if( module.__[ fieldName ] === null )
//     module.status({ all : 0, [ fieldName ] : 1 });
//
//     return module.__[ fieldName ];
//   }
// }
//
// //
//
// function _repoStatusPut( fieldName, src )
// {
//   let module = this;
//   debugger;
//   module.__[ fieldName ] = src;
//   return src;
// }

//

function repoIsRemote( remotePath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  // if( !module.superRelation )
  // return end( false );

  if( remotePath === undefined )
  remotePath = module.remotePath ? path.common( module.remotePath ) : module.commonPath;
  let remoteProvider = fileProvider.providerForPath( remotePath );

  _.assert( !!remoteProvider );

  return !!remoteProvider.isVcs;

  // if( remoteProvider.isVcs )
  // return end( true );
  //
  // return end( false );

  /* */

  // function end( result )
  // {
  //   module.isRemote = result;
  //   return result;
  // }
}

//
// //
//
// function repoIsGoodReform()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( module.downloadPath ) );
//   _.assert( !!module.willfilesPath );
//   _.assert( module.isRemote === true );
//
//   // let remoteProvider = fileProvider.providerForPath( module.remotePath );
//   // _.assert( !!remoteProvider.isVcs );
//
//   let result = _.git.isRepository
//   ({
//     localPath : module.downloadPath,
//   });
//
//   _.assert( !_.consequenceIs( result ) );
//
//   // if( !result )
//   // return end( result );
//
//   return _.Consequence.From( result )
//   .finally( ( err, arg ) =>
//   {
//     end( arg );
//     if( err )
//     throw err;
//     return arg;
//   });
//
//   /* */
//
//   function end( result )
//   {
//     module.isRepository = !!result;
//     return result;
//   }
//
// }

// //
//
// function repoIsUpToDateReform()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( module.downloadPath ) );
//   _.assert( !!module.willfilesPath );
//   _.assert( module.isRemote === true );
//
//   let remoteProvider = fileProvider.providerForPath( module.remotePath );
//
//   _.assert( !!remoteProvider.isVcs );
//
//   let result = remoteProvider.isUpToDate
//   ({
//     remotePath : module.remotePath,
//     localPath : module.downloadPath,
//     verbosity : will.verbosity - 3,
//   });
//
//   // if( !result )
//   // return end( result );
//
//   return _.Consequence.From( result )
//   .finally( ( err, arg ) =>
//   {
//     end( arg );
//     if( err )
//     throw err;
//     return arg;
//   });
//
//   /* */
//
//   function end( result )
//   {
//     module.isUpToDate = !!result;
//     return result;
//   }
//
// }

// //
//
// function repoHasLocalChanges()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!module.willfilesPath || !!module.dirPath );
//   _.assert( arguments.length === 0 );
//
//   // let remoteProvider = fileProvider.providerForPath( module.remotePath );
//   // return remoteProvider.hasLocalChanges( module.downloadPath );
//   return _.git.hasLocalChanges
//   ({
//     localPath : module.downloadPath,
//     unpushed : 1,
//     sync : 1,
//   });
// }

// //
//
// function repoHasFilesReform()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( _.strDefined( module.downloadPath ) );
//   _.assert( !!module.willfilesPath );
//   _.assert( module.isRemote === true );
//
//   let remoteProvider = fileProvider.providerForPath( module.remotePath );
//   _.assert( !!remoteProvider.isVcs );
//
//   let result = remoteProvider.hasFiles
//   ({
//     localPath : module.downloadPath,
//   });
//
//   _.assert( !_.consequenceIs( result ) );
//
//   if( _.boolLike( result ) )
//   return end( result );
//
//   return _.Consequence.From( result )
//   .finally( ( err, arg ) =>
//   {
//     end( arg );
//     if( err )
//     throw err;
//     return arg;
//   });
//
//   /* */
//
//   function end( result )
//   {
//     _.assert( _.boolLike( result ) );
//     result = !!result;
//     module.hasFiles = result;
//     return result;
//   }
//
// }

//

// function _repoIsFresh( o )
// {
//   let opener = this;
//   let ready = _.Consequence().take( null );
//
//   ready
//   .then( () =>
//   {
//     if( o.mode === 'download' )
//     return hasFilesRepositoryReform();
//     else if( o.mode === 'update' )
//     return isUpdatedRepositoryReform();
//     else if( o.mode === 'agree' )
//     return isUpdatedRepositoryReform();
//   })
//   .then( function()
//   {
//     let downloading = false;
//     if( o.mode === 'download' )
//     downloading = !opener.hasFiles;
//     else if( o.mode === 'update' )
//     downloading = !opener.isUpToDate || !opener.isRepository;
//     else if( o.mode === 'agree' )
//     downloading = !opener.isUpToDate || !opener.isRepository;
//     _.assert( _.boolLike( downloading ) );
//     return !!downloading;
//   })
//   .then( ( downloading ) =>
//   {
//     if( !downloading )
//     if( o.mode === 'update' || o.mode === 'agree' )
//     {
//       let gitProvider = opener.will.fileProvider.providerForPath( opener.remotePath );
//       let result = gitProvider.hasRemote
//       ({
//         localPath : opener.downloadPath,
//         remotePath : opener.remotePath
//       });
//       downloading = !result.remoteIsValid;
//     }
//
//     return !downloading;
//   })
//
//   /*  */
//
//   function isUpdatedRepositoryReform()
//   {
//     let con = new _.Consequence().take( null );
//     con.then( () => opener.repoIsGoodReform() )
//     con.then( () => opener.repoIsUpToDateReform() )
//     return con;
//   }
//
//   /* */
//
//   function hasFilesRepositoryReform()
//   {
//     let con = new _.Consequence().take( null );
//     con.then( () => opener.repoHasFilesReform() )
//     /* qqq : check */
//     // con.then( () => opener.repoIsGoodReform() )
//     return con;
//   }
//
//   return ready;
// }
//
// _repoIsFresh.defaults =
// {
//   mode : 'download',
// }

// //
//
// function repoLocalVersion()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!module.willfilesPath || !!module.dirPath );
//   _.assert( arguments.length === 0 );
//
//   debugger;
//   let remoteProvider = fileProvider.providerForPath( module.commonPath );
//   debugger;
//   return remoteProvider.versionLocalRetrive( module.downloadPath );
// }
//
// //
//
// function repoLatestVersion()
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   _.assert( !!module.willfilesPath || !!module.dirPath );
//   _.assert( arguments.length === 0 );
//
//   debugger;
//   let remoteProvider = fileProvider.providerForPath( module.commonPath );
//   debugger;
//   return remoteProvider.versionRemoteLatestRetrive( module.downloadPath )
// }

// --
// relations
// --

let willfileWithRoleMapSymbol = Symbol.for( 'willfileWithRoleMap' );
let willfileArraySymbol = Symbol.for( 'willfilesArray' );
let fileNameSymbol = Symbol.for( 'fileName' );

let willfilesPathSymbol = Symbol.for( 'willfilesPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let willPathSymbol = Symbol.for( 'willPath' );

// let LocalRepoDefaults =
// {
//   isRepository : true,
//   isUpToDate : true,
//   remoteIsValid : true,
//   hasLocalChanges : false,
//   downloadRequired : false,
//   updateRequired : false,
//   agreeRequired : false,
// }

let Composes =
{

  // isRemote : null,
  isOut : null,

  // hasFiles : null,
  // isRepository : null,
  // remoteIsValid : null,
  // hasLocalChanges : null,
  // isUpToDate : null,
  // downloadRequired : null,
  // updateRequired : null,
  // agreeRequired : null,

}

let Aggregates =
{
}

let Associates =
{
  will : null,
  peerModule : null,
  repo : null,
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
  // LocalRepoDefaults,
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
  isDownloaded : 'isDownloaded',

  hasFiles : 'hasFiles',
  isRepository : 'isRepository',
  remoteIsValid : 'remoteIsValid',
  hasLocalChanges : 'hasLocalChanges',
  isUpToDate : 'isUpToDate',
  downloadRequired : 'downloadRequired',
  updateRequired : 'updateRequired',
  agreeRequired : 'agreeRequired',
  LocalRepoDefaults : 'LocalRepoDefaults',
  isRemote : 'isRemote',

}

let Accessors =
{

  qualifiedName : { getter : qualifiedNameGet, combining : 'rewrite', readOnly : 1 },
  fileName : { readOnly : 1 },
  decoratedQualifiedName : { getter : decoratedQualifiedNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },

  willfilesArray : { setter : willfileArraySet },
  willfileWithRoleMap : { readOnly : 1 },

  __ : { getter : _.accessor.getter.withSymbol, readOnly : 1, strict : 0 },

  // hasFiles : { getter : _statusGetter_functor( 'hasFiles' ), readOnly : 1 },
  // isRepository : { getter : _statusGetter_functor( 'isRepository' ), readOnly : 1 },
  // remoteIsValid : { getter : _statusGetter_functor( 'remoteIsValid' ), readOnly : 1 },
  // hasLocalChanges : { getter : _statusGetter_functor( 'hasLocalChanges' ), readOnly : 1 },
  // isUpToDate : { getter : _statusGetter_functor( 'isUpToDate' ), readOnly : 1 },
  // downloadRequired : { getter : _statusGetter_functor( 'downloadRequired' ), readOnly : 1 },
  // updateRequired : { getter : _statusGetter_functor( 'updateRequired' ), readOnly : 1 },
  // agreeRequired : { getter : _statusGetter_functor( 'agreeRequired' ), readOnly : 1 },

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

  // repo

  // statusInvalidate,
  // status,
  // _repoStatusPut,

  repoIsRemote,
  // repoIsGoodReform,
  // repoIsUpToDateReform,
  // repoHasLocalChanges,
  // repoHasFilesReform,
  // _repoIsFresh,

  // repoLocalVersion,
  // repoLatestVersion,

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
