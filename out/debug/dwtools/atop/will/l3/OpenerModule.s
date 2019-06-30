( function _OpenerModule_s_( ) {

'use strict';

if( typeof opener !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.AbstractModule;
let Self = function wWillOpenerModule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'OpenerModule';

// --
// inter
// --

function finit()
{
  let opener = this;
  let will = opener.will;

  // opener.submoduleAssociation.forEach( ( submodule ) =>
  // {
  //   _.assert( submodule.oModule === opener );
  //   submodule.finit();
  // });

  opener.unform();

  return Parent.prototype.finit.apply( opener, arguments );
}

//

function init( o )
{
  let opener = this;

  opener[ dirPathSymbol ] = null;
  opener[ commonPathSymbol ] = null;
  opener[ willPathSymbol ] = _.path.join( __dirname, '../Exec' );
  opener[ willfileWithRoleMapSymbol ] = Object.create( null );
  opener[ willfileArraySymbol ] = [];
  opener[ configNameSymbol ] = null;

  Parent.prototype.init.apply( opener, arguments );

  _.assert( !!o );
  if( o )
  {
    opener.copy( o );
  }

  _.assert( opener.openerModule !== undefined );
  _.assert( opener.unwrappedOpenerModule !== undefined );
  _.assert( opener.openedModule !== undefined );

  return opener;
}

// function init( o )
// {
//   let opener = this;
//
//   opener[ Symbol.for( 'dirPath' ) ] = null;
//
//   // _.assert( arguments.length <= 1 );
//   // _.instanceInit( opener )
//   // Object.preventExtensions( opener );
//   //
//   // _.Will.ResourceCounter += 1;
//   // opener.id = _.Will.ResourceCounter;
//
//   Parent.prototype.init.apply( opener, arguments );
//
//   _.assert( !!o );
//   if( o )
//   {
//     if( !o.supermodule )
//     {
//       // opener.moduleWithPathMap = Object.create( null );
//       opener.moduleWithNameMap = Object.create( null );
//       opener.allSubmodulesMap = Object.create( null );
//     }
//     opener.copy( o );
//   }
//
//   let accessors =
//   {
//     get : function( opener, k, proxy )
//     {
//       let result;
//       if( opener[ k ] !== undefined )
//       result = opener[ k ];
//       else if( opener.openedModule && opener.openedModule[ k ] !== undefined )
//       result = opener.openedModule[ k ];
//       else _.assert( 0, 'Module does not have field', k );
//       if( k !== 'unwrappedOpenerModule' && result === opener )
//       return proxy;
//       return result;
//     },
//     set : function( opener, k, val, proxy )
//     {
//       if( opener[ k ] !== undefined )
//       opener[ k ] = val;
//       else if( opener.openedModule && opener.openedModule[ k ] !== undefined )
//       opener.openedModule[ k ] = val;
//       else _.assert( 0, 'Module does not have field', k );
//       return true;
//     },
//   };
//
//   let proxy = new Proxy( opener, accessors );
//
//   opener.openerModule = proxy;
//   opener.unwrappedOpenerModule = opener;
//
//   _.assert( opener.openerModule !== undefined );
//   _.assert( opener.unwrappedOpenerModule !== undefined );
//   _.assert( opener.openedModule !== undefined );
//   _.assert( proxy.openerModule !== undefined );
//   _.assert( proxy.unwrappedOpenerModule !== undefined );
//   _.assert( proxy.openedModule !== undefined );
//
//   return proxy;
// }

// {
//   let opener = this;
//
//   _.assert( arguments.length === 0 || arguments.length === 1 );
//
//   opener.pathResourceMap = opener.pathResourceMap || Object.create( null );
//
//   _.instanceInit( opener );
//   Object.preventExtensions( opener );
//
// }

//

function optionsForModule()
{
  let opener = this;

  let Import =
  {

    will : null,
    rootModule : null,
    willfilesArray : null,
    willfilesReadBeginTime : null,

    willfilesPath : null,
    localPath : null,
    remotePath : null,
    inPath : null,
    outPath : null,

    // configName : null,
    // aliasName : null,

    isRemote : null,
    isDownloaded : null,
    isUpToDate : null,

  }

  let result = _.mapOnly( opener, Import );

  if( opener.supermodule )
  result.supermodules = [ opener.supermodule ];

  // result.aliasesNames = [];
  // if( opener.aliasName )
  // result.aliasesNames.push( opener.aliasName );
  // if( opener.configName )
  // result.aliasesNames.push( opener.configName );

  result.willfilesArray = _.entityShallowClone( result.willfilesArray );

  return result;
}

//

function optionsForSecondModule()
{
  let opener = this;

  let Import =
  {
    will : null,
    rootModule : null,
    willfilesReadBeginTime : null,
  }

  let result = _.mapOnly( opener, Import );

  // if( opener.supermodule )
  // result.supermodules = [ opener.supermodule ];

  return result;
}

//

function precopy( o )
{
  let opener = this;
  if( o.will )
  opener.will = o.will;
  if( o.supermodules )
  opener.supermodules = o.supermodules;
  if( o.original )
  opener.original = o.original;
  if( o.rootModule )
  opener.rootModule = o.rootModule;
  return o;
}

//

function copy( o )
{
  let opener = this;
  opener.precopy( o );
  let result = _.Copyable.prototype.copy.apply( opener, arguments );
  return result;
}

//

function clone()
{
  let opener = this;

  _.assert( arguments.length === 0 );

  let result = opener.cloneExtending({});

  return result;
}

//

function cloneExtending( o )
{
  let opener = this;

  _.assert( arguments.length === 1 );

  if( o.original === undefined )
  o.original = opener.original;
  if( o.moduleWithPathMap === undefined )
  o.moduleWithPathMap = module.moduleWithPathMap;

  let result = _.Copyable.prototype.cloneExtending.call( opener, o );

  return result;
}

// --
// opener
// --

function unform()
{
  let opener = this;
  let will = opener.will;
  if( !opener.preformed )
  return opener;

  // opener.close();

  /* */

  // if( opener.openedModule )
  // if( opener.openedModule.releasedBy( opener ) )
  // {
  //   debugger;
  //   opener.openedModule = null;
  // }

  // if( opener.openedModule )
  // {
  //   // opener.openedModule.finit();
  //   // opener.openedModule = null;
  //   opener.openedModule.close();
  // }
  //
  // if( opener.error )
  // opener.error = null

  for( let i = opener.willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = opener.willfilesArray[ i ];
    opener.willfileUnregister( willf );
    willf.openerModule = null;
    if( willf.openedModule === null )
    willf.finit();
    _.assert( willf.openerModule === null );
  }

  /* */

  if( opener.openedModule )
  {
    opener.openedModule.releasedBy( opener );
    opener.openedModule = null;
  }

  will.openerUnregister( opener );

  opener.preformed = 0;
  return opener;
}

//

function preform()
{
  let opener = this;
  let will = opener.will;

  if( opener.preformed )
  return opener;

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!opener.will );
  _.assert( _.strsAreAll( opener.willfilesPath ) || _.strIs( opener.dirPath ), 'Expects willfilesPath or dirPath' );
  _.assert( opener.preformed === 0 );

  /* */

  opener._filePathChanged();

  /* */

  // _.assert( opener.id > 0 );
  // will.openerModuleWithIdMap[ opener.id ] = opener;
  // _.arrayAppendOnceStrictly( will.openersArray, opener );
  // _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  will.openerRegister( opener );

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!opener.will );
  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  _.assert( opener.dirPath === null || _.strDefined( opener.dirPath ) );
  _.assert( !!opener.willfilesPath || !!opener.dirPath );

  /* */

  opener.remoteForm();

  /* */

  opener.preformed = 1;
  return opener;
}

//

function close()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  if( opener.openedModule )
  {
    opener.openedModule.close();
  }

  if( opener.error )
  opener.error = null

  for( let i = opener.willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = opener.willfilesArray[ i ];
    opener.willfileUnregister( willf );
    if( willf.openerModule === opener )
    willf.openerModule = null;
    if( willf.openedModule === null )
    willf.finit();
  }

}

