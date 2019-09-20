(function _Stringer_s_() {

'use strict';

/**
 * Stringer nicely stringifies structures does not matter how complex or cycled them are. Convenient tool for fast diagnostic and inspection of data during development and in production. Use it to see more, faster. Refactoring required.
  @module Tools/base/Stringer
*/

/**
 * @file aStringer.s.
 */

/**
 * Collection of tools for fast diagnostic and inspection of data during development and in production.
  @namespace Tools( module::Stringer )
  @memberof module:Tools/base/Stringer
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

}

//

var Self = _global_.wTools;
var _global = _global_;
var _ = _global_.wTools;

var _ArraySlice = Array.prototype.slice;
var _FunctionBind = Function.prototype.bind;
var _ObjectToString = Object.prototype.toString;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

// var __assert = _.assert;
var _arraySlice = _.longSlice;
var strType = _.strType;

//

/**
 * Short-cut for toStr function that works only with Routine type entities.
 * Converts object passed by argument( src ) to string representation using
 * options provided by argument( o ).
 *
 * @param {object} src - Source object.
 * @param {Object} o - conversion o {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @param {boolean} [ options.onlyRoutines=true ] - makes object behavior Routine only.
 * @see {@link wTools.toStrFine} Check out main function for more usage options and details.
 * @returns {string} Returns string that represents object data.
 *
 * @example
 * //returns { routine add }
 * _.toStrMethods( ( function add(){} ), { } )
 *
 * @example
 * //returns { routine noname }
 * _.toStrMethods( ( function(){} ), { } )
 *
 * @function toStrMethods
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function toStrMethods( src,o )
{
  var o = o || Object.create( null );
  o.onlyRoutines = 1;
  var result = toStrFine( src,o );
  return result;
}

//

/**
 * Short-cut for toStr function that works with all entities, but ingnores Routine type.
 * Converts object passed by argument( src ) to string representation using
 * options provided by argument( o ).
 *
 * @param {object} src - Source object.
 * @param {Object} o - conversion o {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @param {boolean} [ options.noRoutine=false ] - Ignores all entities of type Routine.
 * @see {@link wTools.toStrFine} Check out main function for more usage options and details.
 * @returns {string} Returns string that represents object data.
 *
 * @example
 * //returns [ 0, "a" ]
 * _.toStrFields( [ function del(){}, 0, 'a' ], {} )
 *
 * @example
 * //returns { c : 1, d : "2" }
 * _.toStrFields( { a : function b(){},  c : 1 , d : '2' }, {} )
 *
 * @function toStrFields
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function toStrFields( src,o )
{
  var o = o || Object.create( null );
  o.noRoutine = 1;
  var result = toStrFine( src,o );
  return result;
}

//
/**
* @summary Options object for toStr function.
* @typedef {Object} toStrOptions
* @property {boolean} [ o.wrap=true ] - Wrap array-like and object-like entities
* into "[ .. ]" / "{ .. }" respecitvely.
* @property {boolean} [ o.stringWrapper='\'' ] - Wrap string into specified string.
* @property {boolean} [ o.multilinedString=false ] - Wrap string into backtick ( `` ).
* @property {number} [ o.level=0 ] - Sets the min depth of looking into source object. Function starts from zero level by default.
* @property {number} [ o.levels=1 ] - Restricts max depth of looking into source object. Looks only in one level by default.
* @property {number} [ o.limitElementsNumber=0 ] - Outputs limited number of elements from object or array.
* @property {number} [ o.limitStringLength=0 ] - Outputs limited number of characters from source string.
* @property {boolean} [ o.prependTab=true ] - Prepend tab before first line.
* @property {boolean} [ o.errorAsMap=false ] - Interprets Error as Map if true.
* @property {boolean} [ o.own=true ] - Use only own properties of ( src ), ignore properties of ( src ) prototype.
* @property {string} [ o.tab='' ] - Prepended before each line tab.
* @property {string} [ o.dtab='  ' ] - String attached to ( o.tab ) each time the function parses next level of object depth.
* @property {string} [ o.colon=' : ' ] - Colon between name and value, example : { a : 1 }.
* @property {boolean} [ o.noRoutine=false ] - Ignores all entities of type Routine.
* @property {boolean} [ o.noAtomic=false ] - Ignores all entities of type Atomic.
* @property {boolean} [ o.noArray=false ] - Ignores all entities of type Array.
* @property {boolean} [ o.noObject=false ] - Ignores all entities of type Object.
* @property {boolean} [ o.noRow=false ] - Ignores all entities of type Row.
* @property {boolean} [ o.noError=false ] - Ignores all entities of type Error.
* @property {boolean} [ o.noNumber=false ] - Ignores all entities of type Number.
* @property {boolean} [ o.noString=false ] - Ignores all entities of type String.
* @property {boolean} [ o.noUndefines=false ] - Ignores all entities of type Undefined.
* @property {boolean} [ o.noDate=false ] - Ignores all entities of type Date.
* @property {boolean} [ o.onlyRoutines=false ] - Ignores all entities, but Routine.
* @property {boolean} [ o.onlyEnumerable=true ] - Ignores all non-enumerable properties of object ( src ).
* @property {boolean} [ o.noSubObject=false ] - Ignores all child entities of type Object.
* @property {number} [ o.precision=null ] - An integer specifying the number of significant digits,example : [ '1500' ].
* Number must be between 1 and 21.
* @property {number} [ o.fixed=null ] - The number of digits to appear after the decimal point, example : [ '58912.001' ].
* Number must be between 0 and 20.
* @property {string} [ o.comma=', ' ] - Splitter between elements, example : [ 1, 2, 3 ].
* @property {boolean} [ o.multiline=false ] - Writes each object property in new line.
* @property {boolean} [ o.escaping=false ] - enable escaping of special characters.
* @property {boolean} [ o.jsonLike=false ] - enable conversion to JSON string.
* @property {boolean} [ o.jsLike=false ] - enable conversion to JS string.
* @memberof module:Tools/base/Stringer.Tools( module::Stringer )
*/

/**
 * Converts object passed by argument( src ) to string format using parameters passed
 * by argument( o ).If object ( src ) has own ( toStr ) method defined function uses it for conversion.
 *
 * @param {object} src - Source object for representing it as string.
 * @param {Object} o - conversion o {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {string} Returns string that represents object data.
 *
 * @example
 * //Each time function parses next level of object depth
 * //the ( o.dtab ) string ( '-' ) is attached to ( o.tab ).
 * //returns
 * // { // level 1
 * // -a : 1,
 * // -b : 2,
 * // -c :
 * // -{ // level 2
 * // --subd : "some test",
 * // --sube : true,
 * // --subf : {  x : 1  // level 3}
 * // -}
 * // }
 * _.toStr( { a : 1, b : 2, c : { subd : 'some test', sube : true, subf : { x : 1 } } },{ levels : 3, dtab : '-'} );
 *
 * @example
 * //returns " \n1500 "
 * _.toStr( ' \n1500 ', { escaping : 1 } );
 *
 * @example
 * //returns
 * // "
 * // 1500 "
 * _.toStr( ' \n1500 ' );
 *
 * @example
 * //returns 14.5333
 * _.toStr( 14.5333 );
 *
 * @example
 * //returns 1.50e+3
 * _.toStr( 1500, { precision : 3 } );
 *
 * @example
 * //returns 14.53
 * _.toStr( 14.5333, { fixed : 2 } );
 *
 * @example
 * //returns true
 * _.toStr( 1 !== 2 );
 *
 * @example
 * //returns ''
 * _.toStr( 1 !== 2, { noAtomic :  1 } );
 *
 * @example
 * //returns [ 1, 2, 3, 4 ]
 * _.toStr( [ 1, 2, 3, 4 ] );
 *
 * @example
 * //returns [Array with 3 elements]
 * _.toStr( [ 'a','b','c' ], { levels : 0 } );
 *
 * @example
 * //returns [ 1, 2, 3 ]
 * _.toStr( _.toStr( [ 'a','b','c', 1, 2, 3 ], { levels : 2, noString : 1} ) );
 *
 * @example
 * //returns
 * // [
 * //  { Object with 1 elements },
 * //  { Object with 1 elements }
 * // ]
 * _.toStr( [ { a : 1 }, { b : 2 } ] );
 *
 * @example
 * //returns
 * // "    a : 1
 * //      b : 2"
 * _.toStr( [ { a : 1 }, { b : 2 } ], { levels : 2, wrap : 0 } );
 *
 * @example
 * //returns
 * // [
 * //  { a : 1 },
 * //  { b : 2 }
 * // ]
 * _.toStr( [ { a : 1 }, { b : 2 } ], { levels : 2 } );
 *
 * @example
 * //returns 1 , 2 , 3 , 4
 * _.toStr( [ 1, 2, 3, 4 ], { wrap : 0, comma : ' , ' } );
 *
 * @example
 * //returns [ 0.11, 40 ]
 * _.toStr( [ 0.11112, 40.4 ], { precision : 2 } );
 *
 * @example
 * //returns [ 2.00, 1.56 ]
 * _.toStr( [ 1.9999, 1.5555 ], { fixed : 2 } );
 *
 * @example
 * //returns
 * // [
 * //  0,
 * //  [
 * //   1,
 * //   2,
 * //   3
 * //  ],
 * //  4
 * // ]
 * _.toStr( [ 0, [ 1,2,3 ], 4 ], { levels : 2, multiline : 1 } );
 *
 * @example
 * //returns [ 1, 2, [ other 3 element(s) ] ]
 * _.toStr( [ 1, 2 ,3, 4, 5 ], { limitElementsNumber : 2 } );
 *
 * @example
 * //returns [ routine sample ]
 * _.toStr( function sample( ){ });
 *
 * @example
 * //returns [ rotuine without name ]
 * _.toStr( function add( ){ }, { levels : 0 } );
 *
 * @example
 * //If object ( src ) has own ( toStr ) method defined function uses it for conversion
 * //returns
 * //function func(  ) {
 * //console.log('sample');
 * //}
 * var x = function func (  )
 * {
 *   console.log( 'sample' );
 * }
 * x.toStr = x.toString;
 * _.toStr( x );
 *
 * @example
 * //returns { o : 1, y : 3 }
 * _.toStr( { o : 1, y : 3 } );
 *
 * @example
 * //returns { Object with 1 elements }
 * _.toStr( { o : 1 }, { levels : 0 } );
 *
 * @example
 * //returns
 * {
 *    o : { p : "value" }
 * }
 * _.toStr( { o : { p : 'value' } }, { levels : 2 } );
 *
 * @example
 * //returns
 * // {
 * //   y : "value1"
 * // }
 * _.toStr( { y : 'value1', o : { p : 'value2' } }, { levels : 2, noSubObject : 1} );
 *
 * @example
 * //returns a : 1 | b : 2
 * _.toStr( { a : 1, b : 2 }, { wrap : 0, comma : ' | ' } );
 *
 * @example
 * //returns { b : 1, c : 2 }
 * _.toStr( { a : 'string', b : 1 , c : 2  }, { levels : 2 , noString : 1 } );
 *
 * @example
 * //returns { a : string, b : str, c : 2 }
 * _.toStr( { a : 'string', b : "str" , c : 2  }, { levels : 2 , stringWrapper : '' } );
 *
 * @example
 * //returns { "a" : "string", "b" : 1, "c" : 2 }
 * _.toStr( { a : 'string', b : 1 , c : 2  }, { levels : 2 , jsonLike : 1 } );
 *
 * @example
 * //returns
 * // '{',
 * // '  a : 1, ',
 * // ' b : 2, ',
 * // '{ other 2 element(s) }',
 * // '}',
 * _.toStr( { a : 1, b : 2, c : 3, d : 4 }, { limitElementsNumber : 2 } );
 *
 * @example
 * //returns { stack : "Error: my message2"..., message : "my message2" }
 * _.toStr( new Error('my message2'), { onlyEnumerable : 0, errorAsMap : 1 } );
 *
 * @example
 * //returns
 * // "{
 * //  a : `line1
 * // line2
 * // line3`
 * // }"
 * _.toStr( { a : "line1\nline2\nline3" }, { levels: 2, multilinedString : 1 } );
 *
 * @function toStr
 * @throws { Exception } Throw an exception if( o ) is not a Object.
 * @throws { Exception } Throw an exception if( o.stringWrapper ) is not equal true when ( o.jsonLike ) is true.
 * @throws { Exception } Throw an exception if( o.multilinedString ) is not equal false when ( o.jsonLike ) is true.
 * @throws { RangeError } Throw an exception if( o.precision ) is not between 1 and 21.
 * @throws { RangeError } Throw an exception if( o.fixed ) is not between 0 and 20.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function toStrFine_functor()
{

  var primeFilter =
  {

    noRoutine : 0,
    noAtomic : 0,
    noArray : 0,
    noObject : 0,
    noRow : 0,
    noError : 0,
    noNumber : 0,
    noString : 0,
    noDate : 0,
    noUndefines : 0,

  }

  var composes =
  {

    levels : 1,
    level : 0,

    wrap : 1,
    stringWrapper : '\'',
    keyWrapper : '',
    prependTab : 1,
    errorAsMap : 0,
    own : 1,
    tab : '',
    dtab : '  ',
    colon : ' : ',
    limitElementsNumber : 0,
    limitStringLength : 0,

  }

  /**/

  var optional =
  {

    /* secondary filter */

    noSubObject : 0,
    onlyRoutines : 0,
    onlyEnumerable : 1,

    /**/

    precision : null,
    fixed : null,
    comma : ', ',
    multiline : 0,
    multilinedString : 0,
    escaping : 0,
    jsonLike : 0,
    jsLike : 0,

  }

  var restricts =
  {
    /*level : 0,*/
  }

  Object.preventExtensions( primeFilter );
  Object.preventExtensions( composes );
  Object.preventExtensions( optional );
  Object.preventExtensions( restricts );

  var def;

  /* !!! : remove dependency of prototypeUnitedInterface */
  if( _.prototypeUnitedInterface )
  def = _.prototypeUnitedInterface([ primeFilter,composes,optional ]);
  else
  def = _.mapExtend( null,primeFilter,composes,optional );

  var routine = function toStrFine( src,o )
  {

    _.assert( arguments.length === 1 || arguments.length === 2 );
    _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );

    var o = o || Object.create( null );
    var toStrDefaults = Object.create( null );
    if( !_.primitiveIs( src ) && 'toStr' in src && _.routineIs( src.toStr ) && !src.toStr.notMethod && _.objectIs( src.toStr.defaults ) )
    toStrDefaults = src.toStr.defaults;

    if( o.levels === undefined && ( o.jsonLike || o.jsLike ) )
    o.levels = 1 << 20;

    if( o.jsonLike || o.jsLike )
    {
      if( o.escaping === undefined )
      o.escaping = 1;
      if( o.keyWrapper === undefined )
      o.keyWrapper = '"';
      if( o.stringWrapper === undefined )
      o.stringWrapper = '"';
    }

    if( o.stringWrapper === undefined && o.multilinedString )
    o.stringWrapper = '`';

    _.assertMapHasOnly( o,[ composes,primeFilter,optional ] );
    o = _.mapSupplement( null,o,toStrDefaults,composes,primeFilter );

    if( o.onlyRoutines )
    {
      _.assert( !o.noRoutine,'Expects {-o.noRoutine-} false if( o.onlyRoutines ) is true' );
      for( var f in primeFilter )
      o[ f ] = 1;
      o.noRoutine = 0;
    }

    if( o.comma === undefined )
    o.comma = o.wrap ? optional.comma : ' ';

    if( o.comma && !_.strIs( o.comma ) )
    o.comma = optional.comma;

    if( o.stringWrapper === '`' && o.multilinedString === undefined )
    o.multilinedString = 1;

    _.assert( _.strIs( o.stringWrapper ),'Expects string {-o.stringWrapper-}' );

    if( o.jsonLike )
    {
      _.assert( o.stringWrapper === '"','Expects double quote ( o.stringWrapper ) true if either ( o.jsonLike ) or ( o.jsLike ) is true' );
      _.assert( !o.multilinedString,'Expects {-o.multilinedString-} false if either ( o.jsonLike ) or ( o.jsLike ) is true to make valid JSON' );
    }

    var r = _toStr( src,o );

    return r ? r.text : '';
  }

  routine.defaults = def;
  routine.methods = toStrMethods;
  routine.fields = toStrFields;

  routine.notMethod = 1;

  return routine;
}

