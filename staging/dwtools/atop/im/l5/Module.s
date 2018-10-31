( function _Module_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillModule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Module';

// --
// inter
// --

function finit()
{
  let module = this;

  if( module.formed )
  module.unform();

  module.about.finit();
  if( module.execution )
  module.execution.finit();
  // if( module.link )
  // module.link.finit();
  if( module.export )
  module.export.finit();

  _.assert( _.instanceIsFinited( module.about ) );
  if( module.execution )
  _.assert( _.instanceIsFinited( module.execution ) );
  // if( module.link )
  // _.assert( _.instanceIsFinited( module.link ) );
  if( module.export )
  _.assert( _.instanceIsFinited( module.export ) );

  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init( o )
{
  let module = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( module );
  Object.preventExtensions( module );

  if( o )
  module.copy( o );

}

//

function unform()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );
  _.assert( !!module.formed );

  /* begin */

  for( let k in module.submoduleMap )
  module.submoduleMap[ k ].finit()
  for( let k in module.reflectorMap )
  module.reflectorMap[ k ].finit()
  for( let k in module.stepMap )
  module.stepMap[ k ].finit()
  for( let k in module.buildMap )
  module.buildMap[ k ].finit()

  _.assert( Object.keys( module.submoduleMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );

  for( let i = module.inFileArray.length-1 ; i >= 0 ; i-- )
  {
    let inf = module.inFileArray[ i ];
    _.assert( Object.keys( inf.submoduleMap ).length === 0 );
    _.assert( Object.keys( inf.reflectorMap ).length === 0 );
    _.assert( Object.keys( inf.stepMap ).length === 0 );
    _.assert( Object.keys( inf.buildMap ).length === 0 );
    inf.finit()
  }

  _.assert( module.inFileArray.length === 0 );
  _.assert( Object.keys( module.inFileWithRoleMap ).length === 0 );
  _.assert( will.moduleMap[ module.dirPath ] === module );

  _.arrayRemoveElementOnceStrictly( will.moduleArray, module );
  delete will.moduleMap[ module.dirPath ];

  /* end */

  module.formed = 0;
  return module;
}

//

function form()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );

  module.form1();
  module.form2();

  return module;
}

//

function form1()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );
  _.assert( !module.formed );
  _.assert( !!module.will );
  _.assert( will.moduleMap[ module.dirPath ] === undefined );

  /* begin */

  _.arrayAppendOnceStrictly( will.moduleArray, module );
  will.moduleMap[ module.dirPath ] = module

  /* end */

  _.assert( !!module.dirPath );

  module.formed = 1;
  return module;
}

//

function form2()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );
  _.assert( module.formed === 1 );
  _.assert( !!module.will );
  _.assert( will.moduleMap[ module.dirPath ] === module );
  _.assert( !!module.dirPath );

  /* begin */

  module.predefinedForm();

  /* end */

  module.formed = 2;
  return module;
}

//

function predefinedForm()
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 0 );

  new will.Step
  ({
    name : 'grab',
    stepRoutine : will.Step.StepRoutineGrab,
    predefined : 1,
    module : module,
  }).form1();

}

// --
// etc
// --