//

function tryOpen()
{
  let opener = this;
  let will = opener.will;

  try
  {
    opener.open();
  }
  catch( err )
  {
    opener.error = err;
    return null;
  }

  return opener.openedModule;
}

//

function open()
{
  let opener = this;
  let will = opener.will;

  opener.preform();
  opener.willfilesReadBegin();

  let openedModule = opener.openedModule;
  if( !openedModule )
  openedModule = will.moduleAt( opener.willfilesPath );

  /* */

  if( opener.finding )
  if( !openedModule || !openedModule.willfilesArray.length )
  {

    opener._willfilesFind();

    if( !opener.error )
    if( !opener.willfilesArray.length )
    {
      debugger;
      opener.error = _.err( 'Found no will file at ' + _.strQuote( opener.dirPath ) );
    }

    /* get module from opened willfile, maybe */

    if( opener.willfilesArray.length )
    if( opener.willfilesArray[ 0 ].openedModule )
    openedModule = opener.willfilesArray[ 0 ].openedModule;

  }

  /* */

  if( opener.error )
  {
    throw opener.error;
  }

  /* */

  if( openedModule )
  {

    _.assert( openedModule.rootModule === opener.rootModule || opener.rootModule === null );
    _.assert( opener.openedModule === openedModule || opener.openedModule === null );
    opener.openedModule = openedModule;

    _.assert( !opener.willfilesArray.length || !openedModule.willfilesArray.length || _.arrayIdentical( opener.willfilesArray, openedModule.willfilesArray ) );
    if( opener.willfilesArray.length )
    openedModule.willfilesArray = _.entityShallowClone( opener.willfilesArray );
    else
    opener.willfilesArray = _.entityShallowClone( openedModule.willfilesArray );

  }
  else
  {

    _.assert( opener.openedModule === null );
    let o2 = opener.optionsForModule();
    openedModule = opener.openedModule = new will.OpenedModule( o2 );
    if( openedModule.rootModule === null )
    openedModule.rootModule = openedModule;
    openedModule.preform();

    if( opener.rootModule === null || opener.rootModule === openedModule )
    if( !opener.original )
    if( opener.willfilesArray.length )
    opener.openModulesFromData
    ({
      willfilesArray : opener.willfilesArray.slice(),
      rootModule : openedModule.rootModule,
    });

  }

  _.assert( _.arrayIdentical( opener.willfilesArray, opener.openedModule.willfilesArray ) );
  _.assert( _.arrayIdentical( _.mapVals( opener.willfileWithRoleMap ), _.mapVals( opener.openedModule.willfileWithRoleMap ) ) );

  if( !opener.openedModule.isUsedBy( opener ) )
  opener.openedModule.usedBy( opener );

  return opener.openedModule;
}

