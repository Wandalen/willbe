( function _Uri_s_() {

'use strict';

/**
 * Collection of routines to operate URIs ( URLs ) in the reliable and consistent way. Path leverages parsing, joining, extracting, normalizing, nativizing, resolving paths. Use the module to get uniform experience from playing with paths on different platforms.
  @module Tools/base/Uri
*/

/**
 * @file Uri.s.
 */

/**
 * Collection of routines to operate URIs ( URLs ) in the reliable and consistent way.
  @namespace "wTools.uri"
  @memberof module:Tools/base/Uri
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wPathBasic' );

}

//

let _global = _global_;
let _ = _global_.wTools;
let Parent = _.path;
let Self = _.uri = _.uri || Object.create( Parent );

// --
// internal
// --

function _filterOnlyUrl( e,k,c )
{
  if( _.strIs( k ) )
  {
    if( _.strEnds( k,'Url' ) )
    return true;
    else
    return false
  }
  return this.is( e );
}

//

function _filterNoInnerArray( arr )
{
  return arr.every( ( e ) => !_.arrayIs( e ) );
}

// --
// checker
// --

  // '^(https?:\\/\\/)?'                                     // protocol
  // + '(\\/)?'                                              // relative
  // + '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'    // domain
  // + '((\\d{1,3}\\.){3}\\d{1,3}))'                         // ip
  // + '(\\:\\d+)?'                                          // port
  // + '(\\/[-a-z\\d%_.~+]*)*'                               // path
  // + '(\\?[;&a-z\\d%_.~+=-]*)?'                            // query
  // + '(\\#[-a-z\\d_]*)?$';                                 // anchor

let isRegExpString =
  '^([\w\d]*:\\/\\/)?'                                    // protocol
  + '(\\/)?'                                              // relative
  + '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'    // domain
  + '((\\d{1,3}\\.){3}\\d{1,3}))'                         // ip
  + '(\\:\\d+)?'                                          // port
  + '(\\/[-a-z\\d%_.~+]*)*'                               // path
  + '(\\?[;&a-z\\d%_.~+=-]*)?'                            // query
  + '(\\#[-a-z\\d_]*)?$';                                 // anchor

let isRegExp = new RegExp( isRegExpString, 'i' );
function is( path )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _.strIs( path );
}

//

/**
 * @summary Checks if provided uri is safe.
 * @param {String} filePath Source uri
 * @param {Number} level Level of check
 *
 * @example
 * _.uri.isSafe( 'https:///web.archive.org' )// false
 *
 * @example
 * _.uri.isSafe( 'https:///web.archive.org/root' )// true
 *
 * @returns {Boolean} Returns result of check for safetiness.
 * @function isSafe
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isSafe( path, level )
{
  let parent = this.path;

  _.assert( arguments.length === 1 || arguments.length === 2, 'Expects single argument' );
  _.assert( _.strDefined( path ) );

  if( this.isGlobal( path ) )
  path = this.parseConsecutive( path ).longPath;

  return parent.isSafe.call( this, path, level );
}

/*
qqq : module:Tools?
*/

//

/**
 * @summary Checks if provided uri is refined.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if {filePath} is refined, otherwise false.
 * @function isRefinedMaybeTrailed
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isRefinedMaybeTrailed( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isRefinedMaybeTrailed.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri is refined.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if {filePath} is refined, otherwise false.
 * @function isRefined
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isRefined( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isRefined.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri is normalized.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if {filePath} is normalized, otherwise false.
 * @function isNormalizedMaybeTrailed
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isNormalizedMaybeTrailed( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isNormalizedMaybeTrailed.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri is normalized.
 * @param {String} filePath Source uri
 *
 * @example
 * _.uri.isNormalized( 'https:///web.archive.org' ); // returns true
 *
 * @example
 * _.uri.isNormalized( 'https:/\\\\web.archive.org' ); // returns false
 *
 * @returns {Boolean} Returns true if {filePath} is normalized, otherwise false.
 * @function isNormalized
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isNormalized( path )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), 'Expects string' );
  return this.normalize( path ) === path;
}

//

/**
 * @summary Checks if provided uri is absolute.
 * @param {String} filePath Source uri
 *
 * @example
 * _.uri.isAbsolute( 'https:/web.archive.org' )// false
 *
 * @example
 * _.uri.isAbsolute( 'https:///web.archive.org' )// true
 *
 * @returns {Boolean} Returns true if {filePath} is absolute, otherwise false.
 * @function isAbsolute
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isAbsolute( path )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), () => 'Expects string {-path-}, but got ' + _.strType( path ) );

  if( this.isGlobal( path ) )
  path = this.parseConsecutive( path ).longPath;

  return parent.isAbsolute.call( this, path );
}

//

/**
 * @summary Checks if provided uri is relative.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if {filePath} is relative, otherwise false.
 * @function isRelative
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isRelative( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isRelative.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri is root.
 * @param {String} filePath Source uri
 *
 * @example
 * _.uri.isRoot( 'https:/web.archive.org' )// false
 *
 * @example
 * _.uri.isRoot( 'https:///' )// true
 *
 * @returns {Boolean} Returns true if {filePath} is root, otherwise false.
 * @function isRoot
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isRoot( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isRoot.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri begins with dot.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if path begins with dot, otherwise false.
 * @function isDotted
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isDotted( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isDotted.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri ends with slash.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if path ends with slash, otherwise false.
 * @function isTrailed
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isTrailed( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isTrailed.call( this, filePath );
}

//

/**
 * @summary Checks if provided uri is glob.
 * @param {String} filePath Source uri
 *
 * @returns {Boolean} Returns true if {filePath} is glob, otherwise false.
 * @function isGlob
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function isGlob( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ), () => 'Expects string {-filePath-}, but got ' + _.strType( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath ).longPath;

  return parent.isGlob.call( this, filePath );
}

// --
// transformer
// --

/**
 *
 * The URI component object.
 * @typedef {Object} UrlComponents
 * @property {string} protocol the URI's protocol scheme.;
 * @property {string} host host portion of the URI;
 * @property {string} port property is the numeric port portion of the URI
 * @property {string} localWebPath the entire path section of the URI.
 * @property {string} query the entire "query string" portion of the URI, not including '?' character.
 * @property {string} hash property consists of the "fragment identifier" portion of the URI.

 * @property {string} uri the whole URI
 * @property {string} hostWithPort host portion of the URI, including the port if specified.
 * @property {string} origin protocol + host + port
 * @private
 * @memberof module:Tools/base/Uri.wTools.uri
 */

let UriComponents =
{

  /* atomic */

  protocol : null, /* 'svn+http' */
  host : null, /* 'www.site.com' */
  port : null, /* '13' */
  localWebPath : null, /* '/path/name' */
  query : null, /* 'query=here&and=here' */
  hash : null, /* 'anchor' */

  /* composite */

  // qqq !!! : implement queries
  // queries : null, /* { query : here, and : here } */
  longPath : null, /* www.site.com:13/path/name */
  protocols : null, /* [ 'svn','http' ] */
  hostWithPort : null, /* 'www.site.com:13' */
  origin : null, /* 'svn+http://www.site.com:13' */
  full : null, /* 'svn+http://www.site.com:13/path/name?query=here&and=here#anchor' */

}

//

/*
http://www.site.com:13/path/name?query=here&and=here#anchor
2 - protocol
3 - hostWithPort( host + port )
5 - localWebPath
6 - query
8 - hash
*/

/*{
  'protocol' : 'complex+protocol',
  'host' : 'www.site.com',
  'port' : '13',
  'query' : 'query=here&and=here',
  'hash' : 'anchor',
  'localWebPath' : '/!a.js?',
  'longPath' : 'www.site.com:13/!a.js?',
}*/

// let _uriParseRegexpStr = '^';
// _uriParseRegexpStr += '(?:([^:/\\?#]*):)?'; /* protocol */
// _uriParseRegexpStr += '(?:\/\/(([^:/\\?#]*)(?::([^/\\?#]*))?))?'; /* host and port */
// _uriParseRegexpStr += '([^\\?#]*)'; /* local path */
// _uriParseRegexpStr += '(?:\\?([^#]*))?'; /* query */
// _uriParseRegexpStr += '(?:#(.*))?'; /* hash */
// _uriParseRegexpStr += '$';

let _uriParseRegexpStr = '^';

let _uriParseRegexpProtocolStr = '([^:/\\?#]*)'; /* protocol */
let _uriParseRegexpHostAndPortStr = ':\/\/(([^:/\\?#]*)(?::([^/\\?#]*))?)'; /* host and port */

_uriParseRegexpStr = '(?:' + _uriParseRegexpProtocolStr + _uriParseRegexpHostAndPortStr + ')?';

// _uriParseRegexpStr += '([^#]*\\?[^=#]*|[^\\?#]*)'; /* local path */
// _uriParseRegexpStr += '([^#?]*\\?[^=#]*|[^#?]*)'; /* local path */

_uriParseRegexpStr += '([^?]*\\?[^:=#]*|[^?#]*)'; /* local path */
_uriParseRegexpStr += '(?:\\?([^#]*))?'; /* query */
_uriParseRegexpStr += '(?:#(.*))?'; /* hash */
_uriParseRegexpStr += '$';

// ([^#]*\?[^=#]*|[^\?#]*)

let _uriParseRegexp = new RegExp( _uriParseRegexpStr );

// '^'
// '(?:([^:/\\?#]*):)?'
// '(?:\/\/(([^:/\\?#]*)(?::([^/\\?#]*))?))?'
// '([^\\?#]*)'
// '(?:\\?([^#]*))?'
// '(?:#(.*))?$'

// let _uriParseRegexp = new RegExp( '^(?:([^:/\\?#]*):)?(?:\/\/(([^:/\\?#]*)(?::([^/\\?#]*))?))?([^\\?#]*)(?:\\?([^#]*))?(?:#(.*))?$' );

function parse_pre( routine, args )
{
  _.assert( args.length === 1, 'Expects single argument' );
  let o = { srcPath : args[ 0 ] };

  _.routineOptions( routine, o );
  _.assert( _.strIs( o.srcPath ) || _.mapIs( o.srcPath ) );
  _.assert( _.arrayHas( parse_body.Kind, o.kind ), () => 'Unknown kind of parsing ' + o.kind );

  return o;
}

function parse_body( o )
{
  let result = Object.create( null );

  // _.routineOptions( this.parse_body, o );
  // _.assert( _.strIs( o.srcPath ) || _.mapIs( o.srcPath ) );
  // _.assert( arguments.length === 1, 'Expects single argument' );
  // _.assert( _.arrayHas( parse_body.Kind, o.kind ), () => 'Unknown kind of parsing ' + o.kind );

  if( _.mapIs( o.srcPath ) )
  {
    _.assertMapHasOnly( o.srcPath, this.UriComponents );
    if( o.srcPath.protocols )
    {
      debugger;
      return o.srcPath;
    }
    else if( o.srcPath.full )
    o.srcPath = o.srcPath.full;
    else
    o.srcPath = this.str( o.srcPath );
  }

  let e = _uriParseRegexp.exec( o.srcPath );
  _.sure( !!e, 'Cant parse :',o.srcPath );

  if( _.strIs( e[ 1 ] ) )
  result.protocol = e[ 1 ];
  if( _.strIs( e[ 3 ] ) )
  result.host = e[ 3 ];
  if( _.strIs( e[ 4 ] ) )
  result.port = e[ 4 ];
  if( _.strIs( e[ 5 ] ) )
  result.localWebPath = e[ 5 ];
  if( _.strIs( e[ 6 ] ) )
  result.query = e[ 6 ];
  if( _.strIs( e[ 7 ] ) )
  result.hash = e[ 7 ];

  /* */

  if( o.kind === 'full' )
  {
    let hostWithPort = e[ 2 ] || '';
    result.longPath = hostWithPort + result.localWebPath;
    if( result.protocol )
    result.protocols = result.protocol.split( '+' );
    else
    result.protocols = [];
    if( _.strIs( e[ 2 ] ) )
    result.hostWithPort = e[ 2 ];
    if( _.strIs( result.protocol ) || _.strIs( result.hostWithPort ) )
    result.origin = ( _.strIs( result.protocol ) ? result.protocol + '://' : '//' ) + result.hostWithPort;
    result.full = o.srcPath;
  }
  else if( o.kind === 'consecutive' )
  {
    let hostWithPort = e[ 2 ] || '';
    result.longPath = hostWithPort + result.localWebPath;
    delete result.host;
    delete result.port;
    delete result.localWebPath;
  }

  return result;
}

parse_body.defaults =
{
  srcPath : null,
  kind : 'full',
}

parse_body.components = UriComponents;

parse_body.Kind = [ 'full', 'atomic', 'consecutive' ];

//

/**
 * Method parses URI string, and returns a UrlComponents object.
 * @example
 *
   let uri = 'http://www.site.com:13/path/name?query=here&and=here#anchor'

   wTools.uri.parse( uri );

   // {
   //   protocol : 'http',
   //   hostWithPort : 'www.site.com:13',
   //   localWebPath : /path/name,
   //   query : 'query=here&and=here',
   //   hash : 'anchor',
   //   host : 'www.site.com',
   //   port : '13',
   //   origin : 'http://www.site.com:13'
   // }

 * @param {string} path Url to parse
 * @param {Object} o - parse parameters
    included into result
 * @returns {UrlComponents} Result object with parsed uri components
 * @throws {Error} If passed `path` parameter is not string
 * @function parse
 * @memberof module:Tools/base/Uri.wTools.uri
 */

let parse = _.routineFromPreAndBody( parse_pre, parse_body );

parse.components = UriComponents;

//

let parseFull = _.routineFromPreAndBody( parse_pre, parse_body );
parseFull.defaults.kind = 'full';
parseFull.components = UriComponents;

//

let parseAtomic = _.routineFromPreAndBody( parse_pre, parse_body );
parseAtomic.defaults.kind = 'atomic';

parseAtomic.components = UriComponents;

//

let parseConsecutive = _.routineFromPreAndBody( parse_pre, parse_body );
parseConsecutive.defaults.kind = 'consecutive';

//

function localFromGlobal( globalPath )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.boolLike( globalPath ) )
  return globalPath;

  if( _.strIs( globalPath ) )
  {
    if( !this.isGlobal( globalPath ) )
    return globalPath;

    globalPath = this.parseConsecutive( globalPath );
  }

  _.assert( _.mapIs( globalPath ) ) ;
  _.assert( _.strIs( globalPath.longPath ) );

  return globalPath.longPath;
}

