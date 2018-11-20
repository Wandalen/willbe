( function _Module_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillModule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Module';

// --
// inter
// --

function finit()
{
  let module = this;

  if( module.formed )
  module.unform();

  module.about.finit();
  module.execution.finit();

  for( let i in module.exportedMap )
  module.exportedMap[ i ].finit();

  for( let i in module.buildMap )
  module.buildMap[ i ].finit();

  for( let i in module.stepMap )
  module.stepMap[ i ].finit();

  for( let i in module.reflectorMap )
  module.reflectorMap[ i ].finit();

  for( let i in module.pathObjMap )
  module.pathObjMap[ i ].finit();

  for( let i in module.submoduleMap )
  module.submoduleMap[ i ].finit();

  for( let i = 0 ; i < module.willFileArray.length ; i++ )
  module.willFileArray[ i ].finit();

  _.assert( _.instanceIsFinited( module.about ) );
  if( module.execution )
  _.assert( _.instanceIsFinited( module.execution ) );
  if( module.export )
  _.assert( _.instanceIsFinited( module.export ) );

  _.assert( module.willFileArray.length === 0 );

  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init( o )
{
  let module = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( module );
  Object.preventExtensions( module );

  if( o )
  module.copy( o );

  let will = module.will;

  _.assert( !!will );

  module.stager = new _.Stager
  ({
    object : module,
    stageNames : [ 'formed', 'willFilesFound', 'willFilesOpened', 'resourcesFormed' ],
    consequenceNames : [ 'formReady', 'willFilesFindReady', 'willFilesOpenReady', 'resourcesFormReady' ],
    finals : [ 3, 2, 2, 2 ],
    verbosity : will.verbosity && will.verboseStaging,
  });

}

//

function unform()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );
  _.assert( !!module.formed );

  /* begin */

  for( let k in module.submoduleMap )
  module.submoduleMap[ k ].finit()
  for( let k in module.reflectorMap )
  module.reflectorMap[ k ].finit()
  for( let k in module.stepMap )
  module.stepMap[ k ].finit()
  for( let k in module.buildMap )
  module.buildMap[ k ].finit()

  _.assert( Object.keys( module.submoduleMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );

  for( let i = module.willFileArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = module.willFileArray[ i ];
    _.assert( Object.keys( willf.submoduleMap ).length === 0 );
    _.assert( Object.keys( willf.reflectorMap ).length === 0 );
    _.assert( Object.keys( willf.stepMap ).length === 0 );
    _.assert( Object.keys( willf.buildMap ).length === 0 );
    willf.finit()
  }

  _.assert( module.willFileArray.length === 0 );
  _.assert( Object.keys( module.willFileWithRoleMap ).length === 0 );
  _.assert( will.moduleMap[ module.dirPath ] === module );

  _.arrayRemoveElementOnceStrictly( will.moduleArray, module );
  delete will.moduleMap[ module.dirPath ];

  /* end */

  module.formed = 0;
  return module;
}

//

function form()
{
  let module = this;
  let will = module.will;
  let con = new _.Consequence().give( null );

  _.assert( arguments.length === 0 );
  _.assert( !module.formReady.resourcesHas() )

  con.ifNoErrorThen( () => module.form1() );
  con.ifNoErrorThen( () => module.form2() );

  return module;
}

//

function form1()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( !!module.dirPath );
  _.assert( arguments.length === 0 );
  _.assert( !module.formed );
  _.assert( !!module.will );

  module.stager.stage( 'formed', 1 );
  module.dirPath = path.normalize( module.dirPath );

  if( will.moduleMap[ module.dirPath ] !== undefined )
  {
    debugger;
    throw _.err( 'Module at ' + _.strQuote( module.dirPath ) + ' were defined more than once!' );
  }

  /* */

  _.arrayAppendOnceStrictly( will.moduleArray, module );
  _.sure( !will.moduleMap[ module.dirPath ], () => 'Module at ' + _.strQuote( module.dirPath ) + ' already exists!' );
  will.moduleMap[ module.dirPath ] = module;
  module.stager.stage( 'formed', 2 );

  return module;
}

//

function form2()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );
  _.assert( module.formed === 2 );
  _.assert( !!module.will );
  _.assert( will.moduleMap[ module.dirPath ] === module );
  _.assert( !!module.dirPath );

  /* begin */

  module.predefinedForm();
  module.remoteForm();

  /* end */

  module.stager.stage( 'formed', 3 );
  return module;
}

//

