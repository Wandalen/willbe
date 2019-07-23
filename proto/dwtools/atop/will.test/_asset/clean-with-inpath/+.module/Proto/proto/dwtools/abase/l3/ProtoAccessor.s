( function _ProtoAccessor_s_() {

'use strict';

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _propertyIsEumerable = Object.propertyIsEnumerable;
let _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.field ), 'wProto needs wTools/staging/dwtools/abase/l1/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ), 'wProto needs wTools/staging/dwtools/l3/NameTools.s' );

/**
 * @summary Collection of routines for declaring accessors
 * @namespace "wTools.accessor"
 * @memberof module:Tools/base/Proto
 */

/**
 * @summary Collection of routines for declaring getters
 * @namespace "wTools.accessor.getter"
 * @memberof module:Tools/base/Proto
 */

 /**
 * @summary Collection of routines for declaring setters
 * @namespace "wTools.accessor.setter"
 * @memberof module:Tools/base/Proto
 */

/**
 * @summary Collection of routines for declaring getters and setters
 * @namespace "wTools.accessor.getterSetter"
 * @memberof module:Tools/base/Proto
 */

// --
// fields
// --

/**
 * Accessor defaults
 * @typedef {Object} AccessorDefaults
 * @property {Boolean} [ strict=1 ]
 * @property {Boolean} [ preserveValues=1 ]
 * @property {Boolean} [ prime=1 ]
 * @property {String} [ combining=null ]
 * @property {Boolean} [ readOnly=0 ]
 * @property {Boolean} [ readOnlyProduct=0 ]
 * @property {Boolean} [ enumerable=1 ]
 * @property {Boolean} [ configurable=0 ]
 * @property {Function} [ getter=null ]
 * @property {Function} [ setter=null ]
 * @property {Function} [ getterSetter=null ]
 * @memberof module:Tools/base/Proto.wTools.accessor
 **/

let AccessorDefaults =
{

  strict : 1,
  preserveValues : 1,
  prime : 1,
  combining : null,

  readOnly : 0,
  readOnlyProduct : 0,
  enumerable : 1,
  configurable : 0,

  getter : null,
  setter : null,
  copy : null,
  getterSetter : null,


}

// --
// accessor
// --


//

function _propertyGetterSetterNames( propertyName )
{
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( propertyName ) );

  result.set = '_' + propertyName + 'Set';
  result.get = '_' + propertyName + 'Get';

  /* xxx : use it more extensively */

  return result;
}

//

function _propertyGetterSetterMake( o )
{
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.objectLikeOrRoutine( o.methods ) );
  _.assert( _.strIs( o.name ) );
  _.assert( !!o.object );
  _.assertRoutineOptions( _propertyGetterSetterMake, o );

  if( o.getterSetter && o.setter === null && o.getterSetter.set )
  o.setter = o.getterSetter.set;
  if( _.boolLike( o.setter ) )
  o.setter = !!o.setter;

  if( o.getterSetter && o.getter === null && o.getterSetter.get )
  o.getter = o.getterSetter.get;
  if( _.boolLike( o.getter ) )
  o.getter = !!o.getter;

  if( o.getterSetter )
  _.assertMapHasOnly( o.getterSetter, { get : null, set : null, copy : null } );

  if( o.getter )
  result.get = o.getter;
  else if( o.getterSetter && o.getterSetter.get )
  result.get = o.getterSetter.get;
  else if( o.methods[ '' + o.name + 'Get' ] )
  result.get = o.methods[ o.name + 'Get' ];
  else if( o.methods[ '_' + o.name + 'Get' ] )
  result.get = o.methods[ '_' + o.name + 'Get' ];

  if( o.setter )
  result.set = o.setter;
  else if( o.getterSetter && o.getterSetter.set )
  result.set = o.getterSetter.set;
  else if( o.methods[ '' + o.name + 'Set' ] )
  result.set = o.methods[ o.name + 'Set' ];
  else if( o.methods[ '_' + o.name + 'Set' ] )
  result.set = o.methods[ '_' + o.name + 'Set' ];

  if( o.copy )
  result.copy = o.copy;
  else if( o.getterSetter && o.getterSetter.copy )
  result.copy = o.getterSetter.copy;
  else if( o.methods[ '' + o.name + 'Copy' ] )
  result.copy = o.methods[ o.name + 'Copy' ];
  else if( o.methods[ '_' + o.name + 'Copy' ] )
  result.copy = o.methods[ '_' + o.name + 'Copy' ];

  let fieldName = '_' + o.name;
  let fieldSymbol = Symbol.for( o.name );

  if( o.preserveValues )
  if( _ObjectHasOwnProperty.call( o.methods, o.name ) )
  o.object[ fieldSymbol ] = o.object[ o.name ];

  /* copy */

  if( result.copy )
  {
    let copy = result.copy;
    let name = o.name;

    if( !result.set && o.setter === null )
    result.set = function set( src )
    {
      let it = _.accessor.copyIterationMake
      ({
        dstInstance : this,
        instanceKey : name,
        value : src,
      });
      copy.call( this, it );
      return it.value;
    }

    if( !result.get && o.getter === null )
    result.get = function get()
    {
      let it = _.accessor.copyIterationMake
      ({
        srcInstance : this,
        instanceKey : name,
      });
      copy.call( this, it );
      return it.value;
    }

  }

  /* set */

  // if( !result.set && !o.readOnly )
  if( !result.set && o.setter === null )
  result.set = function set( src )
  {
    this[ fieldSymbol ] = src;
    return src;
  }

  /* get */

  if( !result.get && o.getter === null )
  {

    result.get = function get()
    {
      return this[ fieldSymbol ];
    }

  }

  /* readOnlyProduct */

  if( o.readOnlyProduct && result.get )
  {
    let get = result.get;
    result.get = function get()
    {
      debugger;
      let result = get.apply( this, arguments );
      if( !_.primitiveIs( result ) )
      result = _.proxyReadOnly( result );
      return result;
    }
  }

  /* validation */

  // _.assert( !result.set || !o.readOnly, () => 'read only, but setter for ' + _.strQuote( o.name ) + ' found in' + _.toStrShort( o.methods ) );
  // _.assert( !!result.set || !!o.readOnly );

  _.assert( !result.set || o.setter !== false, () => 'Field ' + _.strQuote( o.name ) + ' is read only, but setter found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.set || o.setter === false, () => 'Field ' + _.strQuote( o.name ) + ' is not read only, but setter not found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.get );

  return result;
}

_propertyGetterSetterMake.defaults =
{
  name : null,
  object : null,
  methods : null,
  preserveValues : 1,
  // readOnly : 0,
  readOnlyProduct : 0,
  copy : null,
  setter : null,
  getter : null,
  getterSetter : null,
}