function inFilesLoad( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( inFilesLoad, arguments );
  _.assert( module.inFileArray.length === 0, 'not tested' );

  /* */

  if( !module.inFileWithRoleMap.single )
  {

    new will.InFile
    ({
      role : 'single',
      module : module,
      filePath : path.resolve( module.dirPath, module.prefixPathForRole( 'single' )  ),
    }).form1();

    if( module.inFileWithRoleMap.single.exists() )
    module.inFileWithRoleMap.single.form2();
    else
    module.inFileWithRoleMap.single.finit();

  }

  if( !module.inFileWithRoleMap.single )
  {

    new will.InFile
    ({
      role : 'single',
      module : module,
      filePath : path.resolve( module.dirPath, '..', path.fullName( module.dirPath ) + module.prefixPathForRole( 'single' ) ),
    }).form1();

    if( module.inFileWithRoleMap.single.exists() )
    module.inFileWithRoleMap.single.form2();
    else
    module.inFileWithRoleMap.single.finit();

  }

  /* */

  if( !module.inFileWithRoleMap.import )
  {
    new will.InFile
    ({
      role : 'import',
      module : module,
      filePath : path.resolve( module.dirPath, module.prefixPathForRole( 'import' )  ),
    }).form1();

    if( module.inFileWithRoleMap.import.exists() )
    module.inFileWithRoleMap.import.form2();
    else
    module.inFileWithRoleMap.import.finit();

  }

  if( !module.inFileWithRoleMap.import )
  {

    new will.InFile
    ({
      role : 'import',
      module : module,
      filePath : path.resolve( module.dirPath, '..', path.fullName( module.dirPath ) + module.prefixPathForRole( 'import' ) ),
    }).form1();

    if( module.inFileWithRoleMap.import.exists() )
    module.inFileWithRoleMap.import.form2();
    else
    module.inFileWithRoleMap.import.finit();

  }

  /* */

  if( !module.inFileWithRoleMap.export )
  {

    new will.InFile
    ({
      role : 'export',
      module : module,
      filePath : path.resolve( module.dirPath, module.prefixPathForRole( 'export' )  ),
    }).form1();

    if( module.inFileWithRoleMap.export.exists() )
    module.inFileWithRoleMap.export.form2();
    else
    module.inFileWithRoleMap.export.finit();

  }

  if( !module.inFileWithRoleMap.export )
  {

    new will.InFile
    ({
      role : 'export',
      module : module,
      filePath : path.resolve( module.dirPath, '..', path.fullName( module.dirPath ) + module.prefixPathForRole( 'export' ) ),
    }).form1();

    if( module.inFileWithRoleMap.export.exists() )
    module.inFileWithRoleMap.export.form2();
    else
    module.inFileWithRoleMap.export.finit();

  }

  // _.sure( module.inFileArray.length > 0, 'Found no will file at', _.strQuote( module.dirPath ) );

  return module;
}

inFilesLoad.defaults =
{
}

//

function prefixPathForRole( role )
{
  let module = this;
  let result = module.prefixPathForRoleMaybe( role );

  _.assert( arguments.length === 1 );
  _.sure( _.strIs( result ), 'Unknown role', _.strQuote( role ) );

  return result;
}

//

function prefixPathForRoleMaybe( role )
{
  let module = this;

  _.assert( arguments.length === 1 );

  if( role === 'import' )
  return '.im.in';
  else if( role === 'export' )
  return '.ex.in';
  else if( role === 'single' )
  return '.in';
  else return null;

}

//

function DirPathFromInFilePath( inPath )
{
  let module = this;
  _.assert( arguments.length === 1 );
  let r = /(.*)(?:\.in(?:\.|$).*)/;
  let parsed = r.exec( inPath );

  if( !parsed )
  return r;
  else
  return parsed[ 1 ];
}

// --
// select
// --

/*
iii : implement name glob filtering
*/

function _select( o )
{
  let module = this;
  let elements;

  if( o.resource === 'build' )
  elements = module.buildMap;
  else if( o.resource === 'export' )
  elements = module.exportMap;
  else _.assert( 0, 'Unknown kind of resource', _.strQuote( o.resource ) );

  _.routineOptions( _select, arguments );
  _.assert( arguments.length === 1 );
  _.assert( o.filter === null || _.routineIs( o.filter ) || _.mapIs( o.filter ) );

  if( o.name )
  {
    if( !elements[ o.name ] )
    return []
    elements = [ elements[ o.name ] ];
    if( o.filter === null || Object.keys( o.filter ).length === 0 )
    return elements;
  }

  let hasMapFilter = _.objectIs( o.filter ) && Object.keys( o.filter ).length > 0;
  if( _.routineIs( o.filter ) || hasMapFilter )
  {

    _.assert( _.objectIs( o.filter ), 'not tested' );
    _.assert( !o.name, 'not tested' );

    let filter = o.filter;

    if( hasMapFilter )
    {

      filter = function filter( build, k, c )
      {
        if( build.settings === null && Object.keys( o.filter ).length )
        return;
        let satisfied = _.mapSatisfy
        ({
          template : o.filter,
          src : build.settings,
          levels : 1,
        });
        if( satisfied )
        return build;
      }

    }

    elements = _.mapVals( _.entityFilter( elements, filter ) );

  }
  else if( _.objectIs( o.filter ) && Object.keys( o.filter ).length === 0 && !o.name )
  {

    elements = _.mapVals( _.entityFilter( elements, { default : 1 } ) );

  }

  return elements;
}

