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
  _.assert( Object.keys( module.willFileWithRoleMap ).length === 0 );
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
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  module.dirPath = path.normalize( module.dirPath );

  _.assert( !!module.dirPath );
  _.assert( arguments.length === 0 );
  _.assert( !module.formed );
  _.assert( !!module.will );
  _.assert( will.moduleMap[ module.dirPath ] === undefined );

  /* begin */

  _.arrayAppendOnceStrictly( will.moduleArray, module );
  will.moduleMap[ module.dirPath ] = module

  /* end */

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
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Step
  ({
    name : 'export',
    stepRoutine : will.Predefined.stepRoutineExport,
    module : module,
    criterion :
    {
      predefined : 1,
    }
  }).form();

  new will.Reflector
  ({
    name : 'predefined.common',
    srcFilter :
    {
      // prefixPath : './proto',
      // basePath : '.',
      maskAll :
      {
        excludeAny : [ /(^|\/)-/ ],
      }
    },
    criterion :
    {
      predefined : 1,
    },
    // predefined : 1,
    module : module,
  }).form1();

  new will.Reflector
  ({
    name : 'predefined.debug',
    // inherit : [ 'predefined.common' ],
    srcFilter :
    {
      // prefixPath : './proto',
      // basePath : '.',
      maskAll :
      {
        excludeAny : [ /\.release($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 1,
      predefined : 1,
    },
    // predefined : 1,
    module : module,
  }).form1();

  new will.Reflector
  ({
    name : 'predefined.release',
    // inherit : [ 'predefined.common' ],
    srcFilter :
    {
      // prefixPath : './proto',
      // basePath : '.',
      maskAll :
      {
        excludeAny : [ /\.debug($|\.|\/)/i, /\.test($|\.|\/)/i, /\.experiment($|\.|\/)/i ],
      }
    },
    criterion :
    {
      debug : 0,
      predefined : 1,
    },
    // predefined : 1,
    module : module,
  }).form1();

/*
  .predefined.common :
    srcFilter :
      prefixPath : './proto'
      basePath : '.'
      maskAll :
        excludeAny :
        - !!js/regexp '/(^|\/)-/'

  .predefined.debug :
    inherit : .predefined.common
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.release($|\.|\/)/i'

  .predefined.release :
    inherit : .predefined.common
    srcFilter :
      maskAll :
        excludeAny :
        - !!js/regexp '/\.debug($|\.|\/)/i'
        - !!js/regexp '/\.test($|\.|\/)/i'
        - !!js/regexp '/\.experiment($|\.|\/)/i'
*/

}

// --
// opener
// --

function DirPathFromWillFilePath( inPath )
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

function isOpened()
{
  let module = this;
  return !!_.mapKeys( module.willFileWithRoleMap ).length;
}

//

function willFileLoadMaybe( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( willFileLoadMaybe, arguments );
  _.assert( _.strDefined( o.role ) );

  if( module.willFileWithRoleMap[ o.role ] )
  return null;

  // debugger;

  let filePath;
  if( o.isInFile )
  {
    if( o.isInside )
    {
      let name = module.prefixPathForRole( o.role );
      filePath = path.resolve( module.dirPath, o.dirPath, name );
    }
    else
    {
      let name = _.strJoinPath( [ o.dirPath, module.prefixPathForRole( o.role ) ], '.' );
      filePath = path.resolve( module.dirPath, name );
    }
  }
  else
  {
    let name = _.strJoinPath( [ o.dirPath, '.out', module.prefixPathForRole( o.role ) ], '.' );
    filePath = path.resolve( module.dirPath, name );
    // debugger;
  }

  new will.WillFile
  ({
    role : o.role,
    filePath : filePath,
    module : module,
  }).form1();

  let result = module.willFileWithRoleMap[ o.role ];

  if( result.exists() )
  {
    result.form2();
    // logger.log( ' +', 'will file', filePath, );
    return result;
  }
  else
  {
    result.finit();
    // logger.log( ' -', 'will file', filePath, );
    return null;
  }

}

willFileLoadMaybe.defaults =
{
  role : null,
  dirPath : null,
  isInFile : 1,
  isInside : 1,
}

//

function willFilesLoad( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let loadedOuter = 0;
  let loadedInner = 0;

  o = _.routineOptions( willFilesLoad, arguments );
  _.assert( module.inFileArray.length === 0, 'not tested' );

  /* */

  // debugger;

  loadedOuter = module.willFileLoadMaybe
  ({
    role : 'single',
    dirPath : path.join( '..', path.fullName( module.dirPath ) ),
    isInFile : o.isInFile,
    isInside : 0,
  }) || loadedOuter;

  if( o.isInFile )
  {

    loadedOuter = module.willFileLoadMaybe
    ({
      role : 'import',
      dirPath : path.join( '..', path.fullName( module.dirPath ) ),
      isInFile : o.isInFile,
      isInside : 0,
    }) || loadedOuter;

    loadedOuter = module.willFileLoadMaybe
    ({
      role : 'export',
      dirPath : path.join( '..', path.fullName( module.dirPath ) ),
      isInFile : o.isInFile,
      isInside : 0,
    }) || loadedOuter;

  }

  /* - */

  if( loadedOuter )
  return module;

  loadedInner = module.willFileLoadMaybe
  ({
    role : 'single',
    dirPath : '.',
    isInFile : o.isInFile,
    isInside : 1,
  }) || loadedOuter;

  if( o.isInFile )
  {

    loadedInner = module.willFileLoadMaybe
    ({
      role : 'import',
      dirPath : '.',
      isInFile : o.isInFile,
      isInside : 1,
    }) || loadedOuter;

    loadedInner = module.willFileLoadMaybe
    ({
      role : 'export',
      dirPath : '.',
      isInFile : o.isInFile,
      isInside : 1,
    }) || loadedOuter;

  }

  return module;
}

willFilesLoad.defaults =
{
  isInFile : 1,
}

//

function clean()
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let exps = module.exportsSelect();

  for( let e = 0 ; e < exps.length ; e++ )
  {
    let exp = exps[ e ];
    let archiveFilePath = exp.archiveFilePathFor();
    let outFilePath = exp.outFilePathFor();

    // debugger; xxx

    if( fileProvider.fileExists( archiveFilePath ) )
    fileProvider.fileDelete({ filePath : archiveFilePath, verbosity : 3, throwing : 0 });

    if( fileProvider.fileExists( outFilePath ) )
    fileProvider.fileDelete({ filePath : outFilePath, verbosity : 3, throwing : 0 });

  }

  let temp = module.pathMap.temp ? _.arrayAs( module.pathMap.temp ) : [];
  temp = path.s.resolve( module.dirPath, temp );
  fileProvider.filesDelete({ filePath : temp, verbosity : 2, throwing : 0 });

  // debugger; xxx
}

// --
// etc
// --

function pathAllocate( name, filePath )
{
  let module = this;
  let will = module.will;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( name ) );
  _.assert( _.strIs( filePath ) );

  _.assert( module.pathMap[ name ] === undefined, 'not implemented' );

  let name2 = name + '.0';

  let patho = will.PathObj({ module : module, name : name2, path : filePath }).form1();

  return patho;
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

function _buildsSelect_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o;
  if( args[ 1 ] !== undefined )
  o = { name : args[ 0 ], criterion : args[ 1 ] }
  else
  o = args[ 0 ];

  o = _.routineOptions( routine, o );
  _.assert( _.arrayHas( [ 'build', 'export' ], o.resource ) );
  _.assert( _.arrayHas( [ 'default', 'more' ], o.preffering ) );
  _.assert( o.criterion === null || _.routineIs( o.criterion ) || _.mapIs( o.criterion ) );

  if( o.preffering === 'default' )
  o.preffering = 'default';

  return o;
}

