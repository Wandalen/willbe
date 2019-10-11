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

function _verify()
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
  _.assert( exported.step instanceof will.Step );
  _.assert( exported.recursive === 0 || exported.recursive === 1 || exported.recursive === 2 );
  _.assert( exported.withIntegrated === 0 || exported.withIntegrated === 1 || exported.withIntegrated === 2 );
  _.assert( _.boolLike( exported.tar ), 'Expects bool-like {- exported.tar -}' );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( build.criterion ), 'Expects criterion of export' );
  _.sure( _.strDefined( build.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.willfileWithRoleMap.import ) || _.objectIs( module.willfileWithRoleMap.single ), 'Expects import-willfile' );
  _.sure( _.objectIs( module.willfileWithRoleMap.export ) || _.objectIs( module.willfileWithRoleMap.single ), 'Expects export-willfile' );
  _.sure( _.strDefined( module.about.name ), 'Expects defined name of the module as astring' );
  _.sure( _.strDefined( module.about.version ), 'Expects defined version of the module as string' );

}

//

function _performPrepare1( frame )
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let build = module.buildMap[ exported.name ];
  let run = frame.run;
  let opts = frame.resource.opts;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;
  let step = frame.resource;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( opts ) );
  _.assert( _.boolLike( opts.tar ) );
  _.assert( opts.export !== undefined );

  exported.tar = opts.tar;
  exported.step = step;
  exported.build = build;
  exported.criterion = _.mapExtend( null, build.criterion );
  exported.version = module.about.version;

  if( exported.recursive === null )
  exported.recursive = run.recursive;
  if( exported.withIntegrated === null )
  exported.withIntegrated = run.withIntegrated;

  exported.exportPath = opts.export;

  exported._verify();

  return null;
}

//

function _performReform()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  return module.upform({ all : 1, resourcesFormed : 0 });
}

//

function _performSubmodulesPeersOpen()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;

  _.assert( exported.recursive === 0 || exported.recursive === 1 || exported.recursive === 2 );

  return module.submodulesPeersOpen({ throwing : 0, recursive : Math.max( exported.recursive, 1 ) })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

}

//

function _performRecursive()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;

  _.assert( exported.recursive === 0 || exported.recursive === 1 || exported.recursive === 2 );
  _.assert( exported.withIntegrated === 0 || exported.withIntegrated === 1 || exported.withIntegrated === 2 );

  if( !exported.recursive )
  return null;

  return new _.Consequence().take( null )
  .then( () =>
  {
    let con = new _.Consequence().take( null );

    let modules = module.modulesEach
    ({
      recursive : exported.recursive,
      withPeers : 1,
      withStem : 0,
      withOut : 0,
      withIn : 1,
    });

    modules.forEach( ( module2 ) =>
    {

      con.then( () =>
      {
        if( module2.isOut )
        return module2.peerModuleOpen();
        return module2;
      });

      con.then( ( module3 ) =>
      {
        _.assert( !module3.isOut );
        _.assert( module3 === module2 || module3.peerModule === module2 );
        _.assert( module3 === module2 || module3 === module2.peerModule );
        let exports = module3.exportsResolve({ criterion : exported.build.criterion, strictCriterion : 0 });
        if( exports.length !== 1 )
        {
          debugger;
          throw _.err( `Not clear which export to use, found ${exports.length} :\n - ${_.select( exports, '*/absoluteName' ).join( '\n - ' )}` );
        }
        return exports[ 0 ].perform();
      });

      con.finally( ( err, arg ) =>
      {
        if( err )
        throw err;
        return arg;
      });

    });

    return con;
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });
}

//