_select.defaults =
{
  resource : null,
  name : null,
  filter : null,
}

//

/*
iii : implement name glob filtering
*/

function buildsFor( name, filter )
{
  let module = this;

  _.assert( arguments.length === 2 );

  return module._select
  ({
    resource : 'build',
    name : name,
    filter : filter,
  })

  // debugger;
  //
  // if( name )
  // {
  //   if( !builds[ name ] )
  //   return []
  //   builds = [ builds[ name ] ];
  //   if( filter === null || Object.keys( filter ).length === 0 )
  //   return builds;
  // }
  //
  // let hasMapFilter = _.objectIs( filter ) && Object.keys( filter ).length > 0;
  // if( _.routineIs( filter ) || hasMapFilter )
  // {
  //
  //   _.assert( _.objectIs( filter ), 'not tested' );
  //   _.assert( !name, 'not tested' );
  //
  //   if( hasMapFilter )
  //   {
  //
  //     let ofilter = filter;
  //     filter = function filter( build, k, c )
  //     {
  //       if( build.settings === null && Object.keys( filter ).length )
  //       return;
  //       let satisfied = _.mapSatisfy
  //       ({
  //         template : ofilter,
  //         src : build.settings,
  //         levels : 1,
  //       });
  //       if( satisfied )
  //       return build;
  //     }
  //
  //   }
  //
  //   builds = _.mapVals( _.entityFilter( builds, filter ) );
  //
  // }
  // else if( _.objectIs( filter ) && Object.keys( filter ).length === 0 && !name )
  // {
  //
  //   _.assert( !name, 'not tested' );
  //
  //   filter = { default : 1 };
  //   builds = _.mapVals( _.entityFilter( builds, filter ) );
  //
  // }
  //
  // return builds;
}

//

/*
iii : implement name glob filtering
*/

function exportsFor( name, filter )
{
  let module = this;

  _.assert( arguments.length === 2 );

  return module._select
  ({
    resource : 'export',
    name : name,
    filter : filter,
  })

  // let module = this;
  //
  // _.assert( arguments.length === 2 );
  //
  // if( name )
  // {
  //   if( module.exportMap[ name ] )
  //   return [ module.exportMap[ name ] ];
  //   return [];
  // }
  //
  // if( !_.routineIs( filter ) )
  // {
  //
  //   let ofilter = filter;
  //   filter = function filter( exp, k, c )
  //   {
  //     if( exp.settings === null && Object.keys( filter ).length )
  //     return;
  //     let satisfied = _.mapSatisfy
  //     ({
  //       template : ofilter,
  //       src : exp.settings,
  //       levels : 1,
  //     });
  //     if( satisfied )
  //     return exp;
  //   }
  //
  // }
  //
  // let exports = _.mapVals( _.entityFilter( module.exportMap, filter ) );
  //
  // return exports;
}

// --
// resolver
// --

function _pathResolve( filePath )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = path.resolve( module.dirPath, filePath );
  return result;
}

//

function _strResolve( srcStr )
{
  let module = this;
  let will = module.will;

  let result = module._strResolveMaybe( srcStr );

  if( _.errIs( result ) )
  throw result;

  return result;
}

//

