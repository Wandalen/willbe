( function _Copyable_s_() {

'use strict';

/**
 * Copyable mixin add copyability and clonability to your class. The module uses defined relation to deduce how to copy / clone the instanceCopyable mixin adds copyability and clonability to your class. The module uses defined relation to deduce how to copy / clone the instance.
  @module Tools/base/CopyableMixin
*/

/**
 * @file Copyable.s.
 */

 /**
 * @classdesc Copyable mixin add copyability and clonability to your class.
 * @class wCopyable
 * @memberof module:Tools/base/CopyableMixin
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCloner' );
  _.include( 'wStringer' );
  _.include( 'wLooker' );
  _.include( 'wEqualer' );

}

//

var _global = _global_;
var _ = _global_.wTools;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

_.assert( !!_._cloner );

//

/**
 * Mixin this into prototype of another object.
 * @param {object} dstClass - constructor of class to mixin.
 * @method onMixinApply
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function onMixinApply( mixinDescriptor, dstClass )
{

  var dstPrototype = dstClass.prototype;
  var has =
  {
    Composes : 'Composes',
    constructor : 'constructor',
  }

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.routineIs( dstClass ), () => 'mixin expects constructor, but got ' + _.strPrimitiveType( dstClass ) );
  _.assertMapOwnAll( dstPrototype, has );
  _.assert( _ObjectHasOwnProperty.call( dstPrototype, 'constructor' ), 'prototype of object should has own constructor' );

  /* */

  _.mixinApply( this, dstPrototype );

  /* prototype accessors */

  var readOnly = { combining : 'supplement' };
  var names =
  {

    Self : readOnly,
    Parent : readOnly,
    className : readOnly,
    lowName : readOnly,
    qualifiedName : readOnly,
    uname : readOnly,

    fieldsOfRelationsGroups : readOnly,
    fieldsOfCopyableGroups : readOnly,
    fieldsOfTightGroups : readOnly,
    fieldsOfInputGroups : readOnly,

    FieldsOfCopyableGroups : readOnly,
    FieldsOfTightGroups : readOnly,
    FieldsOfRelationsGroups : readOnly,
    FieldsOfInputGroups : readOnly,

  }

  _.accessor.readOnly
  ({
    object : dstPrototype,
    names,
    preserveValues : 0,
    strict : 0,
    prime : 0,
    enumerable : 0,
  });

  /* constructor accessors */

  var names =
  {

    Self : readOnly,
    Parent : readOnly,
    className : readOnly,
    lowName : readOnly,

    fieldsOfRelationsGroups : readOnly,
    fieldsOfCopyableGroups : readOnly,
    fieldsOfTightGroups : readOnly,
    fieldsOfInputGroups : readOnly,

    FieldsOfCopyableGroups : readOnly,
    FieldsOfTightGroups : readOnly,
    FieldsOfRelationsGroups : readOnly,
    FieldsOfInputGroups : readOnly,

  }

  _.accessor.readOnly
  ({
    object : dstClass,
    names,
    preserveValues : 0,
    strict : 0,
    prime : 0,
    enumerable : 0,
  });

  /* */

  if( !Config.debug )
  return;

  if( _.routineIs( dstPrototype._equalAre ) )
  _.assert( dstPrototype._equalAre.length <= 1 );

  if( _.routineIs( dstPrototype.equalWith ) )
  _.assert( dstPrototype.equalWith.length <= 2 );

  _.assert( !!dstClass.prototype.FieldsOfRelationsGroupsGet );
  _.assert( !!dstClass.FieldsOfRelationsGroupsGet );
  _.assert( !!dstClass.fieldsOfRelationsGroups );
  _.assert( !!dstClass.FieldsOfRelationsGroups );
  _.assert( !!dstClass.prototype.fieldsOfRelationsGroups );
  _.assert( !!dstClass.prototype.FieldsOfRelationsGroups );

  _.assert( dstPrototype._fieldsOfRelationsGroupsGet === _fieldsOfRelationsGroupsGet );
  _.assert( dstPrototype._fieldsOfCopyableGroupsGet === _fieldsOfCopyableGroupsGet );
  _.assert( dstPrototype._fieldsOfTightGroupsGet === _fieldsOfTightGroupsGet );
  _.assert( dstPrototype._fieldsOfInputGroupsGet === _fieldsOfInputGroupsGet );

  _.assert( dstPrototype.constructor.FieldsOfRelationsGroupsGet === FieldsOfRelationsGroupsGet );
  _.assert( dstPrototype.constructor.FieldsOfCopyableGroupsGet === FieldsOfCopyableGroupsGet );
  _.assert( dstPrototype.constructor.FieldsOfTightGroupsGet === FieldsOfTightGroupsGet );
  _.assert( dstPrototype.constructor.FieldsOfInputGroupsGet === FieldsOfInputGroupsGet );

  _.assert( dstPrototype.finit.name !== 'finitEventHandler', 'wEventHandler mixin should goes after wCopyable mixin.' );
  _.assert( !_.mixinHas( dstPrototype, 'wEventHandler' ), 'wEventHandler mixin should goes after wCopyable mixin.' );

}

//

/**
 * Default instance constructor.
 * @method init
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function init( o )
{
  return _.workpiece.initWithArguments({ instance : this, args : arguments });
}

//

/**
 * Instance descturctor.
 * @method finit
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function finit()
{
  var self = this;
  _.workpiece.finit( self );
}

//

/**
 * Is this instance finited.
 * @method finitedIs
 * @param {object} ins - another instance of the class
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function finitedIs()
{
  var self = this;
  return _.workpiece.isFinited( self );
}

//

function From( src )
{
  return _.workpiece.from( src );
}

//

function Froms( srcs )
{
  debugger;
  return _.workpiece.froms( src );
}

//

/**
 * Copy data from another instance.
 * @param {object} src - another isntance.
 * @method copy
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function copy( src )
{
  var self = this;
  var routine = ( self._traverseAct || _traverseAct );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( src instanceof self.Self || _.mapIs( src ), 'Expects instance of Class or map as argument' );

  var o =
  {
    dst : self,
    src,
    technique : 'object',
    copyingMedials : _.instanceIs( src ) ? 0 : 1,
  };
  var it = _._cloner( routine, o );

  return routine.call( self, it );
}

//

/**
 * Copy data from one instance to another. Customizable static function.
 * @param {object} o - options.
 * @param {object} o.Prototype - prototype of the class.
 * @param {object} o.src - src isntance.
 * @param {object} o.dst - dst isntance.
 * @param {object} o.constitutes - to constitute or not fields, should be off for serializing and on for deserializing.
 * @method copyCustom
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function copyCustom( o )
{
  var self = this;
  var routine = ( self._traverseAct || _traverseAct );

  _.assert( arguments.length == 1 );

  if( o.dst === undefined )
  o.dst = self;

  var it = _._cloner( copyCustom, o );

  return routine.call( self, it );
}

copyCustom.iterationDefaults = Object.create( _._cloner.iterationDefaults );
copyCustom.defaults = _.mapSupplementOwn( Object.create( _._cloner.defaults ), copyCustom.iterationDefaults );

//

function copyDeserializing( o )
{
  var self = this;

  _.assertMapHasAll( o, copyDeserializing.defaults )
  _.assertMapHasNoUndefine( o );
  _.assert( arguments.length == 1 );
  _.assert( _.objectIs( o ) );

  var optionsMerging = Object.create( null );
  optionsMerging.src = o;
  optionsMerging.proto = Object.getPrototypeOf( self );
  optionsMerging.dst = self;
  optionsMerging.deserializing = 1;

  var result = _.cloneObjectMergingBuffers( optionsMerging );

  return result;
}

copyDeserializing.defaults =
{
  descriptorsMap : null,
  buffer : null,
  data : null,
}

//

/**
 * Clone only data.
 * @param {object} [options] - options.
 * @method cloneObject
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function cloneObject( o )
{
  var self = this;
  var o = o || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.routineOptions( cloneObject, o );

  var it = _._cloner( cloneObject, o );

  return self._cloneObject( it );
}

cloneObject.iterationDefaults = Object.create( _._cloner.iterationDefaults );
cloneObject.defaults = _.mapSupplementOwn( Object.create( _._cloner.defaults ), cloneObject.iterationDefaults );
cloneObject.defaults.technique = 'object';

//

/**
 * Clone only data.
 * @param {object} [options] - options.
 * @method _cloneObject
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function _cloneObject( it )
{
  var self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( it.iterator.technique === 'object' );

  /* */

  if( !it.dst )
  {

    dst = it.dst = new it.src.constructor( it.src );
    if( it.dst === it.src )
    {
      debugger;
      dst = it.dst = new it.src.constructor();
      it.dst._traverseAct( it );
    }

  }
  else
  {

    debugger;
    it.dst._traverseAct( it );

  }

  return it.dst;
}

