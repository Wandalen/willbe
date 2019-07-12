( function _Proto_s_() {

'use strict';

/**
 * Relations module. Collection of routines to define classes and relations between them. Proto leverages multiple inheritances, mixins, accessors, fields groups defining, introspection and more. Use it as a skeleton of the application.
  @module Tools/base/Proto
*/

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

*  routine :: arithmetical,logical and other manipulations on input data, context and globals to get output data.
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

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  if( !_global_.wTools.nameFielded )
  try
  {
    require( './NameTools.s' );
  }
  catch( err )
  {
  }

}

let Self = _global_.wTools;
let _global = _global_;
let _ = _global_.wTools;

let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _propertyIsEumerable = Object.propertyIsEnumerable;
let _nameFielded = _.nameFielded;

_.assert( _.objectIs( _.field ),'wProto needs wTools/staging/dwtools/abase/l1/FieldMapper.s' );
_.assert( _.routineIs( _nameFielded ),'wProto needs wTools/staging/dwtools/l3/NameTools.s' );

// --
// fields group
// --

function fieldsGroupsGet( src )
{
  _.assert( _.objectIs( src ), () => 'Expects map {-src-}, but got ' + _.strType( src ) );
  _.assert( src.Groups === undefined || _.objectIs( src.Groups ) );

  if( src.Groups )
  return src.Groups;

  return _.DefaultFieldsGroups;
}

//

function fieldsGroupFor( dst, fieldsGroupName )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( fieldsGroupName ) );
  _.assert( !_.primitiveIs( dst ) );

  if( !_ObjectHasOwnProperty.call( dst, fieldsGroupName ) )
  {
    let field = dst[ fieldsGroupName ];
    dst[ fieldsGroupName ] = Object.create( null );
    if( field )
    Object.setPrototypeOf( dst[ fieldsGroupName ], field );
  }

  if( Config.debug )
  {
    let parent = Object.getPrototypeOf( dst );
    if( parent && parent[ fieldsGroupName ] )
    _.assert( Object.getPrototypeOf( dst[ fieldsGroupName ] ) === parent[ fieldsGroupName ] );
  }

  return dst;
}

//

/**
* Default options for fieldsGroupDeclare function
* @typedef {object} wTools~protoAddDefaults
* @property {object} [ o.fieldsGroupName=null ] - object that contains class relationship type name.
* Example : { Composes : 'Composes' }. See {@link wTools~DefaultFieldsGroupsRelations}
* @property {object} [ o.dstPrototype=null ] - prototype of class which will get new constant property.
* @property {object} [ o.srcMap=null ] - name/value map of defaults.
* @property {bool} [ o.extending=false ] - to extending defaults if exist.
*/