//

function _propertyGetterSetterGet( object, propertyName )
{
  let result = Object.create( null );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( object ) );
  _.assert( _.strIs( propertyName ) );

  result.setName = object[ propertyName + 'Set' ] ? propertyName + 'Set' : '_' + propertyName + 'Set';
  result.getName = object[ propertyName + 'Get' ] ? propertyName + 'Get' : '_' + propertyName + 'Get';
  result.copyName = object[ propertyName + 'Copy' ] ? propertyName + 'Copy' : '_' + propertyName + 'Copy';

  result.set = object[ result.setName ];
  result.get = object[ result.getName ];
  result.copy = object[ result.getName ];

  return result;
}

//

function _propertyCopyGet( srcInstance, name )
{
  _.assert( arguments.length === 2 );
  _.assert( _.strIs( name ) );

  if( !_.instanceIs( srcInstance ) )
  return null;

  if( srcInstance[ '' + name + 'Copy' ] )
  return srcInstance[ name + 'Copy' ];
  else if( srcInstance[ '_' + name + 'Copy' ] )
  return srcInstance[ '_' + name + 'Copy' ];

  return null;
}

//

function copyIterationMake( o )
{
  return _.routineOptions( copyIterationMake, arguments );
}

copyIterationMake.defaults =
{
  dstInstance : null,
  srcInstance : null,
  instanceKey : null,
  srcContainer : null,
  dstContainer : null,
  containerKey : null,
  value : null,
}

// --
//
// --

/**
 * Generates options object for _accessorDeclare, _accessorDeclareForbid functions.
 * Can be called in three ways:
 * - First by passing all options in one object;
 * - Second by passing object and name options;
 * - Third by passing object, names and message option as third parameter.
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * //returns
 * // { object: [Function],
 * // methods: [Function],
 * // names: { a: 'a', b: 'b' },
 * // message: [ 'set/get call' ] }
 *
 * let Self = function ClassName( o ) { };
 * _.accessor._accessorDeclare_pre( Self, { a : 'a', b : 'b' }, 'set/get call' );
 *
 * @private
 * @function _accessorDeclare_pre
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function _accessorDeclare_pre( routine, args )
{
  let o;

  _.assert( arguments.length === 2 );

  if( args.length === 1 )
  {
    o = args[ 0 ];
  }
  else
  {
    o = Object.create( null );
    o.object = args[ 0 ];
    o.names = args[ 1 ];
    _.assert( args.length >= 2 );
  }

  // if( !o.methods )
  // o.methods = o.object;
  // else
  // o.methods = _.mapExtend( null, o.methods );

  // if( !_.arrayIs( o.names ) )
  // o.names = _nameFielded( o.names );
  // else
  // o.names = o.names;

  if( args.length > 2 )
  {
    o.message = _.longSlice( args, 2 );
  }

  if( _.strIs( o.names ) )
  o.names = { [ o.names ] : o.names }

  _.routineOptions( routine, o );
  _.assert( !_.primitiveIs( o.object ), 'Expects object as argument but got', o.object );
  _.assert( _.objectIs( o.names ) || _.arrayIs( o.names ), 'Expects object names as argument but got', o.names );

  return o;
}

//

/**
 * Registers provided accessor.
 * Writes accessor's descriptor into accessors map of the prototype ( o.proto ).
 * Supports several combining methods: `rewrite`, `supplement`, `append`.
 *  * Adds diagnostic information to descriptor if running in debug mode.
 * @param {Object} o - options map
 * @param {String} o.name - accessor's name
 * @param {Object} o.proto - target prototype object
 * @param {String} o.declaratorName
 * @param {Array} o.declaratorArgs
 * @param {String} o.declaratorKind
 * @param {String} o.combining - combining method
 * @private
 * @function _accessorRegister
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function _accessorRegister( o )
{

  _.routineOptions( _accessorRegister, arguments );
  _.assert( _.prototypeIsStandard( o.proto ), 'Expects formal prototype' );
  _.assert( _.strDefined( o.declaratorName ) );
  _.assert( _.arrayIs( o.declaratorArgs ) );
  _.fieldsGroupFor( o.proto, '_Accessors' );

  let accessors = o.proto._Accessors;

  if( o.combining && o.combining !== 'rewrite' && o.combining !== 'supplement' )
  debugger;

  if( Config.debug )
  if( !o.combining )
  {
    let stack = accessors[ o.name ] ? accessors[ o.name ].stack : '';
    _.assert
    (
      !accessors[ o.name ],
      'defined at' + '\n',
      stack,
      '\naccessor', o.name, 'of', o.proto.constructor.name
    );
    if( accessors[ o.name ] )
    debugger;
  }

  _.assert( !o.combining || o.combining === 'rewrite' || o.combining === 'append' || o.combining === 'supplement', 'not supported ( o.combining )', o.combining );
  _.assert( _.strIs( o.name ) );

  if( accessors[ o.name ] && o.combining === 'supplement' )
  return;

  let descriptor =
  {
    name : o.name,
    declaratorName : o.declaratorName,
    declaratorArgs : o.declaratorArgs,
    declaratorKind : o.declaratorKind,
    combining : o.combining,
  }

  if( Config.debug )
  descriptor.stack = _.diagnosticStack();

  if( o.combining === 'append' )
  {
    if( _.arrayIs( accessors[ o.name ] ) )
    accessors[ o.name ].push( descriptor );
    else
    accessors[ o.name ] = [ descriptor ];
  }

  accessors[ o.name ] = descriptor;

  return descriptor;
}

_accessorRegister.defaults =
{
  name : null,
  proto : null,
  declaratorName : null,
  declaratorArgs : null,
  declaratorKind : null,
  combining : 0,
}

//

function _accessorDeclareAct( o )
{

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.name ) );
  _.assertRoutineOptions( _accessorDeclareAct, arguments );

  if( o.combining === 'append' )
  debugger;

  /* */

  let propertyDescriptor = _.propertyDescriptorActiveGet( o.object, o.name );
  if( propertyDescriptor.descriptor )
  {

    _.assert
    (
      _.strIs( o.combining ), () =>
      'overriding of property ' + o.name + '\n' +
      '{-o.combining-} suppose to be ' + _.strQuote( _.accessor.Combining ) + ' if accessor overided, ' +
      'but it is ' + _.strQuote( o.combining )
    );

    _.assert( o.combining === 'rewrite' || o.combining === 'append' || o.combining === 'supplement', 'not implemented' );

    if( o.combining === 'supplement' )
    return;

    _.assert( o.combining === 'rewrite', 'not implemented' );
    _.assert( propertyDescriptor.object !== o.object, () => 'Attempt to redefine own accessor ' + _.strQuote( o.name ) + ' of ' + _.toStrShort( o.object ) );

  }

  /* */

  let getterSetter = _.accessor._propertyGetterSetterMake
  ({
    name : o.name,
    methods : o.methods,
    object : o.object,
    preserveValues : o.preserveValues,
    // readOnly : o.readOnly,
    readOnlyProduct : o.readOnlyProduct,
    copy : o.copy,
    getter : o.getter,
    setter : o.readOnly ? false : o.setter,
    getterSetter : o.getterSetter,
  });

  /* */

  if( o.prime )
  {

    let o2 = _.mapExtend( null, o );
    o2.names = o.name;
    if( o2.methods === o2.object )
    o2.methods = Object.create( null );
    o2.object = null;

    if( getterSetter.set )
    o2.methods[ '_' + o.name + 'Set' ] = getterSetter.set;
    if( getterSetter.get )
    o2.methods[ '_' + o.name + 'Get' ] = getterSetter.get;

    _.accessor._accessorRegister
    ({
      proto : o.object,
      name : o.name,
      declaratorName : 'accessor',
      // declaratorName : null,
      declaratorArgs : [ o2 ],
      combining : o.combining,
    });

  }

  /* */

  let forbiddenName = '_' + o.name;
  let fieldSymbol = Symbol.for( o.name );

  if( o.preserveValues )
  if( _ObjectHasOwnProperty.call( o.object, o.name ) )
  o.object[ fieldSymbol ] = o.object[ o.name ];

  /* define accessor */

  Object.defineProperty( o.object, o.name,
  {
    set : getterSetter.set,
    get : getterSetter.get,
    enumerable : !!o.enumerable,
    configurable : !!o.configurable,
    // configurable : o.combining === 'append',
  });

  /* forbid underscore field */

  if( o.strict && !propertyDescriptor.descriptor  )
  {

    let m =
    [
      'use Symbol.for( \'' + o.name + '\' ) ',
      'to get direct access to property\'s field, ',
      'not ' + forbiddenName,
    ].join( '' );

    if( !_.prototypeIsStandard( o.object ) || ( _.prototypeIsStandard( o.object ) && !_.prototypeHasField( o.object, forbiddenName ) ) )
    _.accessor.forbid
    ({
      object : o.object,
      names : forbiddenName,
      message : [ m ],
      prime : 0,
      strict : 1,
    });

  }

}