//

/**
 * Clone only data.
 * @param {object} [options] - options.
 * @method cloneData
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function cloneData( o )
{
  var self = this;
  var o = o || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( o.src === undefined )
  o.src = self;

  if( o.dst === undefined || o.dst === null )
  o.dst = Object.create( null );

  var it = _._cloner( cloneData, o );

  return self._cloneData( it );
}

cloneData.iterationDefaults = Object.create( _._cloner.iterationDefaults );
cloneData.iterationDefaults.dst = null;
cloneData.iterationDefaults.copyingAggregates = 3;
cloneData.iterationDefaults.copyingAssociates = 0;
cloneData.defaults = _.mapSupplementOwn( Object.create( _._cloner.defaults ), cloneData.iterationDefaults );
cloneData.defaults.technique = 'data';

//

/**
 * Clone only data.
 * @param {object} [options] - options.
 * @method _cloneData
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function _cloneData( it )
{
  var self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( it.iterator.technique === 'data' );

  return self._traverseAct( it );
}

//

function _traverseAct_pre( routine, args )
{
  let self = this;
  let it = args[ 0 ];

  _.assert( _.objectIs( it ) );
  _.assert( arguments.length === 2, 'Expects single argument' );
  _.assert( args.length === 1, 'Expects single argument' );

  /* adjust */

  if( it.src === undefined )
  debugger;
  if( it.src === undefined )
  it.src = self;

  if( it.iterator.technique === 'data' )
  if( !it.dst )
  it.dst = Object.create( null );

  if( !it.proto && it.dst )
  it.proto = Object.getPrototypeOf( it.dst );
  if( !it.proto && it.src )
  it.proto = Object.getPrototypeOf( it.src );

  return it;
}