/**
 * Adds own defaults to object. Creates new defaults container, if there is no such own.
 * @param {wTools~protoAddDefaults} o - options {@link wTools~protoAddDefaults}.
 * @private
 *
 * @example
 * let Self = function ClassName( o ) { };
 * _.fieldsGroupDeclare
 * ({
 *   fieldsGroupName : { Composes : 'Composes' },
 *   dstPrototype : Self.prototype,
 *   srcMap : { a : 1, b : 2 },
 * });
 * console.log( Self.prototype ); // returns { Composes: { a: 1, b: 2 } }
 *
 * @function fieldsGroupDeclare
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o.srcMap ) is not a Object.
 * @throws {exception} If( o ) is extented by unknown property.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupDeclare( o )
{
  o = o || Object.create( null );

  _.routineOptions( fieldsGroupDeclare,o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.srcMap === null || !_.primitiveIs( o.srcMap ),'Expects object {-o.srcMap-}, got', _.strType( o.srcMap ) );
  _.assert( _.strIs( o.fieldsGroupName ) );
  _.assert( _.routineIs( o.filter ) && _.strIs( o.filter.functionFamily ) );

  _.fieldsGroupFor( o.dstPrototype, o.fieldsGroupName );

  let fieldGroup = o.dstPrototype[ o.fieldsGroupName ];

  if( o.srcMap )
  _.mapExtendConditional( o.filter, fieldGroup, o.srcMap );

}

fieldsGroupDeclare.defaults =
{
  dstPrototype : null,
  srcMap : null,
  filter : _.field.mapper.bypass,
  fieldsGroupName : null,
}

//

/**
 * Adds own defaults( Composes ) to object. Creates new defaults container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Composes = { tree : null };
 * _.fieldsGroupComposesExtend( Self.prototype, Composes );
 * console.log( Self.prototype ); // returns { Composes: { tree: null } }
 *
 * @function fieldsGroupComposesExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupComposesExtend( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Composes';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    // filter : _.field.mapper.bypass,
  });

}

//

/**
 * Adds own aggregates to object. Creates new aggregates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Aggregates = { tree : null };
 * _.fieldsGroupAggregatesExtend( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @function fieldsGroupAggregatesExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAggregatesExtend( dstPrototype,srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Aggregates';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    // filter : _.field.mapper.bypass,
  });

}

//

/**
 * Adds own associates to object. Creates new associates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Associates = { tree : null };
 * _.fieldsGroupAssociatesExtend( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @function fieldsGroupAssociatesExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAssociatesExtend( dstPrototype,srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Associates';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    // filter : _.field.mapper.bypass,
  });

}

//

/**
 * Adds own restricts to object. Creates new restricts container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Restricts = { tree : null };
 * _.fieldsGroupRestrictsExtend( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @function fieldsGroupRestrictsExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupRestrictsExtend( dstPrototype,srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Restricts';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    // filter : _.field.mapper.bypass,
  });

}

//

/**
 * Adds own defaults( Composes ) to object. Creates new defaults container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Composes = { tree : null };
 * _.fieldsGroupComposesSupplement( Self.prototype, Composes );
 * console.log( Self.prototype ); // returns { Composes: { tree: null } }
 *
 * @function fieldsGroupComposesSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupComposesSupplement( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Composes';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    filter : _.field.mapper.dstNotHas,
  });

}

//

/**
 * Adds own aggregates to object. Creates new aggregates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Aggregates = { tree : null };
 * _.fieldsGroupAggregatesSupplement( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @function fieldsGroupAggregatesSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAggregatesSupplement( dstPrototype,srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Aggregates';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    filter : _.field.mapper.dstNotHas,
  });

}

//

/**
 * Adds own associates to object. Creates new associates container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Associates = { tree : null };
 * _.fieldsGroupAssociatesSupplement( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @function fieldsGroupAssociatesSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAssociatesSupplement( dstPrototype,srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Associates';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    filter : _.field.mapper.dstNotHas,
  });

}

//

/**
 * Adds own restricts to object. Creates new restricts container, if there is no such own.
 * @param {array-like} arguments - for arguments details see {@link wTools~protoAddDefaults}.
 *
 * @example
 * let Self = function ClassName( o ) { };
 * let Restricts = { tree : null };
 * _.fieldsGroupRestrictsSupplement( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @function fieldsGroupRestrictsSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupRestrictsSupplement( dstPrototype,srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Restricts';
  return _.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    filter : _.field.mapper.dstNotHas,
  });

}

// //
//
// function _fieldsOfRelationsGroups( src )
// {
//   let result = Object.create( null );
//
//   _.assert( _.objectIs( src ) );
//   _.assert( arguments.length === 1, 'Expects single argument' );
//
//   for( let g in _.DefaultFieldsGroupsRelations )
//   {
//
//     if( src[ g ] )
//     _.mapExtend( result, src[ g ] );
//
//   }
//
//   return result;
// }

//

function fieldsOfRelationsGroupsFromPrototype( src )
{
  let prototype = src;
  let result = Object.create( null );

  // debugger;
  _.assert( _.objectIs( prototype ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  for( let g in _.DefaultFieldsGroupsRelations )
  {
    if( src[ g ] )
    _.mapExtend( result, src[ g ] );
  }

  return result;
}

//

function fieldsOfCopyableGroupsFromPrototype( src )
{
  let prototype = src;
  let result = Object.create( null );

  _.assert( _.objectIs( prototype ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  for( let g in _.DefaultFieldsGroupsCopyable )
  {
    if( src[ g ] )
    _.mapExtend( result, src[ g ] );
  }

  return result;
}

//

function fieldsOfTightGroupsFromPrototype( src )
{
  let prototype = src;
  let result = Object.create( null );

  _.assert( _.objectIs( prototype ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  for( let g in _.DefaultFieldsGroupsTight )
  {
    if( src[ g ] )
    _.mapExtend( result, src[ g ] );
  }

  return result;
}

//

function fieldsOfInputGroupsFromPrototype( src )
{
  let prototype = src;
  let result = Object.create( null );

  _.assert( _.objectIs( prototype ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  for( let g in _.DefaultFieldsGroupsInput )
  {
    if( src[ g ] )
    _.mapExtend( result, src[ g ] );
  }

  return result;
}

//

function fieldsOfRelationsGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeGet( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  {
    return _.mapOnly( src, _.fieldsOfRelationsGroupsFromPrototype( prototype ) );
  }

  return _.fieldsOfRelationsGroupsFromPrototype( prototype );
}

//

function fieldsOfCopyableGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeGet( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  return _.mapOnly( src, _.fieldsOfCopyableGroupsFromPrototype( prototype ) );

  return _.fieldsOfCopyableGroupsFromPrototype( prototype );
}

//

function fieldsOfTightGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeGet( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  return _.mapOnly( src, _.fieldsOfTightGroupsFromPrototype( prototype ) );

  debugger;
  return _.fieldsOfTightGroupsFromPrototype( prototype );
}

//

function fieldsOfInputGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeGet( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  return _.mapOnly( src, _.fieldsOfInputGroupsFromPrototype( prototype ) );

  return _.fieldsOfInputGroupsFromPrototype( prototype );
}

//

function fieldsGroupsDeclare( o )
{

  _.routineOptions( fieldsGroupsDeclare,o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.srcMap === null || !_.primitiveIs( o.srcMap ),'Expects object {-o.srcMap-}, got', _.strType( o.srcMap ) );

  if( !o.srcMap )
  return;

  if( !o.fieldsGroups )
  o.fieldsGroups = _.fieldsGroupsGet( o.dstPrototype );

  _.assert( _.subPrototypeOf( o.fieldsGroups, _.DefaultFieldsGroups ) );

  for( let f in o.fieldsGroups )
  {

    if( !o.srcMap[ f ] )
    continue;

    _.fieldsGroupDeclare
    ({
      fieldsGroupName : f,
      dstPrototype : o.dstPrototype,
      srcMap : o.srcMap[ f ],
      filter : o.filter,
    });

    if( !_.DefaultFieldsGroupsRelations[ f ] )
    continue;

    if( Config.debug )
    {
      for( let f2 in _.DefaultFieldsGroupsRelations )
      if( f2 === f )
      {
        continue;
      }
      else for( let k in o.srcMap[ f ] )
      {
        _.assert( o.dstPrototype[ f2 ][ k ] === undefined,'Fields group','"'+f2+'"','already has fields','"'+k+'"','fields group','"'+f+'"','should not have the same' );
      }
    }

  }

}

fieldsGroupsDeclare.defaults =
{
  dstPrototype : null,
  srcMap : null,
  fieldsGroups : null,
  filter : fieldsGroupDeclare.defaults.filter,
}

//

function fieldsGroupsDeclareForEachFilter( o )
{

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( fieldsGroupsDeclareForEachFilter, arguments );
  _.assertMapHasNoUndefine( o );

  let oldFieldsGroups = _.fieldsGroupsGet( o.dstPrototype );
  let newFieldsGroups = Object.create( oldFieldsGroups )
  if( ( o.extendMap && o.extendMap.Groups ) || ( o.supplementOwnMap && o.supplementOwnMap.Groups ) || ( o.supplementMap && o.supplementMap.Groups ) )
  {
    if( o.supplementMap && o.supplementMap.Groups )
    _.mapSupplement( newFieldsGroups, o.supplementMap.Groups );
    if( o.supplementOwnMap && o.supplementOwnMap.Groups )
    _.mapSupplementOwn( newFieldsGroups, o.supplementOwnMap.Groups );
    if( o.extendMap && o.extendMap.Groups )
    _.mapExtend( newFieldsGroups, o.extendMap.Groups );
  }

  // if( fieldsGroups === _.DefaultFieldsGroups )

  if( !o.dstPrototype.Groups )
  o.dstPrototype.Groups = Object.create( _.DefaultFieldsGroups );

  for( let f in newFieldsGroups )
  _.fieldsGroupFor( o.dstPrototype, f );

  // _.fieldsGroupDeclare
  // ({
  //   fieldsGroupName : 'Group',
  //   dstPrototype : o.dstPrototype,
  //   srcMap : newFieldsGroups,
  //   filter : _.field.mapper.bypass,
  // });

  _.fieldsGroupsDeclare
  ({
    dstPrototype : o.dstPrototype,
    srcMap : o.extendMap,
    fieldsGroups : newFieldsGroups,
    filter : _.field.mapper.bypass,
  });
  _.fieldsGroupsDeclare
  ({
    dstPrototype : o.dstPrototype,
    srcMap : o.supplementOwnMap,
    fieldsGroups : newFieldsGroups,
    filter : _.field.mapper.dstNotOwn,
  });

  // if( o.dstPrototype.constructor.name === 'wPrinterBase' )
  // debugger;

  _.fieldsGroupsDeclare
  ({
    dstPrototype : o.dstPrototype,
    srcMap : o.supplementMap,
    fieldsGroups : newFieldsGroups,
    filter : _.field.mapper.dstNotHas,
  });

}

fieldsGroupsDeclareForEachFilter.defaults =
{
  dstPrototype : null,
  extendMap : null,
  supplementOwnMap : null,
  supplementMap : null,
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
//
// //
//
// function _propertyGetterSetterNames( propertyName )
// {
//   let result = Object.create( null );
//
//   _.assert( arguments.length === 1 );
//   _.assert( _.strIs( propertyName ) );
//
//   result.set = '_' + propertyName + 'Set';
//   result.get = '_' + propertyName + 'Get';
//
//   /* xxx : use it more extensively */
//
//   return result;
// }
//
// //
//
// function _propertyGetterSetterMake( o )
// {
//   let result = Object.create( null );
//
//   _.assert( arguments.length === 1 );
//   _.assert( _.objectLikeOrRoutine( o.methods ) );
//   _.assert( _.strIs( o.name ) );
//   _.assert( !!o.object );
//   _.assertRoutineOptions( _propertyGetterSetterMake, o );
//
//   if( o.getterSetter && o.setter === null && o.getterSetter.set )
//   o.setter = o.getterSetter.set;
//   if( _.boolLike( o.setter ) )
//   o.setter = !!o.setter;
//
//   if( o.getterSetter && o.getter === null && o.getterSetter.get )
//   o.getter = o.getterSetter.get;
//   if( _.boolLike( o.getter ) )
//   o.getter = !!o.getter;
//
//   if( o.getterSetter )
//   _.assertMapHasOnly( o.getterSetter, { get : null, set : null, copy : null } );
//
//   if( o.getter )
//   result.get = o.getter;
//   else if( o.getterSetter && o.getterSetter.get )
//   result.get = o.getterSetter.get;
//   else if( o.methods[ '' + o.name + 'Get' ] )
//   result.get = o.methods[ o.name + 'Get' ];
//   else if( o.methods[ '_' + o.name + 'Get' ] )
//   result.get = o.methods[ '_' + o.name + 'Get' ];
//
//   if( o.setter )
//   result.set = o.setter;
//   else if( o.getterSetter && o.getterSetter.set )
//   result.set = o.getterSetter.set;
//   else if( o.methods[ '' + o.name + 'Set' ] )
//   result.set = o.methods[ o.name + 'Set' ];
//   else if( o.methods[ '_' + o.name + 'Set' ] )
//   result.set = o.methods[ '_' + o.name + 'Set' ];
//
//   if( o.copy )
//   result.copy = o.copy;
//   else if( o.getterSetter && o.getterSetter.copy )
//   result.copy = o.getterSetter.copy;
//   else if( o.methods[ '' + o.name + 'Copy' ] )
//   result.copy = o.methods[ o.name + 'Copy' ];
//   else if( o.methods[ '_' + o.name + 'Copy' ] )
//   result.copy = o.methods[ '_' + o.name + 'Copy' ];
//
//   let fieldName = '_' + o.name;
//   let fieldSymbol = Symbol.for( o.name );
//
//   if( o.preserveValues )
//   if( _ObjectHasOwnProperty.call( o.methods, o.name ) )
//   o.object[ fieldSymbol ] = o.object[ o.name ];
//
//   /* copy */
//
//   if( result.copy )
//   {
//     let copy = result.copy;
//     let name = o.name;
//
//     if( !result.set && o.setter === null )
//     result.set = function set( src )
//     {
//       let it = Object.create( null );
//       it.dstInstance = this;
//       it.srcInstance = null;
//       it.instanceKey = name;
//       it.srcContainer = null;
//       it.dstContainer = null;
//       it.containerKey = null;
//       it.value = src;
//       copy.call( this, it );
//       return it.value;
//     }
//
//     if( !result.get && o.getter === null )
//     result.get = function get()
//     {
//       let it = Object.create( null );
//       it.dstInstance = null;
//       it.srcInstance = this;
//       it.instanceKey = name;
//       it.srcContainer = null;
//       it.dstContainer = null;
//       it.containerKey = null;
//       it.value = null;
//       copy.call( this, it );
//       return it.value;
//     }
//
//   }
//
//   /* set */
//
//   // if( !result.set && !o.readOnly )
//   if( !result.set && o.setter === null )
//   result.set = function set( src )
//   {
//     this[ fieldSymbol ] = src;
//     return src;
//   }
//
//   /* get */
//
//   if( !result.get && o.getter === null )
//   {
//
//     result.get = function get()
//     {
//       return this[ fieldSymbol ];
//     }
//
//   }
//
//   /* readOnlyProduct */
//
//   if( o.readOnlyProduct && result.get )
//   {
//     let get = result.get;
//     result.get = function get()
//     {
//       debugger;
//       let result = get.apply( this, arguments );
//       if( !_.primitiveIs( result ) )
//       result = _.proxyReadOnly( result );
//       return result;
//     }
//   }
//
//   /* validation */
//
//   // _.assert( !result.set || !o.readOnly, () => 'read only, but setter for ' + _.strQuote( o.name ) + ' found in' + _.toStrShort( o.methods ) );
//   // _.assert( !!result.set || !!o.readOnly );
//
//   _.assert( !result.set || o.setter !== false, () => 'Field ' + _.strQuote( o.name ) + ' is read only, but setter found in' + _.toStrShort( o.methods ) );
//   _.assert( !!result.set || o.setter === false, () => 'Field ' + _.strQuote( o.name ) + ' is not read only, but setter not found in' + _.toStrShort( o.methods ) );
//   _.assert( !!result.get );
//
//   return result;
// }
//
// _propertyGetterSetterMake.defaults =
// {
//   name : null,
//   object : null,
//   methods : null,
//   preserveValues : 1,
//   // readOnly : 0,
//   readOnlyProduct : 0,
//   copy : null,
//   setter : null,
//   getter : null,
//   getterSetter : null,
// }
//
// //
//
// function _propertyGetterSetterGet( object, propertyName )
// {
//   let result = Object.create( null );
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( _.objectIs( object ) );
//   _.assert( _.strIs( propertyName ) );
//
//   result.setName = object[ propertyName + 'Set' ] ? propertyName + 'Set' : '_' + propertyName + 'Set';
//   result.getName = object[ propertyName + 'Get' ] ? propertyName + 'Get' : '_' + propertyName + 'Get';
//   result.copyName = object[ propertyName + 'Copy' ] ? propertyName + 'Copy' : '_' + propertyName + 'Copy';
//
//   result.set = object[ result.setName ];
//   result.get = object[ result.getName ];
//   result.copy = object[ result.getName ];
//
//   return result;
// }
//
// //
//
// function _propertyCopyGet( srcInstance, name )
// {
//   _.assert( arguments.length === 2 );
//   _.assert( _.strIs( name ) );
//
//   if( !_.instanceIs( srcInstance ) )
//   return null;
//
//   if( srcInstance[ '' + name + 'Copy' ] )
//   return srcInstance[ name + 'Copy' ];
//   else if( srcInstance[ '_' + name + 'Copy' ] )
//   return srcInstance[ '_' + name + 'Copy' ];
//
//   return null;
// }

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
      throw _.err( 'Map does not have field',k );
      obj[ k ] = e;
      return true;
    },
    get : function( obj, k )
    {
      if( !_.symbolIs( k ) )
      if( obj[ k ] === undefined )
      throw _.err( 'Map does not have field',k );
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
      throw _.err( 'Read only',_.strType( ins ),ins );
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

function proxyMap( dst, original )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( !!dst );
  _.assert( !!original );

  let handler =
  {
    get : function( dst, k, proxy )
    {
      if( dst[ k ] !== undefined )
      return dst[ k ];
      return original[ k ];
    },
    set : function( dst, k, val, proxy )
    {
      if( dst[ k ] !== undefined )
      dst[ k ] = val;
      else if( original[ k ] !== undefined )
      original[ k ] = val;
      else
      dst[ k ] = val;
      return true;
    },
  }

  let result = new Proxy( dst, handler );

  return result;
}