function predefinedForm()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );

  new will.Step
  ({
    name : 'predefined.delete',
    stepRoutine : will.Predefined.stepRoutineDelete,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'predefined.reflect',
    stepRoutine : will.Predefined.stepRoutineReflect,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'submodules.download',
    stepRoutine : will.Predefined.stepRoutineSubmodulesDownload,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'submodules.upgrade',
    stepRoutine : will.Predefined.stepRoutineSubmodulesUpgrade,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'submodules.clean',
    stepRoutine : will.Predefined.stepRoutineSubmodulesClean,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'clean',
    stepRoutine : will.Predefined.stepRoutineClean,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'export',
    stepRoutine : will.Predefined.stepRoutineExport,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Reflector
  ({
    name : 'predefined.common',
    srcFilter :
    {
      maskAll :
      {
        excludeAny : [ /(^|\/)-/ ],
      }
    },
    criterion :
    {
      predefined : 1,
    },
    module : module,
  }).form1();

  new will.Reflector
  ({
    name : 'predefined.debug',
    srcFilter :
    {
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 1,
      predefined : 1,
    },
    module : module,
  }).form1();

  new will.Reflector
  ({
    name : 'predefined.release',
    srcFilter :
    {
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 0,
      predefined : 1,
    },
    module : module,
  }).form1();

/*
  .predefined.common :
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/(^|\/)-/'

  .predefined.debug :
    inherit : .predefined.common
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.release($|\.|\/)/i'

  .predefined.release :
    inherit : .predefined.common
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.debug($|\.|\/)/i'
        - !!js/regexp '/\.test($|\.|\/)/i'
        - !!js/regexp '/\.experiment($|\.|\/)/i'
*/

}

//

function cleanWhat( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let exps = module.exportsSelect();
  let filePaths = [];

  o = _.routineOptions( cleanWhat, arguments );

  /* submodules */

  if( o.cleaningSubmodules )
  {

    let find = fileProvider.filesFinder
    ({
      verbosity : 0,
      allowingMissing : 1,
      recursive : 1,
      includingDirs : 1,
      includingTerminals : 1,
      outputFormat : 'absolute',
      maskPreset : 0,
    });

    for( let s in module.submoduleMap )
    {
      let submodule = module.submoduleMap[ s ];
      let submodulesCloneDirPath = module.submodulesCloneDirGet();
      let found = find( submodulesCloneDirPath );

      _.arrayFlattenOnce( filePaths, found );
    }

  }

  /* out */

  if( o.cleaningOut )
  {

    for( let e = 0 ; e < exps.length ; e++ )
    {
      let exp = exps[ e ];
      let archiveFilePath = exp.archiveFilePathFor();
      let outFilePath = exp.outFilePathFor();

      if( fileProvider.fileExists( archiveFilePath ) )
      _.arrayFlattenOnce( filePaths, archiveFilePath );

      if( fileProvider.fileExists( outFilePath ) )
      _.arrayFlattenOnce( filePaths, outFilePath );

    }

  }

  /* temp dir */

  if( o.cleaningTemp )
  {

    let temp = module.pathMap.temp ? _.arrayAs( module.pathMap.temp ) : [];
    temp = path.s.resolve( module.dirPath, temp );
    let found = fileProvider.filesFind
    ({
      filePath : temp,
      verbosity : 0,
      allowingMissing : 1,
      recursive : 1,
      includingDirs : 1,
      includingTerminals : 1,
      outputFormat : 'absolute',
    });

    _.arrayFlattenOnce( filePaths, found );

  }

  return filePaths;
}

cleanWhat.defaults =
{
  cleaningSubmodules : 1,
  cleaningOut : 1,
  cleaningTemp : 1,
}

//

function clean()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let filePaths = module.cleanWhat.apply( module, arguments );

  for( let f = filePaths.length-1 ; f >= 0 ; f-- )
  {
    let filePath = filePaths[ f ];
    _.assert( path.isAbsolute( filePath ) );
    fileProvider.fileDelete({ filePath : filePath, verbosity : 1, throwing : 0 });
  }

  if( logger.verbosity >= 2 )
  logger.log( ' - Clean deleted ' + filePaths.length + ' file(s)' );

  return filePaths;
}

clean.defaults = Object.create( cleanWhat.defaults );

// --
// opener
// --

