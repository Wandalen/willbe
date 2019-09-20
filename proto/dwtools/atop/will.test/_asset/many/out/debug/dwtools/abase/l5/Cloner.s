( function _Cloner_s_() {

'use strict';

/**
 * Collection of routines to copy / clone data structures, no matter how complex and cycled them are. Cloner relies on class relations definition for traversing. Use the module to replicate your data.
  @module Tools/base/Cloner
*/

/**
 * @file Cloner.s.
 */

/**
 * Collection of routines to copy / clone data structures, no matter how complex and cycled them are.
 * @namespace Tools( module::Cloner )
 * @augments wTools
 * @memberof module:Tools/base/Cloner
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );
  _.include( 'wTraverser' );

}

var Self = _global_.wTools;
var _global = _global_;
var _ = _global_.wTools;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

_.assert( !!_._traverser );

// --
// routines
// --

function _cloneMapUp( it )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  /* low copy degree */

  if( it.copyingDegree === 1 )
  {
    it.dst = it.src;
    return _.dont;
  }

  /* copiers */

  if( it.down && _.instanceIs( it.down.dst ) && it.down.dst.Copiers && it.down.dst.Copiers[ it.key ] )
  {
    var copier = it.down.dst.Copiers[ it.key ];
    it.dst = copier.call( it.down.dst, it );
    return;
  }
  else if( it.down && _.instanceIs( it.down.src ) && it.down.src.Copiers && it.down.src.Copiers[ it.key ] )
  {
    var copier = it.down.src.Copiers[ it.key ];
    it.dst = copier.call( it.down.src, it );
    return;
  }

  /* definition */

  if( _.definitionIs( it.src ) )
  {
    it.dst = it.src;
    return _.dont;
  }

  /* map */

  var mapLike = _.mapLike( it.src ) || it.instanceAsMap;

  if( !mapLike && !_.construction.is( it.src ) ) /* ttt */
  {
    debugger;
    throw _.err
    (
      'Complex objets should have ' +
      ( it.iterator.technique === 'data' ? 'traverseData' : 'traverseObject' ) +
      ', but object ' + _.strType( it.src ) + ' at ' + ( it.path || '.' ), 'does not have such method', '\n',
      it.src, '\n',
      'try to mixin wCopyable'
    );
  }

  /* */

  if( it.dst )
  {
  }
  else if( it.proto )
  {
    debugger;
    it.dst = new it.proto.constructor();
  }
  else
  {
    it.dst = _.entityMake( it.src );
  }

  return it;
}

//

function _cloneMapElementUp( it, eit )
{
  var key = eit.key;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( it.iterator === eit.iterator );
  _.assert( it.copyingDegree > 1 );
  _.assert( !_.primitiveIs( it.dst ) );

  if( Config.debug )
  {
    var errd = 'Object does not have ' + key;
    _.assert( ( key in it.dst ) || Object.isExtensible( it.dst ), errd );
  }

  eit.cloningWithSetter = 0;
  if( !it.iterator.deserializing && eit.copyingDegree > 1 && it.dst._Accessors && it.dst._Accessors[ key ] )
  {
    _.assert( eit.copyingDegree > 0, 'not expected' );
    eit.copyingDegree = 1;
    eit.cloningWithSetter = 1;
  }

  return eit;
}

//

function _cloneMapElementDown( it, eit )
{
  var key = eit.key;
  var val = eit.dst;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( it.iterator === eit.iterator );

  if( it.compact )
  {
    val = eit.dst = it.onCompactField( it, eit );
    if( val === undefined )
    return eit;
  }

  let copy = _.accessor._propertyCopyGet( it.dst, key );
  if( copy )
  copy.call( it.dst, _.accessor.copyIterationMake
  ({
    srcInstance : it.src,
    dstInstance : it.dst,
    instanceKey : key,
    value : val,
  }));
  else
  it.dst[ key ] = val;

  if( eit.cloningWithSetter )
  if( Config.debug )
  {
    var errd = 'Component setter "' + key + '" of object "' + it.dst.constructor.name + '" didn\'t copy data, but had to.';
    if( !( _.primitiveIs( eit.src ) || it.dst[ key ] !== eit.src ) )
    {
      debugger;
      it.dst[ key ] = val;
    }
    _.assert( _.primitiveIs( eit.src ) || it.dst[ key ] !== eit.src, errd );
  }

  return eit;
}

//

function _cloneArrayUp( it )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( it.copyingDegree >= 1 );

  /* low copy degree */

  if( it.copyingDegree === 1 )
  {
    it.dst = it.src;
    return _.dont;
  }

  if( it.dst )
  {}
  else if( it.proto )
  {
    debugger;
    it.dst = new it.proto( it.src.length );
  }
  else
  {
    it.dst = [];
  }

  return it;
}

