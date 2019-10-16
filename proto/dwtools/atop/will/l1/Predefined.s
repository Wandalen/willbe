( function _Predefined_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let Tar, Open;
let _ = wTools;
let Self = Object.create( null );

// --
// routines
// --

// let filesReflect = _.routineFromPreAndBody( _.FileProvider.Find.prototype.filesReflect.pre, _.FileProvider.Find.prototype.filesReflect.body );
let filesReflect = _.routineExtend( null, _.FileProvider.Find.prototype.filesReflect );

let defaults = filesReflect.defaults;

defaults.linking = 'hardLinkMaybe';
defaults.mandatory = 1;
defaults.dstRewritingOnlyPreserving = 1;

//

function stepRoutineDelete( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let time = _.timeNow();
  let verbosity = step.verbosityWithDelta( -1 );

  beginLog();

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  let filePath = step.inPathResolve( opts.filePath );

  let o2 =
  {
    filePath : filePath,
    verbosity : 0,
  }

  if( filePath instanceof will.Reflector )
  {
    delete o2.filePath;
    let o3 = filePath.optionsForFindExport();
    _.mapExtend( o2, o3 );
  }

  let result = fileProvider.filesDelete( o2 );

  endLog();

  return result;

  /* */

  function beginLog()
  {

    if( verbosity < 3 )
    return;

    logger.log( ' : ' + step.decoratedQualifiedName );

  }

  /* */

  function endLog()
  {

    if( !verbosity )
    return;

    let spentTime = _.timeNow() - time;
    let groupsMap = path.group({ keys : o2.filter.filePath, vals : o2.result });
    let textualReport = path.groupTextualReport
    ({
      explanation : ' - ' + step.decoratedQualifiedName + ' deleted ',
      groupsMap : groupsMap,
      verbosity : verbosity,
      spentTime : spentTime,
    });

    if( textualReport )
    logger.log( textualReport );

  }

}

stepRoutineDelete.stepOptions =
{
  filePath : null,
}

//

function stepRoutineReflect( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let time = _.timeNow();
  let verbosity = step.verbosityWithDelta( -1 );

  _.assert( !!opts.reflector, 'Expects option reflector' );
  _.assert( arguments.length === 1 );

  let reflector = step.reflectorResolve( opts.reflector );

  _.sure( reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', _.strType( reflector ) )
  _.assert( reflector.formed === 3, () => reflector.qualifiedName + ' is not formed' );

  beginLog();

  delete opts.reflector ;

  let reflectorOptions = reflector.optionsForReflectExport();

  _.mapSupplement( opts, reflectorOptions );

  opts.verbosity = 0;

  return _.Consequence.Try( () =>
  {
    // debugger;
    return will.Predefined.filesReflect.call( fileProvider, opts );
  })
  .then( ( result ) =>
  {
    endLog();
    return result;
  })
  .catch( ( err ) =>
  {
    debugger;
    err = _.err( err, '\n\n', _.strIndentation( reflector.infoExport(), '  ' ), '\n' );
    throw _.err( err );
    // throw _.errBrief( err );
  })

  /* */

  function beginLog()
  {
    if( verbosity < 3 )
    return;

    logger.log( ' : ' + reflector.decoratedQualifiedName + '' );
  }

  /* */

  function endLog()
  {
    if( verbosity < 1 )
    return;

    _.assert( opts.src.isPaired() );
    let mtr = opts.src.moveTextualReport();
    logger.log( ' + ' + reflector.decoratedQualifiedName + ' reflected ' + opts.result.length + ' file(s) ' + mtr + ' in ' + _.timeSpent( time ) );

  }

  /* */

}

stepRoutineReflect.stepOptions =
{
  reflector : null,
  verbosity : null,
}

//

function stepRoutineTimelapseBegin( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );

  _.assert( arguments.length === 1 );

  /* */

  logger.log( 'Timelapse begin' );
  // fileProvider.providersWithProtocolMap.hd.archive.timelapseBegin();

  return null;
}

stepRoutineTimelapseBegin.stepOptions =
{
}

//

function stepRoutineTimelapseEnd( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );

  _.assert( arguments.length === 1 );

  /* */

  logger.log( 'Timelapse end' );
  // fileProvider.providersWithProtocolMap.hd.archive.timelapseEnd();

  return null;
}