function DirPathFromWillFilePath( inPath )
{
  let module = this;
  _.assert( arguments.length === 1 );
  let r = /(.*)(?:\.will(?:\.|$).*)/;
  let parsed = r.exec( inPath );

  if( !parsed )
  return r;
  else
  return parsed[ 1 ];
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

//

function _willFileFindMaybe( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( _willFileFindMaybe, arguments );
  _.assert( _.strDefined( o.role ) );
  _.assert( !module.willFilesFindReady.resourcesHas() );
  _.assert( !module.willFilesOpenReady.resourcesHas() );
  _.assert( !module.resourcesFormReady.resourcesHas() );

  if( module.willFileWithRoleMap[ o.role ] )
  return null;

  // debugger;

  let filePath;
  if( o.isInFile )
  {
    if( o.isInside )
    {
      let name = module.prefixPathForRole( o.role );
      filePath = path.resolve( module.dirPath, o.dirPath, name );
    }
    else
    {
      let name = _.strJoinPath( [ o.dirPath, module.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( module.dirPath, name );
    }
  }
  else
  {
    let name = _.strJoinPath( [ o.dirPath, '.out', module.prefixPathForRole( o.role ) ], '.' );
    filePath = path.resolve( module.dirPath, name );
    // debugger;
  }

  new will.WillFile
  ({
    role : o.role,
    filePath : filePath,
    module : module,
  }).form1();

  let result = module.willFileWithRoleMap[ o.role ];

  if( result.exists() )
  {
    // logger.log( ' +', 'will file', filePath, );
    return result;
  }
  else
  {
    result.finit();
    // logger.log( ' -', 'will file', filePath, );
    return null;
  }

}

_willFileFindMaybe.defaults =
{
  role : null,
  dirPath : null,
  isInFile : 1,
  isInside : 1,
}

//

function _willFilesFindMaybe( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( _willFilesFindMaybe, arguments );

  _.assert( module.willFileArray.length === 0, 'not tested' );
  _.assert( !module.willFilesFindReady.resourcesHas() );
  _.assert( !module.willFilesOpenReady.resourcesHas() );
  _.assert( !module.resourcesFormReady.resourcesHas() );

  /* */

  let files = Object.create( null );

  files.outerSingle = module._willFileFindMaybe
  ({
    role : 'single',
    dirPath : path.join( '..', path.fullName( module.dirPath ) ),
    isInFile : o.isInFile,
    isInside : 0,
  })

  if( o.isInFile )
  {

    files.outerImport = module._willFileFindMaybe
    ({
      role : 'import',
      dirPath : path.join( '..', path.fullName( module.dirPath ) ),
      isInFile : o.isInFile,
      isInside : 0,
    });

    files.outerExport = module._willFileFindMaybe
    ({
      role : 'export',
      dirPath : path.join( '..', path.fullName( module.dirPath ) ),
      isInFile : o.isInFile,
      isInside : 0,
    });

  }

  if( files.outerSingle || files.outerImport || files.outerExport )
  {
    module.stager.stage( 'willFilesFound', 2 );
    return true;
  }

  /* - */

  files.innerSingle = module._willFileFindMaybe
  ({
    role : 'single',
    dirPath : '.',
    isInFile : o.isInFile,
    isInside : 1,
  });

  if( o.isInFile )
  {

    files.innerImport = module._willFileFindMaybe
    ({
      role : 'import',
      dirPath : '.',
      isInFile : o.isInFile,
      isInside : 1,
    });

    files.innerExport = module._willFileFindMaybe
    ({
      role : 'export',
      dirPath : '.',
      isInFile : o.isInFile,
      isInside : 1,
    });

  }

  if( files.innerSingle || files.innerImport || files.innerExport )
  {
    module.stager.stage( 'willFilesFound', 2 );
    return true;
  }

  return null;
}

_willFilesFindMaybe.defaults =
{
  isInFile : 1,
}

//

function willFilesFind()
{
  let module = this;
  let will = module.will;

  _.assert( module.willFilesFound === 0 );

  module.stager.stage( 'willFilesFound', 1 );

  module.formReady
  .ifNoErrorGot( () =>
  {
    let result = module._willFilesFindMaybe({ isInFile : !module.supermodule });

    if( !result )
    {
      // debugger;
      if( module.supermodule )
      throw _.err( 'Found no .out.will file for', module.nickName, 'at', _.strQuote( module.dirPath ) );
      else
      throw _.err( 'Found no', module.nickName, 'at', _.strQuote( module.dirPath ) );
    }

    result = _.Consequence.From( result );
    _.assert( _.consequenceIs( result ) );

    result.doThen( ( err, arg ) =>
    {
      if( !err && module.willFileArray.length === 0 )
      throw _.errLogOnce( 'Found no', module.nickName, 'at', _.strQuote( module.dirPath ) );

      if( err )
      throw _.errLogOnce( 'Found no', module.nickName, 'at', _.strQuote( module.dirPath ), '\n', err );

      return arg;
    });

    return result;
  })
  .doThen( ( err, arg ) =>
  {
    if( err )
    {
      if( will.verbosity && will.verboseStaging )
      console.log( ' s', module.nickName, 'willFilesFound', 'failed' );
      // debugger;
      module.willFilesFindReady.error( err );
      throw err;
    }
    return arg;
  });

  return module.formReady.split();
}

willFilesFind.defaults = Object.create( _willFilesFindMaybe.defaults );

//

function willFilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  module.stager.stage( 'willFilesOpened', 1 );

  module.willFilesFindReady.ifNoErrorThen( ( arg ) =>
  {
    return module._willFilesOpen();
  })
  .doThen( ( err, arg ) =>
  {
    if( err )
    {
      if( will.verbosity && will.verboseStaging )
      console.log( ' s', module.nickName, 'willFilesOpened', 'failed' );
      // debugger;
      module.willFilesOpenReady.error( err );
      throw err;
    }
    return arg;
  });

  return module.willFilesFindReady.split();
}

//

function _willFilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().give( null );

  _.assert( arguments.length === 0 );
  _.sure( !!_.mapKeys( module.willFileWithRoleMap ).length && !!module.willFileArray.length, () => 'Found no will file at ' + _.strQuote( module.dirPath ) );

  for( let i = 0 ; i < module.willFileArray.length ; i++ )
  {
    let willFile = module.willFileArray[ i ];

    _.assert( willFile.formed === 1 || willFile.formed === 2, 'not expected' );

    if( willFile.formed === 2 )
    continue;

    con.ifNoErrorThen( ( arg ) => willFile.open() );

  }

  con.ifNoErrorThen( ( arg ) => module._resourcesSubmodulesForm() );
  con.ifNoErrorThen( ( arg ) =>
  {
    module.stager.stage( 'willFilesOpened', 2 );
    return arg;
  });

  return con.split();
}

// --
// submodule
// --

function submodulesAreDownloaded()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !module.supermodule );

  for( let n in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ n ].loadedModule;
    if( !submodule )
    return false;
    if( !submodule.isDownloaded )
    return false;
  }

  return true;
}

//

function _submodulesDownload( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let downloadedNumber = 0;
  let remoteNumber = 0;
  let totalNumber = _.mapKeys( module.submoduleMap ).length;
  let time = _.timeNow();
  let con = new _.Consequence().give( null );

  _.assert( module.formed === 3 );
  _.assert( arguments.length === 1 );
  _.routineOptions( _submodulesDownload, arguments );

  logger.up();

  for( let n in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ n ].loadedModule;
    _.assert( !!submodule && submodule.formed === 3 );
    if( !submodule.isRemote )
    continue;

    con.ifNoErrorThen( () =>
    {
      if( o.upgrading && submodule.isDownloaded )
      return submodule.remoteIsUpToDate()
      return null;
    });

    con.ifNoErrorThen( () =>
    {
      remoteNumber += 1;
      if( o.upgrading )
      {
        if( !submodule.isDownloaded )
        downloadedNumber += 1;
        else if( !submodule.isUpToDate )
        downloadedNumber += 1;
      }
      else
      {
        if( !submodule.isDownloaded )
        downloadedNumber += 1;
      }
      return submodule._remoteDownload({ upgrading : o.upgrading });
    });

  }

  con.doThen( ( err, arg ) =>
  {
    logger.down();
    if( err )
    throw _.err( 'Failed to', ( o.upgrading ? 'upgrade' : 'download' ), module.nickName, '\n', err );
    logger.rbegin({ verbosity : -2 });
    logger.log( ' + ' + downloadedNumber + /*'/' + remoteNumber +*/ '/' + totalNumber + ' submodule(s) of ' + module.nickName + ' were ' + ( o.upgrading ? 'upgraded' : 'downloaded' ) + ' in ' + _.timeSpent( time ) );
    logger.rend({ verbosity : -2 });
    return arg;
  });

  return con;
}

_submodulesDownload.defaults =
{
  upgrading : 0,
}

//

function submodulesDownload()
{
  let module = this;
  let will = module.will;

  _.assert( module.formed === 3 );
  _.assert( arguments.length === 0 );

  return module._submodulesDownload({ upgrading : 0 });
}

