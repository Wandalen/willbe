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
  let will = module.will;
  let rootModule = module.rootModule;

  module.submoduleAssociation.forEach( ( submodule ) =>
  {
    _.assert( submodule.openedModule === module );
    submodule.finit();
  });

  // if( !module.original )
  {
    // if( module.stager.stageStatePerformed( 'preformed' ) )
    {
      _.assert( rootModule.moduleWithPathMap[ module.commonPath ] === module );
      delete rootModule.moduleWithPathMap[ module.commonPath ];
    }
    _.assert( !_.arrayHas( _.mapVals( rootModule.moduleWithPathMap ), module ) );
  }

  module.unform();
  module.about.finit();

  let finited = _.err( 'Finited' );
  finited.finited = true;
  module.stager.stageCancel( 'preformed' );
  module.stager.stageCancel( 'formed' );
  module.stager.stagesState( 'skipping', true );
  module.stager.stageError( 'formed', finited );

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.pathResourceMap ).length === 0 );
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  _.assert( module.willfilesArray.length === 0 );
  _.assert( Object.keys( module.willfileWithRoleMap ).length === 0 );
  _.assert( will.moduleMap[ module.id ] !== module );
  _.assert( !_.arrayHas( will.moduleArray, module ) );
  _.assert( _.instanceIsFinited( module.about ) );

  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init( o )
{
  let module = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  module.pathResourceMap = module.pathResourceMap || Object.create( null );

  _.instanceInit( module );
  Object.preventExtensions( module );

  // module.Counter += 1;
  // module.id = module.Counter;

  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;

  let will = o.will;
  _.assert( !!will );

  module.stager = new _.Stager
  ({
    object : module,
    stageNames : [ 'preformed', 'willfilesFound', 'willfilesOpened', 'submodulesFormed', 'resourcesFormed', 'formed' ],
    consequenceNames : [ 'preformReady', 'willfilesFindReady', 'willfilesOpenReady', 'submodulesFormReady', 'resourcesFormReady', 'ready' ],
    verbosity : Math.max( Math.min( will.verbosity, will.verboseStaging ), will.verbosity - 6 ),
    onPerform : [ module._preform, module._willfilesFind, module._willfilesOpen, module._submodulesForm, module._resourcesForm, null ],
    onBegin : [ null, module.willfilesReadBegin, null, null, null, null ],
    onEnd : [ null, null, null, module.willfilesReadEnd, null, module._openEnd ],
  });

  module.stager.stageStatePausing( 'willfilesFound', 1 );

  if( o )
  {
    if( o.will )
    module.will = o.will;
    if( o.supermodule )
    module.supermodule = o.supermodule;
    if( o.original )
    module.original = o.original;
  }

  module.predefinedForm();

  _.assert( !!o );
  if( o )
  {
    if( !o.supermodule )
    {
      // if( o.original )
      // {
      //   module.moduleWithPathMap = Object.create( o.original.moduleWithPathMap );
      //   module.moduleWithNameMap = Object.create( o.original.moduleWithNameMap );
      //   module.allSubmodulesMap = Object.create( o.original.allSubmodulesMap );
      //   Object.freeze( module.moduleWithPathMap );
      //   Object.freeze( module.moduleWithNameMap );
      //   Object.freeze( module.allSubmodulesMap );
      // }
      // else
      // {
        module.moduleWithPathMap = Object.create( null );
        module.moduleWithNameMap = Object.create( null );
        module.allSubmodulesMap = Object.create( null );
      // }
    }
    module.copy( o );
  }

  module._filePathChanged();
  module.nameChanged();

}

//

function copy( o )
{
  let module = this;

  if( o && o.will )
  module.will = o.will;

  let result = _.Copyable.prototype.copy.apply( module, arguments );

  let names =
  {
    willfilesPath : null,
    localPath : null,
    remotePath : null,
  }

  for( let n in names )
  {
    if( o[ n ] !== undefined )
    module[ n ] = o[ n ];
  }

  _.assert( result.currentRemotePath === module.currentRemotePath );

  return result;
}

//

function clone()
{
  let module = this;

  _.assert( arguments.length === 0 );

  let op = { original : module }
  let result = _.Copyable.prototype.cloneExtending.call( module, op );

  return result;
}

//

function unform()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );

  module.close();

  if( module.stager.stageStatePerformed( 'preformed' ) )
  {
    if( will.moduleMap[ module.id ] === module );
    delete will.moduleMap[ module.id ];
    _.arrayRemoveElementOnceStrictly( will.moduleArray, module );
  }

  for( let i in module.pathResourceMap )
  module.pathResourceMap[ i ].finit();

  _.assert( will.moduleMap[ module.id ] !== module );
  _.assert( !_.arrayHas( will.moduleArray, module ) );

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.pathResourceMap ).length === 0 );
  _.assert( Object.keys( module.pathMap ).length === 0 ); // xxx
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  return module;
}

//

function preform()
{
  let module = this;
  let will = module.will;
  let con = new _.Consequence().take( null );

  _.assert( arguments.length === 0 );
  _.assert( !module.preformReady.resourcesCount() )
  _.assert( !module.preformed );
  _.assert( !module.stager.stageStateEnded( 'preformed' ) );

  // module.stager.stageStateSkipping( 'preformed', 0 );
  module.stager.stageStatePausing( 'preformed', 0 );
  module.stager.tick();

  _.assert( module.stager.stageStateEnded( 'preformed' ) );

  return module;
}

//

function _preform()
{
  let module = this;
  let will = module.will;

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!module.will );
  _.assert( _.strsAreAll( module.willfilesPath ) || _.strIs( module.dirPath ), 'Expects willfilesPath or dirPath' );

  /* */

  module._filePathChanged();

  /* */

  _.assert( module.id > 0 );
  will.moduleMap[ module.id ] = module;
  _.arrayAppendOnceStrictly( will.moduleArray, module );
  _.assert( will.moduleMap[ module.id ] === module );

  /* */

  _.assert( arguments.length === 0 );
  _.assert( !!module.will );
  _.assert( will.moduleMap[ module.id ] === module );
  _.assert( module.dirPath === null || _.strDefined( module.dirPath ) );
  _.assert( !!module.willfilesPath || !!module.dirPath );

  /* */

  module.remoteForm();

  /* */

  return module;
}

//

function predefinedForm()
{
  let module = this;
  let will = module.will;
  let Predefined = will.Predefined;

  _.assert( arguments.length === 0 );

  /* */

  path
  ({
    name : 'module.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
  })

  path
  ({
    name : 'module.original.willfiles',
    path : null,
    writable : 0,
    exportable : 1,
  })

  path
  ({
    name : 'module.dir',
    path : null,
    writable : 0,
    exportable : 1,
    importable : 0,
  })

  path
  ({
    name : 'local',
    path : null,
    writable : 1,
    exportable : 1,
    importable : 1,
  })

  path
  ({
    name : 'remote',
    path : null,
    writable : 1,
    exportable : 1,
  })

  path
  ({
    name : 'current.remote',
    path : null,
    writable : 0,
    exportable : 0,
    importable : 0,
  })

  path
  ({
    name : 'will',
    path : _.path.join( __dirname, '../Exec' ),
    writable : 0,
    exportable : 0,
    importable : 0,
  })

  /* */

  step
  ({
    name : 'predefined.delete',
    stepRoutine : Predefined.stepRoutineDelete,
  })

  step
  ({
    name : 'predefined.reflect',
    stepRoutine : Predefined.stepRoutineReflect,
  })

  step
  ({
    name : 'timelapse.begin',
    stepRoutine : Predefined.stepRoutineTimelapseBegin,
  })

  step
  ({
    name : 'timelapse.end',
    stepRoutine : Predefined.stepRoutineTimelapseEnd,
  })

  step
  ({
    name : 'js.run',
    stepRoutine : Predefined.stepRoutineJs,
  })

  step
  ({
    name : 'shell.run',
    stepRoutine : Predefined.stepRoutineShell,
  })

  step
  ({
    name : 'files.transpile',
    stepRoutine : Predefined.stepRoutineTranspile,
  })

  step
  ({
    name : 'file.view',
    stepRoutine : Predefined.stepRoutineView,
  })

  step
  ({
    name : 'npm.generate',
    stepRoutine : Predefined.stepRoutineNpmGenerate,
  })

  step
  ({
    name : 'submodules.download',
    stepRoutine : Predefined.stepRoutineSubmodulesDownload,
  })

  step
  ({
    name : 'submodules.update',
    stepRoutine : Predefined.stepRoutineSubmodulesUpdate,
  })

  step
  ({
    name : 'submodules.reload',
    stepRoutine : Predefined.stepRoutineSubmodulesReload,
  })

  step
  ({
    name : 'submodules.clean',
    stepRoutine : Predefined.stepRoutineSubmodulesClean,
  })

  step
  ({
    name : 'clean',
    stepRoutine : Predefined.stepRoutineClean,
  })

  step
  ({
    name : 'module.export',
    stepRoutine : Predefined.stepRoutineExport,
  })

  /* */

  reflector
  ({
    name : 'predefined.common',
    src :
    {
      maskAll :
      {
        excludeAny :
        [
          /(\W|^)node_modules(\W|$)/,
          /\.unique$/,
          /\.git$/,
          /\.svn$/,
          /\.hg$/,
          /\.DS_Store$/,
          /(^|\/)-/,
        ],
      }
    },
  });

  reflector
  ({
    name : 'predefined.debug.v1',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 1,
    },
  });

  reflector
  ({
    name : 'predefined.debug.v2',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 'debug',
    },
  });

  reflector
  ({
    name : 'predefined.release.v1',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
        // excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 0,
    },
  });

  // debugger;
  reflector
  ({
    name : 'predefined.release.v2',
    src :
    {
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
        // excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 'release',
    },
  });
  // debugger;

/*
  .predefined.common :
    src :
      maskAll :
        excludeAny :
        - !!js/regexp '/(^|\/)-/'

  .predefined.debug :
    inherit : .predefined.common
    src :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.release($|\.|\/)/i'

  .predefined.release :
    inherit : .predefined.common
    src :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.debug($|\.|\/)/i'
        - !!js/regexp '/\.test($|\.|\/)/i'
        - !!js/regexp '/\.experiment($|\.|\/)/i'
*/

  /* - */

  function path( o )
  {

    if( module.pathResourceMap[ o.name ] )
    return module.pathResourceMap[ o.name ].form1();

    let defaults =
    {
      module : module,
      writable : 0,
      exportable : 0,
      importable : 1,
      criterion :
      {
        predefined : 1,
      }
    }

    o.criterion = o.criterion || Object.create( null );

    _.mapSupplement( o, defaults );
    _.mapSupplement( o.criterion, defaults.criterion );

    _.assert( o.criterion !== defaults.criterion );
    _.assert( arguments.length === 1 );

    let result = new will.PathResource( o ).form1();

    _.assert( !!result.writable === !!o.writable );

    return result;
  }

  /* */

  function step( o )
  {
    if( module.stepMap[ o.name ] )
    return module.stepMap[ o.name ].form1();

    let defaults =
    {
      module : module,
      writable : 0,
      exportable : 0,
      importable : 0,
      criterion :
      {
        predefined : 1,
      }
    }

    o.criterion = o.criterion || Object.create( null );

    _.mapSupplement( o, defaults );
    _.mapSupplement( o.criterion, defaults.criterion );

    _.assert( o.criterion !== defaults.criterion );
    _.assert( arguments.length === 1 );

    let result = new will.Step( o ).form1();
    result.writable = 0;
    return result;
  }

  /* */

  function reflector( o )
  {
    if( module.reflectorMap[ o.name ] )
    return module.reflectorMap[ o.name ].form1();

    let defaults =
    {
      module : module,
      writable : 0,
      exportable : 0,
      importable : 0,
      criterion :
      {
        predefined : 1,
      }
    }

    o.criterion = o.criterion || Object.create( null );

    _.mapSupplement( o, defaults );
    _.mapSupplement( o.criterion, defaults.criterion );

    _.assert( o.criterion !== defaults.criterion );
    _.assert( arguments.length === 1 );

    let result = will.Reflector.MakeForEachCriterion( o );
    return result;
  }

}

// --
// etc
// --

function shell( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( arguments[ 0 ] ) )
  o = { execPath : arguments[ 0 ] }

  _.assert( _.strIs( o.execPath ) );
  _.assert( arguments.length === 1 );
  o = _.routineOptions( shell, o );

  /* */

  o.execPath = module.resolve
  ({
    selector : o.execPath,
    prefixlessAction : 'resolved',
    currentThis : o.currentThis,
    pathNativizing : 1,
    arrayFlattening : 0, /* required for f::this and feature make */
  });

  /* */

  if( o.currentPath )
  o.currentPath = module.pathResolve({ selector : o.currentPath, prefixlessAction : 'resolved', currentContext : o.currentContext });
  _.sure( o.currentPath === null || _.strIs( o.currentPath ) || _.strsAreAll( o.currentPath ), 'Current path should be string if defined' );

  /* */

  let ready = new _.Consequence().take( null );
  // if( _.arrayIs( o.currentPath ) ) /* xxx, qqq : implement multiple currentPath for routine _.shell */
  // {
  //
  //   debugger;
  //   o.currentPath.forEach( ( currentPath ) =>
  //   {
  //     _.shell
  //     ({
  //       execPath : o.execPath,
  //       currentPath : currentPath,
  //       verbosity : will.verbosity - 1,
  //       ready : ready,
  //     });
  //   });
  //
  // }
  // else
  // {

    _.shell
    ({
      execPath : o.execPath,
      currentPath : o.currentPath,
      verbosity : will.verbosity - 1,
      ready : ready,
    });

  // }

  return ready;
}

