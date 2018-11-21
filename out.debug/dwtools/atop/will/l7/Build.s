( function _Build_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
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

  // console.log( 'form3', module.nickName, build.nickName );

  /* begin */

  // build.stepsEach( function( it )
  // {
  //   if( it.concurrent )
  //   return;
  //   let kind = it.element.constructor.shortName;
  //   if( it.element instanceof will.Step )
  //   {
  //     _.sure( _.routineIs( it.element.stepRoutine ), kind, it.element.name, 'does not have step routine' );
  //     _.sure( it.element.formed >= 2, kind, it.element.name, 'was not formed' );
  //   }
  //   else if( it.element instanceof will.Build )
  //   {
  //     _.sure( it.element.formed >= 2, kind, it.element.name, 'was not formed' );
  //   }
  // });

  if( build.criterion && build.criterion.default !== undefined )
  build.criterion.default = build.criterion.default ? 1 : 0;

  /* end */

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

  function inElement( step )
  {
    step = module.resolve
    ({
      query : step,
      defaultPool : 'step',
      current : build,
    });

    _.assert( step instanceof will.Step || step instanceof will.Build, () => 'Cant find step ' + arguments[ 0 ] );
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
  let con = new _.Consequence().give( null );

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!logger );
  _.assert( module.formed === 3 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( resource.formed === 3 );
  _.assert( resource === build );
  _.assert( frame.build === build );

  build.stepsEach( function( it )
  {
    let frame2 = frame.cloneUp( it.element );
    _.assert( frame2.formed === 1 );
    // con.ifNoErrorThen( ( arg ) => it.element.form() );
    con.ifNoErrorThen( ( arg ) => frame2.run() );
    // con.ifNoErrorThen( ( arg ) => it.element.run( frame2 ) );
    con.doThen( ( err, arg ) =>
    {
      frame2.finit();
      if( err )
      throw err;
      return arg;
    });
  });

  return con;
}

//

function proceed( o )
{
  let build = this;
  let module = build.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let isExport = build.isExport();
  let time = _.timeNow();

  let frame = new will.BuildFrame
  ({
    module : module,
    build : build,
    resource : build,
  }).form();

  o = _.routineOptions( build.proceed, arguments );

  logPre();

  return frame.run()
  .doThen( ( err, arg ) =>
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
      logger.log();
      logger.log( isExport ? 'Exporting' : 'Building', build.name );
    }
  }

  /* */

  function logPost()
  {

    if( logger.verbosity >= 2 && !isExport )
    {
      logger.log( ( isExport ? 'Exported' : 'Built' ), build.name, 'in', _.timeSpent( time ) );
      logger.log();
    }
    logger.down();

  }

}

proceed.defaults =
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

function baseDirPathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inDirPath = module.pathMap.in || '.';

  _.assert( arguments.length === 0 );

  // debugger;
  let outDirPath = hd.path.resolve( module.dirPath, module.pathMap.out );
  let baseDirPath = hd.path.relative( outDirPath, module.dirPath );
  // debugger;

  return baseDirPath;
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
  let outDirPath = module.pathMap.out || '.';

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( build.name ) );
  _.assert( inExportFile instanceof will.WillFile );

  // let outDir = module.pathMap.outDir || hd.path.dir( inExportFile.filePath ) || '.';
  let name = _.strJoinPath( [ module.about.name, build.name, '.out.tgs' ], '.' );
  return hd.path.resolve( module.dirPath, outDirPath, name );
  // return hd.path.resolve( inFileDirPath, module.dirPath, outDir, name );
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
  let outDirPath = module.pathMap.out || '.';

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( build.name ) );
  _.assert( inExportFile instanceof will.WillFile );

  let name = _.strJoinPath( [ module.about.name, '.out.will.yml' ], '.' );
  return hd.path.resolve( module.dirPath, outDirPath, name );

  // let outDir = module.pathMap.outDir || hd.path.dir( inExportFile.filePath ) || '.';
  // let name = _.strJoinPath( [ module.about.name, '.out.yml' ], '.' );
  // return hd.path.resolve( module.dirPath, outDir, name );
}


// --
// relations
// --

let Composes =
{

  description : null,
  criterion : null,

  steps : null,
  // exportDirPath : null,
  // entryPath : null,

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
  PoolName : 'build',
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

  form3 : form3,

  stepsEach : stepsEach,
  run : run,
  proceed : proceed,
  isExport : isExport,

  // exportedDirPathFor : exportedDirPathFor,
  baseDirPathFor : baseDirPathFor,
  archiveFilePathFor : archiveFilePathFor,
  outFilePathFor : outFilePathFor,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

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
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
