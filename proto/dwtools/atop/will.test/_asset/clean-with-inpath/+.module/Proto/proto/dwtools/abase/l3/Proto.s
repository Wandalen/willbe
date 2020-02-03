( function _Proto_s_() {

'use strict';

/**
 * Collection of routines to define classes and relations between them.
 * @namespace Tools( module::Proto )
 * @augments wTools
 * @memberof module:Tools/base/Proto
 */

/**
* Definitions :

*  self :: current object.
*  Self :: current class.
*  Parent :: parent class.
*  Statics :: static fields.
*  extend :: extend destination with all properties from source.
*  supplement :: supplement destination with those properties from source which do not belong to source.

*  routine :: arithmetical, logical and other manipulations on input data, context and globals to get output data.
*  function :: routine which does not have side effects and don't use globals or context.
*  procedure :: routine which use globals, possibly modify global's states.
*  method :: routine which has context, possibly modify context's states.

* Synonym :

  A composes B
    :: A consists of B.s
    :: A comprises B.
    :: A made up of B.
    :: A exists because of B, and B exists because of A.
    :: A складається із B.
  A aggregates B
    :: A has B.
    :: A exists because of B, but B exists without A.
    :: A має B.
  A associates B
    :: A has link on B
    :: A is linked with B
    :: A посилається на B.
  A restricts B
    :: A use B.
    :: A has occasional relation with B.
    :: A використовує B.
    :: A має обмежений, не чіткий, тимчасовий звязок із B.

*/

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;
let _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.field ), 'wProto needs Tools/dwtools/abase/l1/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ), 'wProto needs Tools/dwtools/l3/NameTools.s' );

//

function constructorIsStandard( cls )
{

  _.assert( _.constructorIs( cls ) );

  let prototype = _.prototypeOf( cls );

  return _.prototypeIsStandard( prototype );
}

//

function constructorOf( src )
{
  let proto;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _ObjectHasOwnProperty.call( src, 'constructor' ) )
  {
    proto = src; /* proto */
  }
  else if( _ObjectHasOwnProperty.call( src, 'prototype' )  )
  {
    if( src.prototype )
    proto = src.prototype; /* constructor */
    else
    proto = Object.getPrototypeOf( Object.getPrototypeOf( src ) ); /* instance behind ruotine */
  }
  else
  {
    proto = Object.getPrototypeOf( src ); /* instance */
  }

  if( proto === null )
  return null;
  else
  return proto.constructor;
}

//