shell.defaults =
{
  execPath : null,
  currentPath : null,
  currentThis : null,
  currentContext : null,
}

// --
// opener
// --

function isOpened()
{
  let module = this;
  return module.willfilesArray.length > 0;
}

//

function isValid()
{
  let module = this;
  return module.stager.isValid();
}

//

function close()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  /* begin */

  for( let i in module.exportedMap )
  module.exportedMap[ i ].finit();
  for( let i in module.buildMap )
  module.buildMap[ i ].finit();
  for( let i in module.stepMap )
  module.stepMap[ i ].finit();
  for( let i in module.reflectorMap )
  module.reflectorMap[ i ].finit();
  for( let i in module.pathResourceMap )
  {
    if( !module.pathResourceMap[ i ].criterion || !module.pathResourceMap[ i ].criterion.predefined )
    module.pathResourceMap[ i ].finit();
  }
  for( let i in module.submoduleMap )
  module.submoduleMap[ i ].finit();

  _.assert( Object.keys( module.exportedMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  // _.assert( Object.keys( module.pathResourceMap ).length === 0 ); // xxx
  // _.assert( Object.keys( module.pathMap ).length === 0 ); // xxx
  _.assert( Object.keys( module.submoduleMap ).length === 0 );

  for( let i = module.willfilesArray.length-1 ; i >= 0 ; i-- )
  {
    let willf = module.willfilesArray[ i ];
    _.assert( Object.keys( willf.submoduleMap ).length === 0 );
    _.assert( Object.keys( willf.reflectorMap ).length === 0 );
    _.assert( Object.keys( willf.stepMap ).length === 0 );
    _.assert( Object.keys( willf.buildMap ).length === 0 );
    willf.finit();
  }

  _.assert( module.willfilesArray.length === 0 );
  _.assert( Object.keys( module.willfileWithRoleMap ).length === 0 );
  _.assert( will.moduleMap[ module.remotePath ] === undefined );

  module.stager.stageCancel( 'willfilesFound' );
  module.stager.stageCancel( 'willfilesOpened' );
  module.stager.stageCancel( 'submodulesFormed' );
  module.stager.stageCancel( 'resourcesFormed' );
  module.stager.stageCancel( 'formed' );

}

//

function _openEnd()
{
  let module = this;
  return null;
}

//

function _willfileFindSingle( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  _.routineOptions( _willfileFindSingle, arguments );

  _.assert( _.strDefined( o.role ) );
  _.assert( !module.willfilesFindReady.resourcesCount() );
  _.assert( !module.willfilesOpenReady.resourcesCount() );
  _.assert( !module.submodulesFormReady.resourcesCount() );
  _.assert( !module.resourcesFormReady.resourcesCount() );

  /* common path */

  let commonPath = module.willfilesPath ? path.common( module.willfilesPath ) : module.dirPath;

  /* dir path */

  let dirPath;
  let fname = path.fullName( commonPath );

  if( o.lookingDir )
  if( o.isNamed || fname === '' || fname === '.' || module.WillfilePathIs( fname ) )
  {
    dirPath = path.dir( commonPath );
  }

  if( !dirPath )
  dirPath = commonPath;

  /* name path */

  let namePath = '.';
  if( o.isNamed )
  {
    namePath = path.fullName( path.relative( path.parse( dirPath ).longPath, path.parse( commonPath ).longPath ) );
    namePath = _.strReplace( namePath, /(\.ex|\.im|)\.will(\.\w+)?$/, '' );
    if( namePath === '' || namePath === '.' )
    return null;
    _.assert( namePath.length > 0 );
  }

  /* */

  if( module.willfileWithRoleMap[ o.role ] )
  return null;

  /* */

  let filePath;
  if( o.isOutFile )
  {
    // debugger;

    if( !_.strEnds( namePath, '.out' ) )
    namePath = _.strJoinPath( [ namePath, 'out' ], '.' );

    if( o.isNamed )
    {
      let name = _.strJoinPath( [ namePath, module.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( dirPath, '.', name );
    }
    else
    {
      let name = _.strJoinPath( [ namePath, module.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( dirPath, name );
    }

  }
  else
  {

    if( o.isNamed )
    {
      let name = _.strJoinPath( [ namePath, module.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( dirPath, '.', name );
    }
    else
    {
      let name = module.prefixPathForRole( o.role );
      filePath = path.resolve( dirPath, namePath, name );
    }

  }

  /* */

  if( will.verbosity >= 5 )
  logger.log( ' . Trying to open', filePath );

  _.assert( module.willfileWithRoleMap[ o.role ] === undefined );

  new will.WillFile
  ({
    role : o.role,
    filePath : filePath,
    isOutFile : o.isOutFile,
    module : module,
  }).form1();

  let result = module.willfileWithRoleMap[ o.role ];

  if( result.exists() && ( rootModule === module || result.commonPath !== rootModule.commonPath ) )
  {

    if( !o.isNamed && !o.lookingDir )
    {
      /* try to find other split files */
      debugger;
      let found = module._willfileFindMultiple
      ({
        isOutFile : o.isOutFile,
        isNamed : o.isNamed,
        lookingDir : 1,
      });
      debugger;
    }

    return result;
  }
  else
  {
    result.finit();
    return null;
  }

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
  let module = this;
  let rootModule = module.rootModule;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let roles = [ 'single', 'import', 'export' ];
  let files = Object.create( null );

  _.routineOptions( _willfileFindMultiple, arguments );

  for( let r = 0 ; r < roles.length ; r++ )
  {
    let role = roles[ r ];

    files[ role ] = module._willfileFindSingle
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
    for( let w = 0 ; w < module.willfilesArray.length ; w++ )
    {
      let willfile = module.willfilesArray[ w ];
      let name = path.name( willfile.filePath );
      name = _.strRemoveEnd( name, '.will' );
      name = _.strRemoveEnd( name, '.im' );
      name = _.strRemoveEnd( name, '.ex' );
      _.assert( module.configName === null || module.configName === name, 'Name of will files should be the same, something wrong' );
      if( name )
      module.configName = name;
    }
  }

  /* */

  function notNamedNameDeduce()
  {
    module.configName = path.fullName( path.dir( filePaths[ 0 ] ) );
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
    let filePath = module.DirPathFromFilePaths( filePaths );
    if( _.arrayIs( filePaths ) && filePaths.length === 1 )
    filePaths = filePaths[ 0 ];

/*
    let amodule = rootModule.moduleAt( module.commonPath );
    if( amodule )
    {
      debugger; xxx

      for( let a = 0 ; a < module.submoduleAssociation.length ; a++ )
      {
        let submodule = module.submoduleAssociation[ a ];
        _.assert( submodule.openedModule === module );
        submodule.openedModule = amodule;
      }
      debugger;
      module.submoduleAssociation.splice();

      module.finit();

      return true;
    }
*/

    module._filePathChange( filePaths, path.dir( filePath ) );

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
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let filePaths;
  let found;

  o = _.routineOptions( _willfilesFindMaybe, arguments );

  _.assert( module.willfilesArray.length === 0, 'not tested' );
  _.assert( !module.willfilesFindReady.resourcesCount() );
  _.assert( !module.willfilesOpenReady.resourcesCount() );
  _.assert( !module.submodulesFormReady.resourcesCount() );
  _.assert( !module.resourcesFormReady.resourcesCount() );

  /* specific terminal file */

  if( _.arrayIs( module.willfilesPath ) && module.willfilesPath.length === 1 )
  module.willfilesPath = module.willfilesPath[ 0 ];

  // debugger;

  if( !found )
  find( o.isOutFile );
  if( !found )
  find( !o.isOutFile );

  /* */

  return found;

  /* */

  function find( isOutFile )
  {

    /* isOutFile */

    found = module._willfileFindMultiple
    ({
      isOutFile : isOutFile,
      isNamed : 1,
      lookingDir : 1,
    });
    if( found )
    return found;

    found = module._willfileFindMultiple
    ({
      isOutFile : isOutFile,
      isNamed : 1,
      lookingDir : 0,
    });
    if( found )
    return found;

    found = module._willfileFindMultiple
    ({
      isOutFile : isOutFile,
      isNamed : 0,
      lookingDir : 1,
    });
    if( found )
    return found;

    found = module._willfileFindMultiple
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
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 0 );
  _.assert( !!module.pickedWillfilesPath );

  module.pickedWillfilesPath = _.arrayAs( module.pickedWillfilesPath );
  _.assert( _.strsAreAll( module.pickedWillfilesPath ) );

  module.pickedWillfilesPath.forEach( ( filePath ) =>
  {

    let willfile = new will.WillFile
    ({
      role : 'single',
      filePath : filePath,
      module : module,
      data : module.pickedWillfileData,
    }).form1();

    if( willfile.exists() || module.pickedWillfileData )
    result.push( willfile );
    else
    willfile.finit();

  });

  if( result.length )
  {
    let willfilesPath = _.select( result, '*/filePath' );
    module._filePathChange( willfilesPath, path.dir( willfilesPath[ 0 ] ) );
  }

  return result;
}

//

function _willfilesFind()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 0 );

  if( module.pickedWillfilesPath )
  {
    result = module._willfilesFindPickedFile();
  }
  else
  {
    _.assert( !module.pickedWillfileData );
    result = module._willfilesFindMaybe({ isOutFile : !!module.supermodule });
  }

  let result2 = _.Consequence.From( result );
  _.assert( _.consequenceIs( result2 ) );

  result2.then( function( arg )
  {
    if( module.willfilesArray.length )
    _.assert( !!module.willfilesPath && !!module.dirPath );
    return arg;
  });

  result2.finally( function( err, arg )
  {

    let dirPath = module.pickedWillfilesPath;
    if( !dirPath )
    dirPath = module.dirPath;
    if( !dirPath )
    dirPath = module.willfilesPath;
    dirPath = path.common( dirPath );

    // if( !err && module.willfilesArray.length === 0 )
    // debugger;
    if( !err && module.willfilesArray.length === 0 )
    if( module.supermodule )
    throw _.errBriefly( 'Found no .out.will file for',  module.supermodule.nickName, 'at', _.strQuote( dirPath ) );
    else
    throw _.errBriefly( 'Found no willfile at', _.strQuote( dirPath ) );

    if( err )
    throw _.errLogOnce( 'Error looking for will files for', module.nickName, 'at', _.strQuote( dirPath ), '\n', err );
    return arg;
  });

  return result2;
}

//

function willfilesFind()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  // module.stager.stageStateSkipping( 'willfilesFound', 0 );
  module.stager.stageStatePausing( 'willfilesFound', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'willfilesFound' );
}

//

function willfilesPick( filePaths )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  module.pickedWillfilesPath = filePaths;

  module.willfilesFind();
  // module.stager.stageStatePausing( 'willfilesFound', 0 );
  // module.stager.tick();

  return module.willfilesArray.slice();
}

//

function willfilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  // module.stager.stageStateSkipping( 'willfilesOpened', 0 );
  module.stager.stageStatePausing( 'willfilesOpened', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'willfilesOpened' );
}

//

function _willfilesOpen()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().take( null );
  let time = _.timeNow();

  _.assert( arguments.length === 0 );
  _.sure( !!_.mapKeys( module.willfileWithRoleMap ).length && !!module.willfilesArray.length, () => 'Found no will file at ' + _.strQuote( module.dirPath ) );

  /* */

  // if( module.nickName === 'module::Proto' )
  // debugger;

  for( let i = 0 ; i < module.willfilesArray.length ; i++ )
  {
    let willfile = module.willfilesArray[ i ];

    _.assert( willfile.formed === 1 || willfile.formed === 2, 'not expected' );

    if( willfile.formed === 2 )
    continue;

    con.keep( ( arg ) => willfile.open() );

  }

  /* */

  con.finally( ( err, arg ) =>
  {

    // if( module.nickName === 'module::Proto' )
    // debugger;

    if( !module.supermodule )
    {
      if( !err )
      {
        let total = module.willfilesArray.length;
        let opened = _.mapVals( module.submoduleMap );
      }
    }
    if( err )
    throw _.err( err );
    return arg;
  });

  /* */

  return con.split();
}

//

function willfilesReadBegin()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  module.willfilesReadBeginTime = _.timeNow();

  return null;
}

//

function willfilesReadEnd()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  if( will.verbosity >= 2 )
  if( !module.supermodule && !module.original )
  {
    if( !module.willfilesReadTimeReported )
    logger.log( ' . Read', module.willfilesResolve().length, 'willfiles in', _.timeSpent( module.willfilesReadBeginTime ), '\n' );
    module.willfilesReadTimeReported = 1;
  }

  return null;
}

//

function _willfilesExport()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  module.willfileEach( handeWillFile );

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
  let module = this;
  let will = module.will;

  for( let w = 0 ; w < module.willfilesArray.length ; w++ )
  {
    let willfile = module.willfilesArray[ w ];
    onEach( willfile )
  }

  for( let s in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ s ];
    if( !submodule.openedModule )
    continue;

    for( let w = 0 ; w < submodule.openedModule.willfilesArray.length ; w++ )
    {
      let willfile = submodule.openedModule.willfilesArray[ w ];
      onEach( willfile )
    }

  }

}