//

/**
 * Copy data from one instance to another. Customizable static function.
 * @param {object} o - options.
 * @param {object} o.Prototype - prototype of the class.
 * @param {object} o.src - src isntance.
 * @param {object} o.dst - dst isntance.
 * @param {object} o.constitutes - to constitute or not fields, should be off for serializing and on for deserializing.
 * @method _traverseAct
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

var _empty = Object.create( null );
function _traverseAct_body( it )
{
  var self = this;

  /* adjust */

  _.assert( _.objectIs( it.proto ) );

  /* var */

  var proto = it.proto;
  var src = it.src;
  var dst = it.dst;
  var dropFields = it.dropFields || _empty;
  var Composes = proto.Composes || _empty;
  var Aggregates = proto.Aggregates || _empty;
  var Associates = proto.Associates || _empty;
  var Restricts = proto.Restricts || _empty;
  var Medials = proto.Medials || _empty;

  /* verification */

  _.assertMapHasNoUndefine( it );
  _.assertMapHasNoUndefine( it.iterator );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( src !== dst );
  _.assert( !!src );
  _.assert( _.objectIs( proto ) );
  _.assert( _.strIs( it.path ) );
  _.assert( _.objectIs( proto ), 'Expects object {-proto-}, but got', _.strType( proto ) );
  _.assert( !it.customFields || _.objectIs( it.customFields ) );
  _.assert( it.level >= 0 );
  _.assert( _.numberIs( it.copyingDegree ) );
  _.assert( _.routineIs( self.__traverseAct ) );

  if( _.instanceIsStandard( src ) )
  _.assertMapOwnOnly( src, [ Composes, Aggregates, Associates, Restricts ], () => 'Options instance for ' + self.qualifiedName + ' should not have fields :' );
  else
  _.assertMapOwnOnly( src, [ Composes, Aggregates, Associates, Medials ], () => 'Options map for ' + self.qualifiedName + ' should not have fields :' );

  /* */

  if( it.dst === null )
  {

    dst = it.dst = new it.src.constructor( it.src );
    if( it.dst === it.src )
    {
      debugger;
      dst = it.dst = new it.src.constructor();
      self.__traverseAct( it );
    }

  }
  else
  {

    self.__traverseAct( it );

  }

  /* done */

  return dst;
}

