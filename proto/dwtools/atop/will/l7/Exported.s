( function _Exported_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let Tar;

//

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillExported( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Exported';

// --
// inter
// --

function finit()
{
  let exported = this;
  let module = exported.module;

  fieldFinit( 'exportedReflector' );
  fieldFinit( 'exportedFilesReflector' );
  fieldFinit( 'exportedDirPath' );
  fieldFinit( 'exportedFilesPath' );
  fieldFinit( 'archiveFilePath' );

  Parent.prototype.finit.call( exported );

  function fieldFinit( name )
  {
    if( exported[ name ] )
    {
      if( !( exported[ name ] instanceof _.Will.Resource ) )
      exported[ name ] = module.resolveRaw( exported[ name ] );
      if( exported[ name ] instanceof _.Will.Resource )
      if( !_.workpiece.isFinited( exported[ name ] ) )
      exported[ name ].finit();
    }
  }

}

//

function init( o )
{
  let resource = this;

  Parent.prototype.init.apply( resource, arguments );

  return resource;
}

//

function verify()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = module.buildMap[ exported.name ];
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !!build );
  _.assert( module.preformed > 0 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( build instanceof will.Build );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( build.criterion ), 'Expects criterion of export' );
  _.sure( _.strDefined( build.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.willfileWithRoleMap.import ) || _.objectIs( module.willfileWithRoleMap.single ), 'Expects import in fine' );
  _.sure( _.objectIs( module.willfileWithRoleMap.export ) || _.objectIs( module.willfileWithRoleMap.single ), 'Expects export in fine' );
  _.sure( _.strDefined( module.about.name ), 'Expects defined name of the module' );
  _.sure( _.strDefined( module.about.version ), 'Expects defined version of the module' );

  for( let s in module.submoduleMap )
  {
    let submodule = module.submoduleMap[ s ];
    if( !submodule.opener || !submodule.opener.isOpened() || !submodule.opener.isValid() )
    {
      debugger;
      throw _.errBriefly( _.color.strFormat( ' ! ', 'negative' ) + 'Exporting is impossible because ' + submodule.decoratedAbsoluteName + ' is broken!' );
    }
  }

}

//

function readExported()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = module.buildMap[ exported.name ];
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;

  let outFilePath = module.outfilePathGet();
  let opener2 = will.OpenerModule
  ({
    will : will,
    willfilesPath : outFilePath,
    original : module,
    rootModule : module,
  })

  opener2.preform();
  opener2.willfilesPath = outFilePath;
  opener2.finding = 'picked';

  try
  {

    opener2.moduleFind();
    opener2.openedModule.stager.stageStatePausing( 'picked', 0 );
    opener2.openedModule.stager.stageStateSkipping( 'submodulesFormed', 1 );
    opener2.openedModule.stager.stageStateSkipping( 'resourcesFormed', 1 );
    opener2.openedModule.stager.tick();

    let con = opener2.openedModule.ready;
    con
    .thenKeep( ( arg ) =>
    {

      let willfile = opener2.openedModule.willfilesArray[ 0 ];
      _.assert( willfile && opener2.openedModule.willfilesArray.length === 1 );
      if( willfile.data && willfile.data.exported )
      for( let exportedName in willfile.data.exported )
      {
        if( exportedName === exported.name )
        continue;
        let exported2 = opener2.openedModule.exportedMap[ exportedName ];
        _.assert( exported2 instanceof Self );
        module.resourceImport({ srcResource : exported2 });
      }

      return arg;
    })
    .finallyKeep( ( err, arg ) =>
    {
      try
      {
        opener2.openedModule.finit();
      }
      catch( err2 )
      {
        debugger;
        _.errLogOnce( err2 );
      }
      if( err )
      {
        if( opener2.openedModule.stager.stageStatePerformed( 'willfilesFound' ) )
        throw _.errLogOnce( _.errBriefly( err ) );
        else
        {
          _.errAttend( err );
          throw err;
        }
      }
      return arg;
    })
    ;

    let result = con.sync();
    return result;
  }
  catch( err )
  {
    // debugger;
    // _.errLogOnce( err );
  }

}

//

