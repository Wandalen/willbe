(function _Changes_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

}

//

var Self = _global_.wTools;
var _ = _global_.wTools;

var _ArraySlice = Array.prototype.slice;
var _FunctionBind = Function.prototype.bind;
var _ObjectToString = Object.prototype.toString;
var _ObjectHasOwnProperty = Object.hasOwnProperty;
// var __assert = _.assert;

// --
// changes
// --

/**
 * Extend name map by other name maps.
 * @method changesExtend
 * @memberof wTools#
 */

function changesExtend( dst )
{

  _.assert( _.objectIs( dst ) );

  for( var a = 1 ; a < arguments.length ; a++ )
  {
    var src = arguments[ a ];

    _changesExtend( dst,src )

  }

  return dst;
}

//

/**
 * Extend name map by other name map.
 * @method _changesExtend
 * @memberof wTools#
 */

function _changesExtend( dst,src )
{

  _.assert( arguments.length === 2 );
  _.assert( _.objectIs( src ) );

  for( var s in src )
  {

    _.assert( _.objectIs( src ) || _.boolsIs( src ) );

    /**/

    if( _.arrayIs( src[ s ] ) )
    {
      if( dst[ s ] === undefined )
      dst[ s ] = [];
      else
      dst[ s ] = [ dst[ s ] ];
    }

    if( _.boolIs( dst[ s ] ) )
    {
      dst[ s ] = [ dst[ s ] ];
    }

    /**/

    if( _.boolIs( src[ s ] ) )
    {
      dst[ s ] = src[ s ];
    }
    else if( _.arrayIs( src[ s ] ) )
    {
      for( var i = 0, l = src[ s ].length ; i < l ; i++ )
      dst[ s ].push( src[ s ][ i ] );
    }
    else if( _.objectIs( src[ s ] ) )
    {

      if( _.objectIs( dst[ s ] ) )
      dst[ s ] = _changesExtend( dst[ s ],src[ s ] );
      else if( dst[ s ] === undefined )
      dst[ s ] = _changesExtend( Object.create( null ),src[ s ] );
      else if( _.arrayIs( dst[ s ] ) )
      dst[ s ].push( _changesExtend( Object.create( null ),src[ s ] ) );
      else _.assert( 0, 'unknown dst type' );

    }
    else _.assert( 0, 'unknown src type' );

  }

  return dst;
}

//

/**
 * Selects sub map from map with help of changes map.
 * @method changesSelect
 * @memberof wTools#
 */

function changesSelect( changes,src,options )
{
  var options = options || Object.create( null );
  var result = Object.create( null );

  var optionsDefault =
  {
    ignoreUndefined : false,
    /*onSelect : function(){},*/
  }

  _.assertMapHasOnly( options,optionsDefault );
  _.mapSupplement( options,optionsDefault );
  _.assert( _.objectIs( changes ) );

  result = _changesSelectFromContainer( result,src,changes,options );

  return result;
}

//

/**
 * Selects sub map from map with help of changes map. Actual implementation.
 * @method _changesSelectFromContainer
 * @memberof wTools#
 */

function _changesSelectFromContainer( resultContainer,srcContainer,changes,options )
{

  _.assert( arguments.length === 4 );
  _.assert( _.objectIs( changes ) );
  _.assert( _.objectIs( resultContainer ) );

  for( var n in changes )
  {

    var change = changes[ n ];
    resultContainer = _changesSelectFromTerminal( resultContainer,srcContainer,n,change,options );

  }

  return resultContainer;
}

//

/**
 * Selects sub map from map with help of changes map. Actual implementation.
 * @method _changesSelectFromContainer
 * @memberof wTools#
 */

