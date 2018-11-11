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
  let inf = build.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( build.formed === 2 );

  /* begin */

  build.stepsEach( function( it )
  {
    if( it.concurrent )
    return;
    let kind = it.element.constructor.shortName;
    if( it.element instanceof will.Step )
    {
      _.sure( _.routineIs( it.element.stepRoutine ), kind, it.element.name, 'does not have step routine' );
      _.sure( it.element.formed >= 2, kind, it.element.name, 'was not formed' );
    }
    else if( it.element instanceof will.Build )
    {
      _.sure( it.element.formed >= 2, kind, it.element.name, 'was not formed' );
    }
  });

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
  let inf = build.inf;
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
    step = module.strResolve
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

function exportedDirPathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inDirPath = module.pathMap.in || '.';

  _.assert( arguments.length === 0 );
  _.sure( _.strDefined( build.exportDirPath ), 'Export should have defined path to files {-exportDirPath-}' );

  return hd.path.resolve( module.dirPath, inDirPath, module.strResolve( build.exportDirPath ) );
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
  exportDirPath : null,
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

  exportedDirPathFor : exportedDirPathFor,
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
