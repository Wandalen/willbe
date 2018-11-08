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
    name : 'reflect',
    stepRoutine : will.Predefined.stepRoutineReflect,
    predefined : 1,
    module : module,
  }).form();

  new will.Step
  ({
    name : 'export',
    stepRoutine : will.Predefined.stepRoutineExport,
    predefined : 1,
    module : module,
  }).form();

  new will.Reflector
  ({
    name : 'default.common',
    srcFilter :
    {
      // prefixPath : './proto',
      basePath : '.',
      maskAll :
      {
        excludeAny : [ /(^|\/)-/ ],
      }
    },
    predefined : 1,
    module : module,
  }).form1();

  new will.Reflector
  ({
    name : 'default.debug',
    // inherit : [ 'default.common' ],
    srcFilter :
    {
      // prefixPath : './proto',
      // basePath : '.',
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    predefined : 1,
    module : module,
  }).form1();

  new will.Reflector
  ({
    name : 'default.release',
    // inherit : [ 'default.common' ],
    srcFilter :
    {
      // prefixPath : './proto',
      // basePath : '.',
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    predefined : 1,
    module : module,
  }).form1();

/*
  .default.common :
    srcFilter :
      prefixPath : './proto'
      basePath : '.'
      maskAll :
        excludeAny :
        - !!js/regexp '/(^|\/)-/'

  .default.debug :
    inherit : .default.common
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.release($|\.|\/)/i'

  .default.release :
    inherit : .default.common
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.debug($|\.|\/)/i'
        - !!js/regexp '/\.test($|\.|\/)/i'
        - !!js/regexp '/\.experiment($|\.|\/)/i'
*/

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
  return '.im.will';
  else if( role === 'export' )
  return '.ex.will';
  else if( role === 'single' )
  return '.will';
  else return null;

}

//

function DirPathFromInFilePath( inPath )
{
  let module = this;
  _.assert( arguments.length === 1 );
  let r = /(.*)(?:\.will(?:\.|$).*)/;
  let parsed = r.exec( inPath );

  if( !parsed )
  return r;
  else
  return parsed[ 1 ];
}

//

function _nickNameGet()
{
  let module = this;
  return '{ ' + module.constructor.shortName + ' ' + _.strQuote( module.dirPath ) + ' }';
}

// --
// select
// --

/*
iii : implement name glob filtering
*/

function _select_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o;
  if( args[ 1 ] !== undefined )
  o = { name : args[ 0 ], criterion : args[ 1 ] }
  else
  o = args[ 0 ]

  _.routineOptions( routine, o );
  _.assert( _.arrayHas( [ 'build', 'export' ], o.resource ) );
  _.assert( _.arrayHas( [ 'default', 'more' ], o.preffering ) );
  _.assert( o.criterion === null || _.routineIs( o.criterion ) || _.mapIs( o.criterion ) );

  if( o.preffering === 'default' )
  o.preffering = 'default';

  return o;
}

//

function _select_body( o )
{
  let module = this;
  let elements;

  elements = module.buildMap;

  _.assertRoutineOptions( _select_body, arguments );
  _.assert( arguments.length === 1 );

  if( o.name )
  {
    if( !elements[ o.name ] )
    return []
    elements = [ elements[ o.name ] ];
    if( o.criterion === null || Object.keys( o.criterion ).length === 0 )
    return elements;
  }
  else
  {
    elements = _.mapVals( elements );
  }

  let hasMapFilter = _.objectIs( o.criterion ) && Object.keys( o.criterion ).length > 0;
  if( _.routineIs( o.criterion ) || hasMapFilter )
  {

    _.assert( _.objectIs( o.criterion ), 'not tested' );
    _.assert( !o.name, 'not tested' );

    let filter = o.criterion;

    if( hasMapFilter )
    {

      filter = function filter( build, k, c )
      {
        if( build.criterion === null && Object.keys( o.criterion ).length )
        return;
        let satisfied = _.mapSatisfy
        ({
          template : o.criterion,
          src : build.criterion,
          levels : 1,
        });
        if( satisfied )
        return build;
      }

    }

    // elements = _.mapVals( _.entityFilter( elements, filter ) );
    elements = _.entityFilter( elements, filter );

  }
  else if( _.objectIs( o.criterion ) && Object.keys( o.criterion ).length === 0 && !o.name && o.preffering === 'default' )
  {

    // elements = _.mapVals( _.entityFilter( elements, { default : 1 } ) );
    elements = _.entityFilter( elements, { default : 1 } );

  }

  debugger;

  if( o.resource === 'export' )
  elements = elements.filter( ( element ) => element.criterion && element.criterion.export );
  else if( o.resource === 'build' )
  elements = elements.filter( ( element ) => !element.criterion || !element.criterion.export );

  return elements;
}

_select_body.defaults =
{
  resource : null,
  name : null,
  criterion : null,
  preffering : 'default',
}

let _select = _.routineFromPreAndBody( _select_pre, _select_body );

//

let buildsFor = _.routineFromPreAndBody( _select_pre, _select_body );
var defaults = buildsFor.defaults;
defaults.resource = 'build';

//

let exportsFor = _.routineFromPreAndBody( _select_pre, _select_body );
var defaults = exportsFor.defaults;
defaults.resource = 'export';

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