function performExportedReflectors( exportSelector )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = exported.build;
  let step = exported.step;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !!build );
  _.assert( module.preformed > 0 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( _.objectIs( exported.criterion ) );
  _.assert( step instanceof will.Step );
  _.assert( build instanceof will.Build );
  _.assert( exported.exportedReflector === null );
  _.assert( exported.exportedDirPath === null );

  let exportedReflector;
  let exp = module.pathResolve
  ({
    selector : exportSelector,
    currentContext : step,
    pathResolving : 'in',
  });

  /* */

  if( exp instanceof will.Reflector )
  {

    exp.form1();

    _.assert( exp.formed >= 1 );
    _.assert( exp.src.formed === 1 );
    _.sure( !!exp.filePath, () => exp.nickName + ' should have filePath' );

    exportedReflector = exp.cloneExtending
    ({
      name : module.resourceNameAllocate( 'reflector', 'exported.' + exported.name ),
      module : module,
    });

    _.assert( exportedReflector.original === exp.original );
    _.assert( exportedReflector.src !== exp.src );

    exportedReflector.original = null;

    let filter2 =
    {
      // maskTransientDirectory : { excludeAny : [ /\.git$/, /node_modules$/ ] },
    }

    exportedReflector.src.and( filter2 ).pathsInherit( filter2 );
    exportedReflector.src.filePath = exportedReflector.filePath;

  }
  else if( _.arrayIs( exp ) )
  {
    let commonPath = path.common.apply( path, exp );
    if( path.isAbsolute( commonPath ) )
    commonPath = path.relative( module.inPath, commonPath );
    exportedReflector = module.resourceAllocate( 'reflector', 'exported.' + exported.name );
    exportedReflector.src.filePath = Object.create( null );
    for( let p = 0 ; p < exp.length ; p++ )
    {
      _.assert( !_.strHas( exp[ p ], '::' ) );
      exportedReflector.src.filePath[ exp[ p ] ] = true;
    }
    exportedReflector.src.basePath = commonPath;

  }
  else if( _.strIs( exp ) )
  {

    _.assert( !_.strHas( exp, '::' ) );
    exportedReflector = module.resourceAllocate( 'reflector', 'exported.' + exported.name );
    exportedReflector.src.filePath = exp;

  }
  else _.assert( 0 );

  exportedReflector.criterion = _.mapExtend( null, exported.criterion );
  exportedReflector.generated = 1;
  exportedReflector.form();
  exported.exportedReflector = exportedReflector;

  _.assert( exportedReflector.original === null );
  _.assert( module.reflectorMap[ exportedReflector.name ] === exportedReflector );
  _.assert( _.mapIs( exportedReflector.criterion ) );
  _.assert( exportedReflector.dst.prefixPath === null );
  _.assert( exportedReflector.dst.basePath === null );
  _.assert( path.isAbsolute( exportedReflector.src.prefixPath ) );
  _.assert( exportedReflector instanceof will.Reflector );

  /* srcFilter */

  let srcFilter = exported.srcFilter = exportedReflector.src.clone();
  srcFilter._formPaths();

  _.assert( srcFilter.formed === 3 );
  _.assert( _.mapIs( srcFilter.basePath ) );
  _.sure
  (
    srcFilter.basePaths.length === 1,
    () => 'Source filter for ' + exported.nickName + ' for ' + exportSelector + ' should have single-path reflect map or defined base path'
  );

  /* exportedDirPath */

  let exportedDirPath = srcFilter.basePaths[ 0 ];

  if( hd.isTerminal( exportedDirPath ) )
  exportedDirPath = path.dir( exportedDirPath );

  exported.exportedDirPath = module.resourceAllocate( 'path', 'exported.dir.' + exported.name );
  exported.exportedDirPath.generated = 1;
  exported.exportedDirPath.path = path.dot( path.relative( module.inPath, exportedDirPath ) );
  exported.exportedDirPath.criterion = _.mapExtend( null, exported.criterion );
  exported.exportedDirPath.form();

}

//

function performExportedFilesReflector()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;

  /* exportedFilesPath */

  exported.exportedFilesPath = module.resourceAllocate( 'path', 'exported.files.' + exported.name );
  exported.exportedFilesPath.generated = 1;
  exported.exportedFilesPath.criterion = _.mapExtend( null, exported.criterion );

  /* */

  let exportedFilesPath;
  try
  {

    exportedFilesPath = hd.filesFind
    ({
      recursive : 2,
      includingDirs : 1,
      includingTerminals : 1,
      mandatory : 0,
      verbosity : 0,
      outputFormat : 'record',
      filter : exported.srcFilter.clone(),
      maskPreset : 0,
    });

  }
  catch( err )
  {
    throw _.err( 'Cant collect files for export\n', err );
  }

  exportedFilesPath = _.filter( exportedFilesPath, ( r ) => r.absolute );

  exported.exportedFilesPath.path = path.s.relative( module.inPath, exportedFilesPath );

  _.sure
  (
    exported.exportedFilesPath.path.length > 0,
    () => 'No file found at ' + path.commonTextualReport( exported.srcFilter.filePath )
    + ', cant export ' + exported.build.name,
  );

  exported.exportedFilesPath.form();

  /* exportedFilesReflector */

  _.assert( !exported.exportedFilesReflector );

  let exportedFilesReflector = exported.exportedFilesReflector = module.resourceAllocate( 'reflector', 'exported.files.' + exported.name );
  exportedFilesReflector.generated = 1;
  _.mapExtend( exportedFilesReflector.criterion, exported.exportedReflector.criterion );
  exportedFilesReflector.recursive = 0;
  exportedFilesReflector.src.pairWithDst( exportedFilesReflector.dst );
  exportedFilesReflector.src.pairRefineLight();
  exportedFilesReflector.src.basePath = '.';
  exportedFilesReflector.src.prefixPath = exported.exportedDirPath.nickName;
  exportedFilesReflector.src.filePath = exported.exportedFilesPath.nickName;
  exportedFilesReflector.form1();

  _.assert( exportedFilesReflector.dst.prefixPath === null );
  _.assert( exportedFilesReflector.dst.basePath === null );
  _.assert( _.objectIs( exportedFilesReflector.criterion ) );
  _.assert( !!exportedFilesReflector.src.basePath );
  _.assert( exportedFilesReflector.dst.basePath === null );

}