//

/**
 * Assembles uri string from components
 *
 * @example
 *
   let components =
     {
       protocol : 'http',
       host : 'www.site.com',
       port : '13',
       localWebPath : '/path/name',
       query : 'query=here&and=here',
       hash : 'anchor',
     };
   wTools.uri.str( UrlComponents );
   // 'http://www.site.com:13/path/name?query=here&and=here#anchor'
 * @param {UrlComponents} components Components for uri
 * @returns {string} Complete uri string
 * @throws {Error} If `components` is not UrlComponents map
 * @see {@link UrlComponents}
 * @function str
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function str( c )
{
  let self = this;
  let result = '';

  _.assert( c.longPath === undefined || c.longPath === null || longPathHas( c ), 'Codependent components of URI map are not consistent', 'something wrong with {-longPath-}' );
  _.assert( c.protocols === undefined || c.protocols === null || protocolsHas( c ), 'Codependent components of URI map are not consistent', 'something wrong with {-protocols-}' );
  _.assert( c.hostWithPort === undefined || c.hostWithPort === null || hostWithPortHas( c ), 'Codependent components of URI map are not consistent', 'something wrong with {-hostWithPort-}' );
  _.assert( c.origin === undefined || c.origin === null || originHas( c ), 'Codependent components of URI map are not consistent', 'something wrong with {-origin-}' );
  _.assert( c.full === undefined || c.full === null || fullHas( c ), 'Codependent components of URI map are not consistent', 'something wrong with {-full-}' );

  _.assert( _.strIs( c ) || _.mapIs( c ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( c ) )
  return c;

  _.assertMapHasOnly( c, this.UriComponents );

  if( c.full )
  {
    _.assert( _.strDefined( c.full ) );
    return c.full;
  }

  var protocol = c.protocol;
  var host = c.host;
  var port = c.port;

  if( c.origin && ( protocol === null || protocol === undefined ) )
  if( _.strHas( c.origin, '://' ) )
  {
    protocol = _.strIsolateLeftOrNone( c.origin, '://' )[ 0 ];
  }

  if( ( protocol === null || protocol === undefined ) && c.protocols && c.protocols.length )
  protocol = c.protocols.join( '+' );

  if( c.origin && ( host === null || host === undefined ) )
  {
    host = _.strIsolateInsideOrAll( c.origin, '://', ':' )[ 2 ];
  }

  if( c.origin && ( port === null || port === undefined ) )
  if( _.strHas( c.origin, ':' ) )
  {
    port = _.strIsolateRightOrNone( c.origin, ':' )[ 2 ];
  }

  // /* atomic */
  //
  // protocol : null, /* 'svn+http' */
  // host : null, /* 'www.site.com' */
  // port : null, /* '13' */
  // localWebPath : null, /* '/path/name' */
  // query : null, /* 'query=here&and=here' */
  // hash : null, /* 'anchor' */
  //
  // /* composite */
  //
  // longPath : null, /* www.site.com:13/path/name */
  // protocols : null, /* [ 'svn','http' ] */
  // hostWithPort : null, /* 'www.site.com:13' */
  // origin : null, /* 'svn+http://www.site.com:13' */
  // full : null, /* 'svn+http://www.site.com:13/path/name?query=here&and=here#anchor' */

  return fullFrom( c );

  /* */

  return result;

  /**/

  function longPathFrom( c )
  {

    let hostWithPort = c.hostWithPort;
    if( !_.strIs( hostWithPort ) )
    hostWithPort = hostWithPortFrom( c );

    if( _.strIs( c.localWebPath ) )
    {
      if( c.localWebPath && hostWithPort && !_.strBegins( c.localWebPath, self._upStr ) )
      return hostWithPort + self._upStr + c.localWebPath;
      else
      return hostWithPort + c.localWebPath;
    }
    else
    {
      _.assert( _.strBegins( c.longPath, hostWithPort ) );
      return c.longPath;
    }

  }

  /* */

  function longPathHas( c )
  {

    if( c.host )
    if( !_.strBegins( c.longPath, c.host ) )
    return false;

    if( c.port !== undefined && c.port !== null )
    if( !_.strHas( c.longPath, String( c.port ) ) )
    return false;

    if( c.localWebPath )
    if( !_.strEnds( c.longPath, c.localWebPath ) )
    return false;

    return true;
  }

  /* */

  function protocolsFrom( c )
  {
    return protocol.split( '+' );
  }

  /* */

  function protocolsHas( c )
  {
    if( c.protocol !== null && c.protocol !== undefined )
    if( c.protocols.join( '+' ) !== c.protocol )
    return false;
    return true;
  }

  /* */

  function hostWithPortFrom( c )
  {

    // if( host === undefined || host === null )
    // return c.hostWithPort;

    let hostWithPort = '';
    if( _.strIs( host ) )
    hostWithPort = host;
    if( port !== undefined && port !== null )
    if( hostWithPort )
    hostWithPort += ':' + port;
    else
    hostWithPort = ':' + port;
    return hostWithPort;
  }

  /* */

  function hostWithPortHas( c )
  {

    if( c.host )
    if( !_.strBegins( c.hostWithPort, c.host ) )
    return false;

    if( c.port !== null && c.port !== undefined )
    if( !_.strHas( c.hostWithPort, String( c.port ) ) )
    return false;

    return true;
  }

  /* */

  function originFrom( c )
  {
    let result = '';
    let hostWithPort;

    if( c.hostWithPort )
    {
      hostWithPort = c.hostWithPort;
    }
    else
    {
      hostWithPort = hostWithPortFrom( c );
    }

    if( _.strIs( protocol ) && !hostWithPort )
    hostWithPort = '';

    if( _.strIs( protocol ) || _.strIs( hostWithPort ) )
    result += ( _.strIs( protocol ) ? protocol + '://' : '//' ) + hostWithPort;

    return result;
  }

  /* */

  function originHas( c )
  {

    if( c.protocol )
    if( !_.strBegins( c.origin, c.protocol ) )
    return false;

    if( c.host )
    if( !_.strHas( c.origin, c.host ) )
    return false;

    if( c.port !== null && c.port !== undefined )
    if( !_.strHas( c.origin, String( c.port ) ) )
    return false;

    return true;
  }

  /* */

  function fullFrom( c )
  {

    if( _.strIs( protocol ) || _.strIs( c.hostWithPort ) || _.strIs( host ) )
    result += _.strIs( protocol ) ? protocol + '://' : '//';

    if( c.longPath )
    {
      result += c.longPath;
    }
    else
    {
      result += longPathFrom( c );
    }

    /**/

    if( _.mapIs( c.query ) )
    c.query = _.strWebQueryStr({ src : c.query });

    _.assert( !c.query || _.strIs( c.query ) );

    if( c.query !== undefined && c.query !== undefined )
    result += '?' + c.query;

    if( c.hash !== undefined && c.hash !== null )
    result += '#' + c.hash;

    return result;
  }

  /* */

  function fullHas( c )
  {
    if( c.protocol )
    if( !_.strBegins( c.full, c.protocol ) )
    return false;

    if( c.host )
    if( !_.strHas( c.full, c.host ) )
    return false;

    if( c.port !== null && c.port !== undefined )
    if( !_.strHas( c.full, String( c.host ) ) )
    return false;

    if( c.localWebPath )
    if( !_.strHas( c.full, String( c.localWebPath ) ) )
    return false;

    if( c.query )
    if( !_.strHas( c.full, String( c.query ) ) )
    return false;

    if( c.hash )
    if( !_.strHas( c.full, String( c.hash ) ) )
    return false;

    if( c.longPath )
    if( !_.strHas( c.full, String( c.longPath ) ) )
    return false;

    return true;
  }

}