stepRoutineTimelapseEnd.stepOptions =
{
}

//

function stepRoutineJs( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );

  _.assert( arguments.length === 1 );

  _.sure( opts.js === null || _.strIs( opts.js ) );

  /* */

  try
  {
    opts.js = step.inPathResolve({ selector : opts.js, prefixlessAction : 'resolved' });
    opts.routine = require( fileProvider.providersWithProtocolMap.hd.path.nativize( opts.js ) );
    if( !_.routineIs( opts.routine ) )
    throw _.err( 'JS file should return function, but got', _.strType( opts.routine ) );
  }
  catch( err )
  {
    debugger;
    throw _.err( err, '\nFailed to open JS file', _.strQuote( opts.js ) );
  }

  /* */

  try
  {
    let result = opts.routine( frame );
    return result || null;
  }
  catch( err )
  {
    throw _.err( err, '\nFailed to execute JS file', _.strQuote( opts.js ) );
  }

}

stepRoutineJs.stepOptions =
{
  js : null,
}

stepRoutineJs.uniqueOptions =
{
  js : null,
}

//

function stepRoutineShell( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let forEachDstReflector, forEachDst;
  let verbosity = step.verbosityWithDelta( -1 );

  beginLog();

  _.assert( arguments.length === 1 );
  _.sure( opts.shell === null || _.strIs( opts.shell ) || _.arrayIs( opts.shell ) );
  _.sure( _.arrayHas( [ 'preserve', 'rebuild' ], opts.upToDate ), () => 'Unknown value of upToDate ' + _.strQuote( opts.upToDate ) );

  if( opts.forEachDst )
  forEachDst = forEachDstReflector = step.reflectorResolve( opts.forEachDst );

  /* */

  if( opts.upToDate === 'preserve' && forEachDstReflector )
  {

    _.assert( forEachDstReflector instanceof will.Reflector );
    forEachDst = will.Resolver.resolveContextPrepare({ currentThis : forEachDstReflector, baseModule : module });

    for( let dst in forEachDst.filesGrouped )
    {
      let src = forEachDst.filesGrouped[ dst ];
      let upToDate = fileProvider.filesAreUpToDate2({ dst : dst, src : src });
      if( upToDate )
      delete forEachDst.filesGrouped[ dst ];
    }

    forEachDst.src = [];
    forEachDst.dst = [];
    for( let dst in forEachDst.filesGrouped )
    {
      forEachDst.dst.push( hardDrive.path.nativize( dst ) );
      forEachDst.src.push( hardDrive.path.s.nativize( forEachDst.filesGrouped[ dst ] ).join( ' ' ) );
      // forEachDst.src.push( hardDrive.path.s.nativize( forEachDst.filesGrouped[ dst ] ) );
    }

  }

  return module.shell
  ({
    execPath : opts.shell,
    currentPath : opts.currentPath,
    currentThis : forEachDst,
    currentContext : step,
    verbosity : verbosity,
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.errBrief( 'Failed to shell', step.qualifiedName, '\n', err );
    return arg;
  });

  /* */

  function beginLog()
  {
  }

}

stepRoutineShell.stepOptions =
{
  shell : null,
  currentPath : null,
  forEachDst : null,
  upToDate : 'preserve',
}

stepRoutineShell.uniqueOptions =
{
  shell : null,
}

//