//

function submodulesUpgrade()
{
  let module = this;
  let will = module.will;

  _.assert( module.formed === 3 );
  _.assert( arguments.length === 0 );

  return module._submodulesDownload({ upgrading : 1 });
}

//

function submodulesClean()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.assert( module.formed === 3 );
  _.assert( arguments.length === 0 );

  let result = module.clean
  ({
    cleaningSubmodules : 1,
    cleaningOut : 0,
    cleaningTemp : 0,
  });

  return result;
}

// --
// remote
// --

function remoteIsRemote()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let fileProvider2 = fileProvider.providerForPath( module.dirPath );
  if( fileProvider2.limitedImplementation )
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

function remoteIsDownloaded()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.clonePath ) );
  _.assert( _.strDefined( module.dirPath ) );
  _.assert( module.isRemote === true );

  let fileProvider2 = fileProvider.providerForPath( module.remotePath );
  _.assert( !!fileProvider2.limitedImplementation );

  // let result = fileProvider.resolvedIsDir( module.clonePath ) && fileProvider.dirRead( module.clonePath ).length > 0

  let result = fileProvider2.isDownloaded
  ({
    remotePath : module.remotePath,
    localPath : module.clonePath,
  });

  // return end( result );

  if( !result )
  return end( result );

  return _.Consequence.From( result )
  .doThen( ( err, arg ) =>
  {
    end( arg );
    if( err )
    throw err;
    return arg;
  });

  /* */

  function end( result )
  {
    // _.assert( _.boolIs( result ) );
    module.isDownloaded = !!result;
    return result;
  }
}

//

function remoteIsUpToDate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.clonePath ) );
  _.assert( _.strDefined( module.dirPath ) );
  _.assert( module.isRemote === true );

  let fileProvider2 = fileProvider.providerForPath( module.remotePath );

  _.assert( !!fileProvider2.limitedImplementation );

  let result = fileProvider2.isUpToDate
  ({
    remotePath : module.remotePath,
    localPath : module.clonePath,
  });

  if( !result )
  return end( result );

  return _.Consequence.From( result )
  .doThen( ( err, arg ) =>
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

function remoteForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( module.formed === 2 );
  _.assert( _.strDefined( module.dirPath ) );

  module.isRemote = module.remoteIsRemote();

  if( module.isRemote )
  {
    module.remoteFormAct();
  }
  else
  {
    module.isDownloaded = 1;
  }

  return module;
}

//

function remoteFormAct()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( module.formed === 2 );
  _.assert( _.strDefined( module.dirPath ) );
  _.assert( _.strDefined( module.alias ) );
  _.assert( !!module.supermodule );

  let fileProvider2 = fileProvider.providerForPath( module.dirPath );
  let submodulesDir = module.supermodule.submodulesCloneDirGet();
  let localPath = fileProvider2.pathIsolateGlobalAndLocal( module.dirPath )[ 1 ];

  module.remotePath = module.dirPath;
  module.clonePath = path.resolve( submodulesDir, module.alias );
  module.dirPath = path.resolve( module.clonePath, localPath );

  let o2 =
  {
    reflectMap : { [ module.remotePath ] : module.clonePath },
  }

  module.isDownloaded = !!module.remoteIsDownloaded();

  _.assert( will.moduleMap[ module.remotePath ] === module );
  _.sure( will.moduleMap[ module.dirPath ] === undefined, () => 'Module at ' + _.strQuote( module.dirPath ) + ' already exists' );

   will.moduleMap[ module.dirPath ] = module;

  return module;
}

//

function _remoteDownload( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let time = _.timeNow();
  let wasUpToDate = false;
  let con = _.Consequence().give( null );

  _.routineOptions( _remoteDownload, o );
  _.assert( arguments.length === 1 );
  _.assert( module.formed === 3 );
  _.assert( _.strDefined( module.dirPath ) );
  _.assert( _.strDefined( module.alias ) );
  _.assert( _.strDefined( module.remotePath ) );
  _.assert( _.strDefined( module.clonePath ) );
  _.assert( !!module.supermodule );

  if( !o.upgrading )
  {
    if( module.isDownloaded )
    return false;
  }

  let o2 =
  {
    reflectMap : { [ module.remotePath ] : module.clonePath },
    verbosity : 0,
  }

  return con
  .ifNoErrorThen( () => module.remoteIsUpToDate() )
  .ifNoErrorThen( ( arg ) =>
  {
    wasUpToDate = module.isUpToDate;
    return arg;
  })
  .ifNoErrorThen( () => will.Predefined.filesReflect.call( fileProvider, o2 ) )
  // .ifNoErrorThen( () => module.remoteIsDownloaded() )
  // .ifNoErrorThen( () => module.remoteIsUpToDate() )
  .ifNoErrorThen( ( arg ) =>
  {
    // _.assert( module.isUpToDate, () => Module.nickName + ' still is not up to date ' + module.clonePath );
    // _.assert( module.isDownloaded, () => Module.nickName + ' still is not downloaded ' + module.clonePath );
    module.isUpToDate = true;
    module.isDownloaded = true;
    return arg;
  })
  .doThen( ( err, arg ) =>
  {
    if( err )
    throw _.err( 'Failed to', ( o.upgrading ? 'upgrade' : 'download' ), module.nickName, '\n', err );
    if( will.verbosity >= 3 && !wasUpToDate )
    logger.log( ' + ' + module.nickName + ' was ' + ( o.upgrading ? 'upgraded' : 'downloaded' ) + ' in ' + _.timeSpent( time ) );
    return arg;
  });
}

_remoteDownload.defaults =
{
  upgrading : 0,
}

//

function remoteDownload()
{
  let module = this;
  let will = module.will;
  return module._remoteDownload({ upgrading : 0 });
}

//

function remoteUpgrade()
{
  let module = this;
  let will = module.will;
  return module._remoteDownload({ upgrading : 1 });
}