function isSubClassOf( subCls, cls )
{

  _.assert( _.routineIs( cls ) );
  _.assert( _.routineIs( subCls ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( cls === subCls )
  return true;

  return Object.isPrototypeOf.call( cls.prototype, subCls.prototype );
}

//

function isSubPrototypeOf( sub, parent )
{

  _.assert( !!parent );
  _.assert( !!sub );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( parent === sub )
  return true;

  return Object.isPrototypeOf.call( parent, sub );

}

//

/**
 * Get parent's constructor.
 * @function parentOf
 * @memberof wCopyable#
 */

function parentOf( src )
{
  let c = _.constructorOf( src );

  _.assert( arguments.length === 1, 'Expects single argument' );

  let proto = Object.getPrototypeOf( c.prototype );
  let result = proto ? proto.constructor : null;

  return result;
}

//

function _classConstructorAndPrototypeGet( o )
{
  let result = Object.create( null );

  if( !result.cls )
  if( o.prototype )
  result.cls = o.prototype.constructor;

  if( !result.cls )
  if( o.extend )
  if( o.extend.constructor !== Object.prototype.constructor )
  result.cls = o.extend.constructor;

  if( !result.cls )
  if( o.usingStatics && o.extend && o.extend.Statics )
  if( o.extend.Statics.constructor !== Object.prototype.constructor )
  result.cls = o.extend.Statics.constructor;

  if( !result.cls )
  if( o.supplement )
  if( o.supplement.constructor !== Object.prototype.constructor )
  result.cls = o.supplement.constructor;

  if( !result.cls )
  if( o.usingStatics && o.supplement && o.supplement.Statics )
  if( o.supplement.Statics.constructor !== Object.prototype.constructor )
  result.cls = o.supplement.Statics.constructor;

  if( o.prototype )
  result.prototype = o.prototype;
  else if( result.cls )
  result.prototype = result.cls.prototype;

  if( o.prototype )
  _.assert( result.cls === o.prototype.constructor );

  return result;
}

// --
// prototype
// --

function prototypeOf( src )
{
  _.assert( arguments.length === 1, 'Expects single argument, probably you want routine isPrototypeOf' );

  if( !( 'constructor' in src ) )
  return null;

  let c = _.constructorOf( src );

  _.assert( arguments.length === 1, 'Expects single argument' );

  return c.prototype;
}

//

/**
 * Make united interface for several maps. Access to single map cause read and write to original maps.
 * @param {array} protos - maps to united.
 * @return {object} united interface.
 * @function prototypeUnitedInterface
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function prototypeUnitedInterface( protos )
{
  let result = Object.create( null );
  let unitedArraySymbol = Symbol.for( '_unitedArray_' );
  let unitedMapSymbol = Symbol.for( '_unitedMap_' );
  let protoMap = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.arrayIs( protos ) );

  //

  function get( fieldName )
  {
    return function unitedGet()
    {
      return this[ unitedMapSymbol ][ fieldName ][ fieldName ];
    }
  }
  function set( fieldName )
  {
    return function unitedSet( value )
    {
      this[ unitedMapSymbol ][ fieldName ][ fieldName ] = value;
    }
  }

  //

  for( let p = 0 ; p < protos.length ; p++ )
  {
    let proto = protos[ p ];
    for( let f in proto )
    {
      if( f in protoMap )
      throw _.err( 'prototypeUnitedInterface :', 'several objects try to unite have same field :', f );
      protoMap[ f ] = proto;

      let methods = Object.create( null )
      methods[ f + 'Get' ] = get( f );
      methods[ f + 'Set' ] = set( f );
      let names = Object.create( null );
      names[ f ] = f;
      _.accessor.declare
      ({
        object : result,
        names,
        methods,
        strict : 0,
        prime : 0,
      });

    }
  }

  /*result[ unitedArraySymbol ] = protos;*/
  result[ unitedMapSymbol ] = protoMap;

  return result;
}

//

/**
 * Append prototype to object. Find archi parent and replace its proto.
 * @param {object} dstMap - dst object to append proto.
 * @function prototypeAppend
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function prototypeAppend( dstMap )
{

  _.assert( _.objectIs( dstMap ) );

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    let proto = arguments[ a ];

    _.assert( _.objectIs( proto ) );

    let parent = _.prototypeArchyGet( dstMap );
    Object.setPrototypeOf( parent, proto );

  }

  return dstMap;
}

//

/**
 * Returns parent which has default proto.
 * @param {object} srcPrototype - dst object to append proto.
 * @function prototypeArchyGet
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function prototypeArchyGet( srcPrototype )
{

  _.assert( _.objectIs( srcPrototype ) );

  while( Object.getPrototypeOf( srcPrototype ) !== Object.prototype )
  srcPrototype = Object.getPrototypeOf( srcPrototype );

  return srcPrototype;
}

//

function prototypeHasField( src, fieldName )
{
  let prototype = _.prototypeOf( src );

  _.assert( _.prototypeIsStandard( prototype ), 'Expects standard prototype' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( fieldName ) );

  for( let f in _.DefaultFieldsGroupsRelations )
  if( prototype[ f ][ fieldName ] !== undefined )
  return true;

  return false;
}

//

/*
_.prototypeCrossRefer
({
  namespace : _,
  entities :
  {
    System : Self,
  },
  names :
  {
    System : 'LiveSystem',
    Node : 'LiveNode',
  },
});
*/

let _protoCrossReferAssociations = Object.create( null );
function prototypeCrossRefer( o )
{
  let names = _.mapKeys( o.entities );
  let length = names.length;

  let association = _protoCrossReferAssociations[ o.name ];
  if( !association )
  {
    _.assert( _protoCrossReferAssociations[ o.name ] === undefined );
    association = _protoCrossReferAssociations[ o.name ] = Object.create( null );
    association.name = o.name;
    association.length = length;
    association.have = 0;
    association.entities = _.mapExtend( null, o.entities );
  }
  else
  {
    _.assert( _.arraySetIdentical( _.mapKeys( association.entities ), _.mapKeys( o.entities ) ), 'cross reference should have same associations' );
  }

  _.assert( association.name === o.name );
  _.assert( association.length === length );

  for( let e in o.entities )
  {
    if( !association.entities[ e ] )
    association.entities[ e ] = o.entities[ e ];
    else if( o.entities[ e ] )
    _.assert( association.entities[ e ] === o.entities[ e ] );
  }

  association.have = 0;
  for( let e in association.entities )
  if( association.entities[ e ] )
  association.have += 1;

  if( association.have === association.length )
  {

    for( let src in association.entities )
    for( let dst in association.entities )
    {
      if( src === dst )
      continue;
      let dstEntity = association.entities[ dst ];
      let srcEntity = association.entities[ src ];
      _.assert( !dstEntity[ src ] || dstEntity[ src ] === srcEntity, 'override of entity', src );
      _.assert( !dstEntity.prototype[ src ] || dstEntity.prototype[ src ] === srcEntity );
      _.classExtend( dstEntity, { Statics : { [ src ] : srcEntity } } );
      _.assert( dstEntity[ src ] === srcEntity );
      _.assert( dstEntity.prototype[ src ] === srcEntity );
    }

    _protoCrossReferAssociations[ o.name ] = null;

    return true;
  }

  return false;
}

prototypeCrossRefer.defaults =
{
  entities : null,
  name : null,
}

// //
//
// /**
//  * Iterate through prototypes.
//  * @param {object} proto - prototype
//  * @function prototypeEach
//  * @memberof module:Tools/base/Proto.Tools( module::Proto )
//  */
//
// function prototypeEach( proto, onEach )
// {
//   let result = [];
//
//   _.assert( _.routineIs( onEach ) || !onEach );
//   _.assert( !_.primitiveIs( proto ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   do
//   {
//     if( onEach )
//     onEach.call( this, proto );
//     result.push( proto );
//     proto = Object.getPrototypeOf( proto );
//   }
//   while( proto );
//
//   return result;
// }
//
// //
//
// function prototypeEach_deprecated( proto, onEach )
// {
//   let result = [];
//
//   _.assert( _.routineIs( onEach ) || !onEach );
//   _.assert( _.objectIs( proto ) );
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//
//   do
//   {
//
//     if( onEach )
//     onEach.call( this, proto );
//
//     result.push( proto );
//
//     let parent = _.parentOf( proto );
//
//     proto = parent ? parent.prototype : null;
//
//     if( proto && proto.constructor === Object )
//     proto = null;
//
//   }
//   while( proto );
//
//   return result;
// }

// --
// instance
// --

function instanceIsStandard( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.instanceIs( src ) )
  return false;

  let proto = _.prototypeOf( src );

  if( !proto )
  return false;

  return _.prototypeIsStandard( proto );
}

