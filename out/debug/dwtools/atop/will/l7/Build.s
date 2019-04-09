( function _Build_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillBuild( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Build';

// --
// inter
// --

function form3()
{
  let build = this;
  let module = build.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( build.formed === 2 );

  /* begin */

  if( build.criterion && build.criterion.default !== undefined )
  build.criterion.default = build.criterion.default ? 1 : 0;

  /* end */

  build.formed = 3;
  return build;
}

function form3()
{
  let build = this;
  let module = build.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( build.formed === 2 );

  /* begin */

  if( build.criterion && build.criterion.default !== undefined )
  build.criterion.default = build.criterion.default ? 1 : 0;

  // if( _.arrayIs( build.steps ) )
  // build.steps = [ build.steps ];

  /* end */

  // _.assert( build.steps === null || _.arrayIs( build.steps ) );
  build.formed = 3;
  return build;
}

//

function stepsEach( onEach )
{
  let build = this;
  let module = build.module;
  let will = module.will;

  each( build.steps );

  return build;

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
      defaultResourceName : 'step',
      prefixlessAction : 'default',
      currentContext : build,
      missingAction : 'error',
    });

    if( _.errIs( step ) )
    {
      debugger;
      throw _.err( 'No such step ' + stepName + ' for build ' + build.nickName + '' + '\n', step );
    }

    if( _.arrayIs( step ) )
    return inArray( step );

    _.assert( step instanceof will.Step || step instanceof will.Build, () => 'Cant find ' + arguments[ 0 ] );
    let it = Object.create( null );
    it.element = step;
    onEach( it );
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
    _.assertMapHasOnly( steps, { concurrent : null } );
    onEach({ concurrent : steps.concurrent });
    inArray( steps.concurrent );
  }

}

//

function run( frame )
{
  let build = this;
  let resource = frame.resource;
  let module = frame.module;
  let will = module.will;
  let logger = will.logger;
  let con = new _.Consequence().take( null );

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!logger );
  _.assert( module.preformed === 3 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( resource.formed === 3 );
  _.assert( resource === build );
  _.assert( frame.build === build );

  /*
    to make sure all steps exist
  */
  build.stepsEach( function( it )
  {
  });

  build.stepsEach( function( it )
  {
    let frame2;
    con.then( ( arg ) => frame2 = frame.cloneUp( it.element ) );
    con.then( ( arg ) => frame2.run() );
    con.finally( ( err, arg ) =>
    {
      if( frame2 )
      frame2.finit();
      if( err )
      throw err;
      return arg;
    });
  });

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
  let logger = will.logger;
  let isExport = build.isExport();
  let time = _.timeNow();

  // return _.timeOutError( 100, 'xxx' );

  let frame = new will.BuildFrame
  ({
    module : module,
    build : build,
    resource : build,
  }).form();

  o = _.routineOptions( build.perform, arguments );

  logPre();

  return frame.run()
  .finally( ( err, arg ) =>
  {
    frame.finit();
    if( err )
    throw _.errLogOnce( err );

    logPost();

    return arg;
  });

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
      logger.log( ( isExport ? 'Exported' : 'Built' ), build.decoratedAbsoluteName, 'in', _.timeSpent( time ) );
      if( logger.verbosity >= 2 )
      logger.log();
    }
    logger.down();

  }

}

perform.defaults =
{
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
  let inExportFile = module.willFileWithRoleMap.export || module.willFileWithRoleMap.single;
  let inFileDirPath = hd.path.dir( inExportFile.filePath )

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( build.name ), 'Build should have name' );
  _.assert( _.strDefined( module.about.name ), 'Module should have name, declare about.name' );
  _.assert( inExportFile instanceof will.WillFile );

  let exports = module.exportsSelect();
  let criterions = build.criterionVariable( exports );

  for( let c in criterions )
  if( !criterions[ c ] )
  delete criterions[ c ];

  let name = _.strJoinPath( [ module.about.name, _.mapKeys( criterions ).join( '-' ), '.out.tgs' ], '.' );

  return hd.path.resolve( module.outPath, name );
}

//

function outFilePathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inExportFile = module.willFileWithRoleMap.export || module.willFileWithRoleMap.single;
  let inFileDirPath = hd.path.dir( inExportFile.filePath )

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( build.name ) );
  _.assert( inExportFile instanceof will.WillFile );
  _.assert( _.strDefined( module.about.name ), 'Module should have name, declare about.name' );

  let name = _.strJoinPath( [ module.about.name, '.out.will.yml' ], '.' );

  return hd.path.resolve( module.outPath, name );
}

// --
// relations
// --

let Composes =
{

  description : null,
  criterion : null,
  steps : null,
  inherit : _.define.own([]),

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

let Proto =
{

  // inter

  form3,

  stepsEach,
  run,
  perform,
  isExport,

  archiveFilePathFor,
  outFilePathFor,

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
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