//

function toStrShort( src )
{
  _.assert( arguments.length === 1 );
  var result = _.toStr( src, { levels : 0 } );
  return result;
}

//

function _toStr( src,o )
{
  var result = '';
  var simple = 1;
  var type = _.strPrimitiveType( src );

  if( o.level >= o.levels )
  {
    return { text : _toStrShort( src,o ), simple : 1 };
  }

  if( !_toStrIsVisibleElement( src,o ) )
  return;

  var isAtomic = _.primitiveIs( src );
  var isLong = _.longIs( src );
  var isArray = _.arrayIs( src );
  var isObject = !isLong && _.objectIs( src );
  var isObjectLike = !isLong && _.objectLike( src ) && !( 'toString' in src );

  /* */

  // if( src && src.toStr && src.toStr.notMethod )
  // debugger;
  // if( src && src.constructor && src.constructor.name === 'eGdcHeader' )
  // debugger;

  if( !isAtomic && 'toStr' in src && _.routineIs( src.toStr ) && !src.toStr.notMethod && !_ObjectHasOwnProperty.call( src,'constructor' ) )
  {

    var r = src.toStr( o );
    if( _.objectIs( r ) )
    {
      _.assert( r.simple !== undefined && r.text !== undefined );
      simple = r.simple;
      result += r.text;
    }
    else if( _.strIs( r ) )
    {
      simple = r.indexOf( '\n' ) === -1;
      result += r;
    }
    else throw _.err( 'unexpected' );

  }
  else if( _.vectorIs( src ) )
  {
    result += _.vector.toStr( src,o );
  }
  else if( _.errIs( src ) )
  {

    if( !o.errorAsMap )
    {
      result += src.toString();
    }
    else
    {
      if( o.onlyEnumerable === undefined )
      o.onlyEnumerable = 0;
      var r = _toStrFromObject( src,o );
      result += r.text;
      simple = r.simple;
    }

  }
  else if( type === 'Function' )
  {
    result += _toStrFromRoutine( src,o );
  }
  else if( type === 'Number' )
  {
    result += _toStrFromNumber( src,o );
  }
  else if( type === 'BigInt' )
  {
    result += _toStrFromBigInt( src,o );
  }
  else if( type === 'String' )
  {
    result += _toStrFromStr( src,o );
  }
  else if( type === 'Date' )
  {
    if( o.jsonLike )
    result += '"' + src.toISOString() + '"';
    else if( o.jsLike )
    result += 'new Date( \'' + src.toISOString() + '\' )';
    else
    result += src.toISOString();
  }
  else if( _.bufferRawIs( src ) )
  {
    var r = _toStrFromBufferRaw( src,o );
    result += r.text;
    simple = r.simple;
  }
  else if( _.bufferTypedIs( src ) )
  {
    var r = _toStrFromBufferTyped( src,o );
    result += r.text;
    simple = r.simple;
  }
  else if( _.bufferNodeIs( src ) )
  {
    var r = _toStrFromBufferNode( src,o );
    result += r.text;
    simple = r.simple;
  }
  else if( isLong )
  {
    var r = _toStrFromArray( src,o );
    result += r.text;
    simple = r.simple;
  }
  else if( isObject )
  {
    var r = _toStrFromObject( src,o );
    result += r.text;
    simple = r.simple;
  }
  else if( type === 'Map' )
  {
    var r = _toStrFromHashMap( src,o );
    result += r.text;
    simple = r.simple;
  }
  else if( !isAtomic && _.routineIs( src.toString ) )
  {
    result += src.toString();
  }
  else
  {
    if( o.jsonLike )
    {
      if( src === undefined || src === NaN )
      result += 'null';
      else
      result += String( src );
    }
    else
    {
      result += String( src );
    }
  }

  return { text : result, simple };
}