//

function openCloning( openedModule )
{
  let opener = this;
  let will = opener.will;

  opener.preform();
  opener.willfilesReadBegin();

  let o2 = opener.optionsForModule();
  o2.rootModule = opener.rootModule;

  let openedModule2 = openedModule.cloneExtending( o2 );
  opener.openedModule = openedModule2;

  if( openedModule2.rootModule === null )
  openedModule2.rootModule = openedModule2;

  _.assert( opener.openedModule === openedModule2 );
  openedModule2.usedBy( opener );
  return openedModule2;
}

//

function openModulesFromData( o )
{
  let opener = this;
  let will = opener.will;

  o = _.routineOptions( openModulesFromData, arguments );

  for( let f = 0 ; f < o.willfilesArray.length ; f++ )
  {
    let willfile = o.willfilesArray[ f ];
    willfile.read();

    for( let modulePath in willfile.data.module )
    {
      let data = willfile.data.module[ modulePath ];
      if( data === 'root' )
      continue;
      opener.openModuleFromData
      ({
        modulePath : modulePath,
        data : data,
        rootModule : o.rootModule,
      });
    }

  }

}

openModulesFromData.defaults =
{
  willfilesArray : null,
  rootModule : null,
}

//

function openModuleFromData( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( openModuleFromData, arguments );

  let modulePath = path.join( opener.dirPath, o.modulePath );
  let willf = will.willfileFor
  ({
    filePath : modulePath + '.will.cached!',
    will : will,
    role : 'single',
    data : o.data,
  });

  let opener2 = will.OpenerModule
  ({
    will : will,
    willfilesPath : modulePath,
    willfilesArray : [ willf ],
    finding : 0,
    rootModule : o.rootModule,
  }).preform();

  opener2.open();

  return opener2.openedModule;
}

openModuleFromData.defaults =
{
  modulePath : null,
  data : null,
  rootModule : null,
}

//

function isOpened()
{
  let opener = this;
  return opener.openedModule && opener.openedModule.stager.stageStatePerformed( 'formed' );
}

//

function isValid()
{
  let opener = this;
  if( opener.error )
  return false;
  if( opener.openedModule )
  return opener.openedModule.stager.isValid();
  return true;
}

//

function _openEnd()
{
  let opener = this;
  return null;
}

//

function willfileUnregister( willf )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayRemoveElementOnceStrictly( opener.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( opener.willfileWithRoleMap[ willf.role ] === willf )
    delete opener.willfileWithRoleMap[ willf.role ];
  }

}

//

function willfileRegister( willf )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayAppendOnceStrictly( opener.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( !opener.willfileWithRoleMap[ willf.role ], 'Module already has willfile with role', willf.role )
    opener.willfileWithRoleMap[ willf.role ] = willf;
  }

  if( willf.openerModule === null )
  willf.openerModule = opener;

}

//

function willfileArraySet( willfilesArray )
{
  let opener = this;
  _.assert( _.arrayIs( willfilesArray ) );

  if( opener.willfilesArray === willfilesArray )
  return opener.willfilesArray;

  for( let w = opener.willfilesArray.length-1 ; w >= 0 ; w-- )
  {
    let willf = opener.willfilesArray[ w ];
    opener.willfileUnregister( willf );
  }

  for( let w = 0 ; w < willfilesArray.length ; w++ )
  {
    let willf = willfilesArray[ w ];
    opener.willfileRegister( willf );
  }

  return opener.willfilesArray;
}

//