function _strResolveMaybe( srcStr )
{
  let module = this;
  let will = module.will;

  let result = module._strResolveAct
  ({
    src : srcStr,
    visited : [],
  });

  return result;
}

//

function _strResolveAct( o )
{
  let module = this;
  let will = module.will;
  let result;

  _.assertRoutineOptions( _strResolveAct, arguments );

  let splits = module.StrSplit( o.src );

  if( !splits[ 0 ] )
  return o.src;

  return module.componentGet( splits[ 0 ], splits[ 2 ] )
}

_strResolveAct.defaults =
{
  src : null,
  visited : null,
}

//

function componentGet( kind, name )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( kind ) );
  _.assert( _.strIs( name ) );

  if( !kind || !_.arrayHas( module.KnownPrefixes, kind ) )
  return o.src;

  if( kind === 'path' )
  {
    result = module.pathMap[ name ];
    // result = path.s.resolve( module.dirPath, result );
  }
  else if( kind === 'reflector' )
  result = module.reflectorMap[ name ];
  else if( kind === 'submodule' )
  result = module.submoduleMap[ name ];
  else if( kind === 'step' )
  result = module.stepMap[ name ];
  else if( kind === 'build' )
  result = module.buildMap[ name ];

  if( result === undefined )
  {
    debugger;
    result = _.err( kind, _.strQuote( name ), 'was not found' );
  }

  return result;
}

//

function StrSplit( srcStr )
{
  let module = this;
  let splits = _.strIsolateBeginOrNone( srcStr, ':' );
  return splits;
}

//

function strGetPrefix( srcStr )
{
  let module = this;
  let splits = module.StrSplit( srcStr );
  if( !splits[ 0 ] )
  return false;
  if( !_.arrayHas( module.KnownPrefixes, splits[ 0 ] ) )
  return false;
  return splits[ 0 ];
}

// --
// exporter
// --

function infoExport()
{
  let module = this;
  let will = module.will;
  let result = '';

  result += module.about.infoExport();
  result += module.execution.infoExport();
  // result += module.link.infoExport();

  result += module.infoExportPaths( module.pathMap );
  result += module.infoExportReflectors( module.reflectorMap );
  result += module.infoExportSteps( module.stepMap );
  result += module.infoExportBuilds( module.buildMap );
  result += module.infoExportExports( module.exportMap );

  return result;
}

//

function infoExportPaths( paths )
{
  let module = this;
  paths = paths || module.pathMap;
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !Object.keys( paths ).length )
  return '';

  return 'Paths\n' + _.toStr( paths, { wrap : 0, multiline : 1, levels : 2 } ) + '\n\n';
}

//

function infoExportReflectors( reflectors )
{
  let module = this;
  let will = module.will;
  let result = '';
  reflectors = reflectors || module.reflectorMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let b in reflectors )
  {
    let reflector = reflectors[ b ];
    result += reflector.infoExport();
    result += '\n';
  }

  return result;
}

//

function infoExportSteps( steps )
{
  let module = this;
  let will = module.will;
  let result = '';
  steps = steps || module.stepMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let b in steps )
  {
    let step = steps[ b ];
    result += step.infoExport();
    result += '\n';
  }

  return result;
}

//

function infoExportBuilds( builds )
{
  let module = this;
  let will = module.will;
  let result = '';
  builds = builds || module.buildMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let b in builds )
  {
    let build = builds[ b ];
    result += build.infoExport();
    result += '\n';
  }

  return result;
}

//

function infoExportExports( exports )
{
  let module = this;
  let will = module.will;
  let result = '';
  exports = exports || module.buildMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let e in exports )
  {
    let exp = exports[ e ];
    result += exp.infoExport();
    result += '\n';
  }

  return result;
}

//

function dataExport()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = Object.create( null );

  result.path = module.dataExportPaths();
  result.submodule = module.dataExportSubmodules();
  result.reflector = module.dataExportReflectors();
  result.step = module.dataExportSteps();
  result.build = module.dataExportBuilds();
  result.export = module.dataExportExports();

  result.about = module.about.dataExport();
  result.execution = module.execution.dataExport();

  return result;
}

