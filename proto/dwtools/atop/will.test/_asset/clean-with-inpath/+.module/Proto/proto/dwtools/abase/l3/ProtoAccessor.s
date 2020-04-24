( function _Accessor_s_() {

'use strict';

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;
let _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.field ), 'wProto needs wTools/staging/dwtools/abase/l1/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ), 'wProto needs wTools/staging/dwtools/l3/NameTools.s' );

/**
 * @summary Collection of routines for declaring accessors
 * @namespace wTools.accessor
 * @extends Tools
 * @module Tools/base/Proto
 */

/**
 * @summary Collection of routines for declaring getters
 * @namespace wTools.accessor.getter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

 /**
 * @summary Collection of routines for declaring setters
 * @namespace wTools.accessor.setter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

/**
 * @summary Collection of routines for declaring getters and setters
 * @namespace wTools.accessor.getterSetter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

// --
// fields
// --

/**
 * Accessor defaults
 * @typedef {Object} AccessorDefaults
 * @property {Boolean} [ strict=1 ]
 * @property {Boolean} [ preservingValue=1 ]
 * @property {Boolean} [ prime=1 ]
 * @property {String} [ combining=null ]
 * @property {Boolean} [ readOnly=0 ]
 * @property {Boolean} [ readOnlyProduct=0 ]
 * @property {Boolean} [ enumerable=1 ]
 * @property {Boolean} [ configurable=0 ]
 * @property {Function} [ getter=null ]
 * @property {Function} [ setter=null ]
 * @property {Function} [ getterSetter=null ]
 * @namespace Tools.accessor
 **/

let AccessorDefaults =
{

  strict : 1,
  preservingValue : 1,
  prime : null,
  combining : null,
  addingMethods : 0,

  readOnly : 0,
  readOnlyProduct : 0,
  enumerable : 1,
  configurable : 0,

  getter : null,
  setter : null,
  put : null,
  copy : null, /* xxx : remove? */
  getterSetter : null, /* xxx : rename? */

}

// --
// getter / setter generator
// --

function _propertyGetterSetterNames( propertyName )
{
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( propertyName ) );

  result.set = '_' + propertyName + 'Set';
  result.get = '_' + propertyName + 'Get';
  result.put = '_' + propertyName + 'Put';
  result.copy = '_' + propertyName + 'Copy';

  /* xxx : use it more extensively */

  return result;
}

//

