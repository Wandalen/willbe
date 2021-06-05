( function _Predefined_s_()
{

'use strict';

let Tar, Open;
const _ = _global_.wTools;
const Self = _.will.Predefined = _.will.Predefined || Object.create( null );

// --
// implementation
// --

let _filesReflect = _.routineExtend( null, _.FileProvider.FindMixin.prototype.filesReflect );
let defaults = _filesReflect.defaults;
defaults.linkingAction = 'hardLinkMaybe';
defaults.outputFormat = 'record';
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );
  let time = _.time.now();
  let verbosity = step.verbosityWithDelta( -1 );

  beginLog();

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  let filePath = step.inPathResolve( opts.filePath );

  let o2 =
  {
    filePath,
    verbosity : 0,
  }

  if( filePath instanceof _.will.Reflector )
  {
    delete o2.filePath;
    let o3 = filePath.optionsForFindExport();
    _.props.extend( o2, o3 );
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

    let spentTime = _.time.now() - time;
    let groupsMap = path.group({ keys : o2.filter.filePath, vals : o2.result });
    let textualReport = path.groupTextualReport
    ({
      explanation : ' - ' + step.decoratedQualifiedName + ' deleted ',
      groupsMap,
      verbosity,
      spentTime,
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );
  let time = _.time.now();
  let verbosity = step.verbosityWithDelta( -1 );

  _.assert( !!opts.filePath, 'Expects reflector as option filePath' );
  _.assert( arguments.length === 1 );

  let reflector = step.reflectorResolve( opts.filePath );

  _.sure( reflector instanceof _.will.Reflector, () => `Step "reflect" expects reflector, but got ${_.entity.strType( reflector )}` )
  _.assert( reflector.formed === 3, () => `${reflector.qualifiedName} is not formed` );

  beginLog();

  delete opts.filePath ;

  let reflectorOptions = reflector.optionsForReflectExport();

  _.props.extend( opts, reflectorOptions );

  opts.verbosity = 0;

  return _.Consequence.Try( () =>
  {

    // _.will.Predefined._filesReflect.head.call( fileProvider, _.will.Predefined._filesReflect, opts );

    return _.will.Predefined._filesReflect.call( fileProvider, opts );
  })
  .then( ( result ) =>
  {
    endLog();
    return result;
  })
  .catch( ( err ) =>
  {
    err = _.err( err, '\n\n', _.strLinesIndentation( reflector.exportString(), '  ' ), '\n' );
    throw _.err( err );
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
    logger.log( ' + ' + reflector.decoratedQualifiedName + ' reflected ' + opts.result.length + ' file(s) ' + mtr + ' in ' + _.time.spent( time ) );

  }

  /* */

}

stepRoutineReflect.stepOptions =
{
  filePath : null,
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );

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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );

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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );

  _.assert( arguments.length === 1 );

  _.sure( opts.js === null || _.strIs( opts.js ) );

  /* */

  try
  {
    opts.js = step.inPathResolve({ selector : opts.js, prefixlessAction : 'resolved' });
    opts.routine = require( fileProvider.providersWithProtocolMap.hd.path.nativize( opts.js ) );
    if( !_.routineIs( opts.routine ) )
    throw _.err( 'JS file should return function, but got', _.entity.strType( opts.routine ) );
  }
  catch( err )
  {
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

function stepRoutineEcho( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );

  _.assert( arguments.length === 1 );
  _.sure( _.strIs( opts.echo ) );

  /* */

  try
  {
    opts.echo = module.resolve
    ({
      selector : opts.echo,
      prefixlessAction : 'resolved',
      currentContext : step,
    });
  }
  catch( err )
  {
    throw _.err( err, '\nFailed to resolve echo output', _.strQuote( opts.echo ) );
  }

  /* */

  logger.log( opts.echo );

  /* */

  return opts.echo;
}

stepRoutineEcho.stepOptions =
{
  echo : null,
}

stepRoutineEcho.uniqueOptions =
{
  echo : null,
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );
  let forEachDstReflector, forEachDst;
  let verbosity = step.verbosityWithDelta( -1 );

  beginLog();

  _.assert( arguments.length === 1 );
  _.sure( opts.shell === null || _.strIs( opts.shell ) || _.arrayIs( opts.shell ) );
  _.sure( _.longHas( [ 'preserve', 'rebuild' ], opts.upToDate ), () => 'Unknown value of upToDate ' + _.strQuote( opts.upToDate ) );

  if( opts.forEachDst )
  forEachDst = forEachDstReflector = step.reflectorResolve( opts.forEachDst );

  /* */

  if( opts.upToDate === 'preserve' && forEachDstReflector )
  {

    _.assert( forEachDstReflector instanceof _.will.Reflector );
    forEachDst = _.will.resolver.Resolver.сontextPrepare({ currentThis : forEachDstReflector, baseModule : module });

    for( let dst in forEachDst.filesGrouped )
    {
      let src = forEachDst.filesGrouped[ dst ];
      let upToDate = fileProvider.filesAreUpToDate2({ dst, src });
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
    currentThis : forEachDst !== undefined ? forEachDst : null,
    currentContext : step,
    verbosity,
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );
  let verbosity = step.verbosityWithDelta( -1 );

  _.sure( _.longHas( [ 'preserve', 'rebuild' ], opts.upToDate ), () => 'Unknown value of upToDate ' + _.strQuote( opts.upToDate ) );
  _.sure
  (
    opts.transpilingStrategy === null || _.arrayIs( opts.transpilingStrategy ),
    () => 'Unknown value of transpilingStrategy ' + _.strQuote( opts.transpilingStrategy )
  );
  _.assert( arguments.length === 1 );

  if( opts.entry )
  opts.entry = step.inPathResolve( opts.entry );
  if( opts[ 'external.before' ] )
  opts[ 'external.before' ] = step.inPathResolve( opts[ 'external.before' ] );
  if( opts[ 'external.after' ] )
  opts[ 'external.after' ] = step.inPathResolve( opts[ 'external.after' ] );

  let reflector = step.reflectorResolve( opts.filePath );
  let reflectOptions = reflector.optionsForReflectExport();

  _.include( 'wTranspile' );

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

  if( opts.transpilingStrategy === null )
  {
    opts.transpilingStrategy = [ 'Uglify' ];
    if( debug )
    opts.transpilingStrategy = [ 'Nop' ];
  }

  let ts = new _.trs.System({ logger }).form();
  let multiple = ts.multiple
  ({

    inPath : reflectOptions.src,
    outPath : reflectOptions.dst,
    entryPath : opts.entry,
    externalBeforePath : opts[ 'external.before' ],
    externalAfterPath : opts[ 'external.after' ],
    // totalReporting : 0,
    transpilingStrategy : opts.transpilingStrategy,
    splittingStrategy : raw ? 'OneToOne' : 'ManyToOne',
    writingTerminalUnderDirectory : 1,
    simpleConcatenator : 0,
    upToDate : opts.upToDate,
    verbosity,
    // verbosity : 1,

    optimization : opts.optimization,
    minification : opts.minification,
    diagnosing : opts.diagnosing,
    beautifing : opts.beautifing,

  });

  return multiple.form().perform()
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err );
    // throw _.errLogOnce( err );
    return arg;
  });

}

