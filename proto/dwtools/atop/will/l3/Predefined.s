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

function stepRoutineDelete( run )
{
  let step = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.objectIs( step.opts ) );
  _.assert( arguments.length === 2 );

  // debugger;
  let filePath = step.inPathResolve( step.filePath );
  // console.log( 'filesDelete', filePath );
  // debugger;
  _.sure( _.strCount( filePath, '/' ) > 3, () => 'Are you sure you want to delete ' + filePath + '?' );
  return fileProvider.filesDelete({ filePath : filePath, verbosity : 1 });
}

//

function stepRoutineReflect( run )
{
  let step = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.objectIs( step.opts ) );
  _.assert( !!step.opts.reflector, 'Expects option reflector' );
  _.assert( arguments.length === 2 );

  let opts = _.mapExtend( null, step.opts );
  // opts.reflector = module.strResolve( opts.reflector );
  opts.reflector = module.strResolve
  ({
    query : opts.reflector,
    defaultPool : 'reflector',
    current : step,
  });

  _.sure( opts.reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', step.opts )

  opts.reflector = opts.reflector.optionsReflectExport();
  _.mapSupplement( opts, opts.reflector )
  delete opts.reflector;

  if( will.verbosity >= 2 && will.verbosity <= 3 )
  {
    logger.log( 'filesReflect' );
    logger.log( _.toStr( opts.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  // debugger;
  let result = will.Predefined.filesReflect.call( fileProvider, opts );
  // debugger;

  return result;
}

//

function stepRoutineExport( run, build )
{
  let step = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hub = will.fileProvider;

  _.assert( arguments.length === 2 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!logger );
  _.assert( module.formed === 2 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( build.criterion ), 'Expects criterion of export' );
  _.sure( _.strDefined( build.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.willFileWithRoleMap.import ) || _.objectIs( module.willFileWithRoleMap.single ), 'Expects import in fine' );
  _.sure( _.objectIs( module.willFileWithRoleMap.export ) || _.objectIs( module.willFileWithRoleMap.single ), 'Expects export in fine' );
  _.sure( _.strDefined( module.about.name ), 'Expects name of the module defined' );
  _.sure( _.strDefined( module.about.version ), 'Expects the current version of the module defined' );

  /* begin */

  if( module.exportedMap[ build.name ] )
  {
    _.assert( 0, 'not tested' );
    module.exportedMap[ build.name ].finit();
    _.assert( module.exportedMap[ build.name ] === undefined );
  }

  let exported = new will.Exported({ module : module, name : build.name }).form1();

  _.assert( module.exportedMap[ build.name ] === exported );

  return exported.build();
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