function stepRoutineTranspile( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let verbosity = step.verbosityWithDelta( -1 );

  _.sure( _.arrayHas( [ 'preserve', 'rebuild' ], opts.upToDate ), () => 'Unknown value of upToDate ' + _.strQuote( opts.upToDate ) );
  _.assert( arguments.length === 1 );

  if( opts.entry )
  opts.entry = step.inPathResolve( opts.entry );
  if( opts[ 'external.before' ] )
  opts[ 'external.before' ] = step.inPathResolve( opts[ 'external.before' ] );
  if( opts[ 'external.after' ] )
  opts[ 'external.after' ] = step.inPathResolve( opts[ 'external.after' ] );

  let reflector = step.reflectorResolve( opts.reflector );
  let reflectOptions = reflector.optionsForReflectExport();

  _.include( 'wTranspilationStrategy' );

  let debug = false;
  if( _.strIs( frame.resource.criterion.debug ) )
  debug = frame.resource.criterion.debug === 'debug';
  else if( frame.resource.criterion.debug !== undefined )
  debug = !!frame.resource.criterion.debug;

  let raw = false;
  if( _.strIs( frame.resource.criterion.raw ) )
  raw = frame.resource.criterion.raw === 'raw';
  else if( frame.resource.criterion.raw !== undefined )
  raw = !!frame.resource.criterion.raw;

  let transpilingStrategy = [ 'Uglify' ];
  if( debug )
  transpilingStrategy = [ 'Nop' ];

  // debugger;
  let ts = new _.TranspilationStrategy({ logger : logger }).form();
  let multiple = ts.multiple
  ({

    inPath : reflectOptions.src,
    outPath : reflectOptions.dst,
    entryPath : opts.entry,
    externalBeforePath : opts[ 'external.before' ],
    externalAfterPath : opts[ 'external.after' ],
    // totalReporting : 0,
    transpilingStrategy : transpilingStrategy,
    splittingStrategy : raw ? 'OneToOne' : 'ManyToOne',
    writingTerminalUnderDirectory : 1,
    simpleConcatenator : 0,
    upToDate : opts.upToDate,
    verbosity : verbosity,
    // verbosity : 1,

    optimization : 9,
    minification : 8,
    diagnosing : 1,
    beautifing : 0,

  });

  return multiple.form().perform()
  .finally( ( err, arg ) =>
  {
    debugger;
    if( err )
    throw _.err( err );
    // throw _.errLogOnce( err );
    return arg;
  });

}

stepRoutineTranspile.stepOptions =
{
  reflector : null,
  upToDate : 'preserve',
  entry : null,
  'external.before' : null,
  'external.after' : null,
}

stepRoutineTranspile.uniqueOptions =
{
}

//

function stepRoutineView( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  debugger;
  let filePath = step.resolve
  ({
    selector : opts.filePath,
    prefixlessAction : 'resolved',
    pathNativizing : 1,
  });
  debugger;

  // filePath = _.strReplace( filePath, '///', '//' );

  if( !Open )
  Open = require( 'open' );

  if( opts.delay )
  opts.delay = Number( opts.delay );

  if( opts.delay )
  {
    _.timeOut( opts.delay, () =>
    {
      view( filePath );
    });
    return null;
  }

  return view( filePath );

  function view( filePath )
  {
    debugger;
    if( verbosity >= 1 )
    logger.log( 'View ' + filePath );
    let result = Open( filePath );
    debugger;
    return result;
  }

}

stepRoutineView.stepOptions =
{
  filePath : null,
  delay : null,
}

stepRoutineView.uniqueOptions =
{
}

//

