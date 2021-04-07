( function _Build_s_()
{

'use strict';

/**
 * @classdesc Class wWillBuild provides interface for forming and handling build resources.
 * @class wWillBuild
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.Resource;
const Self = wWillBuild;
function wWillBuild( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Build';

// --
// inter
// --

function init( o )
{
  let resource = this;

  Parent.prototype.init.apply( resource, arguments );

  return resource;
}

//

function form3()
{
  let build = this;
  let module = build.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( build.formed === 3 )
  return build;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( build.formed === 2 );

  /* begin */

  if( build.criterion && build.criterion.default !== undefined )
  build.criterion.default = build.criterion.default ? 1 : 0;

  /* end */

  build.formed = 3;
  return build;
}

//

function stepsEach( o )
{
  let build = this;
  let module = build.module;
  let will = module.will;
  let result = [];

  if( _.routineIs( arguments[ 0 ] ) )
  o = { onEach : arguments[ 0 ] }
  o = _.routineOptions( stepsEach, o );

  each( build.steps );

  return result;

  /* */

  function each( step )
  {
    if( step === null )
    return;
    if( _.arrayIs( step ) )
    inArray( step )
    else if( _.mapIs( step ) )
    inMap( step );
    else
    inElement( step );
  }

  function inElement( stepName )
  {

    let step = module.resolve
    ({
      selector : stepName,
      defaultResourceKind : 'step',
      prefixlessAction : 'default',
      currentContext : build,
      missingAction : 'error',
    });

    if( _.errIs( step ) )
    {
      debugger;
      throw _.err( step, '\nFound no ' + stepName + ' for ' + build.qualifiedName );
    }

    if( _.arrayIs( step ) )
    return inArray( step );

    _.assert( step instanceof _.will.Step || step instanceof _.will.Build, () => 'Cant find ' + arguments[ 0 ] );
    let it = Object.create( null );
    it.element = step;
    handleEach( it )
    // onEach( it );
  }

  function inArray( steps )
  {
    _.assert( _.arrayIs( steps ) );
    for( let s = 0 ; s < steps.length ; s++ )
    {
      let step = steps[ s ];
      each( step );
    }
  }

  function inMap( steps )
  {
    _.assert( _.mapIs( steps ) );
    _.map.assertHasOnly( steps, { concurrent : null } );
    // onEach({ concurrent : steps.concurrent });
    handleEach({ concurrent : steps.concurrent });
    inArray( steps.concurrent );
  }

  function handleEach( it )
  {
    _.assert( !!it.element );
    result.push( it.element );
    if( o.onEach )
    o.onEach( it );
  }

}

stepsEach.defaults =
{
  onEach : null,
}

//

function framePerform( frame )
{
  let build = this;
  let run = frame.run;
  let resource = frame.resource;
  let module = run.module;
  // let module = frame.module;
  let will = module.will;
  let logger = will.logger;
  let con = _.take( null );

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!logger );
  _.assert( module.preformed > 0  );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( resource === build );
  // _.assert( frame.build === build );

  /*
    first run to make sure all steps exist
  */

  // debugger;
  let steps = build.stepsEach();
  // debugger;

  steps.forEach( function( step )
  {
    let frame2;
    con.then( ( arg ) => frame2 = frame.frameUp( step ) );
    // con.then( ( arg ) => frame2.resourceFormAndPerform() );

    con.then( () => step.form() );
    con.then( () => step.framePerform( frame2 ) );

    con.finally( ( err, arg ) =>
    {
      if( frame2 )
      frame2.finit();
      if( err )
      throw err;
      return arg;
    });
  });

  // con.then( () => resource.form() );
  // con.then( ( arg ) =>
  // {
  //   _.assert( resource.formed === 3 );
  //   return arg;
  // });
  // con.then( () => resource.framePerform( frame ) );

  // /*
  //   first run to make sure all steps exist
  // */
  //
  // build.stepsEach( function( it )
  // {
  // });
  //
  // build.stepsEach( function( it )
  // {
  //   let frame2;
  //   con.then( ( arg ) => frame2 = frame.frameUp( it.element ) );
  //   con.then( ( arg ) => frame2.run() );
  //   con.finally( ( err, arg ) =>
  //   {
  //     if( frame2 )
  //     frame2.finit();
  //     if( err )
  //     throw err;
  //     return arg;
  //   });
  // });

  return con;
}

