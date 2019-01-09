( function _Predefined_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let Tar;
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
  return fileProvider.filesDelete
  ({
    filePath : filePath,
    verbosity : will.verbosity >= 2 ? 2 : 0,
  });
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

  let reflector = module.resolve
  ({
    query : opts.reflector,
    defaultPool : 'reflector',
    current : step,
  });

  delete opts.reflector ;

  debugger;
  reflector.form();

  _.sure( reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', _.strType( reflector ) )
  _.assert( reflector.formed === 3, () => reflector.nickName + ' is not formed' );

  reflector = reflector.optionsReflectExport();

  _.mapSupplement( opts, reflector )

  if( will.verbosity >= 4 )
  {
    logger.log( ' + Reflecting...' );
    // logger.log( _.toStr( opts.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  if( opts.verbosity === null )
  opts.verbosity = will.verbosity-1;
  let verbosity = opts.verbosity;
  opts.verbosity = 0;

  let result = will.Predefined.filesReflect.call( fileProvider, opts );

  // if( will.verbosity >= 5 )
  // {
  //   logger.log( _.toStr( _.select( result, '*/src/absolute' ), { levels : 2, wrap : 0 } ) );
  // }

  if( verbosity >= 1 )
  {
    let srcFilter = opts.srcFilter.clone().form();
    let dstFilter = opts.dstFilter.clone().form();
    let src = srcFilter.srcPathCommon();
    let dst = dstFilter.dstPathCommon();
    logger.log( ' + ' + step.name + ' reflected ' + opts.result.length + ' files ' + path.moveReport( dst, src ) + ' in ' + _.timeSpent( time ) );
  }

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
    opts.js = step.inPathResolve({ query : opts.js, prefixlessAction : 'resolved' });
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
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let opts = frame.opts;

  _.assert( arguments.length === 1 );
  _.sure( opts.shell === null || _.strIs( opts.shell ) || _.arrayIs( opts.shell ) );

  /* */

  if( opts.currentPath )
  opts.currentPath = step.inPathResolve({ query : opts.currentPath, prefixlessAction : 'resolved' });
  _.sure( opts.currentPath === null || _.strIs( opts.currentPath ), 'Current path should be string if defined' );

  /* */

  return _.shell
  ({
    path : opts.shell,
    currentPath : opts.currentPath,
    verbosity : will.verbosity - 1,
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
}

stepRoutineShell.uniqueOptions =
{
  shell : null,
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

function stepRoutineSubmodulesUpgrade( frame )
{
  let step = this;
  let module = frame.module;

  _.assert( arguments.length === 1 );
  _.assert( !!module );

  return module.submodulesUpgrade();
}

stepRoutineSubmodulesUpgrade.stepOptions =
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

  return exported.proceed( frame );
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

  stepRoutineSubmodulesDownload,
  stepRoutineSubmodulesUpgrade,
  stepRoutineSubmodulesClean,

  stepRoutineClean,
  stepRoutineExport,

}

//

_.mapExtend( Self, Extend );
_.staticDecalre
({
  prototype : _.Will.prototype,
  name : 'Predefined',
  value : Self,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = /**/_global_.wTools;

})();