str.components = UriComponents;

//

/**
 * Complements current window uri origin by components passed in o.
 * All components of current origin is replaced by appropriates components from o if they exist.
 * If { o.full } exists and valid, method returns it.
 * @example
 * // current uri http://www.site.com:13/foo/baz
   let components =
   {
     localWebPath : '/path/name',
     query : 'query=here&and=here',
     hash : 'anchor',
   };
   let res = wTools.uri.full( o );
   // 'http://www.site.com:13/path/name?query=here&and=here#anchor'
 *
 * @returns {string} composed uri
 * @function full
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function full( o )
{

  _.assert( arguments.length === 1 );
  _.assert( this.is( o ) || _.mapIs( o ) );

  if( _.strIs( o ) )
  o = this.parseAtomic( o )

  _.assertMapHasOnly( o, this.UriComponents );

  // if( o.full )
  // return this.str( o );

  let serverUri = this.server();
  let serverParsed = this.parseAtomic( serverUri );

  _.mapExtend( serverParsed, o );

  return this.str( serverParsed );
}

//

function refine( filePath )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( filePath ) );

  if( this.isGlobal( filePath ) )
  filePath = this.parseConsecutive( filePath );
  else
  return parent.refine.call( this, filePath );

  if( _.strDefined( filePath.longPath ) )
  filePath.longPath = parent.refine.call( this, filePath.longPath );

  if( filePath.hash )
  filePath.longPath = parent.detrail( filePath.longPath );

  return this.str( filePath );
}

function normalize( filePath )
{
  let parent = this.path;
  _.assert( _.strIs( filePath ), 'Expects string {-filePath-}' );
  if( _.strIs( filePath ) )
  {
    if( this.isGlobal( filePath ) )
    filePath = this.parseConsecutive( filePath );
    else
    return parent.normalize.call( this, filePath );
  }
  _.assert( !!filePath );
  filePath.longPath = parent.normalize.call( this, filePath.longPath );
  return this.str( filePath );
}

//

function canonize( filePath )
{
  let parent = this.path;
  if( _.strIs( filePath ) )
  {
    if( this.isGlobal( filePath ) )
    filePath = this.parseConsecutive( filePath );
    else
    return parent.canonize.call( this, filePath );
  }
  _.assert( !!filePath );
  filePath.longPath = parent.canonize.call( this, filePath.longPath );
  return this.str( filePath );
}

//

function normalizeTolerant( filePath )
{
  let parent = this.path;
  if( _.strIs( filePath ) )
  {
    if( this.isGlobal( filePath ) )
    filePath = this.parseConsecutive( filePath );
    else
    return parent.normalizeTolerant.call( this, filePath );
  }
  _.assert( !!filePath );
  filePath.longPath = parent.normalizeTolerant.call( this, filePath.longPath );
  return this.str( filePath );
}

//

function dot( path )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strDefined( path ) );

  if( !this.isGlobal( path ) )
  return parent.dot.call( this, path );

  path = this.parseConsecutive( path );
  path.longPath = parent.dot( path.longPath );

  return this.str( path );
}

//

function trail( srcPath )
{
  _.assert( arguments.length === 1 );
  return this.path.trail( srcPath );
}

//

function detrail( srcPath )
{
  _.assert( this.is( srcPath ) );
  _.assert( arguments.length === 1 );

  // debugger;
  if( _.strIs( srcPath ) )
  srcPath = this.parseConsecutive( srcPath );

  srcPath.longPath = this.path.detrail( srcPath.longPath );

  return this.str( srcPath );
}

// --
// joiner
// --

function join_functor( gen )
{

  if( arguments.length === 2 )
  gen = { routineName : arguments[ 0 ], web : arguments[ 1 ] }

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assertRoutineOptions( join_functor, gen );

  let routineName = gen.routineName;
  let web = gen.web;

  return function joining()
  {

    let parent = this.path;
    let result = Object.create( null );
    let srcs = [];
    let isGlobal = false;

    /* */

    if( web )
    {

      for( let s = 0 ; s < arguments.length ; s++ )
      {
        if( arguments[ s ] !== null && this.isGlobal( arguments[ s ] ) )
        {
          isGlobal = true;
          srcs[ s ] = this.parseAtomic( arguments[ s ] );
        }
        else
        {
          isGlobal = arguments[ s ] !== null;
          srcs[ s ] = { localWebPath : arguments[ s ] };
        }
      }

    }
    else
    {

      for( let s = 0 ; s < arguments.length ; s++ )
      {
        if( arguments[ s ] !== null && this.isGlobal( arguments[ s ] ) )
        {
          isGlobal = true;
          srcs[ s ] = this.parseConsecutive( arguments[ s ] );
        }
        else
        {
          isGlobal = arguments[ s ] !== null;
          srcs[ s ] = { longPath : arguments[ s ] };
        }
      }

    }

    /* */

    if( web )
    {
      result.localWebPath = undefined;
    }
    else
    {
      result.longPath = undefined;
    }

    /* */

    for( let s = srcs.length-1 ; s >= 0 ; s-- )
    {
      let src = srcs[ s ];

      if( web )
      if( result.protocol && src.protocol )
      if( result.protocol !== src.protocol )
      continue;

      if( !result.protocol && src.protocol !== undefined )
      result.protocol = src.protocol;

      if( web )
      {

        let hostWas = result.host;
        if( !result.host && src.host !== undefined )
        result.host = src.host;

        if( !result.port && src.port !== undefined )
        if( !hostWas || !src.host || hostWas === src.host )
        result.port = src.port;

        if( !result.localWebPath && src.localWebPath !== undefined )
        result.localWebPath = src.localWebPath;
        else if( src.localWebPath )
        result.localWebPath = parent[ routineName ]( src.localWebPath, result.localWebPath );

        if( src.localWebPath === null )
        break;

      }
      else
      {

        if( result.longPath === undefined && src.longPath !== undefined )
        result.longPath = src.longPath;
        else if( src.longPath )
        result.longPath = parent[ routineName ]( src.longPath, result.longPath );

        if( src.longPath === null )
        break;

      }

      if( src.query !== undefined )
      if( !result.query )
      result.query = src.query;
      else
      result.query = src.query + '&' + result.query;

      if( !result.hash && src.hash !==undefined )
      result.hash = src.hash;

    }

    /* */

    if( !isGlobal )
    {
      if( web )
      return result.localWebPath;
      else
      return result.longPath;
    }

    if( result.hash && result.longPath )
    result.longPath = parent.detrail( result.longPath );

    return this.str( result );
  }

}