//

/**
 * Converts object passed by argument( src ) to string representation using
 * options provided by argument( o ) for string and number types.
 * Returns string with object type for routines and errors, iso format for date, string representation for atomic.
 * For object,array and row returns count of elemets, example: '[ Row with 3 elements ]'.
 *
 * @param {object} src - Source object.
 * @param {Object} o - Conversion options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {string} Returns string that represents object data.
 *
 * @example
 * //returns [ Array with 3 elements ]
 * _._toStrShort( [ function del(){}, 0, 'a' ], { levels : 0 } )
 *
 * @function _toStrShort
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function _toStrShort( src,o )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( o ),'Expects map {-o-}' );

  var result = '';

  try
  {

    if( _.vectorIs( src ) )
    {
      result += '[ Row with ' + src.length + ' elements' + ' ]';
    }
    else if( _.errIs( src ) )
    {
      result += _ObjectToString.call( src );
    }
    else if( _.routineIs( src ) )
    {
      result += _toStrFromRoutine( src,o );
    }
    else if( _.numberIs( src ) )
    {
      result += _toStrFromNumber( src,o );
    }
    else if( _.strIs( src ) )
    {

      var optionsStr =
      {
        limitStringLength : o.limitStringLength ? Math.min( o.limitStringLength,40 ) : 40,
        stringWrapper : o.stringWrapper,
        escaping : 1,
      }

      result = _toStrFromStr( src,optionsStr );

    }
    else if( src && !_.objectIs( src ) && _.numberIs( src.length ) )
    {

      result += '[ ' + strType( src ) + ' with ' + src.length + ' elements ]';

    }
    else if( src instanceof Date )
    {
      result += src.toISOString();
    }
    else if( _.objectLike( src ) )
    {

      if( _.routineIs( src.infoExport ) )
      result += src.infoExport({ verbosity : 1 });
      else
      result += '[ ' + strType( src ) + ' with ' + _.entityLength( src ) + ' elements' + ' ]';

    }
    else
    {
      result += String( src );
    }

  }
  catch( err )
  {
    result = String( err );
  }

  return result;
}

//

/**
 * Checks if object provided by argument( src ) must be ignored by toStr() function.
 * Filters are provided by argument( o ).
 * Returns false if object must be ignored.
 *
 * @param {object} src - Source object.
 * @param {Object} o - Filters {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {boolean} Returns result of filter check.
 *
 * @example
 * //returns false
 * _.toStrIsVisibleElement( function del(){}, { noRoutine : 1 } );
 *
 * @function _toStrIsVisibleElement
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function _toStrIsVisibleElement( src,o )
{

  var isAtomic = _.primitiveIs( src );
  var isArray = _.longIs( src );
  var isObject = !isArray && _.objectLike( src );
  var type = _.strPrimitiveType( src );

  /* */

  if( !isAtomic && 'toStr' in src && _.routineIs( src.toStr ) && !src.toStr.notMethod )
  {
    if( isObject && o.noObject )
    return false;
    if( isArray && o.noArray )
    return false;

    return true;
  }
  else if( _.vectorIs( src ) )
  {
    if( o.noRow )
    return false;
    return true;
  }
  else if( _.errIs( src ) )
  {
    if( o.noError )
    return false;
    return true;
  }
  else if( type === 'Function' )
  {
    if( o.noRoutine )
    return false;
    return true;
  }
  else if( type === 'Number' )
  {
    if( o.noNumber || o.noAtomic )
    return false;
    return true;
  }
  else if( type === 'String' )
  {
    if( o.noString || o.noAtomic  )
    return false;
    return true;
  }
  else if( type === 'Date' )
  {
    if( o.noDate )
    return false;
    return true;
  }
  else if( isArray )
  {
    if( o.noArray )
    return false;

    if( !o.wrap )
    {
      src = _toStrFromArrayFiltered( src,o );
      if( !src.length )
      return false;
    }

    return true;
  }
  else if( isObject )
  {
    if( o.noObject )
    return false;

    if( !o.wrap )
    {
      var keys = _toStrFromObjectKeysFiltered( src,o );
      if( !keys.length )
      return false;
    }

    return true;
  }
  else if( !isAtomic && _.routineIs( src.toString ) )
  {
    if( isObject && o.noObject )
    return false;
    if( isArray && o.noArray )
    return false;
    return true;
  }
  else
  {
    if( o.noAtomic )
    return false;
    if( o.noUndefines && src === undefined )
    return false;
    return true;
  }

}