function _methodsMake( o )
{
  let result = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.objectLikeOrRoutine( o.methods ) );
  _.assert( _.strIs( o.name ) );
  _.assert( !!o.object );
  _.assertRoutineOptions( _methodsMake, o );

  // if( o.setter === null )
  // if( o.put === 0 || o.put === false )
  // o.setter = false;
  //
  // if( o.put === null )
  // if( o.setter === 0 || o.setter === false )
  // o.put = false;

  if( o.getterSetter )
  {
    o.getterSetter = unfunct( o.getterSetter );
    _.assertMapHasOnly( o.getterSetter, { get : null, set : null, copy : null } );
  }

  if( o.getterSetter && o.setter === null && o.getterSetter.set )
  o.setter = o.getterSetter.set;
  if( _.boolLike( o.setter ) )
  o.setter = !!o.setter;

  if( o.getterSetter && o.getter === null && o.getterSetter.get )
  o.getter = o.getterSetter.get;
  if( _.boolLike( o.getter ) )
  o.getter = !!o.getter;

  if( o.getter !== false && o.getter !== 0 )
  {
    if( o.getter )
    result.get = o.getter;
    else if( o.getterSetter && o.getterSetter.get )
    result.get = o.getterSetter.get;
    else if( o.methods[ '' + o.name + 'Get' ] )
    result.get = o.methods[ o.name + 'Get' ];
    else if( o.methods[ '_' + o.name + 'Get' ] )
    result.get = o.methods[ '_' + o.name + 'Get' ];
  }

  if( o.setter !== false && o.setter !== 0 )
  {
    if( o.setter )
    result.set = o.setter;
    else if( o.getterSetter && o.getterSetter.set )
    result.set = o.getterSetter.set;
    else if( o.methods[ '' + o.name + 'Set' ] )
    result.set = o.methods[ o.name + 'Set' ];
    else if( o.methods[ '_' + o.name + 'Set' ] )
    result.set = o.methods[ '_' + o.name + 'Set' ];
  }

  if( o.put !== false && o.put !== 0 )
  {
    if( o.put )
    result.put = o.put;
    else if( o.getterSetter && o.getterSetter.put )
    result.put = o.getterSetter.put;
    else if( o.methods[ '' + o.name + 'Put' ] )
    result.put = o.methods[ o.name + 'Put' ];
    else if( o.methods[ '_' + o.name + 'Put' ] )
    result.put = o.methods[ '_' + o.name + 'Put' ];
  }

  if( o.copy )
  debugger;
  if( o.copy !== false && o.copy !== 0 )
  {
    if( o.copy )
    result.copy = o.copy;
    else if( o.getterSetter && o.getterSetter.copy )
    result.copy = o.getterSetter.copy;
    else if( o.methods[ '' + o.name + 'Copy' ] )
    result.copy = o.methods[ o.name + 'Copy' ];
    else if( o.methods[ '_' + o.name + 'Copy' ] )
    result.copy = o.methods[ '_' + o.name + 'Copy' ];
  }

  // if( _global_.debugger )
  // debugger;
  resultUnfunct( 'get' );
  resultUnfunct( 'set' );
  resultUnfunct( 'put', 1 );
  resultUnfunct( 'copy', 1 );

  let fieldName = '_' + o.name;
  let fieldSymbol = Symbol.for( o.name );

  // if( o.preservingValue ) /* xxx : move out */
  // if( _ObjectHasOwnProperty.call( o.methods, o.name ) )
  // o.object[ fieldSymbol ] = o.object[ o.name ];

  /* copy */

  if( result.copy )
  {
    let copy = result.copy;
    let name = o.name;

    if( !result.set && o.setter === null )
    result.set = function set( src )
    {
      debugger;
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
      debugger;
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

  // if( !result.set && o.setter === null )
  // if( !result.set && o.setter === null || o.setter === true || o.setter === 1 )
  if( !result.set )
  if( o.setter === null || o.setter === true || o.setter === 1 )
  {
    if( result.put )
    result.set = result.put;
    else
    result.set = function set( src )
    {
      this[ fieldSymbol ] = src;
      return src;
    }
  }

  // if( result.set && !result.setName )
  // {
  //   if( o.object[ o.name + 'Set' ] )
  //   result.setName = o.name + 'Set';
  //   else if( o.object[ '_' + o.name + 'Set' ] )
  //   result.setName = '_' + o.name + 'Set';
  //   else
  //   result.setName = o.name + 'Set';
  // }

  /* get */

  if( !result.get )
  if( o.getter === null || o.getter === true || o.getter === 1 )
  {
    result.get = function get()
    {
      return this[ fieldSymbol ];
    }
  }

  // if( result.get && !result.getName )
  // {
  //   if( o.object[ o.name + 'Get' ] )
  //   result.getName = o.name + 'Get';
  //   else if( o.object[ '_' + o.name + 'Get' ] )
  //   result.getName = '_' + o.name + 'Get';
  //   else
  //   result.setName = o.name + 'Get';
  // }

  /* put */

  // if( !result.put && o.put === null )
  if( !result.put )
  if( o.put === null || o.put === true || o.put === 1 )
  // if( o.put === true || o.put === 1 )
  {
    if( result.set )
    result.put = result.set;
    else
    result.put = function put( src )
    {
      this[ fieldSymbol ] = src;
    }
  }

  // if( result.put && !result.putName )
  // {
  //   if( o.object[ o.name + 'Put' ] )
  //   result.putName = o.name + 'Put';
  //   else if( o.object[ '_' + o.name + 'Put' ] )
  //   result.putName = '_' + o.name + 'Put';
  //   else
  //   result.setName = o.name + 'Put';
  // }

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

  _.assert( !result.set || o.setter !== false, () => 'Field ' + _.strQuote( o.name ) + ' is read only, but setter found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.set || o.setter === false, () => 'Field ' + _.strQuote( o.name ) + ' is not read only, but setter not found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.get || o.getter === false, () => 'Field ' + _.strQuote( o.name ) + ' is not read only, but getter not found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.put || !o.put, () => 'Field ' + _.strQuote( o.name ) + ' putter not found in' + _.toStrShort( o.methods ) );

  return result;

  /* */

  function resultUnfunct( name, checking )
  {
    _.assert( _.primitiveIs( name ) );
    if( !result[ name ] )
    return;
    let functor = result[ name ];
    let r = unfunct( functor );
    // if( checking && r !== functor )
    // {
    // }
    result[ name ] = r;
    return r;
  }

  /* */

  function unfunct( functor )
  {
    if( !_.routineIs( functor ) )
    return functor;
    if( functor && functor.rubrics && _.longHas( functor.rubrics, 'functor' ) )
    {
      if( functor.defaults && functor.defaults.fieldName !== undefined )
      functor = functor({ fieldName : o.name });
      else
      functor = functor();
    }
    return functor;
  }

  /* */

}

_methodsMake.defaults =
{
  name : null,
  object : null,
  methods : null,
  // preservingValue : 1,
  readOnlyProduct : 0,
  copy : null,
  setter : null,
  getter : null,
  put : null,
  getterSetter : null,
}

//

function _methodsNames( o )
{

  _.routineOptions( _methodsNames, o );

  if( o.anames === null )
  o.anames = Object.create( null );

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o.amethods ) );
  _.assert( _.strIs( o.name ) );
  _.assert( !!o.object );

  /* get */

  for( let t = 0 ; t < _.accessor.AccessorType.length ; t++ )
  {
    let type = _.accessor.AccessorType[ t ];
    if( o.amethods[ type ] && !o.anames[ type ] )
    {
      let type2 = _.strCapitalize( type );
      if( o.object[ o.name + type2 ] === o.amethods[ type ] )
      o.anames[ type ] = o.name + type2;
      else if( o.object[ '_' + o.name + type2 ] === o.amethods[ type ] )
      o.anames[ type ] = '_' + o.name + type2;
      else
      o.anames[ type ] = o.name + type2;
    }
  }

  return o.anames;
}

_methodsNames.defaults =
{
  object : null,
  amethods : null,
  anames : null,
  name : null,
}

//

function _methodsRetrieve( object, propertyName )
{
  let result = Object.create( null );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( object ) );
  _.assert( _.strIs( propertyName ) );

  result.setName = object[ propertyName + 'Set' ] ? propertyName + 'Set' : '_' + propertyName + 'Set';
  result.getName = object[ propertyName + 'Get' ] ? propertyName + 'Get' : '_' + propertyName + 'Get';
  result.copyName = object[ propertyName + 'Copy' ] ? propertyName + 'Copy' : '_' + propertyName + 'Copy';
  result.putName = object[ propertyName + 'Put' ] ? propertyName + 'Put' : '_' + propertyName + 'Put';

  result.set = object[ result.setName ];
  result.get = object[ result.getName ];
  result.copy = object[ result.copyName ];
  result.put = object[ result.putName ];

  return result;
}

//

function _methodsValidate( o )
{

  _.assert( _.strIs( o.name ) );
  _.assert( !!o.object );
  _.routineOptions( _methodsValidate, o );

  // let AccessorType = _.accessor.AccessorType;
  let AccessorType = [ 'get', 'set' ];

  for( let t = 0 ; t < AccessorType.length ; t++ )
  {
    let type = AccessorType[ t ];
    if( !o.amethods[ type ] )
    {
      let name1 = o.name + _.strCapitalize( type );
      let name2 = '_' + o.name + _.strCapitalize( type );

      if( name1 in o.object )
      throw _.err( `Object should not have method ${name1}, if accessor has it disabled` );
      if( name2 in o.object )
      throw _.err( `Object should not have method ${name1}, if accessor has it disabled` );

    }
  }

}

