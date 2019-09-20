( function _Instancing_s_() {

'use strict';

/**
 * Mixin adds instances accounting functionality to a class. Instancing makes possible to iterate instances of the specific class, optionally create names map or class name map in case of a complicated hierarchical structure. Use Instancing to don't repeat yourself. Refactoring required.
  @module Tools/mixin/Instancing
*/

/**
 * @file Instancing.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );

}

//

var _global = _global_;
var _ = _global_.wTools;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

//

function onMixinApply( mixinDescriptor, dstClass )
{
  /* xxx : clean it */

  var dstPrototype = dstClass.prototype;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.routineIs( dstClass ) );
  _.assert( !dstPrototype.instances,'class already has mixin',Self.name );
  _.assert( _.mapKeys( Supplement ).length === 8 );

  _.mixinApply( this, dstPrototype );

  // _.accessor.forbid
  // ({
  //   object : dstPrototype.constructor.InstancesMap,
  //   prime : 0,
  //   names : { null : 'null', undefined : 'undefined' },
  // });

  _.assert( _.mapKeys( Supplement ).length === 8 );

  /* */

  _.accessor.readOnly
  ({
    object : [ dstPrototype.constructor, dstPrototype ],
    methods : Supplement,
    names :
    {
      firstInstance : { readOnlyProduct : 0 },
    },
    preserveValues : 0,
    prime : 0,
  });

  _.accessor.readOnly
  ({
    object : dstPrototype.constructor.prototype,
    methods : Supplement,
    names :
    {
      instanceIndex : { readOnly : 1, readOnlyProduct : 0 },
    },
    preserveValues : 0,
    combining : 'supplement',
  });

  _.accessor.declare
  ({
    object : dstPrototype.constructor.prototype,
    methods : Supplement,
    names :
    {
      name : 'name',
    },
    preserveValues : 0,
    combining : 'supplement',
  });

  _.accessor.forbid
  ({
    object : dstPrototype.constructor,
    prime : 0,
    names : { instance : 'instance' },
  });

  _.assert( _.mapIs( dstPrototype.InstancesMap ) );
  _.assert( dstPrototype.InstancesMap === dstPrototype.constructor.InstancesMap );
  _.assert( _.arrayIs( dstPrototype.instances ) );
  _.assert( dstPrototype.instances === dstPrototype.constructor.instances );
  _.assert( _.mapKeys( Supplement ).length === 8 );

}

//

/**
 * @classdesc Mixin adds instances accounting functionality to a class.
 * @class wInstancing
 * @memberof module:Tools/mixin/Instancing
 */

/**
 * Functors to produce init.
 * @param { routine } original - original method.
 * @method init
 * @memberof module:Tools/mixin/Instancing.wInstancing#
 */

function init( original )
{

  return function initInstancing()
  {
    var self = this;

    self.instances.push( self );
    self.InstancesCounter[ 0 ] += 1;

    return original ? original.apply( self,arguments ) : undefined;
  }

}

//

/**
 * Functors to produce finit.
 * @param { routine } original - original method.
 * @method finit
 * @memberof module:Tools/mixin/Instancing.wInstancing#
 */

function finit( original )
{

  return function finitInstancing()
  {
    var self = this;

    if( self.name )
    {
      if( self.UsingUniqueNames )
      self.InstancesMap[ self.name ] = null;
      else if( self.InstancesMap[ self.name ] )
      _.arrayRemoveElementOnce( self.InstancesMap[ self.name ],self );
    }

    _.arrayRemoveElementOnce( self.instances,self );

    return original ? original.apply( self,arguments ) : undefined;
  }

}

//

/**
 * Iterate through instances of this type.
 * @param {routine} onEach - on each handler.
 * @method eachInstance
 * @memberof module:Tools/mixin/Instancing.wInstancing#
 */

function eachInstance( onEach )
{
  var self = this;

  /*if( self.Self.prototype === self )*/

  for( var i = 0 ; i < self.instances.length ; i++ )
  {
    var instance = self.instances[ i ];
    if( instance instanceof self.Self )
    onEach.call( instance );
  }

  return self;
}

//

function instanceByName( name )
{
  var self = this;

  _.assert( _.strIs( name ) || name instanceof self.Self,'Expects name or suit instance itself, but got',_.strType( name ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( name instanceof self.Self )
  return name;

  if( self.UsingUniqueNames )
  return self.InstancesMap[ name ];
  else
  return self.InstancesMap[ name ] ? self.InstancesMap[ name ][ 0 ] : undefined;

}

//

function instancesByFilter( filter )
{
  var self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  var result = _.entityFilter( self.instances, filter );

  return result;
}

//

/**
 * Get first instance.
 * @method _firstInstanceGet
 * @memberof module:Tools/mixin/Instancing.wInstancing#
 */

function _firstInstanceGet()
{
  var self = this;
  return self.instances[ 0 ];
}

//

/**
 * Get index of current instance.
 * @method _instanceIndexGet
 * @memberof module:Tools/mixin/Instancing.wInstancing#
 */

function _instanceIndexGet()
{
  var self = this;
  return self.instances.indexOf( self );
}

//

/**
 * Set name.
 * @method _nameSet
 * @memberof module:Tools/mixin/Instancing.wInstancing#
 */

function _nameSet( name )
{
  var self = this;
  var nameWas = self[ nameSymbol ];

  if( self.UsingUniqueNames )
  {
    _.assert( _.mapIs( self.InstancesMap ) );
    if( nameWas )
    delete self.InstancesMap[ nameWas ];
  }
  else
  {
    if( nameWas && self.InstancesMap[ nameWas ] )
    _.arrayRemoveElementOnce( self.InstancesMap[ nameWas ], self );
  }

  if( name )
  {
    if( self.UsingUniqueNames )
    {
      if( Config.debug )
      if( self.InstancesMap[ name ] )
      throw _.err
      (
        self.Self.name,'has already an instance with name "' + name + '"',
        ( self.InstancesMap[ name ].suiteFileLocation ? ( '\nat ' + self.InstancesMap[ name ].suiteFileLocation ) : '' )
      );
      self.InstancesMap[ name ] = self;
    }
    else
    {
      self.InstancesMap[ name ] = self.InstancesMap[ name ] || [];
      _.arrayAppendOnce( self.InstancesMap[ name ], self );
    }
  }

  self[ nameSymbol ] = name;

}

//

function _nameGet()
{
  var self = this;
  return self[ nameSymbol ];
}

// --
// declare
// --

var nameSymbol = Symbol.for( 'name' );

var Functors =
{

  init,
  finit,

}

var Statics =
{

  eachInstance,
  instanceByName,
  instancesByFilter,

  instances : _.define.contained({ ini : [], readOnly : 1, shallowCloning : 1 }),
  InstancesMap : _.define.contained({ ini : Object.create( null ), readOnly : 1, shallowCloning : 1 }),
  UsingUniqueNames : _.define.contained({ ini : 0, readOnly : 1 }),
  InstancesCounter : _.define.contained({ ini : [ 0 ], readOnly : 1 }),

  // firstInstance : null,

}

var Supplement =
{

  _firstInstanceGet,
  _instanceIndexGet,
  _nameSet,
  _nameGet,

  eachInstance,
  instanceByName,
  instancesByFilter,

  Statics,

}

var Self =
{

  onMixinApply,
  supplement : Supplement,
  functors : Functors,
  name : 'wInstancing',
  shortName : 'Instancing',

}

_global_[ Self.name ] = _[ Self.shortName ] = _.mixinDelcare( Self );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
