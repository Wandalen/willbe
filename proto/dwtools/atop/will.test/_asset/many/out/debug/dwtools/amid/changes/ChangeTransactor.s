( function _ChangeTransactor_s_() {

'use strict';

/**
 * Still sketch. Mixin to add the ability to track changes of an object, to reflect changes in a data structure and to make possible to apply the changes to another object. Use the module to mirror object's changes somehow elsewhere, for example on server-side or client-side.
  @module Tools/base/ChangeTransactor
*/

/**
 * @file ChangeTransactor.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );

  require( './Changes.s' );

}

var _ = _global_.wTools;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

//

function onMixinApply( mixinDescriptor, dstClass )
{

  var dstPrototype = dstClass.prototype;

  _.mixinApply( this, dstPrototype );
  // _.mixinApply
  // ({
  //   dstPrototype : dstPrototype,
  //   descriptor : Self,
  // });

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( dstPrototype.Events.changed ) );

}

//

function changeBegin()
{
  var self = this;

  _.assert( arguments.length === 0 );
  _.assert( self._changeLevel >= 0 );

  self._changeLevel += 1;

}

//

function changeEnd()
{
  var self = this;

  _.assert( arguments.length === 0 );
  _.assert( self._changeLevel >= 1 );

  self._changeLevel -= 1;

  if( self._changeLevel === 0 )
  self._changed();

}

//

function changed()
{
  var self = this;

  _.assert( arguments.length === 0 );

  if( self._changeLevel === 0 )
  self._changed();

}

//

function _changed()
{
  var self = this;

  if( _.routineIs( self.eventGive ) )
  self.eventGive({ kind : 'changed' });

}

// --
// declare
// --

var Composes =
{
}

var Restricts =
{
  _changeLevel : 0,
}

var Statics =
{
}

var Events =
{
  'changed' : 'changed',
}

var Functors =
{
}

var Supplement =
{

  changeBegin : changeBegin,
  changeEnd : changeEnd,
  changed : changed,
  _changed : _changed,

  Composes : Composes,
  Restricts : Restricts,
  Statics : Statics,
  Events : Events,

}

//

var Self =
{

  onMixinApply : onMixinApply,

  functors : Functors,
  supplement : Supplement,

  name : 'wChangeTransactor',
  shortName : 'ChangeTransactor',

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.shortName ] = _.mixinDelcare( Self );

})();
