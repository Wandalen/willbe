(function _Path_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../UseBase.s' );

  let _global = _global_;
  let _ = _global_.wTools;

  _.include( 'wPathBasic' );

}

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools.path;

_.assert( _.objectIs( Self ) );

// --
// functor
// --

function _vectorizeKeysAndVals( routine, select )
{
  select = select || 1;

  let routineName = routine.name;

  _.assert( _.routineIs( routine ) );
  _.assert( _.strDefined( routineName ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  let routine2 = _.routineVectorize_functor
  ({
    routine : [ routineName ],
    vectorizingArray : 1,
    vectorizingMapVals : 1,
    vectorizingMapKeys : 1,
    select : select,
  });

  _.routineExtend( routine2, routine );

  return routine2;
}

// --
// routines
// --

/**
 * Returns absolute path to file. Accepts file record object. If as argument passed string, method returns it.
 * @example
 * let str = 'foo/bar/baz',
    fileRecord = FileRecord( str );
   let path = wTools.path.from( fileRecord ); // '/home/user/foo/bar/baz';
 * @param {string|wFileRecord} src file record or path string
 * @returns {string}
 * @throws {Error} If missed argument, or passed more then one.
 * @throws {Error} If type of argument is not string or wFileRecord.
 * @function from
 * @memberof module:Tools/PathBasic.wTools.path
 */

function from( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  return src;
  else if( src instanceof _.FileRecord )
  return src.absolute;
  else _.assert( 0, 'Expects string, but got', _.strType( src ) );

}

//

/**
 * @summary Converts source path `src` to platform-specific path.
 * @param {String} src Source path.
 * @function nativize
 * @memberof module:Tools/PathBasic.wTools.path
*/

function nativize( src )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( this.fileProvider.pathNativizeAct ) );
  return this.fileProvider.pathNativizeAct( src );
}

//

/**
 * Returns the current working directory of the Node.js process. If as argument passed path to existing directory,
   method sets current working directory to it. If passed path is an existing file, method set its parent directory
   as current working directory.
 * @param {string} [path] path to set current working directory.
 * @returns {string}
 * @throws {Error} If passed more than one argument.
 * @throws {Error} If passed path to not exist directory.
 * @function current
 * @memberof module:Tools/PathBasic.wTools.path
 */

function current()
{
  let path = this;
  let provider = this.fileProvider;

  _.assert( _.objectIs( provider ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.routineIs( provider.pathCurrentAct ) );
  _.assert( _.routineIs( path.isAbsolute ) );

  if( arguments[ 0 ] )
  try
  {

    let filePath = arguments[ 0 ];
    _.assert( _.strIs( filePath ), 'Expects string' );

    if( !path.isAbsolute( filePath ) )
    filePath = path.join( provider.pathCurrentAct(), filePath );

    if( provider.fileExists( filePath ) && provider.isTerminal( filePath ) )
    filePath = path.resolve( filePath, '..' );

    provider.pathCurrentAct( filePath );

  }
  catch( err )
  {
    throw _.err( 'File was not found : ' + arguments[ 0 ] + '\n', err );
  }

  let result = provider.pathCurrentAct();

  _.assert( _.strIs( result ) );

  result = path.normalize( result );

  return result;
}

//

/**
 * @summary Converts global path `globalPath` to local.
 * @param {String} globalPath Source path.
 * @function preferredFromGlobal
 * @memberof module:Tools/PathBasic.wTools.path
*/

function preferredFromGlobal( globalPath )
{
  let path = this;
  let provider = this.fileProvider;
  return provider.preferredFromGlobalAct( globalPath );
}

//

/**
 * @summary Converts local path `localPath` to global.
 * @param {String} localPath Source path.
 * @function globalFromPreferred
 * @memberof module:Tools/PathBasic.wTools.path
*/

function globalFromPreferred( localPath )
{
  let path = this;
  let provider = this.fileProvider;
  return provider.globalFromPreferredAct( localPath );
}

//

function hasLocally( filePath )
{
  let path = this;
  let provider = this.fileProvider;

  if( !path.isGlobal( filePath ) )
  return true;

  let parsed = _.uri.parse( filePath );

  if( !parsed.protocol )
  return true;

  if( _.arrayHas( provider.protocols, parsed.protocol ) )
  return true;

  return false;
}

// --
// declare
// --

let Proto =
{

  from,
  // pathsFrom,

  preferredFromGlobal,
  localsFromGlobals : _vectorizeKeysAndVals( preferredFromGlobal ),
  globalFromPreferred,
  globalsFromLocals : _vectorizeKeysAndVals( globalFromPreferred ),

  nativize,
  current,
  hasLocally,

}

_.mapExtend( Self, Proto );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
