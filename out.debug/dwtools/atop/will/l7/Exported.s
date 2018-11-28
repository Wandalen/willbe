( function _Exported_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let Tar;

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillExported( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Exported';

// --
// inter
// --

function exportedReflectorMake( exportSelector )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = exported.build;
  let step = exported.step;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !!build );
  _.assert( module.formed === 3 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( _.objectIs( exported.criterion ) );
  _.assert( step instanceof will.Step );
  _.assert( build instanceof will.Build );
  _.assert( exported.exportedReflector === null );
  _.assert( exported.exportedDirPath === null );

  let exp = step.resolve( exportSelector );
  let result;

  if( exp instanceof will.Reflector )
  {

    _.assert( exp.formed === 3 );
    _.assert( exp.srcFilter.formed === 1 );
    _.sure( !!exp.filePath, () => exp.nickName + ' should have filePath' );

    result = exp.cloneExtending({ name : module.resourceNameAllocate( 'reflector', 'exported' ) });
    result.criterion = _.mapExtend( null, exported.criterion );

    _.assert( result.srcFilter !== exp.srcFilter );
    _.assert( result.srcFilter.prefixPath === null || result.srcFilter.prefixPath === module.inPath );
    result.srcFilter.prefixPath = null;

    let filter2 =
    {
      // maskTransientDirectory : { excludeAny : [ /\.git$/, /node_modules$/ ] },
    }

    result.srcFilter.and( filter2 ).pathsInherit( filter2 );
    result.srcFilter.inFilePath = result.filePath;

  }
  else if( _.arrayIs( exp ) )
  {
    let commonPath = path.common.apply( path, exp );

    _.assert( path.isRelative( commonPath ) );

    result = module.resourceAllocate( 'reflector', 'exported' );
    result.filePath = Object.create( null );
    for( let p = 0 ; p < exp.length ; p++ )
    result.filePath[ exp[ p ] ] = true;

    // result.srcFilter = fileProvider.recordFilter();
    result.srcFilter.basePath = commonPath;
    result.srcFilter.inFilePath = result.filePath;

  }
  else if( _.strIs( exp ) )
  {

    result = module.resourceAllocate( 'reflector', 'exported' );
    result.filePath = { [ exp ] : true };

    // result.srcFilter = fileProvider.recordFilter();
    result.srcFilter.inFilePath = exp;

  }
  else _.assert( 0 );

  result.form();

  exported.exportedReflector = result;

  // _.assert( result.srcFilter.prefixPath === null );
  _.assert( path.isAbsolute( result.srcFilter.prefixPath ) );
  _.assert( result instanceof will.Reflector );

  let exportedReflector = result.dataExport();
  exportedReflector.srcFilter = result.srcFilter.clone();
  // exportedReflector.srcFilter.prefixPath = module.inPath;
  // exportedReflector.srcFilter.prefixPath = path.relative( module.inPath, exportedReflector.srcFilter.prefixPath );
  exportedReflector.srcFilter._formBasePath();

  _.assert( _.mapIs( exportedReflector ) );
  _.assert( exportedReflector.srcFilter.formed === 3 );
  _.assert( _.mapIs( exportedReflector.srcFilter.basePath ) );
  _.sure
  (
    exportedReflector.srcFilter.basePaths.length === 1,
    () => 'Source filter of ' + result.nickName + ' for ' + exportSelector + ' should have single-path reflect map or defined base path'
  );

  /* exportedDirPath */

  let exportedDirPath = exportedReflector.srcFilter.basePaths[ 0 ];

  exported.exportedDirPath = module.resourceAllocate( 'path', 'exportedDir' );
  exported.exportedDirPath.path = path.dot( path.relative( module.dirPath, exportedDirPath ) );
  exported.exportedDirPath.criterion = _.mapExtend( null, exported.criterion );
  exported.exportedDirPath.form();

  return exportedReflector;
}

//

function proceed( frame )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = module.buildMap[ exported.name ];
  let opts = frame.opts
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let step = frame.resource;
  let time = _.timeNow();

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !!build );
  _.assert( module.formed === 3 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( exported.criterion === null );
  _.assert( step instanceof will.Step );
  _.assert( build instanceof will.Build );
  _.assert( _.strDefined( opts.export ), () => step.nickName + ' should have options option export, path to directory to export or reflector' )

  exported.step = step;
  exported.build = build;
  exported.criterion = _.mapExtend( null, build.criterion );
  exported.version = module.about.version;

  let exportedReflector = exported.exportedReflectorMake( opts.export );
  let exportedDirPath = path.s.resolve( module.dirPath, exported.exportedDirPath.path );
  let baseDirPath = build.baseDirPathFor();
  let archiveFilePath = build.archiveFilePathFor();
  let outFilePath = build.outFilePathFor();
  let outDirPath = path.dir( outFilePath );

  _.assert( _.strIs( exportedDirPath ) );
  _.assert( _.mapIs( exportedReflector ) );
  _.assert( exportedReflector.srcFilter.formed === 3 );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( build.criterion ), 'Expects criterion of export' );
  _.sure( _.strDefined( build.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.willFileWithRoleMap.import ) || _.objectIs( module.willFileWithRoleMap.single ), 'Expects import in fine' );
  _.sure( _.objectIs( module.willFileWithRoleMap.export ) || _.objectIs( module.willFileWithRoleMap.single ), 'Expects export in fine' );
  _.sure( _.strDefined( module.about.name ), 'Expects defined name of the module' );
  _.sure( _.strDefined( module.about.version ), 'Expects defined current version of the module' );
  _.sure( hd.fileExists( exportedDirPath ) );
  _.sure( module.pathMap.baseDir === undefined || module.pathMap.baseDir === baseDirPath, 'path::baseDir should not be defined manually' );

  /* begin */

  if( !module.pathMap.baseDir )
  {
    will.PathObj({ module : module, name : 'baseDir', path : baseDirPath }).form();
  }

  /* archiveFilePath */

  if( opts.tar === undefined || opts.tar )
  {
    exported.archiveFilePath = module.resourceAllocate( 'path', 'archiveFile' );
    exported.archiveFilePath.path = path.dot( path.relative( module.dirPath, archiveFilePath ) );
    exported.archiveFilePath.criterion = _.mapExtend( null, exported.criterion );
    exported.archiveFilePath.form();
  }
  else
  {
    exported.archiveFilePath = null;
  }

  /* exportedFilesPath */

  exported.exportedFilesPath = module.resourceAllocate( 'path', 'exportedFiles' );
  exported.exportedFilesPath.criterion = _.mapExtend( null, exported.criterion );

  exported.exportedTerminalsPath = module.resourceAllocate( 'path', 'exportedTerminals' );
  exported.exportedTerminalsPath.criterion = _.mapExtend( null, exported.criterion );

  // debugger;

  let exportedFilesPath = hd.filesFind
  ({
    recursive : '2',
    includingDirs : 1,
    includingTerminals : 1,
    mandatory : 0,
    verbosity : 0,
    outputFormat : 'record',
    // outputFormat : 'relative',
    // filePath : exportedDirPath,
    filter : exportedReflector.srcFilter,
  });

  // debugger;
  let exportedTerminalsPath = exported.exportedTerminalsPath.path = _.filter( exportedFilesPath, ( r ) => r.isTerminal ? r.relative : undefined );
  exportedFilesPath = exported.exportedFilesPath.path = _.filter( exportedFilesPath, ( r ) => r.relative );
  // debugger;

  _.sure
  (
    exported.exportedFilesPath.path.length > 0,
    () => 'No file found at ' + path.commonReport( exportedReflector.srcFilter.stemPath ) + ', cant export ' + opts.export,
  );
  exported.exportedFilesPath.form();

  /* */

  // debugger;
  let exportedFilesReflector = exported.exportedFilesReflector = exported.exportedReflector.cloneExtending({ name : module.resourceNameAllocate( 'reflector', 'exportedFiles' ) });
  // debugger;

  // exportedFilesReflector.srcFilter = exportedFilesReflector.srcFilter || {};
  _.assert( exportedFilesReflector.srcFilter.basePath === exported.exportedDirPath.path || exportedFilesReflector.srcFilter.basePath === null );
  exportedFilesReflector.srcFilter.filteringEmpty();
  _.assert( exportedFilesReflector.srcFilter.basePath === exported.exportedDirPath.path || exportedFilesReflector.srcFilter.basePath === null );
  _.assert( exportedFilesReflector.srcFilter.prefixPath === module.inPath || exportedFilesReflector.srcFilter.prefixPath === null );

  exportedFilesReflector.srcFilter.basePath = '.';
  exportedFilesReflector.srcFilter.prefixPath = exported.exportedDirPath.refName;
  // exportedFilesReflector.srcFilter.prefixPath = '.';

  // exportedFilesReflector.dstFilter = exportedFilesReflector.dstFilter || {};
  _.assert( exportedFilesReflector.dstFilter.basePath === null );
  exportedFilesReflector.dstFilter.filteringEmpty();
  exportedFilesReflector.dstFilter.basePath = '.';

  exportedFilesReflector.filePath = { [ exported.exportedTerminalsPath.refName ] : true }
  exportedFilesReflector.recursive = 0;
  exportedFilesReflector.form();
  debugger;

  /* */

  exported.exportedFilesReflector = exported.exportedFilesReflector.refName;
  exported.exportedReflector = exported.exportedReflector.refName;
  exported.exportedDirPath = exported.exportedDirPath.refName;
  exported.exportedFilesPath = exported.exportedFilesPath.refName;
  if( exported.archiveFilePath )
  exported.archiveFilePath = exported.archiveFilePath.refName;

  /* */

  let data = module.dataExport();

  hd.fileWrite
  ({
    filePath : outFilePath,
    data : data,
    encoding : 'yaml',
  });

  /* */

  if( will.verbosity >= 3 )
  logger.log( ' + ' + 'Write out file to ' + outFilePath );

  if( opts.tar === undefined || opts.tar )
  {

    if( !Tar )
    Tar = require( 'tar' );

    let o2 =
    {
      gzip : true,
      sync : 1,
      file : hd.path.nativize( archiveFilePath ),
      cwd : hd.path.nativize( exportedDirPath ),
    }

    let zip = Tar.create( o2, [ '.' ] );
    if( will.verbosity >= 3 )
    logger.log( ' + ' + 'Write out archive ' + hd.path.moveReport( archiveFilePath, exportedDirPath ) );

  }

  if( will.verbosity >= 3 )
  logger.log( 'Exported', exported.name, 'with', exportedFilesPath.length, 'files', 'in', _.timeSpent( time ) );

  return exported;
}

// --
// relations
// --

let Composes =
{

  version : null,
  description : null,
  criterion : null,
  inherit : _.define.own([]),

  exportedReflector : null,
  exportedFilesReflector : null,

  exportedDirPath : null,
  exportedFilesPath : null,
  exportedTerminalsPath : null,
  archiveFilePath : null,

}

let Aggregates =
{
  name : null,
}

let Associates =
{
  step : null,
  build : null,
  module : null,
}

let Restricts =
{
}

let Statics =
{
  MapName : 'exportedMap',
  PoolName : 'exported',
}

let Forbids =
{
  files : 'files',
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

  exportedReflectorMake : exportedReflectorMake,

  proceed : proceed,

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