stepRoutineTranspile.stepOptions =
{
  'filePath' : null,
  'upToDate' : 'preserve',
  'entry' : null,
  'external.before' : null,
  'external.after' : null,

  'transpilingStrategy' : null,
  'optimization' : 9,
  'minification' : 8,
  'diagnosing' : 1,
  'beautifing' : 0
}

stepRoutineTranspile.uniqueOptions =
{
  transpilingStrategy : null,
  optimization : 9,
  minification : 8,
  diagnosing : 1,
  beautifing : 0
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );
  let verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  let filePath = module.pathResolve
  ({
    selector : opts.filePath,
    prefixlessAction : 'resolved',
    pathNativizing : 1,
    selectorIsPath : 1,
    currentContext : step,
  });

  // debugger; xxx
  // let filePath = step.resolve
  // ({
  //   selector : opts.filePath,
  //   prefixlessAction : 'resolved',
  //   pathNativizing : 1,
  // });

  // filePath = _.strReplace( filePath, '///', '//' );

  if( !Open )
  Open = require( 'open' );

  if( opts.delay )
  opts.delay = Number( opts.delay );

  if( opts.delay )
  {
    _.time.out( opts.delay, () =>
    {
      view( filePath );
    });
    return null;
  }

  return view( filePath );

  function view( filePath )
  {
    if( verbosity >= 1 )
    logger.log( 'View ' + filePath );
    let result = Open( filePath );
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
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );
  opts.currentContext = step;

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.npmGenerateFromWillfile( opts );
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