//

/**
 * Checks if object length provided by argument( element ) is enough to represent it as single line string.
 * Options are provided by argument( o ).
 * Returns true if object can be represented as one line.
 *
 * @param {object} element - Source object.
 * @param {Object} o - Check options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @param {boolean} [ o.escaping=false ] - enable escaping of special characters.
 * @returns {boolean} Returns result of length check.
 *
 * @example
 * //returns true
 * _.toStrIsSimpleElement( 'string', { } );
 *
 * @example
 * //returns false
 * _.toStrIsSimpleElement( { a : 1, b : 2, c : 3, d : 4, e : 5 }, { } );
 *
 * @function _toStrIsSimpleElement
 * @throws { Exception } Throw an exception if( arguments.length ) is not equal 2.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function _toStrIsSimpleElement( element,o )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );

  if( _.strIs( element ) )
  {
    if( element.length > 40 )
    return false;
    if( !o.escaping )
    return element.indexOf( '\n' ) === -1;
    return true;
  }
  else if( element && !_.objectIs( element ) && _.numberIs( element.length ) )
  return !element.length;
  else if( _.objectIs( element ) || _.objectLike( element ) )
  return !_.entityLength( element );
  else
  return _.primitiveIs( element );

}

//

/**
 * Returns string representation of routine provided by argument( src ) using options
 * from argument( o ).
 *
 * @param {object} src - Source object.
 * @param {Object} o - conversion options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {string} Returns routine as string.
 *
 * @example
 * //returns [ routine a ]
 * _.toStrFromRoutine( function a(){}, {} );
 *
 * @function _toStrFromRoutine
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function _toStrFromRoutine( src,o )
{
  var result = '';

  // debugger;
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.routineIs( src ),'Expects routine {-src-}' );

  if( o.jsLike )
  {
    if( _.routineSourceGet )
    result = _.routineSourceGet( src );
    else
    result = src.toString();
  }
  else
  {
    result = '[ routine ' + ( src.name || src._name || 'without name' ) + ' ]';
  }

  return result;
}

//

/**
 * Converts Number( src ) to String using one of two possible options: precision or fixed.
 * If no option specified returns source( src ) as simple string.
 *
 * @param {Number} src - Number to convert.
 * @param {Object} o - Contains conversion options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {String} Returns number converted to the string.
 *
 * @example
 * //returns 8.9
 * _._toStrFromNumber( 8.923964453, { precision : 2 } );
 *
 * @example
 * //returns 8.9240
 * _._toStrFromNumber( 8.923964453, { fixed : 4 } );
 *
 * @example
 * //returns 8.92
 * _._toStrFromNumber( 8.92, { } );
 *
 * @function _toStrFromNumber
 * @throws {Exception} If no arguments provided.
 * @throws {Exception} If( src ) is not a Number.
 * @throws {Exception} If( o ) is not a Object.
 * @throws {RangeError} If( o.precision ) is not between 1 and 21.
 * @throws {RangeError} If( o.fixed ) is not between 0 and 20.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
*/