//

function _cloneArrayElementUp( it, eit )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  return eit;
}

//

function _cloneArrayElementDown( it, eit )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  it.dst.push( eit.dst );
  return eit;
}

//

function _cloneBufferUp( src, it )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( it.copyingDegree >= 1 );

  if( it.copyingDegree >= 2 )
  {
    it.dst = _._longClone( it.src );
  }
  else
  {
    it.dst = it.src;
  }

  // return it;
}

//

function _cloner( routine, o )
{
  var routine = routine || _cloner;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.routineOptions( routine, o );

  /* */

  o.onMapUp = [ _._cloneMapUp, o.onMapUp ];
  o.onMapElementUp = [ _._cloneMapElementUp, o.onMapElementUp ];
  o.onMapElementDown = [ _._cloneMapElementDown, o.onMapElementDown ];
  o.onArrayUp = [ _._cloneArrayUp, o.onArrayUp ];
  o.onArrayElementUp = [ _._cloneArrayElementUp, o.onArrayElementUp ];
  o.onArrayElementDown = [ _._cloneArrayElementDown, o.onArrayElementDown ];
  o.onBuffer = [ _._cloneBufferUp, o.onBuffer ];

  var result = _._traverser( routine, o );

  return result;
}

_cloner.iterationDefaults = Object.create( _._traverser.iterationDefaults );
_cloner.defaults = Object.create( _._traverser.defaults );

//

function _cloneAct( it )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  return _._traverseAct( it );
}

//

function _clone( o )
{
  var it = _cloner( _clone, o );
  _.assert( !it.iterator.src || !!it.iterator.rootSrc );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return _cloneAct( it );
}

_clone.defaults = _cloner.defaults;
_clone.iterationDefaults = _cloner.iterationDefaults;

// --
//
// --

/**
 * @summary Short-cut for clone routine. Clones source entity( src ) with default options.
 * @param {} src Entity to clone.
 * @function cloneJust
 * @memberof module:Tools/base/Cloner.Tools( module::Cloner )
*/

function cloneJust( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  var o = Object.create( null );
  o.src = src;

  _.routineOptions( cloneJust, o );

  return _._clone( o );
}

cloneJust.defaults =
{
  technique : 'object',
}

cloneJust.defaults.__proto__ = _clone.defaults;

//

/**
 * @summary Clones source entity( src ). Returns new entity as copy of source( src ).
 * @description
 * If source entity( src ) is instance of a class, then result object will be also an instance of same class.
 * @param {} src Entity to clone.
 * @function cloneObject
 * @memberof module:Tools/base/Cloner.Tools( module::Cloner )
*/

function cloneObject( o )
{
  if( o.rootSrc === undefined )
  o.rootSrc = o.src;
  _.routineOptions( cloneObject, o );
  var result = _clone( o );
  return result;
}

cloneObject.defaults =
{
  copyingAssociates : 1,
  technique : 'object',
}

cloneObject.defaults.__proto__ = _clone.defaults;

//

function cloneObjectMergingBuffers( o )
{
  var result = Object.create( null );
  var src = o.src;
  var descriptorsMap = o.src.descriptorsMap;
  var buffer = o.src.buffer;
  var data = o.src.data;

  if( o.rootSrc === undefined )
  o.rootSrc = o.src;

  _.routineOptions( cloneObjectMergingBuffers, o );

  _.assert( _.objectIs( o.src.descriptorsMap ) );
  _.assert( _.bufferRawIs( o.src.buffer ) );
  _.assert( o.src.data !== undefined );
  _.assert( arguments.length === 1 )

  /* */

  var optionsForCloneObject = _.mapOnly( o, _.cloneObject.defaults );
  optionsForCloneObject.src = data;

  /* onString */

  optionsForCloneObject.onString = function onString( strString, it )
  {

    _.assert( arguments.length === 2, 'Expects exactly two arguments' );

    var id = _.strUnjoin( strString, [ '--buffer-->', _.strUnjoin.any, '<--buffer--' ] )

    if( id === undefined )
    return strString;

    var descriptor = descriptorsMap[ strString ];
    _.assert( descriptor !== undefined );

    var bufferConstructor = _global[ descriptor[ 'bufferConstructorName' ] ];
    var offset = descriptor[ 'offset' ];
    var size = descriptor[ 'size' ];
    var sizeOfAtom = descriptor[ 'sizeOfAtom' ];
    var result = bufferConstructor ? new bufferConstructor( buffer, offset, size / sizeOfAtom ) : null;

    it.dst = result;

    return result;
  }

  optionsForCloneObject.onInstanceCopy = function onInstanceCopy( src, it )
  {

    _.assert( arguments.length === 2, 'Expects exactly two arguments' );

    var newIt = it.iterationClone();
    newIt.dst = null;
    newIt.proto = null;

    var technique = newIt.iterator.technique;
    newIt.iterator.technique = 'data';
    newIt.usingInstanceCopy = 0;
    _._cloneAct( newIt );
    newIt.iterator.technique = technique;

    it.src = newIt.dst;

  }

  /* clone object */

  var result = _.cloneObject( optionsForCloneObject );

  return result;
}

