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
//
// --

let filesReflect = _.routineFromPreAndBody( _.FileProvider.Find.prototype.filesReflect.pre, _.FileProvider.Find.prototype.filesReflect.body );

let defaults = filesReflect.defaults;

defaults.linking = 'hardLinkMaybe';
defaults.mandatory = 1;
defaults.dstRewritingPreserving = 1;

//

function stepRoutineDelete( frame )
{
  let step = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( opts ) );

  let filePath = step.inPathResolve( opts.filePath );

  let o2 =
  {
    filePath : filePath,
    verbosity : will.verbosity >= 2 ? 2 : 0,
  }

  if( filePath instanceof will.Reflector )
  {
    delete o2.filePath;
    let o3 = filePath.optionsForFindExport();
    _.mapExtend( o2, o3 );
  }

  return fileProvider.filesDelete( o2 );
}

stepRoutineDelete.stepOptions =
{
  filePath : null,
}

//

function stepRoutineReflect( frame )
{
  let step = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;
  let time = _.timeNow();

  _.assert( !!opts.reflector, 'Expects option reflector' );
  _.assert( arguments.length === 1 );

  let reflector = step.reflectorResolve( opts.reflector );

  _.sure( reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', _.strType( reflector ) )
  _.assert( reflector.formed === 3, () => reflector.nickName + ' is not formed' );

  delete opts.reflector ;

  let reflectorOptions = reflector.optionsForReflectExport();

  _.mapSupplement( opts, reflectorOptions );

  if( will.verbosity >= 4 )
  {
    logger.log( ' + Reflecting...' );
    // logger.log( _.toStr( opts.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  if( opts.verbosity === null )
  opts.verbosity = will.verbosity-1;
  let verbosity = opts.verbosity;
  opts.verbosity = 0;

  let result;
  try
  {
    debugger;
    result = will.Predefined.filesReflect.call( fileProvider, opts );
  }
  catch( err )
  {
    if( err )
    throw _.errBriefly( err );
  }

  // if( will.verbosity >= 5 )
  // {
  //   logger.log( _.toStr( _.select( result, '*/src/absolute' ), { levels : 2, wrap : 0 } ) );
  // }

  _.Consequence.From( result ).then( ( result ) =>
  {

    if( verbosity >= 1 )
    {
      let dstFilter = opts.dstFilter.clone();
      let srcFilter = opts.srcFilter.clone().pairWithDst( dstFilter ).form();
      dstFilter.form();
      let src = srcFilter.filePathSrcCommon();
      let dst = dstFilter.filePathDstCommon();
      logger.log( ' + ' + step.name + ' reflected ' + opts.result.length + ' files ' + path.moveReport( dst, src ) + ' in ' + _.timeSpent( time ) );
    }

    return result;
  });

  return result;
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
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

  _.assert( arguments.length === 1 );

  /* */

  logger.log( 'Timelapse begin' );
  fileProvider.providersWithProtocolMap.hd.archive.timelapseBegin();

  return null;
}

stepRoutineTimelapseBegin.stepOptions =
{
}

//

function stepRoutineTimelapseEnd( frame )
{
  let step = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

  _.assert( arguments.length === 1 );

  /* */

  logger.log( 'Timelapse end' );
  fileProvider.providersWithProtocolMap.hd.archive.timelapseEnd();

  return null;
}

stepRoutineTimelapseEnd.stepOptions =
{
}

//

function stepRoutineJs( frame )
{
  let step = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

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
    throw _.err( 'Failed to open JS file', _.strQuote( opts.js ), '\n', err );
  }

  /* */

  try
  {
    let result = opts.routine( frame );
    return result || null;
  }
  catch( err )
  {
    throw _.err( 'Failed to execute JS file', _.strQuote( opts.js ), '\n', err );
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
  let module = frame.module;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;
  let forEachDstReflector, forEachDst;

  _.assert( arguments.length === 1 );
  _.sure( opts.shell === null || _.strIs( opts.shell ) || _.arrayIs( opts.shell ) );
  _.sure( _.arrayHas( [ 'preserve', 'rebuild' ], opts.upToDate ) );

  if( opts.forEachDst )
  forEachDst = forEachDstReflector = step.reflectorResolve( opts.forEachDst );

  /* */

  if( opts.upToDate === 'preserve' && forEachDstReflector )
  {
    _.assert( forEachDstReflector instanceof will.Reflector );
    forEachDst = module.resolveContextPrepare({ currentThis : forEachDstReflector });

    // debugger;
    for( let dst in forEachDst.filesGrouped )
    {
      let src = forEachDst.filesGrouped[ dst ];
      let upToDate = fileProvider.filesAreUpToDate( dst, src );
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

  debugger;
  return module.shell
  ({
    execPath : opts.shell,
    currentPath : opts.currentPath,
    currentThis : forEachDst,
    currentContext : step,
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.errBriefly( 'Failed to shell', step.nickName, '\n', err );
    return arg;
  });

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
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

  _.assert( arguments.length === 1 );

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

  let transpilingStrategies = [ 'Uglify' ];
  if( debug )
  transpilingStrategies = [ 'Nop' ];

  let ts = new _.TranspilationStrategy({ logger : logger }).form();
  let multiple = ts.multiple
  ({

    inputPath : reflectOptions.srcFilter,
    outputPath : reflectOptions.dstFilter,
    totalReporting : 0,
    transpilingStrategies : transpilingStrategies,
    splittingStrategy : raw ? 'OneToOne' : 'ManyToOne',
    writingTerminalUnderDirectory : 1,

    optimization : 9,
    minification : 8,
    diagnosing : 1,
    beautifing : 0,

  });

  // optimization : 9,
  // minification : 8,
  // diagnosing : 0,
  // beautifing : 0,

  return multiple.form().perform()
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.errLogOnce( err );
    return arg;
  });

}

stepRoutineTranspile.stepOptions =
{
  reflector : null,
}

stepRoutineTranspile.uniqueOptions =
{
}

//

function stepRoutineView( frame )
{
  let step = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

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
    if( will.verbosity >= 3 )
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

function stepRoutineSubmodulesDownload( frame )
{
  let step = this;
  let module = frame.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.submodulesDownload();
}

stepRoutineSubmodulesDownload.stepOptions =
{
}

//

function stepRoutineSubmodulesUpdate( frame )
{
  let step = this;
  let module = frame.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.submodulesUpdate();
}

stepRoutineSubmodulesUpdate.stepOptions =
{
}

//

function stepRoutineSubmodulesReload( frame )
{
  let step = this;
  let module = frame.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  if( will.verbosity >= 3 )
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
  let module = frame.module;

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
  let module = frame.module;

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
  let build = frame.build;
  let module = frame.module;
  let will = module.will;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  /* begin */

  if( module.exportedMap[ build.name ] )
  {
    _.assert( 0, 'not tested' );
    module.exportedMap[ build.name ].finit();
    _.assert( module.exportedMap[ build.name ] === undefined );
  }

  let exported = new will.Exported({ module : module, name : build.name }).form1();

  _.assert( module.exportedMap[ build.name ] === exported );

  return exported.perform( frame );
}

stepRoutineExport.stepOptions =
{
  export : null,
  tar : 1,
}

stepRoutineExport.uniqueOptions =
{
  export : null,
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

  stepRoutineSubmodulesDownload,
  stepRoutineSubmodulesUpdate,
  stepRoutineSubmodulesReload,
  stepRoutineSubmodulesClean,

  stepRoutineClean,
  stepRoutineExport,

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