function _toStrFromNumber( src,o )
{
  var result = '';

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.numberIs( src ) && _.objectIs( o ) );

  if( _.numberIs( o.precision ) )
  result += src.toPrecision( o.precision );
  else if( _.numberIs( o.fixed ) )
  result += src.toFixed( o.fixed );
  else
  result += String( src );

  if( Object.is( src, -0 ) )
  result = '-' + result;

  return result;
}

//

function _toStrFromBigInt( src,o )
{
  let result = '';

  if( o.jsonLike )
  result += '"' + src.toString() + 'n"';
  else if( o.jsLike )
  result += src.toString() + 'n';
  else
  result += String( src );

  return result;
}

//

/**
 * Adjusts source string. Takes string from argument( src ) and options from argument( o ).
 * Limits string length using option( o.limitStringLength ), disables escaping characters using option( o.escaping ),
 * wraps source into specified string using( o.stringWrapper ).
 * Returns result as new string or source string if no changes maded.
 *
 * @param {object} src - String to parse.
 * @param {Object} o - Contains conversion  options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {String} Returns result of adjustments as new string.
 *
 * @example
 * //returns "hello"
 * _._toStrFromStr( 'hello', {} );
 *
 * @example
 * //returns "test\n"
 * _._toStrFromStr( 'test\n', { escaping : 1 } );
 *
 * @example
 * //returns [ "t" ... "t" ]
 * _._toStrFromStr( 'test', { limitStringLength: 2 } );
 *
 * @example
 * //returns `test`
 * _._toStrFromStr( 'test', { stringWrapper : '`' } );
 *
 * @function _toStrFromStr
 * @throws {Exception} If no arguments provided.
 * @throws {Exception} If( src ) is not a String.
 * @throws {Exception} If( o ) is not a Object.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
*/

