( function _Exported_s_()
{

'use strict';

/**
 * @classdesc Class wWillExported provides interface for work with exported resources.
 * @class wWillExported
 * @module Tools/atop/willbe
 */

let Tar;

//

const _ = _global_.wTools;
const Parent = _.will.Resource;
const Self = wWillExported;
function wWillExported( o )
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
      if( !( exported[ name ] instanceof _.will.Resource ) )
      exported[ name ] = module.resolveRaw( exported[ name ] );
      if( exported[ name ] instanceof _.will.Resource )
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

function form1()
{
  let resource = this;

  Parent.prototype.form1.apply( resource, arguments );

  if( !resource.inModule )
  resource.inModule = resource.outModule.peerModule;
  if( !resource.outModule )
  resource.outModule = resource.inModule.peerModule;

  _.assert( !resource.inModule || !resource.inModule.isOut );
  _.assert( resource.outModule && resource.outModule.isOut );

  return resource;
}

//

function form2()
{
  let resource = this;

  if( resource.formed >= 2 )
  return resource;

  Parent.prototype.form2.apply( resource, arguments );

  let fieldNames =
  {
    exportedReflector : null,
    exportedFilesReflector : null,
    exportedDirPath : null,
    exportedFilesPath : null,
    archiveFilePath : null,
  }

  for( let f in fieldNames )
  {
    let field = resource[ f ];
    if( _.strIs( field ) || _.arrayIs( field ) )
    resource[ f ] = resource.resolve
    ({
      selector : field,
      pathUnwrapping : 0,
    });
  }

  return resource;
}

// --
// etc
// --

function inModuleSet( src )
{
  let exported = this;
  _.assert( !src || !src.isOut );
  exported[ inModuleSymbol ] = src;
  return src;
}

//

function inModuleGet()
{
  let exported = this;
  return exported[ inModuleSymbol ];
}

//

function outModuleSet( src )
{
  let exported = this;
  _.assert( !src || src.isOut );
  exported[ moduleSymbol ] = src;
  return src;
}

//

function outModuleGet()
{
  let exported = this;
  return exported[ moduleSymbol ];
}

//

function moduleSet( src )
{
  let exported = this;

  if( src && !src.isOut )
  {
    exported.inModule = src;
    return src;
  }

  _.assert( !src || src.isOut );
  exported[ moduleSymbol ] = src;
  return src;
}

//

function moduleGet()
{
  let exported = this;
  return exported[ moduleSymbol ];
}

// --
// perform
// --

function _verify()
{
  let exported = this;
  let inModule = exported.inModule;
  let will = inModule.will;
  let build = inModule.buildMap[ exported.name ];
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;

  _.assert( exported.inModule && !exported.inModule.isOut );
  _.assert( exported.outModule && exported.outModule.isOut );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!inModule );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !!build );
  _.assert( inModule.preformed > 0 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( build instanceof _.will.Build );
  _.assert( exported.step instanceof _.will.Step );
  _.assert( exported.recursive === 0 || exported.recursive === 1 || exported.recursive === 2 );
  _.assert( exported.withIntegrated === 0 || exported.withIntegrated === 1 || exported.withIntegrated === 2 );
  _.assert( _.boolLike( exported.tar ), 'Expects bool-like {- exported.tar -}' );

  _.sure( _.strDefined( inModule.dirPath ), 'Expects directory path of the inModule' );
  _.sure( _.object.isBasic( build.criterion ), 'Expects criterion of export' );
  _.sure( _.strDefined( build.name ), 'Expects name of export' );
  _.sure( _.object.isBasic( inModule.willfileWithRoleMap.import ) || _.object.isBasic( inModule.willfileWithRoleMap.single ), 'Expects import-willfile' );
  _.sure( _.object.isBasic( inModule.willfileWithRoleMap.export ) || _.object.isBasic( inModule.willfileWithRoleMap.single ), 'Expects export-willfile' );
  _.sure( _.strDefined( inModule.about.name ), 'Expects defined name of the inModule as astring' );
  // _.sure( _.strDefined( inModule.about.version ), 'Expects defined version of the inModule as string' );

}

//

function _performPrepare1( frame )
{
  let exported = this;
  let inModule = exported.inModule;
  let will = inModule.will;
  let build = inModule.buildMap[ exported.name ];
  let run = frame.run;
  let opts = frame.resource.opts;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let step = frame.resource;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( opts ) );
  _.assert( _.boolLike( opts.tar ) );
  _.assert( opts.export !== undefined );

  exported.tar = opts.tar;
  exported.step = step;
  exported.build = build;
  exported.criterion = _.props.extend( null, build.criterion );
  exported.version = inModule.about.version || '0.0.0';

  if( exported.recursive === null ) /* xxx : remove maybe */
  exported.recursive = run.recursive;
  if( exported.withIntegrated === null ) /* xxx : remove maybe */
  exported.withIntegrated = run.withIntegrated;

  exported.exportPath = opts.export;

  exported._verify();

  return null;
}