// --
// mixin
// --

/**
 * Make mixin which could be mixed into prototype of another object.
 * @param {object} o - options.
 * @function _mixinDelcare
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function _mixinDelcare( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.mapIs( o ) || _.routineIs( o ) );
  _.assert( _.routineIs( o.onMixin ) || o.onMixin === undefined || o.onMixin === null, 'Expects routine {-o.onMixin-}, but got', _.strType( o ) );
  _.assert( _.strDefined( o.name ), 'mixin should have name' );
  _.assert( _.objectIs( o.extend ) || o.extend === undefined || o.extend === null );
  _.assert( _.objectIs( o.supplementOwn ) || o.supplementOwn === undefined || o.supplementOwn === null );
  _.assert( _.objectIs( o.supplement ) || o.supplement === undefined || o.supplement === null );
  _.assertOwnNoConstructor( o );

  _.routineOptions( _mixinDelcare, o );

  if( !o.onMixin )
  o.mixin = function mixin( dstClass )
  {
    let md = this.__mixin__;

    _.assert( _.objectIs( md ) );
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.routineIs( dstClass ), 'Expects constructor' );
    _.assert( dstClass === dstClass.prototype.constructor );
    _.assertMapHasOnly( this, [ _.KnownConstructorFields, { mixin : 'mixin', __mixin__ : '__mixin__' }, this.prototype.Statics || {} ] );

    _.mixinApply( md, dstClass.prototype );
    if( md.onMixinEnd )
    md.onMixinEnd( md, dstClass );
    return dstClass;
  }
  else
  o.mixin = function mixin( dstClass )
  {
    let md = this.__mixin__;

    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.routineIs( dstClass ), 'Expects constructor' );
    _.assert( dstClass === dstClass.prototype.constructor );
    _.assertMapHasOnly( this, [ _.KnownConstructorFields, { mixin : 'mixin', __mixin__ : '__mixin__' }, this.prototype.Statics || {} ] );

    if( o.onMixinEnd )
    debugger;
    md.onMixin( md, dstClass );
    if( md.onMixinEnd )
    md.onMixinEnd( md, dstClass );

    return dstClass;
  }

  /* */

  if( !o.prototype )
  {
    let got = _._classConstructorAndPrototypeGet( o );

    if( got.prototype )
    o.prototype = got.prototype;
    else
    o.prototype = Object.create( null );

    _.classExtend
    ({
      cls : got.cls || null,
      prototype : o.prototype,
      extend : o.extend || null,
      supplementOwn : o.supplementOwn || null,
      supplement : o.supplement || null,
    });

  }

  if( o.prototype )
  {
    _.assert( !o.prototype.mixin,'not tested' );
    o.prototype.mixin = o.mixin;
    if( o.prototype.constructor )
    {
      _.assert( !o.prototype.constructor.mixin || o.prototype.constructor.mixin === o.mixin,'not tested' );
      o.prototype.constructor.mixin = o.mixin;
    }
  }

  Object.freeze( o );

  return o;
}

_mixinDelcare.defaults =
{

  name : null,
  shortName : null,
  prototype : null,

  extend : null,
  supplementOwn : null,
  supplement : null,
  functors : null,

  onMixin : null,
  onMixinEnd : null,

}

//

function mixinDelcare( o )
{
  let result = Object.create( null );

  _.assert( o.mixin === undefined );

  let md = result.__mixin__ = _._mixinDelcare.apply( this, arguments );
  result.name = md.name;
  result.shortName = md.shortName;
  result.prototype = md.prototype;
  result.mixin = md.mixin;

  Object.freeze( result );

  return result;
}

mixinDelcare.defaults = Object.create( _mixinDelcare.defaults );

//

