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

  _.assert( arguments.length === 1 );

  let filePath = step.inPathResolve( frame.opts.filePath );
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

  _.assert( !!frame.opts.reflector, 'Expects option reflector' );
  _.assert( step.formed === 3 );
  _.assert( arguments.length === 1 );

  // if( step.opts.reflector )
  // {
  //   let reflectors = module.strResolve
  //   ({
  //     query :  step.opts.reflector,
  //     defaultPool : 'reflector',
  //     current : step,
  //     unwrappingSingle : 0,
  //   });
  //   _.assert( _.arrayIs( reflectors ) );
  //   for( let r = 0 ; r < reflectors.length ; r++ )
  //   reflectors[ r ].form();
  // }

  frame.opts.reflector = module.strResolve
  ({
    query : frame.opts.reflector,
    defaultPool : 'reflector',
    current : step,
  });

  frame.opts.reflector.form();

  _.sure( frame.opts.reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', _.strTypeOf( frame.opts.reflector ) )
  _.assert( frame.opts.reflector.formed === 3, () => frame.opts.reflector.nickName + ' is not formed' );

  frame.opts.reflector = frame.opts.reflector.optionsReflectExport();
  _.mapSupplement( frame.opts, frame.opts.reflector )
  delete frame.opts.reflector;

  // if( will.verbosity >= 2 && will.verbosity <= 3 )
  // {
  //   logger.log( ' + Files reflecting...' );
  //   logger.log( _.toStr( frame.opts.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  // }

  frame.opts.verbosity = will.verbosity >= 2 ? 2 : 0;

  let result = will.Predefined.filesReflect.call( fileProvider, frame.opts );

  return result;
}

stepRoutineReflect.stepOptions =
{
  reflector : null,
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

// --
// declare
// --

let Extend =
{

  filesReflect : filesReflect,

  stepRoutineDelete : stepRoutineDelete,
  stepRoutineReflect : stepRoutineReflect,
  stepRoutineExport : stepRoutineExport,

  stepRoutineSubmodulesDownload : stepRoutineSubmodulesDownload,
  stepRoutineSubmodulesUpgrade : stepRoutineSubmodulesUpgrade,
  stepRoutineSubmodulesClean : stepRoutineSubmodulesClean,

  stepRoutineClean : stepRoutineClean,

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