//

function perform( o )
{
  let build = this;
  let module = build.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  // let logger = will.logger;
  let logger = will.transaction.logger;
  let isExport = build.isExport();
  let con = _.take( null );
  let time = _.time.now();

  will.readingEnd();

  _.assert( !!will.willfilesReadEndTime, 'Please, call "will.readingEnd" first' );
  o = _.routineOptions( build.perform, arguments );

  if( !o.run )
  o.run = new _.will.BuildRun
  ({
    build,
  });

  _.assert( o.run instanceof _.will.BuildRun );

  o.run.form();

  let frame = o.run.frameUp( build );

  logPre();

  con
  .then( () => build.form() )
  .then( () => build.framePerform( frame ) )
  .finally( ( err, arg ) =>
  {
    frame.finit();

    if( err )
    {
      err = _.err( err );
      logger.error( _.errOnce( err ) );
      throw err;
    }
    // throw _.errLogOnce( err );

    logPost();

    return arg;
  });

  return con;

  /* */

  function logPre()
  {
    logger.up();
    if( logger.verbosity >= 2 )
    {
      logger.log( isExport ? 'Exporting' : 'Building', build.decoratedAbsoluteName );
    }
  }

  /* */

  function logPost()
  {

    if( logger.verbosity >= 1 )
    {
      let withFiles = '';
      if( o.run.exported.length )
      {
        let total = o.run.exported.reduce( ( acc, exported ) => acc + exported.exportedFilesPath.path.length, 0 );
        withFiles = 'with ' + total + ' file(s)';
        // withFiles = 'with ' + o.run.exported.exportedFilesPath.path.length + ' file(s)';
      }
      logger.log( ( isExport ? 'Exported' : 'Built' ), build.decoratedAbsoluteName, withFiles, 'in', _.time.spent( time ) );
      if( logger.verbosity >= 2 )
      logger.log();
    }

    logger.down();

  }

}

perform.defaults =
{
  run : null,
}

//

function isExport()
{
  let build = this;
  if( !build.criterion )
  return false;
  return !!build.criterion.export;
}

//

function archiveFilePathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inModule = module;
  if( inModule.isOut )
  inModule = inModule.peerModule;
  let inExportFile =
  inModule.willfileWithRoleMap.export || inModule.willfileWithRoleMap.single || inModule.willfileWithRoleMap.import;
  // let inFileDirPath = hd.path.dir( inExportFile.filePath );
  let inFileDirPath = inExportFile.dirPath;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( _.strDefined( build.name ), 'Build should have name' );
  _.assert( inExportFile instanceof _.will.Willfile );

  if( !_.strDefined( module.about.name ) )
  throw _.errBrief( 'Module should have name, declare about.name' );

  let exports = module.exportsResolve();
  let criterions = build.criterionVariable( exports );

  for( let c in criterions )
  if( !criterions[ c ] )
  delete criterions[ c ];

  let name = _.strJoinPath( [ module.about.name, _.mapKeys( criterions ).join( '-' ), '.out.tgs' ], '.' );

  return hd.path.resolve( module.outPath, name );
}

// --
// relations
// --

let Composes =
{

  steps : null,
  withSubmodules : null,

}

let Aggregates =
{
  name : null,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  MapName : 'buildMap',
  KindName : 'build',
}

let Forbids =
{
  exportDirPath : 'exportDirPath',
}

let Accessors =
{
}

// --
// declare
// --

let Extension =
{

  // inter

  init,
  form3,

  stepsEach,
  framePerform,
  perform,
  isExport,

  archiveFilePathFor,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