// --
// submodule
// --

function rootModuleGet()
{
  let module = this;
  while( module.supermodule )
  module = module.supermodule;
  return module;
}

//

function moduleAt( willfilesPath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let rootModule = module.rootModule;

  _.assert( arguments.length === 1 );

  let commonPath = module.CommonPathFor( willfilesPath );

  return rootModule.moduleWithPathMap[ commonPath ];
}

//

function moduleRegister()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  // _.assert( !module.original );
  _.assert( arguments.length === 0 );

  _.assert( rootModule.moduleWithPathMap[ module.commonPath ] === module || rootModule.moduleWithPathMap[ module.commonPath ] === undefined );
  rootModule.moduleWithPathMap[ module.commonPath ] = module;
  _.assert( _.arrayCountElement( _.mapVals( rootModule.moduleWithPathMap ), module ) === 1 );

}

//

function moduleUnregister()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let rootModule = module.rootModule;

  // _.assert( !module.original );
  _.assert( arguments.length === 0 );
  _.assert( _.strIs( module.commonPath ) );

  _.assert( rootModule.moduleWithPathMap[ module.commonPath ] === module || rootModule.moduleWithPathMap[ module.commonPath ] === undefined );
  delete rootModule.moduleWithPathMap[ module.commonPath ];
  _.assert( _.arrayCountElement( _.mapVals( rootModule.moduleWithPathMap ), module ) === 0 );

}

//

function submoduleRegister( submodule )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let rootModule = module.rootModule;

  _.assert( arguments.length === 1 );
  _.assert( module.rootModule === module );
  _.assert( submodule.shortNameArrayGet().length > 1 );
  _.assert( !!module.allSubmodulesMap );

  /* */

  register( submodule.shortNameArrayGet().join( '.' ) );
  register( submodule.name );

  /* */

  function register( name )
  {
    let name0 = name;
    let counter = 1;
    while( module.allSubmodulesMap[ name ] )
    {
      counter += 1;
      name = name0 + '.' + counter;
    }
    module.allSubmodulesMap[ name ] = submodule;
  }

}

// submoduleRegister.default =
// {
//   submodule : null,
//   // shortName : null,
//   // longName : null,
// }

//
// //
//
// function submoduleRegister( o )
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let rootModule = module.rootModule;
//
//   _.assert( arguments.length === 1 );
//   _.assertRoutineOptions( submoduleRegister, arguments );
//
//   if( submodule.module === module )
//   {
//     _.assert( submodule.name === o.shortName );
//     _.assert( module.submoduleMap[ submodule.name ] === submodule )
//   }
//   else
//   {
//     debugger;
//
//     let shortName = o.shortName;
//     if( module.submoduleMap[ shortName ] !== submodule )
//     {
//       if( module.submoduleMap[ shortName ] )
//       debugger;
//       if( module.submoduleMap[ shortName ] )
//       shortName = module.resourceNameAllocate( 'submodule', shortName );
//       module.submoduleMap[ shortName ] = submodule;
//     }
//
//     if( o.shortName !== o.longName )
//     {
//       let longName = o.longName;
//       if( module.submoduleMap[ longName ] !== submodule )
//       {
//         if( module.submoduleMap[ longName ] )
//         debugger;
//         if( module.submoduleMap[ longName ] )
//         longName = module.resourceNameAllocate( 'submodule', longName );
//         module.submoduleMap[ longName ] = submodule;
//       }
//     }
//
//   }
//
//   if( module.supermodule )
//   {
//     debugger;
//     let longName = ( module.aliasName || module.name || '' ) + '.' + o.longName;
//     module.supermodule.submoduleRegister
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
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let rootModule = module.rootModule;
//
//   _.assert( arguments.length === 1 );
//
//
//
//   return rootModule.moduleWithPathMap[ commonPath ];
// }

//

function submodulesAllAreDownloaded()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !module.supermodule );

  for( let n in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ n ].openedModule;
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
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !module.supermodule );

  for( let n in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ n ].openedModule;
    if( !submodule )
    continue;
    if( !submodule.isValid() )
    return false;
  }

  return true;
}

//

function submodulesClean()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 0 );

  let result = module.clean
  ({
    cleaningSubmodules : 1,
    cleaningOut : 0,
    cleaningTemp : 0,
  });

  return result;
}

//

function submodulesReload()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  return module.ready
  .then( function( arg )
  {
    return module._submodulesForm();
  })
  .split();

}

//

function _submodulesDownload_pre( routine, args )
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

  return o;
}

function _submodulesDownload_body( o )
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
  let con = new _.Consequence().take( null );

  o.downloaded = o.downloaded || Object.create( null );

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _submodulesDownload_body, arguments );

  logger.up();

  downloadAgain();

  con.finally( ( err, arg ) =>
  {
    logger.down();
    if( err )
    throw _.err( 'Failed to', ( o.updating ? 'update' : 'download' ), 'submodules of', module.decoratedNickName, '\n', err );
    logger.rbegin({ verbosity : -2 });
    if( o.dry )
    logger.log( ' + ' + downloadedNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedNickName + ' will be ' + ( o.updating ? 'updated' : 'downloaded' ) );
    else
    logger.log( ' + ' + downloadedNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedNickName + ' were ' + ( o.updating ? 'updated' : 'downloaded' ) + ' in ' + _.timeSpent( time ) );
    logger.rend({ verbosity : -2 });
    return arg;
  });

  return con;

  /* */

  function downloadAgain()
  {
    let remoteNumberWas;

    remoteNumberWas = remoteNumber;

    for( let n in module.submoduleMap )
    {
      let submodule = module.submoduleMap[ n ].openedModule;
      // submodule.preform();
      // _.assert( !!submodule && submodule.preformed === 3, 'Submodule', ( submodule ? submodule.nickName : n ), 'was not preformed' );
      _.assert( !!submodule && submodule.stager.stageStatePerformed( 'preformed' ), 'Submodule', ( submodule ? submodule.nickName : n ), 'was not preformed' );

      if( !submodule.isRemote )
      continue;

      con.then( () =>
      {

        if( o.downloaded[ submodule.remotePath ] )
        return null;

        remoteNumber += 1;

        let o2 = _.mapExtend( null, o );
        delete o2.downloaded;
        // debugger;
        let r = _.Consequence.From( submodule._remoteDownload( o2 ) );
        return r.keep( ( arg ) =>
        {
          _.assert( _.boolIs( arg ) );
          _.assert( _.strIs( submodule.remotePath ) );
          // debugger;
          o.downloaded[ submodule.remotePath ] = submodule;

          if( arg )
          downloadedNumber += 1;

          // if( arg && o.recursive )
          // {
          //   debugger;
          //   let o2 = _.mapExtend( null, o );
          //   return submodule._submodulesDownload( o2 );
          // }

          return arg;
        });

      });

    }

  }

  /* */

  function downloadRecursive()
  {
    let remoteNumberWas;

    remoteNumberWas = remoteNumber;

    for( let n in module.submoduleMap )
    {
      let submodule = module.submoduleMap[ n ];

      if( !submodule.openedModule )
      {
        debugger;
        submodule.form();
      }

    }

  }

}

_submodulesDownload_body.defaults =
{
  updating : 0,
  forming : 1,
  recursive : 1,
  dry : 0,
  downloaded : null,
}

let _submodulesDownload = _.routineFromPreAndBody( _submodulesDownload_pre, _submodulesDownload_body );

//

let submodulesDownload = _.routineFromPreAndBody( _submodulesDownload_pre, _submodulesDownload_body, 'submodulesDownload' );
submodulesDownload.defaults.updating = 0;

//

let submodulesUpdate = _.routineFromPreAndBody( _submodulesDownload_pre, _submodulesDownload_body, 'submodulesUpdate' );
submodulesUpdate.defaults.updating = 1;

//

function submodulesFixate( o )
{
  let module = this;
  let will = module.will;
  let logger = will.logger;

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( submodulesFixate, arguments );

  debugger;

  let o2 = _.mapExtend( null, o );
  o2.submodule = module;
  module.moduleFixate( o2 );

  for( let m in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ m ].openedModule;
    if( !submodule )
    continue;

    let o2 = _.mapExtend( null, o );
    o2.submodule = submodule;
    module.moduleFixate( o2 );

  }

  return module;
}

submodulesFixate.defaults =
{
  dry : 0,
  upgrading : 0,
}

//

function moduleFixate( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( !_.mapIs( o ) )
  o = { submodule : o }

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( o.dry ) );
  _.assert( _.boolLike( o.upgrading ) );
  _.assert( o.submodule.supermodule === null || o.submodule.supermodule === module );
  _.routineOptions( moduleFixate, o );

  //  remote

  let counter = 0;

  o.submodule.submoduleAssociation.forEach( ( submodule ) =>
  {

    let o2 = _.mapExtend( null, o );
    o2.remotePath = submodule.path;
    o2.willfilePath = submodule.willf.filePath;
    let fixatedPath = module.moduleFixatePath( o2 );
    if( fixatedPath )
    {
      if( !o.dry )
      {
        o.submodule.remotePath = fixatedPath;
        submodule.path = fixatedPath;
      }
      counter += 1;
    }

  });

  let remote = o.submodule.pathResourceMap[ 'remote' ];
  if( remote && remote.path && remote.path.length && remote.willf && !!o.submodule.supermodule )
  {

    debugger;

    if( _.arrayIs( remote.path ) && remote.path.length === 1 )
    remote.path = remote.path[ 0 ];

    _.assert( _.strIs( remote.path ) );

    let o2 = _.mapExtend( null, o );
    o2.remotePath = remote.path;
    o2.willfilePath = remote.willf.filePath;
    o2.secondaryWillFilesPath = remote.module.pathResolve
    ({
      selector : 'path::module.original.willfiles',
      missingAction : 'undefine',
    });
    let fixatedPath = module.moduleFixatePath( o2 );
    if( fixatedPath )
    {
      if( !o.dry )
      {
        debugger;
        remote.path = fixatedPath;
        _.assert( o.submodule.remotePath === fixatedPath );
      }
      counter += 1;
    }

  }

  return counter;
}

var defaults = moduleFixate.defaults = Object.create( submodulesFixate.defaults );
defaults.submodule = null;

//

function moduleFixatePath( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( !_.mapIs( o ) )
  o = { submodule : o }

  _.assert( module.preformed > 0  );
  _.assert( arguments.length === 1 );
  _.assert( _.boolLike( o.dry ) );
  _.assert( _.boolLike( o.upgrading ) );
  _.assert( o.submodule.supermodule === null || o.submodule.supermodule === module );
  _.routineOptions( moduleFixatePath, o );

  if( _.strIs( o.secondaryWillFilesPath ) )
  o.secondaryWillFilesPath = _.arrayAs( o.secondaryWillFilesPath );

  if( !o.remotePath )
  return false;

  if( _.arrayIs( o.remotePath ) && o.remotePath.length === 0 )
  return false;

  let vcs = will.vcsFor( o.remotePath );

  if( !vcs )
  return false;

  if( !o.upgrading )
  if( vcs.pathIsFixated( o.remotePath ) )
  return false;

  let fixatedPath = vcs.pathFixate( o.remotePath );

  if( !fixatedPath )
  return false;

  if( fixatedPath === o.remotePath )
  return false;

  let log = '';

  fileReplace( o.willfilePath, 1 );
  if( o.secondaryWillFilesPath )
  for( let f = 0 ; f < o.secondaryWillFilesPath.length ; f++ )
  fileReplace( o.secondaryWillFilesPath[ f ], 0 );

  if( will.verbosity >= 2 )
  logger.log( log );

  return fixatedPath;

  function fileReplace( willfilePath, mandatory )
  {

    let code = fileProvider.fileRead( willfilePath );

    if( !mandatory )
    {
      if( !_.strHas( code, o.remotePath ) )
      return false;
    }

    _.sure( _.strHas( code, o.remotePath ), () => 'Failed to parse ' + _.color.strFormat( o.willfilePath, 'path' ) + ' to replace ' + _.color.strFormat( o.remotePath, 'path' ) );

    if( will.verbosity >= 2 )
    {
      let fixated = 'fixated to version';
      if( o.dry )
      fixated = 'will be fixated to version';
      let moveReport = path.moveReport( fixatedPath, o.remotePath );

      if( !log.length )
      {
        log += 'Remote path of ' + o.submodule.decoratedAbsoluteName + ' ' + fixated;
        log += '\n  ' + moveReport;
      }

      log += '\n  in ' + _.color.strFormat( willfilePath, 'path' );

    }

    if( !o.dry )
    {
      code = code.replace( o.remotePath, fixatedPath );
      fileProvider.fileWrite( willfilePath, code );
    }

    return true;
  }

}

var defaults = moduleFixatePath.defaults = Object.create( moduleFixate.defaults );
defaults.remotePath = null;
defaults.willfilePath = null;
defaults.secondaryWillFilesPath = null;

//

function submodulesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  // module.stager.stageStateSkipping( 'submodulesFormed', 0 );
  module.stager.stageStatePausing( 'submodulesFormed', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'submodulesFormed' );
}

//

function _submodulesForm()
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
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  module._resourcesAllForm( will.Submodule, con );

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

// --
// remote
// --

function remoteIsUpdate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.willfilesPath || !!module.dirPath );
  _.assert( arguments.length === 0 );

  let remoteProvider = fileProvider.providerForPath( module.commonPath );
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