join_functor.defaults =
{
  routineName : null,
  web : 0,
}

//

let join = join_functor({ routineName : 'join', web : 0 });
let joinRaw = join_functor({ routineName : 'joinRaw', web : 0 });
let reroot = join_functor({ routineName : 'reroot', web : 0 });

//

function resolve()
{
  let parent = this.path;
  let joined = this.join.apply( this, arguments );
  if( joined === null )
  return joined;
  let parsed = this.parseConsecutive( joined );
  parsed.longPath = parent.resolve.call( this, parsed.longPath );
  return this.str( parsed );
}

//

function relative_body( o )
{
  let parent = this.path;

  _.assertRoutineOptions( relative_body, arguments );

  if( !this.isGlobal( o.basePath ) && !this.isGlobal( o.filePath ) )
  {
    let o2 = _.mapExtend( null, o );
    delete o2.global;
    return this._relative( o2 );
  }

  let basePath = this.parseConsecutive( o.basePath );
  let filePath = this.parseConsecutive( o.filePath );

  let o2 = _.mapExtend( null, o );
  delete o2.global;
  o2.basePath = basePath.longPath;
  o2.filePath = filePath.longPath;
  let longPath = parent._relative( o2 );

  if( o.global )
  {
    _.mapExtend( filePath, basePath );
    // _.mapSupplement( basePath, filePath );
    // return this.str( basePath );
  }
  else
  {
    for( let c in filePath )
    {
      if( c === 'longPath' )
      continue;
      if( filePath[ c ] === basePath[ c ] )
      delete filePath[ c ];
    }
  }

  filePath.longPath = longPath;

  return this.str( filePath );
}