// --
// resource
// --


function resourcesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  module.stager.stage( 'resourcesFormed', 1 );

  module.willFilesOpenReady.ifNoErrorThen( ( arg ) =>
  {
    let con = new _.Consequence().give( null );

    // debugger;
    if( !module.supermodule && module.submodulesAreDownloaded() )
    {

      con.ifNoErrorThen( () => module._resourcesForm() );

      con.ifNoErrorThen( ( arg ) =>
      {
        module.stager.stage( 'resourcesFormed', 2 );
        return arg;
      });

    }
    else
    {
      if( !module.supermodule )
      if( will.verbosity === 2 )
      logger.error( ' ! One or more submodules of ' + module.nickName + ' were not downloaded!'  );
    }

    return con;
  })
  .doThen( ( err, arg ) =>
  {
    _.timeOut( 1, () => module.ready.give( err, arg ) );
    _.assert( !module.ready.resourcesHas() );
    if( err )
    {
      if( will.verbosity && will.verboseStaging )
      console.log( ' s', module.nickName, 'resourcesFormed', 'failed' );
      // debugger;
      module.resourcesFormReady.error( err );
      throw err;
    }
    return arg;
  });

  return module.willFilesOpenReady.split();
}

//

function _resourcesSubmodulesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.formed );

  let con = _.Consequence().give( null );

  /* */

  module._resourcesFormAct( will.Submodule, con );

  /* */

  con.doThen( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

//

function _resourcesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.formed );

  let con = _.Consequence().give( null );

  /* */

  module._resourcesFormAct( will.Submodule, con );
  module._resourcesFormAct( will.Exported, con );
  module._resourcesFormAct( will.PathObj, con );
  module._resourcesFormAct( will.Reflector, con );
  module._resourcesFormAct( will.Step, con );
  module._resourcesFormAct( will.Build, con );

  /* */

  con.doThen( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

//

function _resourcesFormAct( Resource, con )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.constructorIs( Resource ) );
  _.assert( arguments.length === 2 );

  for( let s in module[ Resource.MapName ] )
  {
    let resource = module[ Resource.MapName ][ s ];
    _.assert( !!resource.formed );
    con.ifNoErrorThen( ( arg ) => resource.form2() );
  }

  for( let s in module[ Resource.MapName ] )
  {
    let resource = module[ Resource.MapName ][ s ];
    con.ifNoErrorThen( ( arg ) => resource.form3() );
  }

}

//

function resourceClassForKind( resourceKind )
{
  let module = this;
  let will = module.will;
  let result = will[ will.ResourceKindToClassName.forKey( resourceKind ) ];

  _.assert( arguments.length === 1 );
  _.sure( _.routineIs( result ), () => 'Cant find class for resource kind ' + _.strQuote( resourceKind ) );

  return result;
}

//

function resourceMapForKind( resourceKind )
{
  let module = this;
  let will = module.will;
  let result;

  // debugger;

  if( resourceKind === 'export' )
  result = module.buildMap;
  else
  result = module[ will.ResourceKindToMapName.forKey( resourceKind ) ];

  _.assert( arguments.length === 1 );
  _.sure( _.objectIs( result ), () => 'Cant find resource map for resource kind ' + _.strQuote( resourceKind ) );

  return result;
}

//

function resourceAllocate( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceName ) );

  // _.assert( module.pathMap[ resourceName ] === undefined, 'not implemented' );
  // let resourceName2 = resourceName + '.0';

  let resourceName2 = module.resourceAllocateName( resourceKind, resourceName );
  let cls = module.resourceClassForKind( resourceKind );
  let patho = new cls({ module : module, name : resourceName2 }).form1();

  return patho;
}

//

function resourceAllocateName( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceName ) );
  // _.assert( module.pathMap[ resourceName ] === undefined, 'not implemented' );

  let map = module.resourceMapForKind( resourceKind );
  let counter = 0;
  let resourceName2;

  do
  {
    resourceName2 = resourceName + '.' + counter;
    counter += 1;
  }
  while( map[ resourceName2 ] !== undefined );

  return resourceName2;
}

// --
// path
// --

function submodulesCloneDirGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  _.assert( arguments.length === 0 );
  return path.join( module.dirPath, '.module' );
}

//

function baseDirPathChange( dirPath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  dirPath = path.normalize( dirPath );

  _.assert( arguments.length === 1 );
  _.assert( _.strDefined( dirPath ) );
  _.assert( path.isAbsolute( dirPath ) );
  _.assert( module.formed === 3 );
  _.assert( path.isNormalized( dirPath ) );
  _.assert( path.isNormalized( module.dirPath ) );

  if( module.dirPath === dirPath )
  return module;

  _.assert( will.moduleMap[ module.dirPath ] === module );
  _.assert( will.moduleMap[ dirPath ] === undefined );

  delete will.moduleMap[ module.dirPath ];
  module.dirPath = dirPath;
  will.moduleMap[ module.dirPath ] = module;

  return module;
}

//

function inPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.s.resolve( module.dirPath, ( module.pathMap.in || '.' ) );
}

//

function outPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.s.resolve( module.dirPath, ( module.pathMap.out || '.' ) );
}

// --
// accessor
// --

function _nickNameGet()
{
  let module = this;
  let name = module.alias ? module.alias : null;
  if( !name && module.about )
  name = module.about.name;
  if( !name )
  name = module.dirPath;
  return '→ ' + module.constructor.shortName + ' ' + _.strQuote( name ) + ' ←';
}

// --
// selector
// --

/*
iii : implement name glob filtering
*/

function _buildsSelect_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o;
  if( args[ 1 ] !== undefined )
  o = { name : args[ 0 ], criterion : args[ 1 ] }
  else
  o = args[ 0 ];

  o = _.routineOptions( routine, o );
  _.assert( _.arrayHas( [ 'build', 'export' ], o.resource ) );
  _.assert( _.arrayHas( [ 'default', 'more' ], o.preffering ) );
  _.assert( o.criterion === null || _.routineIs( o.criterion ) || _.mapIs( o.criterion ) );

  if( o.preffering === 'default' )
  o.preffering = 'default';

  return o;
}