//

function _buildsSelect_body( o )
{
  let module = this;
  let elements;

  elements = module.buildMap;

  _.assertRoutineOptions( _buildsSelect_body, arguments );
  _.assert( arguments.length === 1 );

  // debugger;

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

    elements = filterWith( elements, o.criterion );

    // let filter = o.criterion;
    //
    // if( hasMapFilter )
    // {
    //
    //   filter = function filter( build, k, c )
    //   {
    //     if( build.criterion === null && Object.keys( o.criterion ).length )
    //     return;
    //     let satisfied = _.mapSatisfy
    //     ({
    //       template : o.criterion,
    //       src : build.criterion,
    //       levels : 1,
    //     });
    //     if( satisfied )
    //     return build;
    //   }
    //
    // }
    //
    // // elements = _.mapVals( _.entityFilter( elements, filter ) );
    // elements = _.entityFilter( elements, filter );

  }
  else if( _.objectIs( o.criterion ) && Object.keys( o.criterion ).length === 0 && !o.name && o.preffering === 'default' )
  {

    // elements = _.mapVals( _.entityFilter( elements, { default : 1 } ) );
    // elements = _.entityFilter( elements, { default : 1 } );
    elements = filterWith( elements, { default : 1 } );

  }

  // debugger;

  if( o.resource === 'export' )
  elements = elements.filter( ( element ) => element.criterion && element.criterion.export );
  else if( o.resource === 'build' )
  elements = elements.filter( ( element ) => !element.criterion || !element.criterion.export );

  return elements;

  /* */

  function filterWith( elements, filter )
  {

    _.assert( _.objectIs( filter ), 'not tested' );
    _.assert( !o.name, 'not tested' );

    if( _.objectIs( filter ) && Object.keys( filter ).length > 0 )
    {

      let template = filter;
      filter = function filter( build, k, c )
      {
        if( build.criterion === null && Object.keys( template ).length )
        return;

        let satisfied = _.mapSatisfy
        ({
          template : template,
          src : build.criterion,
          levels : 1,
        });
        if( satisfied )
        return build;
      }

    }

    elements = _.entityFilter( elements, filter );

    return elements;
  }

}