_traverseAct_body.iterationDefaults = Object.create( _._cloner.iterationDefaults );
_traverseAct_body.defaults = _.mapSupplementOwn( Object.create( _._cloner.defaults ) , _traverseAct_body.iterationDefaults );

let _traverseAct = _.routineFromPreAndBody( _traverseAct_pre, _traverseAct_body );

//

function __traverseAct( it )
{

  /* var */

  var proto = it.proto;
  var src = it.src;
  var dst = it.dst = it.dst;
  var dropFields = it.dropFields || _empty;
  var Composes = proto.Composes || _empty;
  var Aggregates = proto.Aggregates || _empty;
  var Associates = proto.Associates || _empty;
  var Restricts = proto.Restricts || _empty;
  var Medials = proto.Medials || _empty;

  var ordersHash = new Map;
  var standardOrder = true;

  /* */

  var newIt = it.iterationClone();

  copyFacets( Composes, it.copyingComposes );
  copyFacets( Aggregates, it.copyingAggregates );
  copyFacets( Associates, it.copyingAssociates );
  copyFacets( _.mapOnly( Medials, Restricts ), it.copyingMedialRestricts );
  copyFacets( Restricts, it.copyingRestricts );
  copyFacets( it.customFields, it.copyingCustomFields );

  run();

  /* done */

  return dst;

  /* */

  function copyFacets( screen, copyingDegree )
  {

    if( screen === null )
    return;

    if( !copyingDegree )
    return;

    _.assert( _.mapIsHeritated( screen ) );
    let screen2 = _.mapExtend( null, screen );

    _.assert( _.numberIs( copyingDegree ) );
    _.assert( it.dst === dst );
    _.assert( _.mapIsHeritated( screen2 ) || !copyingDegree );

    let newIt2 = Object.create( null );
    newIt2.screenFields = screen2;
    newIt2.copyingDegree = Math.min( copyingDegree, it.copyingDegree );
    newIt2.instanceAsMap = 1;

    _.assert( it.copyingDegree === 3, 'not tested' );
    _.assert( newIt2.copyingDegree === 1 || newIt2.copyingDegree === 3, 'not tested' );

    /* copyingDegree applicable to fields, so increment is needed */

    if( newIt2.copyingDegree === 1 )
    newIt2.copyingDegree += 1;

    for( let s in screen2 )
    {
      let e = screen[ s ];
      if( _.definitionIs( e ) )
      if( e.order < 0 || e.order > 0 )
      {
        let newIt3 = _.mapExtend( null, newIt2 );
        newIt3.screenFields = Object.create( null );
        newIt3.screenFields[ s ] = screen2[ s ];
        delete screen2[ s ];
        orderAdd( e.order, newIt3 );
      }
    }

    orderAdd( 0, newIt2 );

  }

  /* */

  function orderAdd( order, newIt2 )
  {
    _.assert( _.numberIs( order ) );

    if( !ordersHash.has( order ) )
    ordersHash.set( order, [] );

    ordersHash.get( order ).push( newIt2 );

  }

  /* */

  function run()
  {

    let orders = Array.from( ordersHash.keys() );
    orders.sort();

    orders.forEach( ( order ) =>
    {
      let its = ordersHash.get( order );
      its.forEach( ( newIt2 ) =>
      {
        _.mapExtend( newIt, newIt2 );
        _._traverseMap( newIt );
      });
    });

  }

}