function remoteIsUpToDateUpdate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.localPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( module.remotePath );

  _.assert( !!remoteProvider.isVcs );

  debugger;
  let result = remoteProvider.isUpToDate
  ({
    remotePath : module.remotePath,
    localPath : module.localPath,
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
    module.isUpToDate = !!result;
    return result;
  }

}

//

function remoteIsDownloadedUpdate()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( _.strDefined( module.localPath ) );
  _.assert( !!module.willfilesPath );
  _.assert( module.isRemote === true );

  let remoteProvider = fileProvider.providerForPath( module.remotePath );
  _.assert( !!remoteProvider.isVcs );

  let result = remoteProvider.isDownloaded
  ({
    localPath : module.localPath,
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
    module.isDownloaded = !!result;
    return result;
  }
}

//

function remoteIsDownloadedChanged()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( !!module.pathResourceMap[ 'current.remote' ] );

  /* */

  if( module.isDownloaded &&  module.remotePath )
  {

    let remoteProvider = fileProvider.providerForPath( module.remotePath );
    _.assert( !!remoteProvider.isVcs );

    let version = remoteProvider.versionLocalRetrive( module.localPath );
    if( version )
    {
      let remotePath = _.uri.parseConsecutive( module.remotePath );
      remotePath.hash = version;
      module.pathResourceMap[ 'current.remote' ].path = _.uri.str( remotePath );
    }
  }
  else
  {
    module.pathResourceMap[ 'current.remote' ].path = null;
  }

  /* */

  if( !module.localPath )
  if( module.dirPath )
  {
    _.assert( _.strIs( module.dirPath ) );
    // module.localPath = module.dirPath; // yyy
  }

}

//

function remoteIsDownloadedSet( src )
{
  let module = this;

  src = !!src;

  let changed = module[ isDownloadedSymbol ] !== undefined && module[ isDownloadedSymbol ] !== src;

  module[ isDownloadedSymbol ] = src;

  if( changed )
  module.remoteIsDownloadedChanged();

}

//

function remoteForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  module.isRemote = module.remoteIsUpdate();

  if( module.isRemote )
  {
    module._remoteFormAct();
  }
  else
  {
    module.isDownloaded = 1;
    // _.assert( module.localPath === module.dirPath );
  }

  return module;
}

//

function _remoteFormAct()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let willfilesPath = module.willfilesPath;

  _.assert( _.strDefined( module.aliasName ) );
  _.assert( !!module.supermodule );
  _.assert( _.strIs( willfilesPath ) );

  let remoteProvider = fileProvider.providerForPath( module.commonPath );

  _.assert( remoteProvider.isVcs && _.routineIs( remoteProvider.pathParse ), () => 'Seems file provider ' + remoteProvider.nickName + ' does not have version control system features' );

  let submodulesDir = module.supermodule.cloneDirGet();
  let parsed = remoteProvider.pathParse( willfilesPath );

  module.remotePath = willfilesPath;
  module.localPath = path.resolve( submodulesDir, module.aliasName );

  let willfilesPath2 = path.resolve( module.localPath, parsed.localVcsPath );
  module._filePathChange( willfilesPath2, path.dir( willfilesPath2 ) );

  module.remoteIsDownloadedUpdate();

  _.assert( will.moduleMap[ module.id ] === module );

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
  let downloading = false;
  let con = _.Consequence().take( null );

  _.routineOptions( _remoteDownload, o );
  _.assert( arguments.length === 1 );
  _.assert( module.preformed > 0  );
  _.assert( !!module.willfilesPath );
  _.assert( _.strDefined( module.aliasName ) );
  _.assert( _.strDefined( module.remotePath ) );
  _.assert( _.strDefined( module.localPath ) );
  _.assert( !!module.supermodule );

  return con
  .keep( () =>
  {
    if( o.updating )
    return module.remoteIsUpToDateUpdate();
    else
    return module.remoteIsDownloadedUpdate();
  })
  .keep( function( arg )
  {

    if( o.updating )
    downloading = !module.isUpToDate;
    else
    downloading = !module.isDownloaded;

    /*
    delete old remote module if it has a critical error or downloaded files are corrupted
    */

    if( !o.dry )
    if( module.willfilesOpenReady.errorsCount() || !module.isDownloaded )
    {
      // logger.log( '_remoteDownload/filesDelete', module.localPath );
      fileProvider.filesDelete({ filePath : module.localPath, throwing : 0, sync : 1 });
    }

    return arg;
  })
  .keep( () =>
  {

    let o2 =
    {
      reflectMap : { [ module.remotePath ] : module.localPath },
      verbosity : will.verbosity - 5,
      extra : { fetching : 0 },
    }

    if( downloading && !o.dry )
    return will.Predefined.filesReflect.call( fileProvider, o2 );

    return null;
  })
  .keep( function( arg )
  {
    module.isUpToDate = true;
    module.isDownloaded = true;
    if( o.forming && !o.dry && downloading )
    {
      _.assert( module.stager.stageStatePerformed( 'preformed' ) );

      module.close();

      module.stager.stageStateSkipping( 'submodulesFormed', 1 );
      module.stager.stageStateSkipping( 'resourcesFormed', 1 );

      module.willfilesFind();

      return module.ready
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
    throw _.err( 'Failed to', ( o.updating ? 'update' : 'download' ), module.decoratedAbsoluteName, '\n', err );
    if( will.verbosity >= 3 && downloading )
    {
      if( o.dry )
      {
        let remoteProvider = fileProvider.providerForPath( module.remotePath );
        let version = remoteProvider.versionRemoteCurrentRetrive( module.remotePath );
        logger.log( ' + ' + module.decoratedNickName + ' will be ' + ( o.updating ? 'updated to' : 'downloaded' ) + ' version ' + _.color.strFormat( version, 'path' ) );
      }
      else
      {
        let remoteProvider = fileProvider.providerForPath( module.remotePath );
        debugger; // xxx
        let version = remoteProvider.versionLocalRetrive( module.localPath );
        debugger;
        logger.log( ' + ' + module.decoratedNickName + ' was ' + ( o.updating ? 'updated to' : 'downloaded' ) + ' version ' + _.color.strFormat( version, 'path' ) + ' in ' + _.timeSpent( time ) );
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
  let module = this;
  let will = module.will;
  return module._remoteDownload({ updating : 0 });
}

//

function remoteUpgrade()
{
  let module = this;
  let will = module.will;
  return module._remoteDownload({ updating : 1 });
}

//

function remoteCurrentVersion()
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
  return remoteProvider.versionLocalRetrive( module.localPath );
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
  return remoteProvider.versionRemoteLatestRetrive( module.localPath )
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

  // module.stager.stageStateSkipping( 'resourcesFormed', 0 );
  module.stager.stageStatePausing( 'resourcesFormed', 0 );
  module.stager.tick();

  return module.stager.stageConsequence( 'resourcesFormed' );
}

//

function _resourcesForm()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().take( null );

  if( !module.supermodule )
  if( module.submodulesAllAreDownloaded() && module.submodulesAllAreValid() )
  {

    con.keep( () => module._resourcesFormAct() );

    con.keep( ( arg ) =>
    {
      // if( !module.supermodule )
      // module._willfilesCacheSave();
      return arg;
    });

  }
  else
  {
    if( will.verbosity === 2 )
    logger.error( ' ! One or more submodules of ' + module.decoratedNickName + ' were not downloaded!'  );
  }

  return con;
}

//

function _resourcesFormAct()
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
  _.assert( !!module.preformed );

  let con = _.Consequence().take( null );

  /* */

  module._resourcesAllForm( will.Submodule, con );
  module._resourcesAllForm( will.Exported, con );
  module._resourcesAllForm( will.PathResource, con );
  module._resourcesAllForm( will.Reflector, con );
  module._resourcesAllForm( will.Step, con );
  module._resourcesAllForm( will.Build, con );

  /* */

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con.split();
}

//

function _resourcesAllForm( Resource, con )
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
    con.keep( ( arg ) => resource.form2() );
  }

  for( let s in module[ Resource.MapName ] )
  {
    let resource = module[ Resource.MapName ][ s ];
    con.keep( ( arg ) => resource.form3() );
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

  // if( resourceKind === 'module' )
  // debugger;

  if( resourceKind === 'export' )
  result = module.buildMap;
  else if( resourceKind === 'about' )
  result = module.about.values;
  else if( resourceKind === 'module' )
  result = module.rootModule.moduleWithNameMap;
  else
  result = module[ will.ResourceKindToMapName.forKey( resourceKind ) ];

  _.assert( arguments.length === 1 );
  _.sure( _.objectIs( result ), () => 'Cant find resource map for resource kind ' + _.strQuote( resourceKind ) );

  return result;
}

//

function resourceMaps()
{
  let module = this;
  let will = module.will;

  // let ResourcesNames =
  // [
  //   // 'about',
  //   'submodule',
  //   'step',
  //   'path',
  //   'reflector',
  //   'build',
  //   'exported',
  // ]

  let Resources =
  {
    // 'about',
    'submodule' : module.resourceMapForKind( 'submodule' ),
    'path' : module.resourceMapForKind( 'path' ),
    'reflector' : module.resourceMapForKind( 'reflector' ),
    'step' : module.resourceMapForKind( 'step' ),
    'build' : module.resourceMapForKind( 'build' ),
    'exported' : module.resourceMapForKind( 'exported' ),
  }

  // if( !_.path.isGlob( resourceSelector ) )
  // return module.resourceMapForKind( resourceSelector );
  //
  // let result = _.path.globFilter( ResourcesNames, resourceSelector );
  //
  // result = result.map( ( resourceSelector ) => module.resourceMapForKind( resourceSelector ) );

  return Resources;
}

//

function resourceMapsForKind( resourceSelector )
{
  let module = this;
  let will = module.will;

  let ResourcesNames =
  [
    'module',
    'submodule',
    'path',
    'reflector',
    'step',
    'build',
    'exported',
  ]

  let Resources =
  {
    'module' : module.resourceMapForKind( 'module' ),
    'submodule' : module.resourceMapForKind( 'submodule' ),
    'path' : module.resourceMapForKind( 'path' ),
    'reflector' : module.resourceMapForKind( 'reflector' ),
    'step' : module.resourceMapForKind( 'step' ),
    'build' : module.resourceMapForKind( 'build' ),
    'exported' : module.resourceMapForKind( 'exported' ),
  }

  if( !_.path.isGlob( resourceSelector ) )
  return module.resourceMapForKind( resourceSelector );

  let result = _.path.globFilterKeys( Resources, resourceSelector );

  return result;
}

//

function resourceObtain( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceName ) );

  let resource = module.resolve
  ({
    selector : resourceKind + '::' + resourceName,
    pathResolving : 0,
    pathUnwrapping : 0,
    missingAction : 'undefine',
  });

  if( !resource )
  resource = module.resourceAllocate( resourceKind, resourceName );

  _.assert( resource instanceof will.Resource );
  if( resource instanceof will.PathResource )
  _.assert( module.pathResourceMap[ resource.name ] === resource );

  return resource;
}

//

function resourceAllocate( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceName ) );

  let resourceName2 = module.resourceNameAllocate( resourceKind, resourceName );
  let cls = module.resourceClassForKind( resourceKind );
  let resource = new cls({ module : module, name : resourceName2 }).form1();

  return resource;
}

//

function resourceNameAllocate( resourceKind, resourceName )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( resourceKind ) );
  _.assert( _.strIs( resourceName ) );

  let map = module.resourceMapForKind( resourceKind );

  if( map[ resourceName ] === undefined )
  return resourceName;

  let counter = 1;
  let resourceName2;

  let ends = /\.\d+$/;
  if( ends.test( resourceName ) )
  resourceName = resourceName.replace( ends, '' );

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

//

function cloneDirGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  _.assert( arguments.length === 0 );
  return path.join( module.dirPath, '.module' );
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
  let rootModule = module.rootModule;

  module.moduleUnregister();

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

  module.moduleRegister();

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

//

function commonPathGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let willfilesPath = module.willfilesPath ? module.willfilesPath : module.dirPath;

  if( !willfilesPath )
  return null;

  let common = module.CommonPathFor( willfilesPath );

  return common;
}

//

function CommonPathFor( willfilesPath )
{
  if( _.arrayIs( willfilesPath ) )
  willfilesPath = willfilesPath[ 0 ];

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( willfilesPath ) );

  let common = willfilesPath.replace( /\.will\.\w+$/, '' );

  common = common.replace( /(\.im|\.ex)$/, '' );

  return common;
}

//

function nonExportablePathGet_functor( fieldName, resourceName )
{

  return function nonExportablePathGet()
  {
    let module = this;

    if( !module.will)
    return null;

    return module.pathMap[ resourceName ] || null;
  }

}

//

function nonExportablePathSet_functor( fieldName, resourceName )
{

  return function nonExportablePathSet( filePath )
  {
    let module = this;

    // if( fieldName === 'willfilesPath' )
    // debugger;

    if( !module.will && !filePath )
    return filePath;

    if( !module.pathResourceMap[ resourceName ] )
    {
      let resource = new _.Will.PathResource({ module : module, name : resourceName }).form1();
      resource.criterion = resource.criterion || Object.create( null );
      resource.criterion.predefined = 1;
      resource.writable = 0;
    }

    _.assert( !!module.pathResourceMap[ resourceName ] );

    module.pathResourceMap[ resourceName ].path = filePath;

    return filePath;
  }

}