var defaults = _accessorDeclareAct.defaults = Object.create( AccessorDefaults );

defaults.name = null;
defaults.object = null;
defaults.methods = null;

//

/**
 * Accessor options
 * @typedef {Object} AccessorOptions
 * @property {Object} [ object=null ] - source object wich properties will get getter/setter defined.
 * @property {Object} [ names=null ] - map that that contains names of fields for wich function defines setter/getter.
 * Function uses values( rawName ) of object( o.names ) properties to check if fields of( o.object ) have setter/getter.
 * Example : if( rawName ) is 'a', function searchs for '_aSet' or 'aSet' and same for getter.
 * @property {Object} [ methods=null ] - object where function searchs for existing setter/getter of property.
 * @property {Array} [ message=null ] - setter/getter prints this message when called.
 * @property {Boolean} [ strict=true ] - makes object field private if no getter defined but object must have own constructor.
 * @property {Boolean} [ enumerable=true ] - sets property descriptor enumerable option.
 * @property {Boolean} [ preserveValues=true ] - saves values of existing object properties.
 * @property {Boolean} [ prime=true ]
 * @property {String} [ combining=null ]
 * @property {Boolean} [ readOnly=false ] - if true function doesn't define setter to property.
 * @property {Boolean} [ readOnlyProduct=false ]
 * @property {Boolean} [ configurable=false ]
 * @property {Function} [ getter=null ]
 * @property {Function} [ setter=null ]
 * @property {Function} [ getterSetter=null ]
 *
 * @memberof module:Tools/base/Proto.wTools.accessor
 **/

/**
 * Defines set/get functions on source object( o.object ) properties if they dont have them.
 * If property specified by( o.names ) doesn't exist on source( o.object ) function creates it.
 * If ( o.object.constructor.prototype ) has property with getter defined function forbids set/get access
 * to object( o.object ) property. Field can be accessed by use of Symbol.for( rawName ) function,
 * where( rawName ) is value of property from( o.names ) object.
 *
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let o = _.accessor._accessorDeclare_pre( Self, { a : 'a', b : 'b' }, [ 'set/get call' ] );
 * _.accessor._accessorDeclare( o );
 * Self.a = 1; // returns [ 'set/get call' ]
 * Self.b = 2; // returns [ 'set/get call' ]
 * console.log( Self.a );
 * // returns [ 'set/get call' ]
 * // 1
 * console.log( Self.b );
 * // returns [ 'set/get call' ]
 * // 2
 *
 * @function _accessorDeclare
 * @throws {exception} If( o.object ) is not a Object.
 * @throws {exception} If( o.names ) is not a Object.
 * @throws {exception} If( o.methods ) is not a Object.
 * @throws {exception} If( o.message ) is not a Array.
 * @throws {exception} If( o ) is extented by unknown property.
 * @throws {exception} If( o.strict ) is true and object doesn't have own constructor.
 * @throws {exception} If( o.readOnly ) is true and property has own setter.
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function _accessorDeclare( o )
{

  _.assertRoutineOptions( _accessorDeclare, arguments );

  if( _.arrayLike( o.object ) )
  {
    _.each( o.object, ( object ) =>
    {
      let o2 = _.mapExtend( null, o );
      o2.object = object;
      _accessorDeclare( o2 );
    });
    return;
  }

  if( !o.methods )
  o.methods = o.object;

  /* verification */

  _.assert( !_.primitiveIs( o.object ) );
  _.assert( !_.primitiveIs( o.methods ) );

  if( o.strict )
  {

    let has =
    {
      constructor : 'constructor',
    }

    _.assertMapOwnAll( o.object, has );
    _.accessor.forbid
    ({
      object : o.object,
      names : _.DefaultForbiddenNames,
      prime : 0,
      strict : 0,
    });

  }

  _.assert( _.objectLikeOrRoutine( o.object ), () => 'Expects object {-object-}, but got ' + _.toStrShort( o.object ) );
  _.assert( _.objectIs( o.names ), () => 'Expects object {-names-}, but got ' + _.toStrShort( o.names ) );

  /* */

  for( let n in o.names )
  {

    let o2 = o.names[ n ];

    _.assert( _.strIs( o2 ) || _.objectIs( o2 ) );

    if( _.strIs( o2 ) )
    {
      _.assert( o2 === n, 'map for forbid should have same key and value' );
      o2 = _.mapExtend( null, o );
    }
    else
    {
      _.assertMapHasOnly( o2, _.accessor.AccessorDefaults );
      o2 = _.mapExtend( null, o, o2 );
      _.assert( !!o2.object );
    }

    o2.name = n;
    delete o2.names;

    _.accessor._accessorDeclareAct( o2 );

  }

}