//

function Clone( o )
{
  var cls = this.Self;
  o = o || Object.create( null );

  _.assert( arguments.length <= 1 );

  if( o instanceof cls )
  return o.clone();
  else
  return cls( o )
}

//

/**
 * Clone only data.
 * @param {object} [options] - options.
 * @method cloneSerializing
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function cloneSerializing( o )
{
  var self = this;
  var o = o || Object.create( null );

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( o.src === undefined )
  o.src = self;

  if( o.copyingMedials === undefined )
  o.copyingMedials = 0;

  if( o.copyingMedialRestricts === undefined )
  o.copyingMedialRestricts = 1;

  var result = _.cloneDataSeparatingBuffers( o );

  return result;
}

cloneSerializing.defaults =
{
  copyingMedialRestricts : 1,
}

cloneSerializing.defaults.__proto__ = _.cloneDataSeparatingBuffers.defaults;

//

/**
 * Clone instance.
 * @method clone
 * @param {object} [self] - optional destination
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function clone()
{
  var self = this;

  _.assert( arguments.length === 0 );

  var dst = new self.constructor( self );
  _.assert( dst !== self );

  return dst;
}

//

function cloneExtending( override )
{
  var self = this;

  _.assert( arguments.length <= 1 );

  if( !override )
  {
    debugger;
    var dst = new self.constructor( self );
    _.assert( dst !== self );
    return dst;
  }
  else
  {
    var src = _.mapOnly( self, self.Self.FieldsOfCopyableGroups );
    _.mapExtend( src, override );
    var dst = new self.constructor( src );
    _.assert( dst !== self && dst !== src );
    return dst;
  }

}

//

function cloneEmpty()
{
  var self = this;
  return self.clone();
}

// --
// etc
// --

/**
 * Gives descriptive string of the object.
 * @method toStr
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function toStr( o )
{
  return _.workpiece.toStr( this, o );
}

// --
// checker
// --

function _equalAre_functor( fieldsGroupsMap )
{
  _.assert( arguments.length <= 1 );

  fieldsGroupsMap = _.routineOptions( _equalAre_functor, fieldsGroupsMap );

  _.routineExtend( _equalAre, _._equal );

  return _equalAre;

  function _equalAre( it )
  {

    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.objectIs( it ) );
    _.assert( it.strictTyping !== undefined );
    _.assert( it.containing !== undefined );

    if( !it.src )
    return false;

    if( !it.src2 )
    return false;

    if( it.strictTyping )
    if( it.src.constructor !== it.src2.constructor )
    return false;

    if( it.src === it.src2 )
    return end( true );

    /* */

    var fieldsMap = Object.create( null );
    for( var g in fieldsGroupsMap )
    if( fieldsGroupsMap[ g ] )
    _.mapExtend( fieldsMap, this[ g ] );

    /* */

    for( var f in fieldsMap )
    {
      if( !it.continue || !it.iterator.continue )
      break;
      var newIt = it.iterationMake().select( f );
      if( !_.mapHas( it.src, f ) )
      return end( false );
      if( !_._equal.body( newIt ) )
      return end( false );
    }

    /* */

    if( !it.containing )
    {
      if( !( it.src2 instanceof this.constructor ) )
      if( _.mapKeys( _.mapBut( it.src, fieldsMap ) ).length )
      return end( false );
    }

    if( !( it.src instanceof this.constructor ) )
    if( _.mapKeys( _.mapBut( it.src, fieldsMap ) ).length )
    return end( false );

    /* */

    return end( true );

    /* */

    function end( result )
    {
      it.continue = false;
      return result;
    }

  }

}