//

function _buildsSelect_body( o )
{
  let module = this;
  let elements;

  elements = module.buildMap;

  _.assertRoutineOptions( _buildsSelect_body, arguments );
  _.assert( arguments.length === 1 );

  // debugger;

  if( o.name )
  {
    if( !elements[ o.name ] )
    return []
    elements = [ elements[ o.name ] ];
    if( o.criterion === null || Object.keys( o.criterion ).length === 0 )
    return elements;
  }
  else
  {
    elements = _.mapVals( elements );
  }

  let hasMapFilter = _.objectIs( o.criterion ) && Object.keys( o.criterion ).length > 0;
  if( _.routineIs( o.criterion ) || hasMapFilter )
  {

    _.assert( _.objectIs( o.criterion ), 'not tested' );
    _.assert( !o.name, 'not tested' );

    elements = filterWith( elements, o.criterion );

  }
  else if( _.objectIs( o.criterion ) && Object.keys( o.criterion ).length === 0 && !o.name && o.preffering === 'default' )
  {

    elements = filterWith( elements, { default : 1 } );

  }

  // debugger;

  if( o.resource === 'export' )
  elements = elements.filter( ( element ) => element.criterion && element.criterion.export );
  else if( o.resource === 'build' )
  elements = elements.filter( ( element ) => !element.criterion || !element.criterion.export );

  return elements;

  /* */

  function filterWith( elements, filter )
  {

    _.assert( _.objectIs( filter ), 'not tested' );
    _.assert( !o.name, 'not tested' );

    if( _.objectIs( filter ) && Object.keys( filter ).length > 0 )
    {

      let template = filter;
      filter = function filter( build, k, c )
      {
        if( build.criterion === null && Object.keys( template ).length )
        return;

        let satisfied = _.mapSatisfy
        ({
          template : template,
          src : build.criterion,
          levels : 1,
        });
        if( satisfied )
        return build;
      }

    }

    elements = _.entityFilter( elements, filter );

    return elements;
  }

}

_buildsSelect_body.defaults =
{
  resource : null,
  name : null,
  criterion : null,
  preffering : 'default',
}

let _buildsSelect = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );

//

let buildsSelect = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = buildsSelect.defaults;
defaults.resource = 'build';

//

let exportsSelect = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = exportsSelect.defaults;
defaults.resource = 'export';

// --
// resolver
// --

function errResolving( o )
{
  let module = this;
  _.routineOptions( errResolving, arguments );
  if( o.current && o.current.nickName )
  throw _.err( 'Failed to resolve', _.strQuote( o.query ), 'for', o.current.nickName, 'in', module.nickName, '\n', o.err );
  else
  throw _.err( 'Failed to resolve', _.strQuote( o.query ), 'in', module.nickName, '\n', o.err );
}

errResolving.defaults =
{
  err : null,
  current : null,
  query : null,
}

//

function strSplitShort( srcStr )
{
  let module = this;
  _.assert( !_.strHas( srcStr, '/' ) );
  let result = _.strIsolateBeginOrNone( srcStr, '::' );
  return result;
}

//

function _strSplit( o )
{
  let module = this;
  let will = module.will;
  let result;

  _.assertRoutineOptions( _strSplit, arguments );
  _.assert( !_.strHas( o.query, '/' ) );
  _.sure( _.strIs( o.query ), 'Expects string, but got', _.strTypeOf( o.query ) );

  let splits = module.strSplitShort( o.query );

  if( !splits[ 0 ] && o.defaultPool )
  {
    splits = [ o.defaultPool, '::', o.query ]
  }

  return splits;
}

var defaults = _strSplit.defaults = Object.create( null )

defaults.query = null
defaults.defaultPool = null;

//

function strGetPrefix( srcStr )
{
  let module = this;
  let splits = module.strSplitShort( srcStr );
  if( !splits[ 0 ] )
  return false;
  if( !_.arrayHas( will.ResourceKinds, splits[ 0 ] ) )
  return false;
  return splits[ 0 ];
}

//

function strIsResolved( srcStr )
{
  return !_.strHas( srcStr, '::' );
}

//

function _resolve_pre( routine, args )
{
  let o = args[ 0 ];
  if( _.strIs( o ) )
  o = { query : o }

  _.routineOptions( routine, o );
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.arrayHas( [ null, 'in', 'out' ], o.resolvingPath ) );

  return o;
}

//

function _resolveMaybe_body( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( o.currentModule === null )
  o.currentModule = module;

  // if( !o.visited )
  // o.visited = [];

  let result = module._resolveSelect( o );

  if( _.errIs( result ) )
  return result;

  // if( o.flattening && _.mapIs( result ) )
  // debugger;

  if( o.resolvingPath )
  {
    if( result instanceof will.PathObj )
    {
      result = pathResolve( result );
    }
    else if( _.arrayIs( result ) )
    {
      let r = [];
      for( let r = 0 ; r < result.length ; r++ )
      if( result instanceof will.PathObj )
      r[ r ] = pathResolve( result[ r ] );
      else
      r[ r ] = result[ r ];
      result = r;
    }
  }

  if( o.flattening && _.mapIs( result ) )
  result = _.mapsFlatten2([ result ]);

  if( o.unwrappingPath && o.hasPath )
  {
    // if( o.query === 'submodule::*/exported::*=1/path::exportedDir*=1' )
    // debugger;
    // if( _.arrayIs( result ) )
    // debugger;
    _.assert( _.mapIs( result ) || _.objectIs( result ) || _.arrayIs( result ) || _.strIs( result ) );
    if( _.mapIs( result ) || _.arrayIs( result ) )
    result = _.filter( result, ( e ) => e instanceof will.PathObj ? e.path : e )
    else if( result instanceof will.PathObj )
    result = result.path;
  }

  if( o.unwrappingSingle )
  if( _.mapIs( result ) )
  {
    if( _.mapKeys( result ).length === 1 )
    result = _.mapVals( result )[ 0 ];
  }
  else if( _.arrayIs( result ) )
  {
    if( result.length === 1 )
    result = result[ 0 ];
  }

  if( o.mapVals && _.mapIs( result ) )
  result = _.mapVals( result );

  return result;

  /*  */

  function pathResolve( patho )
  {
    _.assert( patho instanceof will.PathObj );
    if( o.resolvingPath === 'in' )
    return path.s.resolve( module.dirPath, ( module.pathMap.in || '.' ), patho.path );
    else if( o.resolvingPath === 'out' )
    return path.s.resolve( module.dirPath, ( module.pathMap.out || '.' ), patho.path );
    else
    return patho.path;
  }

}