var defaults = _accessorDeclare.defaults = Object.create( _accessorDeclareAct.defaults );
defaults.names = null;

//

/**
 * Short-cut for {@link module:Tools/base/Proto.wTools.accessor._accessorDeclare } function.
 * Defines set/get functions on source object( o.object ) properties if they dont have them.
 * For more details {@link module:Tools/base/Proto.wTools.accessor._accessorDeclare }.
 * Can be called in three ways:
 * - First by passing all options in one object( o );
 * - Second by passing ( object ) and ( names ) options;
 * - Third by passing ( object ), ( names ) and ( message ) option as third parameter.
 *
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * _.accessor.declare( Self, { a : 'a' }, 'set/get call' )
 * Self.a = 1; // set/get call
 * Self.a;
 * // returns
 * // set/get call
 * // 1
 *
 * @function declare
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function accessorDeclare( o )
{
  o = _accessorDeclare_pre( accessorDeclare, arguments );
  return _accessorDeclare( o );
}

accessorDeclare.defaults = Object.create( _accessorDeclare.defaults );

//

/**
 * @summary Declares forbid accessor.
 * @description
 * Forbid accessor throws an Error when user tries to get value of the property.
 * @param {Object} o - options {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * _.accessor.forbid( Self, { a : 'a' } )
 * Self.a; // throw an Error
 *
 * @function accessorForbid
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function accessorForbid( o )
{

  o = _accessorDeclare_pre( accessorForbid, arguments );

  if( !o.methods )
  o.methods = Object.create( null );

  if( _.arrayLike( o.object ) )
  {
    debugger;
    _.each( o.object, ( object ) =>
    {
      let o2 = _.mapExtend( null, o );
      o2.object = object;
      accessorForbid( o2 );
    });
    debugger;
    return;
  }

  if( _.objectIs( o.names ) )
  o.names = _.mapExtend( null, o.names );

  if( o.combining === 'rewrite' && o.strict === undefined )
  o.strict = 0;

  if( o.prime === null )
  o.prime = _.prototypeIsStandard( o.object );

  /* verification */

  _.assert( _.objectLikeOrRoutine( o.object ), () => 'Expects object {-o.object-} but got ' + _.toStrShort( o.object ) );
  _.assert( _.objectIs( o.names ) || _.arrayIs( o.names ), () => 'Expects object {-o.names-} as argument but got ' + _.toStrShort( o.names ) );

  /* message */

  let _constructor = o.object.constructor || Object.getPrototypeOf( o.object );
  _.assert( _.routineIs( _constructor ) || _constructor === null );
  _.assert( _constructor === null || _.strIs( _constructor.name ) || _.strIs( _constructor._name ), 'object should have name' );
  if( !o.protoName )
  o.protoName = ( _constructor ? ( _constructor.name || _constructor._name || '' ) : '' ) + '.';
  if( !o.message )
  o.message = 'is deprecated';
  else
  o.message = _.arrayIs( o.message ) ? o.message.join( ' : ' ) : o.message;

  // if( o.protoName === 'wPrinterTop.' && o.names.Static )
  // debugger;

  // /* _accessorDeclareForbid */
  //
  // let encodedName, rawName;

  /* property */

  if( _.objectIs( o.names ) )
  {

    for( let n in o.names )
    {
      let name = o.names[ n ];
      let o2 = _.mapExtend( null, o );
      o2.fieldName = name;
      _.assert( n === name, () => 'Key and value should be the same, but ' + _.strQuote( n ) + ' and ' + _.strQuote( name ) + ' are not' );
      if( !_accessorDeclareForbid( o2 ) )
      delete o.names[ name ];
    }

  }
  else
  {

    let namesArray = o.names;
    o.names = Object.create( null );
    // debugger;
    for( let n = 0 ; n < namesArray.length ; n++ )
    {
      let name = namesArray[ n ];
      // let encodedName = namesArray[ n ];
      // let rawName = namesArray[ n ];
      let o2 = _.mapExtend( null, o );
      o2.fieldName = name;
      // o2.fieldValue = namesArray[ n ];
      // _.assert( n === namesArray[ n ] );
      // names[ encodedName ] = rawName;
      if( _accessorDeclareForbid( o2 ) )
      o.names[ name ] = name;
    }
    // debugger;

  }

  // o.names = names;
  // o.object = object;
  // o.methods = methods;
  o.strict = 0;
  o.prime = 0;

  return _accessorDeclare( _.mapOnly( o, _accessorDeclare.defaults ) );
}

var defaults = accessorForbid.defaults = Object.create( _accessorDeclare.defaults );

defaults.preserveValues = 0;
defaults.enumerable = 0;
defaults.prime = null;
defaults.strict = 1;
defaults.combining = 'rewrite';
defaults.message = null;

//

function _accessorDeclareForbid()
{
  let o = _.routineOptions( _accessorDeclareForbid, arguments );
  let setterName = '_' + o.fieldName + 'Set';
  let getterName = '_' + o.fieldName + 'Get';
  let messageLine = o.protoName + o.fieldName + ' : ' + o.message;

  // if( o.fieldName === 'originPath' )
  // debugger;

  // _.assert( o.fieldName === o.fieldValue );
  _.assert( _.strIs( o.protoName ) );
  _.assert( _.objectIs( o.methods ) );

  /* */

  let propertyDescriptor = _.propertyDescriptorActiveGet( o.object, o.fieldName );
  if( propertyDescriptor.descriptor )
  {
    _.assert( _.strIs( o.combining ), 'accessorForbid : if accessor overided expect ( o.combining ) is', _.accessor.Combining.join() );

    if( _.routineIs( propertyDescriptor.descriptor.get ) && propertyDescriptor.descriptor.get.name === 'forbidden' )
    {
      // delete names[ encodedName ];
      return false;
    }

  }

  /* check fields */

  if( o.strict )
  // if( _ObjectHasOwnProperty.call( o.object, o.fieldName ) )
  if( propertyDescriptor.object === o.object )
  {
    if( _.accessor.forbidOwns( o.object, o.fieldName ) )
    {
      // delete names[ encodedName ];
      return false;
    }
    else
    {
      // debugger;
      // let pd = _.propertyDescriptorActiveGet( o.object, '_pathGet' );
      forbidden();
    }
  }

  /* check fields group */

  if( o.strict && _.prototypeIsStandard( o.object ) )
  if( _.prototypeHasField( o.object, o.fieldName ) )
  {
    forbidden();
  }

  /* */

  if( !Object.isExtensible( o.object ) )
  {
    // delete names[ encodedName ];
    return false;
  }

  o.methods[ setterName ] = forbidden;
  o.methods[ getterName ] = forbidden;
  forbidden.isForbid = true;

  /* */

  if( o.prime )
  {

    /* !!! not tested */
    let o2 = _.mapExtend( null, o );
    o2.names = o.fieldName;
    o2.object = null;
    delete o2.protoName;
    delete o2.fieldName;

    _.accessor._accessorRegister
    ({
      proto : o.object,
      name : o.fieldName,
      declaratorName : 'accessorForbid',
      declaratorArgs : [ o2 ],
      combining : o.combining,
    });

  }

  /* */

  return true;

  /* */

  function forbidden()
  {
    debugger;
    throw _.err( messageLine );
  }

}