function _toStrFromStr( src,o )
{
  var result = '';

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.strIs( src ), 'Expects string {-src-}'  );
  _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );

  //var q = o.multilinedString ? '`' : o.stringWrapper;
  var q = o.stringWrapper;

  if( o.limitStringLength )
  {
    result = _.strStrShort({ src, limit : o.limitStringLength, wrap : q, escaping : 1 });
    if( result.length > o.limitStringLength )
    {
      result = '[ ' + result + ' ]';
      q = '';
    }
  }
  else if( o.escaping )
  {
    result = _.strEscape({ src, stringWrapper : o.stringWrapper });
  }
  else
  {
    result = src;
  }

  if( o.stringWrapper )
  {
    result = q + result + q;
  }

  return result;
}

//

function _toStrFromHashMap( src,o )
{
  var result = '';
  var simple = 0;

  // throw _.err( 'not implemented' );
  _.assert( src instanceof Map ); debugger;

  src.forEach( function( e,k )
  {
    result += '\n' + k + ' : ' + e;
  });

  return { text : result, simple : 0 };

  /* item options */

  var optionsItem = _.mapExtend( null,o );
  optionsItem.noObject = o.noSubObject ? 1 : optionsItem.noObject;
  optionsItem.tab = o.tab + o.dtab;
  optionsItem.level = o.level + 1;
  optionsItem.prependTab = 0;

  /* get names */

  var keys = _toStrFromObjectKeysFiltered( src,o );

  /* empty case */

  var length = keys.length;
  if( length === 0 )
  {
    if( !o.wrap )
    return { text : '', simple : 1 };
    return { text : '{}', simple : 1 };
  }

  /* is simple */

  var simple = !optionsItem.multiline;
  if( simple )
  simple = length < 4;
  if( simple )
  for( var k in src )
  {
    simple = _toStrIsSimpleElement( src[ k ],optionsItem );
    if( !simple )
    break;
  }

  /* */

  result += _toStrFromContainer
  ({
    values : src,
    names : keys,
    optionsContainer : o,
    optionsItem,
    simple,
    prefix : '{',
    postfix : '}',
  });

  return { text : result, simple };
}

//

function _toStrFromBufferTyped( src, o )
{
  var result = '';

  _.assert( _.bufferTypedIs( src ) );

  src.forEach( function( e,k )
  {
    if( k !== 0 )
    result += ',';
    result += _toStrFromNumber( e, o );
  });

  result = '( new ' + src.constructor.name + '([ ' + result + ' ]) )';

  return { text : result, simple : true };
}

//

function _toStrFromBufferRaw( src, o )
{
  var result = '';

  _.assert( _.bufferRawIs( src ) );

  ( new Uint8Array( src ) ).forEach( function( e,k )
  {
    if( k !== 0 )
    result += ',';
    result += '0x' + e.toString( 16 );
  });

  result = '( new Uint8Array([ ' + result + ' ]) ).buffer';

  return { text : result, simple : true };
}

//

function _toStrFromBufferNode( src, o )
{
  var result = '';

  _.assert( _.bufferNodeIs( src ) );

  let k = 0;
  for ( let value of src.values() )
  {
    if( k !== 0 )
    result += ',';
    result += value;
    ++k;
  }

  result = '( Buffer.from([ ' + result + ' ]) )';

  return { text : result, simple : true };
}

//

function _toStrFromArrayFiltered( src,o )
{
  var result = '';

  _.assert( arguments.length === 2 );

  /* item options */

  var optionsItem = _.mapExtend( null,o );
  optionsItem.level = o.level + 1;

  /* filter */

  var v = 0;
  var length = src.length;
  for( var i = 0 ; i < length ; i++ )
  {
    v += !!_toStrIsVisibleElement( src[ i ],optionsItem );
  }

  if( v !== length )
  {
    var i2 = 0;
    var i = 0;
    var src2 = _.longMake( src,v );
    while( i < length )
    {
      if( _toStrIsVisibleElement( src[ i ],optionsItem ) )
      {
        src2[ i2 ] = src[ i ];
        i2 += 1;
      }
      i += 1;
    }
    src = src2;
    length = src.length;
  }

  return src;
}

//

