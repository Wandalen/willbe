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

defaults.linking = 'hardlinkMaybe';
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
  return fileProvider.filesDelete({ filePath : filePath, verbosity : will.verbosity >= 2 ? 2 : 0 });
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

  _.assert( !!opts.reflector, 'Expects option reflector' );
  _.assert( arguments.length === 1 );

  opts.reflector = module.resolve
  ({
    query : opts.reflector,
    defaultPool : 'reflector',
    current : step,
  });

  opts.reflector.form();

  _.sure( opts.reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', _.strTypeOf( opts.reflector ) )
  _.assert( opts.reflector.formed === 3, () => opts.reflector.nickName + ' is not formed' );

  opts.reflector = opts.reflector.optionsReflectExport();
  _.mapSupplement( opts, opts.reflector )
  delete opts.reflector;

  if( will.verbosity >= 4 )
  {
    logger.log( ' + Files reflecting...' );
    logger.log( _.toStr( opts.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  if( opts.verbosity === null )
  opts.verbosity = _.numberClamp( will.verbosity - 2, 0, 9 );

  let result = will.Predefined.filesReflect.call( fileProvider, opts );

  return result;
}

stepRoutineReflect.stepOptions =
{
  reflector : null,
  verbosity : null,
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

  // _.sure( !!opts.shell ^ !!opts.js ^ _.routineIs( step.stepRoutine ), 'Step should have only {-shell-} or {-js-} or {-stepRoutine-} fields' );
  _.sure( opts.js === null || _.strIs( opts.js ) );

  /* */

  try
  {
    // debugger;
    // if( _.strBegins( opts.js, '.' ) )
    opts.js = step.inPathResolve({ query : opts.js, prefixlessAction : 'resolved' });
    opts.routine = require( fileProvider.providersWithProtocolMap.hd.path.nativize( opts.js ) );
    if( !_.routineIs( opts.routine ) )
    throw _.err( 'JS file should return function, but got', _.strTypeOf( opts.routine ) );
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

  // _.sure( !!opts.shell ^ !!opts.js ^ _.routineIs( step.stepRoutine ), 'Step should have only {-shell-} or {-js-} or {-stepRoutine-} fields' );
  // _.sure( opts.js === null || _.strIs( opts.js ) );
  _.sure( opts.shell === null || _.strIs( opts.shell ) || _.arrayIs( opts.shell ) );

  /* */

  if( opts.currentPath )
  opts.currentPath = step.inPathResolve({ query : opts.currentPath, prefixlessAction : 'resolved' });
  _.sure( opts.currentPath === null || _.strIs( opts.currentPath ), 'Current path should be string if defined' );

  /* */

  // if( _.arrayIs( opts.shell ) )
  // opts.shell = opts.shell.join( '\n' );

  return _.shell
  ({
    path : opts.shell,
    currentPath : opts.currentPath,
  }).doThen( ( err, arg ) =>
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

// --
// declare
// --

let Extend =
{

  filesReflect,

  stepRoutineDelete,
  stepRoutineReflect,
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
module[ 'exports' ] = wTools;

})();