function _willfileFindSingle( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = opener.rootModule;

  _.assert( rootModule === null || rootModule instanceof will.OpenedModule );
  _.assert( _.strDefined( o.role ) );
  _.routineOptions( _willfileFindSingle, arguments );

  /* */

  if( opener.willfileWithRoleMap[ o.role ] )
  return opener.willfileWithRoleMap[ o.role ];

  let willfilesPath = _.strCommonLeft.apply( _, _.arrayAs( opener.willfilesPath ) );
  let isDir = path.isTrailed( willfilesPath );
  let name = '';

  if( !isDir )
  {
    name = path.fullName( willfilesPath );
    name = _.strRemoveEnd( name, '.' );
    name = _.strReplace( name, /(\.ex|\.im|)?\.will(\.\w+)?$/, '' );
    name = _.strReplace( name, /(\.out)?$/, '' );
    willfilesPath = path.dir( willfilesPath );
  }

  let fullName = name;
  fullName += opener.prefixPathForRole( o.role, o.isOutFile );

  let filePath = path.resolve( willfilesPath, fullName );

  /* */

  if( will.verbosity >= 5 )
  logger.log( ' . Trying to open', filePath );

  _.assert( opener.willfileWithRoleMap[ o.role ] === undefined );

  let willf;
  let commonPath = will.Willfile.CommonPathFor( filePath );
  if( will.willfileWithPathMap[ commonPath ] )
  {
    willf = will.willfileWithPathMap[ commonPath ];
    opener.willfileRegister( willf );
  }
  else
  {
    willf = will.willfileFor
    ({
      filePath : filePath,
      role : o.role,
      isOutFile : o.isOutFile,
      openerModule : opener,
      will : will,
    })
  }

  _.assert( willf === opener.willfileWithRoleMap[ o.role ] );

  if( !willf.exists() )
  {
    willf.finit();
    return null;
  }

  if( isDir )
  {
    /* try to find other split files */
    let found = opener._willfileFindMultiple
    ({
      isOutFile : o.isOutFile,
    });
  }

  return willf;
}

_willfileFindSingle.defaults =
{
  role : null,
  isOutFile : 0,
}

//

function _willfileFindMultiple( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let roles = [ 'single', 'import', 'export' ];
  let files = Object.create( null );

  _.routineOptions( _willfileFindMultiple, arguments );

  for( let r = 0 ; r < roles.length ; r++ )
  {
    let role = roles[ r ];

    files[ role ] = opener._willfileFindSingle
    ({
      role : role,
      isOutFile : o.isOutFile,
    });

  }

  if( opener.willfilesArray.length )
  return end( opener.willfilesArray );

  return false;

  /* */

  function end( willfilesArray )
  {
    _.assert( willfilesArray.length > 0 );
    let filePaths = _.select( willfilesArray, '*/filePath' );
    opener._filePathChange( filePaths );
    return true;
  }

}

_willfileFindMultiple.defaults =
{
  isOutFile : 0,
}

//

function _willfilesFindMaybe( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let filePaths;
  let found;

  o = _.routineOptions( _willfilesFindMaybe, arguments );

  _.assert( opener.willfilesArray.length === 0, 'not tested' );

  /* specific terminal file */

  if( _.arrayIs( opener.willfilesPath ) && opener.willfilesPath.length === 1 )
  opener.willfilesPath = opener.willfilesPath[ 0 ];

  if( !found )
  find( o.isOutFile );

  if( !o.isOutFile )
  if( !found )
  find( !o.isOutFile );

  /* */

  return found;

  /* */

  function find( isOutFile )
  {

    /* isOutFile */

    found = opener._willfileFindMultiple
    ({
      isOutFile : isOutFile,
    });
    if( found )
    return found;

  }

}

_willfilesFindMaybe.defaults =
{
  isOutFile : 0,
}

//

function _willfilesFindPickedFile()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 0 );
  _.assert( !!opener.pickedWillfilesPath );

  opener.pickedWillfilesPath = _.arrayAs( opener.pickedWillfilesPath );
  _.assert( _.strsAreAll( opener.pickedWillfilesPath ) );

  opener.pickedWillfilesPath.forEach( ( filePath ) =>
  {

    let willfile = will.willfileFor
    ({
      filePath : filePath,
      will : will,
      role : 'single',
      openerModule : opener,
      data : opener.pickedWillfileData,
    })

    if( willfile.exists() || opener.pickedWillfileData )
    result.push( willfile );
    else
    willfile.finit();

  });

  if( result.length )
  {
    let willfilesPath = _.select( result, '*/filePath' );
    opener._filePathChange( willfilesPath );
  }

  return result;
}

//

function _willfilesFind()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 0 );

  /* */

  try
  {

    // if( opener.submoduleAssociation && opener.submoduleAssociation.autoExporting ) // xxx
    // {
    //   result = opener.exportAuto();
    // }
    // else
    if( opener.pickedWillfilesPath )
    {
      result = opener._willfilesFindPickedFile();
    }
    else
    {
      _.assert( !opener.pickedWillfileData );
      result = opener._willfilesFindMaybe({ isOutFile : !!opener.supermodule });
    }

    _.assert( !_.consequenceIs( result ) );

    if( opener.willfilesArray.length )
    _.assert( !!opener.willfilesPath && !!opener.dirPath );

  }
  catch( err )
  {
    err = _.err( 'Error looking for will files for', opener.nickName, 'at', _.strQuote( opener.commonPath ), '\n', err );
    opener.error = err;
  }

  if( opener.willfilesArray.length === 0 )
  {
    let err;
    if( opener.supermodule )
    err = _.errBriefly( 'Found no .out.will file for',  opener.supermodule.nickName, 'at', _.strQuote( opener.commonPath ) );
    else
    err = _.errBriefly( 'Found no willfile at', _.strQuote( opener.commonPath ) );
    opener.error = err;
  }

}