//

function dataExportPaths()
{
  let module = this;
  let will = module.will;
  return _.mapExtend( null, module.pathMap );
}

//

function dataExportSubmodules()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  for( let e in module.submoduleMap )
  {
    let element = module.submoduleMap[ e ];
    result[ e ] = element.dataExport();
  }

  return result;
}

//

function dataExportReflectors()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  for( let e in module.reflectorMap )
  {
    let element = module.reflectorMap[ e ];
    result[ e ] = element.dataExport();
  }

  return result;
}

//

function dataExportSteps()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  for( let e in module.stepMap )
  {
    let element = module.stepMap[ e ];
    if( element.predefined )
    continue;
    result[ e ] = element.dataExport();
  }

  return result;
}

//

function dataExportBuilds()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  for( let e in module.buildMap )
  {
    let element = module.buildMap[ e ];
    result[ e ] = element.dataExport();
  }

  return result;
}

//

function dataExportExports()
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  for( let e in module.exportMap )
  {
    let element = module.exportMap[ e ];
    result[ e ] = element.dataExport();
  }

  return result;
}

// --
// relations
// --

let KnownPrefixes = [ 'submodule', 'step', 'path', 'reflector', 'build', 'about', 'execution', 'export' ];

let Composes =
{
  dirPath : null,
  verbosity : 0,
}

let Aggregates =
{

  inFileArray : _.define.own([]),
  inFileWithRoleMap : _.define.own({}),

  submoduleMap : _.define.own({}),
  pathMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportMap : _.define.own({}),

  about : _.define.ownInstanceOf( _.Will.ParagraphAbout ),
  execution : _.define.ownInstanceOf( _.Will.ParagraphExecution ),
  generated : null,

}

let Associates =
{
  will : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  DirPathFromInFilePath : DirPathFromInFilePath,
  KnownPrefixes : KnownPrefixes,
}

let Forbids =
{
  name : 'name',
}

let Accessor =
{
  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Will.ParagraphAbout }) },
  execution : { setter : _.accessor.setter.friend({ name : 'execution', friendName : 'module', maker : _.Will.ParagraphExecution }) },
  generated : { setter : _.accessor.setter.friend({ name : 'generated', friendName : 'module', maker : _.Will.ParagraphGenerated }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  finit : finit,
  init : init,
  unform : unform,
  form : form,
  form1 : form1,
  form2 : form2,
  predefinedForm : predefinedForm,

  // etc

  inFilesLoad : inFilesLoad,
  prefixPathForRole : prefixPathForRole,
  prefixPathForRoleMaybe : prefixPathForRoleMaybe,
  DirPathFromInFilePath : DirPathFromInFilePath,

  // select

  _select : _select,
  buildsFor : buildsFor,
  exportsFor : exportsFor,

  // resolver

  _pathResolve : _pathResolve,
  pathResolve : _.routineVectorize_functor( _pathResolve ),

  _strResolve : _strResolve,
  strResolve : _.routineVectorize_functor( _strResolve ),

  _strResolveMaybe : _strResolveMaybe,
  strResolveMaybe : _.routineVectorize_functor( _strResolveMaybe ),

  _strResolveAct : _strResolveAct,
  componentGet : componentGet,

  StrSplit : StrSplit,
  strGetPrefix : strGetPrefix,

  // exporter

  infoExport : infoExport,
  infoExportPaths : infoExportPaths,
  infoExportReflectors : infoExportReflectors,
  infoExportSteps : infoExportSteps,
  infoExportBuilds : infoExportBuilds,
  infoExportExports : infoExportExports,

  dataExport : dataExport,
  dataExportPaths : dataExportPaths,
  dataExportSubmodules : dataExportSubmodules,
  dataExportReflectors : dataExportReflectors,
  dataExportSteps : dataExportSteps,
  dataExportBuilds : dataExportBuilds,
  dataExportExports : dataExportExports,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

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