_equalAre_functor.defaults = Object.create( null );

var on = _.mapMake( _.DefaultFieldsGroupsCopyable );
var off = _.mapBut( _.DefaultFieldsGroups, _.DefaultFieldsGroupsCopyable );
_.mapValsSet( on, 1 );
_.mapValsSet( off, 0 );
_.mapExtend( _equalAre_functor.defaults, on, off );

//

/**
 * Is this instance same with another one. Use relation maps to compare.
 * @method equalWith
 * @param {object} ins - another instance of the class
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

var _equalAre = _equalAre_functor();

//

/**
 * Is this instance same with another one. Use relation maps to compare.
 * @method identicalWith
 * @param {object} src - another instance of the class
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function identicalWith( src, opts )
{
  var self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !opts || _.mapIs( opts ), 'not tested' );

  var args = [ self, src, opts ];
  var it = self._equalAre.pre.call( self, self.identicalWith, args );
  var result = this._equalAre( it );

  return result;
}

_.routineExtend( identicalWith, _.entityIdentical );

//

/**
 * Is this instance equivalent with another one. Use relation maps to compare.
 * @method equivalentWith
 * @param {object} src - another instance of the class
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function equivalentWith( src, opts )
{
  var self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !opts || _.mapIs( opts ), 'not tested' );

  var args = [ self, src, opts ];
  var it = self._equalAre.pre.call( self, self.equivalentWith, args );
  var result = this._equalAre( it );

  return result;
}

_.routineExtend( equivalentWith, _.entityEquivalent );

//

/**
 * Does this instance contain with another instance or map.
 * @method contains
 * @param {object} src - another instance of the class
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function contains( src, opts )
{
  var self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !opts || _.mapIs( opts ), 'not tested' );

  var args = [ self, src, opts ];
  var it = self._equalAre.pre.call( self, self.contains, args );
  var result = this._equalAre( it );

  return result;
}

_.routineExtend( contains, _.entityContains );

//

function instanceIs()
{
  _.assert( arguments.length === 0 );
  return _.instanceIs( this );
}

//

function prototypeIs()
{
  _.assert( arguments.length === 0 );
  return _.prototypeIs( this );
}

//

function constructorIs()
{
  _.assert( arguments.length === 0 );
  return _.constructorIs( this );
}

// --
// field
// --

/**
 * Get map of all fields.
 * @method FieldsOfRelationsGroupsGet
 * @memberof wCopyable
 */

function _fieldsOfRelationsGroupsGet()
{
  var self = this;
  return _.workpiece.fieldsOfRelationsGroups( this );
}

//

/**
 * Get map of copyable fields.
 * @method _fieldsOfCopyableGroupsGet
 * @memberof wCopyable
 */

function _fieldsOfCopyableGroupsGet()
{
  var self = this;
  return _.workpiece.fieldsOfCopyableGroups( this );
}

//

/**
 * Get map of loggable fields.
 * @method _fieldsOfTightGroupsGet
 * @memberof wCopyable
 */

function _fieldsOfTightGroupsGet()
{
  var self = this;
  return _.workpiece.fieldsOfTightGroups( this );
}

//

function _fieldsOfInputGroupsGet()
{
  var self = this;
  return _.workpiece.fieldsOfInputGroups( this );
}

//