//

function willfilesPick( filePaths )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  opener.pickedWillfilesPath = filePaths;

  opener._willfilesFind();

  return opener.willfilesArray.slice();
}

//

function willfilesReadBegin()
{
  let opener = this;
  let will = opener.will;
  let logger = will.logger;

  opener.willfilesReadBeginTime = _.timeNow();

  return null;
}

//

function _willfilesExport()
{
  let opener = this;
  let will = opener.will;
  let result = Object.create( null );

  opener.willfileEach( handeWillFile );

  return result;

  function handeWillFile( willfile )
  {
    _.assert( _.objectIs( willfile.data ) );
    result[ willfile.filePath ] = willfile.data;
  }

}

//

function willfileEach( onEach )
{
  let opener = this;
  let will = opener.will;

  for( let w = 0 ; w < opener.willfilesArray.length ; w++ )
  {
    let willfile = opener.willfilesArray[ w ];
    onEach( willfile )
  }

  for( let s in opener.submoduleMap )
  {
    let submodule = opener.submoduleMap[ s ];
    if( !submodule.oModule )
    continue;

    for( let w = 0 ; w < submodule.oModule.willfilesArray.length ; w++ )
    {
      let willfile = submodule.oModule.willfilesArray[ w ];
      onEach( willfile )
    }

  }

}

// --
// submodule
// --


//

function supermoduleGet()
{
  let opener = this;
  return opener[ supermoduleSymbol ];
}

//

function supermoduleSet( src )
{
  let opener = this;
  _.assert( src === null || src instanceof _.Will.OpenedModule );
  opener[ supermoduleSymbol ] = src;
  return src;
}

//

function rootModuleGet()
{
  let opener = this;
  if( opener.openedModule )
  return opener.openedModule.rootModule;
  return opener[ rootModuleSymbol ];
}

//

function rootModuleSet( src )
{
  let opener = this;
  _.assert( src === null || src instanceof _.Will.OpenedModule );
  opener[ rootModuleSymbol ] = src;
  return src;
}

//

function submodulesAllAreDownloaded()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !opener.supermodule );

  for( let n in opener.submoduleMap )
  {
    let submodule = opener.submoduleMap[ n ].oModule;
    if( !submodule )
    return false;
    if( !submodule.isDownloaded )
    return false;
  }

  return true;
}

//

function submodulesAllAreValid()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !opener.supermodule );

  for( let n in opener.submoduleMap )
  {
    let submodule = opener.submoduleMap[ n ].oModule;
    if( !submodule )
    continue;
    if( !submodule.isValid() )
    return false;
  }

  return true;
}

// --
// remote
// --

function remoteIsUpdate()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!opener.willfilesPath || !!opener.dirPath );
  _.assert( arguments.length === 0 );

  let remoteProvider = fileProvider.providerForPath( opener.commonPath );
  if( remoteProvider.isVcs )
  return end( true );

  return end( false );

  /* */

  function end( result )
  {
    opener.isRemote = result;
    return result;
  }
}

//

function remoteIsUpToDateUpdate()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( opener.localPath ) );
  _.assert( !!opener.willfilesPath );
  _.assert( opener.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( opener.remotePath );

  _.assert( !!remoteProvider.isVcs );

  debugger;
  let result = remoteProvider.isUpToDate
  ({
    remotePath : opener.remotePath,
    localPath : opener.localPath,
    verbosity : will.verbosity - 3,
  });

  if( !result )
  return end( result );

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
    opener.isUpToDate = !!result;
    return result;
  }

}

//

function remoteIsDownloadedUpdate()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( opener.localPath ) );
  _.assert( !!opener.willfilesPath );
  _.assert( opener.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( opener.remotePath );
  _.assert( !!remoteProvider.isVcs );

  let result = remoteProvider.isDownloaded
  ({
    localPath : opener.localPath,
  });

  _.assert( !_.consequenceIs( result ) );

  if( !result )
  return end( result );

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
    opener.isDownloaded = !!result;
    return result;
  }
}

//

function remoteIsDownloadedChanged()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!opener.pathResourceMap[ 'current.remote' ] );

  /* */

  if( opener.isDownloaded &&  opener.remotePath )
  {

    let remoteProvider = fileProvider.providerForPath( opener.remotePath );
    _.assert( !!remoteProvider.isVcs );

    let version = remoteProvider.versionLocalRetrive( opener.localPath );
    if( version )
    {
      let remotePath = _.uri.parseConsecutive( opener.remotePath );
      remotePath.hash = version;
      opener.pathResourceMap[ 'current.remote' ].path = _.uri.str( remotePath );
    }
  }
  else
  {
    opener.pathResourceMap[ 'current.remote' ].path = null;
  }

}

//

function remoteIsDownloadedSet( src )
{
  let opener = this;

  src = !!src;

  let changed = opener[ isDownloadedSymbol ] !== undefined && opener[ isDownloadedSymbol ] !== src;

  opener[ isDownloadedSymbol ] = src;

  if( changed )
  opener.remoteIsDownloadedChanged();

}

