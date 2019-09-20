( function _MainBase_s_( ) {

'use strict';

/**
 * Collection of tools to generate background service to start and pack application. Use the module to keep files structure of the application and make code aware wherein the file system is it executed.
  @module Tools/mid/Starter
*/

let Open;

require( './IncludeBase.s' );

//

let _ = wTools;
let Parent = null;
let Self = function wStarter( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Starter';

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
  let starter = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !starter.logger )
  starter.logger = new _.Logger({ output : _global_.logger });

  _.workpiece.initFields( starter );
  Object.preventExtensions( starter );

  if( o )
  starter.copy( o );

}

//

function unform()
{
  let starter = this;

  _.assert( arguments.length === 0 );
  _.assert( !!starter.formed );

  /* begin */

  /* end */

  starter.formed = 0;
  return starter;
}

//

function form()
{
  let starter = this;

  if( starter.formed )
  return starter;

  starter.formAssociates();

  _.assert( arguments.length === 0 );
  _.assert( !starter.formed );

  starter.formed = 1;
  return starter;
}

//

function formAssociates()
{
  let starter = this;
  let logger = starter.logger;

  _.assert( arguments.length === 0 );
  _.assert( !starter.formed );

  if( !starter.logger )
  logger = starter.logger = new _.Logger({ output : _global_.logger });

  if( !starter.fileProvider )
  starter.fileProvider = _.FileProvider.Default();

  if( !starter.maker )
  starter.maker = _.StarterMakerLight();

  return starter;
}

//

function sourcesJoin( o )
{
  let starter = this;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let maker = starter.maker;

  o = _.routineOptions( sourcesJoin, arguments );

  /* */

  o.inPath = fileProvider.recordFilter( o.inPath );
  o.inPath.basePathUse( o.basePath );
  let basePath = o.inPath.basePathSimplest();

  o.inPath = fileProvider.filesFind
  ({
    filter : o.inPath,
    mode : 'distinct',
    outputFormat : 'absolute',
  });

  /* */

  o.outPath = o.outPath || sourcesJoin.defaults.outPath;
  o.outPath = path.resolve( o.basePath, o.outPath );

  /* */

  if( o.entryPath )
  {
    o.entryPath = fileProvider.recordFilter( o.entryPath );
    o.entryPath.basePath = path.resolve( o.entryPath.basePath || o.basePath || '.' );
    o.entryPath = fileProvider.filesFind
    ({
      filter : o.entryPath,
      mode : 'distinct',
      outputFormat : 'absolute',
    });
    if( !_.arrayHasAll( o.inPath, o.entryPath ) )
    throw _.errBrief
    (
      'List of source files should have all entry files' +
      '\nSource files\n' + _.toStrNice( o.inPath, { levels : 2 } ) +
      '\nEntry files\n' + _.toStrNice( o.entryPath, { levels : 2 } )
    );
  }

  /* */

  if( o.externalBeforePath )
  {
    o.externalBeforePath = fileProvider.recordFilter( o.externalBeforePath );
    o.externalBeforePath.basePath = path.resolve( o.externalBeforePath.basePath || o.basePath || '.' );
    o.externalBeforePath = fileProvider.filesFind
    ({
      filter : o.externalBeforePath,
      mode : 'distinct',
      outputFormat : 'absolute',
    });
  }

  /* */

  if( o.externalAfterPath )
  {
    o.externalAfterPath = fileProvider.recordFilter( o.externalAfterPath );
    o.externalAfterPath.basePath = path.resolve( o.externalAfterPath.basePath || o.basePath || '.' );
    o.externalAfterPath = fileProvider.filesFind
    ({
      filter : o.externalAfterPath,
      mode : 'distinct',
      outputFormat : 'absolute',
    });
  }

  /* */

  o.basePath = path.resolve( basePath || '.' );

  /* */

  let srcScriptsMap = Object.create( null );
  o.inPath = o.inPath.map( ( inPath ) =>
  {
    let srcRelativePath = inPath;
    srcScriptsMap[ srcRelativePath ] = fileProvider.fileRead( inPath );
  });

  let o2 = _.mapExtend( null, o )
  delete o2.inPath;
  o2.filesMap = srcScriptsMap;
  let data = maker.sourcesJoin( o2 )

  _.sure( !fileProvider.isDir( o.outPath ), () => 'Can rewrite directory ' + _.color.strFormat( o.outPath, 'path' ) );

  fileProvider.fileWrite
  ({
    filePath : o.outPath,
    data : data,
  });

  return data;
}

var defaults = sourcesJoin.defaults = _.mapBut( _.StarterMakerLight.prototype.sourcesJoin.defaults, { filesMap : null } );
defaults.inPath = null;
defaults.outPath = 'Index.js';

//

function htmlFor( o )
{
  let starter = this;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let maker = starter.maker;

  o = _.routineOptions( htmlFor, arguments );

  /* */

  let basePath = o.basePath;
  if( !_.arrayIs( o.inPath ) || o.inPath.length )
  {
    o.inPath = fileProvider.recordFilter( o.inPath );
    o.inPath.basePathUse( o.basePath );
    let basePath = o.inPath.basePathSimplest();
    o.inPath = fileProvider.filesFind
    ({
      filter : o.inPath,
      mode : 'distinct',
      outputFormat : 'absolute',
    });
  }

  /* */

  o.outPath = o.outPath || sourcesJoin.defaults.outPath;
  o.outPath = path.resolve( o.basePath, o.outPath );

  /* */

  o.basePath = path.resolve( basePath || '.' );

  /* */

  let srcScriptsMap = Object.create( null );
  o.inPath = o.inPath.map( ( inPath ) =>
  {
    let srcRelativePath = inPath;
    if( o.relative && o.basePath )
    srcRelativePath = path.dot( path.relative( o.basePath, srcRelativePath ) );
    if( o.nativize )
    srcRelativePath = path.nativize( srcRelativePath );
    if( o.starterIncluding === 'inline' )
    srcScriptsMap[ srcRelativePath ] = fileProvider.fileRead( inPath );
    else
    srcScriptsMap[ srcRelativePath ] = null;
  });

  let o2 = _.mapOnly( o, maker.htmlFor.defaults );
  o2.srcScriptsMap = srcScriptsMap;
  let data = maker.htmlFor( o2 );

  _.sure( !fileProvider.isDir( o.outPath ), () => 'Can rewrite directory ' + _.color.strFormat( o.outPath, 'path' ) );

  fileProvider.fileWrite
  ({
    filePath : o.outPath,
    data : data,
  });

  return data;
}

var defaults = htmlFor.defaults = _.mapBut( _.StarterMakerLight.prototype.htmlFor.defaults, { srcScriptsMap : null } );
defaults.inPath = null;
defaults.outPath = 'Index.html';
defaults.basePath = null;
defaults.relative = 1;
defaults.nativize = 0;

//

function httpOpen( o )
{
  let starter = this;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let maker = starter.maker;

  _.routineOptions( httpOpen, arguments );

  o.basePath = path.resolve( o.basePath );
  o.allowedPath = path.resolve( o.allowedPath );
  o.starter = starter;

  let servlet = new starter.Servlet( o );

  servlet.form();

  return servlet;
}

httpOpen.defaults =
{
  basePath : null,
  allowedPath : '/',
}

//

function start( o )
{
  let starter = this;
  let fileProvider = starter.fileProvider;
  let path = starter.fileProvider.path;
  let logger = starter.logger;
  let maker = starter.maker;

  _.routineOptions( start, arguments );

  o.entryPath = path.resolve( o.entryPath );
  if( !o.basePath )
  o.basePath = path.resolve( '.' );
  o.allowedPath = path.resolve( o.allowedPath );

  /* */

  let filter = { filePath : o.entryPath, basePath : o.basePath };
  let found = _.fileProvider.filesFind
  ({
    filter,
    mode : 'distinct',
    mandatory : 0,
    includingDirs : 0,
    withDefunct : 0,
  });

  if( !found.length )
  throw _.errBrief( `Found no ${o.entryPath}` );

  /* */

  let servlet = starter.httpOpen
  ({
    allowedPath : o.allowedPath,
    basePath : o.basePath,
  });

  if( !Open )
  Open = require( 'open' );

  debugger;
  Open( _.uri.join( servlet.serverPath, found[ 0 ].relative, '?entry:1' ) );

  return servlet;
}

var defaults = start.defaults = _.mapExtend( null, httpOpen.defaults );

defaults.entryPath = null;

// --
// relations
// --

let Composes =
{

  verbosity : 3,
  servletsMap : _.define.own({}),

}

let Aggregates =
{
}

let Associates =
{

  maker : null,
  fileProvider : null,
  logger : null,

}

let Restricts =
{
  formed : 0,
}

let Statics =
{
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

  finit,
  init,
  unform,
  form,
  formAssociates,

  sourcesJoin,
  htmlFor,
  httpOpen,
  start,

  // ident

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_global_[ Self.name ] = wTools[ Self.shortName ] = Self;

require( './IncludeMid.s' );

})();