function _changesSelectFromTerminal( resultContainer,srcContainer,name,change,options )
{

  _.assert( arguments.length === 5 );
  _.assert( change !== undefined );
  _.assert( _.objectIs( resultContainer ) );
  _.assert( _.strIs( name ) );

  if( _.boolIs( change ) )
  {

    if( change )
    {
      resultContainer[ name ] = _changesSelectingClone( resultContainer[ name ],srcContainer[ name ] );
    }
    else
    {
      debugger;
      delete resultContainer[ name ];
    }

    if( change && !options.ignoreUndefined )
    _.assert( resultContainer[ name ] !== undefined );

  }
  else if( _.objectIs( change ) )
  {
    if( resultContainer[ name ] )
    {
      if( !_.objectIs( resultContainer[ name ] ) )
      resultContainer[ name ] = _.arrayToMap( resultContainer[ name ] );
    }
    else
    {
      resultContainer[ name ] = Object.create( null );
    }
    resultContainer[ name ] = _changesSelectFromContainer( resultContainer[ name ],srcContainer[ name ],change,options );
  }
  else if( _.arrayIs( change ) )
  {
    for( var c = 0 ; c < change.length ; c++ )
    resultContainer = _changesSelectFromTerminal( resultContainer,srcContainer,name,change[ c ],options );
  }
  else _.assert( 0,'Strange changes map' );

  return resultContainer;
}

//

/**
 * Apply changes to object.
 * @method changesApply
 * @memberof wTools#
 */

function changesApply( changes,dst,src,options )
{
  var options = options || Object.create( null );

  _.assert( _.objectIs( dst ) );
  _.assert( 3 <= arguments.length && arguments.length <= 4 );

  return _changesApply( changes,dst,src,options );
}

//

/**
 * Apply changes to object.
 * @method changesApply
 * @memberof wTools#
 */

function _changesApply( changes,dst,src,options )
{

  _.assert( arguments.length === 4 );

  if( _.boolIs( changes ) )
  {

    if( changes )
    {
      return _changesApplyingSet( dst,src );
    }
    else
    {
      debugger;
      return;
    }

  }
  else if( _.arrayIs( changes ) )
  {
    var val = dst;
    for( var c = 0 ; c < changes.length ; c++ )
    {
      val = _changesApply( changes[ c ],val,src,options );
      if( c+1 < changes.length && val === undefined )
      {
        debugger;
        val = _.entityMake( dst );
      }
    }
    dst = val;
  }
  else if( _.objectIs( changes ) )
  {

    _.assert( !!dst );
    for( var c in changes )
    {

      var val = _changesApply( changes[ c ],dst[ c ],src[ c ],options );
      if( val !== undefined )
      dst[ c ] = val;
      else
      delete dst[ c ];

    }

  }
  else _.assert( 0,'Strange changes map' );

  return dst;
}

//

/**
 * Selects sub map from map with help of changes map. Actual implementation.
 * @method _changesSelectingClone
 * @memberof wTools#
 */

function _changesSelectingClone( dst,src )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.primitiveIs( src ) )
  return src;

  var result = _.cloneData
  ({
    src : src,
    // copyingBuffers : 1,
  });

  return result;
}

//

/**
 * Selects sub map from map with help of changes map. Actual implementation.
 * @method _changesApplyingSet
 * @memberof wTools#
 */

function _changesApplyingSet( dst,src )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( dst )
  {

    if( dst.copyCustom && src )
    return dst.copyCustom
    ({

      dst : dst,
      src : src,

      copyingComposes : 3,
      copyingAggregates : 1,
      copyingAssociates : 0,

      technique : 'object',

    });

  }

  if( _.primitiveIs( src ) )
  {
    return src;
  }

  return src;
}

// --
// declare
// --

var Proto =
{

  changesExtend : changesExtend,
  _changesExtend : _changesExtend,

  changesSelect : changesSelect,
  _changesSelectFromContainer : _changesSelectFromContainer,
  _changesSelectFromTerminal : _changesSelectFromTerminal,

  changesApply : changesApply,
  _changesApply : _changesApply,

  _changesSelectingClone : _changesSelectingClone,
  _changesApplyingSet : _changesApplyingSet,

};

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