//

function remoteForm()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  opener.remoteIsUpdate();

  if( opener.isRemote )
  {
    opener._remoteFormAct();
  }
  else
  {
    opener.isDownloaded = null;
  }

  return opener;
}

//

function _remoteFormAct()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let willfilesPath = opener.willfilesPath;

  _.assert( _.strDefined( opener.aliasName ) );
  _.assert( !!opener.supermodule );
  _.assert( _.strIs( willfilesPath ) );

  let remoteProvider = fileProvider.providerForPath( opener.commonPath );

  _.assert( remoteProvider.isVcs && _.routineIs( remoteProvider.pathParse ), () => 'Seems file provider ' + remoteProvider.nickName + ' does not have version control system features' );

  let submodulesDir = opener.supermodule.cloneDirPathGet();
  let parsed = remoteProvider.pathParse( willfilesPath );

  opener.remotePath = willfilesPath;
  debugger;
  opener.localPath = path.resolve( submodulesDir, opener.aliasName );
  debugger;

  let willfilesPath2 = path.resolve( opener.localPath, parsed.localVcsPath );
  opener._filePathChange( willfilesPath2 );

  opener.remoteIsDownloadedUpdate();

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );

  return opener;
}

//

function _remoteDownload( o )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let time = _.timeNow();
  let downloading = false;
  let con = _.Consequence().take( null );

  _.routineOptions( _remoteDownload, o );
  _.assert( arguments.length === 1 );
  _.assert( opener.preformed > 0  );
  _.assert( !!opener.willfilesPath );
  _.assert( _.strDefined( opener.aliasName ) );
  _.assert( _.strDefined( opener.remotePath ) );
  _.assert( _.strDefined( opener.localPath ) );
  _.assert( !!opener.supermodule );

  return con
  .keep( () =>
  {
    if( o.updating )
    return opener.remoteIsUpToDateUpdate();
    else
    return opener.remoteIsDownloadedUpdate();
  })
  .keep( function( arg )
  {

    if( o.updating )
    downloading = !opener.isUpToDate;
    else
    downloading = !opener.isDownloaded;

    /*
    delete old remote opener if it has a critical error or downloaded files are corrupted
    */

    if( !o.dry )
    if( !opener.isValid() || !opener.isDownloaded )
    {
      fileProvider.filesDelete({ filePath : opener.localPath, throwing : 0, sync : 1 });
    }

    return arg;
  })
  .keep( () =>
  {

    let o2 =
    {
      reflectMap : { [ opener.remotePath ] : opener.localPath },
      verbosity : will.verbosity - 5,
      extra : { fetching : 0 },
    }

    if( downloading && !o.dry )
    return will.Predefined.filesReflect.call( fileProvider, o2 );

    return null;
  })
  .keep( function( arg )
  {
    debugger;
    opener.isDownloaded = true;
    if( downloading && !o.dry )
    opener.isUpToDate = true;
    if( o.forming && !o.dry && downloading )
    {

      let willf = opener.willfilesArray[ 0 ];
      opener.close();
      _.assert( !_.arrayHas( will.willfilesArray, willf ) );
      opener.open();

      debugger;
      opener.openedModule.stager.stageStatePausing( 'opened', 0 );
      opener.openedModule.stager.stageStateSkipping( 'submodulesFormed', 1 );
      opener.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
      opener.openedModule.stager.tick();

      return opener.openedModule.ready
      .finallyGive( function( err, arg )
      {
        this.take( err, arg );
      })
      .split();
    }
    return null;
  })
  .finallyKeep( function( err, arg )
  {
    if( err )
    throw _.err( 'Failed to', ( o.updating ? 'update' : 'download' ), opener.decoratedAbsoluteName, '\n', err );
    if( will.verbosity >= 3 && downloading )
    {
      if( o.dry )
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionRemoteCurrentRetrive( opener.remotePath );
        logger.log( ' + ' + opener.decoratedNickName + ' will be ' + ( o.updating ? 'updated to' : 'downloaded' ) + ' version ' + _.color.strFormat( version, 'path' ) );
      }
      else
      {
        let remoteProvider = fileProvider.providerForPath( opener.remotePath );
        let version = remoteProvider.versionLocalRetrive( opener.localPath );
        logger.log( ' + ' + opener.decoratedNickName + ' was ' + ( o.updating ? 'updated to' : 'downloaded' ) + ' version ' + _.color.strFormat( version, 'path' ) + ' in ' + _.timeSpent( time ) );
      }
    }
    return downloading;
  });

}

_remoteDownload.defaults =
{
  updating : 0,
  dry : 0,
  forming : 1,
  recursive : 0,
}

//

function remoteDownload()
{
  let opener = this;
  let will = opener.will;
  return opener._remoteDownload({ updating : 0 });
}

//

function remoteUpgrade()
{
  let opener = this;
  let will = opener.will;
  return opener._remoteDownload({ updating : 1 });
}

//