_methodsValidate.defaults =
{
  object : null,
  amethods : null,
  name : null,
}

//

function _methodCopyGet( srcInstance, name )
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
// declare
// --

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
 * @function _register
 * @namespace Tools.accessor
 */

function _register( o )
{

  _.routineOptions( _register, arguments );
  _.assert( _.prototypeIsStandard( o.proto ), 'Expects formal prototype' );
  _.assert( _.strDefined( o.declaratorName ) );
  _.assert( _.arrayIs( o.declaratorArgs ) );
  _.workpiece.fieldsGroupFor( o.proto, '_Accessors' );

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
  descriptor.stack = _.introspector.stack();

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

_register.defaults =
{
  name : null,
  proto : null,
  declaratorName : null,
  declaratorArgs : null,
  declaratorKind : null,
  combining : 0,
}

//

function _declareAct( o )
{

  _.assertRoutineOptions( _declareAct, arguments );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.name ) );
  _.assert( _.longHas( [ null, 0, false, 'rewrite', 'supplement' ], o.combining ), 'not tested' );

  if( o.prime === null )
  o.prime = _.prototypeIsStandard( o.object );

  // if( o.setter === null )
  // if( o.put === 0 || o.put === false )
  // o.setter = false;
  //
  // if( o.put === null )
  // if( o.setter === 0 || o.setter === false )
  // o.put = false;

  _.assert( _.boolLike( o.prime ) );

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

  if( _global_.debugger )
  debugger;
  let amethods = _.accessor._methodsMake
  ({
    name : o.name,
    methods : o.methods,
    object : o.object,
    readOnlyProduct : o.readOnlyProduct,
    put : o.put,
    copy : o.copy,
    getter : o.getter,
    setter : o.readOnly ? false : o.setter,
    getterSetter : o.getterSetter,
  });

  let anames;
  if( o.prime || o.addingMethods )
  anames = _.accessor._methodsNames
  ({
    object : o.object,
    amethods : amethods,
    name : o.name,
  })

  /* */

  if( o.prime )
  {

    let o2 = _.mapExtend( null, o );
    o2.names = o.name;
    if( o2.methods === o2.object )
    o2.methods = Object.create( null );
    o2.object = null;

    delete o2.name;

    for( let k in amethods )
    o2.methods[ anames[ k ] ] = amethods[ k ];

    _.accessor._register
    ({
      proto : o.object,
      name : o.name,
      declaratorName : 'accessor',
      declaratorArgs : [ o2 ],
      combining : o.combining,
    });

  }

  // if( _global_.debugger )
  // debugger;

  let fieldSymbol = Symbol.for( o.name );

  /* preservingValue */

  if( o.preservingValue ) /* xxx : use put */
  if( _ObjectHasOwnProperty.call( o.object, o.name ) )
  {
    if( amethods.put )
    amethods.put.call( o.object, o.object[ o.name ] );
    else
    o.object[ fieldSymbol ] = o.object[ o.name ];
  }

  /* addingMethods */

  if( o.addingMethods )
  {
    for( let n in amethods )
    {
      o.object[ anames[ n ] ] = amethods[ n ];
    }
  }

  /* define accessor */

  _.assert( amethods.get !== undefined );

    let o2 =
    {
      enumerable : !!o.enumerable,
      configurable : !!o.configurable,
    }
    if( _.routineIs( amethods.get ) )
    {
      o2.set = amethods.set;
      o2.get = amethods.get;
    }
    else
    {
      _.assert( amethods.set === undefined );
      o2.value = amethods.get;
    }
    // if( _.routineIs( amethods.put ) )
    // o2.put = amethods.put;
    // if( _.routineIs( amethods.copy ) )
    // o2.copy = amethods.copy;

    if( _global_.debugger )
    debugger;
    Object.defineProperty( o.object, o.name, o2 );

  // if( _.routineIs( amethods.get ) )
  // {
  //   let o2 =
  //   {
  //     set : amethods.set,
  //     get : amethods.get,
  //     enumerable : !!o.enumerable,
  //     configurable : !!o.configurable,
  //   }
  //   Object.defineProperty( o.object, o.name, o2 );
  // }
  // else
  // {
  //   _.assert( amethods.set === undefined );
  //   Object.defineProperty( o.object, o.name,
  //   {
  //     value : amethods.get,
  //     enumerable : !!o.enumerable,
  //     configurable : !!o.configurable,
  //   });
  // }

  /* validate */

  if( Config.debug )
  _.accessor._methodsValidate({ object : o.object, name : o.name, amethods });

  /* forbid underscore field */

  if( o.strict && !propertyDescriptor.descriptor )
  forbid();

  /* - */

  function forbid()
  {
    let forbiddenName = '_' + o.name;
    let m =
    [
      'use Symbol.for( \'' + o.name + '\' ) ',
      'to get direct access to property\'s field, ',
      'not ' + forbiddenName,
    ].join( '' );

    if( !_.prototypeIsStandard( o.object ) || !_.prototypeHasField( o.object, forbiddenName ) )
    _.accessor.forbid
    ({
      object : o.object,
      names : forbiddenName,
      message : [ m ],
      prime : 0,
      strict : 0,
    });

  }

}

var defaults = _declareAct.defaults = Object.create( AccessorDefaults );

defaults.name = null;
defaults.object = null;
defaults.methods = null;

//

/**
 * Generates options map for declare.body, _forbidDeclare functions.
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
 * _.accessor._declare_pre( Self, { a : 'a', b : 'b' }, 'set/get call' );
 *
 * @private
 * @function _declare_pre
 * @namespace Tools.accessor
 */