let willfilesPathGet = nonExportablePathGet_functor( 'willfilesPath', 'module.willfiles' );
let dirPathGet = nonExportablePathGet_functor( 'dirPath', 'module.dir' );
let localPathGet = nonExportablePathGet_functor( 'localPath', 'local' );
let remotePathGet = nonExportablePathGet_functor( 'remotePath', 'remote' );
let currentRemotePathGet = nonExportablePathGet_functor( 'currentRemotePath', 'current.remote' );
let willPathGet = nonExportablePathGet_functor( 'willPath', 'will' );

let willfilesPathSet = nonExportablePathSet_functor( 'willfilesPath', 'module.willfiles' );
let _dirPathChange = nonExportablePathSet_functor( 'dirPath', 'module.dir' );
let localPathSet = nonExportablePathSet_functor( 'localPath', 'local' );
let remotePathSet = nonExportablePathSet_functor( 'remotePath', 'remote' );

// --
// name
// --

function nameGet()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;

  if( !name && module.aliasName )
  name = module.aliasName;
  if( !name && module.about )
  name = module.about.name;

  if( !name && module.configName )
  name = module.configName;
  if( !name && module.commonPath )
  name = path.fullName( module.commonPath );

  return name;
}

//

function nameChanged()
{
  let module = this;
  let will = module.will;

  if( !will )
  return;

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let name = null;
  let rootModule = module.rootModule;
  let c = 0;

  for( let m in rootModule.moduleWithNameMap )
  {
    if( rootModule.moduleWithNameMap[ m ] === module )
    delete rootModule.moduleWithNameMap[ m ];
  }

  if( module.aliasName )
  if( !rootModule.moduleWithNameMap[ module.aliasName ] )
  {
    c += 1;
    rootModule.moduleWithNameMap[ module.aliasName ] = module;
  }

  if( module.configName )
  if( !rootModule.moduleWithNameMap[ module.configName ] )
  {
    c += 1;
    rootModule.moduleWithNameMap[ module.configName ] = module;
  }

  if( module.about && module.about.name )
  if( !rootModule.moduleWithNameMap[ module.about.name ] )
  {
    c += 1;
    rootModule.moduleWithNameMap[ module.about.name ] = module;
  }

}

//

function aliasNameSet( src )
{
  let module = this;
  module[ aliasSymbol ] = src;
  module.nameChanged();
}

//

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

function absoluteNameGet()
{
  let module = this;
  let supermodule = module.supermodule;
  if( supermodule )
  return supermodule.nickName + ' / ' + module.nickName;
  else
  return module.nickName;
}

//

function decoratedAbsoluteNameGet()
{
  let module = this;
  let result = module.absoluteName;
  return _.color.strFormat( result, 'entity' );
}

//

function shortNameArrayGet()
{
  let module = this;
  let supermodule = module.supermodule;
  if( !supermodule )
  return [ module.name ];
  let result = supermodule.shortNameArrayGet();
  result.push( module.name );
  return result;
}

// --
// clean
// --

function cleanWhat( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let exps = module.exportsResolve();
  let filePaths = [];
  let result = Object.create( null );
  result[ '/' ] = filePaths;

  o = _.routineOptions( cleanWhat, arguments );

  /* submodules */

  if( o.cleaningSubmodules )
  {

    let submodulesCloneDirPath = module.cloneDirGet();
    find( submodulesCloneDirPath );

  }

  /* out */

  if( o.cleaningOut )
  {
    let files = [];

    for( let e = 0 ; e < exps.length ; e++ )
    {
      let exp = exps[ e ];
      let archiveFilePath = exp.archiveFilePathFor();
      let outFilePath = exp.outFilePathFor();
      _.arrayAppendArrayOnce( files, [ archiveFilePath, outFilePath ] );
    }

    find( files );
  }

  /* temp dir */

  if( o.cleaningTemp )
  {
    let temp;

    temp = module.reflectorResolve
    ({
      selector : 'reflector::temp',
      pathResolving : 'in',
      missingAction : 'undefine',
    });

    if( temp )
    {
      let o2 = temp.optionsForFindExport();
      find( o2 );
    }

    if( !temp )
    {
      temp = module.pathResolve
      ({
        selector : 'path::temp',
        pathResolving : 'in',
        missingAction : 'undefine',
      });

      if( !temp )
      temp = [];

      temp = _.arrayAs( path.s.join( module.inPath, temp ) );

      for( let p = 0 ; p < temp.length ; p++ )
      {
        let filePath = temp[ p ];
        find( filePath );
      }

    }

  }

  filePaths.sort();

  return result;

  /* - */

  function find( op )
  {

    if( _.arrayIs( op ) || _.strIs( op ) )
    op = { filter : { filePath : op } }

    if( _.arrayIs( op.filter.filePath.length ) && !op.filter.filePath.length )
    return;

    let def =
    {
      verbosity : 0,
      allowingMissed : 1,
      recursive : 2,
      includingDirs : 1,
      includingTerminals : 1,
      maskPreset : 0,
      outputFormat : 'absolute',
      writing : 0,
      deletingEmptyDirs : 1,
    }

    _.mapSupplement( op, def );

    let found = fileProvider.filesDelete( op );
    _.assert( op.filter.formed === 5 );
    let filePath = path.pathMapSrcFromSrc( op.filter.filePath );
    let commonPath = filePath.length ? path.detrail( path.common( filePath ) ) : '';

    found = _.arrayFlattenOnce( found );

    if( found.length )
    _.arrayFlattenOnce( filePaths, found );

    if( found.length )
    for( let p in result )
    {
      if( !_.strHas( commonPath, p ) )
      continue;
      if( p === '/' )
      continue;
      if( !result[ commonPath ] )
      result[ commonPath ] = found;
      else
      _.arrayFlattenOnce( result[ commonPath ], found );
      found = [];
      break;
    }

    if( found.length )
    if( !result[ commonPath ] )
    result[ commonPath ] = found;
    else
    _.arrayFlattenOnce( result[ commonPath ], found );

  }

}

cleanWhat.defaults =
{
  cleaningSubmodules : 1,
  cleaningOut : 1,
  cleaningTemp : 1,
}

//

function cleanWhatReport()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let time = _.timeNow();
  let filesPath = module.cleanWhat();
  logger.log();

  if( logger.verbosity >= 4 )
  logger.log( _.toStr( filesPath[ '/' ], { multiline : 1, wrap : 0, levels : 2 } ) );

  if( logger.verbosity >= 2 )
  {
    let details = _.filter( filesPath, ( filesPath, basePath ) =>
    {
      if( basePath === '/' )
      return;
      if( !filesPath.length )
      return;
      return filesPath.length + ' at ' + basePath;
    });
    logger.log( _.mapVals( details ).join( '\n' ) );
  }

  logger.log( 'Clean will delete ' + filesPath[ '/' ].length + ' file(s) in total, found in ' + _.timeSpent( time ) );

  return filesPath;

}

cleanWhatReport.defaults = Object.create( cleanWhat.defaults );

//

function clean()
{
  let module = this;
  let will = module.will;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let time = _.timeNow();
  let files = module.cleanWhat.apply( module, arguments );

  _.assert( _.arrayIs( files[ '/' ] ) );

  for( let f = files[ '/' ].length-1 ; f >= 0 ; f-- )
  {
    let filePath = files[ '/' ][ f ];
    _.assert( path.isAbsolute( filePath ) );
    fileProvider.fileDelete({ filePath : filePath, verbosity : 1, throwing : 0 });
  }

  if( logger.verbosity >= 2 )
  logger.log( ' - Clean deleted ' + files[ '/' ].length + ' file(s) in ' + _.timeSpent( time ) );

  return files;
}

clean.defaults = Object.create( cleanWhat.defaults );

// --
// resolver
// --

function _selectorShortSplitAct( selector )
{
  let module = this;
  _.assert( !_.strHas( selector, '/' ) );
  let result = _.strIsolateLeftOrNone( selector, '::' );
  return result;
}

//