function _performPrepare2()
{
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let logger = will.logger;

  _.assert
  (
      module.isFull({ all : { resourcesFormed : 0 } }) && module.isValid()
    , `${module.decoratedQualifiedName} is not fully formed to be exported`
  );

  /* */

  if( exported.exportPath === null )
  {

    let exportFiles = module.pathOrReflectorResolve( 'export' );
    if( exportFiles )
    exported.exportPath = exportFiles.qualifiedName;

  }

  /* */

  if( !_.strDefined( exported.exportPath ) )
  throw _.errBrief
  (
    exported.step.decoratedQualifiedName + ' should have defined path or reflector to export. Alternatively module could have defined path::export or reflecotr::export.'
  );

  for( let s in module.submoduleMap )
  {

    let submodule = module.submoduleMap[ s ];
    if( !submodule.opener || !submodule.opener.isOpened() || !submodule.opener.isValid() )
    if( submodule.isMandatory() )
    {
      if( submodule.opener && submodule.opener.error )
      logger.log( submodule.opener.error );
      throw _.errBrief( 'Exporting is impossible because ' + submodule.decoratedAbsoluteName + ' is not downloaded or not valid!' );
    }

    if( submodule.opener.openedModule && !submodule.opener.openedModule.isOut )
    {
      let peerModule = submodule.opener.openedModule.peerModule;
      if( !peerModule || !peerModule.isValid() )
      throw _.errBrief( 'Exporting is impossible because found no out-willfile of ' + submodule.decoratedAbsoluteName + '! Please re-export it, first.' );
    }

  }

  return null;
}

//

function _performReadExported()
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

  let o2 =
  {
    willfilesPath : outFilePath,
    original : module,
    rootModule : module.rootModule,
    searching : 'exact',
    reason : 'export',
  }

  let opener2 = will._openerMake({ opener : o2 })

  opener2.preform();
  opener2.find({ throwing : 0 });

  return opener2.open({ throwing : 1, all : 0 })
  .then( ( module2 ) =>
  {

    _.assert( !!will.formed );

    if( !opener2.openedModule.isValid() )
    {
      logger.log( _.errBrief( `Module ${opener2.absoluteName} was not valid` ) );
      return module2;
    }

    if( !opener2.openedModule.isConsistent() )
    {
      logger.log( _.errBrief( `Module ${opener2.absoluteName} was not consistent, please export it` ) );
      return module2;
    }

    let willfile = opener2.openedModule.willfilesArray[ 0 ];
    let structure = willfile.structureOf( opener2.openedModule );
    _.assert( willfile && opener2.openedModule.willfilesArray.length === 1 );
    _.assert( opener2.openedModule.isValid() );
    _.assert( opener2.openedModule.isOut );
    _.assert( _.mapIs( structure ) );
    _.assert( _.mapIs( structure.exported ) );

    for( let exportedName in structure.exported )
    {
      if( exportedName === exported.name )
      continue;
      let exported2 = opener2.openedModule.exportedMap[ exportedName ];
      _.assert( exported2 instanceof Self );
      module.resourceImport({ srcResource : exported2 });
    }

    return module2;
  })
  .finally( ( err, module2 ) =>
  {

    err = err || opener2.error;

    if( err )
    {
      err = _.err( err, `\nFailed to read exported out-willfile ${opener2.willfilesPath} to extend it` );
      let requireVerbosity = 5;
      if( _.strIs( err.originalMessage ) )
      if( !_.strHas( err.originalMessage, 'Found no willfile at' ) )
      if( !_.strHas( err.originalMessage, 'Found no out-willfile' ) )
      if( !_.strHas( err.originalMessage, 'Out-willfile is inconsistent with its in-willfiles' ) )
      requireVerbosity = 3;
      if( requireVerbosity <= will.verbosity )
      {
        if( !_.errIsLogged( err ) )
        {
          logger.up( 2 );
          logger.log( err );
          logger.down( 2 );
        }
      }
    }

    try
    {
      opener2.finit();
    }
    catch( err2 )
    {
      debugger;
      err2 = _.err( err2 );
      logger.log( _.errOnce( err2 ) );
      throw err2;
    }

    if( err )
    _.errAttend( err );
    return module2 || null;
  })

}

//

function _performExportedReflectors()
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

  _.assert( arguments.length === 0 );
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
  let exp;
  let recursive = null;

  exp = module.pathResolve
  ({
    selector : exported.exportPath,
    currentContext : step,
    pathResolving : 'in',
  });

  /* */

  if( exp instanceof will.Reflector )
  {

    exp.form1();

    _.assert( exp.formed >= 1 );
    _.assert( exp.src.formed === 1 );
    _.sure( !!exp.filePath, () => exp.qualifiedName + ' should have filePath' );

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

    exportedReflector.src.and( filter2 ).pathsSupplementJoining( filter2 );
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
      exportedReflector.src.filePath[ exp[ p ] ] = '';
    }
    exportedReflector.src.basePath = commonPath;

  }
  else if( _.strIs( exp ) )
  {

    if( !path.isGlob( exp ) )
    throw _.errBrief( `Expects glob path to export in export step. ${exported.exportPath} is not glob\n${exp}` );
    _.assert( !_.strHas( exp, '::' ) );
    exportedReflector = module.resourceAllocate( 'reflector', 'exported.' + exported.name );
    exportedReflector.src.filePath = exp;

  }
  else _.assert( 0 );

  if( recursive !== null )
  exportedReflector.src.recursive = recursive;

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
    () => 'Source filter for ' + exported.qualifiedName + ' for ' + exported.exportPath + ' should have single-path reflect map or defined base path'
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

  return null;
}