function _declare_pre( routine, args )
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

  if( args.length > 2 )
  {
    _.assert( o.messages === null || o.messages === undefined );
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
 * @property {Boolean} [ preservingValue=true ] - saves values of existing object properties.
 * @property {Boolean} [ prime=true ]
 * @property {String} [ combining=null ]
 * @property {Boolean} [ readOnly=false ] - if true function doesn't define setter to property.
 * @property {Boolean} [ readOnlyProduct=false ]
 * @property {Boolean} [ configurable=false ]
 * @property {Function} [ getter=null ]
 * @property {Function} [ setter=null ]
 * @property {Function} [ getterSetter=null ]
 *
 * @namespace Tools.accessor
 **/

/**
 * Defines set/get functions on source object( o.object ) properties if they dont have them.
 * If property specified by( o.names ) doesn't exist on source( o.object ) function creates it.
 * If ( o.object.constructor.prototype ) has property with getter defined function forbids set/get access
 * to object( o.object ) property. Field can be accessed by use of Symbol.for( rawName ) function,
 * where( rawName ) is value of property from( o.names ) object.
 *
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
 * @throws {exception} If( o.object ) is not a Object.
 * @throws {exception} If( o.names ) is not a Object.
 * @throws {exception} If( o.methods ) is not a Object.
 * @throws {exception} If( o.message ) is not a Array.
 * @throws {exception} If( o ) is extented by unknown property.
 * @throws {exception} If( o.strict ) is true and object doesn't have own constructor.
 * @throws {exception} If( o.readOnly ) is true and property has own setter.
 * @function declare
 * @namespace Tools.accessor
 */

function declare_body( o )
{

  _.assertRoutineOptions( declare_body, arguments );

  if( _.arrayLike( o.object ) )
  {
    _.each( o.object, ( object ) =>
    {
      let o2 = _.mapExtend( null, o );
      o2.object = object;
      declare_body( o2 );
    });
    return;
  }

  if( !o.methods )
  o.methods = o.object;

  /* verification */

  _.assert( !_.primitiveIs( o.object ) );
  _.assert( !_.primitiveIs( o.methods ) );

  // if( o.strict )
  // {
  //
  //   let has =
  //   {
  //     constructor : 'constructor',
  //   }
  //
  //   _.assertMapOwnAll( o.object, has );
  //   _.accessor.forbid
  //   ({
  //     object : o.object,
  //     names : _.DefaultForbiddenNames,
  //     prime : 0,
  //     strict : 0,
  //   });
  //
  // }

  _.assert( _.objectLikeOrRoutine( o.object ), () => 'Expects object {-object-}, but got ' + _.toStrShort( o.object ) );
  _.assert( _.objectIs( o.names ), () => 'Expects object {-names-}, but got ' + _.toStrShort( o.names ) );

  /* */

  for( let n in o.names )
  {

    let o2 = o.names[ n ];

    if( _.routineIs( o2 ) && o2.rubrics && _.longHas( o2.rubrics, 'functor' ) )
    {
      if( o2.defaults && o2.defaults.fieldName !== undefined )
      o2 = o2({ fieldName : n });
      else
      o2 = o2();
    }

    _.assert
    (
        _.strIs( o2 ) || _.objectIs( o2 )
      , () => `Expects accessor definition, but got ${ _.strType( o2 ) } for accessor ${ n }`
    );

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

    _.accessor._declareAct( o2 );

  }

}

var defaults = declare_body.defaults = _.mapExtend( null, _declareAct.defaults );
defaults.names = null;
delete defaults.name;

let declare = _.routineFromPreAndBody( _declare_pre, declare_body );

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
 * @function forbid
 * @namespace Tools.accessor
 */

function forbid_body( o )
{

  // o = _declare_pre( forbid, arguments );
  _.assertRoutineOptions( forbid_body, arguments );

  if( !o.methods )
  o.methods = Object.create( null );

  if( _.arrayLike( o.object ) )
  {
    debugger;
    _.each( o.object, ( object ) =>
    {
      let o2 = _.mapExtend( null, o );
      o2.object = object;
      forbid_body( o2 );
    });
    debugger;
    return;
  }

  if( _.objectIs( o.names ) )
  o.names = _.mapExtend( null, o.names );

  // if( o.combining === 'rewrite' && o.strict === undefined )
  // o.strict = 0;

  if( o.prime === null )
  o.prime = _.prototypeIsStandard( o.object );

  /* verification */

  _.assert( _.objectLikeOrRoutine( o.object ), () => 'Expects object {-o.object-} but got ' + _.toStrShort( o.object ) );
  _.assert( _.objectIs( o.names ) || _.arrayIs( o.names ), () => 'Expects object {-o.names-} as argument but got ' + _.toStrShort( o.names ) );

  /* message */

  // if( o.names && o.names.abc )
  // debugger;
  // let _constructor = o.object.constructor || Object.getPrototypeOf( o.object ); // yyy
  let _constructor = o.object.constructor || null;
  _.assert( _.routineIs( _constructor ) || _constructor === null );
  _.assert( _constructor === null || _.strIs( _constructor.name ) || _.strIs( _constructor._name ), 'object should have name' );
  if( !o.protoName )
  o.protoName = ( _constructor ? ( _constructor.name || _constructor._name || '' ) : '' ) + '.';
  if( !o.message )
  o.message = 'is deprecated';
  else
  o.message = _.arrayIs( o.message ) ? o.message.join( ' : ' ) : o.message;

  /* property */

  if( _.objectIs( o.names ) )
  {

    for( let n in o.names )
    {
      let name = o.names[ n ];
      let o2 = _.mapExtend( null, o );
      o2.fieldName = name;
      _.assert( n === name, () => 'Key and value should be the same, but ' + _.strQuote( n ) + ' and ' + _.strQuote( name ) + ' are not' );
      if( !_.accessor._forbidDeclare( o2 ) )
      delete o.names[ name ];
    }

  }
  else
  {

    let namesArray = o.names;
    o.names = Object.create( null );
    for( let n = 0 ; n < namesArray.length ; n++ )
    {
      let name = namesArray[ n ];
      let o2 = _.mapExtend( null, o );
      o2.fieldName = name;
      if( _.accessor._forbidDeclare( o2 ) )
      o.names[ name ] = name;
    }

  }

  _.assert( !o.strict );
  _.assert( !o.prime );

  o.strict = 0;
  o.prime = 0;

  return _.accessor.declare.body( _.mapOnly( o, _.accessor.declare.body.defaults ) );
}

// var defaults = forbid_body.defaults = Object.create( declare.body.defaults );

var defaults = forbid_body.defaults =
{

  ... _.mapExtend( null, declare.body.defaults ),

  preservingValue : 0,
  enumerable : 0,
  combining : 'rewrite',
  message : null,

  prime : 0,
  strict : 0,

}

// delete defaults.strict;
// delete defaults.prime;

let forbid = _.routineFromPreAndBody( _declare_pre, forbid_body );

//

function _forbidDeclare()
{
  let o = _.routineOptions( _forbidDeclare, arguments );
  let setterName = '_' + o.fieldName + 'Set';
  let getterName = '_' + o.fieldName + 'Get';
  let messageLine = o.protoName + o.fieldName + ' : ' + o.message;

  _.assert( _.strIs( o.protoName ) );
  _.assert( _.objectIs( o.methods ) );

  /* */

  let propertyDescriptor = _.propertyDescriptorActiveGet( o.object, o.fieldName );
  if( propertyDescriptor.descriptor )
  {
    _.assert( _.strIs( o.combining ), 'forbid : if accessor overided expect ( o.combining ) is', _.accessor.Combining.join() );

    if( _.routineIs( propertyDescriptor.descriptor.get ) && propertyDescriptor.descriptor.get.name === 'forbidden' )
    {
      return false;
    }

  }

  /* check fields */

  if( o.strict )
  if( propertyDescriptor.object === o.object )
  {
    if( _.accessor.ownForbid( o.object, o.fieldName ) )
    {
      return false;
    }
    else
    {
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

    _.accessor._register
    ({
      proto : o.object,
      name : o.fieldName,
      declaratorName : 'forbid',
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

var defaults = _forbidDeclare.defaults = Object.create( forbid.defaults );

defaults.fieldName = null;
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
 * _.accessor.ownForbid( Self, 'a' ) // returns true
 * _.accessor.ownForbid( Self, 'b' ) // returns false
 *
 * @function ownForbid
 * @namespace Tools.accessor
 */

function ownForbid( object, name )
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

// --
// etc
// --

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
 * @function forbid
 * @namespace Tools.accessor
 */

function readOnly_body( o )
{
  _.assertRoutineOptions( readOnly_body, arguments );
  _.assert( o.readOnly );
  return _.accessor.declare.body( o );
}

var defaults = readOnly_body.defaults = Object.create( declare.body.defaults );
defaults.readOnly = true;

let readOnly = _.routineFromPreAndBody( _declare_pre, readOnly_body );

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
 * @function supplement
 *
 * @namespace Tools.accessor
 */

function supplement( dst, src )
{

  _.workpiece.fieldsGroupFor( dst, '_Accessors' );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _ObjectHasOwnProperty.call( dst, '_Accessors' ), 'supplement : dst should has _Accessors map' );
  _.assert( _ObjectHasOwnProperty.call( src, '_Accessors' ), 'supplement : src should has _Accessors map' );

  /* */

  for( let a in src._Accessors )
  {

    let accessor = src._Accessors[ a ];

    if( _.objectIs( accessor ) )
    supplement( a, accessor );
    else for( let i = 0 ; i < accessor.length ; i++ )
    supplement( a, accessor[ i ] );

  }

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

}

// --
// etc
// --

// /**
//  * Makes constants properties on object by creating new or replacing existing properties.
//  * @param {object} dstPrototype - prototype of class which will get new constant property.
//  * @param {object} namesObject - name/value map of constants.
//  *
//  * @example
//  * let Self = function ClassName( o ) { };
//  * let Constants = { num : 100  };
//  * _.constant ( Self.prototype, Constants );
//  * console.log( Self.prototype ); // returns { num: 100 }
//  * Self.prototype.num = 1;// error assign to read only property
//  *
//  * @function constant
//  * @throws {exception} If no argument provided.
//  * @throws {exception} If( dstPrototype ) is not a Object.
//  * @throws {exception} If( name ) is not a Map.
//  * @namespace Tools.accessor
//  */
//
// function constant( dstPrototype, name, value )
// {
//
//   _.assert( arguments.length === 2 || arguments.length === 3 );
//   _.assert( !_.primitiveIs( dstPrototype ), () => 'dstPrototype is needed, but got ' + _.toStrShort( dstPrototype ) );
//
//   if( _.containerIs( name ) )
//   {
//     _.eachKey( name, ( n, v ) =>
//     {
//       if( value !== undefined )
//       _.propertyConstant( dstPrototype, n, value );
//       else
//       _.propertyConstant( dstPrototype, n, v );
//     });
//     return;
//   }
//
//   if( value === undefined )
//   value = dstPrototype[ name ];
//
//   _.assert( _.strIs( name ), 'name is needed, but got', name );
//
//   Object.defineProperty( dstPrototype, name,
//   {
//     value,
//     enumerable : true,
//     writable : false,
//     configurable : true,
//   });
//
// }

//

/**
 * Returns true if source object( proto ) has accessor with name( name ).
 * @param {Object} proto - target object
 * @param {String} name - name of accessor
 * @function has
 * @namespace Tools.accessor
 */

function has( proto, name )
{
  let accessors = proto._Accessors;
  if( !accessors )
  return false;
  return !!accessors[ name ];
}

//

function suiteMakerFrom_functor( fop )
{

  if( arguments.length === 2 )
  fop = { getterFunctor : arguments[ 0 ], setterFunctor : arguments[ 1 ] }

  _.routineOptions( suiteMakerFrom_functor, fop );

  let defaults;
  if( fop.getterFunctor )
  defaults = _.mapExtend( null, fop.getterFunctor.defaults );
  else
  defaults = _.mapExtend( null, fop.setterFunctor.defaults );

  if( fop.getterFunctor && _.entityIdentical )
  _.assert( _.entityIdentical( defaults, _.mapExtend( null, fop.getterFunctor.defaults ) ) );
  if( fop.setterFunctor && _.entityIdentical )
  _.assert( _.entityIdentical( defaults, _.mapExtend( null, fop.setterFunctor.defaults ) ) );

  let _pre = fop.getterFunctor.pre || fop.setterFunctor.pre;
  if( _pre )
  accessorMaker.pre = pre;

  accessorMaker.defaults = defaults;

  return accessorMaker;

  /* */

  function pre( routine, args )
  {
    let o2 = _pre( routine, args );
    return o2;
  }

  /* */

  function accessorMaker( o )
  {
    let r = Object.create( null );

    if( _pre )
    o = pre( accessorMaker, arguments );
    else
    o = _.routineOptions( accessorMaker, arguments );

    if( fop.setterFunctor )
    if( fop.setterFunctor.body )
    r.set = fop.setterFunctor.body( o );
    else
    r.set = fop.setterFunctor( o );

    if( fop.getterFunctor )
    if( fop.getterFunctor.body )
    r.get = fop.getterFunctor.body( o );
    else
    r.get = fop.getterFunctor( o );

    return r;
  }

}

suiteMakerFrom_functor.defaults =
{
  getterFunctor : null,
  setterFunctor : null,
}

// --
// getter / setter functors
// --

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
 * @namespace Tools.accessor.setter
 */

function setterOwn_functor( op )
{
  let symbol = Symbol.for( op.name );

  _.routineOptions( setterOwn_functor, arguments );

  return function ownSet( src )
  {
    let self = this;

    _.assert( arguments.length === 1 );

    self[ symbol ] = _.entityMake( src );

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
    else if( _.objectIs( self[ symbol ] ) && !self[ symbol ].copy )
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
 * @namespace Tools.accessor.setter
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
 * @summary Allows to get read and write access to property of inner container.
 * @param {Object} o
 * @param {String} o.name
 * @param {Number} o.index
 * @param {String} o.storageName
 * @function toElement
 * @namespace Tools.accessor.getterSetter
 */

function toElementSet_functor( o )
{
  _.assert( 0, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( o.names ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.strIs( o.storageName ) );
  _.assert( _.numberIs( o.index ) );
  _.routineOptions( toElementSet_functor, o );

  debugger;

  let index = o.index;
  let storageName = o.storageName;
  let name = o.name;
  let aname = _.accessor._propertyGetterSetterNames( name );

  _.assert( _.numberIs( index ) );
  _.assert( index >= 0 );

  return function accessorToElementSet( src )
  {
    this[ storageName ][ index ] = src;
  }

  return r;
}

toElementSet_functor.defaults =
{
  name : null,
  index : null,
  storageName : null,
}

//

function symbolPut_functor( o )
{
  o = _.routineOptions( symbolPut_functor, arguments );
  let symbol = Symbol.for( o.fieldName );
  return function put( val )
  {
    this[ symbol ] = val;
    return val;
  }
}

symbolPut_functor.defaults =
{
  fieldName : null,
}

symbolPut_functor.rubrics = [ 'accessor', 'put', 'functor' ];

//

function toElementGet_functor( o )
{
  _.assert( 0, 'not tested' );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( o.names ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.strIs( o.storageName ) );
  _.assert( _.numberIs( o.index ) );
  _.routineOptions( toElementGet_functor, o );

  debugger;

  let index = o.index;
  let storageName = o.storageName;
  let name = o.name;
  let aname = _.accessor._propertyGetterSetterNames( name );

  _.assert( _.numberIs( index ) );
  _.assert( index >= 0 );

  return function accessorToElementGet()
  {
    return this[ storageName ][ index ];
  }
}

toElementGet_functor.defaults =
{
  name : null,
  index : null,
  storageName : null,
}

//

function withSymbolGet_functor( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( withSymbolGet_functor, o );
  _.assert( _.strDefined( o.fieldName ) );

  let spaceName = o.fieldName;
  let setter = Object.create( null );
  let getter = Object.create( null );
  let symbol = Symbol.for( spaceName );

  return function toStructure()
  {
    let helper = this[ symbol ];
    if( !helper )
    {
      helper = this[ symbol ] = proxyMake( this );
    }
    return helper;
  }

  /* */

  function proxyMake( original )
  {
    let handlers =
    {
      get( original, fieldName, proxy )
      {
        let method = getter[ fieldName ];
        if( method )
        return end();

        if( fieldName === spaceName )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return undefined;
          }
          return end();
        }

        debugger;
        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        method = getter[ fieldName ] = function get( value )
        {
          return this[ symbol ];
        }
        return end();

        function end()
        {
          return method.call( original );
        }

      },
      set( original, fieldName, value, proxy )
      {
        let method = setter[ fieldName ];
        if( method )
        return end();

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        method = setter[ fieldName ] = function put( value )
        {
          this[ symbol ] = value;
        }
        return end();

        function end()
        {
          method.call( original, value );
          return true;
        }
      },
    };

    let proxy = new Proxy( original, handlers );

    return proxy;
  }

}

withSymbolGet_functor.defaults =
{
  fieldName : null,
}

withSymbolGet_functor.rubrics = [ 'accessor', 'getter', 'functor' ];

//

function toStructureGet_functor( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( toStructureGet_functor, o );
  _.assert( _.strDefined( o.fieldName ) );

  let spaceName = o.fieldName;
  let setter = Object.create( null );
  let getter = Object.create( null );
  let symbol = Symbol.for( spaceName );

  return function toStructure()
  {
    let helper = this[ symbol ];
    if( !helper )
    {
      helper = this[ symbol ] = proxyMake( this );
    }
    return helper;
  }

  /* */

  function proxyMake( original )
  {
    let handlers =
    {
      get( original, fieldName, proxy )
      {
        let method = getter[ fieldName ];
        if( method )
        return end();

        if( fieldName === spaceName )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return undefined;
          }
          return end();
        }

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        if( original.hasField( fieldName ) || Object.hasOwnProperty.call( original, symbol ) )
        {
          debugger;
          method = getter[ fieldName ] = function get( value )
          {
            debugger;
            return this[ symbol ];
          }
          return end();
        }

        method = getter[ fieldName ] = function get( value )
        {
          return this[ fieldName ];
        }
        return end();

        function end()
        {
          return method.call( original );
        }

      },
      set( original, fieldName, value, proxy )
      {
        let method = setter[ fieldName ];
        if( method )
        return end();

        let putName1 = '_' + fieldName + 'Put';
        if( original[ putName1 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName1 ]( value );
          }
          return end();
        }

        let putName2 = fieldName + 'Put';
        if( original[ putName2 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName2 ]( value );
          }
          return end();
        }

        let symbol = _.symbolIs( fieldName ) ? fieldName : Symbol.for( fieldName );
        if( original.hasField( fieldName ) || Object.hasOwnProperty.call( original, symbol ) )
        {
          method = setter[ fieldName ] = function put( value )
          {
            this[ symbol ] = value;
          }
          return end();
        }

        method = setter[ fieldName ] = function put( value )
        {
          this[ fieldName ] = value;
        }

        return end();

        function end()
        {
          method.call( original, value );
          return true;
        }
      },
    };

    let proxy = new Proxy( original, handlers );

    return proxy;
  }

}

toStructureGet_functor.defaults =
{
  fieldName : null,
}

toStructureGet_functor.rubrics = [ 'accessor', 'getter', 'functor' ]; /* xxx : deprecate in favor of toValueGet_functor */

//

function toValueGet_functor( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( toValueGet_functor, o );
  _.assert( _.strDefined( o.fieldName ) );

  let spaceName = o.fieldName;
  let setter = Object.create( null );
  let getter = Object.create( null );
  // let symbol = Symbol.for( spaceName );

  return function toStructure()
  {
    // let helper = this[ symbol ];
    // if( !helper )
    // {
    //   helper = this[ symbol ] = proxyMake( this );
    // }
    let helper = proxyMake( this );
    let o2 =
    {
      enumerable : false,
      configurable : false,
      value : helper
    }
    Object.defineProperty( this, spaceName, o2 );
    return helper;
  }

  /* */

  function proxyMake( original )
  {
    let handlers =
    {
      get( original, fieldName, proxy )
      {
        let method = getter[ fieldName ];
        if( method )
        return end();

        if( fieldName === spaceName )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return undefined;
          }
          return end();
        }

        if( _.symbolIs( fieldName ) )
        {
          let symbol = fieldName;
          method = getter[ fieldName ] = function get( value )
          {
            return this[ symbol ];
          }
          return end();
        }

        let getName1 = '_' + fieldName + 'Get';
        let getName2 = '' + fieldName + 'Get';

        if( _.routineIs( original[ getName1 ] ) )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return original[ getName1 ]();
          }
          return end();
        }

        if( _.routineIs( original[ getName2 ] ) )
        {
          method = getter[ fieldName ] = function get( value )
          {
            return original[ getName2 ]();
          }
          return end();
        }

        let symbol = Symbol.for( fieldName );
        method = getter[ fieldName ] = function get( value )
        {
          return this[ symbol ];
        }
        return end();

        function end()
        {
          return method.call( original );
        }

      },
      set( original, fieldName, value, proxy )
      {
        let method = setter[ fieldName ];
        if( method )
        return end();

        let putName1 = '_' + fieldName + 'Put';
        if( original[ putName1 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName1 ]( value );
          }
          return end();
        }

        let putName2 = fieldName + 'Put';
        if( original[ putName2 ] )
        {
          method = setter[ fieldName ] = function put( value )
          {
            return this[ putName2 ]( value );
          }
          return end();
        }

        method = setter[ fieldName ] = function put( value )
        {
          this[ symbol ] = value;
        }

        return end();

        function end()
        {
          method.call( original, value );
          return true;
        }
      },
    };

    let proxy = new Proxy( original, handlers );

    return proxy;
  }

}

