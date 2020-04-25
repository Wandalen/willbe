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
 * @summary Collection of getters
 * @namespace wTools.accessor.getter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

 /**
 * @summary Collection of setters
 * @namespace wTools.accessor.setter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

 /**
 * @summary Collection of putters
 * @namespace wTools.accessor.putter
 * @extends Tools.accessor
 * @module Tools/base/Proto
 */

/**
 * @summary Collection of setters
 * @namespace wTools.accessor.suite
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
 * @property {Function} [ suite=null ]
 * @namespace Tools.accessor
 **/

let AccessorDefaults =
{

  strict : 1,
  preservingValue : null,
  prime : null,
  combining : null,
  addingMethods : null,
  enumerable : null,
  configurable : null,

  readOnly : 0,
  readOnlyProduct : 0,

  get : null,
  set : null,
  put : null,
  copy : null,
  suite : null, /* xxx : rename? */

}

let AccessorPreferences =
{

  strict : 1,
  preservingValue : 1,
  prime : null,
  combining : null,
  addingMethods : 0,
  enumerable : 1,
  configurable : 0,

  readOnly : 0,
  readOnlyProduct : 0,

  get : null,
  set : null,
  put : null,
  copy : null,
  suite : null, /* xxx : rename? */

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

  if( o.suite )
  {
    // _.assertMapHasOnly( o.suite, { get : null, set : null, put : null, copy : null } );
    // debugger;
    _.assertMapHasOnly( o.suite, _.accessor.AccessorType );
  }

  if( o.suite && o.set === null && o.suite.set )
  o.set = o.suite.set;
  if( _.boolLike( o.set ) )
  o.set = !!o.set;

  if( o.suite && o.get === null && o.suite.get )
  o.get = o.suite.get;
  if( _.boolLike( o.get ) )
  o.get = !!o.get;

  if( o.get !== false && o.get !== 0 )
  {
    if( o.get )
    result.get = o.get;
    else if( o.suite && o.suite.get )
    result.get = o.suite.get;
    else if( o.methods[ '' + o.name + 'Get' ] )
    result.get = o.methods[ o.name + 'Get' ];
    else if( o.methods[ '_' + o.name + 'Get' ] )
    result.get = o.methods[ '_' + o.name + 'Get' ];
  }

  if( o.set !== false && o.set !== 0 )
  {
    if( o.set )
    result.set = o.set;
    else if( o.suite && o.suite.set )
    result.set = o.suite.set;
    else if( o.methods[ '' + o.name + 'Set' ] )
    result.set = o.methods[ o.name + 'Set' ];
    else if( o.methods[ '_' + o.name + 'Set' ] )
    result.set = o.methods[ '_' + o.name + 'Set' ];
  }

  if( o.put !== false && o.put !== 0 )
  {
    if( o.put )
    result.put = o.put;
    else if( o.suite && o.suite.put )
    result.put = o.suite.put;
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
    else if( o.suite && o.suite.copy )
    result.copy = o.suite.copy;
    else if( o.methods[ '' + o.name + 'Copy' ] )
    result.copy = o.methods[ o.name + 'Copy' ];
    else if( o.methods[ '_' + o.name + 'Copy' ] )
    result.copy = o.methods[ '_' + o.name + 'Copy' ];
  }

  let fieldName = '_' + o.name;
  let fieldSymbol = Symbol.for( o.name );

  /* copy */

  if( result.copy )
  {
    let copy = result.copy;
    let name = o.name;

    if( !result.set && o.set === null )
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

    if( !result.get && o.get === null )
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

  // if( !result.set && o.set === null )
  // if( !result.set && o.set === null || o.set === true || o.set === 1 )
  if( !result.set )
  if( o.set === null || o.set === true || o.set === 1 )
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
  if( o.get === null || o.get === true || o.get === 1 )
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

  _.assert( !result.set || o.set !== false, () => 'Field ' + _.strQuote( o.name ) + ' is read only, but setter found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.set || o.set === false, () => 'Field ' + _.strQuote( o.name ) + ' is not read only, but setter not found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.get || o.get === false, () => 'Field ' + _.strQuote( o.name ) + ' is not read only, but getter not found in' + _.toStrShort( o.methods ) );
  _.assert( !!result.put || !o.put, () => 'Field ' + _.strQuote( o.name ) + ' putter not found in' + _.toStrShort( o.methods ) );

  return result;
}

_methodsMake.defaults =
{
  name : null,
  object : null,
  methods : null,
  readOnlyProduct : 0, /* xxx */
  copy : null,
  set : null,
  get : null,
  put : null,
  suite : null,
}

//

// function _methodsUnfunct( amethods, accessor )
function _methodsUnfunct( o )
{

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o.amethods ) );
  _.assertRoutineOptions( _methodsUnfunct, arguments );

  resultUnfunct( 'get' );
  resultUnfunct( 'set' );
  resultUnfunct( 'put' );
  resultUnfunct( 'copy' );

  return o.amethods;

  /* */

  function resultUnfunct( kind )
  {
    _.assert( _.primitiveIs( kind ) );
    if( !o.amethods[ kind ] )
    return;
    let amethod = o.amethods[ kind ];
    let r = _.accessor._methodUnfunct({ amethod, kind, accessor : o });
    o.amethods[ kind ] = r;
    return r;
  }

}

var defaults = _methodsUnfunct.defaults =
{
  ... AccessorDefaults,
  name : null,
  object : null,
  methods : null,
  amethods : null,
}

//