/**
 * Converts array provided by argument( src ) into string representation using options provided by argument( o ).
 *
 * @param {object} src - Array to convert.
 * @param {Object} o - Contains conversion options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {String} Returns string representation of array.
 *
 * @example
 * //returns
 * //[
 * //  [ Object with 1 elements ],
 * //  [ Object with 1 elements ]
 * //]
 * _.toStrFromArray( [ { a : 1 }, { b : 2 } ], {} );
 *
 * @example
 * //returns
 * // [
 * //   1,
 * //   [
 * //     2,
 * //     3,
 * //     4'
 * //   ],
 * //   5
 * // ]
 * _.toStrFromArray( [ 1, [ 2, 3, 4 ], 5 ], { levels : 2, multiline : 1 } );
 *
 * @function _toStrFromArray
 * @throws { Exception } If( src ) is undefined.
 * @throws { Exception } If no arguments provided.
 * @throws { Exception } If( o ) is not a Object.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function _toStrFromArray( src,o )
{
  var result = '';

  _.assert( arguments.length === 2 );
  _.assert( src && _.numberIs( src.length ) );
  _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );


  if( o.level >= o.levels )
  {
    return { text : _toStrShort( src,o ), simple : 1 };
  }

  /* item options */

  var optionsItem = _.mapExtend( null,o );
  optionsItem.tab = o.tab + o.dtab;
  optionsItem.level = o.level + 1;
  optionsItem.prependTab = 0;

  /* empty case */

  if( src.length === 0 )
  {
    if( !o.wrap )
    return { text : '', simple : 1 };
    return { text : '[]', simple : 1 };
  }

  /* filter */

  src = _toStrFromArrayFiltered( src,o );

  /* is simple */

  var length = src.length;
  var simple = !optionsItem.multiline;
  if( simple )
  for( var i = 0 ; i < length ; i++ )
  {
    simple = _toStrIsSimpleElement( src[ i ],optionsItem );;
    if( !simple )
    break;
  }

  /* */

  result += _toStrFromContainer
  ({
    values : src,
    optionsContainer : o,
    optionsItem,
    simple,
    prefix : '[',
    postfix : ']',
  });

  return { text : result, simple };
}

//

/**
 * Builds string representation of container structure using options from
 * argument( o ). Takes keys from option( o.names ) and values from option( o.values ).
 * Wraps array-like and object-like entities using ( o.prefix ) and ( o.postfix ).
 *
 * @param {object} o - Contains data and options.
 * @param {object} [ o.values ] - Source object that contains values.
 * @param {array} [ o.names ] - Source object keys.
 * @param {string} [ o.prefix ] - Denotes begin of container.
 * @param {string} [ o.postfix ] - Denotes end of container.
 * @param {Object} o.optionsContainer - Options for container {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @param {Object} o.optionsItem - Options for item {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {String} Returns string representation of container.
 *
 * @function _toStrFromContainer
 * @throws { Exception } If no argument provided.
 * @throws { Exception } If( o ) is not a Object.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
 */

function _toStrFromContainer( o )
{
  var result = '';

  _.assert( arguments.length );
  _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );
  _.assert( _.arrayIs( o.names ) || !o.names );

  var values = o.values;
  var names = o.names;
  var optionsContainer = o.optionsContainer;
  var optionsItem = o.optionsItem;

  var simple = o.simple;
  var prefix = o.prefix;
  var postfix = o.postfix;
  var limit = optionsContainer.limitElementsNumber;
  var l = ( names ? names.length : values.length );

  if( limit > 0 && limit < l )
  {
    debugger;
    l = limit;
    optionsContainer.limitElementsNumber = 0;
  }

  /* line postfix */

  var linePostfix = '';
  if( optionsContainer.comma )
  linePostfix += optionsContainer.comma;

  if( !simple )
  {
    linePostfix += '\n' + optionsItem.tab;
  }

  /* prepend */

  if( optionsContainer.prependTab  )
  {
    result += optionsContainer.tab;
  }

  /* wrap */

  if( optionsContainer.wrap )
  {
    result += prefix;
    if( simple )
    {
      if( l )
      result += ' ';
    }
    else
    {
      result += '\n' + optionsItem.tab;
    }
  }
  else if( !simple )
  {
    /*result += '\n' + optionsItem.tab;*/
  }

  /* exec */

  var r;
  var written = 0;
  for( var n = 0 ; n < l ; n++ )
  {

    _.assert( optionsItem.tab === optionsContainer.tab + optionsContainer.dtab );
    _.assert( optionsItem.level === optionsContainer.level + 1 );

    // if( _global.gc )
    // _global.gc();
    // else
    // xxx;
    // console.log( _.process.memoryUsageInfo() );

    if( names )
    r = _toStr( values[ names[ n ] ],optionsItem );
    else
    r = _toStr( values[ n ],optionsItem );

    _.assert( _.objectIs( r ) && _.strIs( r.text ) );
    _.assert( optionsItem.tab === optionsContainer.tab + optionsContainer.dtab );

    if( written > 0 )
    {
      result += linePostfix;
    }
    else if( !optionsContainer.wrap )
    if( !names || !simple )
    //if( !simple )
    {
      result += optionsItem.dtab;
    }

    if( names )
    {
      if( optionsContainer.keyWrapper )
      result += optionsContainer.keyWrapper + String( names[ n ] ) + optionsContainer.keyWrapper + optionsContainer.colon;
      else
      result += String( names[ n ] ) + optionsContainer.colon;

      if( !r.simple )
      result += '\n' + optionsItem.tab;
    }

    if( r.text )
    {
      result += r.text;
      written += 1;
    }

  }

  /* other */

  function other( length )
  {
    debugger;
    return linePostfix + '[ ... other '+ ( length - l ) +' element(s) ]';
  }

  // if( names && l < names.length )
  // result += other( names.length );
  // else if( l < names.length )
  // result += other( names.length );

  /* wrap */

  if( optionsContainer.wrap )
  {
    if( simple )
    {
      if( l )
      result += ' ';
    }
    else
    {
      result += '\n' + optionsContainer.tab;
    }
    result += postfix;
  }

  return result;
}