function remoteCurrentVersion()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!opener.willfilesPath || !!opener.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( opener.commonPath );
  debugger;
  return remoteProvider.versionLocalRetrive( opener.localPath );
}

//

function remoteLatestVersion()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!opener.willfilesPath || !!opener.dirPath );
  _.assert( arguments.length === 0 );

  debugger;
  let remoteProvider = fileProvider.providerForPath( opener.commonPath );
  debugger;
  return remoteProvider.versionRemoteLatestRetrive( opener.localPath )
}

// --
// path
// --

function _filePathChange( willfilesPath )
{

  if( !this.will )
  return;

  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( _.arrayIs( willfilesPath ) && willfilesPath.length === 1 )
  willfilesPath = willfilesPath[ 0 ];

  if( willfilesPath )
  willfilesPath = path.s.normalizeTolerant( willfilesPath );

  let dirPath = willfilesPath;
  if( _.arrayIs( dirPath ) )
  dirPath = dirPath[ 0 ];
  if( _.strIs( dirPath ) )
  dirPath = path.dir( dirPath );
  if( dirPath === null )
  dirPath = opener.dirPath;
  if( dirPath )
  dirPath = path.normalize( dirPath );

  let commonPath = opener.CommonPathFor( willfilesPath );

  _.assert( arguments.length === 1 );
  _.assert( dirPath === null || _.strDefined( dirPath ) );
  _.assert( dirPath === null || path.isAbsolute( dirPath ) );
  _.assert( dirPath === null || path.isNormalized( dirPath ) );
  _.assert( willfilesPath === null || path.s.allAreAbsolute( willfilesPath ) );

  opener[ willfilesPathSymbol ] = willfilesPath;
  opener[ dirPathSymbol ] = dirPath;
  opener[ commonPathSymbol ] = commonPath;
  opener[ configNameSymbol ] = path.fullName( commonPath );

  if( opener.openedModule )
  debugger;
  if( opener.openedModule )
  opener.openedModule._filePathChange( willfilesPath );

}


//

function _filePathChanged()
{
  let opener = this;

  _.assert( arguments.length === 0 );

  opener._filePathChange( opener.willfilesPath );

}

//

function predefinedPathGet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function predefinedPathGet()
  {
    let opener = this;
    let openedModule = opener.openedModule;
    let will = opener.will;

    if( openedModule )
    return openedModule[ fieldName ];

    let result = opener[ symbol ];
    // if( will )
    // {
    //   let fileProvider = will.fileProvider;
    //   let path = fileProvider.path;
    //   if( fieldName !== 'dirPath' && result )
    //   result = path.s.join( opener.dirPath, result );
    // }

    return result;
  }

}

//

function predefinedPathSet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function predefinedPathSet( filePath )
  {
    let opener = this;
    let openedModule = opener.openedModule;

    filePath = _.entityShallowClone( filePath );
    opener[ symbol ] = filePath;

    opener._filePathChanged();

    if( openedModule )
    openedModule[ fieldName ] = filePath;

  }

}

let willfilesPathGet = predefinedPathGet_functor( 'willfilesPath' );
let dirPathGet = predefinedPathGet_functor( 'dirPath' );
let commonPathGet = predefinedPathGet_functor( 'commonPath' );
let inPathGet = predefinedPathGet_functor( 'inPath' );
let outPathGet = predefinedPathGet_functor( 'outPath' );
let localPathGet = predefinedPathGet_functor( 'localPath' );
let remotePathGet = predefinedPathGet_functor( 'remotePath' );
let willPathGet = predefinedPathGet_functor( 'willPath' );

let willfilesPathSet = predefinedPathSet_functor( 'willfilesPath' );
let inPathSet = predefinedPathSet_functor( 'inPath' );
let outPathSet = predefinedPathSet_functor( 'outPath' );
let localPathSet = predefinedPathSet_functor( 'localPath' );
let remotePathSet = predefinedPathSet_functor( 'remotePath' );

// --
// name
// --

function nameGet()
{
  let opener = this;
  let will = opener.will;

  _.assert( !!will );

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;

  if( !name && opener.aliasName )
  return opener.aliasName;

  if( !name && opener.openedModule && opener.openedModule.about )
  return opener.openedModule.about.name;

  if( !name && opener.configName )
  return opener.configName;

  if( !name && opener.openedModule )
  return opener.openedModule.name;

  if( !name && opener.commonPath )
  return path.fullName( opener.commonPath );

  return null;
}

//

function _nameChanged()
{
  let opener = this;
  let will = opener.will;
  let openedModule = opener.openedModule;

  if( openedModule )
  openedModule._nameChanged();

}

//

function aliasNameSet( src )
{
  let opener = this;
  opener[ aliasNameSymbol ] = src;
  opener._nameChanged();
}

// //
//
// function configNameSet( src )
// {
//   let opener = this;
//   opener[ configNameSymbol ] = src;
//   opener._nameChanged();
// }

//

function absoluteNameGet()
{
  let opener = this;
  let supermodule = opener.supermodule;
  if( supermodule )
  return supermodule.nickName + ' / ' + opener.nickName;
  else
  return opener.nickName;
}