function _methodUnfunct( o )
{

  _.assert( arguments.length === 1 );

  if( !_.routineIs( o.amethod ) )
  return o.amethod;

  if( o.amethod && o.amethod.rubrics && _.longHas( o.amethod.rubrics, 'functor' ) )
  {
    let o2 = Object.create( null );
    if( o.amethod.defaults )
    {
      if( o.amethod.defaults.fieldName !== undefined )
      o2.fieldName = o.accessor.name;
      if( o.amethod.defaults.accessor !== undefined )
      o2.accessor = o.accessor;
      if( o.amethod.defaults.accessorKind !== undefined )
      o2.accessorKind = o.kind;
    }
    o.amethod = o.amethod( o2 );
  }

  return o.amethod;
}

_methodUnfunct.defaults =
{
  amethod : null,
  accessor : null,
  kind : null,
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

  o.suite = _.accessor._methodUnfunct
  ({
    amethod : o.suite,
    accessor : o,
    kind : 'suite',
  });

  o.amethods = _.accessor._methodsMake /* xxx : rename amethods -> suite */
  ({
    name : o.name,
    methods : o.methods,
    object : o.object,
    readOnlyProduct : o.readOnlyProduct,
    put : o.put,
    copy : o.copy,
    get : o.get,
    set : o.readOnly ? false : o.set,
    suite : o.suite,
  });

  o.amethods = _.accessor._methodsUnfunct( o );

  defaultsApply();

  let anames;
  if( o.prime || o.addingMethods )
  anames = _.accessor._methodsNames
  ({
    object : o.object,
    amethods : o.amethods,
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
    delete o2.amethods;
    for( let k in o.amethods )
    o2.methods[ anames[ k ] ] = o.amethods[ k ];

    _.accessor._register
    ({
      proto : o.object,
      name : o.name,
      declaratorName : 'accessor',
      declaratorArgs : [ o2 ],
      combining : o.combining,
    });

  }

  let fieldSymbol = Symbol.for( o.name );

  /* preservingValue */

  if( o.preservingValue ) /* xxx : use put */
  if( _ObjectHasOwnProperty.call( o.object, o.name ) )
  {
    if( o.amethods.put )
    o.amethods.put.call( o.object, o.object[ o.name ] );
    else
    o.object[ fieldSymbol ] = o.object[ o.name ];
  }

  /* addingMethods */

  if( o.addingMethods )
  {
    for( let n in o.amethods )
    {
      o.object[ anames[ n ] ] = o.amethods[ n ];
    }
  }

  /* define accessor */

  _.assert( o.amethods.get !== undefined );

  let o2 =
  {
    enumerable : !!o.enumerable,
    configurable : !!o.configurable,
  }
  if( _.routineIs( o.amethods.get ) )
  {
    if( o.amethods.set )
    {
      o2.set = o.amethods.set;
    }
    o2.get = o.amethods.get;
  }
  else
  {
    _.assert( o.amethods.set === undefined );
    o2.value = o.amethods.get;
  }

  if( _global_.debugger )
  debugger;
  Object.defineProperty( o.object, o.name, o2 );

  /* validate */

  if( Config.debug )
  _.accessor._methodsValidate({ object : o.object, name : o.name, amethods : o.amethods });

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

  /* */

  function defaultsApply()
  {

    if( o.prime === null )
    o.prime = _.prototypeIsStandard( o.object );

    for( let k in o )
    {
      if( o[ k ] === null && _.boolLike( _.accessor.AccessorPreferences[ k ] ) )
      o[ k ] = _.accessor.AccessorPreferences[ k ];
    }

    // if( o.configurable === null )
    // o.configurable = 0;
    // if( o.enumerable === null )
    // o.enumerable = 1;
    // if( o.addingMethods === null )
    // o.addingMethods = 0;
    // if( o.preservingValue === null )
    // o.preservingValue = 1;

    _.assert( _.boolLike( o.prime ) );
    _.assert( _.boolLike( o.configurable ) );
    _.assert( _.boolLike( o.enumerable ) );
    _.assert( _.boolLike( o.addingMethods ) );
    _.assert( _.boolLike( o.preservingValue ) );

  }

  /* */

}

var defaults = _declareAct.defaults =
{
  ... AccessorDefaults,
  name : null,
  object : null,
  methods : null,
}

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
 * @property {Function} [ get=null ]
 * @property {Function} [ set=null ]
 * @property {Function} [ suite=null ]
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

    // if( _.routineIs( o2 ) && o2.rubrics && _.longHas( o2.rubrics, 'functor' ) )
    // {
    //   if( o2.defaults && o2.defaults.fieldName !== undefined )
    //   o2 = o2({ fieldName : n });
    //   else
    //   o2 = o2();
    // }

    // o2 = _.accessor._methodUnfunct({ amethod : o2, accessor : o, kind : 'suite' });

    if( _.routineIs( o2 ) && o2.rubrics && _.longHas( o2.rubrics, 'functor' ) )
    o2 = { suite : o2 }

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
// relations
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

//

let AccessorExtension =
{

  // getter / setter generator

  _propertyGetterSetterNames,
  _methodsMake,
  _methodsUnfunct,
  _methodUnfunct,
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

  // meta

  suiteMakerFrom_functor,
  _DefinesGenerate,
  _DefineGenerate,

  // fields

  AccessorDefaults,
  AccessorPreferences,
  Combining,
  AccessorType,
  DefaultAccessorsMap,

}

//

let ToolsExtension =
{
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
_.accessor.setter = _.accessor.setter || Object.create( null );
_.accessor.putter = _.accessor.putter || Object.create( null );
_.accessor.suite = _.accessor.suite || Object.create( null );
_.accessor.define = _.accessor.define || Object.create( null );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