var defaults = relative_body.defaults = Object.create( Parent.relative.defaults );
defaults.global = 1; /* qqq : why is this option here? */

let relative = _.routineFromPreAndBody( Parent.relative.pre, relative_body );

//

/*
qqq : teach common to work with path maps and cover it by tests
*/

function common()
{
  let parent = this.path;
  let self = this;
  let uris = _.arrayFlatten( null, arguments );

  for( let s = uris.length-1 ; s >= 0 ; s-- )
  {
    _.assert( !_.mapIs( uris[ s ] ), 'not tested' );
    if( _.mapIs( uris[ s ] ) )
    _.longBut( uris, [ s, s+1 ], _.mapKeys( uris[ s ] ) );
  }

  // _.assert( uris.length, 'Expects at least one argument' );
  _.assert( _.strsAreAll( uris ), 'Expects only strings as arguments' );

  /* */

  if( !uris.length )
  return null;

  /* */

  let isRelative = null;
  for( let i = 0, len = uris.length ; i < len ; i++ )
  {
    uris[ i ] = parse( uris[ i ] );
    let isThisRelative = parent.isRelative.call( this, uris[ i ].longPath );
    _.assert( isRelative === isThisRelative || isRelative === null, 'Attempt to combine relative with absolutue paths' );
    isRelative = isThisRelative;
  }

  /* */

  let result = _.mapExtend( null, uris[ 0 ] );
  let protocol = null;
  let withoutProtocol = 0;

  for( let i = 1, len = uris.length ; i < len ; i++ )
  {

    for( let c in result )
    if( uris[ i ][ c ] !== result[ c ] )
    delete result[ c ];

  }

  /* */

  for( let i = 0, len = uris.length; i < len; i++ )
  {
    let uri = uris[ i ];

    let protocol2 = uri.protocol || '';

    if( protocol === null )
    {
      protocol = uri.protocol;
      continue;
    }

    if( uri.protocol === protocol )
    continue;

    if( uri.protocol && protocol )
    return '';

    withoutProtocol = 1;

  }

  if( withoutProtocol )
  protocol = '';

  result.protocol = protocol;
  result.longPath = result.longPath || uris[ 0 ].longPath;

  /* */

  for( let i = 1, len = uris.length; i < len; i++ )
  {
    let uri = uris[ i ];
    result.longPath = parent._commonPair.call( this, uri.longPath, result.longPath );
  }

  /* */

  return this.str( result );

  /* */

  function parse( uri )
  {
    let result;

    if( _.strIs( uri ) )
    if( self.isGlobal( uri ) )
    {
      result = self.parseConsecutive( uri );
    }
    else
    {
      result = { longPath : uri };
    }

    return result;
  }

}

