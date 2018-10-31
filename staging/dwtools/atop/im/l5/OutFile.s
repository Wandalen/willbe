( function _OutFile_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let Tar;

//

let _ = wTools;
let Parent = null;
let Self = function wWillOutFile( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'OutFile';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let outf = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( outf );
  Object.preventExtensions( outf );

  if( o )
  outf.copy( o );

}

//

function unform()
{
  let outf = this;
  let module = outf.module;

  _.assert( arguments.length === 0 );
  _.assert( !!outf.formed );

  /* begin */

  /* end */

  outf.formed = 0;
  return outf;
}

//

function form()
{
  let outf = this;
  let module = outf.module;
  let exp = outf.export;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let path = hub.path;
  let logger = will.logger;
  let con = new _.Consequence().give();

  // outf.exportPath = hd.path.resolve( module.dirPath, module.strResolve( exp.files ) );
  // outf.archivePath = hd.path.resolve( module.dirPath, module.pathMap.outDir || '.', module.about.name + exp.name + '.out.tgs' );
  // outf.outFilePath = hd.path.resolve( module.dirPath, module.pathMap.outDir || '.', module.about.name + exp.name + '.out.yml' );

  outf.exportPath = exp.exportPathFor();
  outf.archivePath = exp.archivePathFor();
  outf.outFilePath = exp.outFilePathFor();

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!hd );
  _.assert( !!logger );
  _.assert( !outf.formed );
  _.assert( module.formed === 2 );
  _.assert( will.formed === 1 );
  _.assert( exp.formed === 3 );
  _.assert( outf.data === null );
  _.assert( module.generated === null );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( exp.settings ), 'Expects settings of export' );
  _.sure( _.strDefined( exp.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.inFileWithRoleMap.import ) || _.objectIs( module.inFileWithRoleMap.single ), 'Expects import in fine' );
  _.sure( _.objectIs( module.inFileWithRoleMap.export ) || _.objectIs( module.inFileWithRoleMap.single ), 'Expects export in fine' );
  _.sure( _.strDefined( module.about.name ), 'Expects name of the module defined' );
  _.sure( _.strDefined( module.about.version ), 'Expects the current version of the module defined' );
  _.sure( hd.fileExists( outf.exportPath ) );

  /* begin */

  module.generated = new will.ParagraphGenerated({ module : module });

  module.generated.formatVersion = outf.Version;
  module.generated.version = module.about.version;
  module.generated.files = null;

  // outf.data.formatVersion = outf.Version;
  // outf.data.version = module.about.version;
  // outf.data.files = null;

  // outf.data.importIn = module.inFileWithRoleMap.import ? module.inFileWithRoleMap.import.data : null;
  // outf.data.exportIn = module.inFileWithRoleMap.export ? module.inFileWithRoleMap.export.data : null;
  // outf.data.singleIn = module.inFileWithRoleMap.single ? module.inFileWithRoleMap.single.data : null;

  module.generated.files = hd.filesFind
  ({
    recursive : 1,
    includingDirectories : 1,
    includingTerminals : 1,
    outputFormat : 'relative',
    filePath : outf.exportPath,
    filter :
    {
      maskTransientDirectory : { /*excludeAny : [ /\.git$/, /node_modules$/ ]*/ },
      basePath : module.dirPath,
    },
  });

  /* */

  outf.data = module.dataExport();

  hd.fileWrite
  ({
    filePath : outf.outFilePath,
    data : outf.data,
    encoding : 'yaml',
  });

  /* */

  if( will.verbosity >= 2 )
  logger.log( ' + ' + 'Write out file to ' + outf.outFilePath );

  if( exp.tar )
  {

    if( !Tar )
    Tar = require( 'tar' );

    let oo =
    {
      gzip : true,
      sync : 1,
      file : hd.path.nativize( outf.archivePath ),
      cwd : hd.path.nativize( outf.exportPath ),
    }

    debugger;
    let zip = Tar.create( oo, [ '.' ] );
    debugger;

    if( will.verbosity >= 2 )
    logger.log( ' + ' + 'Write out archive ' + hd.path.move( outf.archivePath, outf.exportPath ) );

  }

  /* end */

  outf.formed = 1;
  return con;
}

// --
// relations
// --

let Composes =
{
  outFilePath : null,
  exportPath : null,
  archivePath : null,
}

let Aggregates =
{
  data : null,
}

let Associates =
{
  module : null,
  export : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  Version : '1.0.0',
}

let Forbids =
{
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
