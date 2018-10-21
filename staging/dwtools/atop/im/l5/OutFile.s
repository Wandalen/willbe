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
let Self = function wImOutFile( o )
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
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let con = new _.Consequence().give();

  outf.exportPath = path.resolve( module.dirPath, module.strResolve( exp.files ) );
  outf.archivePath = path.resolve( module.dirPath, module.link.outDirPath, module.about.name + exp.name + '.out.tgs' );
  outf.outFilePath = path.resolve( module.dirPath, module.link.outDirPath, module.about.name + exp.name + '.out.yml' );

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !outf.formed );
  _.assert( module.formed === 1 );
  _.assert( will.formed === 1 );
  _.assert( exp.formed === 3 );
  _.assert( outf.data === null );

  _.sure( _.strDefined( module.dirPath ), 'Expects directory path of the module' );
  _.sure( _.objectIs( exp.settings ), 'Expects settings of export' );
  _.sure( _.strDefined( exp.name ), 'Expects name of export' );
  _.sure( _.objectIs( module.inFileWithRoleMap.import ), 'Expects import in fine' );
  _.sure( _.objectIs( module.inFileWithRoleMap.export ), 'Expects export in fine' );
  _.sure( _.strDefined( module.about.name ), 'Expects name of the module defined' );
  _.sure( _.strDefined( module.about.version ), 'Expects the current version of the module defined' );
  _.sure( fileProvider.fileExists( outf.exportPath ) );

  /* begin */

  outf.data = Object.create( null );

  outf.data.formatVersion = outf.Version;
  outf.data.version = module.about.version;
  outf.data.files = null;

  outf.data.importIn = module.inFileWithRoleMap.import.data;
  outf.data.exportIn = module.inFileWithRoleMap.export.data;

  fileProvider.fileWrite
  ({
    filePath : outf.outFilePath,
    data : outf.data,
    encoding : 'yaml',
  });

  if( will.verbosity >= 2 )
  logger.log( ' + ' + 'Write out file to ' + outf.outFilePath );

  if( exp.tar )
  {

    if( !Tar )
    Tar = require( 'tar' );
    let zip;

    let oo =
    {
      gzip : true,
      sync : 1,
      file : path.nativize( outf.archivePath ),
      cwd : path.nativize( outf.exportPath ),
    }

    zip = Tar.create( oo, [ '.' ] );

    if( will.verbosity >= 2 )
    logger.log( ' + ' + 'Write out archive ' + path.move( outf.archivePath, outf.exportPath ) );

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