//

function _performOutModule( frame )
{
  let exported = this;
  let inModule = exported.inModule;
  let will = inModule.will;
  let build = inModule.buildMap[ exported.name ];
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let outFilePath = inModule.outfilePathGet();

  if( exported.outModule )
  {
    _.assert( exported.outModule.isValid() );
    return null;
  }

  exported.outModule = inModule.outModuleMake({ willfilesPath : outFilePath });
  return null;
}

//

function _performReform()
{
  let exported = this;
  let inModule = exported.inModule;
  let will = inModule.will;
  return inModule.upform({ all : 1, resourcesFormed : 0 });
}

//

function _performSubmodulesPeersOpen()
{
  let exported = this;
  let outModule = exported.outModule;
  let will = outModule.will;

  _.assert( exported.recursive === 0 || exported.recursive === 1 || exported.recursive === 2 );

  return outModule.submodulesPeersOpen({ throwing : 0, recursive : Math.max( exported.recursive, 1 ) })
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
  let outModule = exported.outModule;
  let will = outModule.will;

  _.assert( exported.recursive === 0 || exported.recursive === 1 || exported.recursive === 2 );
  _.assert( exported.withIntegrated === 0 || exported.withIntegrated === 1 || exported.withIntegrated === 2 );

  if( !exported.recursive )
  return null;

  return _.take( null )
  .then( () =>
  {
    let con = _.take( null );

    let modules = outModule.modulesEach
    ({
      recursive : exported.recursive,
      withPeers : true,
      withStem : false,
      withOut : false,
      withIn : true,
    });

    modules.forEach( ( module2 ) =>
    {

      _.assert( module2 instanceof _.will.Module );

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
  let inModule = exported.inModule;
  let outModule = exported.outModule;
  let will = outModule.will;
  let logger = will.transaction.logger;

  _.assert
  (
    inModule.isFull({ only : { resourcesFormed : 0 } }) && inModule.isValid(),
    `${inModule.decoratedQualifiedName} is not fully formed to be exported`
  );

  _.assert
  (
    outModule.isValid(),
    `${outModule.decoratedQualifiedName} is not fully formed to be exported`
  );

  /* */

  if( exported.exportPath === null )
  {

    let exportFiles = outModule.pathOrReflectorResolve( 'export' );
    if( exportFiles )
    exported.exportPath = exportFiles.qualifiedName;

  }

  /* */

  if( !_.strDefined( exported.exportPath ) )
  throw _.errBrief
  (
    exported.step.decoratedQualifiedName + ' should have defined path or reflector to export. Alternatively module could have defined path::export or reflecotr::export.'
  );

  for( let s in outModule.submoduleMap )
  {

    let submodule = outModule.submoduleMap[ s ];
    if( !submodule.opener || !submodule.opener.isOpened() || !submodule.opener.isValid() )
    if( submodule.isMandatory() )
    {
      if( submodule.opener && submodule.opener.error )
      logger.log( submodule.opener.error );
      debugger;
      throw _.errBrief( 'Exporting is impossible because ' + submodule.decoratedAbsoluteName + ' is not downloaded or not valid!' );
    }

    if( submodule.opener.openedModule && !submodule.opener.openedModule.isOut )
    {
      let peerModule = submodule.opener.openedModule.peerModule;
      if( !peerModule || !peerModule.isValid() )
      {
        debugger;
        throw _.errBrief( 'Exporting is impossible because found no out-willfile of ' + submodule.decoratedAbsoluteName + '! Please re-export it, first.' );
      }
    }

  }

  return null;
}

//

function _performExportedReflectors()
{
  let exported = this;
  let inModule = exported.inModule;
  let outModule = exported.outModule;
  let will = outModule.will;
  let build = exported.build;
  let step = exported.step;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !!outModule );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !!build );
  _.assert( outModule.preformed > 0 );
  _.assert( inModule.preformed > 0 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  _.assert( _.object.isBasic( exported.criterion ) );
  _.assert( step instanceof _.will.Step );
  _.assert( build instanceof _.will.Build );
  _.assert( exported.exportedReflector === null );
  _.assert( exported.exportedDirPath === null );

  let exportedReflector;
  let recursive = null;

  let exp = inModule.pathResolve
  ({
    selector : exported.exportPath,
    currentContext : step,
    pathResolving : 'in',
  });

  /* */

  if( exp instanceof _.will.Reflector )
  {

    exp.form1();

    _.assert( exp.formed >= 1 );
    _.assert( exp.src.formed === 1 );
    _.sure( !!exp.filePath, () => exp.qualifiedName + ' should have filePath' );

    exportedReflector = exp.cloneExtending
    ({
      name : inModule.resourceNameGenerate( 'reflector', 'exported.' + exported.name ),
      module : outModule,
    });
    exportedReflector.criterion.generated = 1;

    _.assert( exportedReflector.original === exp.original );
    _.assert( exportedReflector.src !== exp.src );

    exportedReflector.original = null;

    let filter2 =
    {
      // maskTransientDirectory : { excludeAny : [ /\.git$/, /node_modules$/ ] },
    }

    exportedReflector.src.and( filter2 ).pathsSupplementJoining( filter2 );
    exportedReflector.src.filePath = exportedReflector.filePath;
    _.assert( !exportedReflector.src.prefixPath, 'not tested' );
    if( !exportedReflector.src.prefixPath )
    exportedReflector.src.prefixPath = inModule.inPath;

  }
  else if( _.arrayIs( exp ) )
  {

    let commonPath = path.common.apply( path, exp );
    if( path.isAbsolute( commonPath ) )
    commonPath = path.relative( inModule.inPath, commonPath );
    exportedReflector = outModule.resourceGenerate( 'reflector', 'exported.' + exported.name );
    exportedReflector.src.filePath = Object.create( null );
    for( let p = 0 ; p < exp.length ; p++ )
    {
      _.assert( !_.strHas( exp[ p ], '::' ) );
      exportedReflector.src.filePath[ exp[ p ] ] = '';
    }
    exportedReflector.src.basePath = commonPath;
    exportedReflector.src.prefixPath = inModule.inPath;

  }
  else if( _.strIs( exp ) )
  {

    if( !path.isGlob( exp ) )
    throw _.errBrief( `Expects glob path to export in export step. ${exported.exportPath} is not glob\n${exp}` );
    _.assert( !_.strHas( exp, '::' ) );
    exportedReflector = outModule.resourceGenerate( 'reflector', 'exported.' + exported.name );
    exportedReflector.src.filePath = exp;
    exportedReflector.src.prefixPath = inModule.inPath;

  }
  else _.assert( 0 );

  // debugger;
  if( recursive !== null )
  exportedReflector.src.recursive = recursive;
  exportedReflector.criterion = _.props.extend( exportedReflector.criterion, exported.criterion );
  // exportedReflector.generated = 1;
  exportedReflector.form();
  exported.exportedReflector = exportedReflector;

  _.assert( !!exportedReflector.criterion.generated );
  _.assert( exportedReflector.original === null );
  _.assert( outModule.reflectorMap[ exportedReflector.name ] === exportedReflector );
  _.assert( _.mapIs( exportedReflector.criterion ) );
  _.assert( exportedReflector.dst.prefixPath === null );
  _.assert( exportedReflector.dst.basePath === null );
  _.assert( path.isAbsolute( exportedReflector.src.prefixPath ) );
  _.assert( exportedReflector instanceof _.will.Reflector );

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

  // debugger;
  exported.exportedDirPath = outModule.resourceGenerate( 'path', 'exported.dir.' + exported.name );
  // exported.exportedDirPath.generated = 1;
  exported.exportedDirPath.path = path.undot( path.relative( outModule.inPath, exportedDirPath ) );
  exported.exportedDirPath.criterion = _.props.extend( exported.exportedDirPath.criterion, exported.criterion );
  // exported.exportedDirPath.criterion.generated = 1;
  exported.exportedDirPath.form();
  _.assert( !!exported.exportedDirPath.criterion.generated );

  return null;
}

//

function _performExportedFilesReflector()
{
  let exported = this;
  let outModule = exported.outModule;
  let will = outModule.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;

  /* exportedFilesPath */

  exported.exportedFilesPath = outModule.resourceGenerate( 'path', 'exported.files.' + exported.name );
  // exported.exportedFilesPath.generated = 1;
  exported.exportedFilesPath.criterion = _.props.extend( exported.exportedFilesPath.criterion, exported.criterion );
  // exported.exportedFilesPath.criterion.generated = 1;
  _.assert( !!exported.exportedFilesPath.criterion.generated );

  /* */

  let exportedFilesPath;
  try
  {

    exportedFilesPath = hd.filesFind
    ({
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

  exportedFilesPath = _.filter_( null, exportedFilesPath, ( r ) => r.absolute );

  exported.exportedFilesPath.path = path.s.relative( outModule.inPath, exportedFilesPath );

  if( exported.exportedFilesPath.path.length === 0 )
  {
    debugger;
    throw _.errBrief
    (
      'No file found at ' + path.commonTextualReport( exported.srcFilter.filePath )
      + ', cant export ' + exported.build.name,
    );
  }

  exported.exportedFilesPath.form();

  /* exportedFilesReflector */

  _.assert( !exported.exportedFilesReflector );

  let exportedFilesReflector = exported.exportedFilesReflector = outModule.resourceGenerate( 'reflector', 'exported.files.' + exported.name );
  // exportedFilesReflector.generated = 1;
  _.props.extend( exportedFilesReflector.criterion, exported.exportedReflector.criterion );
  exportedFilesReflector.recursive = 0;
  exportedFilesReflector.src.pairWithDst( exportedFilesReflector.dst );
  exportedFilesReflector.src.pairRefineLight();
  exportedFilesReflector.src.basePath = '.';
  exportedFilesReflector.src.prefixPath = exported.exportedDirPath.qualifiedName;
  exportedFilesReflector.src.filePath = exported.exportedFilesPath.qualifiedName;
  exportedFilesReflector.form1();

  _.assert( !!exportedFilesReflector.criterion.generated );
  _.assert( exportedFilesReflector.dst.prefixPath === null );
  _.assert( exportedFilesReflector.dst.basePath === null );
  _.assert( _.object.isBasic( exportedFilesReflector.criterion ) );
  _.assert( !!exportedFilesReflector.src.basePath );
  _.assert( exportedFilesReflector.dst.basePath === null );

  return null;
}

//

function _performPaths()
{
  let exported = this;
  let inModule = exported.inModule;
  let outModule = exported.outModule;
  let will = outModule.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let build = outModule.buildMap[ exported.name ];

  let originalWillFilesPath = outModule.resourceObtain( 'path', 'module.original.willfiles' );
  // originalWillFilesPath.path = path.s.relative( outModule.inPath, _.entity.make( outModule.willfilesPath ) );
  // originalWillFilesPath.criterion.predefined = 1;

  _.assert( !originalWillFilesPath.writable );
  _.assert( !!originalWillFilesPath.exportable );
  _.assert( !originalWillFilesPath.importableFromIn );
  _.assert( !!originalWillFilesPath.importableFromOut );

  // _.assert( !inModule.isOut );
  // _.assert( _.entityIdentical( inModule.pathMap[ 'module.original.willfiles' ], inModule.pathMap[ 'module.willfiles' ] ) );
  // _.assert( !_.entityIdentical( inModule.pathMap[ 'module.original.willfiles' ], inModule.pathMap[ 'module.peer.willfiles' ] ) );
  // _.assert( !_.entityIdentical( inModule.pathMap[ 'module.willfiles' ], inModule.pathMap[ 'module.peer.willfiles' ] ) );
  // _.assert( !!outModule.isOut );
  // _.assert( !_.entityIdentical( outModule.pathMap[ 'module.original.willfiles' ], outModule.pathMap[ 'module.willfiles' ] ) );
  // _.assert( _.entityIdentical( outModule.pathMap[ 'module.original.willfiles' ], outModule.pathMap[ 'module.peer.willfiles' ] ) );
  // _.assert( !_.entityIdentical( outModule.pathMap[ 'module.willfiles' ], outModule.pathMap[ 'module.peer.willfiles' ] ) );

  _.assert( !inModule.isOut );
  _.assert( _.path.map.identical( inModule.pathMap[ 'module.original.willfiles' ], inModule.pathMap[ 'module.willfiles' ] ) );
  _.assert( !_.path.map.identical( inModule.pathMap[ 'module.original.willfiles' ], inModule.pathMap[ 'module.peer.willfiles' ] ) );
  _.assert( !_.path.map.identical( inModule.pathMap[ 'module.willfiles' ], inModule.pathMap[ 'module.peer.willfiles' ] ) );
  _.assert( !!outModule.isOut );
  _.assert( !_.path.map.identical( outModule.pathMap[ 'module.original.willfiles' ], outModule.pathMap[ 'module.willfiles' ] ) );
  _.assert( _.path.map.identical( outModule.pathMap[ 'module.original.willfiles' ], outModule.pathMap[ 'module.peer.willfiles' ] ) );
  _.assert( !_.path.map.identical( outModule.pathMap[ 'module.willfiles' ], outModule.pathMap[ 'module.peer.willfiles' ] ) );

  return null;
}

//

function _performArchive()
{
  let exported = this;
  let outModule = exported.outModule;
  let inModule = exported.inModule;
  let will = outModule.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let build = inModule.buildMap[ exported.name ];

  _.assert( exported.archiveFilePath === null );
  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( _.boolLike( exported.tar ) );

  /* archiveFilePath */

  if( !exported.tar )
  {
    exported.archiveFilePath = null;
    return null;
  }

  let archiveFilePath = build.archiveFilePathFor();
  exported.archiveFilePath = outModule.resourceGenerate( 'path', 'archiveFile.' + exported.name );
  exported.archiveFilePath.path = path.undot( path.relative( outModule.inPath, archiveFilePath ) );
  exported.archiveFilePath.criterion = _.props.extend( exported.archiveFilePath.criterion, exported.criterion );
  // exported.archiveFilePath.criterion.generated = 1;
  exported.archiveFilePath.form();
  _.assert( !!exported.archiveFilePath.criterion.generated );

  /* */

  if( !Tar )
  Tar = require( 'tar' );

  let exportedDirPath = path.s.resolve( outModule.inPath, exported.exportedDirPath.path );

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
  // if( will.verbosity >= 3 )
  if( will.transaction.verbosity >= 3 )
  logger.log( ' + ' + 'Write out archive ' + hd.path.moveTextualReport( archiveFilePath, exportedDirPath ) );

  return null;
}

//

function _performWriteOutFile()
{
  let exported = this;
  let inModule = exported.inModule;
  let outModule = exported.outModule;
  let will = outModule.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let build = outModule.buildMap[ exported.name ];

  /* */

  let outFilePath = outModule.outfilePathGet();
  _.assert( outModule.isOut );
  let structure = outModule.structureExportOut();

  /* */

  // debugger;
  hd.fileWrite
  ({
    filePath : outFilePath,
    data : structure,
    encoding : 'yaml',
  });
  // debugger;

  /* */

  // if( will.verbosity >= 3 )
  if( will.transaction.verbosity >= 3 )
  logger.log( ' + ' + 'Write out willfile ' + _.color.strFormat( outFilePath, 'path' ) );

  return null;
}

//

function _performAttachOutFile()
{
  let exported = this;
  let inModule = exported.inModule;
  let outModule = exported.outModule;
  let will = outModule.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let build = outModule.buildMap[ exported.name ];
  let outFilePath = outModule.outfilePathGet();

  /* */

  let willf = outModule.willfileAttach( outFilePath );

  willf.reopen({ forModule : outModule });

  return null;
}

//

function _performReloadOutFile()
{
  let exported = this;
  let inModule = exported.inModule;
  let outModule = exported.outModule;
  let will = outModule.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.transaction.logger;
  let build = outModule.buildMap[ exported.name ];

  /* */

  let name = outModule.absoluteName;
  return outModule.reopen()
  .finally( ( err, outModule2 ) =>
  {
    if( err )
    debugger;
    if( err )
    throw _.err( err, `\nFailed to reopen ${name} after exporting it` );
    _.assert( outModule2 instanceof _.will.Module );
    return outModule2;
  });

}

//

function perform( frame )
{
  let time = _.time.now();
  let exported = this;
  let inModule = exported.inModule;
  let will = inModule.will;
  let con = _.take( null );
  let logger = will.transaction.logger;

  _.assert( arguments.length === 1 );

  con.then( () => exported._performPrepare1( frame ) );
  con.then( () => exported._performOutModule( frame ) );
  con.then( () => exported._performReform() );
  con.then( () => exported._performSubmodulesPeersOpen() );
  con.then( () => exported._performRecursive() );
  con.then( () => exported._performPrepare2() );
  con.then( () => exported._performExportedReflectors() );
  con.then( () => exported._performExportedFilesReflector() );
  con.then( () => exported._performPaths() );
  con.then( () => exported._performArchive() );
  con.then( () => exported._performWriteOutFile() );
  con.then( () => exported._performAttachOutFile() );
  // con.then( () => exported._performReloadOutFile() );

  /* log */

  con.finally( ( err, outModule2 ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to export ${exported.decoratedAbsoluteName}` );
    frame.run.exported.push( exported );
    return outModule2;
  });

  return con;
}

// --
// relations
// --

let moduleSymbol = Symbol.for( 'module' );
let inModuleSymbol = Symbol.for( 'inModule' );

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
  outModule : null,
  inModule : null,
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
  inModule : { get : inModuleGet, set : inModuleSet },
  outModule : { get : outModuleGet, set : outModuleSet },
  module : { get : moduleGet, set : moduleSet, combining : 'rewrite' },
}

// --
// declare
// --

let Extension =
{

  finit,
  init,
  form1,
  form2,

  // etc

  inModuleGet,
  inModuleSet,
  outModuleGet,
  outModuleSet,
  moduleGet,
  moduleSet,

  // inter

  _verify,
  _performPrepare1,
  _performOutModule,
  _performReform,
  _performSubmodulesPeersOpen,
  _performRecursive,
  _performPrepare2,
  _performExportedReflectors,
  _performExportedFilesReflector,
  _performPaths,
  _performArchive,
  _performWriteOutFile,
  _performAttachOutFile,
  _performReloadOutFile,

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
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