var defaults = _accessorDeclareForbid.defaults = Object.create( accessorForbid.defaults );

defaults.fieldName = null;
// defaults.fieldValue = null;
defaults.protoName = null;

//

/**
 * Checks if source object( object ) has own property( name ) and its forbidden.
 * @param {Object} object - source object
 * @param {String} name - name of the property
 *
 * @example
 * let Self = function ClassName( o ) { };
 * _.accessor.forbid( Self, { a : 'a' } );
 * _.accessor.forbidOwns( Self, 'a' ) // returns true
 * _.accessor.forbidOwns( Self, 'b' ) // returns false
 *
 * @function accessorForbidOwns
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function accessorForbidOwns( object, name )
{
  if( !_ObjectHasOwnProperty.call( object, name ) )
  return false;

  let descriptor = Object.getOwnPropertyDescriptor( object, name );
  if( _.routineIs( descriptor.get ) && descriptor.get.isForbid )
  {
    return true;
  }
  else
  {
    return false;
  }

}

//

/**
 * @summary Declares read-only accessor( s ).
 * @description Expects two arguments: (object), (names) or single as options map {@link module:Tools/base/Proto.wTools.accessor~AccessorOptions}
 *
 * @param {Object} object - target object
 * @param {Object} names - contains names of properties that will get read-only accessor
 *
 * @example
 * var Alpha = function _Alpha(){}
 * _.classDeclare
 * ({
 *   cls : Alpha,
 *   parent : null,
 *   extend : { Composes : { a : null } }
 * });
 * _.accessor.readOnly( Alpha.prototype,{ a : 'a' });
 *
 * @function accessorForbid
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function accessorReadOnly( object, names )
{
  let o = _accessorDeclare_pre( accessorReadOnly, arguments );
  _.assert( o.readOnly );
  return _accessorDeclare( o );
}

var defaults = accessorReadOnly.defaults = Object.create( _accessorDeclare.defaults );

defaults.readOnly = true;

//

/**
 * @summary Supplements target object( dst ) with accessors from source object( src ).
 *
 * @description
 * Both objects should have accessorts map defined.
 * Ignores accessor that is already declared on destination object( dst ).
 *
 * @param {Object} src - source object
 * @param {Object} dst - destination object
 *
 * @throws {Exception} If number of arguments is not supported.
 * @throws {Exception} If combining method of source accessor is unknown.
 * @throws {Exception} If accessor.declaratorArgs is not a Array.
 * @throws {Exception} If one of object doesn't have _Accessors map
 * @function accessorsSupplement
 *
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function accessorsSupplement( dst, src )
{

  _.fieldsGroupFor( dst, '_Accessors' );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _ObjectHasOwnProperty.call( dst, '_Accessors' ), 'accessorsSupplement : dst should has _Accessors map' );
  _.assert( _ObjectHasOwnProperty.call( src, '_Accessors' ), 'accessorsSupplement : src should has _Accessors map' );

  /* */

  function supplement( name, accessor )
  {

    _.assert( _.arrayIs( accessor.declaratorArgs ) );
    _.assert( !accessor.combining || accessor.combining === 'rewrite' || accessor.combining === 'supplement' || accessor.combining === 'append', 'not implemented' );

    if( _.objectIs( dst._Accessors[ name ] ) )
    return;

    if( accessor.declaratorName !== 'accessor' )
    {
      _.assert( _.routineIs( dst[ accessor.declaratorName ] ), 'dst does not have accessor maker', accessor.declaratorName );
      dst[ accessor.declaratorName ].apply( dst, accessor.declaratorArgs );
    }
    else
    {
      _.assert( accessor.declaratorArgs.length === 1 );
      let optionsForAccessor = _.mapExtend( null, accessor.declaratorArgs[ 0 ] );
      optionsForAccessor.object = dst;
      if( !optionsForAccessor.methods )
      optionsForAccessor.methods = dst;
      _.accessor.declare( optionsForAccessor );
    }

  }

  /* */

  for( let a in src._Accessors )
  {

    let accessor = src._Accessors[ a ];

    if( _.objectIs( accessor ) )
    supplement( name, accessor );
    else for( let i = 0 ; i < accessor.length ; i++ )
    supplement( name, accessor[ i ] );

  }

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
 * _.constant ( Self.prototype, Constants );
 * console.log( Self.prototype ); // returns { num: 100 }
 * Self.prototype.num = 1;// error assign to read only property
 *
 * @function constant
 * @throws {exception} If no argument provided.
 * @throws {exception} If( dstPrototype ) is not a Object.
 * @throws {exception} If( name ) is not a Map.
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function constant( dstPrototype, name, value )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( !_.primitiveIs( dstPrototype ), () => 'dstPrototype is needed, but got ' + _.toStrShort( dstPrototype ) );

  if( _.containerIs( name ) )
  {
    _.eachKey( name, ( n, v ) =>
    {
      if( value !== undefined )
      _.accessor.constant( dstPrototype, n, value );
      else
      _.accessor.constant( dstPrototype, n, v );
    });
    return;
  }

  if( value === undefined )
  value = dstPrototype[ name ];

  _.assert( _.strIs( name ), 'name is needed, but got', name );

  // for( let n in name )
  // {
  //   let encodedName = n;
  //   let value = name[ n ];

  Object.defineProperty( dstPrototype, name,
  {
    value,
    enumerable : true,
    writable : false,
    configurable : true,
  });

}