/**
 * Mixin methods and fields into prototype of another object.
 * @param {object} o - options.
 * @function mixinApply
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

let MixinDescriptorFields =
{

  name : null,
  shortName : null,
  prototype : null,

  extend : null,
  supplementOwn : null,
  supplement : null,
  functors : null,

  onMixin : null,
  onMixinEnd : null,
  mixin : null,

}

function mixinApply( mixinDescriptor, dstPrototype )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( dstPrototype ), () => 'second argument {-dstPrototype-} does not look like prototype, got ' + _.strType( dstPrototype ) );
  _.assert( _.routineIs( mixinDescriptor.mixin ), 'first argument does not look like mixin descriptor' );
  _.assert( _.objectIs( mixinDescriptor ) );
  _.assert( Object.isFrozen( mixinDescriptor ), 'first argument does not look like mixin descriptor' );
  _.assertMapHasOnly( mixinDescriptor, MixinDescriptorFields );

  /* mixin into routine */

  if( !_.mapIs( dstPrototype ) )
  {
    _.assert( dstPrototype.constructor.prototype === dstPrototype,'mixin :','Expects prototype with own constructor field' );
    _.assert( dstPrototype.constructor.name.length || dstPrototype.constructor._name.length,'mixin :','constructor should has name' );
    _.assert( _.routineIs( dstPrototype.init ) );
  }

  /* extend */

  _.assert( _.mapOwnKey( dstPrototype,'constructor' ) );
  _.assert( dstPrototype.constructor.prototype === dstPrototype );
  _.classExtend
  ({
    cls : dstPrototype.constructor,
    extend : mixinDescriptor.extend,
    supplementOwn : mixinDescriptor.supplementOwn,
    supplement : mixinDescriptor.supplement,
    functors : mixinDescriptor.functors,
  });

  /* mixins map */

  if( !_ObjectHasOwnProperty.call( dstPrototype,'_mixinsMap' ) )
  {
    dstPrototype._mixinsMap = Object.create( dstPrototype._mixinsMap || null );
  }

  _.assert( !dstPrototype._mixinsMap[ mixinDescriptor.name ],'attempt to mixin same mixin "' + mixinDescriptor.name + '" several times into ' + dstPrototype.constructor.name );

  dstPrototype._mixinsMap[ mixinDescriptor.name ] = 1;

}

//

function mixinHas( proto,mixin )
{
  if( _.constructorIs( proto ) )
  proto = _.prototypeGet( proto );

  _.assert( _.prototypeIsStandard( proto ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.strIs( mixin ) )
  {
    return proto._mixinsMap && proto._mixinsMap[ mixin ];
  }
  else
  {
    _.assert( _.routineIs( mixin.mixin ),'Expects mixin, but got not mixin',_.strType( mixin ) );
    _.assert( _.strDefined( mixin.name ),'Expects mixin, but got not mixin',_.strType( mixin ) );
    return proto._mixinsMap && proto._mixinsMap[ mixin.name ];
  }

}

// --
// class
// --

/**
* @typedef {object} wTools~prototypeOptions
* @property {routine} [o.cls=null] - constructor for which prototype is needed.
* @property {routine} [o.parent=null] - constructor of parent class.
* @property {object} [o.extend=null] - extend prototype by this map.
* @property {object} [o.supplement=null] - supplement prototype by this map.
* @property {object} [o.static=null] - static fields of a class.
* @property {boolean} [o.usingPrimitiveExtension=false] - extends class with primitive fields from relationship descriptors.
* @property {boolean} [o.usingOriginalPrototype=false] - makes prototype using original constructor prototype.
*/

/**
 * Make prototype for constructor repairing relationship : Composes, Aggregates, Associates, Medials, Restricts.
 * Execute optional extend / supplement if such o present.
 * @param {wTools~prototypeOptions} o - options {@link wTools~prototypeOptions}.
 * @returns {object} Returns constructor's prototype based on( o.parent ) prototype and complemented by fields, static and non-static methods.
 *
 * @example
 *  let Parent = function Alpha(){ };
 *  Parent.prototype.init = function(  )
 *  {
 *    let self = this;
 *    self.c = 5;
 *  };
 *
 *  let Self = function Betta( o )
 *  {
 *    return Self.prototype.init.apply( this,arguments );
 *  }
 *
 *  function init()
 *  {
 *    let self = this;
 *    Parent.prototype.init.call( this );
 *    _.mapExtendConditional( _.field.mapper.srcOwn,self,Composes );
 *  }
 *
 *  let Composes =
 *  {
 *   a : 1,
 *   b : 2,
 *  }
 *
 *  let Proto =
 *  {
 *   init,
 *   Composes
 *  }
 *
 *  _.classDeclare
 *  ({
 *    cls : Self,
 *    parent : Parent,
 *    extend : Proto,
 *  });
 *
 *  let betta = new Betta();
 *  console.log( proto === Self.prototype ); //returns true
 *  console.log( Parent.prototype.isPrototypeOf( betta ) ); //returns true
 *  console.log( betta.a, betta.b, betta.c ); //returns 1 2 5
 *
 * @function classDeclare
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o ) is not a Object.
 * @throws {exception} If( o.cls ) is not a Routine.
 * @throws {exception} If( o.cls.name ) is not defined.
 * @throws {exception} If( o.cls.prototype ) has not own constructor.
 * @throws {exception} If( o.cls.prototype ) has restricted properties.
 * @throws {exception} If( o.parent ) is not a Routine.
 * @throws {exception} If( o.extend ) is not a Object.
 * @throws {exception} If( o.supplement ) is not a Object.
 * @throws {exception} If( o.parent ) is equal to( o.extend ).
 * @throws {exception} If function cant rewrite constructor using original prototype.
 * @throws {exception} If( o.usingOriginalPrototype ) is false and ( o.cls.prototype ) has manually defined properties.
 * @throws {exception} If( o.cls.prototype.constructor ) is not equal( o.cls  ).
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

/*
_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});
*/

function classDeclare( o )
{
  let result;

  if( o.withClass === undefined )
  o.withClass = true;

  if( o.cls && !o.name )
  o.name = o.cls.name;

  if( o.cls && !o.shortName )
  o.shortName = o.cls.shortName;

  /* */

  let has = {}
  has.constructor = 'constructor';

  let hasNot =
  {
    Parent : 'Parent',
    Self : 'Self',
  }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.objectIs( o ) );
  _.assertOwnNoConstructor( o,'options for classDeclare should have no constructor' );
  _.assert( !( 'parent' in o ) || o.parent !== undefined,'parent is "undefined", something is wrong' );

  if( o.withClass )
  {

    _.assert( _.routineIs( o.cls ),'Expects {-o.cls-}' );
    _.assert( _.routineIs( o.cls ),'classDeclare expects constructor' );
    _.assert( _.strIs( o.cls.name ) || _.strIs( o.cls._name ),'constructor should have name' );
    _.assert( _ObjectHasOwnProperty.call( o.cls.prototype,'constructor' ) );
    _.assert( !o.name || o.cls.name === o.name || o.cls._name === o.name,'class has name',o.cls.name + ', but options',o.name );
    _.assert( !o.shortName || !o.cls.shortName|| o.cls.shortName === o.shortName,'class has short name',o.cls.shortName + ', but options',o.shortName );

    _.assertMapOwnAll( o.cls.prototype, has,'classDeclare expects constructor' );
    _.assertMapOwnNone( o.cls.prototype, hasNot );
    _.assertMapOwnNone( o.cls.prototype, _.DefaultForbiddenNames );

    if( o.extend && _ObjectHasOwnProperty.call( o.extend,'constructor' ) )
    _.assert( o.extend.constructor === o.cls );

  }
  else
  {
    _.assert( !o.cls );
  }

  _.assert( _.routineIs( o.parent ) || o.parent === undefined || o.parent === null, () => 'Wrong type of parent : ' + _.strType( 'o.parent' ) );
  _.assert( _.objectIs( o.extend ) || o.extend === undefined );
  _.assert( _.objectIs( o.supplement ) || o.supplement === undefined );
  _.assert( o.parent !== o.extend || o.extend === undefined );

  if( o.extend )
  {
    _.assert( o.extend.cls === undefined );
    _.assertOwnNoConstructor( o.extend );
  }
  if( o.supplementOwn )
  {
    _.assert( o.supplementOwn.cls === undefined );
    _.assertOwnNoConstructor( o.supplementOwn );
  }
  if( o.supplement )
  {
    _.assert( o.supplement.cls === undefined );
    _.assertOwnNoConstructor( o.supplement );
  }

  _.routineOptions( classDeclare,o );

  /* */

  let prototype;
  if( !o.parent )
  o.parent = null;

  /* make prototype */

  if( o.withClass )
  {

    if( o.usingOriginalPrototype )
    {

      prototype = o.cls.prototype;
      _.assert( o.parent === null || o.parent === Object.getPrototypeOf( o.cls.prototype ) );

    }
    else
    {
      if( o.cls.prototype )
      {
        _.assert( Object.keys( o.cls.prototype ).length === 0, 'misuse of classDeclare, prototype of constructor has properties which where put there manually',Object.keys( o.cls.prototype ) );
        _.assert( o.cls.prototype.constructor === o.cls );
      }
      if( o.parent )
      {
        prototype = o.cls.prototype = Object.create( o.parent.prototype );
      }
      else
      {
        prototype = o.cls.prototype = Object.create( null );
      }
    }

    /* constructor */

    prototype.constructor = o.cls;

    if( o.parent )
    {
      Object.setPrototypeOf( o.cls, o.parent );
    }

    /* extend */

    // if( prototype.constructor.name === 'BasicConstructor' )
    // debugger;

    _.classExtend
    ({
      cls : o.cls,
      extend : o.extend,
      supplementOwn : o.supplementOwn,
      supplement : o.supplement,
      usingPrimitiveExtension : o.usingPrimitiveExtension,
      usingStatics : 1,
      allowingExtendStatics : o.allowingExtendStatics,
    });

    /* statics */

    _.assert( _.routineIs( prototype.constructor ) );
    _.assert( _.objectIs( prototype.Statics ) );

    // _.assertMapHasAll( prototype, prototype.Statics );
    _.assertMapHasAll( prototype.constructor, prototype.Statics );

    // _.mapExtendConditional( _.field.mapper.dstNotOwnSrcOwn, prototype, prototype.Statics );
    // _.mapExtendConditional( _.field.mapper.dstNotOwnSrcOwn, prototype.constructor, prototype.Statics );

    _.assert( prototype === o.cls.prototype );
    _.assert( _ObjectHasOwnProperty.call( prototype,'constructor' ),'prototype should has own constructor' );
    _.assert( _.routineIs( prototype.constructor ),'prototype should has own constructor' );

    /* mixin tracking */

    if( !_ObjectHasOwnProperty.call( prototype,'_mixinsMap' ) )
    {
      prototype._mixinsMap = Object.create( prototype._mixinsMap || null );
    }

    _.assert( !prototype._mixinsMap[ o.cls.name ] );

    prototype._mixinsMap[ o.cls.name ] = 1;

    result = o.cls;

    /* handler */

    if( prototype.OnClassMakeEnd_meta )
    prototype.OnClassMakeEnd_meta.call( prototype, o );

    if( o.onClassMakeEnd )
    o.onClassMakeEnd.call( prototype, o );

  }

  /* */

  if( o.withMixin )
  {

    let mixinOptions = _.mapExtend( null,o );

    _.assert( !o.usingPrimitiveExtension );
    _.assert( !o.usingOriginalPrototype );
    _.assert( !o.parent );
    _.assert( !o.cls || o.withClass );

    delete mixinOptions.parent;
    delete mixinOptions.cls;
    delete mixinOptions.withMixin;
    delete mixinOptions.withClass;
    delete mixinOptions.usingPrimitiveExtension;
    delete mixinOptions.usingOriginalPrototype;
    delete mixinOptions.allowingExtendStatics;
    delete mixinOptions.onClassMakeEnd;

    if( mixinOptions.extend )
    mixinOptions.extend = _.mapExtend( null, mixinOptions.extend );
    if( mixinOptions.supplement )
    mixinOptions.supplement = _.mapExtend( null, mixinOptions.supplement );
    if( mixinOptions.supplementOwn )
    mixinOptions.supplementOwn = _.mapExtend( null, mixinOptions.supplementOwn );

    mixinOptions.prototype = prototype; /* xxx : remove? */

    _._mixinDelcare( mixinOptions );
    o.cls.__mixin__ = mixinOptions;
    o.cls.mixin = mixinOptions.mixin;

    _.assert( mixinOptions.extend === null || mixinOptions.extend.constructor === undefined );
    _.assert( mixinOptions.supplement === null || mixinOptions.supplement.constructor === undefined );
    _.assert( mixinOptions.supplementOwn === null || mixinOptions.supplementOwn.constructor === undefined );

  }

  /* */

  if( Config.debug )
  if( prototype )
  {
    let descriptor = Object.getOwnPropertyDescriptor( prototype,'constructor' );
    _.assert( descriptor.writable || descriptor.set );
    _.assert( descriptor.configurable );
  }

  return result;
}

