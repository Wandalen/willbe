( function _Predefined_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let Tar;

//

let _ = wTools;
let Self = Object.create( null );

// --
//
// --

//

let filesReflect = _.routineForPreAndBody( _.FileProvider.Find.prototype.filesReflect.pre, _.FileProvider.Find.prototype.filesReflect.body );

let defaults = filesReflect.defaults;

defaults.linking = 'hardlinkMaybe';
defaults.mandatory = 1;
defaults.dstRewritingPreserving = 1;

//

function stepRoutineReflect( run )
{
  let step = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.objectIs( step.opts ) );
  _.assert( !!step.opts.reflector, 'Expects option reflector' );
  _.assert( arguments.length === 2 );

  let opts = _.mapExtend( null, step.opts );
  opts.reflector = module.strResolve( opts.reflector );

  _.sure( opts.reflector instanceof will.Reflector, 'Step "reflect" expects reflector, but got', step.opts )

  opts.reflector = opts.reflector.optionsReflectExport();
  _.mapSupplement( opts, opts.reflector )
  delete opts.reflector;

  if( will.verbosity >= 2 && will.verbosity <= 3 )
  {
    logger.log( 'filesReflect' );
    logger.log( _.toStr( opts.reflectMap, { wrap : 0, multiline : 1, levels : 3 } ) );
  }

  debugger;
  let result = will.Predefined.filesReflect.call( fileProvider, opts );
  debugger;

  return result;
}

//

function stepRoutineExport( run, build )
{
  let step = this;
  let module = run.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;

  let exportPath = build.exportPathFor();
  let archivePath = build.archivePathFor();
  let outFilePath = build.outFilePathFor();

  _.assert( arguments.length === 2 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  // _.assert( !outf.formed );
  _.assert( module.formed === 2 );
  _.assert( will.formed === 1 );
  _.assert( build.formed === 3 );
  // _.assert( outf.data === null );
  _.assert( module.exported === null );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( build.criterion ), 'Expects criterion of export' );
  _.sure( _.strDefined( build.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.inFileWithRoleMap.import ) || _.objectIs( module.inFileWithRoleMap.single ), 'Expects import in fine' );
  _.sure( _.objectIs( module.inFileWithRoleMap.export ) || _.objectIs( module.inFileWithRoleMap.single ), 'Expects export in fine' );
  _.sure( _.strDefined( module.about.name ), 'Expects name of the module defined' );
  _.sure( _.strDefined( module.about.version ), 'Expects the current version of the module defined' );
  _.sure( hd.fileExists( exportPath ) );

  /* begin */

  module.exported = new will.ParagraphExported({ module : module });

  module.exported.formatVersion = will.FormatVersion;
  module.exported.version = module.about.version;
  module.exported.files = null;

  // outf.data.formatVersion = outf.Version;
  // outf.data.version = module.about.version;
  // outf.data.files = null;

  // outf.data.importIn = module.inFileWithRoleMap.import ? module.inFileWithRoleMap.import.data : null;
  // outf.data.exportIn = module.inFileWithRoleMap.export ? module.inFileWithRoleMap.export.data : null;
  // outf.data.singleIn = module.inFileWithRoleMap.single ? module.inFileWithRoleMap.single.data : null;

  module.exported.files = hd.filesFind
  ({
    recursive : 1,
    includingDirectories : 1,
    includingTerminals : 1,
    outputFormat : 'relative',
    filePath : exportPath,
    filter :
    {
      maskTransientDirectory : { /*excludeAny : [ /\.git$/, /node_modules$/ ]*/ },
      basePath : module.dirPath,
    },
  });

  /* */

  // outf.data = module.dataExport();
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

  if( build.criterion.tar === undefined || build.criterion.tar )
  {

    if( !Tar )
    Tar = require( 'tar' );

    let oo =
    {
      gzip : true,
      sync : 1,
      file : hd.path.nativize( archivePath ),
      cwd : hd.path.nativize( exportPath ),
    }

    debugger;
    let zip = Tar.create( oo, [ '.' ] );
    debugger;

    if( will.verbosity >= 2 )
    logger.log( ' + ' + 'Write out archive ' + hd.path.move( archivePath, exportPath ) );

  }

}

// --
// declare
// --

let Extend =
{

  filesReflect : filesReflect,

  stepRoutineReflect : stepRoutineReflect,
  stepRoutineExport : stepRoutineExport,



}

//

_.mapExtend( Self, Extend );
_.staticDecalre
({
  prototype : _.Will.prototype,
  name : 'Predefined',
  value : Self,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;

})();