toValueGet_functor.defaults =
{
  fieldName : null,
}

toValueGet_functor.rubrics = [ 'accessor', 'getter', 'functor' ];

//

let toElementSuite = suiteMakerFrom_functor( toElementGet_functor, toElementSet_functor );

//

/**
 * Makes a setter that is an alias for other property.
 * @param {Object} o - options map
 * @param {Object} o.original - name of source property
 * @param {Object} o.alias - name of alias
 * @returns {Function} Returns setter function.
 * @function alias
 * @namespace Tools.accessor.setter
 */

function alias_pre( routine, args )
{

  let o = args[ 0 ];
  if( _.strIs( args[ 0 ] ) )
  o = { originalName : args[ 0 ] }
  // o = { originalName : args[ 0 ], aliasName : args[ 1 ] }

  _.routineOptions( routine, o );

  // if( o.aliasName === null )
  // o.aliasName = o.originalName;
  // if( o.originalName === null )
  // o.originalName = o.aliasName;

  _.assert( args.length === 1, 'Expects single argument' );
  // _.assert( args.length === 1 || args.length === 2, 'Expects single argument' );
  // _.assert( _.strIs( o.aliasName ) );
  _.assert( _.strIs( o.originalName ) );

  return o;
}

//

function aliasSetter_functor_body( o )
{
  let container = o.container;
  let originalName = o.originalName;
  // let aliasName = o.aliasName;

  _.assertRoutineOptions( aliasSetter_functor_body, arguments );

  if( _.strIs( container ) )
  return function aliasSet( src )
  {
    let self = this;
    self[ container ][ originalName ] = src;
    return self[ container ][ originalName ];
  }
  else if( _.objectLike( container ) || _.routineLike( container ) )
  return function aliasSet( src )
  {
    let self = this;
    return container[ originalName ] = src;
  }
  else if( container === null )
  return function aliasSet( src )
  {
    let self = this;
    self[ originalName ] = src;
    return self[ originalName ];
  }
  else _.assert( 0, `Unknown type of container ${_.strType( container )}` );

}

