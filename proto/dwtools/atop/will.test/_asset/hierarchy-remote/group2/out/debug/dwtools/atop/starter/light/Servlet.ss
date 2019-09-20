( function _Servlet_ss_() {

'use strict';

let Express = null;
let ExpressLogger = null;
let ExpressDir = null;
let Querystring = null;
let _ = wTools;
let Parent = null;
let Self = function wStarterServlet( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Servlet';

// --
// routine
// --

function unform()
{
  let servlet = this;

  _.assert( 0, 'not implemented' );

/*
qqq : implement please
*/

}

//

function form()
{
  let servlet = this;
  let starter = servlet.starter;

  if( starter.servletsMap[ servlet.servePath ] && starter.servletsMap[ servlet.servePath ] !== servlet )
  throw _.err( 'Servlet at ' + servlet.servePath + ' is already launched' );

  starter.servletsMap[ servlet.servePath ] = servlet;

  let parsedServerPath = _.servlet.serverPathParse({ serverPath : servlet.serverPath });
  servlet.serverPath = parsedServerPath.full;
  _.sure( _.numberIsFinite( parsedServerPath.port ), () => 'Expects number {-port-}, but got ' + _.toStrShort( parsedServerPath.port ) );

  /* - */

  if( !servlet.express )
  {
    if( !Express )
    Express = require( 'express' );
    servlet.express = Express();
  }

  let express = servlet.express;

  express.use( ( request, response, next ) => servlet.requestPreHandler({ request, response, next }) );

  if( Config.debug && starter.verbosity )
  {
    if( !ExpressLogger )
    ExpressLogger = require( 'morgan' );
    express.use( ExpressLogger( 'dev' ) );
  }

  express.use( ( request, response, next ) => servlet.requestMidHandler({ request, response, next }) );

  servlet._requsetScriptWrapHandler = servlet.ScriptWrap_functor
  ({
    allowedPath : '/',
    basePath : servlet.basePath,
    allowedPath : servlet.allowedPath,
    verbosity : servlet.verbosity,
    incudingExts : servlet.incudingExts,
    excludingExts : servlet.excludingExts,
    starterMaker : starter.maker,
  });
  express.use( ( request, response, next ) => servlet._requsetScriptWrapHandler({ request, response, next }) );

  express.use( parsedServerPath.localWebPath, Express.static( _.path.nativize( servlet.basePath ) ) );

  if( servlet.servingDirs )
  {
    if( !ExpressDir )
    ExpressDir = require( 'serve-index' );
    let directoryOptions =
    {
      'icons' : true,
      'hidden' : true,
    }
    express.use( parsedServerPath.localWebPath, ExpressDir( _.path.nativize( servlet.basePath ), directoryOptions ) );
  }

  express.use( ( request, response, next ) => servlet.requestPostHandler({ request, response, next }) );
  express.use( ( error, request, response, next ) => servlet.requestErrorHandler({ error, request, response, next }) );

  let o3 = _.servlet.controlExpressStart
  ({
    name : servlet.qualifiedName,
    verbosity : starter.verbosity - 1,
    server : servlet.server,
    express : servlet.express,
    serverPath : servlet.serverPath,
  });

  servlet.server = o3.server;
  servlet.express = o3.express;
  servlet.serverPath = o3.serverPath;

  /* - */

  return servlet;
}

//

function requestPreHandler( o )
{
  let servlet = this;

  _.servlet.controlRequestPreHandle
  ({
    allowCrossDomain : servlet.allowCrossDomain,
    verbosity : servlet.verbosity,
    request : o.request,
    response : o.response,
    next : o.next,
  });

  o.next();
}

//

function requestMidHandler( o )
{
  let servlet = this;

  // debugger;
  // let filePath = _.uri.reroot( servlet.basePath, o.request.originalUrl );
  // _.assert( _.uri.isLocal( filePath ) );

  o.next();
}

//

function requestPostHandler( o )
{
  let servlet = this;

  debugger;
  _.servlet.controlRequestPostHandle
  ({
    verbosity : servlet.verbosity,
    request : o.request,
    response : o.response,
    next : o.next,
  });

  o.next();
}

//

function requestErrorHandler( o )
{
  debugger;
  if( o.response.headersSent )
  return o.next( o.error );
  o.error = _.err( o.error );

  _.errLogOnce( o.error )

  o.response.status( 500 );
  o.response.send( o.error.message );
  // o.response.write( o.error.message );
  // o.response.end();
  // o.response.render( 'error', { error : o.error } );
}

//

function _verbosityGet()
{
  let servlet = this;
  if( !servlet.starter )
  return 9;
  return servlet.starter.verbosity;
}

// //
//
// function webSocketServerRun()
// {
//
//   debugger;
//   var WebSocketServer = require( 'websocket' ).server;
//   var http = require( 'http' );
//
//   o.server = http.createServer( function( request, response )
//   {
//     console.log( 'server request' ); debugger;
//   });
//   o.server.listen( 5001, function() { } );
//
//   o.webSocketServer = new WebSocketServer
//   ({
//     httpServer : o.server
//   });
//
//   o.webSocketServer.on( 'request', function( request )
//   {
//     console.log( 'webSocketServer request' ); debugger;
//
//     var connection = request.accept( null, request.origin );
//
//     connection.on( 'message', function( message )
//     {
//       console.log( 'webSocketServer message' ); debugger;
//       if( message.type === 'utf8' )
//       {
//       }
//     });
//
//     connection.on( 'close', function( connection )
//     {
//       console.log( 'webSocketServer close' ); debugger;
//     });
//
//   });
//
// }
//
// let defaults = webSocketServerRun.defaults = Object.create( null );
//
// defaults.server = null;
// defaults.webSocketServer = null;

// --
//
// --

function ScriptWrap_functor( fop )
{
  fop = _.routineOptions( ScriptWrap_functor, arguments );

  if( fop.starter === null )
  fop.starter = new _.Starter();

  if( fop.incudingExts === null )
  fop.incudingExts = [ 's', 'js', 'ss' ];

  if( fop.excludingExts === null )
  fop.excludingExts = [ 'raw', 'usefile' ];

  _.assert( _.strDefined( fop.basePath ) );
  _.assert( _.strDefined( fop.allowedPath ) );

  let ware;
  let fileProvider = _.FileProvider.HardDrive({ encoding : 'utf8' });

  scriptWrap.defaults =
  {
    request : null,
    response : null,
    next : null,
  }

  return scriptWrap;

  function _scriptWrap( o )
  {

    _.assertRoutineOptions( scriptWrap, arguments );

    if( !Querystring )
    Querystring = require( 'querystring' );
    o.request.url = Querystring.unescape( o.request.url );

    let uri = _.uri.parseFull( o.request.url );
    let exts = _.uri.exts( uri.localWebPath );
    let query = uri.query ? _.strWebQueryParse( uri.query ) : Object.create( null );
    if( query.running === undefined )
    query.running = 1;
    query.running = !!query.running;
    query.entry = !!query.entry;

    if( uri.localWebPath === '/.starter' )
    {
      return starterWareReturn();
    }
    else if( _.strBegins( uri.localWebPath, '/.resolve/' ) )
    {
      return remoteResolve();
    }
    else if( query.entry )
    {
      return htmlGenerate();
    }

    surePathAllowed( uri.localWebPath );

    if( !_.arrayHasAny( fop.incudingExts, exts ) )
    return o.next();

    if( _.arrayHasAny( fop.excludingExts, exts ) )
    return o.next();

    let filePath = _.path.normalize( _.path.reroot( fop.basePath, uri.longPath ) );
    let shortName = _.strVarNameFor( _.path.fullName( filePath ) );

    if( !_.fileProvider.isTerminal( filePath ) )
    return o.next();

    let splits = fop.starterMaker.sourceWrapSplits
    ({
      basePath : fop.basePath,
      filePath : filePath,
      running : query.running,
      interpreter : 'browser',
    });

    let stream = fileProvider.streamRead
    ({
      filePath : filePath,
      throwing : 0,
    });

    if( !stream )
    return o.next();

    o.response.setHeader( 'Content-Type', 'application/javascript; charset=UTF-8' );

    let state = 0;

    if( fop.verbosity )
    console.log( ' . scriptWrap', uri.localWebPath, 'of', filePath );

    stream.on( 'open', function()
    {
      state = 1;
      o.response.write( splits.prefix1 );
      o.response.write( splits.prefix2 );
    });

    stream.on( 'data', function( d )
    {
      state = 1;
      o.response.write( d );
    });

    stream.on( 'end', function()
    {
      if( state < 2 )
      {
        o.response.write( splits.postfix2 );
        o.response.write( splits.ware );
        o.response.write( splits.postfix1 );
        o.response.end();
      }
      state = 2;
    });

    stream.on( 'error', function( err )
    {
      if( !state )
      {
        o.next();
      }
      else
      errorHandle
      ({
        err : err,
        request : o.request,
        response : o.response,
      });
      state = 2;
    });

    /* - */

    function htmlGenerate()
    {
      let filePath = _.strRemoveBegin( uri.localWebPath, '/.resolve/' );
      let realPath = _.path.reroot( fop.basePath, filePath );

      let filter = { filePath : realPath, basePath : fop.basePath };
      let resolvedFilePath = _.fileProvider.filesFind
      ({
        filter,
        mode : 'distinct',
        mandatory : 0,
        includingDirs : 0,
        withDefunct : 0,
      });

      if( !resolvedFilePath.length )
      return _.servlet.errorHandle
      ({
        request : o.request,
        response : o.response,
        err : _.err( `Found no ${filePath}` ),
      });

      let srcScriptsMap = Object.create( null );
      resolvedFilePath.forEach( ( p ) => surePathAllowed( p.absolute ) );
      resolvedFilePath.forEach( ( p ) =>
      {
        srcScriptsMap[ _.path.join( '/', p.relative ) ] = _.fileProvider.fileRead( p.absolute );
      });
      let title = _.path.fullName( resolvedFilePath[ 0 ].absolute );

      let html = fop.starterMaker.htmlFor
      ({
        srcScriptsMap,
        title,
      });

      o.response.setHeader( 'Content-Type', 'text/html; charset=UTF-8' );
      o.response.write( html );
      o.response.end();

    }

    /* - */

    function remoteResolve()
    {
      let filePath = _.strRemoveBegin( uri.localWebPath, '/.resolve/' );
      filePath = _.path.reroot( fop.basePath, filePath );

      let basePath = _.path.fromGlob( filePath );
      surePathAllowed( basePath );

      let resolvedFilePath = [];
      if( _.path.isGlob( filePath ) )
      {

        if( !fop.resolvingGlob )
        return _.servlet.errorHandle
        ({
          request : o.request,
          response : o.response,
          err : _.err( `Cant resolve ${filePath} because {- fop.resolvingGlob -} is off` ),
        });

        let filter = { filePath, basePath : fop.basePath };
        resolvedFilePath = _.fileProvider.filesFind
        ({
          filter,
          mode : 'distinct',
          mandatory : 0,
          includingDirs : 0,
        });

        resolvedFilePath.forEach( ( p ) => surePathAllowed( p.absolute ) );
        resolvedFilePath = resolvedFilePath.map( ( p ) => _.path.join( '/', p.relative ) );

      }
      else
      {

        if( !fop.resolvingNpm )
        return _.servlet.errorHandle
        ({
          request : o.request,
          response : o.response,
          err : _.err( `Cant resolve ${filePath} because {- fop.resolvingNpm -} is off` ),
        });

        debugger;
      }

      o.response.json( resolvedFilePath );
      return;
    }

    /* - */

    function starterWareReturn()
    {
      if( !ware )
      {
        let splits = fop.starterMaker.sourcesJoinSplits({ interpreter : 'browser', libraryName : 'Application' });
        ware = splits.prefix + splits.ware + splits.browser + splits.starter + splits.env + '' + splits.externalBefore + splits.entry + splits.externalAfter + splits.postfix;
      }
      o.response.write( ware );
      o.response.end();
      return null;
    }

    /* - */

    function surePathAllowed( filePath )
    {
      _.all( filePath, ( p ) =>
      {
        _.sure( _.path.begins( p, fop.allowedPath ), () => `Path ${p} is beyond allowed path ${fop.allowedPath}` );
      });
    }

  }

  /* - */

  function scriptWrap( o )
  {
    try
    {
      return _scriptWrap.apply( this, arguments );
    }
    catch( err )
    {
      throw _.err( err );
    }
  }

}

let defaults = ScriptWrap_functor.defaults = Object.create( null );

defaults.basePath = null;
defaults.allowedPath = '/';
defaults.verbosity = 0;
defaults.incudingExts = null;
defaults.excludingExts = null;
defaults.starterMaker = null;
defaults.resolvingGlob = 1;
defaults.resolvingNpm = 1;
defaults.autoGeneratingHtml = 1;

// --
// relationships
// --

let Composes =
{

  servingDirs : 0,
  serverPath : 'http://127.0.0.1:5000',
  basePath : null,
  allowedPath : '/',

  incudingExts : _.define.own([ 's', 'js', 'ss' ]),
  excludingExts : _.define.own([ 'raw', 'usefile' ]),

}

let Associates =
{
  starter : null,
  server : null,
  express : null,
}

let Restricts =
{
  _requsetScriptWrapHandler : null,
}

let Statics =
{
  ScriptWrap_functor,
}

let Accessor =
{
  verbosity : { getter : _verbosityGet, readOnly : 1 }
}

// --
// prototype
// --

let Proto =
{

  unform,
  form,

  requestPreHandler,
  requestMidHandler,
  requestPostHandler,
  requestErrorHandler,

  _verbosityGet,

  ScriptWrap_functor,

  /* */

  Composes,
  Associates,
  Restricts,
  Statics,
  Accessor,

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
module[ 'exports' ] = Self;

_.staticDeclare
({
  prototype : _.Starter.prototype,
  name : Self.shortName,
  value : Self,
});

})();