/**
 * Get map of all relations fields.
 * @method FieldsOfRelationsGroupsGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function FieldsOfRelationsGroupsGet()
{
  return _.workpiece.fieldsOfRelationsGroups( this.Self );
}

//

/**
 * Get map of copyable fields.
 * @method FieldsOfCopyableGroupsGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function FieldsOfCopyableGroupsGet()
{
  return _.workpiece.fieldsOfCopyableGroups( this.Self );
}

//

/**
 * Get map of tight fields.
 * @method FieldsOfTightGroupsGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function FieldsOfTightGroupsGet()
{
  return _.workpiece.fieldsOfTightGroups( this.Self );
}

//

/**
 * Get map of input fields.
 * @method FieldsOfInputGroupsGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function FieldsOfInputGroupsGet()
{
  return _.workpiece.fieldsOfInputGroups( this.Self );
}

//

function hasField( fieldName )
{
  debugger;
  return _.prototypeHasField( this, fieldName );
}

// --
// class
// --

/**
 * Return own constructor.
 * @method _SelfGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function _SelfGet()
{
  var result = _.constructorOf( this );
  return result;
}

//

/**
 * Return parent's constructor.
 * @method _ParentGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function _ParentGet()
{
  var result = _.parentOf( this );
  return result;
}

// --
// name
// --

function _lowNameGet()
{
  return _.workpiece.lowClassName( this );
}

//

/**
 * Return name of class constructor.
 * @method _classNameGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function _classNameGet()
{
  return _.workpiece.className( this );
}

//

/**
 * Nick name of the object.
 * @method _qualifiedNameGet
 * @memberof module:Tools/base/CopyableMixin.wCopyable#
 */

function _qualifiedNameGet()
{
  return _.workpiece.qualifiedName( this );
}

//

function unameGet()
{
  return _.workpiece.uname( this );
}

// --
// relations
// --

var Composes =
{
}

var Aggregates =
{
}

var Associates =
{
}

var Restricts =
{
}

var Medials =
{
}

var Statics =
{

  From,
  Froms,

  Clone,

  instanceIs,
  prototypeIs,
  constructorIs,

  _fieldsOfRelationsGroupsGet,
  _fieldsOfCopyableGroupsGet,
  _fieldsOfTightGroupsGet,
  _fieldsOfInputGroupsGet,

  FieldsOfRelationsGroupsGet,
  FieldsOfCopyableGroupsGet,
  FieldsOfTightGroupsGet,
  FieldsOfInputGroupsGet,

  hasField,

  _SelfGet,
  _ParentGet,
  _classNameGet,
  _lowNameGet,

}

Object.freeze( Composes );
Object.freeze( Aggregates );
Object.freeze( Associates );
Object.freeze( Restricts );
Object.freeze( Medials );
Object.freeze( Statics );

// --
// declare
// --

var Supplement =
{

  init,
  finit,
  finitedIs,

  From,
  Froms,

  copy,

  copyCustom,
  copyDeserializing,

  _traverseAct,
  __traverseAct,

  cloneObject,
  _cloneObject,

  cloneData,
  _cloneData,

  Clone,
  cloneSerializing,
  clone,
  cloneExtending,
  cloneEmpty,

  // etc

  toStr,

  // checker

  _equalAre_functor,
  _equalAre,

  identicalWith,
  equivalentWith,
  contains,

  instanceIs,
  prototypeIs,
  constructorIs,

  // field

  _fieldsOfRelationsGroupsGet,
  _fieldsOfCopyableGroupsGet,
  _fieldsOfTightGroupsGet,
  _fieldsOfInputGroupsGet,

  // class

  _SelfGet,
  _ParentGet,

  // name

  _lowNameGet,
  _classNameGet,
  _qualifiedNameGet,
  unameGet,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,

}

//

var Self = _.mixinDelcare
({
  supplement : Supplement,
  onMixinApply,
  name : 'wCopyable',
  shortName : 'Copyable',
});

//

_.assert( !Self.copy );
_.assert( _.routineIs( Self.prototype.copy ) );
_.assert( _.strIs( Self.shortName ) );
_.assert( _.objectIs( Self.__mixin__ ) );
_.assert( !Self.onMixinApply );
_.assert( _.routineIs( Self.mixin ) );

// --
// export
// --

_global_[ Self.name ] = _[ Self.shortName ] = Self;
if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