function _selectorShortSplit( o )
{
  let module = this;
  let will = module.will;
  let result;

  _.assertRoutineOptions( _selectorShortSplit, o );
  _.assert( arguments.length === 1 );
  _.assert( !_.strHas( o.selector, '/' ) );
  _.sure( _.strIs( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let splits = module._selectorShortSplitAct( o.selector );

  if( !splits[ 0 ] && o.defaultResourceName )
  {
    splits = [ o.defaultResourceName, '::', o.selector ];
  }

  return splits;
}

var defaults = _selectorShortSplit.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceName = null;

//

function selectorLongSplit( o )
{
  let module = this;
  let will = module.will;
  let result = [];

  if( _.strIs( o ) )
  o = { selector : o }

  _.routineOptions( selectorLongSplit, o );
  _.assert( arguments.length === 1 );
  _.sure( _.strIs( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let selectors = o.selector.split( '/' );

  selectors.forEach( ( selector ) =>
  {
    let o2 = _.mapExtend( null, o );
    o2.selector = selector;
    result.push( module._selectorShortSplit( o2 ) );
  });

  return result;
}

var defaults = selectorLongSplit.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceName = null;

//

function selectorParse( o )
{
  let module = this;
  let will = module.will;
  let result = [];

  if( _.strIs( o ) )
  o = { selector : o }

  _.routineOptions( selectorParse, o );
  _.assert( arguments.length === 1 );
  _.sure( _.strIs( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let splits = _.strSplitFast
  ({
    src : o.selector,
    delimeter : [ '{', '}' ],
  });

  splits = _.strSplitsCoupledGroup({ splits : splits, prefix : '{', postfix : '}' });

  if( splits[ 0 ] === '' )
  splits.splice( 0, 1 );
  if( splits[ splits.length-1 ] === '' )
  splits.splice( splits.length-1, 1 );

  splits = splits.map( ( split ) =>
  {
    if( !_.arrayIs( split ) )
    return split;
    _.assert( split.length === 3 )
    if( module.SelectorIs( split[ 1 ] ) )
    {
      let o2 = _.mapExtend( null, o );
      o2.selector = split[ 1 ];
      split[ 1 ] = module.selectorLongSplit( o2 );
    }
    return split;
  });

  return splits;
}

var defaults = selectorParse.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceName = null;

//

function SelectorIsPrimitive( selector )
{
  if( !_.strIs( selector ) )
  return false;
  if( !_.strHas( selector, '::' ) )
  return false;
  return true;
}

//

function SelectorIs( selector )
{
  if( _.arrayIs( selector ) )
  {
    for( let s = 0 ; s < selector.length ; s++ )
    if( this.SelectorIs( selector[ s ] ) )
    return true;
  }
  return this.SelectorIsPrimitive( selector );
}

//

function SelectorIsComposite( selector )
{

  if( !this.SelectorIs( selector ) )
  return false;

  if( _.arrayIs( selector ) )
  {
    for( let s = 0 ; s < selector.length ; s++ )
    if( isComposite( selector[ s ] ) )
    return true;
  }
  else
  {
    return isComposite( selector );
  }

  /* */

  function isComposite( selector )
  {

    let splits = _.strSplitFast
    ({
      src : selector,
      delimeter : [ '{', '}' ],
    });

    if( splits.length < 5 )
    return false;

    splits = _.strSplitsCoupledGroup({ splits : splits, prefix : '{', postfix : '}' });

    if( !splits.some( ( split ) => _.arrayIs( split ) ) )
    return false;

    return true;
  }

}

function errResolving( o )
{
  let module = this;
  _.assertRoutineOptions( errResolving, arguments );
  // _.routineOptions( errResolving, arguments );
  if( o.currentContext && o.currentContext.nickName )
  return _.err( 'Failed to resolve', _.color.strFormat( o.selector, 'code' ), 'for', o.currentContext.decoratedNickName, 'in', module.decoratedNickName, '\n', o.err );
  else
  return _.err( 'Failed to resolve', _.color.strFormat( o.selector, 'code' ), 'in', module.decoratedNickName, '\n', o.err );
}

errResolving.defaults =
{
  err : null,
  currentContext : null,
  selector : null,
}

//

function errThrow( o )
{
  let module = this;
  _.assertRoutineOptions( errThrow, arguments );
  if( o.missingAction === 'undefine' )
  return;
  debugger;
  let err = module.errResolving
  ({
    selector : o.selector,
    currentContext : o.currentContext,
    err : o.err,
  });
  if( o.missingAction === 'throw' )
  throw err;
  else
  return err;

}

errThrow.defaults =
{
  missingAction : null,
  err : null,
  currentContext : null,
  selector : null,
}

//

function resolveContextPrepare( o )
{
  let module = this;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.routineOptions( resolveContextPrepare, arguments );

  if( !o.currentThis )
  return o.currentThis;

  if( _.mapIs( o.currentThis ) )
  {
  }
  else if( o.currentThis instanceof will.Reflector )
  {
    let currentThis = Object.create( null );
    currentThis.src = [];
    currentThis.dst = [];
    let o2 = o.currentThis.optionsForFindGroupExport();
    o2.outputFormat = 'absolute';
    let found = fileProvider.filesFindGroups( o2 );
    currentThis.filesGrouped = found.filesGrouped;
    for( let dst in found.filesGrouped )
    {
      currentThis.dst.push( hardDrive.path.nativize( dst ) );
      currentThis.src.push( hardDrive.path.s.nativize( found.filesGrouped[ dst ] ).join( ' ' ) );
    }
    o.currentThis = currentThis;
  }
  else _.assert( 0 );

  return o.currentThis;
}

resolveContextPrepare.defaults =
{
  currentThis : null,
}

//

function resolve_pre( routine, args )
{
  let o = args[ 0 ];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { selector : o }

  _.routineOptions( routine, o );

  if( o.visited === null )
  o.visited = [];

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.arrayHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), 'Unknown value of option path resolving', o.pathResolving );
  _.assert( _.arrayHas( [ 'undefine', 'throw', 'error' ], o.missingAction ), 'Unknown value of option missing action', o.missingAction );
  _.assert( _.arrayHas( [ 'default', 'resolved', 'throw', 'error' ], o.prefixlessAction ), 'Unknown value of option prefixless action', o.prefixlessAction );
  // _.assert( o.prefixlessAction === 'default' || o.defaultResourceName === null, 'prefixlessAction should be "default" if defaultResourceName is provided' );
  _.assert( _.arrayIs( o.visited ) );
  _.assert( !o.defaultResourceName || !_.path.isGlob( o.defaultResourceName ), 'Expects non glob {-defaultResourceName-}' );

  return o;
}

//

function resolve_body( o )
{
  let module = this;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentContext = o.currentContext = o.currentContext || module;

  _.assert( o.prefixlessAction === 'default' || o.defaultResourceName === null, 'Prefixless action should be "default" if default resource is provided' );

  if( o.currentThis )
  {
    o.currentThis = module.resolveContextPrepare({ currentThis : o.currentThis });
  }

  let result = module._resolveAct( o );

  if( result === undefined )
  {
    result = module.errResolving
    ({
      selector : o.selector,
      currentContext : o.currentContext,
      err : _.ErrorLooking( o.selector, 'was not found' ),
    })
  }

  if( _.errIs( result ) )
  {
    return module.errThrow
    ({
      selector : o.selector,
      currentContext : o.currentContext,
      missingAction : o.missingAction,
      err : result,
    });
    // if( o.missingAction === 'undefine' )
    // return;
    // debugger;
    // let err = module.errResolving
    // ({
    //   selector : o.selector,
    //   currentContext : o.currentContext,
    //   err : result,
    // });
    // if( o.missingAction === 'throw' )
    // throw err;
    // else
    // return err;
  }

  result = mapsFlatten( result );
  result = mapValsUnwrap( result );
  result = singleUnwrap( result );
  result = arrayWrap( result );

  return result;

  /* */

  function singleUnwrap( result )
  {

    if( !o.singleUnwrapping )
    return result;

    if( _.any( result, ( e ) => _.mapIs( e ) || _.arrayIs( e ) ) )
    return result;

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

    return result;
  }

  //

  function mapsFlatten( result )
  {
    if( o.mapFlattening && _.mapIs( result ) )
    result = _.mapsFlatten([ result ]);
    return result;
  }

  //

  function mapValsUnwrap( result )
  {
    if( !o.mapValsUnwrapping )
    return result
    if( !_.mapIs( result ) )
    return result;
    if( !_.all( result, ( e ) => _.instanceIs( e ) || _.primitiveIs( e ) ) )
    return result;
    return _.mapVals( result );
  }

  //

  function arrayWrap( result )
  {
    if( !o.arrayWrapping )
    return result;
    if( !_.mapIs( result ) )
    return _.arrayAs( result );
    return result;
  }

}

resolve_body.defaults =
{
  selector : null,
  defaultResourceName : null,
  prefixlessAction : 'resolved',
  missingAction : 'throw',
  visited : null,
  currentThis : null,
  currentContext : null,
  criterion : null,
  module : null,
  pathResolving : 'in',
  pathNativizing : 0,
  pathUnwrapping : 1,
  singleUnwrapping : 1,
  mapValsUnwrapping : 1,
  mapFlattening : 1,
  arrayWrapping : 0,
  arrayFlattening : 1,
  preservingIteration : 0,
  strictCriterion : 0,
  hasPath : null,
  selectorIsPath : 0,
}

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );
let resolveMaybe = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = resolveMaybe.defaults;
defaults.missingAction = 'undefine';

//

let onSelectorComposite = _.select.functor.onSelectorComposite({ isStrippedSelector : 1 });
/* let onSelectorDown = _.select.functor.onSelectorDownComposite({}); */
function onSelectorDown()
{
  let it = this;

  if( it.continue && _.arrayIs( it.dst ) && it.src.rejoin === _.hold )
  {

    for( let d = 0 ; d < it.dst.length ; d++ )
    if( _.errIs( it.dst[ d ] ) )
    throw it.dst[ d ];

    it.dst = _.strJoin( it.dst );
    pathsNativize.call( it );
  }

  /* */

  function pathsNativize()
  {
    let it = this;
    let resource = it.dst;
    let rop = it.selectMultipleOptions.iteratorExtension.resolveOptions;

    if( !rop.selectorIsPath )
    return;
    if( !rop.pathNativizing )
    return;

    if( it.dst )
    it.dst = _.map( it.dst, ( resource ) =>
    {
      if( _.strIs( resource ) )
      return pathNativize.call( it, resource );
      if( resource instanceof will.PathResource )
      {
        resource = resource.cloneDerivative(); // !!! xxx : don't do second clone
        _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
        if( resource.path )
        resource.path = pathNativize.call( it, resource.path );
      }
      else debugger;
      return resource;
    });

  }

  /* */

  function pathNativize( filePath )
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    let rop = it.selectMultipleOptions.iteratorExtension.resolveOptions; debugger;
    let will = rop.module.will;
    let path = will.fileProvider.providersWithProtocolMap.file.path;
    let result = filePath;

    _.assert( _.strIs( result ) || _.strsAreAll( result ) );

    if( _.arrayIs( filePath ) )
    {
      return filePath.map( ( e ) => nativize( e ) );
    }
    else
    {
      return nativize( filePath );
    }

    function nativize( filePath )
    {
      if( path.isGlobal( filePath ) )
      return filePath
      else
      return path.nativize( filePath );
    }

  }

  /* */

}

function _resolveAct( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result;
  let currentContext = o.currentContext;

  if( o.module === null )
  o.module = module;
  if( o.criterion === null && o.currentContext && o.currentContext.criterion )
  o.criterion = o.currentContext.criterion;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _resolveAct, arguments );
  _.assert( o.module instanceof will.Module );
  _.assert( o.criterion === null || _.mapIs( o.criterion ) );
  _.assert( _.arrayIs( o.visited ) );

  /* */

  try
  {

    result = _.select
    ({
      src : module,
      selector : o.selector,
      preservingIteration : o.preservingIteration,
      onSelector : onSelector,
      onSelectorDown : onSelectorDown,
      onUpBegin : onUpBegin,
      onUpEnd : onUpEnd,
      onDownEnd : onDownEnd,
      onQuantitativeFail : onQuantitativeFail,
      missingAction : o.missingAction === 'undefine' ? 'undefine' : 'error',
      iteratorExtension :
      {
        resolveOptions : o,
      },
      iterationExtension :
      {
      },
      iterationPreserve :
      {
        currentModule : o.module,
        // module : o.module,
        exported : null,
        isFunction : null,
        selectorIsPath : 0,
      },
    });

  }
  catch( err )
  {
    debugger;
    throw module.errResolving
    ({
      selector : o.selector,
      currentContext : currentContext,
      err : err,
    });
  }

  return result;

  /* */

  function onSelector( selector )
  {
    let it = this;

    if( !_.strIs( selector ) )
    return;

    if( module.SelectorIsPrimitive( selector ) )
    {
      return onSelectorComposite.call( it, selector );
    }

    if( o.prefixlessAction === 'default' )
    {
      return selector;
    }
    else if( o.prefixlessAction === 'throw' || o.prefixlessAction === 'error' )
    {
      debugger;
      it.iterator.continue = false;
      let err = module.errResolving
      ({
        selector : selector,
        currentContext : currentContext,
        err : _.ErrorLooking( 'Resource selector should have prefix' ),
      });
      debugger;
      if( o.prefixlessAction === 'throw' )
      throw err;
      debugger;
      it.dst = err;
      return;
    }
    else if( o.prefixlessAction === 'resolved' )
    {
      return;
    }
    else _.assert( 0 );

  }

  /* */

  function onUpBegin()
  {
    let it = this;

    // if( _.strHas( it.path, '/Logger' ) )
    // debugger;

    statusPreUpdate.call( it );
    globCriterionFilter.call( it );

    if( !it.dstWritingDown )
    return;

    /*
    resourceMapSelect, statusPostUpdate should go after queryParse
    */

    queryParse.call( it );
    resourceMapSelect.call( it );
    statusPostUpdate.call( it );

  }

  /* */

  function onUpEnd()
  {
    let it = this;

    // if( _.strHas( it.path, '/Logger' ) )
    // debugger;

    exportedWriteThrough.call( it );
    currentExclude.call( it );

    if( it.dstWritingDown )
    compositePathsSelect.call( it );

    if( it.dstWritingDown )
    if( o.pathResolving || it.isFunction )
    pathsResolve.call( it );

    if( o.pathUnwrapping )
    pathsUnwrap.call( it );

  }

  /* */

  function onDownEnd()
  {
    let it = this;

    if( it.dstWritingDown )
    if( o.pathNativizing || it.isFunction )
    pathsNativize.call( it );

    functionStringsJoinDown.call( it );
    mapsFlatten.call( it );
    mapValsUnwrap.call( it );
    arrayFlatten.call( it );
    singleUnwrap.call( it );

  }

  /* */

  function onQuantitativeFail( err )
  {
    let it = this;

    debugger;

    let result = it.dst;
    if( _.mapIs( result ) )
    result = _.mapVals( result );
    if( _.arrayIs( result ) )
    {
      let isString = 1;
      if( result.every( ( e ) => _.strIs( e ) ) )
      isString = 1;
      else
      result = result.map( ( e ) =>
      {
        if( _.strIs( e ) )
        return e;
        if( _.strIs( e.nickName ) )
        return e.nickName;
        isString = 0
      });

      if( o.criterion )
      err = _.err( err, '\nCriterions :\n', _.toStr( o.criterion, { wrap : 0, levels : 4, multiline : 1, stringWrapper : '', multiline : 1 } ) );

      if( isString )
      if( result.length )
      err = _.err( err, '\n', 'Found : ' + result.join( ', ' ) );
      else
      err = _.err( err, '\n', 'Found nothing' );
    }

    throw err;
  }

  /* */

  function statusPreUpdate()
  {
    let it = this;

    if( !it.src )
    return;

    _.assert( !it.src.rejoin );

    if( it.src instanceof will.Module )
    {
      it.currentModule = it.src;
    }
    else if( it.src instanceof will.Submodule )
    {
      // debugger;
      // _.assert( !!it.src.openedModule, 'not tested' ); // yyy
      if( it.src.openedModule )
      /*it.module*/it.currentModule = it.src.openedModule;
    }
    else if( it.src instanceof will.Exported )
    {
      it.exported = it.src;
    }

  }

  /* */

  function statusPostUpdate()
  {
    let it = this;

    if( o.selectorIsPath )
    it.selectorIsPath = 1;

    if( it.parsedSelector )
    {
      let kind = it.parsedSelector.kind;

      if( kind === 'path' && o.hasPath === null )
      o.hasPath = true;

      if( kind === 'path' )
      it.selectorIsPath = 1;
    }

  }

  /* */

  function globCriterionFilter()
  {
    let it = this;

    if( it.down && it.down.isGlob )
    if(  o.criterion && it.src && it.src.criterionSattisfy )
    {

      let s = o.strictCriterion ? it.src.criterionSattisfyStrict( o.criterion ) : it.src.criterionSattisfy( o.criterion );

      if( !s )
      {
        it.continue = false;
        it.dstWritingDown = false;
      }

    }

  }

  /* */

  function queryParse()
  {
    let it = this;

    if( !it.selector )
    return;

    _.assert( !!/*it.module*/it.currentModule );
    let splits = /*it.module*/it.currentModule._selectorShortSplit
    ({
      selector : it.selector,
      defaultResourceName : o.defaultResourceName,
    });

    it.parsedSelector = Object.create( null );
    it.parsedSelector.kind = splits[ 0 ];

    if( !it.parsedSelector.kind )
    {
      if( splits[ 1 ] !== undefined )
      it.parsedSelector.kind = null;
    }

    it.parsedSelector.full = splits.join( '' );
    it.selector = it.parsedSelector.name = splits[ 2 ];

  }

  /* */

  function resourceMapSelect()
  {
    let it = this;
    let sop = it.selectOptions;

    if( !it.selector )
    return;

    let kind = it.parsedSelector.kind;

    if( kind === '' )
    {
    }
    else if( kind === 'f' )
    {

      if( it.selector === 'strings.join' )
      {
        functionStringsJoinUp.call( it );
      }
      else if( it.selector === 'os' )
      {
        functionOsGetUp.call( it );
      }
      else if( it.selector === 'this' )
      {
        functionThisUp.call( it );
      }
      else _.sure( 0, 'Unknown function', it.parsedSelector.full );

    }
    else
    {

      it.src = /*it.module*/it.currentModule.resourceMapsForKind( kind );
      // it.src = /*it.module*/it.currentModule.resourceMaps();

      if( _.strIs( kind ) && _.path.isGlob( kind ) )
      {
        sop.selectorArray.splice( it.logicalLevel-1, 1, '*', it.selector );
        it.selector = sop.selectorArray[ it.logicalLevel-1 ];
        sop.selectorChanged.call( it );
      }

      if( !it.src )
      {
        debugger;
        throw _.ErrorLooking( 'No resource map', _.strQuote( it.parsedSelector.full ) );
      }

    }

    it.srcChanged();
  }

  /* */

  function exportedWriteThrough()
  {
    let it = this;

    if( it.down && it.parsedSelector && it.parsedSelector.kind === 'exported' )
    {
      let dstWriteDownOriginal = it.dstWriteDown;
      it.dstWriteDown = function writeThrough( eit )
      {
        let r = dstWriteDownOriginal.apply( this, arguments );
        return r;
      }
    }

  }

  /* */

  function functionStringsJoinUp()
  {
    let it = this;
    let sop = it.selectOptions;

    _.sure( !!it.down, () => it.parsedSelector.full + ' expects context to join it' );

    it.src = [ it.src ];
    it.src[ functionSymbol ] = it.selector;
    // it.dst = [ it.dst ];
    // it.dst[ functionSymbol ] = it.selector;

    it.selector = 0;
    it.isFunction = it.selector;
    sop.selectorChanged.call( it );

  }

  /* */

  function functionStringsJoinDown()
  {
    let it = this;
    let sop = it.selectOptions;

    if( !_.arrayIs( it.src ) || !it.src[ functionSymbol ] )
    return;

    debugger;
    if( _.arrayIs( it.dst ) && it.dst.every( ( e ) => _.arrayIs( e ) ) )
    {
      it.dst = it.dst.map( ( e ) => e.join( ' ' ) );
    }
    else
    {
      it.dst = it.dst.join( ' ' );
    }

  }

  /* */

  function functionOsGetUp()
  {
    let it = this;
    let sop = it.selectOptions;
    let Os = require( 'os' );
    let os = 'posix';

    debugger;

    if( Os.platform() === 'win32' )
    os = 'windows';
    else if( Os.platform() === 'darwin' )
    os = 'osx';

    it.src = os;
    it.dst = os;
    it.selector = undefined;
    sop.selectorChanged.call( it );

  }

  /* */

  function functionThisUp()
  {
    let it = this;
    let sop = it.selectOptions;

    it.src = [ o.currentThis ];
    it.selector = 0;

    sop.selectorChanged.call( it );

  }

  /* */

  function currentExclude()
  {
    let it = this;
    if( it.src === o.currentContext && it.down )
    it.dstWritingDown = false;
  }

  /* */

  function compositePathSelect( currentModule, currentResource, filePath, resolving )
  {
    let result = filePath;

    _.assert( _.strIs( result ) || _.strsAreAll( result ) );
    _.assert( arguments.length === 4 );

    if( currentModule.SelectorIsComposite( result ) )
    {

      result = currentModule.pathResolve
      ({
        selector : result,
        visited : _.arrayFlatten( null, [ o.visited, result ] ),
        pathResolving : o.pathResolving || resolving,
        currentContext : currentResource,
        pathNativizing : o.pathNativizing,
        // pathResolving : o.pathResolving,
      });

    }

    return result;
  }

  /* */

  function compositePathsSelect()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    let resource = it.dst;

    if( resource instanceof will.Reflector )
    {
      if( currentModule.SelectorIsComposite( resource.src.prefixPath ) || currentModule.SelectorIsComposite( resource.dst.prefixPath ) )
      {
        resource = it.dst = resource.cloneDerivative();
        if( resource.src.prefixPath )
        resource.src.prefixPath = compositePathSelect( currentModule, resource, resource.src.prefixPath, 'in' );
        if( resource.dst.prefixPath )
        resource.dst.prefixPath = compositePathSelect( currentModule, resource, resource.dst.prefixPath, 'in' );
      }
    }

    if( resource instanceof will.PathResource )
    {
      if( currentModule.SelectorIsComposite( resource.path ) )
      {
        resource = it.dst = resource.cloneDerivative();
        resource.path = compositePathSelect( currentModule, resource, resource.path, 0 )
      }
    }

  }

  /* */

  function pathResolve( filePath, resourceName )
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    let result = filePath;

    if( _.arrayIs( filePath ) )
    filePath = _.arrayFlattenOnce( filePath );

    if( _.errIs( filePath ) )
    {
      if( o.missingAction === 'error' )
      return filePath;
      else
      throw filePath;
    }
    else if( _.arrayIs( filePath ) )
    for( let f = 0 ; f < filePath.length ; f++ )
    if( _.errIs( filePath[ f ] ) )
    {
      if( o.missingAction === 'error' )
      return filePath[ f ];
      else
      throw filePath[ f ];
    }

    _.assert( _.strIs( filePath ) || _.strsAreAll( filePath ) );

    // if( _.arrayIs( filePath ) )
    // debugger;

    if( it.replicateIteration.composite )
    if( it.replicateIteration.compositeRoot !== it.replicateIteration )
    if( it.replicateIteration.compositeRoot === it.replicateIteration.down )
    {
      if( it.replicateIteration.key !== 0 )
      return result;
    }

    let prefixPath = '.';
    if( o.pathResolving === 'in' && resourceName !== 'in' )
    prefixPath = currentModule.inPath || '.';
    else if( o.pathResolving === 'out' && resourceName !== 'out' )
    prefixPath = currentModule.outPath || '.';

    if( currentModule.SelectorIs( prefixPath ) )
    prefixPath = currentModule.pathResolve({ selector : prefixPath, currentContext : it.dst });
    if( currentModule.SelectorIs( result ) )
    result = currentModule.pathResolve({ selector : result, currentContext : it.dst });

    result = path.s.join( currentModule.dirPath, prefixPath, result );

    return result;
  }

  /* */

  function pathsResolve()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    let resource = it.dst;

    if( it.dst instanceof will.Reflector )
    {

      resource = it.dst = it.dst.cloneDerivative();

      _.assert( resource.formed >= 1 );

      let srcHasAnyPath = resource.src.hasAnyPath();
      let dstHasAnyPath = resource.dst.hasAnyPath();

      if( srcHasAnyPath || dstHasAnyPath )
      {
        if( srcHasAnyPath )
        resource.src.prefixPath = pathResolve.call( it, resource.src.prefixPath || '.' );
        if( dstHasAnyPath )
        resource.dst.prefixPath = pathResolve.call( it, resource.dst.prefixPath || '.' );
      }

    }

    if( it.dst instanceof will.PathResource )
    {
      resource = it.dst = resource.cloneDerivative();
      _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
      if( resource.path )
      resource.path = pathResolve.call( it, resource.path, resource.name )
    }

  }

  /* */

  function pathNativize( filePath )
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    let result = filePath;

    _.assert( _.strIs( filePath ) || _.strsAreAll( filePath ) );

    result = will.fileProvider.providersWithProtocolMap.file.path.s.nativize( result );

    return result;
  }

  /* */

  function pathsNativize()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    let resource = it.dst;

    if( it.selectorIsPath )
    {
      if( it.down && it.down.selectorIsPath )
      return;
      if( it.dst )
      it.dst = _.map( it.dst, ( resource ) =>
      {
        if( _.strIs( resource ) )
        return pathNativize.call( it, resource );
        if( resource instanceof will.PathResource )
        {
          resource = resource.cloneDerivative(); // xxx : don't do second clone
          _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
          if( resource.path )
          resource.path = pathNativize.call( it, resource.path );
        }
        else debugger;
        return resource;
      });
      return;
    }

  }

  /* */

  function pathsUnwrap()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;

    if( it.dst instanceof will.PathResource )
    it.dst = it.dst.path;

    return result;
  }

  /* */

  function singleUnwrap()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;

    if( !o.singleUnwrapping )
    return;

    if( _.any( it.dst, ( e ) => _.mapIs( e ) || _.arrayIs( e ) ) )
    return;

    if( _.mapIs( it.dst ) )
    {
      if( _.mapKeys( it.dst ).length === 1 )
      it.dst = _.mapVals( it.dst )[ 0 ];
    }
    else if( _.arrayIs( it.dst ) )
    {
      if( it.dst.length === 1 )
      it.dst = it.dst[ 0 ];
    }

  }

  /* */

  function arrayFlatten()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;

    if( !o.arrayFlattening || !_.arrayIs( it.dst ) )
    return;

    it.dst = _.arrayFlattenDefined( it.dst );

  }

  /* */

  function mapsFlatten()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;
    if( !o.mapFlattening || !_.mapIs( it.dst ) )
    return;

    it.dst = _.mapsFlatten([ it.dst ]);
  }

  /* */

  function mapValsUnwrap()
  {
    let it = this;
    let currentModule = /*it.module*/it.currentModule;

    if( !o.mapValsUnwrapping )
    return;
    if( !_.mapIs( it.dst ) )
    return;
    if( !_.all( it.dst, ( e ) => _.instanceIs( e ) || _.primitiveIs( e ) ) )
    return;

    it.dst = _.mapVals( it.dst );
  }

}