_resolveMaybe_body.defaults =
{
  query : null,
  defaultPool : null,
  visited : null,
  current : null,
  currentModule : null,
  resolvingPath : null,
  unwrappingPath : 1,
  unwrappingSingle : 1,
  mapVals : 1,
  flattening : 0,
  hasPath : null,
}

let _resolveMaybe = _.routineFromPreAndBody( _resolve_pre, _resolveMaybe_body );

//

function _resolve_body( o )
{
  let module = this;
  let will = module.will;
  let current = o.current;

  let result = module._resolveMaybe.body.call( module, o );

  if( _.errIs( result ) )
  {
    debugger;
    throw module.errResolving({ query : o.query, current : current, err : result });
  }

  return result;
}

_resolve_body.defaults = Object.create( _resolveMaybe.body.defaults );

let _resolve = _.routineFromPreAndBody( _resolve_pre, _resolve_body );

//

function _resolveSelect( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result;
  let current = o.current;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _resolveSelect, arguments );
  _.assert( o.currentModule instanceof will.Module );

  // if( _.strHas( o.query, 'reflect.proto' ) )
  // debugger;

  try
  {

    result = _.select
    ({
      container : module,
      query : o.query,
      onUpBegin : onUpBegin,
      onUpEnd : onUpEnd,
      missingAction : 'error',
      _inherited :
      {
        module : o.currentModule,
        exported : null,
      }
    });

  }
  catch( err )
  {
    debugger;
    throw module.errResolving({ query : o.query, current : current, err : err });
  }

  if( result === undefined )
  {
    debugger;
    return _.ErrorLooking( kind, _.strQuote( name ), 'was not found' );
  }

  return result;

  /* */

  function onUpBegin()
  {
    let it = this;

    if( !it.query )
    {
      return;
    }

    if( it.src && it.src instanceof will.Submodule )
    {
      // debugger;
      it._inherited.module = it.src.loadedModule;
    }

    if( it.src && it.src instanceof will.Exported )
    {
      // debugger;
      it._inherited.exported = it.src;
    }

    queryParse.call( it );

    let kind = it.queryParsed.kind
    if( kind === 'path' && o.hasPath === null )
    o.hasPath = true;

    let pool = it._inherited.module.resourceMapForKind( kind );
    // debugger;

    if( !pool )
    {
      debugger;
      throw _.ErrorLooking( 'Unknown type of resource, no pool for such resource', _.strQuote( it.queryParsed.full ) );
    }

    it.src = pool;
  }

  /* */

  function onUpEnd()
  {
    let it = this;

    exportedWriteThrough.call( it );
    globCriterionFilter.call( it );
    exportedPathResolve.call( it );

  }

  /* */

  function queryParse()
  {
    let it = this;
    // debugger;
    _.assert( !!it._inherited.module );
    let splits = it._inherited.module._strSplit({ query : it.query, defaultPool : o.defaultPool });

    it.queryParsed = Object.create( null );
    it.queryParsed.full = splits.join( '' );
    it.queryParsed.kind = splits[ 0 ];
    it.query = it.queryParsed.name = splits[ 2 ];

  }

  /* */

  function globCriterionFilter()
  {
    let it = this;

    if( it.down && it.down.isGlob )
    if( o.current && o.current.criterion && it.src && it.src.criterionSattisfy )
    {
      if( !it.src.criterionSattisfy( o.current.criterion ) )
      {
        it.looking = false;
        it.writingDown = false;
      }
    }

  }

  /* */

  function exportedWriteThrough()
  {
    let it = this;

    if( it.down && it.queryParsed && it.queryParsed.kind === 'exported' )
    {
      // debugger;
      let writeToDownOriginal = it.writeToDown;
      it.writeToDown = function writeThrough( eit )
      {
        let r = writeToDownOriginal.apply( this, arguments );

        // debugger;

        eit.key = it.key + '.' + eit.key;

        it.down.writeToDown.apply( it.down, arguments );
        it.writingDown = false;

        // return writeToDownOriginal.apply( this, arguments );

        return r;
      }
    }

  }

  /* */

  function exportedPathResolve()
  {
    let it = this;

    if( !it.query )
    {

      if( it._inherited.exported && it.result && it.result instanceof will.PathObj )
      {
        // debugger;
        let m = it._inherited.module;
        it.result = path.s.join( m.dirPath, it.result.path );
      }

    }

  }

}

var defaults = _resolveSelect.defaults = Object.create( _resolve.defaults )

defaults.visited = null;

//

// function poolFor( kind )
// {
//   let module = this;
//   let pool;
//
//   _.assert( arguments.length === 1 );
//
//   if( !kind || !_.arrayHas( will.ResourceKinds, kind ) )
//   {
//     debugger;
//     throw _.ErrorLooking( 'Unknown kind of resource, no pool for resource', _.toStrShort( kind ) );
//   }
//
//   if( kind === 'path' )
//   pool = module.pathObjMap;
//   else if( kind === 'reflector' )
//   pool = module.reflectorMap;
//   else if( kind === 'submodule' )
//   pool = module.submoduleMap;
//   else if( kind === 'step' )
//   pool = module.stepMap;
//   else if( kind === 'build' )
//   pool = module.buildMap;
//   else if( kind === 'exported' )
//   pool = module.exportedMap;
//
//   return pool
// }

