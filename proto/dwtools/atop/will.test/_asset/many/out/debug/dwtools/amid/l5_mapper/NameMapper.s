( function _NameMapper_s_( ) {

'use strict';

/**
 * Simple class to map names from one space to another and vice versa. Options for handling names collisions exist. Use the module to make your program shorter, more readable and to avoid typos.
  @module Tools/mid/NameMapper
*/

/**
 * @file NameMapper.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wCopyable' );

}

//

/**
 * @classdesc Simple class to map names from one space to another and vice versa.
 * @param {Object} o Options map for constructor. {@link module:Tools/mid/NameMapper.wNameMapper.Fields Options description }
 * @example
 * let mapper = new _.NameMapper({ leftName : 'kind of entity', rightName : 'name of routine' })
 * @class wNameMapper
 * @memberof module:Tools/mid/NameMapper
*/

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wNameMapper( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'NameMapper';

// --
// inter
// --

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( self );

  if( o )
  self.copy( o );

  self.forVal = self._forVal.bind( self );
  self.forKey = self._forKey.bind( self );
  self.hasKey = self._hasKey.bind( self );
  self.hasVal = self._hasVal.bind( self );

  if( self.constructor === Self )
  Object.preventExtensions( self );
}

//

/**
 * @summary Maps names from one space to another and vice versa.
 * @description Expects at least one map with key:value pairs.
 * @example
 * let shortNameToLong  = new _.NameMapper().set
   ({
      'Tools' : 'wTools',
      'NameMapper' : 'wNameMapper',
   });
   shortNameToLong.forKey('NameMapper') // wNameMapper
   shortNameToLong.forVal('wTools') // Tools
 * @class set
 * @memberof module:Tools/mid/NameMapper.wNameMapper#
*/

function set()
{
  let self = this;

  _.assert( arguments.length > 0 );

  self.keyToValueMap = _.mapExtend( null, self.keyToValueMap );
  _.mapsExtend( self.keyToValueMap, arguments );

  if( self.droppingDuplicates )
  self.valueToKeyMap = _.mapInvertDroppingDuplicates( self.keyToValueMap );
  else
  self.valueToKeyMap = _.mapInvert( self.keyToValueMap );

  Object.freeze( self.keyToValueMap );
  Object.freeze( self.valueToKeyMap );

  return self;
}

//

/**
 * @summary Returns key mapped with provided value `val`.
 * @example
 * let keyToValueMap  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   keyToValueMap.forVal('B') // A
 * @class forVal
 * @memberof module:Tools/mid/NameMapper.wNameMapper#
*/

function _forVal( val )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.primitiveIs( val ) )
  {
    debugger;
    return _.entityMap( val, function forVal( val )
    {
      return self.forVal( val );
    });
  }

  if( self.asIsIfMiss && self.valueToKeyMap[ val ] === undefined )
  return val;

  _.assert( self.valueToKeyMap[ val ] !== undefined, () => 'Unknown ' + self.rightName + ' ' + val );

  return self.valueToKeyMap[ val ];
}

//

/**
 * @summary Returns value mapped with provided key `key`.
 * @example
 * let keyToValueMap  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   keyToValueMap.forKey('A') // B
 * @class forKey
 * @memberof module:Tools/mid/NameMapper.wNameMapper#
*/

function _forKey( key )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !_.primitiveIs( key ) )
  {
    debugger;
    return _.entityMap( key, function forKey( key )
    {
      return self.forKey( key );
    });
  }

  _.assert( _.strIs( key ) || _.numberIs( key ), 'Expects string or number {-key-}, but got', _.strType( key ) );

  if( self.asIsIfMiss && self.keyToValueMap[ key ] === undefined )
  return key;

  _.assert( self.keyToValueMap[ key ] !== undefined, () => 'Unknown ' + self.leftName + ' ' + _.strQuote( key ) );

  return self.keyToValueMap[ key ];
}

//

/**
 * @summary Returns true if map has key:value pair with provided value `val`.
 * @example
 * let keyToValueMap  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   keyToValueMap.hasVal('A') // false
   keyToValueMap.hasVal('B') // true
 * @class hasVal
 * @memberof module:Tools/mid/NameMapper.wNameMapper#
*/

function _hasVal( val )
{
  let self = this;
  return self.valueToKeyMap[ val ] !== undefined;
}

//

/**
 * @summary Returns true if map has key:value pair with provided key `key`.
 * @example
 * let keyToValueMap  = new _.NameMapper().set
   ({
      'A' : 'B',
   });
   keyToValueMap.hasKey('A') // true
   keyToValueMap.hasKey('B') // false
 * @class hasKey
 * @memberof module:Tools/mid/NameMapper.wNameMapper#
*/

function _hasKey( key )
{
  let self = this;
  _.assert( _.strIs( key ) || _.numberIs( key ), 'Expects string or number {-key-}, but got', _.strType( key ) );
  return self.keyToValueMap[ key ] !== undefined;
}

/**
 * @typedef {Object} Fields
 * @property {Boolean} droppingDuplicates=1 Prevents duplication of keys.
 * @property {Boolean} asIsIfMiss=0 Return source value if key:value pair is not found.
 * @property {Object} keyToValueMap Container for mapped key:value pairs.
 * @property {Object} valueToKeyMap Container for mapped value:key pairs.
 * @property {String} leftName='key' Description of left side of key:value pair.
 * @property {String} rightName='value' Description of right side of key:value pair.
 * @memberof module:Tools/mid/NameMapper.wNameMapper
 */

// --
// relations
// --

let Composes =
{
  droppingDuplicates : 1,
  asIsIfMiss : 0,
  keyToValueMap : _.define.own( {} ),
  valueToKeyMap : _.define.own( {} ),
  leftName : 'key',
  rightName : 'value',
}

let Associates =
{
}

let Restricts =
{
}

// --
// declare
// --

let Proto =
{

  init,
  set,

  _forVal,
  _forKey,
  _hasVal,
  _hasKey,

  // relations

  Composes,
  Associates,
  Restricts,

};

// define

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

_[ Self.shortName ] = _global_[ Self.name ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