var defaults = _resolveAct.defaults = Object.create( resolve.defaults )

defaults.visited = null;

//

let pathResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = pathResolve.defaults;
defaults.pathResolving = 'in';
defaults.prefixlessAction = 'resolved';
defaults.selectorIsPath = 1;

//

let resolveRaw = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = resolveRaw.defaults;
defaults.pathResolving = 0;
defaults.pathNativizing = 0;
defaults.pathUnwrapping = 0;
defaults.singleUnwrapping = 0;
defaults.mapValsUnwrapping = 0;
defaults.mapFlattening = 0;
defaults.arrayWrapping = 0;
defaults.arrayFlattening = 0;
// defaults.missingAction = 'undefine';

//

function reflectorResolve_body( o )
{
  let module = this;
  let will = module.will;

  let o2 = _.mapExtend( null, o );
  o2.pathResolving = 0; //
  let reflector = module.resolve( o2 );

  if( o.missingAction === 'undefine' && reflector === undefined )
  return reflector;
  else if( o.missingAction === 'error' && _.errIs( reflector ) )
  return reflector;

  if( reflector instanceof will.Reflector )
  {
    _.sure( reflector instanceof will.Reflector, () => 'Reflector ' + o.selector + ' was not found' + _.strType( reflector ) );
    reflector.form();
    _.assert( reflector.formed === 3, () => reflector.nickName + ' is not formed' );
  }

  return reflector;
}

var defaults = reflectorResolve_body.defaults = Object.create( resolve.defaults );
defaults.selector = null;
defaults.defaultResourceName = 'reflector';
defaults.prefixlessAction = 'default';
defaults.currentContext = null;
defaults.pathResolving = 'in';

let reflectorResolve = _.routineFromPreAndBody( resolve_pre, reflectorResolve_body );

//

function submodulesResolve_body( o )
{
  let module = this;
  let will = module.will;

  let result = module.resolve( o );

  return result;
}

var defaults = submodulesResolve_body.defaults = Object.create( resolve.defaults );
defaults.selector = null;
defaults.prefixlessAction = 'default';
defaults.defaultResourceName = 'submodule';

let submodulesResolve = _.routineFromPreAndBody( resolve.pre, submodulesResolve_body );

// --
// other resolver
// --

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
  let elements = module.buildMap;

  _.assertRoutineOptions( _buildsSelect_body, arguments );
  _.assert( arguments.length === 1 );

  if( o.name )
  {
    elements = _.mapVals( _.path.globFilterKeys( elements, o.name ) );
    if( !elements.length )
    return []
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

    elements = filterWith( elements, o.criterion );

  }
  else if( _.objectIs( o.criterion ) && Object.keys( o.criterion ).length === 0 && !o.name && o.preffering === 'default' )
  {

    elements = filterWith( elements, { default : 1 } );

  }

  if( o.resource === 'export' )
  elements = elements.filter( ( element ) => element.criterion && element.criterion.export );
  else if( o.resource === 'build' )
  elements = elements.filter( ( element ) => !element.criterion || !element.criterion.export );

  return elements;

  /* */

  function filterWith( elements, filter )
  {

    _.assert( _.objectIs( filter ), 'not tested' );

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

let _buildsResolve = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );

//

let buildsResolve = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = buildsResolve.defaults;
defaults.resource = 'build';

//

let exportsResolve = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = exportsResolve.defaults;
defaults.resource = 'export';

//

function willfilesResolve()
{
  let module = this;
  let will = module.will;
  _.assert( arguments.length === 0 );

  let result = module.willfilesArray.slice();

  for( let m in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ m ].openedModule;
    if( !submodule )
    continue;
    _.arrayAppendArrayOnce( result, submodule.willfilesResolve() );
  }

  return result;
}

// --
// exporter
// --

function infoExport()
{
  let module = this;
  let will = module.will;
  let result = '';

  result += module.about.infoExport();

  result += module.infoExportPaths( module.pathMap );
  result += module.infoExportResource( module.submoduleMap );
  result += module.infoExportResource( module.reflectorMap );
  result += module.infoExportResource( module.stepMap );
  result += module.infoExportResource( module.buildsResolve({ preffering : 'more' }) );
  result += module.infoExportResource( module.exportsResolve({ preffering : 'more' }) );
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

  let result = _.color.strFormat( 'Paths', 'highlighted' );

  result += '\n' + _.toStr( paths, { wrap : 0, multiline : 1, levels : 2 } ) + '';

  result += '\n\n';

  return result;
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
    result += resource.infoExport();
    result += '\n\n';
  });

  return result;
}

//