function stepRoutineNpmGenerate( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let verbosity = step.verbosityWithDelta( -1 );
  let about = module.about.structureExport();

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  opts.packagePath = module.pathResolve
  ({
    selector : opts.packagePath || '{path::out}/package.json',
    prefixlessAction : 'resolved',
    pathNativizing : 0,
    selectorIsPath : 1,
    currentContext : step,
  });

  if( opts.entryPath )
  opts.entryPath = module.filesFromResource({ selector : opts.entryPath, currentContext : step });
  if( opts.filesPath )
  opts.filesPath = module.filesFromResource({ selector : opts.filesPath, currentContext : step });

  /* */

  let config = Object.create( null );
  config.name = about.name;
  config.version = about.version;
  config.enabled = about.enabled;

  if( about.description )
  config.description = about.description;
  if( about.keywords )
  config.keywords = about.keywords;
  if( about.license )
  config.license = about.license;

  if( about.interpreters )
  {
    let interpreters = _.arrayAs( about.interpreters );
    interpreters.forEach( ( interpreter ) =>
    {
      if( _.strHas( interpreter, 'njs' ) )
      config.engine = _.strReplace( interpreter, 'njs', 'node' );
    });
  }

  if( about.author )
  config.author = about.author;
  if( about.contributors )
  config.contributors = about.contributors;

  for( let n in about )
  {
    if( !_.strBegins( n, 'npm.' ) )
    continue;
    config[ _.strRemoveBegin( n, 'npm.' ) ] = about[ n ];
  }

  if( opts.entryPath && opts.entryPath.length )
  {
    config.main = _.scalarFrom( path.s.relative( path.dir( opts.packagePath ), opts.entryPath ) );
  }

  if( opts.filesPath && opts.filesPath.length )
  {
    config.files = path.s.relative( path.dir( opts.packagePath ), opts.filesPath );
  }

  if( module.pathMap.repository )
  config.repository = pathSimplify( module.pathMap.repository );
  if( module.pathMap.bugtracker )
  config.bugs = pathSimplify( module.pathMap.bugtracker );
  if( module.pathMap.entry )
  config.entry = module.pathMap.entry;

  for( let n in module.pathMap )
  {
    if( !_.strBegins( n, 'npm.' ) )
    continue;
    config[ _.strRemoveBegin( n, 'npm.' ) ] = module.pathMap[ n ];
  }

  for( let s in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ s ];
    let p = submodule.path;
    p = path.parseFull( p );

    _.assert
    (
      p.protocol === 'npm' || p.protocol === 'hd',
      () => 'Implemented only for "npm" and "hd" dependencies, but got ' + p.full
    );

    if( p.protocol === 'npm' )
    {
      depAdd( submodule, path.relative( '/', p.longPath ) );
    }
    else if( p.protocol === 'hd' )
    {
      depAdd( submodule, 'file:' + p.longPath );
    }
    else _.assert( 0 );

  }

  _.sure( !fileProvider.isDir( opts.packagePath ), () => packagePath + ' is dir, not safe to delete' );

  fileProvider.fileWrite
  ({
    filePath : opts.packagePath,
    data : config,
    encoding : 'json.fine',
    verbosity : verbosity ? 5 : 0,
  });

  debugger;
  return null;

  /* */

  function pathSimplify( src )
  {
    let r = src;
    if( !_.strIs( r ) )
    return r;

    r = r.replace( '///', '//' );
    r = r.replace( 'npm://', '' );

    return r;
  }

  function depAdd( submodule, name )
  {
    if( submodule.criterion.optional )
    _depAdd( 'optionalDependencies', name );
    else if( submodule.criterion.development )
    _depAdd( 'devDependencies', name );
    else
    _depAdd( 'dependencies', name );
  }

  function _depAdd( section, name )
  {
    config[ section ] = config[ section ] || Object.create( null );
    config[ section ][ name ] = '';
  }

}

stepRoutineNpmGenerate.stepOptions =
{
  packagePath : 'package.json',
  entryPath : 'Index.js',
  filesPath : null,
}

stepRoutineNpmGenerate.uniqueOptions =
{
}

//

function stepRoutineSubmodulesDownload( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.subModulesDownload();
}

stepRoutineSubmodulesDownload.stepOptions =
{
}

//

function stepRoutineSubmodulesUpdate( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.subModulesUpdate();
}

stepRoutineSubmodulesUpdate.stepOptions =
{
}

//

function stepRoutineSubmodulesAgree( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.subModulesAgree();
}

stepRoutineSubmodulesAgree.stepOptions =
{
}

//