//

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
 * @function hide
 *
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function hide( dstPrototype, name, value )
{

  _.assert( arguments.length === 2 || arguments.length === 3 );
  _.assert( !_.primitiveIs( dstPrototype ), () => 'dstPrototype is needed, but got ' + _.toStrShort( dstPrototype ) );

  if( _.containerIs( name ) )
  {
    _.eachKey( name, ( n, v ) =>
    {
      if( value !== undefined )
      _.accessor.hide( dstPrototype, n, value );
      else
      _.accessor.hide( dstPrototype, n, v );
    });
    return;
  }

  if( value === undefined )
  value = dstPrototype[ name ];

  _.assert( _.strIs( name ), 'name is needed, but got', name );

  // for( let n in name )
  // {
  //   let encodedName = n;
  //   let value = name[ n ];

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
 * Makes properties of object( dstPrototype ) read only without changing their values. Uses properties names from argument( namesObject ).
 * Sets undefined for property that not exists on source( dstPrototype ).
 * @param {object} dstPrototype - prototype of class which properties will get read only state.
 * @param {object|string} namesObject - property name as string/map with properties.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * Self.prototype.num = 100;
 * let ReadOnly = { num : null, num2 : null  };
 * _.restrictReadOnly ( Self.prototype, ReadOnly );
 * console.log( Self.prototype ); // returns { num: 100, num2: undefined }
 * Self.prototype.num2 = 1; // error assign to read only property
 *
 * @function restrictReadOnly
 * @throws {exception} If no argument provided.
 * @throws {exception} If( dstPrototype ) is not a Object.
 * @throws {exception} If( namesObject ) is not a Map.
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function restrictReadOnly( dstPrototype, namesObject )
{

  if( _.strIs( namesObject ) )
  {
    namesObject = Object.create( null );
    namesObject[ namesObject ] = namesObject;
  }

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectLikeOrRoutine( dstPrototype ), '_.constant :', 'dstPrototype is needed :', dstPrototype );
  _.assert( _.mapIs( namesObject ), '_.constant :', 'namesObject is needed :', namesObject );

  for( let n in namesObject )
  {

    let encodedName = n;
    let value = namesObject[ n ];

    Object.defineProperty( dstPrototype, encodedName,
    {
      value : dstPrototype[ n ],
      enumerable : true,
      writable : false,
    });

  }

}

//

/**
 * Returns true if source object( proto ) has accessor with name( name ).
 * @param {Object} proto - target object
 * @param {String} name - name of accessor
 * @function accessorHas
 * @memberof module:Tools/base/Proto.wTools.accessor
 */

function accessorHas( proto, name )
{
  let accessors = proto._Accessors;
  if( !accessors )
  return false;
  return !!accessors[ name ];
}

//

function accessorMakerFrom_functor( fop )
{

  if( arguments.length === 2 )
  fop = { getterFunctor : arguments[ 0 ], setterFunctor : arguments[ 1 ] }

  _.routineOptions( accessorMakerFrom_functor, fop );

  let defaults;
  if( fop.getterFunctor )
  defaults = _.mapExtend( null, fop.getterFunctor.defaults );
  else
  defaults = _.mapExtend( null, fop.setterFunctor.defaults );

  if( fop.getterFunctor && _.entityIdentical )
  _.assert( _.entityIdentical( defaults, _.mapExtend( null, fop.getterFunctor.defaults ) ) );
  if( fop.setterFunctor && _.entityIdentical )
  _.assert( _.entityIdentical( defaults, _.mapExtend( null, fop.setterFunctor.defaults ) ) );

  accessorMaker.defaults = defaults;

  return accessorMaker;

  /* */

  function accessorMaker( o )
  {
    let r = Object.create( null );
    _.routineOptions( accessorMaker, arguments );
    if( fop.setterFunctor )
    r.set = fop.setterFunctor( o );
    if( fop.getterFunctor )
    r.get = fop.getterFunctor( o );
    return r;
  }

}

accessorMakerFrom_functor.defaults =
{
  getterFunctor : null,
  setterFunctor : null,
}

// --
// getter / setter functors
// --

/**
 * @summary Allows to get read and write access to property of inner container.
 * @param {Object} o
 * @param {String} o.name
 * @param {Number} o.index
 * @param {String} o.storageName
 * @function toElement
 * @memberof module:Tools/base/Proto.wTools.accessor.getterSetter
 */

// debugger;
// function accessorToElement( o )
function toElement( o )
{
  let r = Object.create( null );

  _.assert( 0, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( o.names ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.strIs( o.storageName ) );
  _.assert( _.numberIs( o.index ) );
  _.routineOptions( toElement, o );

  debugger;

  // let names = Object.create( null );
  // for( let n in o.names ) (function()
  // {
    // names[ n ] = n;

    // let arrayName = o.arrayName;
    // let index = o.names[ n ];

    let index = o.index;
    let storageName = o.storageName;
    let name = o.name;
    let aname = _.accessor._propertyGetterSetterNames( name );

    _.assert( _.numberIs( index ) );
    _.assert( index >= 0 );

    // let getterSetter = _.accessor._propertyGetterSetterGet( o.object, n );

    // if( !getterSetter.set )
    r[ aname.setName ] = function accessorToElementSet( src )
    {
      this[ storageName ][ index ] = src;
    }

    // if( !getterSetter.get )
    r[ aname.getName ] = function accessorToElementGet()
    {
      return this[ storageName ][ index ];
    }

  // })();

  // _.accessor.declare
  // ({
  //   object : o.object,
  //   names,
  // });

  return r;
}

toElement.defaults =
{
  // object : null,
  name : null,
  index : null,
  storageName : null,
}

//

function setterMapCollection_functor( o )
{

  _.assertMapHasOnly( o, setterMapCollection_functor.defaults );
  _.assert( _.strIs( o.name ) );
  _.assert( _.routineIs( o.elementMaker ) );
  let symbol = Symbol.for( o.name );
  let elementMakerOriginal = o.elementMaker;
  let elementMaker = o.elementMaker;
  let friendField = o.friendField;

  if( friendField )
  elementMaker = function elementMaker( src )
  {
    src[ friendField ] = this;
    return elementMakerOriginal.call( this, src );
  }

  return function _setterMapCollection( src )
  {
    let self = this;

    _.assert( _.objectIs( src ) );

    if( self[ symbol ] )
    {

      if( src !== self[ symbol ] )
      for( let d in self[ symbol ] )
      delete self[ symbol ][ d ];

    }
    else
    {

      self[ symbol ] = Object.create( null );

    }

    for( let d in src )
    {
      if( src[ d ] !== null )
      self[ symbol ][ d ] = elementMaker.call( self, src[ d ] );
    }

    return self[ symbol ];
  }

}

setterMapCollection_functor.defaults =
{
  name : null,
  elementMaker : null,
  friendField : null,
}

//

function setterArrayCollection_functor( o )
{

  if( _.strIs( arguments[ 0 ] ) )
  o = { name : arguments[ 0 ] }

  _.routineOptions( setterArrayCollection_functor, o );
  _.assert( _.strIs( o.name ) );
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( o.elementMaker ) || o.elementMaker === null );

  let symbol = Symbol.for( o.name );
  let elementMaker = o.elementMaker;
  let friendField = o.friendField;

  if( !elementMaker )
  elementMaker = function( src ){ return src }

  let elementMakerOriginal = elementMaker;

  if( friendField )
  elementMaker = function elementMaker( src )
  {
    src[ friendField ] = this;
    return elementMakerOriginal.call( this, src );
  }

  return function _setterArrayCollection( src )
  {
    let self = this;

    _.assert( src !== undefined );
    _.assert( arguments.length === 1 );

    if( src !== null )
    src = _.arrayAs( src );

    _.assert( _.arrayIs( src ) );

    if( self[ symbol ] )
    {

      if( src !== self[ symbol ] )
      self[ symbol ].splice( 0, self[ symbol ].length );

    }
    else
    {

      self[ symbol ] = [];

    }

    if( src === null )
    return self[ symbol ];

    if( src !== self[ symbol ] )
    for( let d = 0 ; d < src.length ; d++ )
    {
      if( src[ d ] !== null )
      self[ symbol ].push( elementMaker.call( self, src[ d ] ) );
    }
    else for( let d = 0 ; d < src.length ; d++ )
    {
      if( src[ d ] !== null )
      src[ d ] = elementMaker.call( self, src[ d ] );
    }

    return self[ symbol ];
  }

}