aliasSetter_functor_body.defaults =
{
  container : null,
  originalName : null,
  // aliasName : null,
  // fieldName : null,
}

let aliasSet_functor = _.routineFromPreAndBody( alias_pre, aliasSetter_functor_body );

//

/**
 * Makes a getter that is an alias for other property.
 * @param {Object} o - options map
 * @param {Object} o.original - name of source property
 * @param {Object} o.alias - name of alias
 * @returns {Function} Returns getter function.
 * @function alias
 * @namespace Tools.accessor.getter
 */

function aliasGet_functor_body( o )
{

  let container = o.container;
  let originalName = o.originalName;
  // let aliasName = o.aliasName;

  _.assertRoutineOptions( aliasGet_functor_body, arguments );

  if( _.strIs( container ) )
  return function aliasGet( src )
  {
    let self = this;
    return self[ container ][ originalName ];
  }
  else if( _.objectLike( container ) || _.routineLike( container ) )
  return function aliasGet( src )
  {
    let self = this;
    return container[ originalName ];
  }
  else if( container === null )
  return function aliasGet( src )
  {
    let self = this;
    return self[ originalName ];
  }
  else _.assert( 0, `Unknown type of container ${_.strType( container )}` );

}

aliasGet_functor_body.defaults = Object.create( aliasSet_functor.defaults );