//

function rebase( srcPath, oldPath, newPath )
{
  let parent = this.path;
  _.assert( arguments.length === 3, 'Expects exactly three arguments' );

  srcPath = this.parseConsecutive( srcPath );
  oldPath = this.parseConsecutive( oldPath );
  newPath = this.parseConsecutive( newPath );

  let dstPath = _.mapExtend( null, srcPath, _.mapSelect( newPath, _.mapKeys( srcPath ) ) );

  // if( srcPath.protocol !== undefined && oldPath.protocol !== undefined )
  // {
  //   if( srcPath.protocol === oldPath.protocol && newPath.protocol === undefined )
  //   delete dstPath.protocol;
  // }
  //
  // if( srcPath.host !== undefined && oldPath.host !== undefined )
  // {
  //   if( srcPath.host === oldPath.host && newPath.host === undefined )
  //   delete dstPath.host;
  // }

  // dstPath.localWebPath = null; xxx
  dstPath.longPath = parent.rebase.call( this, srcPath.longPath, oldPath.longPath, newPath.longPath );

  return this.str( dstPath );
}

//

function name( o )
{
  let parent = this.path;
  if( _.strIs( o ) )
  o = { path : o }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.mapIs( o ) );
  _.assert( _.strIs( o.path ) );
  _.routineOptions( name, o );

  if( !this.isGlobal( o.path ) )
  return parent.name.call( this, o );

  let path = this.parseConsecutive( o.path );

  let o2 = _.mapExtend( null,o );
  o2.path = path.longPath;
  return parent.name.call( this, o2 );
}