setterArrayCollection_functor.defaults =
{
  name : null,
  elementMaker : null,
  friendField : null,
}

//

/**
 * Makes a setter that makes a shallow copy of (src) before assigning.
 * @param {Object} o - options map
 * @param {Object} o.name - name of property
 * @returns {Function} Returns setter function.
 * @function own
 * @memberof module:Tools/base/Proto.wTools.accessor.setter
 */

function setterOwn_functor( op )
{
  let symbol = Symbol.for( op.name );

  _.routineOptions( setterOwn_functor, arguments );

  return function ownSet( src )
  {
    let self = this;

    _.assert( arguments.length === 1 );

    self[ symbol ] = _.entityShallowClone( src );

    return self[ symbol ];
  }

}

setterOwn_functor.defaults =
{
  name : null,
}

//

function setterFriend_functor( o )
{

  let name = _.nameUnfielded( o.name ).coded;
  let friendName = o.friendName;
  let maker = o.maker;
  let symbol = Symbol.for( name );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( name ) );
  _.assert( _.strIs( friendName ) );
  _.assert( _.routineIs( maker ), 'Expects maker {-o.maker-}' );
  _.assertMapHasOnly( o, setterFriend_functor.defaults );

  return function setterFriend( src )
  {

    let self = this;
    _.assert( src === null || _.objectIs( src ), 'setterFriend : expects null or object, but got ' + _.strType( src ) );

    if( !src )
    {

      self[ symbol ] = src;
      return;

    }
    else if( !self[ symbol ] )
    {

      if( _.mapIs( src ) )
      {
        let o2 = Object.create( null );
        o2[ friendName ] = self;
        o2.name = name;
        self[ symbol ] = maker( o2 );
        self[ symbol ].copy( src );
      }
      else
      {
        self[ symbol ] = src;
      }

    }
    else
    {

      if( self[ symbol ] !== src )
      self[ symbol ].copy( src );

    }

    if( self[ symbol ][ friendName ] !== self )
    self[ symbol ][ friendName ] = self;

    return self[ symbol ];
  }

}

setterFriend_functor.defaults =
{
  name : null,
  friendName : null,
  maker : null,
}

//

function setterCopyable_functor( o )
{

  let name = _.nameUnfielded( o.name ).coded;
  let maker = o.maker;
  let symbol = Symbol.for( name );
  let debug = o.debug;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( maker ) );
  _.assertMapHasOnly( o, setterCopyable_functor.defaults );

  return function setterCopyable( data )
  {
    let self = this;

    if( debug )
    debugger;

    if( data === null )
    {
      if( self[ symbol ] && self[ symbol ].finit )
      self[ symbol ].finit();
      self[ symbol ] = null;
      return self[ symbol ];
    }

    if( !_.objectIs( self[ symbol ] ) )
    {

      self[ symbol ] = maker( data );

    }
    else
    {

      if( self[ symbol ] !== data )
      {
        _.assert( _.routineIs( self[ symbol ].copy ) );
        self[ symbol ].copy( data );
      }

    }

    return self[ symbol ];
  }

}

setterCopyable_functor.defaults =
{
  name : null,
  maker : null,
  debug : 0,
}

//

/**
 * Makes a setter that makes a buffer from (src) before assigning.
 * @param {Object} o - options map
 * @param {Object} o.name - name of property
 * @param {Object} o.bufferConstructor - buffer constructor
 * @returns {Function} Returns setter function.
 * @function bufferFrom
 * @memberof module:Tools/base/Proto.wTools.accessor.setter
 */

function setterBufferFrom_functor( o )
{

  let name = _.nameUnfielded( o.name ).coded;
  let bufferConstructor = o.bufferConstructor;
  let symbol = Symbol.for( name );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( name ) );
  _.assert( _.routineIs( bufferConstructor ) );
  _.routineOptions( setterBufferFrom_functor, o );

  return function setterBufferFrom( data )
  {
    let self = this;

    if( data === null || data === false )
    {
      data = null;
    }
    else
    {
      data = _.bufferFrom({ src : data, bufferConstructor });
    }

    self[ symbol ] = data;
    return data;
  }

}

setterBufferFrom_functor.defaults =
{
  name : null,
  bufferConstructor : null,
}

//

function setterChangesTracking_functor( o )
{

  let name = Symbol.for( _.nameUnfielded( o.name ).coded );
  let nameOfChangeFlag = Symbol.for( _.nameUnfielded( o.nameOfChangeFlag ).coded );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( setterChangesTracking_functor, o );

  throw _.err( 'not tested' );

  return function setterChangesTracking( data )
  {
    let self = this;

    if( data === self[ name ] )
    return;

    self[ name ] = data;
    self[ nameOfChangeFlag ] = true;

    return data;
  }

}

setterChangesTracking_functor.defaults =
{
  name : null,
  nameOfChangeFlag : 'needsUpdate',
  bufferConstructor : null,
}

//

/**
 * Makes a setter that is an alias for other property.
 * @param {Object} o - options map
 * @param {Object} o.original - name of source property
 * @param {Object} o.alias - name of alias
 * @returns {Function} Returns setter function.
 * @function alias
 * @memberof module:Tools/base/Proto.wTools.accessor.setter
 */

function alias_pre( routine, args )
{

  let o = args[ 0 ];
  if( _.strIs( args[ 0 ] ) )
  o = { originalName : args[ 0 ], aliasName : args[ 1 ] }

  _.routineOptions( routine, o );

  if( o.aliasName === null )
  o.aliasName = o.originalName;
  if( o.originalName === null )
  o.originalName = o.aliasName;

  _.assert( args.length === 1 || args.length === 2, 'Expects single argument' );
  _.assert( _.strIs( o.aliasName ) );
  _.assert( _.strIs( o.originalName ) );

  return o;
}