let aliasGetter_functor = _.routineFromPreAndBody( alias_pre, aliasGet_functor_body );

//

let aliasSuite = suiteMakerFrom_functor( aliasGetter_functor, aliasSet_functor );

// //
//
// function get( obj, key )
// {
// }
//
// //
//
// function set( obj, key, val )
// {
//   debugger;
// }
//
// //
//
// function put( obj, key, val )
// {
//   debugger;
//   let descriptor = _.propertyDescriptorGet( obj, key );
//   debugger;
//   if( !descriptor )
//   {
//     obj[ key ] = val;
//     return;
//   }
//   if( descriptor.put )
//   return descriptor.put.call( obj, val );
//   obj[ key ] = val;
// }

// --
// meta
// --

function _DefinesGenerate( dst, src, kind )
{
  if( dst === null )
  dst = Object.create( null );

  _.assert( arguments.length === 3 );

  for( let s in src )
  {
    dst[ s ] = _DefineGenerate( src[ s ], kind );
  }

  return dst;
}

//

function _DefineGenerate( original, kind )
{
  _.assert( _.routineIs( original ) );

  let r =
  {
    [ original.name ] : function()
    {
      let definition = _.define[ kind ]({ ini : arguments, routine : original });
      _.assert( _.definitionIs( definition ) );
      return definition;
    }
  }

  let routine = r[ original.name ];

  _.routineExtend( routine, original );
  _.assert( arguments.length === 2 );

  routine.originalFunctor = original;

  _.assert( _.routineIs( _.define[ kind ] ) );

  return routine;
}