classDeclare.defaults =
{
  cls : null,
  parent : null,

  onClassMakeEnd : null,
  onMixin : null,
  onMixinEnd : null,

  extend : null,
  supplementOwn : null,
  supplement : null,
  functors : null,

  name : null,
  shortName : null,

  usingPrimitiveExtension : false,
  usingOriginalPrototype : false,
  allowingExtendStatics : false,

  withMixin : false,
  withClass : true,

}

//

/**
 * Extends and supplements( o.cls ) prototype by fields and methods repairing relationship : Composes, Aggregates, Associates, Medials, Restricts.
 *
 * @param {wTools~prototypeOptions} o - options {@link wTools~prototypeOptions}.
 * @returns {object} Returns constructor's prototype complemented by fields, static and non-static methods.
 *
 * @example
 * let Self = function Betta( o ) { };
 * let Statics = { staticFunction : function staticFunction(){ } };
 * let Composes = { a : 1, b : 2 };
 * let Proto = { Composes, Statics };
 *
 * let proto =  _.classExtend
 * ({
 *     cls : Self,
 *     extend : Proto,
 * });
 * console.log( Self.prototype === proto ); //returns true
 *
 * @function classExtend
 * @throws {exception} If no argument provided.
 * @throws {exception} If( o ) is not a Object.
 * @throws {exception} If( o.cls ) is not a Routine.
 * @throws {exception} If( prototype.cls ) is not a Routine.
 * @throws {exception} If( o.cls.name ) is not defined.
 * @throws {exception} If( o.cls.prototype ) has not own constructor.
 * @throws {exception} If( o.parent ) is not a Routine.
 * @throws {exception} If( o.extend ) is not a Object.
 * @throws {exception} If( o.supplement ) is not a Object.
 * @throws {exception} If( o.static) is not a Object.
 * @throws {exception} If( o.cls.prototype.Constitutes ) is defined.
 * @throws {exception} If( o.cls.prototype ) is not equal( prototype ).
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function classExtend( o )
{

  if( arguments.length === 2 )
  o = { cls : arguments[ 0 ], extend : arguments[ 1 ] };

  if( !o.prototype )
  o.prototype = o.cls.prototype;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.objectIs( o ) );
  _.assert( !_ObjectHasOwnProperty.call( o,'constructor' ) );
  _.assertOwnNoConstructor( o );
  _.assert( _.objectIs( o.extend ) || o.extend === undefined || o.extend === null );
  _.assert( _.objectIs( o.supplementOwn ) || o.supplementOwn === undefined || o.supplementOwn === null );
  _.assert( _.objectIs( o.supplement ) || o.supplement === undefined || o.supplement === null );
  _.assert( _.routineIs( o.cls ) || _.objectIs( o.prototype ), 'Expects class constructor or class prototype' );

  /*
  mixin could could have none class constructor
  */

  if( o.cls /*|| !o.prototype*/ )
  {

    _.assert( _.routineIs( o.cls ), 'Expects constructor of class ( o.cls )' );
    _.assert( _.strIs( o.cls.name ) || _.strIs( o.cls._name ), 'class constructor should have name' );
    _.assert( !!o.prototype );
    // if( !o.prototype.Statics )
    // _.assertMapHasOnly( o.cls, [ _.KnownConstructorFields, o.prototype.Statics || {} ] ); /* xxx */

  }

  if( o.extend )
  {
    _.assert( o.extend.cls === undefined );
    _.assertOwnNoConstructor( o.extend );
  }
  if( o.supplementOwn )
  {
    _.assert( o.supplementOwn.cls === undefined );
    _.assertOwnNoConstructor( o.supplementOwn );
  }
  if( o.supplement )
  {
    _.assert( o.supplement.cls === undefined );
    _.assertOwnNoConstructor( o.supplement );
  }

  _.routineOptions( classExtend,o );

  _.assert( _.objectIs( o.prototype ) );

  /* fields groups */

  _.fieldsGroupsDeclareForEachFilter
  ({
    dstPrototype : o.prototype,
    extendMap : o.extend,
    supplementOwnMap : o.supplementOwn,
    supplementMap : o.supplement,
  });

  /* get constructor */

  if( !o.cls )
  o.cls = _._classConstructorAndPrototypeGet( o ).cls;

  /* */

  let staticsOwn = _.mapOwnProperties( o.prototype.Statics );
  let staticsAll = staticsAllGet();
  let fieldsGroups = _.fieldsGroupsGet( o.prototype );

  /* xxx : investigate */
  // if( _.mapKeys( staticsOwn ).length )
  // debugger;

