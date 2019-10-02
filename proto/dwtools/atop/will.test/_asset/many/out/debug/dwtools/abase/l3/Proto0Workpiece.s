( function _Proto0Workpiece_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );
}

/*
qqq : repair and improve doc
*/

let Self = _global_.wTools.workpiece = _global_.wTools.workpiece || Object.create( null );;
let _global = _global_;
let _ = _global_.wTools;

let _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ObjectPropertyIsEumerable = Object.propertyIsEnumerable;

_.assert( _.objectIs( _.field ), 'wProto needs Tools/dwtools/abase/l1/FieldMapper.s' );

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
 * _.workpiece.fieldsGroupDeclare
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

  _.routineOptions( fieldsGroupDeclare, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.srcMap === null || !_.primitiveIs( o.srcMap ), 'Expects object {-o.srcMap-}, got', _.strType( o.srcMap ) );
  _.assert( _.strIs( o.fieldsGroupName ) );
  _.assert( _.routineIs( o.filter ) && _.strIs( o.filter.functionFamily ) );

  _.workpiece.fieldsGroupFor( o.dstPrototype, o.fieldsGroupName );

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
 * _.workpiece.fieldsGroupComposesExtend( Self.prototype, Composes );
 * console.log( Self.prototype ); // returns { Composes: { tree: null } }
 *
 * @function _.workpiece.fieldsGroupComposesExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupComposesExtend( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Composes';
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupAggregatesExtend( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @function fieldsGroupAggregatesExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAggregatesExtend( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Aggregates';
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupAssociatesExtend( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @function fieldsGroupAssociatesExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAssociatesExtend( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Associates';
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupRestrictsExtend( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @function _.workpiece.fieldsGroupRestrictsExtend
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupRestrictsExtend( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Restricts';
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupComposesSupplement( Self.prototype, Composes );
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
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupAggregatesSupplement( Self.prototype, Aggregates );
 * console.log( Self.prototype ); // returns { Aggregates: { tree: null } }
 *
 * @function _.workpiece.fieldsGroupAggregatesSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAggregatesSupplement( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Aggregates';
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupAssociatesSupplement( Self.prototype, Associates );
 * console.log( Self.prototype ); // returns { Associates: { tree: null } }
 *
 * @function fieldsGroupAssociatesSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupAssociatesSupplement( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Associates';
  return _.workpiece.fieldsGroupDeclare
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
 * _.workpiece.fieldsGroupRestrictsSupplement( Self.prototype, Restricts );
 * console.log( Self.prototype ); // returns { Restricts: { tree: null } }
 *
 * @function fieldsGroupRestrictsSupplement
 * @throws {exception} If no arguments provided.
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function fieldsGroupRestrictsSupplement( dstPrototype, srcMap )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let fieldsGroupName = 'Restricts';
  return _.workpiece.fieldsGroupDeclare
  ({
    fieldsGroupName,
    dstPrototype,
    srcMap,
    filter : _.field.mapper.dstNotHas,
  });

}

//

function fieldsOfRelationsGroupsFromPrototype( src )
{
  let prototype = src;
  let result = Object.create( null );

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
  prototype = _.prototypeOf( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ), 'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  {
    return _.mapOnly( src, _.workpiece.fieldsOfRelationsGroupsFromPrototype( prototype ) );
  }

  return _.workpiece.fieldsOfRelationsGroupsFromPrototype( prototype );
}

//

function fieldsOfCopyableGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeOf( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ), 'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  return _.mapOnly( src, _.workpiece.fieldsOfCopyableGroupsFromPrototype( prototype ) );

  return _.workpiece.fieldsOfCopyableGroupsFromPrototype( prototype );
}

//

function fieldsOfTightGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeOf( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ), 'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  return _.mapOnly( src, _.workpiece.fieldsOfTightGroupsFromPrototype( prototype ) );

  return _.workpiece.fieldsOfTightGroupsFromPrototype( prototype );
}

//

function fieldsOfInputGroups( src )
{
  let prototype = src;

  if( !_.prototypeIs( prototype ) )
  prototype = _.prototypeOf( src );

  _.assert( _.prototypeIs( prototype ) );
  _.assert( _.prototypeIsStandard( prototype ), 'Expects standard prototype' );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.instanceIs( src ) )
  return _.mapOnly( src, _.workpiece.fieldsOfInputGroupsFromPrototype( prototype ) );

  return _.workpiece.fieldsOfInputGroupsFromPrototype( prototype );
}

//

function fieldsGroupsDeclare( o )
{

  _.routineOptions( fieldsGroupsDeclare, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.srcMap === null || !_.primitiveIs( o.srcMap ), 'Expects object {-o.srcMap-}, got', _.strType( o.srcMap ) );

  if( !o.srcMap )
  return;

  if( !o.fieldsGroups )
  o.fieldsGroups = _.workpiece.fieldsGroupsGet( o.dstPrototype );

  _.assert( _.isSubPrototypeOf( o.fieldsGroups, _.DefaultFieldsGroups ) );

  for( let f in o.fieldsGroups )
  {

    if( !o.srcMap[ f ] )
    continue;

    _.workpiece.fieldsGroupDeclare
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
        _.assert( o.dstPrototype[ f2 ][ k ] === undefined, 'Fields group', '"'+f2+'"', 'already has fields', '"'+k+'"', 'fields group', '"'+f+'"', 'should not have the same' );
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

  let oldFieldsGroups = _.workpiece.fieldsGroupsGet( o.dstPrototype );
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

  if( !o.dstPrototype.Groups )
  o.dstPrototype.Groups = Object.create( _.DefaultFieldsGroups );

  for( let f in newFieldsGroups )
  _.workpiece.fieldsGroupFor( o.dstPrototype, f );

  _.workpiece.fieldsGroupsDeclare
  ({
    dstPrototype : o.dstPrototype,
    srcMap : o.extendMap,
    fieldsGroups : newFieldsGroups,
    filter : _.field.mapper.bypass,
  });

  _.workpiece.fieldsGroupsDeclare
  ({
    dstPrototype : o.dstPrototype,
    srcMap : o.supplementOwnMap,
    fieldsGroups : newFieldsGroups,
    filter : _.field.mapper.dstNotOwn,
  });

  _.workpiece.fieldsGroupsDeclare
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
// instance
// --

/*
  usage : return _.workpiece.construct( Self, this, arguments );
  replacement for :

  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.constructorJoin( Self, arguments ) );
  return Self.prototype.init.apply( this, arguments );

*/

function construct( cls, context, args )
{

  _.assert( args.length === 0 || args.length === 1 );
  _.assert( arguments.length === 3 );
  _.assert( _.routineIs( cls ) );
  _.assert( _.arrayLike( args ) );

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
 * @function isFinited
 * @param {object} src - instance of any class
 * @memberof wCopyable#
 */

function isFinited( src )
{
  _.assert( _.instanceIs( src ), () => 'Expects instance, but got ' + _.toStrShort( src ) )
  _.assert( _.objectLikeOrRoutine( src ) );
  return Object.isFrozen( src );
}

//

function finit( src )
{

  _.assert( !Object.isFrozen( src ), `Seems instance ${_.workpiece.qualifiedNameTry( src )} is already finited` );
  _.assert( _.objectLikeOrRoutine( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  // let validator =
  // {
  //   set : function( obj, k, e )
  //   {
  //     debugger;
  //     throw _.err( 'Attempt ot access to finited instance with field', k );
  //     return false;
  //   },
  //   get : function( obj, k, e )
  //   {
  //     debugger;
  //     throw _.err( 'Attempt ot access to finited instance with field', k );
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
 * console.log( _.workpiece.initFields( obj ) ); //returns Alpha { a: 1, b: 2 }
 *
 * @return {object} Returns complemented instance.
 * @function initFields
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function initFields( instance, prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined || prototype === null )
  prototype = instance;

  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Restricts );
  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Composes );
  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Aggregates );
  _.mapSupplementOwnFromDefinitionStrictlyPrimitives( instance, prototype.Associates );

  return instance;
}

//

function initWithArguments( o )
{

  o = _.routineOptions( initWithArguments, arguments );
  _.assert( arguments.length === 1 );
  _.assert( o.args.length === 0 || o.args.length === 1 );
  _.workpiece.initFields( o.instance );

  Object.preventExtensions( o.instance, o.prototype );

  if( o.args[ 0 ] )
  o.instance.copy( o.args[ 0 ] );

  return o.instance;
}

initWithArguments.defaults =
{
  instance : null,
  prototype : null,
  args : null,
}

//

function initExtending( instance, prototype )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( prototype === undefined )
  prototype = instance;

  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Restricts );
  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Composes );
  _.mapExtendConditional( _.field.mapper.assigning, instance, prototype.Aggregates );
  _.mapExtend( instance, prototype.Associates );

  return instance;
}

//

function initFilter( o )
{

  _.routineOptions( initFilter, o );
  _.assertOwnNoConstructor( o );
  _.assert( _.routineIs( o.cls ) );
  _.assert( !o.args || o.args.length === 0 || o.args.length === 1 );

  let result = Object.create( null );

  _.workpiece.initFields( result, o.cls.prototype );

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

  _.mapExtend( result, o.extend );

  Object.setPrototypeOf( result, result.original );

  if( o.strict )
  Object.preventExtensions( result );

  return result;
}

initFilter.defaults =
{
  cls : null,
  parent : null,
  extend : null,
  args : null,
  strict : 1,
}

//

function singleFrom( src, cls )
{
  cls = _.constructorOf( cls );

  _.assert( arguments.length === 2 );

  if( src instanceof cls )
  return src;
  return new( _.constructorJoin( cls, arguments ) );
}

//

function from( srcs, cls )
{
  cls = _.constructorOf( cls );

  _.assert( arguments.length === 2 );

  if( srcs instanceof cls )
  {
    return srcs;
  }

  if( _.arrayLike( srcs ) )
  {
    debugger;
    var result = _.map( srcs, ( src ) =>
    {
      return _.workpiece.singleFrom( src );
    });
    return result;
  }

  return _.workpiece.singleFrom.call( srcs, cls );
}

//

function lowClassName( instance )
{
  _.assert( _.instanceIs( instance ) );
  _.assert( arguments.length === 1 );
  let name = _.workpiece.className( instance );
  name = _.strDecapitalize( name );
  return name;
}

//

function className( instance )
{
  _.assert( _.instanceIs( instance ) );
  _.assert( arguments.length === 1 );
  let cls = _.constructorOf( instance );
  _.assert( cls === null || _.strIs( cls.name ) || _.strIs( cls._name ) );
  return cls ? ( cls.name || cls._name ) : '';
}

//

function qualifiedNameTry( instance )
{
  try
  {
    let result = _.workpiece.qualifiedName( instance );
    return result;
  }
  catch( err )
  {
    return '';
  }
}

//

function qualifiedName( instance )
{
  _.assert( _.instanceIs( instance ) );
  _.assert( arguments.length === 1 );

  let name = ( instance.key || instance.name || '' );
  let index = '';
  if( _.numberIs( instance.instanceIndex ) )
  name += '#in' + instance.instanceIndex;
  if( Object.hasOwnProperty.call( instance, 'id' ) )
  name += '#id' + instance.id;

  let result = _.workpiece.className( instance ) + '::' + name;

  return result;
}

//

function uname( instance )
{
  _.assert( _.instanceIs( instance ) );
  _.assert( arguments.length === 1 );
  let name = _.workpiece.className( instance );
  return '#id' + self.id + '::' + name;
}

//

function toStr( instance, options )
{
  var result = '';
  var o = o || Object.create( null );

  _.assert( _.instanceIs( instance ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( !o.jsLike && !o.jsonLike )
  result += _.workpiece.qualifiedName( instance ) + '\n';

  var fields = _.workpiece.fieldsOfTightGroups( instance );

  var t = _.toStr( fields, o );
  _.assert( _.strIs( t ) );
  result += t;

  return result;
}

//

/**
 * Make sure src does not have redundant fields.
 * @param {object} src - source object of the class.
 * @function assertDoesNotHaveReduntantFields
 * @memberof module:Tools/base/Proto.Tools( module::Proto )
 */

function assertDoesNotHaveReduntantFields( src )
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
// fields
// --

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

let Fields =
{

  KnownConstructorFields,

  DefaultFieldsGroups,
  DefaultFieldsGroupsRelations,
  DefaultFieldsGroupsCopyable,
  DefaultFieldsGroupsTight,
  DefaultFieldsGroupsInput,

  DefaultForbiddenNames,

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

  //

  construct,

  isFinited,
  finit,

  initFields,
  initWithArguments,
  initExtending,
  initFilter, /* deprecated */

  singleFrom,
  from,

  lowClassName,
  className,
  qualifiedNameTry,
  qualifiedName,
  uname,
  toStr,

  assertDoesNotHaveReduntantFields,

}

//

_.mapExtend( Self, Routines );
_.mapExtend( Self, Fields );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