//

function aliasSetter_functor_body( o )
{

  let containerName = o.containerName;
  let originalName = o.originalName;
  let aliasName = o.aliasName;

  _.assertRoutineOptions( aliasSetter_functor_body, arguments );

  if( containerName )
  return function aliasSet( src )
  {
    let self = this;
    self[ containerName ][ originalName ] = src;
    return self[ containerName ][ originalName ];
  }
  else
  return function aliasSet( src )
  {
    let self = this;
    self[ originalName ] = src;
    return self[ originalName ];
  }

}

aliasSetter_functor_body.defaults =
{
  containerName : null,
  originalName : null,
  aliasName : null,
}

let aliasSetter_functor = _.routineFromPreAndBody( alias_pre, aliasSetter_functor_body );

//

/**
 * Makes a getter that is an alias for other property.
 * @param {Object} o - options map
 * @param {Object} o.original - name of source property
 * @param {Object} o.alias - name of alias
 * @returns {Function} Returns getter function.
 * @function alias
 * @memberof module:Tools/base/Proto.wTools.accessor.getter
 */

function aliasGetter_functor_body( o )
{

  let containerName = o.containerName;
  let originalName = o.originalName;
  let aliasName = o.aliasName;

  _.assertRoutineOptions( aliasGetter_functor_body, arguments );

  if( containerName )
  return function aliasGet( src )
  {
    let self = this;
    return self[ containerName ][ originalName ];
  }
  else
  return function aliasSet( src )
  {
    let self = this;
    return self[ originalName ];
  }

}

aliasGetter_functor_body.defaults = Object.create( aliasSetter_functor.defaults );

let aliasGetter_functor = _.routineFromPreAndBody( alias_pre, aliasGetter_functor_body );

//

let aliasAccessor = accessorMakerFrom_functor( aliasGetter_functor_body, aliasSetter_functor );

// //
//
// function getterStorage_functor( o )
// {
//
//   let name = o.name;
//   let fieldName = o.fieldName;
//   let containerName = o.containerName;
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.routineOptions( getterStorage_functor, o );
//
//   if( containerName )
//   return function getterStorage( src )
//   {
//     let self = this;
//     return self[ containerName ][ fieldName ];
//   }
//   else
//   return function getterStorage( src )
//   {
//     let self = this;
//     return self[ fieldName ];
//   }
//
// }
//
// getterStorage_functor.defaults =
// {
//   name : null,
//   fieldName : null,
//   containerName : null,
// }

//
//
// function accessorToElement( o )
// {
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.objectIs( o.names ) );
//   _.routineOptions( accessorToElement, o );
//
//   let names = Object.create( null );
//   for( let n in o.names ) (function()
//   {
//     names[ n ] = n;
//
//     let arrayName = o.arrayName;
//     let index = o.names[ n ];
//     _.assert( _.numberIs( index ) );
//     _.assert( index >= 0 );
//
//     let getterSetter = _propertyGetterSetterGet( o.object, n );
//
//     if( !getterSetter.set )
//     o.object[ getterSetter.setName ] = function accessorToElementSet( src )
//     {
//       this[ arrayName ][ index ] = src;
//     }
//
//     if( !getterSetter.get )
//     o.object[ getterSetter.getName ] = function accessorToElementGet()
//     {
//       return this[ arrayName ][ index ];
//     }
//
//   })();
//
//   _.accessor.declare
//   ({
//     object : o.object,
//     names,
//   });
//
// }
//
// accessorToElement.defaults =
// {
//   object : null,
//   names : null,
//   arrayName : null,
// }

// --
// fields
// --

let Combining = [ 'rewrite', 'supplement', 'apppend', 'prepend' ];

let DefaultAccessorsMap = Object.create( null );
DefaultAccessorsMap.Accessors = accessorDeclare;
DefaultAccessorsMap.Forbids = accessorForbid;
DefaultAccessorsMap.AccessorsForbid = accessorForbid;
DefaultAccessorsMap.AccessorsReadOnly = accessorReadOnly;

let Forbids =
{
  _ArrayDescriptor : '_ArrayDescriptor',
  ArrayDescriptor : 'ArrayDescriptor',
  _ArrayDescriptors : '_ArrayDescriptors',
  ArrayDescriptors : 'ArrayDescriptors',
  arrays : 'arrays',
  arrayOf : 'arrayOf',
}

// --
// define
// --

let Fields =
{

  AccessorDefaults,
  Combining,
  DefaultAccessorsMap,

}

//

let Routines =
{

  /* */

  _propertyGetterSetterNames,
  _propertyGetterSetterMake,
  _propertyGetterSetterGet,
  _propertyCopyGet,

  copyIterationMake,

  /* */

  _accessorDeclare_pre,
  _accessorRegister,
  _accessorDeclareAct,
  _accessorDeclare,

  declare : accessorDeclare,
  forbid : accessorForbid,
  _accessorDeclareForbid,

  forbidOwns : accessorForbidOwns,
  readOnly : accessorReadOnly,

  supplement : accessorsSupplement,

  constant,
  hide,
  restrictReadOnly,

  accessorHas,

  accessorMakerFrom_functor,

}

let GetterSetter =
{

  // accessorToElement,
  toElement,

}

let Getter =
{

  alias : aliasGetter_functor_body,
  // storage : getterStorage_functor,

}

let Setter =
{

  mapCollection : setterMapCollection_functor,
  arrayCollection : setterArrayCollection_functor,

  own : setterOwn_functor,
  friend : setterFriend_functor,
  copyable : setterCopyable_functor,
  bufferFrom : setterBufferFrom_functor,
  changesTracking : setterChangesTracking_functor,

  alias : aliasSetter_functor,

}

let Suite =
{

  alias : aliasAccessor,

}

// --
// extend
// --

_.accessor = _.accessor || Object.create( null );
_.mapExtend( _.accessor, Routines );
_.mapExtend( _.accessor, Fields );

_.accessor.forbid( _, Forbids );
_.accessor.forbid( _.accessor, Forbids );

_.accessor.getterSetter = _.accessor.getterSetter || Object.create( null );
_.mapExtend( _.accessor.getterSetter, GetterSetter );

_.accessor.getter = _.accessor.getter || Object.create( null );
_.mapExtend( _.accessor.getter, Getter );

_.accessor.setter = _.accessor.setter || Object.create( null );
_.mapExtend( _.accessor.setter, Setter );

_.accessor.suite = _.accessor.suite || Object.create( null );
_.mapExtend( _.accessor.suite, Suite );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