function _strResolve_pre( routine, args )
{
  let o = args[ 0 ];
  if( _.strIs( o ) )
  o = { subject : o }

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.routineOptions( routine, o );

  return o;
}

//

function _strResolve_body( o )
{
  let module = this;
  let will = module.will;

  let result = module._strResolveMaybe.body.call( module, o );

  if( _.errIs( result ) )
  throw result;

  return result;
}

_strResolve_body.defaults =
{
  context : null,
  subject : null,
  defaultType : null,
  must : 0,
}

let _strResolve = _.routineFromPreAndBody( _strResolve_pre, _strResolve_body );

//

function _strResolveMaybe_body( o )
{
  let module = this;
  let will = module.will;

  if( !o.visited )
  o.visited = [];

  let result = module._strResolveAct( o );

  return result;
}

_strResolveMaybe_body.defaults = Object.create( _strResolve.body.defaults );

let _strResolveMaybe = _.routineFromPreAndBody( _strResolve_pre, _strResolveMaybe_body );

//

function _strResolveAct( o )
{
  let module = this;
  let will = module.will;
  let result;

  _.assertRoutineOptions( _strResolveAct, arguments );
  _.sure( _.strIs( o.subject ), 'Can resolve only string, but got', _.strTypeOf( o.subject ) );

  debugger;
  let splits = module.strSplitShort( o.subject );

  if( !splits[ 0 ] && o.defaultType )
  {
    splits = [ o.defaultType, '::', o.subject ]
  }

  if( !splits[ 0 ] )
  {
    debugger;
    if( o.must )
    return _.ErrorLooking( 'Cant resolve', o.subject );
    else
    return o.subject;

  }

  return module.componentGet( splits[ 0 ], splits[ 2 ] )
}

var defaults = _strResolveAct.defaults = Object.create( _strResolve.defaults )

defaults.visited = null;

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

  let pool = null;

  if( kind === 'path' )
  pool = module.pathMap;
  else if( kind === 'reflector' )
  pool = module.reflectorMap;
  else if( kind === 'submodule' )
  pool = module.submoduleMap;
  else if( kind === 'step' )
  pool = module.stepMap;
  else if( kind === 'build' )
  pool = module.buildMap;

  if( !pool )
  {
    debugger;
    return _.ErrorLooking( 'Unknown type of resource', kind, _.strQuote( name ) );
  }

  if( pool[ name ] )
  result = pool[ name ];
  else
  result = _.entitySelect( pool, name );

  if( result === undefined )
  {
    debugger;
    return _.ErrorLooking( kind, _.strQuote( name ), 'was not found' );
  }

  return result;
}

//

function strSplitShort( srcStr )
{
  let module = this;
  let result = _.strIsolateBeginOrNone( srcStr, '::' );
  return result;
}

//

function strSplitLong( srcStr )
{
  let module = this;
  let splits = _.strSplit( srcStr, '/' );

  debugger; xxx

  let result = []
  for( let s = 0 ; s < splits.length ; s++ )
  {
    let split = splits[ s ];
    if( split === '/' )
    continue;
    result.push( module.strSplitShort( split ) );
  }

  return result;
}

//

function strGetPrefix( srcStr )
{
  let module = this;
  let splits = module.strSplitShort( srcStr );
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
  result += module.infoExportBuilds( module.buildsFor({ preffering : 'more' }) );
  result += module.infoExportExports( module.exportsFor({ preffering : 'more' }) );

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
    if( step.predefined )
    continue;
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

  _.each( builds, ( build ) =>
  {
    result += build.infoExport();
    result += '\n';
  });

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

  _.each( exports, ( exp ) =>
  {
    result += exp.infoExport();
    result += '\n';
  });

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

  result.about = module.about.dataExport();
  result.execution = module.execution.dataExport();

  if( module.exported )
  result.exported = module.exported.dataExport();

  result.path = module.dataExportPaths();
  result.submodule = module.dataExportSubmodules();
  result.reflector = module.dataExportReflectors();
  result.step = module.dataExportSteps();
  result.build = module.dataExportBuilds();

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
//
// function dataExportExports()
// {
//   let module = this;
//   let will = module.will;
//   let result = Object.create( null );
//
//   for( let e in module.exportMap )
//   {
//     let element = module.exportMap[ e ];
//     result[ e ] = element.dataExport();
//   }
//
//   return result;
// }

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
  pathObjMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),

  about : _.define.ownInstanceOf( _.Will.ParagraphAbout ),
  execution : _.define.ownInstanceOf( _.Will.ParagraphExecution ),
  exported : null,

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
  exportMap : 'exportMap',
}

let Accessors =
{
  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Will.ParagraphAbout }) },
  execution : { setter : _.accessor.setter.friend({ name : 'execution', friendName : 'module', maker : _.Will.ParagraphExecution }) },
  exported : { setter : _.accessor.setter.friend({ name : 'exported', friendName : 'module', maker : _.Will.ParagraphExported }) },
  nickName : { getter : _nickNameGet, combining : 'rewrite' },
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

  strSplitShort : strSplitShort,
  strSplitLong : strSplitLong,
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

  // dataExportExports : dataExportExports,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
