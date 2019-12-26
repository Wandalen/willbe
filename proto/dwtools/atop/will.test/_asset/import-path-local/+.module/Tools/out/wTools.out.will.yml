( function _Typing_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );
}

var _global = _global_;
var _ = _global_.wTools;

// --
// tests
// --

function nothingIs( test )
{
  test.case = 'without argument';
  var got = _.nothingIs();
  test.identical( got, true );

  test.case = 'check null';
  var got = _.nothingIs( null );
  test.identical( got, true );

  test.case = 'check undefined';
  var got = _.nothingIs( undefined );
  test.identical( got, true );

  test.case = 'check _.nothing';
  var got = _.nothingIs( _.nothing );
  test.identical( got, true );

  test.case = 'check zero';
  var got = _.nothingIs( 0 );
  test.identical( got, false );

  test.case = 'check empty string';
  var got = _.nothingIs( '' );
  test.identical( got, false );

  test.case = 'check false';
  var got = _.nothingIs( false );
  test.identical( got, false );

  test.case = 'check NaN';
  var got = _.nothingIs( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.nothingIs( Symbol() );
  test.identical( got, false );

  test.case = 'check empty array';
  var got = _.nothingIs( [] );
  test.identical( got, false );

  test.case = 'check empty arguments array';
  var got = _.nothingIs( _.argumentsArrayMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty unroll';
  var got = _.nothingIs( _.unrollMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty map';
  var got = _.nothingIs( {} );
  test.identical( got, false );

  test.case = 'check empty pure map';
  var got = _.nothingIs( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check empty Set';
  var got = _.nothingIs( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check empty Map';
  var got = _.nothingIs( new Map( [] ) );
  test.identical( got, false );

  test.case = 'check empty BufferRaw';
  var got = _.nothingIs( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check empty BufferTyped';
  var got = _.nothingIs( new U8x() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.nothingIs( 3 );
  test.identical( got, false );

  test.case = 'check bigInt';
  var got = _.nothingIs( 1n );
  test.identical( got, false );

  test.case = 'check object Number';
  var got = _.nothingIs( new Number( 2 ) );
  test.identical( got, false );

  test.case = 'check string';
  var got = _.nothingIs( 'str' );
  test.identical( got, false );

  test.case = 'check not empty array';
  var got = _.nothingIs( [ null ] );
  test.identical( got, false );

  test.case = 'check not empty map';
  var got = _.nothingIs( { '' : null } );
  test.identical( got, false );

  test.case = 'check instance of contsructor';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.nothingIs( src );
  test.identical( got, false );
}

//

function definedIs( test )
{
  test.case = 'without argument';
  var got = _.definedIs();
  test.identical( got, false );

  test.case = 'check null';
  var got = _.definedIs( null );
  test.identical( got, false );

  test.case = 'check undefined';
  var got = _.definedIs( undefined );
  test.identical( got, false );

  test.case = 'check _.nothing';
  var got = _.definedIs( _.nothing );
  test.identical( got, false );

  test.case = 'check zero';
  var got = _.definedIs( 0 );
  test.identical( got, true );

  test.case = 'check empty string';
  var got = _.definedIs( '' );
  test.identical( got, true );

  test.case = 'check false';
  var got = _.definedIs( false );
  test.identical( got, true );

  test.case = 'check NaN';
  var got = _.definedIs( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.definedIs( Symbol() );
  test.identical( got, true );

  test.case = 'check empty array';
  var got = _.definedIs( [] );
  test.identical( got, true );

  test.case = 'check empty arguments array';
  var got = _.definedIs( _.argumentsArrayMake( [] ) );
  test.identical( got, true );

  test.case = 'check empty unroll';
  var got = _.definedIs( _.unrollMake( [] ) );
  test.identical( got, true );

  test.case = 'check empty map';
  var got = _.definedIs( {} );
  test.identical( got, true );

  test.case = 'check empty pure map';
  var got = _.definedIs( Object.create( null ) );
  test.identical( got, true );

  test.case = 'check empty Set';
  var got = _.definedIs( new Set( [] ) );
  test.identical( got, true );

  test.case = 'check empty Map';
  var got = _.definedIs( new Map( [] ) );
  test.identical( got, true );

  test.case = 'check empty BufferRaw';
  var got = _.definedIs( new BufferRaw() );
  test.identical( got, true );

  test.case = 'check empty BufferTyped';
  var got = _.definedIs( new U8x() );
  test.identical( got, true );

  test.case = 'check number';
  var got = _.definedIs( 3 );
  test.identical( got, true );

  test.case = 'check bigInt';
  var got = _.definedIs( 1n );
  test.identical( got, true );

  test.case = 'check object Number';
  var got = _.definedIs( new Number( 2 ) );
  test.identical( got, true );

  test.case = 'check string';
  var got = _.definedIs( 'str' );
  test.identical( got, true );

  test.case = 'check not empty array';
  var got = _.definedIs( [ null ] );
  test.identical( got, true );

  test.case = 'check not empty map';
  var got = _.definedIs( { '' : null } );
  test.identical( got, true );

  test.case = 'check instance of contsructor';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.definedIs( src );
  test.identical( got, true );
}

//

function primitiveIs( test )
{
  test.case = 'without argument';
  var got = _.primitiveIs();
  test.identical( got, true );

  test.case = 'check null';
  var got = _.primitiveIs( null );
  test.identical( got, true );

  test.case = 'check undefined';
  var got = _.primitiveIs( undefined );
  test.identical( got, true );

  test.case = 'check _.nothing';
  var got = _.primitiveIs( _.nothing );
  test.identical( got, true );

  test.case = 'check zero';
  var got = _.primitiveIs( 0 );
  test.identical( got, true );

  test.case = 'check empty string';
  var got = _.primitiveIs( '' );
  test.identical( got, true );

  test.case = 'check false';
  var got = _.primitiveIs( false );
  test.identical( got, true );

  test.case = 'check NaN';
  var got = _.primitiveIs( NaN );
  test.identical( got, true );

  test.case = 'check Symbol';
  var got = _.primitiveIs( Symbol() );
  test.identical( got, true );

  test.case = 'check empty array';
  var got = _.primitiveIs( [] );
  test.identical( got, false );

  test.case = 'check empty arguments array';
  var got = _.primitiveIs( _.argumentsArrayMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty unroll';
  var got = _.primitiveIs( _.unrollMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty map';
  var got = _.primitiveIs( {} );
  test.identical( got, false );

  test.case = 'check empty pure map';
  var got = _.primitiveIs( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check empty Set';
  var got = _.primitiveIs( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check empty Map';
  var got = _.primitiveIs( new Map( [] ) );
  test.identical( got, false );

  test.case = 'check empty BufferRaw';
  var got = _.primitiveIs( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check empty BufferTyped';
  var got = _.primitiveIs( new U8x() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.primitiveIs( 3 );
  test.identical( got, true );

  test.case = 'check bigInt';
  var got = _.primitiveIs( 1n );
  test.identical( got, true );

  test.case = 'check object Number';
  var got = _.primitiveIs( new Number( 2 ) );
  test.identical( got, true );

  test.case = 'check string';
  var got = _.primitiveIs( 'str' );
  test.identical( got, true );

  test.case = 'check not empty array';
  var got = _.primitiveIs( [ null ] );
  test.identical( got, false );

  test.case = 'check not empty map';
  var got = _.primitiveIs( { '' : null } );
  test.identical( got, false );

  test.case = 'check instance of contsructor';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.primitiveIs( src );
  test.identical( got, false );
}

//

function symbolIs( test )
{
  test.case = 'without argument';
  var got = _.symbolIs();
  test.identical( got, false );

  test.case = 'check null';
  var got = _.symbolIs( null );
  test.identical( got, false );

  test.case = 'check undefined';
  var got = _.symbolIs( undefined );
  test.identical( got, false );

  test.case = 'check _.nothing';
  var got = _.symbolIs( _.nothing );
  test.identical( got, true );

  test.case = 'check zero';
  var got = _.symbolIs( 0 );
  test.identical( got, false );

  test.case = 'check empty string';
  var got = _.symbolIs( '' );
  test.identical( got, false );

  test.case = 'check false';
  var got = _.symbolIs( false );
  test.identical( got, false );

  test.case = 'check NaN';
  var got = _.symbolIs( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.symbolIs( Symbol() );
  test.identical( got, true );

  test.case = 'check empty array';
  var got = _.symbolIs( [] );
  test.identical( got, false );

  test.case = 'check empty arguments array';
  var got = _.symbolIs( _.argumentsArrayMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty unroll';
  var got = _.symbolIs( _.unrollMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty map';
  var got = _.symbolIs( {} );
  test.identical( got, false );

  test.case = 'check empty pure map';
  var got = _.symbolIs( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check empty Set';
  var got = _.symbolIs( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check empty Map';
  var got = _.symbolIs( new Map( [] ) );
  test.identical( got, false );

  test.case = 'check empty BufferRaw';
  var got = _.symbolIs( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check empty BufferTyped';
  var got = _.symbolIs( new U8x() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.symbolIs( 3 );
  test.identical( got, false );

  test.case = 'check bigInt';
  var got = _.symbolIs( 1n );
  test.identical( got, false );

  test.case = 'check object Number';
  var got = _.symbolIs( new Number( 2 ) );
  test.identical( got, false );

  test.case = 'check string';
  var got = _.symbolIs( 'str' );
  test.identical( got, false );

  test.case = 'check not empty array';
  var got = _.symbolIs( [ null ] );
  test.identical( got, false );

  test.case = 'check not empty map';
  var got = _.symbolIs( { '' : null } );
  test.identical( got, false );

  test.case = 'check instance of contsructor';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.symbolIs( src );
  test.identical( got, false );
}

//

function bigIntIs( test )
{
  test.case = 'without argument';
  var got = _.bigIntIs();
  test.identical( got, false );

  test.case = 'check null';
  var got = _.bigIntIs( null );
  test.identical( got, false );

  test.case = 'check undefined';
  var got = _.bigIntIs( undefined );
  test.identical( got, false );

  test.case = 'check _.nothing';
  var got = _.bigIntIs( _.nothing );
  test.identical( got, false );

  test.case = 'check zero';
  var got = _.bigIntIs( 0 );
  test.identical( got, false );

  test.case = 'check empty string';
  var got = _.bigIntIs( '' );
  test.identical( got, false );

  test.case = 'check false';
  var got = _.bigIntIs( false );
  test.identical( got, false );

  test.case = 'check NaN';
  var got = _.bigIntIs( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.bigIntIs( Symbol() );
  test.identical( got, false );

  test.case = 'check empty array';
  var got = _.bigIntIs( [] );
  test.identical( got, false );

  test.case = 'check empty arguments array';
  var got = _.bigIntIs( _.argumentsArrayMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty unroll';
  var got = _.bigIntIs( _.unrollMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty map';
  var got = _.bigIntIs( {} );
  test.identical( got, false );

  test.case = 'check empty pure map';
  var got = _.bigIntIs( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check empty Set';
  var got = _.bigIntIs( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check empty Map';
  var got = _.bigIntIs( new Map( [] ) );
  test.identical( got, false );

  test.case = 'check empty BufferRaw';
  var got = _.bigIntIs( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check empty BufferTyped';
  var got = _.bigIntIs( new U8x() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.bigIntIs( 3 );
  test.identical( got, false );

  test.case = 'check bigInt';
  var got = _.bigIntIs( 1n );
  test.identical( got, true );

  test.case = 'check object Number';
  var got = _.bigIntIs( new Number( 2 ) );
  test.identical( got, false );

  test.case = 'check string';
  var got = _.bigIntIs( 'str' );
  test.identical( got, false );

  test.case = 'check not empty array';
  var got = _.bigIntIs( [ null ] );
  test.identical( got, false );

  test.case = 'check not empty map';
  var got = _.bigIntIs( { '' : null } );
  test.identical( got, false );

  test.case = 'check instance of contsructor';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.bigIntIs( src );
  test.identical( got, false );
}

// --
//
// --

function vectorAdapterIs( test )
{
  test.case = 'without argument';
  var got = _.vectorAdapterIs();
  test.identical( got, false );

  test.case = 'check null';
  var got = _.vectorAdapterIs( null );
  test.identical( got, false );

  test.case = 'check undefined';
  var got = _.vectorAdapterIs( undefined );
  test.identical( got, false );

  test.case = 'check _.nothing';
  var got = _.vectorAdapterIs( _.nothing );
  test.identical( got, false );

  test.case = 'check zero';
  var got = _.vectorAdapterIs( 0 );
  test.identical( got, false );

  test.case = 'check empty string';
  var got = _.vectorAdapterIs( '' );
  test.identical( got, false );

  test.case = 'check false';
  var got = _.vectorAdapterIs( false );
  test.identical( got, false );

  test.case = 'check NaN';
  var got = _.vectorAdapterIs( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.vectorAdapterIs( Symbol() );
  test.identical( got, false );

  test.case = 'check empty array';
  var got = _.vectorAdapterIs( [] );
  test.identical( got, false );

  test.case = 'check empty arguments array';
  var got = _.vectorAdapterIs( _.argumentsArrayMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty unroll';
  var got = _.vectorAdapterIs( _.unrollMake( [] ) );
  test.identical( got, false );

  test.case = 'check empty map';
  var got = _.vectorAdapterIs( {} );
  test.identical( got, false );

  test.case = 'check empty pure map';
  var got = _.vectorAdapterIs( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check empty Set';
  var got = _.vectorAdapterIs( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check empty Map';
  var got = _.vectorAdapterIs( new Map( [] ) );
  test.identical( got, false );

  test.case = 'check empty BufferRaw';
  var got = _.vectorAdapterIs( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check empty BufferTyped';
  var got = _.vectorAdapterIs( new U8x() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.vectorAdapterIs( 3 );
  test.identical( got, false );

  test.case = 'check bigInt';
  var got = _.vectorAdapterIs( 1n );
  test.identical( got, false );

  test.case = 'check object Number';
  var got = _.vectorAdapterIs( new Number( 2 ) );
  test.identical( got, false );

  test.case = 'check string';
  var got = _.vectorAdapterIs( 'str' );
  test.identical( got, false );

  test.case = 'check not empty array';
  var got = _.vectorAdapterIs( [ null ] );
  test.identical( got, false );

  test.case = 'check not empty map';
  var got = _.vectorAdapterIs( { '' : null } );
  test.identical( got, false );

  /* */

  test.case = 'check not empty map';
  var src = Object.create( null );
  src._vectorBuffer = true;
  var got = _.vectorAdapterIs( src );
  test.identical( got, true );

  test.case = 'check not empty map';
  var src = Object.create( null );
  src._vectorBuffer = false;
  var got = _.vectorAdapterIs( src );
  test.identical( got, true );

  test.case = 'check instance of contsructor with not own property "constructor"';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  src._vectorBuffer = true;
  var got = _.vectorAdapterIs( src );
  test.identical( got, true );

  test.case = 'check instance of contsructor with own property "constructor"';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  src.constructor = Constr;
  src._vectorBuffer = true;
  var got = _.vectorAdapterIs( src );
  test.identical( got, false );

  test.case = 'check instance of contsructor prototyped by another instance with _vectorBuffer property';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var proto = new Constr();
  proto._vectorBuffer = true;
  var src = new Constr();
  src.prototype = proto;
  var got = _.vectorAdapterIs( src );
  test.identical( got, false );

  test.case = 'check instance of contsructor prototyped by another instance with _vectorBuffer and own "constructor" properties';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var proto = new Constr();
  proto._vectorBuffer = true;
  proto.constructor = Constr;
  var src = new Constr();
  src.prototype = proto;
  var got = _.vectorAdapterIs( src );
  test.identical( got, false );
}

//

function objectLike( test )
{

  test.description = 'array-like entities should not overlap with array-like entities set';

  test.identical( _.objectLike( new ArrayBuffer( 10 ) ),false );
  test.identical( _.objectLike( new Float32Array( 10 ) ),false );
  test.identical( _.objectLike( new Int32Array( 10 ) ),false );
  test.identical( _.objectLike( new DataView( new ArrayBuffer( 10 ) ) ),false );
  test.identical( _.objectLike( new Array( 10 ) ),false );
  test.identical( _.objectLike( [ 1,2,3 ] ),false );
  test.identical( _.objectLike( new Map ),false );

  test.description = 'this entities are object-like';

  test.identical( _.objectLike( _global_ ),true );
  test.identical( _.objectLike( new Object() ),true );
  test.identical( _.objectLike( {} ),true );
  test.identical( _.objectLike( Object.create( null ) ),true );

}

//

function consequenceLike( test )
{
  test.case = 'check if entity is a consequenceLike';

  if( !_.consequenceLike )
  return test.identical( true, true );

  test.is( !_.consequenceLike() );
  test.is( !_.consequenceLike( {} ) );
  test.is( _.consequenceLike( Promise.resolve( 0 ) ) );

  var promise = new Promise( ( resolve, reject ) => { resolve( 0 ) } )
  test.is( _.consequenceLike( promise ) );

}

//

function promiseIs( test )
{
  test.case = 'check if entity is a Promise';

  test.is( !_.promiseIs() );
  test.is( !_.promiseIs( {} ) );

  var _Promise = function Promise(){};
  test.is( !_.promiseIs( new _Promise() ) );

  test.is( _.promiseIs( Promise.resolve( 0 ) ) );

  var promise = new Promise( ( resolve, reject ) => { resolve( 0 ) } )
  test.is( _.promiseIs( promise ) );
}

//

function isPrototypeOf( test )
{

  test.case = 'map';
  var src = {};
  var got = _.isPrototypeOf( src, src );
  test.identical( got, true );
  var got = _.isPrototypeOf( Object.prototype, src );
  test.identical( got, true );
  var got = _.isPrototypeOf( src, Object.prototype );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, {} );
  test.identical( got, false );
  var got = _.isPrototypeOf( {}, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, Object.create( null ) );
  test.identical( got, false );
  var got = _.isPrototypeOf( Object.create( null ), src );
  test.identical( got, false );
  var got = _.isPrototypeOf( null, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, null );
  test.identical( got, false );

  test.case = 'pure map';
  var src = Object.create( null );
  var got = _.isPrototypeOf( src, src );
  test.identical( got, true );
  var got = _.isPrototypeOf( src, Object.prototype );
  test.identical( got, false );
  var got = _.isPrototypeOf( Object.prototype, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, {} );
  test.identical( got, false );
  var got = _.isPrototypeOf( {}, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, Object.create( null ) );
  test.identical( got, false );
  var got = _.isPrototypeOf( Object.create( null ), src );
  test.identical( got, false );
  var got = _.isPrototypeOf( null, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, null );
  test.identical( got, false );

  test.case = 'map chain';
  var prototype = Object.create( null );
  var src = Object.create( prototype );
  var got = _.isPrototypeOf( src, src );
  test.identical( got, true );
  var got = _.isPrototypeOf( prototype, src );
  test.identical( got, true );
  var got = _.isPrototypeOf( src, prototype );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, Object.prototype );
  test.identical( got, false );
  var got = _.isPrototypeOf( Object.prototype, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, {} );
  test.identical( got, false );
  var got = _.isPrototypeOf( {}, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, Object.create( null ) );
  test.identical( got, false );
  var got = _.isPrototypeOf( Object.create( null ), src );
  test.identical( got, false );
  var got = _.isPrototypeOf( null, src );
  test.identical( got, false );
  var got = _.isPrototypeOf( src, null );
  test.identical( got, false );

}

// --
// declaration
// --

var Self =
{

  name : 'Tools.base.Typing',
  silencing : 1,

  tests :
  {

    nothingIs,
    definedIs,
    primitiveIs,
    symbolIs,
    bigIntIs,

    //

    vectorAdapterIs,

    objectLike,
    consequenceLike,
    promiseIs,

    isPrototypeOf,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