function dataExport( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  o.dst = o.dst || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( dataExport, arguments );

  o.module = module;

  let o2 = _.mapExtend( null, o );
  delete o2.dst;

  o.dst.about = module.about.dataExport();

  o.dst.path = module.dataExportResources( module.pathResourceMap, o2 );
  o.dst.submodule = module.dataExportResources( module.submoduleMap, o2 );
  o.dst.reflector = module.dataExportResources( module.reflectorMap, o2 );
  o.dst.step = module.dataExportResources( module.stepMap, o2 );
  o.dst.build = module.dataExportResources( module.buildMap, o2 );
  o.dst.exported = module.dataExportResources( module.exportedMap, o2 );

  if( module.moduleWithPathMap )
  o.dst.module = module.dataExportModules( module.moduleWithPathMap, o2 );

  return o.dst;
}

dataExport.defaults =
{
  dst : null,
  compact : 1,
  formed : 0,
  copyingAggregates : 0,
  copyingNonExportable : 0,
  copyingNonWritable : 1,
  copyingPredefined : 1,
  module : null,
}

//

function dataExportForModuleExport( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( dataExportForModuleExport, arguments );
  _.assert( module.original === null );

  // debugger;
  let module2 = module.cloneExtending({ willfilesPath : o.willfilesPath, original : module });
  _.assert( module2.dirPath === module.outPath );
  module2.original = module;
  _.assert( module2.dirPath === module.outPath );

  let inPathResource = module2.resourceObtain( 'path', 'in' );
  let outPathResource = module2.resourceObtain( 'path', 'out' );

  inPathResource.path = path.relative( module.outPath, module.inPath );
  _.assert( module2.pathResourceMap[ inPathResource.name ] === inPathResource );

  module2.stager.stageStateSkipping( 'willfilesFound', 1 );
  module2.stager.stageStateSkipping( 'willfilesOpened', 1 );
  module2.stager.stageStatePausing( 'willfilesFound', 0 );
  module2.stager.tick();
  _.assert( !!module2.ready.resourcesCount() );
  // debugger;

  let data = Object.create( null );
  data.format = will.WillFile.FormatVersion;
  module2.dataExport({ dst : data });

  _.assert( !data.path || !!data.path[ 'module.willfiles' ] );
  _.assert( !data.path || !!data.path[ 'module.dir' ] );
  // _.assert( !data.path || !data.path[ 'local' ] );
  _.assert( !data.path || data.path[ 'remote' ] !== undefined );
  _.assert( !data.path || !data.path[ 'current.remote' ] );
  _.assert( !data.path || !data.path[ 'will' ] );

  module2.finit();

  return data;
}

dataExportForModuleExport.defaults =
{
  willfilesPath : null,
}

//

function dataExportResources( resources, options )
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( _.mapIs( resources ) || _.arrayIs( resources ) );

  _.each( resources, ( resource, r ) =>
  {
    result[ r ] = resource.dataExport( options );
    if( result[ r ] === undefined )
    delete result[ r ];
  });

  return result;
}

//

function dataExportModules( modules, options )
{
  let module = this;
  let rootModule = module.rootModule;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( _.mapIs( modules ) );

  _.each( modules, ( module, absolute ) =>
  {
    let relative = absolute;
    if( !path.isGlobal( relative ) )
    relative = path.relative( module.dirPath, relative );

    if( result[ relative ] )
    {
      debugger;
    }
    else if( absolute === rootModule.commonPath )
    {
      result[ relative ] = 'root';
    }
    else
    {
      result[ relative ] = module.dataExport( options );
    }

    if( result[ relative ] === undefined )
    delete result[ relative ];
  });

  return result;
}

//

function resourceImport( o )
{
  let module = this;
  let will = module.will;

  _.assert( _.mapIs( o ) );
  _.assert( arguments.length === 1 );
  _.assert( o.srcResource instanceof will.Resource );
  _.routineOptions( resourceImport, arguments );

  let srcModule = o.srcResource.module;

  _.assert( module instanceof will.Module );
  _.assert( srcModule === null || srcModule instanceof will.Module );

  let resourceData = o.srcResource.dataExport();

  if( _.mapIs( resourceData ) )
  for( let k in resourceData )
  {
    let value = resourceData[ k ];

    if( _.strIs( value ) && srcModule )
    value = srcModule.resolveMaybe
    ({
      selector : value,
      prefixlessAction : 'resolved',
      pathUnwrapping : 0,
      pathResolving : 0,
    });

    if( _.instanceIsStandard( value ) )
    {
      let o2 = _.mapExtend( null, o );
      o2.srcResource = value;
      let subresource = module.resourceImport( o2 );
      value = subresource.nickName;
    }

    resourceData[ k ] = value;
  }

  if( o.overriding )
  {
    let oldResource = module.resolveRaw
    ({
      selector : o.srcResource.KindName + '::' + o.srcResource.name,
      missingAction : 'undefine',
    });
    if( oldResource )
    {
      resourceData.writable = oldResource.writable;
      resourceData.exportable = oldResource.exportable;
      resourceData.importable = oldResource.importable;
      oldResource.finit();
    }
  }

  _.assert( _.objectIs( resourceData ) );
  resourceData.module = module;
  resourceData.name = module.resourceNameAllocate( o.srcResource.KindName, o.srcResource.name );

  let resource = new o.srcResource.Self( resourceData );
  resource.form1();
  _.assert( module.resolve({ selector : resource.nickName, pathUnwrapping : 0, pathResolving : 0 }).absoluteName === resource.absoluteName );

  return resource;
}

resourceImport.defaults =
{
  srcResource : null,
  overriding : 1,
}

//

function ResourceSetter_functor( op )
{
  _.routineOptions( ResourceSetter_functor, arguments );

  let resourceName = op.resourceName;
  let mapName = op.mapName;
  let mapSymbol = Symbol.for( mapName );

  return function resourceSet( resourceMap2 )
  {
    let module = this;
    let resourceMap = module[ mapSymbol ] = module[ mapSymbol ] || Object.create( null );

    // if( mapName === 'pathResourceMap' )
    // debugger;

    _.assert( arguments.length === 1 );
    _.assert( _.mapIs( resourceMap ) );
    _.assert( _.mapIs( resourceMap2 ) );

    for( let m in resourceMap )
    {
      let resource = resourceMap[ m ];
      _.assert( _.instanceIs( resource ) );
      _.assert( resource.module === module );
      resource.finit();
    }

    _.assert( _.mapKeys( resourceMap ).length === 0 );

    if( resourceMap2 === null )
    return resourceMap;

    for( let m in resourceMap2 )
    {
      let resource = resourceMap2[ m ];

      _.assert( module.preformed === 0 );
      _.assert( _.instanceIs( resource ) );
      _.assert( resource.module !== module );

      if( resource.module !== null )
      resource = resource.clone();
      _.assert( resource.module === null );
      resource.module = module;
      resource.form1();
      _.assert( !_.instanceIsFinited( resource ) );
    }

    // if( mapName === 'pathResourceMap' )
    // debugger;

    return resourceMap;
  }

}

ResourceSetter_functor.defaults =
{
  resourceName : null,
  mapName : null,
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

  willfilesPath : null,
  pickedWillfilesPath : null,
  localPath : null,
  remotePath : null,

  configName : null,

  isRemote : null,
  isDownloaded : null,
  isUpToDate : null,

  verbosity : 0,
  aliasName : null,

}

let Aggregates =
{

  about : _.define.instanceOf( _.Will.ParagraphAbout ),
  submoduleMap : _.define.own({}),
  pathResourceMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportedMap : _.define.own({}),

}

let Associates =
{
  will : null,
  supermodule : null,
  submoduleAssociation : _.define.own([]),
  original : null,
  pickedWillfileData : null,
}

let Restricts =
{

  id : null,
  stager : null,
  willfilesReadBeginTime : null,
  willfilesReadTimeReported : 0,

  willfilesArray : _.define.own([]),
  willfileWithRoleMap : _.define.own({}),
  pathMap : _.define.own({}),
  moduleWithPathMap : null,
  moduleWithNameMap : null,
  allSubmodulesMap : null,

  preformed : 0,
  willfilesFound : 0,
  willfilesOpened : 0,
  submodulesFormed : 0,
  resourcesFormed : 0,
  formed : 0,

  preformReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'preformReady' }) ),
  willfilesFindReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'willfilesFindReady' }) ),
  willfilesOpenReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'willfilesOpenReady' }) ),
  submodulesFormReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'submodulesFormReady' }) ),
  resourcesFormReady : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'resourcesFormReady' }) ),
  ready : _.define.own( _.Consequence({ resourceLimit : 1, tag : 'ready' }) ),

}

let Statics =
{

  SelectorIsPrimitive,
  SelectorIs,
  SelectorIsComposite,

  ResourceSetter_functor,
  WillfilePathIs,
  DirPathFromFilePaths,
  CommonPathFor,
  // Counter : 0,

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
}

let Accessors =
{

  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Will.ParagraphAbout }) },

  submoduleMap : { setter : ResourceSetter_functor({ resourceName : 'Submodule', mapName : 'submoduleMap' }) },
  pathResourceMap : { setter : ResourceSetter_functor({ resourceName : 'PathResource', mapName : 'pathResourceMap' }) },
  reflectorMap : { setter : ResourceSetter_functor({ resourceName : 'Reflector', mapName : 'reflectorMap' }) },
  stepMap : { setter : ResourceSetter_functor({ resourceName : 'Step', mapName : 'stepMap' }) },
  buildMap : { setter : ResourceSetter_functor({ resourceName : 'Build', mapName : 'buildMap' }) },
  exportedMap : { setter : ResourceSetter_functor({ resourceName : 'Exported', mapName : 'exportedMap' }) },

  aliasName : { setter : aliasNameSet },
  name : { getter : nameGet, readOnly : 1 },
  nickName : { getter : nickNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedNickName : { getter : decoratedNickNameGet, combining : 'rewrite', readOnly : 1 },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },
  rootModule : { getter : rootModuleGet, readOnly : 1 },

  inPath : { getter : inPathGet, readOnly : 1 },
  outPath : { getter : outPathGet, readOnly : 1 },
  commonPath : { getter : commonPathGet, readOnly : 1 },

  willfilesPath : { getter : willfilesPathGet, setter : willfilesPathSet },
  dirPath : { getter : dirPathGet, readOnly : 1 },
  localPath : { getter : localPathGet, setter : localPathSet },
  remotePath : { getter : remotePathGet, setter : remotePathSet },
  currentRemotePath : { getter : currentRemotePathGet, readOnly : 1 },
  willPath : { getter : willPathGet, readOnly : 1 },

  isDownloaded : { setter : remoteIsDownloadedSet },

}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,
  copy,
  clone,
  unform,
  preform,
  _preform,
  predefinedForm,

  // etc

  shell,

  // opener

  isOpened,
  isValid,
  close,
  _openEnd,

  _willfileFindSingle,
  _willfileFindMultiple,
  _willfilesFindMaybe,
  _willfilesFindPickedFile,
  _willfilesFind,
  willfilesFind,
  willfilesPick,

  willfilesOpen,
  _willfilesOpen,

  willfilesReadBegin,
  willfilesReadEnd,

  _willfilesExport,
  willfileEach,

  // submodule

  rootModuleGet,
  moduleAt,
  moduleRegister,
  moduleUnregister,

  submoduleRegister,

  submodulesAllAreDownloaded,
  submodulesAllAreValid,
  submodulesClean,
  submodulesReload,
  // submoduleNameAllocate,

  _submodulesDownload,
  submodulesDownload,
  submodulesUpdate,

  submodulesFixate,
  moduleFixate,
  moduleFixatePath,

  submodulesForm,
  _submodulesForm,

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

  // resource

  resourcesForm,
  _resourcesForm,
  _resourcesFormAct,
  _resourcesAllForm,

  resourceClassForKind,
  resourceMapForKind,
  resourceMapsForKind,
  resourceMaps,
  resourceObtain,
  resourceAllocate,
  resourceNameAllocate,

  // path

  WillfilePathIs,
  DirPathFromFilePaths,
  prefixPathForRole,
  prefixPathForRoleMaybe,
  cloneDirGet,

  _filePathChange,
  _filePathChanged,
  inPathGet,
  outPathGet,
  commonPathGet,
  CommonPathFor,

  willfilesPathGet,
  dirPathGet,
  localPathGet,
  remotePathGet,
  currentRemotePathGet,
  willPathGet,

  willfilesPathSet,
  _dirPathChange,
  localPathSet,
  remotePathSet,

  // name

  nameGet,
  nameChanged,
  aliasNameSet,
  nickNameGet,
  decoratedNickNameGet,
  absoluteNameGet,
  decoratedAbsoluteNameGet,
  shortNameArrayGet,

  // clean

  cleanWhat,
  cleanWhatReport,
  clean,

  // resolver

  _selectorShortSplitAct,
  _selectorShortSplit,
  selectorLongSplit,
  selectorParse,
  SelectorIsPrimitive,
  SelectorIs,
  SelectorIsComposite,

  errResolving,
  errThrow,
  resolveContextPrepare,
  resolve,
  resolveMaybe,
  _resolveAct,

  resolveRaw,
  pathResolve,
  reflectorResolve,
  submodulesResolve,

  // other resolver

  _buildsResolve,
  buildsResolve,
  exportsResolve,
  willfilesResolve,

  // exporter

  infoExport,
  infoExportPaths,
  infoExportResource,

  dataExport,
  dataExportForModuleExport,
  dataExportResources,
  dataExportModules,

  resourceImport,

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
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