// --
// fields
// --

let AccessorType = [ 'get', 'set', 'put', 'copy' ];
let Combining = [ 'rewrite', 'supplement', 'apppend', 'prepend' ];

let DefaultAccessorsMap = Object.create( null );
DefaultAccessorsMap.Accessors = declare;
DefaultAccessorsMap.Forbids = forbid;
DefaultAccessorsMap.AccessorsForbid = forbid;
DefaultAccessorsMap.AccessorsReadOnly = readOnly;

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
//
// --

let AccessorExtension =
{

  // getter / setter generator

  _propertyGetterSetterNames,
  _methodsMake,
  _methodsNames,
  _methodsRetrieve,
  _methodsValidate,
  _methodCopyGet,

  copyIterationMake,

  // declare

  _register,
  _declare_pre,
  _declareAct,
  declare,

  // forbid

  forbid,
  _forbidDeclare,
  ownForbid,

  supplement,

  // etc

  readOnly,
  has,
  suiteMakerFrom_functor,

  // fields

  AccessorDefaults,
  Combining,
  AccessorType,
  DefaultAccessorsMap,

}

//

let ToolsExtension =
{
  // get,
  // set,
  // put,
}

//

let Getter =
{

  alias : aliasGetter_functor,
  toElement : toElementGet_functor,
  toStructure : toStructureGet_functor,
  toValue : toValueGet_functor,
  withSymbol : withSymbolGet_functor,

}

//

let Setter =
{

  mapCollection : setterMapCollection_functor,
  arrayCollection : setterArrayCollection_functor,

  own : setterOwn_functor,
  friend : setterFriend_functor,
  copyable : setterCopyable_functor,
  bufferFrom : setterBufferFrom_functor,
  changesTracking : setterChangesTracking_functor,

  alias : aliasSet_functor,
  toElement : toElementSet_functor,

}

//

let Putter =
{

  symbol : symbolPut_functor,

}

//

let Suite =
{

  toElement : toElementSuite,
  alias : aliasSuite,

}

// --
// extend
// --

_.accessor = _.accessor || Object.create( null );
_.mapSupplement( _, ToolsExtension );
_.mapExtend( _.accessor, AccessorExtension );

_.accessor.forbid( _, Forbids );
_.accessor.forbid( _.accessor, Forbids );

_.accessor.getter = _.accessor.getter || Object.create( null );
_.mapExtend( _.accessor.getter, Getter );

_.accessor.setter = _.accessor.setter || Object.create( null );
_.mapExtend( _.accessor.setter, Setter );

_.accessor.putter = _.accessor.putter || Object.create( null );
_.mapExtend( _.accessor.putter, Putter );

_.accessor.suite = _.accessor.suite || Object.create( null );
_.mapExtend( _.accessor.suite, Suite );

_.accessor.define = _.accessor.define || Object.create( null );
_.accessor.define.getter = _DefinesGenerate( _.accessor.define.getter || null, _.accessor.getter, 'getter' );
_.accessor.define.setter = _DefinesGenerate( _.accessor.define.setter || null, _.accessor.setter, 'setter' );
_.accessor.define.putter = _DefinesGenerate( _.accessor.define.putter || null, _.accessor.putter, 'putter' );
_.accessor.define.suite = _DefinesGenerate( _.accessor.define.suite || null, _.accessor.suite, 'accessor' );

_.assert( _.routineIs( _.accessor.define.getter.alias ) );
// _.assert( _.set === set );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