// --
// exporter
// --

function infoExport()
{
  let module = this;
  let will = module.will;
  let result = '';

  result += module.about.infoExport();
  result += module.execution.infoExport();

  result += module.infoExportPaths( module.pathMap );
  result += module.infoExportResource( module.reflectorMap );
  result += module.infoExportResource( module.stepMap );
  result += module.infoExportResource( module.buildsSelect({ preffering : 'more' }) );
  result += module.infoExportResource( module.exportsSelect({ preffering : 'more' }) );
  result += module.infoExportResource( module.exportedMap );

  return result;
}

//

function infoExportPaths( paths )
{
  let module = this;
  paths = paths || module.pathMap;
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !Object.keys( paths ).length )
  return '';

  return 'Paths\n' + _.toStr( paths, { wrap : 0, multiline : 1, levels : 2 } ) + '\n\n';
}

//

function infoExportResource( collection )
{
  let module = this;
  let will = module.will;
  let result = '';

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( collection ) || _.arrayIs( collection ) );

  _.each( collection, ( resource, r ) =>
  {
    if( resource.criterion && resource.criterion.predefined )
    return;
    result += resource.infoExport();
    result += '\n';
  });

  return result;
}

//

function dataExport()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = Object.create( null );

  result.format = will.WillFile.FormatVersion;
  result.about = module.about.dataExport();
  result.execution = module.execution.dataExport();

  result.path = module.dataExportResource( module.pathObjMap );
  result.submodule = module.dataExportResource( module.submoduleMap );
  result.reflector = module.dataExportResource( module.reflectorMap );
  result.step = module.dataExportResource( module.stepMap );
  result.build = module.dataExportResource( module.buildMap );
  result.exported = module.dataExportResource( module.exportedMap );

  return result;
}

//

function dataExportResource( collection )
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( collection ) || _.arrayIs( collection ) );

  _.each( collection, ( resource, r ) =>
  {
    if( resource.criterion && resource.criterion.predefined )
    return;
    result[ r ] = resource.dataExport();
  });

  return result;
}

// --
// relations
// --

let Composes =
{

  dirPath : null,
  clonePath : null,
  remotePath : null,

  isRemote : null,
  isDownloaded : null,
  isUpToDate : null,

  verbosity : 0,
  alias : null,

}

let Aggregates =
{

  about : _.define.ownInstanceOf( _.Will.ParagraphAbout ),
  execution : _.define.ownInstanceOf( _.Will.ParagraphExecution ),

  submoduleMap : _.define.own({}),
  pathMap : _.define.own({}),
  pathObjMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportedMap : _.define.own({}),

  willFileArray : _.define.own([]),
  willFileWithRoleMap : _.define.own({}),

}

let Associates =
{
  will : null,
  supermodule : null,
}

let Restricts =
{
  stager : null,

  formed : 0,
  willFilesFound : 0,
  willFilesOpened : 0,
  resourcesFormed : 0,

  formReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'formReady' }) ),
  willFilesFindReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'willFilesFindReady' }) ),
  willFilesOpenReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'willFilesOpenReady' }) ),
  resourcesFormReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'resourcesFormReady' }) ),

  ready : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'ready' }) ),
}

let Statics =
{
  DirPathFromWillFilePath : DirPathFromWillFilePath,
}

let Forbids =
{
  name : 'name',
  exportMap : 'exportMap',
  exported : 'exported',
  downloaded : 'downloaded',
}

let Accessors =
{
  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Will.ParagraphAbout }) },
  execution : { setter : _.accessor.setter.friend({ name : 'execution', friendName : 'module', maker : _.Will.ParagraphExecution }) },
  nickName : { getter : _nickNameGet, combining : 'rewrite' },
  inPath : { getter : inPathGet, readOnly : 1 },
  outPath : { getter : outPathGet, readOnly : 1 },
}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,
  unform,
  form,
  form1,
  form2,
  predefinedForm,

  // etc

  clean,
  cleanWhat,

  // opener

  DirPathFromWillFilePath,
  prefixPathForRole,
  prefixPathForRoleMaybe,

  _willFileFindMaybe,
  _willFilesFindMaybe,
  willFilesFind,

  willFilesOpen,
  _willFilesOpen,

  // submodule

  submodulesCloneDirGet,

  submodulesAreDownloaded,
  _submodulesDownload,
  submodulesDownload,
  submodulesUpgrade,
  submodulesClean,

  // remote

  remoteIsRemote,
  remoteIsDownloaded,
  remoteIsUpToDate,

  remoteForm,
  remoteFormAct,
  _remoteDownload,
  remoteDownload,
  remoteUpgrade,

  // resource

  resourcesForm,
  _resourcesSubmodulesForm,
  _resourcesForm,
  _resourcesFormAct,

  resourceClassForKind,
  resourceMapForKind,
  resourceAllocate,
  resourceAllocateName,

  // path

  baseDirPathChange,
  inPathGet,
  outPathGet,

  // accessor

  _nickNameGet,

  // selector

  _buildsSelect,
  buildsSelect,
  exportsSelect,

  // resolver

  errResolving,

  strSplitShort,
  _strSplit,
  strGetPrefix,
  strIsResolved,

  _resolve,
  resolve : _resolve,
  // resolve : _.routineVectorize_functor( _resolve ),

  _resolveMaybe,
  resolveMaybe : _resolveMaybe,
  // resolveMaybe : _.routineVectorize_functor( _resolveMaybe ),

  _resolveSelect,
  // poolFor : poolFor,

  // exporter

  infoExport,
  infoExportPaths,
  infoExportResource,

  dataExport,
  dataExportResource,

  // relation

  Composes,
  Aggregates,
  Associates,
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
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