cloneObjectMergingBuffers.defaults =
{
  copyingBuffers : 1,
}

cloneObjectMergingBuffers.defaults.__proto__ = cloneObject.defaults;

//

/**
 * @summary Clones source entity( src ).
 * @description Returns map that is ready for serialization. Can contain maps, arrays and primitives, but don't contain objects or class instances.
 * @param {} src Entity to clone.
 * @function cloneData
 * @memberof module:Tools/base/Cloner.Tools( module::Cloner )
*/

function cloneData( o )
{

  _.routineOptions( cloneData, o );

  var result = _clone( o );

  return result;
}

cloneData.defaults =
{
  technique : 'data',
  copyingAssociates : 0,
}

cloneData.defaults.__proto__ = _clone.defaults;

//

function cloneDataSeparatingBuffers( o )
{
  var result = Object.create( null );
  var buffers = [];
  var descriptorsArray = [];
  var descriptorsMap = Object.create( null );
  var size = 0;
  var offset = 0;

  _.routineOptions( cloneDataSeparatingBuffers, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  /* onBuffer */

  o.onBuffer = function onBuffer( srcBuffer, it )
  {

    _.assert( arguments.length === 2, 'Expects exactly two arguments' );
    _.assert( _.bufferTypedIs( srcBuffer ), 'not tested' );

    var index = buffers.length;
    var id = _.strJoin([ '--buffer-->', index, '<--buffer--' ]);
    var bufferSize = srcBuffer ? srcBuffer.length*srcBuffer.BYTES_PER_ELEMENT : 0;
    size += bufferSize;

    var descriptor =
    {
      'bufferConstructorName' : srcBuffer ? srcBuffer.constructor.name : 'null',
      'sizeOfAtom' : srcBuffer ? srcBuffer.BYTES_PER_ELEMENT : 0,
      'offset' : -1,
      'size' : bufferSize,
      'index' : index,
    }

    buffers.push( srcBuffer );
    descriptorsArray.push( descriptor );
    descriptorsMap[ id ] = descriptor;

    it.dst = id;

  }

  /* clone data */

  result.data = _._clone( o );
  result.descriptorsMap = descriptorsMap;

  /* sort by atom size */

  descriptorsArray.sort( function( a, b )
  {
    return b[ 'sizeOfAtom' ] - a[ 'sizeOfAtom' ];
  });

  /* alloc */

  result.buffer = new ArrayBuffer( size );
  var dstBuffer = _.bufferBytesGet( result.buffer );

  /* copy buffers */

  for( var b = 0 ; b < descriptorsArray.length ; b++ )
  {

    var descriptor = descriptorsArray[ b ];
    var buffer = buffers[ descriptor.index ];
    var bytes = buffer ? _.bufferBytesGet( buffer ) : new Uint8Array();
    var bufferSize = descriptor[ 'size' ];

    descriptor[ 'offset' ] = offset;

    _.bufferMove( dstBuffer.subarray( offset, offset+bufferSize ), bytes );

    offset += bufferSize;

  }

  return result;
}

cloneDataSeparatingBuffers.defaults =
{
  copyingBuffers : 1,
}

cloneDataSeparatingBuffers.defaults.__proto__ = cloneData.defaults;

// --
// declare
// --

var Proto =
{

  _cloneMapUp,
  _cloneMapElementUp,
  _cloneMapElementDown,
  _cloneArrayUp,
  _cloneArrayElementUp,
  _cloneArrayElementDown,
  _cloneBufferUp,

  _cloner,
  _cloneAct,
  _clone,

  //

  cloneJust,
  cloneObject,
  cloneObjectMergingBuffers, /* experimental */
  cloneData,
  cloneDataSeparatingBuffers, /* experimental */

}

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
