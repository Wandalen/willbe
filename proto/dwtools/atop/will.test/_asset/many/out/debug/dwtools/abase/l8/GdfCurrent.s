(function _GdfCurrent_s_() {

'use strict';

/**
 * @file GdfCurrent.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wCopyable' );

}

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wGenericDataFormatCurrent( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Current';

// --
// routines
// --

function init( o )
{
  let selected = this;

  _.assert( arguments.length <= 1 );
  _.mapExtend( selected, o )
  delete selected.default;
  Object.preventExtensions( selected );

  _.assert( selected.encoder instanceof _.Gdf );

  let proxy = _.proxyMap( selected, selected.encoder );

  return proxy;
}

//

function encode_body( o )
{
  let selected = this;

  _.assertRoutineOptions( encode, arguments );

  if( o.format === null )
  o.format = selected.in;

  let result = selected.encoder.encode.body.call( selected.encoder, o );

  return result;
}

_.routineExtend( encode_body, _.Gdf.prototype.encode );

let encode = _.routineFromPreAndBody( _.Gdf.prototype.encode.pre, encode_body );

// --
// declare
// --

let Proto =
{

  init,
  encode,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

// --
// export
// --

_.staticDeclare
({
  prototype : _.Gdf.prototype,
  name : Self.shortName,
  value : Self,
});

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