name.defaults = Object.create( Parent.name.defaults );

//

function ext( path )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( path ), 'Expects string' );

  if( this.isGlobal( path ) )
  path = this.parseConsecutive( path ).longPath;

  return parent.ext.call( this, path );
}

//

function exts( path )
{
  let parent = this.path;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strDefined( path ) );

  if( this.isGlobal( path ) )
  path = this.parseConsecutive( path ).longPath;

  return parent.exts.call( this, path );
}

//

function changeExt( path, ext )
{
  let parent = this.path;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strDefined( path ) );
  _.assert( _.strIs( ext ) );

  if( !this.isGlobal( path ) )
  return parent.changeExt.call( this, path, ext );

  path = this.parseConsecutive( path );

  path.longPath = parent.changeExt( path.longPath, ext );

  return this.str( path );
}

//

function dir_body( o )
{
  let parent = this.path;

  if( !this.isGlobal( o.filePath ) )
  return parent.dir.body.call( this, o );

  let o2 = _.mapExtend( null, o );
  let filePath = this.parseConsecutive( o.filePath );
  o2.filePath = filePath.longPath
  filePath.longPath = parent.dir.body.call( this, o2 )

  return this.str( filePath );
}

_.routineExtend( dir_body, Parent.dir );

let dir = _.routineFromPreAndBody( Parent.dir.pre, dir_body );
_.mapExtend( dir.defaults, Parent.dir.defaults );

let dirFirst = _.routineFromPreAndBody( Parent.dirFirst.pre, dir_body );
_.mapExtend( dirFirst.defaults, Parent.dirFirst.defaults );

//

function groupTextualReport_pre( routine, args )
{
  let self = this;
  let parent = this.path;

  let o = args[ 0 ];

  _.assert( _.objectIs( o ), 'Expects object' );

  let basePathParsed;

  if( !o.onRelative )
  o.onRelative = function onRelative( basePath, filePath )
  {
    if( !basePathParsed )
    basePathParsed = self.parseConsecutive( basePath );

    let filePathParsed = self.parseConsecutive( filePath );
    filePathParsed.longPath = self.relative( basePathParsed.longPath, filePathParsed.longPath );

    let strOptions = { longPath : filePathParsed.longPath }

    if( !basePathParsed.hash )
    strOptions.hash = filePathParsed.hash;
    if( !basePathParsed.protocol )
    strOptions.protocol = filePathParsed.protocol;
    if( !basePathParsed.query )
    strOptions.query = filePathParsed.query;

    return self.str( strOptions );
  }

  return parent.groupTextualReport.pre.call( self, routine, [ o ] );
}

let groupTextualReport = _.routineFromPreAndBody( groupTextualReport_pre, Parent.groupTextualReport.body );

//

function commonTextualReport( filePath )
{
  let self = this;
  let parent = this.path;

  _.assert( arguments.length === 1  );

  let basePathParsed;
  let o =
  {
    filePath : filePath,
    onRelative : onRelative
  }
  return parent._commonTextualReport.call( self, o );

  /*  */

  function onRelative( basePath, filePath )
  {
    if( !basePathParsed )
    basePathParsed = self.parseConsecutive( basePath );

    let filePathParsed = self.parseConsecutive( filePath );
    filePathParsed.longPath = self.relative( basePathParsed.longPath, filePathParsed.longPath );

    let strOptions = { longPath : filePathParsed.longPath }

    if( !basePathParsed.hash )
    strOptions.hash = filePathParsed.hash;
    if( !basePathParsed.protocol )
    strOptions.protocol = filePathParsed.protocol;
    if( !basePathParsed.query )
    strOptions.query = filePathParsed.query;

    return self.str( strOptions );
  }
}

//

function moveTextualReport_pre( routine, args )
{
  let self = this;
  let parent = this.path;

  let o = args[ 0 ];
  if( args[ 1 ] !== undefined )
  o = { dstPath : args[ 0 ], srcPath : args[ 1 ] }

  _.assert( _.objectIs( o ), 'Expects object' );

  let basePathParsed;

  if( !o.onRelative )
  o.onRelative = function onRelative( basePath, filePath )
  {
    if( !basePathParsed )
    basePathParsed = self.parseConsecutive( basePath );

    let filePathParsed = self.parseConsecutive( filePath );
    filePathParsed.longPath = self.relative( basePathParsed.longPath, filePathParsed.longPath );

    let strOptions = { longPath : filePathParsed.longPath }

    if( !basePathParsed.hash )
    strOptions.hash = filePathParsed.hash;
    if( !basePathParsed.protocol )
    strOptions.protocol = filePathParsed.protocol;
    if( !basePathParsed.query )
    strOptions.query = filePathParsed.query;

    return self.str( strOptions );
  }

  return parent.moveTextualReport.pre.call( self, routine, [ o ] );
}

let moveTextualReport = _.routineFromPreAndBody( moveTextualReport_pre, Parent.moveTextualReport.body );

//