function stepRoutineWillfileFromNpm( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );
  opts.currentContext = step;

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.willfileGenerateFromNpm( opts );
}

stepRoutineWillfileFromNpm.stepOptions =
{
  packagePath : 'package.json',
  willfilePath : '.will.yml',
}

stepRoutineWillfileFromNpm.uniqueOptions =
{
}

//

function stepRoutineGitExecCommand( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitExecCommand( opts );
}

stepRoutineGitExecCommand.stepOptions =
{
  command : null,
  hardLinkMaybe : 1,
  profile : 'default',
}

stepRoutineGitExecCommand.uniqueOptions =
{
  command : null,
}

//

function stepRoutineGitPull( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitPull( opts );
}

stepRoutineGitPull.stepOptions =
{
  dirPath : null,
  profile : 'default',
};

stepRoutineGitPull.uniqueOptions =
{
};

//

function stepRoutineGitPush( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitPush( opts );
}

stepRoutineGitPush.stepOptions =
{
  dirPath : null,
  withTags : 1,
  force : 1,
};

stepRoutineGitPush.uniqueOptions =
{
};

//

function stepRoutineGitReset( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitReset( opts );
}

stepRoutineGitReset.stepOptions =
{
  removingUntracked : 0,
  removingIgnored : 0,
  removingSubrepositories : 0,
  dirPath : null,
  dry : 0,
}

stepRoutineGitReset.uniqueOptions =
{
  removingUntracked : 0,
  removingIgnored : 0,
  removingSubrepositories : 0,
}

//

function stepRoutineGitStatus( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitStatus( opts );
}

stepRoutineGitStatus.stepOptions =
{
  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
}

stepRoutineGitStatus.uniqueOptions =
{
  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
}

//

function stepRoutineGitSync( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitSync( opts );
}

stepRoutineGitSync.stepOptions =
{
  message : '-am "."',
  dirPath : null,
  profile : 'default',
  dry : 0,
};

stepRoutineGitSync.uniqueOptions =
{
  message : '-am "."',
};

//

function stepRoutineGitTag( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );
  opts.name = opts[ 'tag.name' ];
  opts.description = opts[ 'tag.description' ];
  delete opts[ 'tag.name' ];
  delete opts[ 'tag.description' ];

  _.assert( arguments.length === 1 );
  _.assert( _.object.isBasic( opts ) );

  return module.gitTag( opts );
}

stepRoutineGitTag.stepOptions =
{
  'tag.name' : '.',
  'tag.description' : '',
  'dry' : 0,
  'light' : 0,
}

stepRoutineGitTag.uniqueOptions =
{
  'tag.name' : '.',
}

//

function stepRoutineModulesUpdate( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( _.object.isBasic( opts ) );

  for( let opt in opts )
  {
    opts[ opt ] = module.resolve
    ({
      selector : opts[ opt ],
      prefixlessAction : 'resolved',
      currentContext : step,
    });
  }

  let con = _.take( null );

  con.then( () =>
  {
    let opener = module.toOpener();
    if( opts.to )
    opener.remotePathChangeVersionTo( opts.to );

    let o2 = _.mapOnly_( null, opts, opener.repoUpdate.defaults );
    o2.strict = 0;
    o2.opening = 0;
    return opener.repoUpdate( o2 );
  })

  con.then( () =>
  {
    let o2 = module.will.filterImplied();
    o2 = _.props.extend( o2, opts );
    return module.subModulesUpdate( o2 );
  })

  return con;
}

stepRoutineModulesUpdate.stepOptions =
{
  dry : null,
  loggingNoChanges : null,
  recursive : null,
  withStem : null,
  withDisabledStem : null,
  to : null
}

stepRoutineModulesUpdate.uniqueOptions =
{
  loggingNoChanges : null,
  withStem : null,
  withDisabledStem : null,
  to : null
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
  let opts = _.props.extend( null, step.opts );

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( _.object.isBasic( opts ) );

  for( let opt in opts )
  {
    opts[ opt ] = module.resolve
    ({
      selector : opts[ opt ],
      prefixlessAction : 'resolved',
      currentContext : step,
    });
  }

  return module.subModulesUpdate( opts );
}