/*

to prioritize ordinary facets adjustment order should be

- static extend
- ordinary extend
- ordinary supplement
- static supplement

*/

  /* static extend */

  if( o.extend && o.extend.Statics )
  declareStaticsForMixin( o.extend.Statics, _.mapExtend );

  /* ordinary extend */

  if( o.extend )
  fieldsDeclare( _.mapExtend, o.extend );

  /* ordinary supplementOwn */

  if( o.supplementOwn )
  fieldsDeclare( _.mapSupplementOwn, o.supplementOwn );

  /* ordinary supplement */

  if( o.supplement )
  fieldsDeclare( _.mapSupplement, o.supplement );

  /* static supplementOwn */

  if( o.supplementOwn && o.supplementOwn.Statics )
  declareStaticsForMixin( o.supplementOwn.Statics, _.mapSupplementOwn );

  /* static supplement */

  if( o.supplement && o.supplement.Statics )
  declareStaticsForMixin( o.supplement.Statics, _.mapSupplement );

  /* primitive extend */

  if( o.usingPrimitiveExtension )
  {
    debugger;
    for( let f in _.DefaultFieldsGroupsRelations )
    if( f !== 'Statics' )
    if( _.mapOwnKey( o.prototype,f ) )
    _.mapExtendConditional( _.field.mapper.srcOwnPrimitive, o.prototype, o.prototype[ f ] );
  }

  /* accessors */

  if( o.supplement )
  declareAccessors( o.supplement );
  if( o.supplementOwn )
  declareAccessors( o.supplementOwn );
  if( o.extend )
  declareAccessors( o.extend );

  /* statics */

  let fieldsOfRelationsGroups = _.fieldsOfRelationsGroupsFromPrototype( o.prototype );

  if( o.supplement && o.supplement.Statics )
  declareStaticsForClass( o.supplement.Statics, 0, 0 );
  if( o.supplementOwn && o.supplementOwn.Statics )
  declareStaticsForClass( o.supplementOwn.Statics, 0, 1 );
  if( o.extend && o.extend.Statics )
  declareStaticsForClass( o.extend.Statics, 1, 1 );

  /* functors */

  if( o.functors )
  for( let m in o.functors )
  {
    let func = o.functors[ m ].call( o,o.prototype[ m ] );
    _.assert( _.routineIs( func ),'not tested' );
    o.prototype[ m ] = func;
  }

  /* validation */

  /*
  mixin could could have none class constructor
  */

  if( o.cls )
  {
    _.assert( o.prototype === o.cls.prototype );
    _.assert( _ObjectHasOwnProperty.call( o.prototype,'constructor' ),'prototype should has own constructor' );
    _.assert( _.routineIs( o.prototype.constructor ),'prototype should has own constructor' );
    _.assert( o.cls === o.prototype.constructor );
    //_.assertMapHasOnly( o.cls, [ _.KnownConstructorFields, o.prototype.Statics ] );

  }

  _.assert( _.objectIs( o.prototype.Statics ) );

  return o.prototype;

  /* */

  function fieldsDeclare( extend, src )
  {
    let map = _.mapBut( src, fieldsGroups );

    for( let s in staticsAll )
    if( map[ s ] === staticsAll[ s ] )
    delete map[ s ];

    extend( o.prototype, map );

    if( Config.debug )
    if( !o.allowingExtendStatics )
    if( Object.getPrototypeOf( o.prototype.Statics ) )
    {
      map = _.mapBut( map, staticsOwn );

      let keys = _.mapKeys( _.mapOnly( map, Object.getPrototypeOf( o.prototype.Statics ) ) );
      if( keys.length )
      {
        _.assert( 0,'attempt to extend static field', keys );
      }
    }
  }

  /* */

  function declareStaticsForMixin( statics, extend )
  {

    if( !o.usingStatics )
    return;

    extend( staticsAll, statics );

    /* is pure mixin */
    if( o.prototype.constructor )
    return;

    if( o.usingStatics && statics )
    {
      extend( o.prototype, statics );
      if( o.cls )
      extend( o.cls, statics );
    }

  }

  /* */

  function staticsAllGet()
  {
    let staticsAll = _.mapExtend( null, o.prototype.Statics );
    if( o.supplement && o.supplement.Statics )
    _.mapSupplement( staticsAll, o.supplement.Statics );
    if( o.supplementOwn && o.supplementOwn.Statics )
    _.mapSupplementOwn( staticsAll, o.supplementOwn.Statics );
    if( o.extend && o.extend.Statics )
    _.mapExtend( staticsAll, o.extend.Statics );
    return staticsAll;
  }

  /* */

  function declareStaticsForClass( statics, extending, dstNotOwn )
  {

    /* is class */
    if( !o.prototype.constructor )
    return;
    if( !o.usingStatics )
    return;

    for( let s in statics )
    {

      if( !_ObjectHasOwnProperty.call( o.prototype.Statics, s ) )
      continue;

      _.staticDeclare
      ({
        name : s,
        value : o.prototype.Statics[ s ],
        prototype : o.prototype,
        extending,
        dstNotOwn,
        fieldsOfRelationsGroups,
      });

    }

  }

  /* */

  function declareAccessors( src )
  {
    // if( o.prototype.constructor && o.prototype.constructor.shortName === 'Module' )
    // debugger;

    for( let d in _.accessor.DefaultAccessorsMap )
    if( src[ d ] )
    {
      _.accessor.DefaultAccessorsMap[ d ]( o.prototype, src[ d ] );
    }
  }

}

classExtend.defaults =
{
  cls : null,
  prototype : null,

  extend : null,
  supplementOwn : null,
  supplement : null,
  functors : null,

  usingStatics : true,
  usingPrimitiveExtension : false,
  allowingExtendStatics : false,
}

//

function staticDeclare( o )
{

  if( !( 'value' in o ) )
  o.value = o.prototype.Statics[ o.name ];

  if( _.definitionIs( o.value ) )
  _.mapExtend( o, o.value.valueGet() );

  _.routineOptions( staticDeclare, arguments );
  _.assert( _.strIs( o.name ) );
  _.assert( arguments.length === 1 );

  if( !o.fieldsOfRelationsGroups )
  o.fieldsOfRelationsGroups = _.fieldsOfRelationsGroupsFromPrototype( o.prototype );

  let pd = _.propertyDescriptorGet( o.prototype, o.name );
  let cd = _.propertyDescriptorGet( o.prototype.constructor, o.name );

  if( pd.object !== o.prototype )
  pd.descriptor = null;

  if( cd.object !== o.prototype.constructor )
  cd.descriptor = null;

  if( o.name === 'constructor' )
  return;

  let symbol = Symbol.for( o.name );
  let aname = _.accessor._propertyGetterSetterNames( o.name );
  let methods = Object.create( null );

  /* */

  let prototype = o.prototype;
  if( !o.readOnly )
  methods[ aname.set ] = function set( src )
  {
    /*
      should assign fields to the original class / prototype
      not descendant
    */
    prototype[ symbol ] = src;
    prototype.constructor[ symbol] = src;
  }
  methods[ aname.get ] = function get()
  {
    return this[ symbol ];
  }

  /* */

  if( o.fieldsOfRelationsGroups[ o.name ] === undefined )
  if( !pd.descriptor || ( o.extending && pd.descriptor.value === undefined ) )
  {

    if( cd.descriptor )
    {
      o.prototype[ o.name ] = o.value;
    }
    else
    {
      o.prototype[ symbol ] = o.value;

      _.accessor.declare
      ({
        object : o.prototype,
        methods,
        names : o.name,
        combining : 'rewrite',
        configurable : true,
        enumerable : false,
        strict : false,
        readOnly : o.readOnly,
      });

    }
  }

  /* */

  if( !cd.descriptor || ( o.extending && cd.descriptor.value === undefined ) )
  {
    if( pd.descriptor )
    {
      o.prototype.constructor[ o.name ] = o.value;
    }
    else
    {
      o.prototype.constructor[ symbol ] = o.value;

      _.accessor.declare
      ({
        object : o.prototype.constructor,
        methods,
        names : o.name,
        combining : 'rewrite',
        enumerable : true,
        configurable : true,
        prime : false,
        strict : false,
        readOnly : o.readOnly,
      });

    }

  }

  /* */

  return true;
}

var defaults = staticDeclare.defaults = Object.create( null );