//

function _toStrFromObjectKeysFiltered( src,o )
{
  var result = '';

  _.assert( arguments.length === 2 );

  /* item options */

  var optionsItem = _.mapExtend( null,o );
  optionsItem.noObject = o.noSubObject ? 1 : optionsItem.noObject;

  /* get keys */

  var keys = _._mapKeys
  ({
    srcMap : src,
    own : o.own,
    enumerable : o.onlyEnumerable || o.onlyEnumerable === undefined || false,
  });

  /* filter */

  for( var n = 0 ; n < keys.length ; n++ )
  {
    if( !_toStrIsVisibleElement( src[ keys[ n ] ],optionsItem ) )
    {
      keys.splice( n,1 );
      n -= 1;
    }
  }

  return keys;
}

//

/**
 * Converts object provided by argument( src ) into string representation using options provided by argument( o ).
 *
 * @param {object} src - Object to convert.
 * @param {Object} o - Contains conversion options {@link module:Tools/base/Stringer.Tools( module::Stringer ).toStrOptions}.
 * @returns {String} Returns string representation of object.
 *
 * @example
 * //returns
 * // {
 * //  r : 9,
 * //  t : { a : 10 },
 * //  y : 11
 * // }
 * _.toStrFromObject( { r : 9, t : { a : 10 }, y : 11 }, { levels : 2 } );
 *
 * @example
 * //returns ''
 * _.toStrFromObject( { h : { d : 1 }, g : 'c', c : [2] }, { levels : 2, noObject : 1 } );
 *
 * @function _toStrFromObject
 * @throws { Exception } If( src ) is not a object-like.
 * @throws { Exception } If not all arguments provided.
 * @throws { Exception } If( o ) is not a Object.
 * @memberof module:Tools/base/Stringer.Tools( module::Stringer )
 *
*/

function _toStrFromObject( src,o )
{
  var result = '';

  _.assert( arguments.length === 2 );
  _.assert( _.objectLike( src ) );
  _.assert( _.objectIs( o ) || o === undefined,'Expects map {-o-}' );


  if( o.level >= o.levels )
  {
    return { text : _toStrShort( src,o ), simple : 1 };
  }

  if( o.noObject )
  return;

  /* item options */

  var optionsItem = _.mapExtend( null,o );
  optionsItem.noObject = o.noSubObject ? 1 : optionsItem.noObject;
  optionsItem.tab = o.tab + o.dtab;
  optionsItem.level = o.level + 1;
  optionsItem.prependTab = 0;

  /* get names */

  var keys = _toStrFromObjectKeysFiltered( src,o );

  /* empty case */

  var length = keys.length;
  if( length === 0 )
  {
    if( !o.wrap )
    return { text : '', simple : 1 };
    return { text : '{}', simple : 1 };
  }

  /* is simple */

  var simple = !optionsItem.multiline;
  if( simple )
  simple = length < 4;
  if( simple )
  for( var k in src )
  {
    simple = _toStrIsSimpleElement( src[ k ],optionsItem );
    if( !simple )
    break;
  }

  /* */

  result += _toStrFromContainer
  ({
    values : src,
    names : keys,
    optionsContainer : o,
    optionsItem,
    simple,
    prefix : '{',
    postfix : '}',
  });

  return { text : result, simple };
}

//

function toJson( src,o )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  o = _.routineOptions( toJson, o );

  if( o.cloning )
  src = _.cloneData({ src });

  delete o.cloning;

  var result = _.toStr( src,o );

  return result;
}

toJson.defaults =
{
  jsonLike : 1,
  levels : 1 << 20,
  cloning : 1,
}

//

function toJs( src,o )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  o = _.routineOptions( toJs, o );

  var result = _.toStr( src,o );

  return result;
}

toJs.defaults =
{
  escaping : 1,
  multilinedString : 1,
  levels : 1 << 20,
  stringWrapper : '`',
  keyWrapper : '"',
  jsLike : 1,
}

//

function toStrNice( src, o )
{
  _.assert( arguments.length === 1 || arguments.length === 2 );

  o = _.routineOptions( toStrNice, o );

  var result = _.toStr( src, o );

  return result;
}

toStrNice.defaults =
{
  escaping : 0,
  multilinedString : 0,
  multiline : 1,
  levels : 9,
  stringWrapper : '',
  keyWrapper : '',
  wrap : 0
}

// --
// declare
// --

var Proto =
{

  toStrMethods,
  toStrFields,

  toStrFine_functor,
  toStrShort,

  _toStr,
  _toStrShort,

  _toStrIsVisibleElement,
  _toStrIsSimpleElement,

  _toStrFromRoutine,
  _toStrFromNumber,
  _toStrFromBigInt,
  _toStrFromStr,

  _toStrFromHashMap,

  _toStrFromBufferRaw,
  _toStrFromBufferNode,
  _toStrFromBufferTyped,

  _toStrFromArrayFiltered,
  _toStrFromArray,

  _toStrFromContainer,

  _toStrFromObjectKeysFiltered,
  _toStrFromObject,

  toJson,
  toJs,
  toStrNice,

  Stringer : 1,

}

_.mapExtend( Self, Proto );

//

var toStrFine = Self.toStrFine = Self.toStrFine_functor();
var toStr = Self.toStr = Self.strFrom = toStrFine;

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
