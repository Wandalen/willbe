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
    // supermodule : null,
    rootModule : null,
    willfilesPath : null,
    localPath : null,
    remotePath : null,
    configName : null,
    aliasName : null,
    isRemote : null,
    isDownloaded : null,
    isUpToDate : null,
    // willfileWithRoleMap : null,
    willfileArray : null,
    willfilesReadBeginTime : null,

  }

  let result = _.mapOnly( opener, Import );

  if( opener.supermodule )
  result.supermodules = [ opener.supermodule ];

  // result.rootModule = opener.rootModule;

  result.willfileArray = _.entityShallowClone( result.willfileArray );
  // result.willfileWithRoleMap = _.entityShallowClone( result.willfileWithRoleMap );

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

  for( let i = opener.willfileArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = opener.willfileArray[ i ];
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
  // _.arrayAppendOnceStrictly( will.openerModuleArray, opener );
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

  for( let i = opener.willfileArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = opener.willfileArray[ i ];
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

  if( opener.finding )
  opener._willfilesFind();

  if( opener.error )
  {
    throw opener.error;
  }

  if( opener.finding )
  if( !opener.willfileArray.length )
  {
    opener.error = _.err( 'Found no will file at ' + _.strQuote( opener.dirPath ) );
    throw opener.error;
  }

  let openedModule = opener.openedModule;

  if( !openedModule )
  openedModule = will.moduleAt( opener.willfilesPath );

  if( openedModule )
  {

    _.assert( openedModule.rootModule === opener.rootModule || opener.rootModule === null );
    _.assert( opener.openedModule === openedModule || opener.openedModule === null );
    opener.openedModule = openedModule;

    // debugger;
    _.assert( !openedModule.willfileArray.length || _.arrayIdentical( opener.willfileArray, openedModule.willfileArray ) );
    // debugger;
    openedModule.willfileArray = _.entityShallowClone( opener.willfileArray );
    // openedModule.willfileWithRoleMap = _.entityShallowClone( opener.willfileWithRoleMap );
    // debugger;

  }
  else
  {
    _.assert( opener.openedModule === null );
    let o2 = opener.optionsForModule();
    // debugger;
    openedModule = opener.openedModule = new will.OpenedModule( o2 );
    if( openedModule.rootModule === null )
    openedModule.rootModule = openedModule;
    openedModule.preform();
  }

  _.assert( _.arrayIdentical( opener.willfileArray, opener.openedModule.willfileArray ) );
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

  _.arrayRemoveElementOnceStrictly( opener.willfileArray, willf );

  if( willf.role )
  {
    _.assert( opener.willfileWithRoleMap[ willf.role ] === willf )
    delete opener.willfileWithRoleMap[ willf.role ];
  }

  // if( willf.openerModule === opener )
  // willf.openerModule = null;
}

//

function willfileRegister( willf )
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayAppendOnceStrictly( opener.willfileArray, willf );

  if( willf.role )
  {
    _.assert( !opener.willfileWithRoleMap[ willf.role ], 'Module already has willfile with role', willf.role )
    opener.willfileWithRoleMap[ willf.role ] = willf;
  }

  if( willf.openerModule === null )
  willf.openerModule = opener;

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

  /* common dir path */

  let willfilesPath = _.strCommonLeft.apply( _, _.arrayAs( opener.willfilesPath ) );

  /* dir path */

  let dirPath;
  let fname = path.fullName( willfilesPath );

  if( o.lookingDir )
  if( o.isNamed || fname === '' || fname === '.' || opener.WillfilePathIs( fname ) )
  {
    dirPath = path.dir( willfilesPath );
  }

  if( !dirPath )
  dirPath = willfilesPath;

  /* name path */

  let namePath = '.';
  if( o.isNamed )
  {
    namePath = path.fullName( path.relative( path.parse( dirPath ).longPath, path.parse( willfilesPath ).longPath ) );
    namePath = _.strReplace( namePath, /(\.ex|\.im|)\.will(\.\w+)?$/, '' );
    if( namePath === '' || namePath === '.' )
    {
      return null;
    }
    _.assert( namePath.length > 0 );
  }

  /* */

  if( opener.willfileWithRoleMap[ o.role ] )
  return null;

  /* */

  let filePath;
  if( o.isOutFile )
  {

    if( !_.strEnds( namePath, '.out' ) )
    namePath = _.strJoinPath( [ namePath, 'out' ], '.' );

    if( o.isNamed )
    {
      let name = _.strJoinPath( [ namePath, opener.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( dirPath, '.', name );
    }
    else
    {
      let name = _.strJoinPath( [ namePath, opener.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( dirPath, name );
    }

  }
  else
  {

    if( o.isNamed )
    {
      let name = _.strJoinPath( [ namePath, opener.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( dirPath, '.', name );
    }
    else
    {
      let name = opener.prefixPathForRole( o.role );
      filePath = path.resolve( dirPath, namePath, name );
    }

  }

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

  if( !o.isNamed && !o.lookingDir )
  {
    /* try to find other split files */
    debugger;
    let found = opener._willfileFindMultiple
    ({
      isOutFile : o.isOutFile,
      isNamed : o.isNamed,
      lookingDir : 1,
    });
    debugger;
  }

  return willf;
}

_willfileFindSingle.defaults =
{
  role : null,
  isOutFile : 0,
  isNamed : 0,
  lookingDir : 1,
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
      isNamed : o.isNamed,
      lookingDir : o.lookingDir,
    });

  }

  let filePaths = filePathsGet( files );
  if( filePaths.length )
  {
    if( o.isNamed )
    namedNameDeduce();
    else
    notNamedNameDeduce();
    return end( filePaths );
  }

  return false;

  /* */

  function namedNameDeduce()
  {
    for( let w = 0 ; w < opener.willfileArray.length ; w++ )
    {
      let willfile = opener.willfileArray[ w ];
      let name = path.name( willfile.filePath );
      name = _.strRemoveEnd( name, '.will' );
      name = _.strRemoveEnd( name, '.im' );
      name = _.strRemoveEnd( name, '.ex' );
      _.assert( opener.configName === null || opener.configName === name, 'Name of will files should be the same, something wrong' );
      if( name )
      opener.configName = name;
    }
  }

  /* */

  function notNamedNameDeduce()
  {
    opener.configName = path.fullName( path.dir( filePaths[ 0 ] ) );
  }

  /* - */

  function filePathsGet()
  {
    let filePaths = [];
    if( files.single )
    filePaths.push( files.single.filePath );
    if( files.import )
    filePaths.push( files.import.filePath );
    if( files.export )
    filePaths.push( files.export.filePath );
    return filePaths;
  }

  /* */

  function end( filePaths )
  {
    let filePath = opener.DirPathFromFilePaths( filePaths );
    if( _.arrayIs( filePaths ) && filePaths.length === 1 )
    filePaths = filePaths[ 0 ];

/*
    let amodule = rootModule.moduleAt( opener.commonPath );
    if( amodule )
    {
      debugger; xxx

      for( let a = 0 ; a < opener.submoduleAssociation.length ; a++ )
      {
        let submodule = opener.submoduleAssociation[ a ];
        _.assert( submodule.oModule === opener );
        submodule.oModule = amodule;
      }
      debugger;
      opener.submoduleAssociation.splice();

      opener.finit();

      return true;
    }
*/

    opener._filePathChange( filePaths );

    return true;
  }

}

_willfileFindMultiple.defaults =
{
  isOutFile : 0,
  isNamed : 0,
  lookingDir : 1,
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

  _.assert( opener.willfileArray.length === 0, 'not tested' );

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
      isNamed : 1,
      lookingDir : 1,
    });
    if( found )
    return found;

    found = opener._willfileFindMultiple
    ({
      isOutFile : isOutFile,
      isNamed : 1,
      lookingDir : 0,
    });
    if( found )
    return found;

    found = opener._willfileFindMultiple
    ({
      isOutFile : isOutFile,
      isNamed : 0,
      lookingDir : 1,
    });
    if( found )
    return found;

    found = opener._willfileFindMultiple
    ({
      isOutFile : isOutFile,
      isNamed : 0,
      lookingDir : 0,
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

    if( opener.willfileArray.length )
    _.assert( !!opener.willfilesPath && !!opener.dirPath );

  }
  catch( err )
  {
    err = _.err( 'Error looking for will files for', opener.nickName, 'at', _.strQuote( opener.commonPath ), '\n', err );
    opener.error = err;
  }

  if( opener.willfileArray.length === 0 )
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

  return opener.willfileArray.slice();
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

  for( let w = 0 ; w < opener.willfileArray.length ; w++ )
  {
    let willfile = opener.willfileArray[ w ];
    onEach( willfile )
  }

  for( let s in opener.submoduleMap )
  {
    let submodule = opener.submoduleMap[ s ];
    if( !submodule.oModule )
    continue;

    for( let w = 0 ; w < submodule.oModule.willfileArray.length ; w++ )
    {
      let willfile = submodule.oModule.willfileArray[ w ];
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

function willfileArraySet( willfileArray )
{
  let opener = this;
  _.assert( _.arrayIs( willfileArray ) );

  if( opener.willfileArray === willfileArray )
  return opener.willfileArray;

  for( let w = opener.willfileArray.length-1 ; w >= 0 ; w-- )
  {
    // debugger;
    let willf = opener.willfileArray[ w ];
    opener.willfileUnregister( willf );
  }

  for( let w = 0 ; w < willfileArray.length ; w++ )
  {
    // debugger;
    let willf = willfileArray[ w ];
    opener.willfileRegister( willf );
  }

  return opener.willfileArray;
}

// function rootModuleGet()
// {
//   let opener = this;
//   if( opener.supermodule )
//
//   // debugger;
//   while( opener.supermodule )
//   opener = opener.supermodule;
//
//   return opener;
// }

// //
//
// function moduleAt( willfilesPath )
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let rootModule = opener.rootModule;
//
//   _.assert( arguments.length === 1 );
//
//   let commonPath = opener.CommonPathFor( willfilesPath );
//
//   return will.moduleWithPathMap[ commonPath ];
// }
//
// //
//
// function modulePathRegister()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let rootModule = opener.rootModule;
//
//   // _.assert( !opener.original );
//   _.assert( arguments.length === 0 );
//
//   _.assert( will.moduleWithPathMap[ opener.commonPath ] === opener || will.moduleWithPathMap[ opener.commonPath ] === undefined );
//   will.moduleWithPathMap[ opener.commonPath ] = opener;
//   _.assert( _.arrayCountElement( _.mapVals( will.moduleWithPathMap ), opener ) === 1 );
//
// }
//
// //
//
// function modulePathUnregister()
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let rootModule = opener.rootModule;
//
//   // _.assert( !opener.original );
//   _.assert( arguments.length === 0 );
//   _.assert( _.strIs( opener.commonPath ) );
//
//   _.assert( will.moduleWithPathMap[ opener.commonPath ] === opener || will.moduleWithPathMap[ opener.commonPath ] === undefined );
//   delete will.moduleWithPathMap[ opener.commonPath ];
//   _.assert( _.arrayCountElement( _.mapVals( will.moduleWithPathMap ), opener ) === 0 );
//
// }
//
// //
//
// function submoduleRegister( submodule )
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let rootModule = opener.rootModule;
//
//   _.assert( arguments.length === 1 );
//   _.assert( opener.rootModule === opener );
//   _.assert( submodule.shortNameArrayGet().length > 1 );
//   _.assert( !!opener.allSubmodulesMap );
//
//   /* */
//
//   register( submodule.shortNameArrayGet().join( '.' ) );
//   register( submodule.name );
//
//   /* */
//
//   function register( name )
//   {
//     let name0 = name;
//     let counter = 1;
//     while( opener.allSubmodulesMap[ name ] )
//     {
//       counter += 1;
//       name = name0 + '.' + counter;
//     }
//     opener.allSubmodulesMap[ name ] = submodule;
//   }
//
// }
//
// // submoduleRegister.default =
// // {
// //   submodule : null,
// //   // shortName : null,
// //   // longName : null,
// // }

//
// //
//
// function submoduleRegister( o )
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let rootModule = opener.rootModule;
//
//   _.assert( arguments.length === 1 );
//   _.assertRoutineOptions( submoduleRegister, arguments );
//
//   if( submodule.opener === opener )
//   {
//     _.assert( submodule.name === o.shortName );
//     _.assert( opener.submoduleMap[ submodule.name ] === submodule )
//   }
//   else
//   {
//     debugger;
//
//     let shortName = o.shortName;
//     if( opener.submoduleMap[ shortName ] !== submodule )
//     {
//       if( opener.submoduleMap[ shortName ] )
//       debugger;
//       if( opener.submoduleMap[ shortName ] )
//       shortName = opener.resourceNameAllocate( 'submodule', shortName );
//       opener.submoduleMap[ shortName ] = submodule;
//     }
//
//     if( o.shortName !== o.longName )
//     {
//       let longName = o.longName;
//       if( opener.submoduleMap[ longName ] !== submodule )
//       {
//         if( opener.submoduleMap[ longName ] )
//         debugger;
//         if( opener.submoduleMap[ longName ] )
//         longName = opener.resourceNameAllocate( 'submodule', longName );
//         opener.submoduleMap[ longName ] = submodule;
//       }
//     }
//
//   }
//
//   if( opener.supermodule )
//   {
//     debugger;
//     let longName = ( opener.aliasName || opener.name || '' ) + '.' + o.longName;
//     opener.supermodule.submoduleRegister
//     ({
//       submodule : submodule,
//       longName : longName,
//       shortName : o.shortName,
//     });
//   }
//
// }
//
// submoduleRegister.default =
// {
//   submodule : null,
//   shortName : null,
//   longName : null,
// }

// //
//
// function submoduleNameAllocate( name )
// {
//   let opener = this;
//   let will = opener.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let rootModule = opener.rootModule;
//
//   _.assert( arguments.length === 1 );
//
//
//
//   return will.moduleWithPathMap[ commonPath ];
// }

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

  /* */

  if( !opener.localPath )
  if( opener.dirPath )
  {
    _.assert( _.strIs( opener.dirPath ) );
    // opener.localPath = opener.dirPath; // yyy
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
    opener.isDownloaded = 1;
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
  opener.localPath = path.resolve( submodulesDir, opener.aliasName );

  // debugger;

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

    // debugger;
    if( !o.dry )
    // if( opener.willfilesOpenReady.errorsCount() || !opener.isDownloaded )
    // if( opener.error || !opener.isDownloaded )
    if( !opener.isValid() || !opener.isDownloaded )
    {
      // logger.log( '_remoteDownload/filesDelete', opener.localPath );
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
    opener.isUpToDate = true;
    opener.isDownloaded = true;
    if( o.forming && !o.dry && downloading )
    {

      // _.assert( opener.stager.stageStatePerformed( 'preformed' ) );
      debugger;
      let willf = opener.willfileArray[ 0 ];
      opener.close();
      _.assert( !_.arrayHas( will.willfileArray, willf ) );
      opener.open();
      // debugger;

      opener.openedModule.stager.stageStatePausing( 'opened', 0 );
      opener.openedModule.stager.stageStateSkipping( 'submodulesFormed', 1 );
      opener.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
      opener.openedModule.stager.tick();
      // debugger;
      // opener.willfilesFind();

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
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  // will.modulePathUnregister( opener );

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

  opener.willfilesPath = willfilesPath;
  opener[ dirPathSymbol ] = dirPath;
  opener[ commonPathSymbol ] = commonPath;

  if( opener.openedModule )
  debugger;
  if( opener.openedModule )
  opener.openedModule._filePathChange( willfilesPath );

  // opener._dirPathChange( dirPath );
  // opener._commonPathChange( commonPath );
  // will.modulePathRegister( opener );

  return opener;
}


//

function _filePathChanged()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  // let dirPath = opener.willfilesPath;
  // if( _.arrayIs( dirPath ) )
  // dirPath = dirPath[ 0 ];
  // if( _.strIs( dirPath ) )
  // dirPath = path.dir( dirPath );
  // if( dirPath === null )
  // dirPath = opener.dirPath;

  opener._filePathChange( opener.willfilesPath );

}

//

function inPathGet()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !opener.openedModule )
  return null;

  return opener.openedModule.inPath;
  // return path.s.join( opener.dirPath, ( opener[ inPathSymbol ] || '.' ) );
  // return path.s.join( opener.dirPath, ( opener.pathMap.in || '.' ) );
}

//

function outPathGet()
{
  let opener = this;
  let will = opener.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !opener.openedModule )
  return null;

  return opener.openedModule.outPath;
}

//

function predefinedPathGet_functor( fieldName )
{
  let symbol = Symbol.for( fieldName );

  return function predefinedPathGet()
  {
    let opener = this;
    let openedModule = opener.openedModule;

    if( openedModule )
    return openedModule[ fieldName ];

    return opener[ symbol ];
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

    if( openedModule )
    openedModule[ fieldName ] = filePath;
  }

}

let willfilesPathGet = predefinedPathGet_functor( 'willfilesPath' );
let dirPathGet = predefinedPathGet_functor( 'dirPath' );
let commonPathGet = predefinedPathGet_functor( 'commonPath' );
let localPathGet = predefinedPathGet_functor( 'localPath' );
let remotePathGet = predefinedPathGet_functor( 'remotePath' );
let willPathGet = predefinedPathGet_functor( 'willPath' );

let willfilesPathSet = predefinedPathSet_functor( 'willfilesPath' );
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
  name = opener.aliasName;

  if( !name && opener.openedModule && opener.openedModule.about )
  name = opener.openedModule.about.name;

  if( !name && opener.configName )
  name = opener.configName;

  if( !name && opener.commonPath )
  name = path.fullName( opener.commonPath );

  return name;
}

//

function nameChanged()
{
  let opener = this;
  let will = opener.will;

  if( !will )
  return;

}

//

function aliasNameSet( src )
{
  let opener = this;
  opener[ aliasSymbol ] = src;
  opener.nameChanged();
}

// //
//
// function nickNameGet()
// {
//   let opener = this;
//   let name = opener.name;
//   return 'module' + '::' + name;
// }
//
// //
//
// function decoratedNickNameGet()
// {
//   let opener = this;
//   let result = opener.nickName;
//   return _.color.strFormat( result, 'entity' );
// }
//
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

// //
//
// function decoratedAbsoluteNameGet()
// {
//   let opener = this;
//   let result = opener.absoluteName;
//   return _.color.strFormat( result, 'entity' );
// }

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
let dirPathSymbol = Symbol.for( 'dirPath' );
let commonPathSymbol = Symbol.for( 'commonPath' );
let aliasSymbol = Symbol.for( 'aliasName' );
let supermoduleSymbol = Symbol.for( 'supermodule' );
let rootModuleSymbol = Symbol.for( 'rootModule' );
let willPathSymbol = Symbol.for( 'willPath' );
let willfileWithRoleMapSymbol = Symbol.for( 'willfileWithRoleMap' );
let willfileArraySymbol = Symbol.for( 'willfileArray' );

let Composes =
{

  willfilesPath : null,
  pickedWillfilesPath : null,
  localPath : null,
  remotePath : null,

  isRemote : null, // xxx
  isDownloaded : null, // xxx
  isUpToDate : null, // xxx
  finding : 1,

  aliasName : null,
  configName : null,

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
  // submoduleAssociation : _.define.own([]),
  pickedWillfileData : null,

  willfileArray : _.define.own([]),
  // willfileWithRoleMap : _.define.own({}),

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
  opened : 0,
  error : null,

  // openerModule : null,
  // _proxy : null,

  openedModule : null,
  openerModule : null,
  unwrappedOpenerModule : null,

  willfilesReadBeginTime : null,
  // willfilesReadTimeReported : 0,

  // moduleWithPathMap : null,
  // moduleWithNameMap : null,
  // allSubmodulesMap : null,

}

let Statics =
{

  // WillfilePathIs,
  // DirPathFromFilePaths,
  // CommonPathFor,
  // CloneDirPathFor,
  // OutfilePathFor,

}

let Forbids =
{
  // inPath : 'inPath',
  // outPath : 'outPath',
  moduleWithPathMap : 'moduleWithPathMap',
  allSubmodulesMap : 'allSubmodulesMap',
  moduleWithNameMap : 'moduleWithNameMap',
  willfilesReadTimeReported : 'willfilesReadTimeReported',
  // supermodule : 'supermodule'
  submoduleAssociation : 'submoduleAssociation',
  currentRemotePath : 'currentRemotePath',
}

let Accessors =
{

  inPath : { getter : inPathGet, readOnly : 1 },
  outPath : { getter : outPathGet, readOnly : 1 },
  commonPath : { getter : commonPathGet, readOnly : 1 },
  willfilesPath : { getter : willfilesPathGet, setter : willfilesPathSet },
  dirPath : { getter : dirPathGet, readOnly : 1 },
  localPath : { getter : localPathGet, setter : localPathSet },
  remotePath : { getter : remotePathGet, setter : remotePathSet },
  willPath : { getter : willPathGet, readOnly : 1 },

  name : { getter : nameGet, readOnly : 1 },
  aliasName : { setter : aliasNameSet },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },

  supermodule : { getter : supermoduleGet, setter : supermoduleSet },
  rootModule : { getter : rootModuleGet, setter : rootModuleSet },
  willfileArray : { setter : willfileArraySet },
  willfileWithRoleMap : { readOnly : 1 },

}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,
  optionsForModule,
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

  isOpened,
  isValid,
  _openEnd,

  willfileUnregister,
  willfileRegister,

  _willfileFindSingle,
  _willfileFindMultiple,
  _willfilesFindMaybe,
  _willfilesFindPickedFile,
  _willfilesFind,
  // willfilesFind,
  willfilesPick,

  willfilesReadBegin,

  _willfilesExport,
  willfileEach,

  // submodule

  supermoduleGet,
  supermoduleSet,
  rootModuleGet,
  rootModuleSet,
  willfileArraySet,

  // moduleAt,
  // modulePathRegister,
  // modulePathUnregister,
  // submoduleRegister,

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
  inPathGet,
  outPathGet,

  willfilesPathGet,
  dirPathGet,
  commonPathGet,
  localPathGet,
  remotePathGet,
  willPathGet,

  willfilesPathSet,
  localPathSet,
  remotePathSet,

  // name

  nameGet,
  nameChanged,
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
  extend : Proto,
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