stepRoutineSubmodulesUpdate.stepOptions =
{
  dry : null,
  loggingNoChanges : null,
  recursive : null,
  withStem : null,
  withDisabledStem : null,
  to : null
}

stepRoutineSubmodulesUpdate.uniqueOptions =
{
  loggingNoChanges : null,
  withStem : null,
  withDisabledStem : null,
  to : null
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

function stepRoutineSubmodulesVersionsVerify( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let will = module.will;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.submodulesVerify
  ({

    recursive : 1,
    throwing : 1,
    asMap : 1,

    hasFiles : 1,
    isRepository : 1,
    isValid : 1,
    hasRemote : 1,
    isUpToDate : 1,

  })
  .finally( ( err, summary ) =>
  {
    if( err )
    throw _.err( err, '\nFailed to check if modules are up to date' );

    let message = summary.verifiedNumber + '/' + summary.totalNumber + ' submodule(s) of ' + module.decoratedQualifiedName + ' are up to date';
    let allAreUpToDate = summary.verifiedNumber === summary.totalNumber;

    if( !allAreUpToDate )
    throw _.errBrief( message );

    logger.log( message );

    logger.down();

    return allAreUpToDate;
  })

}

stepRoutineSubmodulesVersionsVerify.stepOptions =
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
  let logger = will.transaction.logger;
  let opts = _.props.extend( null, step.opts );
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
  let will = module.will;
  let logger = will.transaction.logger;
  let build = frame.closesBuildGet();

  _.assert( arguments.length === 1 );
  _.assert( build instanceof _.will.Build );
  // _.assert( _.boolLike( frame.run.isRoot ) ); /* xxx : investigate */
  // _.assert( _.boolLike( frame.run.purging ) ); /* xxx : investigate */

  return module.exportedMake({ build, purging : frame.run.isRoot && frame.run.purging })
  .then( ( exported ) =>
  {
    _.assert( exported instanceof _.will.Exported );
    return exported.perform( frame );
  });
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

  return will.versionIsUpToDate( _.props.extend( null, step.opts ) );
}

stepRoutineWillbeIsUpToDate.stepOptions =
{
  throwing : 1,
  // brief : 0
}

stepRoutineWillbeIsUpToDate.uniqueOptions =
{
}

//

function stepRoutineWillfileVersionBump( frame )
{
  let step = this;
  let run = frame.run;
  let module = run.module;
  let opts = _.props.extend( null, step.opts );
  opts.verbosity = step.verbosityWithDelta( -1 );

  _.assert( arguments.length === 1 );

  return module.willfileVersionBump( opts );
}

stepRoutineWillfileVersionBump.stepOptions =
{
  versionDelta : 1,
}

stepRoutineWillfileVersionBump.uniqueOptions =
{
  versionDelta : 1,
}

// --
// declare
// --

let Extension =
{

  _filesReflect,

  stepRoutineDelete,
  stepRoutineReflect,
  stepRoutineTimelapseBegin,
  stepRoutineTimelapseEnd,

  stepRoutineJs,
  stepRoutineEcho,
  stepRoutineShell,
  stepRoutineTranspile,
  stepRoutineView,

  stepRoutineNpmGenerate,
  stepRoutineWillfileFromNpm,

  stepRoutineGitExecCommand,
  stepRoutineGitPull,
  stepRoutineGitPush,
  stepRoutineGitReset,
  stepRoutineGitStatus,
  stepRoutineGitSync,
  stepRoutineGitTag,

  stepRoutineModulesUpdate,

  stepRoutineSubmodulesDownload,
  stepRoutineSubmodulesUpdate,
  stepRoutineSubmodulesAgree,
  stepRoutineSubmodulesVersionsVerify,
  stepRoutineSubmodulesReload,
  stepRoutineSubmodulesClean,

  stepRoutineClean,
  stepRoutineExport,

  stepRoutineWillbeIsUpToDate,

  stepRoutineWillfileVersionBump,
}

/* _.props.extend */Object.assign( _.will.Predefined, Extension );

})()