// --
// property
// --

function propertyDescriptorActiveGet( object, name )
{
  let result = Object.create( null );
  result.object = null;
  result.descriptor = null;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  do
  {
    let descriptor = Object.getOwnPropertyDescriptor( object, name );
    if( descriptor && !( 'value' in descriptor ) )
    {
      result.descriptor = descriptor;
      result.object = object;
      return result;
    }
    object = Object.getPrototypeOf( object );
  }
  while( object );

  return result;
}

//

function propertyDescriptorGet( object, name )
{
  let result = Object.create( null );
  result.object = null;
  result.descriptor = null;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  do
  {
    let descriptor = Object.getOwnPropertyDescriptor( object, name );
    if( descriptor )
    {
      result.descriptor = descriptor;
      result.object = object;
      return result;
    }
    object = Object.getPrototypeOf( object );
  }
  while( object );

  return result;
}

// --
// field
// --

/**
 * @summary Defines hidden property with name( name ) and value( value ) on target object( dstPrototype ).
 *
 * @description
 * Property is defined as not enumarable.
 * Also accepts second argument as map of properties.
 * If second argument( name ) is a map and third argument( value ) is also defined, then all properties will have value of last arg.
 *
 * @param {Object} dstPrototype - target object
 * @param {String|Object} name - name of property or map of names
 * @param {*} value - destination object
 *
 * @throws {Exception} If number of arguments is not supported.
 * @throws {Exception} If dstPrototype is not an Object
   * @function propertyHide
 *
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function propertyHide( dstPrototype, name, value )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( !_.primitiveIs( dstPrototype ), () => 'dstPrototype is needed, but got ' + _.toStrShort( dstPrototype ) );

  if( _.containerIs( name ) )
  {
    if( !_.objectIs( name ) )
    debugger;
    if( !_.objectIs( name ) )
    name = _.indexExtending( name, ( e ) => { return { [ e ] : undefined } } );
    _.each( name, ( v, n ) =>
    {
      if( value !== undefined )
      _.propertyHide( dstPrototype, n, value );
      else
      _.propertyHide( dstPrototype, n, v );
    });
    return;
  }

  if( value === undefined )
  value = dstPrototype[ name ];

  _.assert( _.strIs( name ), 'name is needed, but got', name );

  Object.defineProperty( dstPrototype, name,
  {
    value,
    enumerable : false,
    writable : true,
    configurable : true,
  });

}

//

/**
 * Makes constants properties on object by creating new or replacing existing properties.
 * @param {object} dstPrototype - prototype of class which will get new constant property.
 * @param {object} namesObject - name/value map of constants.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Constants = { num : 100  };
 * _.propertyConstant( Self.prototype, Constants );
 * console.log( Self.prototype ); // returns { num: 100 }
 * Self.prototype.num = 1;// error assign to read only property
 *
 * @function propertyConstant
 * @throws {exception} If no argument provided.
 * @throws {exception} If( dstPrototype ) is not a Object.
 * @throws {exception} If( name ) is not a Map.
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function propertyConstant( dstPrototype, name, value )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( !_.primitiveIs( dstPrototype ), () => 'dstPrototype is needed, but got ' + _.toStrShort( dstPrototype ) );

  if( _.containerIs( name ) )
  {
    if( !_.objectIs( name ) )
    debugger;
    if( !_.objectIs( name ) )
    name = _.indexExtending( name, ( e ) => { return { [ e ] : undefined } } );
    _.each( name, ( v, n ) =>
    {
      if( value !== undefined )
      _.propertyConstant( dstPrototype, n, value );
      else
      _.propertyConstant( dstPrototype, n, v );
    });
    return;
  }

  if( value === undefined )
  value = dstPrototype[ name ];

  _.assert( _.strIs( name ), 'name is needed, but got', name );

  Object.defineProperty( dstPrototype, name,
  {
    value,
    enumerable : true,
    writable : false,
    configurable : false,
  });

}

// --
// proxy
// --

function proxyNoUndefined( ins )
{

  let validator =
  {
    set : function( obj, k, e )
    {
      if( obj[ k ] === undefined )
      throw _.err( 'Map does not have field', k );
      obj[ k ] = e;
      return true;
    },
    get : function( obj, k )
    {
      if( !_.symbolIs( k ) )
      if( obj[ k ] === undefined )
      throw _.err( 'Map does not have field', k );
      return obj[ k ];
    },

  }

  let result = new Proxy( ins, validator );

  return result;
}

//

function proxyReadOnly( ins )
{

  let validator =
  {
    set : function( obj, k, e )
    {
      throw _.err( 'Read only', _.strType( ins ), ins );
    }
  }

  let result = new Proxy( ins, validator );

  return result;
}

//

function ifDebugProxyReadOnly( ins )
{

  if( !Config.debug )
  return ins;

  return _.proxyReadOnly( ins );
}

//

// function proxyMap( front, back )
function proxyMap( o )
{

  if( arguments.length === 2 )
  o = { front : arguments[ 0 ], back : arguments[ 1 ] }
  o = _.routineOptions( proxyMap, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !!o.front );
  _.assert( !!o.back );
  let back = o.back;

  let handler =
  {
    get : function( front, key, proxy )
    {
      if( front[ key ] !== undefined )
      return front[ key ];
      return back[ key ];
    },
    set : function( front, key, val, proxy )
    {
      if( front[ key ] !== undefined )
      front[ key ] = val;
      else if( back[ key ] !== undefined )
      back[ key ] = val;
      else
      front[ key ] = val;
      return true;
    },
  }

  let result = new Proxy( o.front, handler );

  return result;
}

proxyMap.defaults =
{
  front : null,
  back : null,
}

//

function proxyShadow( o )
{

  if( arguments.length === 2 )
  o = { front : arguments[ 0 ], back : arguments[ 1 ] }
  o = _.routineOptions( proxyShadow, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !!o.front );
  _.assert( !!o.back );
  let front = o.front;

  let handler =
  {
    get : function( back, key, context )
    {
      if( front[ key ] !== undefined )
      return front[ key ];
      return Reflect.get( ... arguments );
    },
    set : function( back, key, val, context )
    {
      if( front[ key ] !== undefined )
      {
        front[ key ] = val;
        return true;
      }
      return Reflect.set( ... arguments );
    },
  };

  let shadowProxy = new Proxy( o.back, handler );

  return shadowProxy;
}

proxyShadow.defaults =
{
  front : null,
  back : null,
}

// --
// default
// --

/*
apply default to each element of map, if present
*/