defaults.name = null;
defaults.value = null;
defaults.prototype = null;
defaults.fieldsOfRelationsGroups = null;
defaults.extending = 0; /**/
defaults.dstNotOwn = 0; /* !!! not used */
defaults.readOnly = 0;

//

function constructorGet( src )
{
  let proto;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _ObjectHasOwnProperty.call( src,'constructor' ) )
  {
    proto = src; /* proto */
  }
  else if( _ObjectHasOwnProperty.call( src,'prototype' )  )
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

function subclassOf( subCls, cls )
{

  _.assert( _.routineIs( cls ) );
  _.assert( _.routineIs( subCls ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( cls === subCls )
  return true;

  return Object.isPrototypeOf.call( cls.prototype, subCls.prototype );
}

//

function subPrototypeOf( sub, parent )
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
 * @function parentGet
 * @memberof wCopyable#
 */

function parentGet( src )
{
  let c = constructorGet( src );

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

function prototypeGet( src )
{

  if( !( 'constructor' in src ) )
  return null;

  let c = constructorGet( src );

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
      throw _.err( 'prototypeUnitedInterface :','several objects try to unite have same field :',f );
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
 * Does srcProto has insProto as prototype.
 * @param {object} srcProto - proto stack to investigate.
 * @param {object} insProto - proto to look for.
 * @function prototypeHasPrototype
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function prototypeHasPrototype( srcProto,insProto )
{

  do
  {
    if( srcProto === insProto )
    return true;
    srcProto = Object.getPrototypeOf( srcProto );
  }
  while( srcProto !== Object.prototype );

  return false;
}

//

/**
 * Return proto owning names.
 * @param {object} srcPrototype - src object to investigate proto stack.
 * @function prototypeHasProperty
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function prototypeHasProperty( srcPrototype,names )
{
  names = _nameFielded( names );
  _.assert( _.objectIs( srcPrototype ) );

  do
  {
    let has = true;
    for( let n in names )
    if( !_ObjectHasOwnProperty.call( srcPrototype,n ) )
    {
      has = false;
      break;
    }
    if( has )
    return srcPrototype;

    srcPrototype = Object.getPrototypeOf( srcPrototype );
  }
  while( srcPrototype !== Object.prototype && srcPrototype );

  return null;
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
  let prototype = _.prototypeGet( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ),'Expects standard prototype' );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( fieldName ) );

  for( let f in _.DefaultFieldsGroupsRelations )
  if( prototype[ f ][ fieldName ] !== undefined )
  return true;

  return false;
}

//

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
    association.entities = _.mapExtend( null,o.entities );
  }
  else
  {
    _.assert( _.arraySetIdentical( _.mapKeys( association.entities ), _.mapKeys( o.entities ) ),'cross reference should have same associations' );
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
      _.assert( !dstEntity[ src ] || dstEntity[ src ] === srcEntity, 'override of entity',src );
      _.assert( !dstEntity.prototype[ src ] || dstEntity.prototype[ src ] === srcEntity );
      _.classExtend( dstEntity,{ Statics : { [ src ] : srcEntity } } );
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

// _.prototypeCrossRefer
// ({
//   namespace : _,
//   entities :
//   {
//     System : Self,
//   },
//   names :
//   {
//     System : 'LiveSystem',
//     Node : 'LiveNode',
//   },
// });

//

/**
 * Iterate through prototypes.
 * @param {object} proto - prototype
 * @function prototypeEach
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function prototypeEach( proto,onEach )
{
  let result = [];

  _.assert( _.routineIs( onEach ) || !onEach );
  _.assert( _.prototypeIs( proto ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  do
  {

    if( onEach )
    onEach.call( this,proto );

    result.push( proto );

    let parent = _.parentGet( proto );

    proto = parent ? parent.prototype : null;

    if( proto && proto.constructor === Object )
    proto = null;

  }
  while( proto );

  return result;
}

// --
// instance
// --

/*
  usage : return _.instanceConstructor( Self, this, arguments );
  replacement for :

  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.constructorJoin( Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );

*/

function instanceConstructor( cls, context, args )
{

  _.assert( args.length === 0 || args.length === 1 );
  _.assert( arguments.length === 3 );
  _.routineIs( cls );
  _.arrayLike( args );

  let o = args[ 0 ];

  if( !( context instanceof cls ) )
  if( o instanceof cls )
  {
    _.assert( args.length === 1 );
    return o;
  }
  else
  {
    if( args.length === 1 && _.arrayLike( args[ 0 ] ) )
    {
      let result = [];
      for( let i = 0 ; i < args[ 0 ].length ; i++ )
      {
        let o = args[ 0 ][ i ];
        if( o === null )
        continue;
        if( o instanceof cls )
        result.push( o );
        else
        result.push( new( _.constructorJoin( cls, [ o ] ) ) );
      }
      return result;
    }
    else
    {
      return new( _.constructorJoin( cls, args ) );
    }
  }

  return cls.prototype.init.apply( context, args );
}

//

/**
 * Is this instance finited.
 * @function instanceIsFinited
 * @param {object} src - instance of any class
 * @memberof wCopyable#
 */

function instanceIsFinited( src )
{
  _.assert( _.instanceIs( src ), () => 'Expects instance, but got ' + _.toStrShort( src ) )
  _.assert( _.objectLikeOrRoutine( src ) );
  return Object.isFrozen( src );
}

//

function instanceFinit( src )
{

  _.assert( !Object.isFrozen( src ) );
  _.assert( _.objectLikeOrRoutine( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  // let validator =
  // {
  //   set : function( obj, k, e )
  //   {
  //     debugger;
  //     throw _.err( 'Attempt ot access to finited instance with field',k );
  //     return false;
  //   },
  //   get : function( obj, k, e )
  //   {
  //     debugger;
  //     throw _.err( 'Attempt ot access to finited instance with field',k );
  //     return false;
  //   },
  // }
  // let result = new Proxy( src, validator );

  Object.freeze( src );

}

//

/**
 * Complements instance by its semantic relations : Composes, Aggregates, Associates, Medials, Restricts.
 * @param {object} instance - instance to complement.
 *
 * @example
 * let Self = function Alpha( o ) { };
 *
 * let Proto = { constructor: Self, Composes : { a : 1, b : 2 } };
 *
 * _.classDeclare
 * ({
 *     constructor: Self,
 *     extend: Proto,
 * });
 * let obj = new Self();
 * console.log( _.instanceInit( obj ) ); //returns Alpha { a: 1, b: 2 }
 *
 * @return {object} Returns complemented instance.
 * @function instanceInit
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function instanceInit( instance,prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined )
  prototype = instance;

  // _.mapComplement( instance, prototype.Restricts );
  // _.mapComplement( instance, prototype.Composes );
  // _.mapComplement( instance, prototype.Aggregates );

  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Restricts );
  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Composes );
  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Aggregates );
  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Associates );

  // _.mapSupplementOwn( instance, prototype.Associates );
  // _.mapSupplementOwnAssigning( instance, prototype.Associates );

  return instance;
}

//

function instanceInitExtending( instance,prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined )
  prototype = instance;

  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Restricts );
  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Composes );
  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Aggregates );
  _.mapExtend( instance,prototype.Associates );

  return instance;
}

//

function instanceFilterInit( o )
{

  _.routineOptions( instanceFilterInit,o );

  // let self = _.instanceFilterInit
  // ({
  //   cls : Self,
  //   parent : Parent,
  //   extend : Extend,
  // });

  _.assertOwnNoConstructor( o );
  _.assert( _.routineIs( o.cls ) );
  _.assert( !o.args || o.args.length === 0 || o.args.length === 1 );

  let result = Object.create( null );

  _.instanceInit( result,o.cls.prototype );

  if( o.args[ 0 ] )
  _.Copyable.prototype.copyCustom.call( o.cls.prototype,
  {
    proto : o.cls.prototype,
    src : o.args[ 0 ],
    dst : result,
    technique : 'object',
  });

  if( !result.original )
  result.original = _.FileProvider.Default();

  _.mapExtend( result,o.extend );

  Object.setPrototypeOf( result,result.original );

  if( o.strict )
  Object.preventExtensions( result );

  return result;
}

instanceFilterInit.defaults =
{
  cls : null,
  parent : null,
  extend : null,
  args : null,
  strict : 1,
}

//

/**
 * Make sure src does not have redundant fields.
 * @param {object} src - source object of the class.
 * @function assertInstanceDoesNotHaveReduntantFields
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function assertInstanceDoesNotHaveReduntantFields( src )
{

  let Composes = src.Composes || Object.create( null );
  let Aggregates = src.Aggregates || Object.create( null );
  let Associates = src.Associates || Object.create( null );
  let Restricts = src.Restricts || Object.create( null );

  _.assert( _.ojbectIs( src ) )
  _.assertMapOwnOnly( src, [ Composes, Aggregates, Associates, Restricts ] );

  return dst;
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
  // _.assert( def === _.def );

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
      _.mapSupplement( src[ s ],defVal );
    }

  }
  else
  {

    for( let s = 0 ; s < src.length ; s++ )
    {
      if( !_.objectIs( src[ s ] ) )
      continue;
      _.mapSupplement( src[ s ],defVal );
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
//
// --

/**
* @classdesc Class container for creating property-like entity from non-primitive value.
  Is used by routines:
  @see {@link module:Tools/base/Proto.wTools.define.own}
  @see {@link module:Tools/base/Proto.wTools.define.common}
  @see {@link module:Tools/base/Proto.wTools.define.instanceOf}
  @see {@link module:Tools/base/Proto.wTools.define.ownMadeBy}
  @see {@link module:Tools/base/Proto.wTools.define.contained}
* @class Definition
* @memberof module:Tools/base/Proto.wTools.define
*/

function Definition( o )
{
  _.assert( arguments.length === 1 );
  if( !( this instanceof Definition ) )
  if( o instanceof Definition )
  return o;
  else
  return new( _.constructorJoin( Definition, arguments ) );
  _.mapExtend( this, o );
  return this;
}

//

/**
* Creates property-like entity with getter that returns reference to source object.
* @param {Object-like|Long} src - source value
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function common
* @memberof module:Tools/base/Proto.wTools.define
*/

function common( src )
{
  let definition = new Definition({ value : src });

  _.assert( src !== undefined, () => 'Expects object-like or long, but got ' + _.strType( src ) );
  _.assert( arguments.length === 1 );

  definition.valueGet = function get() { return this.value }

  _.accessor.hide( definition, 'valueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns shallow copy of source object.
* @param {Object-like|Long} src - source value
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function own
* @memberof module:Tools/base/Proto.wTools.define
*/

function own( src )
{
  let definition = new Definition({ value : src });

  _.assert( src !== undefined, () => 'Expects object-like or long, but got ' + _.strType( src ) );
  _.assert( arguments.length === 1 );

  // definition.valueGet = function get() { return _.entityShallowClone( this.value ) }
  definition.valueGet = function get() { return _.cloneJust( this.value ) }

  _.accessor.hide( definition, 'valueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns new instance of source constructor.
* @param {Function} src - source constructor
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function instanceOf
* @memberof module:Tools/base/Proto.wTools.define
*/

function instanceOf( src )
{
  let definition = new Definition({ value : src });

  _.assert( _.routineIs( src ), 'Expects constructor' );
  _.assert( arguments.length === 1 );

  definition.valueGet = function get() { return new this.value() }

  _.accessor.hide( definition, 'valueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* Creates property-like entity with getter that returns result of source routine call.
* @param {Function} src - source routine
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function ownMadeBy
* @memberof module:Tools/base/Proto.wTools.define
*/

function ownMadeBy( src )
{
  let definition = new Definition({ value : src });

  _.assert( _.routineIs( src ), 'Expects constructor' );
  _.assert( arguments.length === 1 );

  definition.valueGet = function get() { return this.value() }

  _.accessor.hide( definition, 'valueGet' );

  Object.freeze( definition );
  return definition;
}

//

/**
* @param {Object} src
* @returns {module:Tools/base/Proto.wTools.define.Definition}
* @function contained
* @memberof module:Tools/base/Proto.wTools.define
*/

function contained( src )
{

  _.assert( _.mapIs( src ) );
  _.assert( arguments.length === 1 );

  let container = _.mapBut( src, contained.defaults );
  let o = _.mapOnly( src, contained.defaults );
  o.container = container;
  o.value = container.value;
  let definition = new Definition( o );

  if( o.shallowCloning )
  definition.valueGet = function get()
  {
    let result = this.container;
    result.value = _.entityShallowClone( definition.value );
    return result;
  }
  else
  definition.valueGet = function get()
  {
    let result = this.container;
    result.value = definition.value;
    return result;
  }

  _.accessor.hide( definition, 'valueGet' );
  Object.freeze( definition );
  return definition;
}

contained.defaults =
{
  shallowCloning : 0,
}

// --
// type
// --

class wCallableObject extends Function
{
  constructor()
  {
    super( 'return this.self.__call__.apply( this.self, arguments );' );

    let context = Object.create( null );
    let self = this.bind( context );
    context.self = self;
    Object.freeze( context );

    return self;
  }
}

wCallableObject.shortName = 'CallableObject';

// --
// fields
// --

// let Combining = [ 'rewrite','supplement','apppend','prepend' ];

/**
 * @typedef {Object} KnownConstructorFields - contains fields allowed for class constructor.
 * @property {String} name - full name
 * @property {String} _name - private name
 * @property {String} shortName - short name
 * @property {Object} prototype - prototype object
 * @memberof module:Tools/base/Proto
 */

let KnownConstructorFields =
{
  name : null,
  _name : null,
  shortName : null,
  prototype : null,
}

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

/**
* Collection of routines to create a property-like entity.
* @namespace "wTools.define"
* @augments wTools
* @memberof module:Tools/base/Proto
*/

let Define =
{
  Definition,
  common,
  own,
  instanceOf,
  ownMadeBy,
  contained,
}

//

let Fields =
{

  KnownConstructorFields,

  DefaultFieldsGroups,
  DefaultFieldsGroupsRelations,
  DefaultFieldsGroupsCopyable,
  DefaultFieldsGroupsTight,
  DefaultFieldsGroupsInput,

  DefaultForbiddenNames,
  CallableObject : wCallableObject,

}

//

let Routines =
{

  // fields group

  fieldsGroupsGet,
  fieldsGroupFor, /* experimental */
  fieldsGroupDeclare, /* experimental */

  fieldsGroupComposesExtend, /* experimental */
  fieldsGroupAggregatesExtend, /* experimental */
  fieldsGroupAssociatesExtend, /* experimental */
  fieldsGroupRestrictsExtend, /* experimental */

  fieldsGroupComposesSupplement, /* experimental */
  fieldsGroupAggregatesSupplement, /* experimental */
  fieldsGroupAssociatesSupplement, /* experimental */
  fieldsGroupRestrictsSupplement, /* experimental */

  fieldsOfRelationsGroupsFromPrototype,
  fieldsOfCopyableGroupsFromPrototype,
  fieldsOfTightGroupsFromPrototype,
  fieldsOfInputGroupsFromPrototype,

  fieldsOfRelationsGroups,
  fieldsOfCopyableGroups,
  fieldsOfTightGroups,
  fieldsOfInputGroups,

  fieldsGroupsDeclare,
  fieldsGroupsDeclareForEachFilter,

  // property

  propertyDescriptorActiveGet,
  propertyDescriptorGet,

  // _propertyGetterSetterNames,
  // _propertyGetterSetterMake,
  // _propertyGetterSetterGet,
  // _propertyCopyGet,

  // proxy

  proxyNoUndefined,
  proxyReadOnly,
  ifDebugProxyReadOnly,
  proxyMap,

  // mixin

  _mixinDelcare,
  mixinDelcare,
  mixinApply,
  mixinHas,

  // class

  classDeclare,
  classExtend,

  staticDeclare,

  constructorGet,

  subclassOf,
  subPrototypeOf,

  parentGet,
  _classConstructorAndPrototypeGet,

  // prototype

  prototypeGet,

  prototypeUnitedInterface, /* experimental */

  prototypeAppend, /* experimental */
  prototypeHasPrototype, /* experimental */
  prototypeHasProperty, /* experimental */
  prototypeArchyGet, /* experimental */
  prototypeHasField,

  prototypeCrossRefer, /* experimental */
  prototypeEach, /* experimental */

  // instance

  instanceConstructor,

  instanceIsFinited,
  instanceFinit,

  instanceInit,
  instanceInitExtending,
  instanceFilterInit, /* deprecated */

  assertInstanceDoesNotHaveReduntantFields,

  // default

  defaultApply,
  defaultProxy,
  defaultProxyFlatteningToArray,

}

//

_.define = Define;
_.mapExtend( _, Routines );
_.mapExtend( _, Fields );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

// --
// import
// --

if( typeof module !== 'undefined' )
{

  require( './ProtoAccessor.s' );
  require( './ProtoLike.s' );

}

})();