/**
 * Returns origin plus path without query part of uri string.
 * @example
 *
   let path = 'https://www.site.com:13/path/name?query=here&and=here#anchor';
   wTools.uri.uri.documentGet( path, { withoutProtocol : 1 } );
   // 'www.site.com:13/path/name'
 * @param {string} path uri string
 * @param {Object} [o] o - options
 * @param {boolean} o.withoutServer if true rejects origin part from result
 * @param {boolean} o.withoutProtocol if true rejects protocol part from result uri
 * @returns {string} Return document uri.
 * @function documentGet
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function documentGet( path, o )
{
  o = o || Object.create( null );

  if( path === undefined )
  path = _realGlobal_.location.href;

  if( path.indexOf( '//' ) === -1 )
  {
    path = 'http:/' + ( path[ 0 ] === '/' ? '' : '/' ) + path;
  }

  let a = path.split( '//' );
  let b = a[ 1 ].split( '?' );

  /* */

  if( o.withoutServer )
  {
    let i = b[ 0 ].indexOf( '/' );
    if( i === -1 ) i = 0;
    return b[ 0 ].substr( i );
  }
  else
  {
    if( o.withoutProtocol ) return b[0];
    else return a[ 0 ] + '//' + b[ 0 ];
  }

}

documentGet.defaults =
{
  path : null,
  withoutServer : null,
  withoutProtocol : null,
}

//

/**
 * Return origin (protocol + host + port) part of passed `path` string. If missed arguments, returns origin of
 * current document.
 * @example
 *
   let path = 'http://www.site.com:13/path/name?query=here'
   wTools.uri.server( path );
   // 'http://www.site.com:13/'
 * @param {string} [path] uri
 * @returns {string} Origin part of uri.
 * @function server
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function server( path )
{
  let a,b;

  if( path === undefined )
  path = _realGlobal_.location.origin;

  if( path.indexOf( '//' ) === -1 )
  {
    if( path[ 0 ] === '/' ) return '/';
    a = [ '',path ]
  }
  else
  {
    a = path.split( '//' );
    a[ 0 ] += '//';
  }

  b = a[ 1 ].split( '/' );

  return a[ 0 ] + b[ 0 ] + '/';
}

//

/**
 * Returns query part of uri. If method is called without arguments, it returns current query of current document uri.
 * @example
   let uri = 'http://www.site.com:13/path/name?query=here&and=here#anchor',
   wTools.uri.query( uri ); // 'query=here&and=here#anchor'
 * @param {string } [path] uri
 * @returns {string}
 * @function query
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function query( path )
{
  if( path === undefined )
  path = _realGlobal_.location.href;
  if( path.indexOf( '?' ) === -1 ) return '';
  return path.split( '?' )[ 1 ];
}

//

/**
 * Parse a query string passed as a 'query' argument. Result is returned as a dictionary.
 * The dictionary keys are the unique query variable names and the values are decoded from uri query variable values.
 * @example
 *
   let query = 'k1=&k2=v2%20v3&k3=v4_v4';

   let res = wTools.uri.dequery( query );
   // {
   //   k1 : '',
   //   k2 : 'v2 v3',
   //   k3 : 'v4_v4'
   // },

 * @param {string} query query string
 * @returns {Object}
 * @function dequery
 * @memberof module:Tools/base/Uri.wTools.uri
 */

function dequery( query )
{

  let result = Object.create( null );
  query = query || _global.location.search.split('?')[1];
  if( !query || !query.length )
  return result;
  let vars = query.split( '&' );

  for( let i = 0 ; i < vars.length ; i++ )
  {

    let w = vars[ i ].split( '=' );
    w[ 0 ] = decodeURIComponent( w[ 0 ] );
    if( w[ 1 ] === undefined ) w[ 1 ] = '';
    else w[ 1 ] = decodeURIComponent( w[ 1 ] );

    if( (w[ 1 ][ 0 ] == w[ 1 ][ w[ 1 ].length-1 ] ) && ( w[ 1 ][ 0 ] == '"') )
    w[ 1 ] = w[ 1 ].substr( 1,w[ 1 ].length-1 );

    if( result[ w[ 0 ] ] === undefined )
    {
      result[ w[ 0 ] ] = w[ 1 ];
    }
    else if( _.strIs( result[ w[ 0 ] ] ) )
    {
      result[ w[ 0 ] ] = result[ result[ w[ 0 ] ], w[ 1 ] ]
    }
    else
    {
      result[ w[ 0 ] ].push( w[ 1 ] );
    }

  }

  return result;
}

// --
// declare Fields
// --

let Fields =
{

  single : Self,
  UriComponents,

}

// --
// declare routines
// --

let Routines =
{

  // internal

  _filterOnlyUrl,
  _filterNoInnerArray,

  // checker

  is,
  isSafe,
  isRefinedMaybeTrailed,
  isRefined,
  isNormalizedMaybeTrailed,
  isNormalized,
  isAbsolute,
  isRelative,
  isRoot,
  isDotted,
  isTrailed,
  isGlob,

  // transformer

  parse,
  parseFull,
  parseAtomic,
  parseConsecutive,
  // parsedSupplementFull, /* qqq : implement, please. supplement parsed with parseAtomic by extra fields( returning parseFull ) */
  localFromGlobal,

  str,
  full,

  refine,
  normalize,
  canonize,
  normalizeTolerant,

  dot,

  trail,
  detrail,

  // joiner

  join_functor,

  join,
  joinRaw,
  reroot,
  resolve,

  relative,
  common,
  rebase,

  name,
  ext,
  exts,
  changeExt,
  dir,
  dirFirst,

  groupTextualReport,
  commonTextualReport,
  moveTextualReport,

  documentGet,
  server,
  query,
  dequery,

}

_.mapSupplementOwn( Self, Fields );
_.mapSupplementOwn( Self, Routines );

Self.Init();

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

if( typeof module !== 'undefined' )
require( '../l5/Uris.s' );

})();