//

function performPaths()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;
  let build = module.buildMap[ exported.name ];

  let originalWillFilesPath = module.resourceObtain( 'path', 'module.original.willfiles' );
  originalWillFilesPath.path = path.s.relative( module.inPath, _.entityShallowClone( module.willfilesPath ) );
  originalWillFilesPath.criterion.predefined = 1;

  _.assert( !originalWillFilesPath.writable );
  _.assert( !!originalWillFilesPath.exportable );
  _.assert( !!originalWillFilesPath.importable );

}

//

function performArchive( enabled )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;
  let build = module.buildMap[ exported.name ];

  _.assert( exported.archiveFilePath === null );
  _.assert( arguments.length === 1 );

  /* archiveFilePath */

  if( !enabled )
  {
    exported.archiveFilePath = null;
    return;
  }

  let archiveFilePath = build.archiveFilePathFor();
  exported.archiveFilePath = module.resourceAllocate( 'path', 'archiveFile.' + exported.name );
  exported.archiveFilePath.path = path.dot( path.relative( module.inPath, archiveFilePath ) );
  exported.archiveFilePath.criterion = _.mapExtend( null, exported.criterion );
  exported.archiveFilePath.form();

  /* */

  if( !Tar )
  Tar = require( 'tar' );

  let exportedDirPath = path.s.resolve( module.inPath, exported.exportedDirPath.path );

  hd.dirMake( path.dir( archiveFilePath ) );

  _.sure( hd.fileExists( exportedDirPath ) );

  let o2 =
  {
    gzip : true,
    sync : 1,
    file : hd.path.nativize( archiveFilePath ),
    cwd : hd.path.nativize( exportedDirPath ),
  }

  let zip = Tar.create( o2, [ '.' ] );
  if( will.verbosity >= 3 )
  logger.log( ' + ' + 'Write out archive ' + hd.path.moveTextualReport( archiveFilePath, exportedDirPath ) );

}

//

function performWriteOutFile()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;
  let build = module.buildMap[ exported.name ];

  /* */

  let outFilePath = module.outfilePathGet();
  let data = module.dataExportForModuleExport({ willfilesPath : outFilePath });

  /* */

  hd.fileWrite
  ({
    filePath : outFilePath,
    data : data,
    encoding : 'yaml',
  });

  /* */

  if( will.verbosity >= 3 )
  logger.log( ' + ' + 'Write out willfile ' + _.color.strFormat( outFilePath, 'path' ) );

}

//

function _perform( frame )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = module.buildMap[ exported.name ];
  let opts = frame.opts
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;
  let step = frame.resource;
  let time = _.timeNow();

  _.assert( arguments.length === 1 );
  _.assert( step instanceof will.Step );
  _.assert( exported.step === null || exported.step === step );
  _.assert( _.strDefined( opts.export ), () => step.nickName + ' should have options option export, path to directory to export or reflector' )
  _.assert( module.stager.stageStatePerformed( 'resourcesFormed' ), 'Resources should be formed' );

  exported.verify();

  exported.step = step;
  exported.build = build;
  exported.criterion = _.mapExtend( null, build.criterion );
  exported.version = module.about.version;

  /* */

  exported.readExported();
  exported.performExportedReflectors( opts.export );
  exported.performExportedFilesReflector();
  exported.performPaths();
  exported.performArchive( opts.tar === undefined || opts.tar );
  exported.performWriteOutFile();

  /* log */

  if( will.verbosity >= 3 )
  logger.log( ' + Exported', exported.decoratedNickName, 'with', exported.exportedFilesPath.path.length, 'files', 'in', _.timeSpent( time ) );

  return exported;
}

//

function perform( frame )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let con = new _.Consequence().take( null );

  _.assert( arguments.length === 1 );

  if( !module.stager.stageStatePerformed( 'resourcesFormed' ) )
  con.then( () => module.stager.stageRerun( 'resourcesFormed' ) )

  con.then( () => exported._perform( frame ) );

  return con;
}

// --
// relations
// --

let Composes =
{

  version : null,

  exportedReflector : null,
  exportedFilesReflector : null,
  exportedDirPath : null,
  exportedFilesPath : null,
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
}

let Restricts =
{
  srcFilter : null,
}

let Medials =
{
}

let Statics =
{
  MapName : 'exportedMap',
  KindName : 'exported',
}

let Forbids =
{
  files : 'files',
  src : 'src',
  originalWillFilesPath : 'originalWillFilesPath',
}

let Accessors =
{
}

// --
// declare
// --

let Extend =
{

  finit,
  init,

  // inter

  verify,
  readExported,
  performExportedReflectors,
  performExportedFilesReflector,
  performPaths,
  performArchive,
  performWriteOutFile,

  _perform,
  perform,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
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