//

function shortNameArrayGet()
{
  let opener = this;
  let supermodule = opener.openerModule.supermodule;
  if( !supermodule )
  return [ opener.name ];
  let result = supermodule.shortNameArrayGet();
  result.push( opener.name );
  return result;
}

// --
// relations
// --

let outPathSymbol = Symbol.for( 'outPath' );
let inPathSymbol = Symbol.for( 'inPath' );
let willfilesPathSymbol = Symbol.for( 'willfilesPath' );
let dirPathSymbol = Symbol.for( 'dirPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let aliasNameSymbol = Symbol.for( 'aliasName' );
let configNameSymbol = Symbol.for( 'configName' );
let supermoduleSymbol = Symbol.for( 'supermodule' );
let rootModuleSymbol = Symbol.for( 'rootModule' );
let willPathSymbol = Symbol.for( 'willPath' );
let willfileWithRoleMapSymbol = Symbol.for( 'willfileWithRoleMap' );
let willfileArraySymbol = Symbol.for( 'willfilesArray' );

let Composes =
{

  willfilesPath : null,
  pickedWillfilesPath : null,
  inPath : null,
  outPath : null,
  localPath : null,
  remotePath : null,

  isRemote : null,
  isDownloaded : null,
  isUpToDate : null,
  finding : 1,

  aliasName : null,
  // configName : null,

}

let Aggregates =
{
}

let Associates =
{

  original : null,
  will : null,

  rootModule : null,
  supermodule : null,
  pickedWillfileData : null,

  willfilesArray : _.define.own([]),

}

let Medials =
{
  moduleWithPathMap : null,
}

let Restricts =
{

  id : null,
  preformed : 0,
  found : 0,
  error : null,

  openedModule : null,
  openerModule : null,
  unwrappedOpenerModule : null,

  willfilesReadBeginTime : null,

}

let Statics =
{
}

let Forbids =
{
  moduleWithPathMap : 'moduleWithPathMap',
  allSubmodulesMap : 'allSubmodulesMap',
  moduleWithNameMap : 'moduleWithNameMap',
  willfilesReadTimeReported : 'willfilesReadTimeReported',
  submoduleAssociation : 'submoduleAssociation',
  currentRemotePath : 'currentRemotePath',
  opened : 'opened',
}

let Accessors =
{

  willfilesPath : { getter : willfilesPathGet, setter : willfilesPathSet },
  dirPath : { getter : dirPathGet, readOnly : 1 },
  commonPath : { getter : commonPathGet, readOnly : 1 },
  inPath : { getter : inPathGet, setter : inPathSet },
  outPath : { getter : outPathGet, setter : outPathSet },
  localPath : { getter : localPathGet, setter : localPathSet },
  remotePath : { getter : remotePathGet, setter : remotePathSet },
  willPath : { getter : willPathGet, readOnly : 1 },

  name : { getter : nameGet, readOnly : 1 },
  aliasName : { setter : aliasNameSet },
  configName : { readOnly : 1 },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },

  supermodule : { getter : supermoduleGet, setter : supermoduleSet },
  rootModule : { getter : rootModuleGet, setter : rootModuleSet },
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
  optionsForModule,
  optionsForSecondModule,
  precopy,
  copy,
  clone,
  cloneExtending,

  [ Symbol.toStringTag ] : Object.prototype.toString,

  // opener

  unform,
  preform,

  close,
  tryOpen,
  open,
  openCloning,

  openModulesFromData,
  openModuleFromData,

  isOpened,
  isValid,
  _openEnd,

  // willfile

  willfileUnregister,
  willfileRegister,
  willfileArraySet,

  _willfileFindSingle,
  _willfileFindMultiple,
  _willfilesFindMaybe,
  _willfilesFindPickedFile,
  _willfilesFind,
  willfilesPick,

  willfilesReadBegin,

  _willfilesExport,
  willfileEach,

  // submodule

  supermoduleGet,
  supermoduleSet,
  rootModuleGet,
  rootModuleSet,

  submodulesAllAreDownloaded,
  submodulesAllAreValid,

  // remote

  remoteIsUpdate,
  remoteIsUpToDateUpdate,

  remoteIsDownloadedUpdate,
  remoteIsDownloadedChanged,
  remoteIsDownloadedSet,

  remoteForm,
  _remoteFormAct,
  _remoteDownload,
  remoteDownload,
  remoteUpgrade,
  remoteCurrentVersion,
  remoteLatestVersion,

  // path

  _filePathChange,
  _filePathChanged,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,

  inPathGet,
  outPathGet,
  localPathGet,
  remotePathGet,
  willPathGet,

  willfilesPathSet,
  inPathSet,
  outPathSet,
  localPathSet,
  remotePathSet,

  // name

  nameGet,
  _nameChanged,
  aliasNameSet,
  absoluteNameGet,
  shortNameArrayGet,

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

Self.prototype[ Symbol.toStringTag ] = Object.prototype.toString;

// _.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
