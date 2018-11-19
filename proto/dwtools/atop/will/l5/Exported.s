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

//

function build( frame )
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
  _.assert( exported.criterion === null );
  _.assert( _.strDefined( opts.export ), () => step.nickName + ' should have options option export, path to directory to export or reflector' )

  debugger;
  // let exportedDirPath = build.exportedDirPathFor();
  let exportedDirPath = frame.resource.inPathResolve( opts.export );
  let baseDirPath = build.baseDirPathFor();
  let archiveFilePath = build.archiveFilePathFor();
  let outFilePath = build.outFilePathFor();
  let outDirPath = path.dir( outFilePath );
  debugger;

  _.assert( _.strIs( exportedDirPath ), 'not implemented' );

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

  exported.criterion = _.mapExtend( null, build.criterion );

  if( !module.pathMap.baseDir )
  {
    will.PathObj({ module : module, name : 'baseDir', path : baseDirPath }).form();
  }

  /* exportedDirPath */

  exported.exportedDirPath = module.pathAllocate( 'exportedDir' );
  exported.exportedDirPath.path = path.dot( path.relative( module.dirPath, exportedDirPath ) );
  exported.exportedDirPath.criterion = _.mapExtend( null, exported.criterion );
  exported.exportedDirPath.form();
  exported.exportedDirPath = exported.exportedDirPath.refName;

  /* archiveFilePath */

  if( exported.criterion.tar === undefined || exported.criterion.tar )
  {
    exported.archiveFilePath = module.pathAllocate( 'archiveFile' );
    exported.archiveFilePath.path = path.dot( path.relative( module.dirPath, archiveFilePath ) );
    exported.archiveFilePath.criterion = _.mapExtend( null, exported.criterion );
    exported.archiveFilePath.form();
    exported.archiveFilePath = exported.archiveFilePath.refName;
  }
  else
  {
    exported.archiveFilePath = null;
  }

  /* exportedFilesPath */

  exported.exportedFilesPath = module.pathAllocate( 'exportedFiles' );
  exported.exportedFilesPath.criterion = _.mapExtend( null, exported.criterion );

  debugger;

  exported.exportedFilesPath.path = hd.filesFind
  ({
    recursive : 1,
    includingDirs : 1,
    includingTerminals : 1,
    outputFormat : 'relative',
    filePath : exportedDirPath,
    filter :
    {
      maskTransientDirectory : { excludeAny : [ /\.git$/, /node_modules$/ ] },
      basePath : exportedDirPath,
    },
  });

  exported.exportedFilesPath.form();
  exported.exportedFilesPath = exported.exportedFilesPath.refName;

  /* */

  exported.version = module.about.version;

  let data = module.dataExport();

  hd.fileWrite
  ({
    filePath : outFilePath,
    data : data,
    encoding : 'yaml',
  });

  /* */

  if( will.verbosity >= 2 )
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
    if( will.verbosity >= 2 )
    logger.log( ' + ' + 'Write out archive ' + hd.path.moveReport( archiveFilePath, exportedDirPath ) );

  }

  return exported;
}

// --
// relations
// --

let Composes =
{

  version : null,

  exportedDirPath : null,
  exportedFilesPath : null,
  archiveFilePath : null,

  description : null,
  criterion : null,

  inherit : _.define.own([]),
  // files : null,

}

let Aggregates =
{
  name : null,
}

let Associates =
{
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

  build : build,

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
