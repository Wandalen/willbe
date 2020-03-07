( function _NameTools_s_() {

'use strict';

var Self = _global_.wTools;
var _global = _global_;
var _ = _global_.wTools;

var _ArraySlice = Array.prototype.slice;
var _FunctionBind = Function.prototype.bind;
var _ObjectToString = Object.prototype.toString;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

// var __assert = _.assert;
var _arraySlice = _.longSlice;

// --
// name and symbol
// --

/**
 * Produce fielded name from string.
 * @param {string} nameString - object coded name or string.
 * @return {object} nameKeyValue - name in key/value format.
 * @method nameFielded
 * @memberof wTools
 */

function nameFielded( nameString )
{

  if( _.objectIs( nameString ) )
  {
    return nameString;
  }
  else if( _.strIs( nameString ) )
  {
    var name = {};
    name[ nameString ] = nameString;
    return name;
  }
  else _.assert( 0, 'nameFielded :', 'Expects string or ' );

}

//

/**
 * Returns name splitted in coded/raw fields.
 * @param {object} nameObject - fielded name or name as string.
 * @return {object} name splitted in coded/raw fields.
 * @method nameUnfielded
 * @memberof wTools
 */

function nameUnfielded( nameObject )
{
  var name = {};

  if( _.mapIs( nameObject ) )
  {
    var keys = Object.keys( nameObject );
    _.assert( keys.length === 1 );
    name.coded = keys[ 0 ];
    name.raw = nameObject[ name.coded ];
  }
  else if( _.strIs( nameObject ) )
  {
    name.raw = nameObject;
    name.coded = nameObject;
  }
  else if( _.symbolIs( nameObject ) )
  {
    name.raw = nameObject;
    name.coded = nameObject;
  }
  else _.assert( 0, 'nameUnfielded :', 'Unknown arguments' );

  // _.assert( arguments.length === 1 );
  // _.assert( _.strIs( name.raw ) || _.symbolIs( name.raw ), 'nameUnfielded :', 'not a string, something wrong :', nameObject );
  // _.assert( _.strIs( name.coded ) || _.symbolIs( name.coded ), 'nameUnfielded :', 'not a string, something wrong :', nameObject );

  return name;
}

//

/**
 * Returns name splitted in coded/coded fields. Drops raw part replacing it by coded.
 * @param {object} namesMap - fielded names.
 * @return {object} expected map.
 * @method namesCoded
 * @memberof wTools
 */

function namesCoded( namesMap )
{
  var result = {}

  if( _.assert )
  _.assert( arguments.length === 1 );
  if( _.assert )
  _.assert( _.objectIs( namesMap ) );

  for( var n in namesMap )
  result[ n ] = n;

  return result;
}

// --
// id
// --

function idWithDate( prefix, postfix, fast )
{
  var date = new Date;

  prefix = prefix ? prefix : '';
  postfix = postfix ? postfix : '';

  if( fast )
  return prefix + date.valueOf() + postfix;

  var d =
  [
    date.getFullYear(),
    date.getMonth()+1,
    date.getDate(),
    date.getHours(),
    date.getMinutes(),
    date.getSeconds(),
    date.getMilliseconds(),
    Math.floor( Math.random()*0x10000 ).toString( 16 ),
  ].join( '-' );

  return prefix + d + postfix
}

//

function idWithTime( prefix, postfix )
{
  var date = new Date;

  prefix = prefix ? prefix : '';
  postfix = postfix ? postfix : '';

  var d =
  [
    String( date.getHours() ) + String( date.getMinutes() ) + String( date.getSeconds() ),
    String( date.getMilliseconds() ),
    Math.floor( Math.random()*0x10000 ).toString( 16 ),
  ].join( '-' );

  return prefix + d + postfix
}

//

/* aaa : reimplement it more properly | Dmytro : new implementation is written below, it use futures of random RFC4122 GUIDs v4. Guids can be more complex for example https://www.npmjs.com/package/uuid */

function idWithGuid()
{

  var result =
  [
    s4() + s4(),
    s4(),
    s4(),
    s4(),
    s4() + s4() + s4(),
  ].join( '-' );

  return result;

  function s4()
  {
    return Math.floor( ( 1 + Math.random() ) * 0x10000 ).toString( 16 ).substring( 1 );
  }

}

//

// function idWithGuid()
// {
//   let guid = '$$$$$$$$-$$$$-4$$$-y$$$-$$$$$$$$$$$$';
//
//   return guid.replace( /[$y]/g, replaceSymbol );
//
//   /* */
//
//   function replaceSymbol( sym )
//   {
//     let r = Math.random() * 16 | 0;
//     return ( sym === '$' ? r : ( r & 0x3 | 0x8 ) ).toString( 16 );
//   }
// }

//

/**
 * Routine idWithTimeGuid() returns random GUID of RFC4122 standard.
 * GUID v4 is used.
 * Routine does not accepts parameters.
 *
 * @example
 * _.idWithTimeGuid()
 * // returns '0d796bf0-dc89-4ccd-b751-01430f6ec71f'
 *
 * @return { String } - Returns GUID v4.
 * @function idWithTimeGuid
 * @memberof wTools
 */

function idWithTimeGuid()
{
  /* aqq : ask */
  /* Dmytro : improved, 'x' -> '$' */
  let guid = '$$$$$$$$-$$$$-4$$$-y$$$-$$$$$$$$$$$$'; 
  let date = _.time.now();

  return guid.replace( /[$y]/g, replaceSymbol );

  /* */

  function replaceSymbol( sym )
  {
    let r = ( date + Math.random() * 16 ) % 16 | 0;
    date = Math.floor( date / 16 );
    return ( sym === '$' ? r : ( r & 0x3 | 0x8 ) ).toString( 16 );
  }
}

//

var idWithInt = (function()
{

  var counter = 0;

  return function()
  {
    _.assert( arguments.length === 0, 'Expects no arguments' );
    counter += 1;
    return counter;
  }

})();

// --
// declare
// --

var Proto =
{

  // name and symbol

  nameFielded, /* experimental */
  nameUnfielded, /* experimental */
  namesCoded, /* experimental */

  // id

  idWithDate,
  idWithTime,
  idWithGuid,
  idWithTimeGuid,
  idWithInt,

}

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