_buildsSelect_body.defaults =
{
  resource : null,
  name : null,
  criterion : null,
  preffering : 'default',
}

let _buildsSelect = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );

//

let buildsSelect = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = buildsSelect.defaults;
defaults.resource = 'build';

//

let exportsSelect = _.routineFromPreAndBody( _buildsSelect_pre, _buildsSelect_body );
var defaults = exportsSelect.defaults;
defaults.resource = 'export';

// --
// resolver
// --

function errResolving( o )
{
  let module = this;
  _.routineOptions( errResolving, arguments );
  if( o.current && o.current.nickName )
  throw _.err( 'Failed to resolve', _.strQuote( o.query ), 'for', o.current.nickName, 'in', module.nickName, '\n', o.err );
  else
  throw _.err( 'Failed to resolve', _.strQuote( o.query ), 'in', module.nickName, '\n', o.err );
}

errResolving.defaults =
{
  err : null,
  current : null,
  query : null,
}

//

function strSplitShort( srcStr )
{
  let module = this;
  _.assert( !_.strHas( srcStr, '/' ) );
  let result = _.strIsolateBeginOrNone( srcStr, '::' );
  return result;
}

//

function _strSplit( o )
{
  let module = this;
  let will = module.will;
  let result;

  _.assertRoutineOptions( _strSplit, arguments );
  _.assert( !_.strHas( o.query, '/' ) );
  _.sure( _.strIs( o.query ), 'Expects string, but got', _.strTypeOf( o.query ) );

  let splits = module.strSplitShort( o.query );

  if( !splits[ 0 ] && o.defaultPool )
  {
    splits = [ o.defaultPool, '::', o.query ]
  }

  return splits;
}

var defaults = _strSplit.defaults = Object.create( null )

defaults.query = null
defaults.defaultPool = null;

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

//

function strIsResolved( srcStr )
{
  return !_.strHas( srcStr, '::' );
}

//

// function _pathResolve( filePath )
// {
//   let module = this;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let result = path.resolve( module.dirPath, filePath );
//   return result;
// }

//

function _strResolve_pre( routine, args )
{
  let o = args[ 0 ];
  if( _.strIs( o ) )
  o = { query : o }

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.routineOptions( routine, o );

  return o;
}

//

function _strResolveMaybe_body( o )
{
  let module = this;
  let will = module.will;

  if( o.currentModule === null )
  o.currentModule = module;

  // if( !o.visited )
  // o.visited = [];

  let result = module._resourceSelect( o );

  if( o.flattening && _.mapIs( result ) )
  debugger;
  if( o.flattening && _.mapIs( result ) )
  result = _.mapsFlatten2([ result ]);

  if( o.unwrappingPath && o.hasPath )
  {
    if( o.query === 'submodule::*/exported::*=1/path::exportedDir*=1' )
    debugger;
    _.assert( _.mapIs( result ) || _.objectIs( result ), 'not implemented' );
    if( _.mapIs( result ) )
    result = _.filter( result, ( e ) => e instanceof will.PathObj ? e.path : e )
    else if( result instanceof will.PathObj )
    result = result.path;
  }

  if( o.unwrappingSingle )
  if( _.mapIs( result ) )
  {
    if( _.mapKeys( result ).length === 1 )
    result = _.mapVals( result )[ 0 ];
  }
  else if( _.arrayIs( result ) )
  {
    if( result.length === 1 )
    result = result[ 0 ];
  }

  if( o.mapVals && _.mapIs( result ) )
  result = _.mapVals( result );

  return result;
}

_strResolveMaybe_body.defaults =
{
  query : null,
  defaultPool : null,
  visited : null,
  current : null,
  currentModule : null,
  unwrappingPath : 1,
  unwrappingSingle : 1,
  mapVals : 1,
  flattening : 0,
  hasPath : null,
}