function defaultApply( src )
{

  _.assert( _.objectIs( src ) || _.longIs( src ) );

  let defVal = src[ _.def ];

  if( !defVal )
  return src;

  _.assert( _.objectIs( src ) );

  if( _.objectIs( src ) )
  {

    for( let s in src )
    {
      if( !_.objectIs( src[ s ] ) )
      continue;
      _.mapSupplement( src[ s ], defVal );
    }

  }
  else
  {

    for( let s = 0 ; s < src.length ; s++ )
    {
      if( !_.objectIs( src[ s ] ) )
      continue;
      _.mapSupplement( src[ s ], defVal );
    }

  }

  return src;
}

//

/*
activate default proxy
*/

function defaultProxy( map )
{

  _.assert( _.objectIs( map ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  let validator =
  {
    set : function( obj, k, e )
    {
      obj[ k ] = _.defaultApply( e );
      return true;
    }
  }

  let result = new Proxy( map, validator );

  for( let k in map )
  {
    _.defaultApply( map[ k ] );
  }

  return result;
}

//

function defaultProxyFlatteningToArray( src )
{
  let result = [];

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( src ) || _.arrayIs( src ) );

  function flatten( src )
  {

    if( _.arrayIs( src ) )
    {
      for( let s = 0 ; s < src.length ; s++ )
      flatten( src[ s ] );
    }
    else
    {
      if( _.objectIs( src ) )
      result.push( defaultApply( src ) );
      else
      result.push( src );
    }

  }

  flatten( src );

  return result;
}

// --
// type
// --

class wCallableObject extends Function
{
  constructor()
  {
    super( 'return this.routine.__call__.apply( this.routine, arguments );' );
    let context = Object.create( null );
    let routine = this.bind( context );
    context.routine = routine;
    Object.freeze( context );
    return routine;
  }
}

wCallableObject.shortName = 'CallableObject';

_.assert( wCallableObject.shortName === 'CallableObject' );

// --
// fields
// --

let Combining = [ 'rewrite', 'supplement', 'apppend', 'prepend' ];

/**
 * @typedef {Object} DefaultFieldsGroups - contains predefined class fields groups.
 * @memberof module:Tools/base/Proto
 */

/**
 * @typedef {Object} DefaultFieldsGroupsRelations - contains predefined class relationship types.
 * @memberof module:Tools/base/Proto
 */

/**
 * @typedef {Object} DefaultFieldsGroupsCopyable - contains predefined copyable class fields groups.
 * @memberof module:Tools/base/Proto
 */

/**
 * @typedef {Object} DefaultFieldsGroupsTight
 * @memberof module:Tools/base/Proto
 */

/**
 * @typedef {Object} DefaultFieldsGroupsInput
 * @memberof module:Tools/base/Proto
 */

/**
 * @typedef {Object} DefaultForbiddenNames - contains names of forbidden properties
 * @memberof module:Tools/base/Proto
 */

let DefaultFieldsGroups = Object.create( null );
DefaultFieldsGroups.Groups = 'Groups';
DefaultFieldsGroups.Composes = 'Composes';
DefaultFieldsGroups.Aggregates = 'Aggregates';
DefaultFieldsGroups.Associates = 'Associates';
DefaultFieldsGroups.Restricts = 'Restricts';
DefaultFieldsGroups.Medials = 'Medials';
DefaultFieldsGroups.Statics = 'Statics';
DefaultFieldsGroups.Copiers = 'Copiers';
Object.freeze( DefaultFieldsGroups );

let DefaultFieldsGroupsRelations = Object.create( null );
DefaultFieldsGroupsRelations.Composes = 'Composes';
DefaultFieldsGroupsRelations.Aggregates = 'Aggregates';
DefaultFieldsGroupsRelations.Associates = 'Associates';
DefaultFieldsGroupsRelations.Restricts = 'Restricts';
Object.freeze( DefaultFieldsGroupsRelations );

let DefaultFieldsGroupsCopyable = Object.create( null );
DefaultFieldsGroupsCopyable.Composes = 'Composes';
DefaultFieldsGroupsCopyable.Aggregates = 'Aggregates';
DefaultFieldsGroupsCopyable.Associates = 'Associates';
Object.freeze( DefaultFieldsGroupsCopyable );

let DefaultFieldsGroupsTight = Object.create( null );
DefaultFieldsGroupsTight.Composes = 'Composes';
DefaultFieldsGroupsTight.Aggregates = 'Aggregates';
Object.freeze( DefaultFieldsGroupsTight );

let DefaultFieldsGroupsInput = Object.create( null );
DefaultFieldsGroupsInput.Composes = 'Composes';
DefaultFieldsGroupsInput.Aggregates = 'Aggregates';
DefaultFieldsGroupsInput.Associates = 'Associates';
DefaultFieldsGroupsInput.Medials = 'Medials';
Object.freeze( DefaultFieldsGroupsInput );

let DefaultForbiddenNames = Object.create( null );
DefaultForbiddenNames.Static = 'Static';
DefaultForbiddenNames.Type = 'Type';
Object.freeze( DefaultForbiddenNames );

// --
// define
// --

let ToolsExtension =
{

  constructorIsStandard,
  constructorOf,
  classGet : constructorOf,

  isSubClassOf,
  isSubPrototypeOf,

  parentOf,
  _classConstructorAndPrototypeGet,

  // prototype

  prototypeOf,

  prototypeUnitedInterface, /* experimental */

  prototypeAppend, /* experimental */
  // prototypeHasPrototype, /* moved */
  // prototypeHasProperty, /* moved */
  prototypeArchyGet, /* experimental */
  prototypeHasField,

  prototypeCrossRefer, /* experimental */
  // prototypeEach, /* moved */
  // prototypeEach_deprecated,

  // instance

  instanceIsStandard,

  // property

  propertyDescriptorActiveGet,
  propertyDescriptorGet,
  propertyHide,
  propertyConstant,

  // proxy

  proxyNoUndefined,
  proxyReadOnly,
  ifDebugProxyReadOnly,
  proxyMap,
  proxyShadow,

  // default

  defaultApply,
  defaultProxy,
  defaultProxyFlatteningToArray,

  // fields

  Combining,

  DefaultFieldsGroups,
  DefaultFieldsGroupsRelations,
  DefaultFieldsGroupsCopyable,
  DefaultFieldsGroupsTight,
  DefaultFieldsGroupsInput,

  DefaultForbiddenNames,
  CallableObject : wCallableObject,

}

//

_.mapExtend( _, ToolsExtension );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