function stepRoutineSubmodulesAreUpdated( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  let relations = module.modulesEach({ outputFormat : '*/relation' });
  let totalNumber = _.mapKeys( module.submoduleMap ).length;
  let upToDateNumber = 0;

  let con = new _.Consequence().take( null );

  logger.up();

  _.each( relations, ( relation ) =>
  {
    con.then( () => update() )
    con.then( () =>
    {
      /* */

      if( !isDownloaded() )
      {
        logger.error( ' ! Submodule ' + relation.opener.decoratedQualifiedName + ' is not downloaded!'  );
        return false;
      }

      /* check if module is downloaded from correct remote */

      let gitProvider = will.fileProvider.providerForPath( relation.opener.remotePath );
      let result = gitProvider.isDownloadedFromRemote
      ({
        localPath : relation.opener.downloadPath,
        remotePath : relation.opener.remotePath
      });

      if( !result.downloadedFromRemote )
      {
        logger.error
        (
          ' ! Submodule ' + relation.opener.decoratedQualifiedName, 'is already downloaded, but has different origin url:',
          _.color.strFormat( result.originVcsPath, 'path' ), ', expected url:', _.color.strFormat( result.remoteVcsPath, 'path' )
        );
        return false;
      }

      /* */

      if( !relation.opener.isUpToDate )
      logger.error( ' ! Submodule ' + relation.opener.decoratedQualifiedName + ' is not up to date!'  );
      else
      upToDateNumber += 1;
      return null;
    })

    function isDownloaded()
    {
      if( !relation.opener )
      return false;

      _.assert( _.boolLike( relation.opener.isDownloaded ) );

      if( !relation.opener.isDownloaded )
      return false;

      if( !relation.opener.isGitRepository )
      return false;

      return true;
    }

    function update()
    {
      let con = new _.Consequence().take( null );
      con.then( () => relation.opener.remoteIsDownloadedReform() )
      con.then( () => relation.opener.remoteIsGoodRepositoryReform() )
      con.then( () => relation.opener.remoteIsUpToDateReform() )
      return con;
    }
  });

  con.finally( ( err, got ) =>
  {
    if( err )
    throw _.err( err, '\nFailed to check if modules are up to date' );

    let message = upToDateNumber + '/' + totalNumber + ' submodule(s) of ' + module.decoratedQualifiedName + ' are up to date';

    let allAreUpToDate = upToDateNumber === totalNumber;

    if( !allAreUpToDate )
    throw _.errBrief( message );
    else
    logger.log( message );

    logger.down();

    return allAreUpToDate;
  })

  return con;
}

stepRoutineSubmodulesAreUpdated.stepOptions =
{
}

//

function stepRoutineSubmodulesReload( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = _.mapExtend( null, step.opts );
  let verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  if( verbosity )
  {
    logger.log( ' . Reloading submodules..' );
  }

  return module.submodulesReload();
}

stepRoutineSubmodulesReload.stepOptions =
{
}

//

function stepRoutineSubmodulesClean( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.submodulesClean();
}

stepRoutineSubmodulesClean.stepOptions =
{
}

//

function stepRoutineClean( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.clean();
}

stepRoutineClean.stepOptions =
{
}

//

function stepRoutineExport( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let build = run.build;
  let will = module.will;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  return module.exportedMake({ build })
  .then( ( exported ) =>
  {
    // debugger;
    _.assert( exported instanceof _.Will.Exported );
    return exported.perform( frame );
  });

  // let exported = module.exportedMake({ build });
  //
  // // if( module.exportedMap[ build.name ] )
  // // {
  // //   module.exportedMap[ build.name ].finit();
  // //   _.assert( module.exportedMap[ build.name ] === undefined );
  // // }
  // //
  // // let exported = new will.Exported({ module : module, name : build.name }).form1();
  // //
  // // _.assert( module.exportedMap[ build.name ] === exported );
  //
  // return exported.perform( frame );
}

stepRoutineExport.stepOptions =
{
  export : null,
  tar : 0,
}

stepRoutineExport.uniqueOptions =
{
  export : null,
}

//

function stepRoutineWillbeIsUpToDate( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;

  _.assert( arguments.length === 1 );

  return will.versionIsUpToDate( _.mapExtend( null, step.opts ) );
}

stepRoutineWillbeIsUpToDate.stepOptions =
{
  throwing : 1,
  // brief : 0
}

stepRoutineWillbeIsUpToDate.uniqueOptions =
{
}

// --
// declare
// --

let Extend =
{

  filesReflect,

  stepRoutineDelete,
  stepRoutineReflect,
  stepRoutineTimelapseBegin,
  stepRoutineTimelapseEnd,

  stepRoutineJs,
  stepRoutineShell,
  stepRoutineTranspile,
  stepRoutineView,
  stepRoutineNpmGenerate,

  stepRoutineSubmodulesDownload,
  stepRoutineSubmodulesUpdate,
  stepRoutineSubmodulesAgree,
  stepRoutineSubmodulesAreUpdated,
  stepRoutineSubmodulesReload,
  stepRoutineSubmodulesClean,

  stepRoutineClean,
  stepRoutineExport,

  stepRoutineWillbeIsUpToDate

}

//

_.mapExtend( Self, Extend );
_.staticDeclare
({
  prototype : _.Will.prototype,
  name : 'Predefined',
  value : Self,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

})();