let _strResolveMaybe = _.routineFromPreAndBody( _strResolve_pre, _strResolveMaybe_body );

//

function _strResolve_body( o )
{
  let module = this;
  let will = module.will;
  let current = o.current;

  let result = module._strResolveMaybe.body.call( module, o );

  if( _.errIs( result ) )
  {
    debugger;
    throw module.errResolving({ query : o.query, current : current, err : result });
  }

  return result;
}

_strResolve_body.defaults = Object.create( _strResolveMaybe.body.defaults );

let _strResolve = _.routineFromPreAndBody( _strResolve_pre, _strResolve_body );

//

function _resourceSelect( o )
{
  let module = this;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result;
  let current = o.current;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _resourceSelect, arguments );
  _.assert( o.currentModule instanceof will.Module );

  // if( _.strHas( o.query, 'reflect.proto' ) )
  // debugger;

  try
  {

    result = _.select
    ({
      container : module,
      query : o.query,
      onUpBegin : onUpBegin,
      onUpEnd : onUpEnd,
      missingAction : 'error',
      _inherited :
      {
        module : o.currentModule,
        exported : null,
      }
    });

  }
  catch( err )
  {
    debugger;
    throw module.errResolving({ query : o.query, current : current, err : err });
  }

  if( result === undefined )
  {
    debugger;
    return _.ErrorLooking( kind, _.strQuote( name ), 'was not found' );
  }

  return result;

  /* */

  function onUpBegin()
  {
    let it = this;

    if( !it.query )
    {
      return;
    }

    if( it.src && it.src instanceof will.Submodule )
    {
      debugger;
      it._inherited.module = it.src.loadedModule;
    }

    if( it.src && it.src instanceof will.Exported )
    {
      debugger;
      it._inherited.exported = it.src;
    }

    queryParse.call( it );

    let kind = it.queryParsed.kind
    if( kind === 'path' && o.hasPath === null )
    o.hasPath = true;

    let pool = it._inherited.module.poolFor( kind );

    if( !pool )
    {
      debugger;
      throw _.ErrorLooking( 'Unknown type of resource, no pool for such resource', _.strQuote( it.queryParsed.full ) );
    }

    it.src = pool;
  }

  /* */

  function onUpEnd()
  {
    let it = this;

    exportedWriteThrough.call( it );
    globCriterionFilter.call( it );
    exportedPathResolve.call( it );

  }

  /* */

  function queryParse()
  {
    let it = this;
    let splits = it._inherited.module._strSplit({ query : it.query, defaultPool : o.defaultPool });

    it.queryParsed = Object.create( null );
    it.queryParsed.full = splits.join( '' );
    it.queryParsed.kind = splits[ 0 ];
    it.query = it.queryParsed.name = splits[ 2 ];

  }

  /* */

  function globCriterionFilter()
  {
    let it = this;

    if( it.down && it.down.isGlob )
    if( o.current && o.current.criterion && it.src && it.src.criterionSattisfy )
    {
      if( !it.src.criterionSattisfy( o.current.criterion ) )
      {
        it.looking = false;
        it.writingDown = false;
      }
    }

  }

  /* */

  function exportedWriteThrough()
  {
    let it = this;

    if( it.down && it.queryParsed && it.queryParsed.kind === 'exported' )
    {
      // debugger;
      let writeToDownOriginal = it.writeToDown;
      it.writeToDown = function writeThrough( eit )
      {
        let r = writeToDownOriginal.apply( this, arguments );

        // debugger;

        eit.key = it.key + '.' + eit.key;

        it.down.writeToDown.apply( it.down, arguments );
        it.writingDown = false;

        // return writeToDownOriginal.apply( this, arguments );

        return r;
      }
    }

  }

  /* */

  function exportedPathResolve()
  {
    let it = this;

    if( !it.query )
    {

      if( it._inherited.exported && it.result && it.result instanceof will.PathObj )
      {
        // debugger;
        let m = it._inherited.module;
        it.result = path.s.join( m.dirPath, it.result.path );
      }

    }

  }

}

var defaults = _resourceSelect.defaults = Object.create( _strResolve.defaults )

defaults.visited = null;

//

