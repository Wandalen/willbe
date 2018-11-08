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

function _inheritSingle( o )
{
  let build = this;
  let module = build.module;
  let inf = build.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.strIs( o.buildName ) );
  _.assert( arguments.length === 1 );
  _.assert( build.formed === 1 );
  _.assertRoutineOptions( _inheritSingle, arguments );

  let build2 = module.buildMap[ o.buildName ];
  _.sure( _.objectIs( build2 ), () => 'Build ' + _.strQuote( o.buildName ) + ' does not exist' );
  _.assert( !!build2.formed );

  if( build2.formed !== 2 )
  {
    _.sure( !_.arrayHas( o.visited, build2.name ), () => 'Cyclic dependency build ' + _.strQuote( build.name ) + ' of ' + _.strQuote( build2.name ) );
    build2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( build2, _.mapNulls( build ) );
  delete extend.criterion;
  build.copy( extend );

  if( build2.criterion )
  build.criterion = _.mapSupplement( build.criterion || null, build2.criterion );

}

_inheritSingle.defaults=
{
  buildName : null,
  visited : null,
}

//

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

  build.default = build.default ? 1 : 0;

  _.assert( build.default === 0 || build.default === 1 );

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
    step = module.strResolve( step );
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

function exportPathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;

  _.assert( arguments.length === 0 );

  _.sure( _.strDefined( build.filesPath ), 'Export should have defined path to files {-filesPath-}' );

  return hd.path.resolve( module.dirPath, module.strResolve( build.filesPath ) );
}

//

function archivePathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inExportFile = module.inFileWithRoleMap.export || module.inFileWithRoleMap.single;

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( build.name ) );
  _.assert( inExportFile instanceof will.InFile );

  let outDir = module.pathMap.outDir || hd.path.dir( inExportFile.filePath ) || '.';

  return hd.path.resolve( module.dirPath, outDir, module.about.name + build.name + '.out.tgs' );
}

//

function outFilePathFor()
{
  let build = this
  let module = build.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inExportFile = module.inFileWithRoleMap.export || module.inFileWithRoleMap.single;

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( build.name ) );
  _.assert( inExportFile instanceof will.InFile );

  let outDir = module.pathMap.outDir || hd.path.dir( inExportFile.filePath ) || '.';

  return hd.path.resolve( module.dirPath, outDir, module.about.name + build.name + '.out.yml' );
}


// --
// relations
// --

let Composes =
{

  description : null,
  criterion : null,
  steps : null,

  default : null,
  filesPath : null,
  entryPath : null,

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
}

let Forbids =
{
}

let Accessors =
{
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  _inheritSingle : _inheritSingle,

  form3 : form3,

  stepsEach : stepsEach,

  exportPathFor : exportPathFor,
  archivePathFor : archivePathFor,
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