//

function _performExportedFilesReflector()
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
      // recursive : 2,
      withDirs : 1,
      withTerminals : 1,
      mandatory : 0,
      verbosity : 0,
      outputFormat : 'record',
      filter : exported.srcFilter.clone(),
      maskPreset : 0,
    });

  }
  catch( err )
  {
    throw _.err( err, '\nCant collect files for export' );
  }

  exportedFilesPath = _.filter( exportedFilesPath, ( r ) => r.absolute );

  exported.exportedFilesPath.path = path.s.relative( module.inPath, exportedFilesPath );

  if( exported.exportedFilesPath.path.length === 0 )
  throw _.errBrief
  (
    'No file found at ' + path.commonTextualReport( exported.srcFilter.filePath )
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
  exportedFilesReflector.src.prefixPath = exported.exportedDirPath.qualifiedName;
  exportedFilesReflector.src.filePath = exported.exportedFilesPath.qualifiedName;
  exportedFilesReflector.form1();

  _.assert( exportedFilesReflector.dst.prefixPath === null );
  _.assert( exportedFilesReflector.dst.basePath === null );
  _.assert( _.objectIs( exportedFilesReflector.criterion ) );
  _.assert( !!exportedFilesReflector.src.basePath );
  _.assert( exportedFilesReflector.dst.basePath === null );

  return null;
}

//

function _performPaths()
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
  originalWillFilesPath.path = path.s.relative( module.inPath, _.entityMake( module.willfilesPath ) );
  originalWillFilesPath.criterion.predefined = 1;

  _.assert( !originalWillFilesPath.writable );
  _.assert( !!originalWillFilesPath.exportable );
  _.assert( !originalWillFilesPath.importableFromIn );
  _.assert( !!originalWillFilesPath.importableFromOut );

  return null;
}

//

function _performArchive()
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
  _.assert( arguments.length === 0 );
  _.assert( _.boolLike( exported.tar ) );

  /* archiveFilePath */

  if( !exported.tar )
  {
    exported.archiveFilePath = null;
    return null;
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

  return null;
}

//

function _performWriteOutFile()
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
  let data = module.structureExportForModuleExport({ willfilesPath : outFilePath });

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

  return null;
}

//

function perform( frame )
{
  let time = _.timeNow();
  let exported = this;
  let module = exported.module;
  let will = module.will;
  let con = new _.Consequence().take( null );
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  con.then( () => exported._performPrepare1( frame ) );
  con.then( () => exported._performReform() );
  con.then( () => exported._performSubmodulesPeersOpen() );
  con.then( () => exported._performRecursive() );
  con.then( () => exported._performReadExported() );
  con.then( () => exported._performPrepare2() );
  con.then( () => exported._performExportedReflectors() );
  con.then( () => exported._performExportedFilesReflector() );
  con.then( () => exported._performPaths() );
  con.then( () => exported._performArchive() );
  con.then( () => exported._performWriteOutFile() );

  /* log */

  con.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to export ${exported.decoratedAbsoluteName}` );
    frame.run.exported = exported;
    return arg;
  });

  return con;
}

// --
// relations
// --

let Composes =
{

  version : null,
  recursive : null,
  withIntegrated : null,
  tar : null,

  exportedReflector : null,
  exportedFilesReflector : null,
  exportedDirPath : null,
  exportedFilesPath : null,
  archiveFilePath : null,

}

let Aggregates =
{
  name : null,
  exportPath : null,
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
  exportFiles : 'exportFiles',
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

  _verify,
  _performPrepare1,
  _performReform,
  _performSubmodulesPeersOpen,
  _performRecursive,
  _performPrepare2,
  _performReadExported,
  _performExportedReflectors,
  _performExportedFilesReflector,
  _performPaths,
  _performArchive,
  _performWriteOutFile,

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