function poolFor( kind )
{
  let module = this;
  let pool;

  _.assert( arguments.length === 1 );

  if( !kind || !_.arrayHas( module.KnownPrefixes, kind ) )
  {
    debugger;
    throw _.ErrorLooking( 'Unknown kind of resource, no pool for resource', _.toStrShort( kind ) );
  }

  if( kind === 'path' )
  pool = module.pathObjMap;
  else if( kind === 'reflector' )
  pool = module.reflectorMap;
  else if( kind === 'submodule' )
  pool = module.submoduleMap;
  else if( kind === 'step' )
  pool = module.stepMap;
  else if( kind === 'build' )
  pool = module.buildMap;
  else if( kind === 'exported' )
  pool = module.exportedMap;

  return pool
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

  result += module.infoExportPaths( module.pathMap );
  result += module.infoExportResource( module.reflectorMap );
  result += module.infoExportResource( module.stepMap );
  result += module.infoExportResource( module.buildsSelect({ preffering : 'more' }) );
  result += module.infoExportResource( module.exportsSelect({ preffering : 'more' }) );
  result += module.infoExportResource( module.exportedMap );

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

function infoExportResource( collection )
{
  let module = this;
  let will = module.will;
  let result = '';

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( collection ) || _.arrayIs( collection ) );

  _.each( collection, ( resource, r ) =>
  {
    if( resource.criterion && resource.criterion.predefined )
    return;
    result += resource.infoExport();
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

  result.format = will.WillFile.FormatVersion;
  result.about = module.about.dataExport();
  result.execution = module.execution.dataExport();

  result.path = module.dataExportResource( module.pathObjMap );
  result.submodule = module.dataExportResource( module.submoduleMap );
  result.reflector = module.dataExportResource( module.reflectorMap );
  result.step = module.dataExportResource( module.stepMap );
  result.build = module.dataExportResource( module.buildMap );
  result.exported = module.dataExportResource( module.exportedMap );

  return result;
}

//

function dataExportResource( collection )
{
  let module = this;
  let will = module.will;
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( collection ) || _.arrayIs( collection ) );

  _.each( collection, ( resource, r ) =>
  {
    if( resource.criterion && resource.criterion.predefined )
    return;
    result[ r ] = resource.dataExport();
  });

  return result;
}

// --
// relations
// --

let KnownPrefixes = [ 'submodule', 'step', 'path', 'reflector', 'build', 'about', 'execution', 'exported' ];

let Composes =
{
  dirPath : null,
  verbosity : 0,
}

let Aggregates =
{

  about : _.define.ownInstanceOf( _.Will.ParagraphAbout ),
  execution : _.define.ownInstanceOf( _.Will.ParagraphExecution ),

  submoduleMap : _.define.own({}),
  pathMap : _.define.own({}),
  pathObjMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportedMap : _.define.own({}),

  inFileArray : _.define.own([]),
  willFileWithRoleMap : _.define.own({}),

}

let Associates =
{
  will : null,
  supermodule : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  DirPathFromWillFilePath : DirPathFromWillFilePath,
  KnownPrefixes : KnownPrefixes,
}

let Forbids =
{
  name : 'name',
  exportMap : 'exportMap',
  exported : 'exported',
}

let Accessors =
{
  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Will.ParagraphAbout }) },
  execution : { setter : _.accessor.setter.friend({ name : 'execution', friendName : 'module', maker : _.Will.ParagraphExecution }) },
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

  // opener

  DirPathFromWillFilePath : DirPathFromWillFilePath,
  prefixPathForRole : prefixPathForRole,
  prefixPathForRoleMaybe : prefixPathForRoleMaybe,
  isOpened : isOpened,

  willFileLoadMaybe : willFileLoadMaybe,
  willFilesLoad : willFilesLoad,

  clean : clean,

  // etc

  pathAllocate : pathAllocate,
  _nickNameGet : _nickNameGet,

  // select

  _buildsSelect : _buildsSelect,
  buildsSelect : buildsSelect,
  exportsSelect : exportsSelect,

  // resolver

  errResolving : errResolving,

  strSplitShort : strSplitShort,
  _strSplit : _strSplit,
  strGetPrefix : strGetPrefix,
  strIsResolved : strIsResolved,

  // _pathResolve : _pathResolve,
  // pathResolve : _.routineVectorize_functor( _pathResolve ),

  _strResolve : _strResolve,
  strResolve : _strResolve,
  // strResolve : _.routineVectorize_functor( _strResolve ),

  _strResolveMaybe : _strResolveMaybe,
  strResolveMaybe : _strResolveMaybe,
  // strResolveMaybe : _.routineVectorize_functor( _strResolveMaybe ),

  _resourceSelect : _resourceSelect,
  poolFor : poolFor,

  // exporter

  infoExport : infoExport,
  infoExportPaths : infoExportPaths,
  infoExportResource : infoExportResource,

  dataExport : dataExport,
  dataExportResource : dataExportResource,

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
