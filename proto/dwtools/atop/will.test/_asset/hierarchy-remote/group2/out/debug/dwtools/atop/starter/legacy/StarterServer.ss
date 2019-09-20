( function _StarterServer_ss_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );

  _.include( 'wFiles' );
  require( './StarterMaker.s' );

}

//

var _ = wTools;
var Self = _.starter = _.starter || Object.create( null );

// --
// routine
// --

function staticRequestHandler_functor( gen )
{
  var gen = _.routineOptions( staticRequestHandler_functor, arguments );

  _.assert( _.strDefined( gen.basePath ) );

  var fileProvider = _.FileProvider.HardDrive({ encoding : 'utf8' });
  function staticRequestHandler( request, response, next )
  {

    var url = request.url;
    var exts = _.uri.exts( url );

    if( !_.strBegins( url, gen.filterPath ) )
    return next();

    if( _.arrayHasAny( [ 's','js','ss' ], exts ) )
    response.setHeader( 'Content-Type', 'application/javascript; charset=UTF-8' );
    else
    return next();

    var isRaw = _.arrayHasAny( [ 'raw','usefile' ], exts );
    var isRun = _.arrayHasAny( [ 'run' ], exts );

    // console.log( url, exts );
    if( isRaw )
    return next();

    // if( /\.manual(\.|\/|$)/.test( url ) )
    // return next();

    var urlParsed = _.uri.parse( url );
    var filePath = urlParsed.longPath;
    var dirPath = _.path.dir( filePath );
    var path = _.path.normalize( _.path.reroot( gen.basePath, filePath ) );
    var shortName = _.strVarNameFor( _.path.fullName( filePath ) );

//     var prefix = `/* */ /* ${filePath} */ `
//     prefix += `( function ${shortName}() { `; /**/
//     prefix += `var _naked = function ${shortName}_naked() { `; /**/
//
//     /* .. code .. */
//
//     var postfix = '/* */\n';
//     postfix += `/* */ }\n`; /* end of _naked */
//
//     postfix +=
// `/* */
// /* */  var _filePath_ = '${filePath}';
// /* */  var _dirPath_ = '${dirPath}';
// /* */  var __filename = _filePath_;
// /* */  var __dirname = _dirPath_;
// /* */  var _scriptFile_, module, include, require;
// `
//
//     postfix +=
// `/* */
// /* */  var _preload = function ${shortName}_preload()
// /* */  {
// /* */    if( typeof _starter_ === 'undefined' )
// /* */    return;
// /* */    _scriptFile_ = new _starter_.ScriptFile({ filePath : _filePath_, dirPath : _dirPath_ });
// /* */    module = _scriptFile_;
// /* */    include = _scriptFile_.include;
// /* */    require = include;
// /* */    _starter_.scriptRewrite( _filePath_, _dirPath_, _naked );
// /* */    _starter_._scriptPreloadEnd( _filePath_ );
// /* */  }
// `
//
//   if( isRun )
//   postfix +=
// `/* */
// /* */  _naked();
// `
//   else
//   postfix +=
// `/* */
// /* */  if( typeof _starterScriptsToPreload === 'undefined' )
// /* */  _starterScriptsToPreload = Object.create( null )
// /* */
// /* */  if( typeof _starter_ !== 'undefined' )
// /* */  {
// /* */    _preload();
// /* */  }
// /* */  else
// /* */  {
// /* */    _starterScriptsToPreload[ __filename ] = _preload;
// /* */    _naked();
// /* */  }
// `
//
//     postfix += `/* */})();\n`; /* end of r */
//     postfix += `/* */ /* > end of file ${filePath} */`;

    var fixes = _.StarterMaker.fixesFor
    ({
      filePath : filePath,
    });

    var stream = fileProvider.streamRead
    ({
      filePath : path,
      throwing : 0,
    });

    if( !stream )
    return next();

    var state = 0;

    if( gen.verbosity )
    console.log( '- staticRequestHandler',url,'at',path );

    stream.on( 'open', function()
    {
      state = 1;
      response.write( fixes.prefix );
    });

    stream.on( 'data', function( d )
    {
      state = 1;
      response.write( d );
    });

    stream.on( 'end', function()
    {
      if( state < 2 )
      {
        response.write( fixes.postfix );
        response.end();
      }
      state = 2;
    });

    stream.on( 'error', function( err )
    {
      if( !state )
      {
        next();
      }
      else
      {
        err = _.errLogOnce( err );
        response.write( err.toString() );
        response.end();
      }
      state = 2;
    });

  }

  return staticRequestHandler;
}

var defaults = staticRequestHandler_functor.defaults = Object.create( null );

defaults.basePath = null;
defaults.filterPath = '/';
defaults.verbosity = 0;

// --
// declare
// --

var Proto =
{

  staticRequestHandler_functor : staticRequestHandler_functor,

}

_.mapExtend( Self,Proto );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
