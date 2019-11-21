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

function objectLike( t )
{

  async function sync1()
  {
  }

  async function sync2()
  {
  }

  sync2.map = {}
  sync2.array = [];
  sync2.str = 'str';

  async function async1()
  {
  }

  async function async2()
  {
  }

  async2.map = {}
  async2.array = [];
  async2.str = 'str';

  t.description = 'not object-like';

  t.identical( _.objectLike( new ArrayBuffer( 10 ) ), false );
  t.identical( _.objectLike( new Float32Array( 10 ) ), false );
  t.identical( _.objectLike( new Int32Array( 10 ) ), false );
  t.identical( _.objectLike( new DataView( new ArrayBuffer( 10 ) ) ), false );
  t.identical( _.objectLike( new Array( 10 ) ), false );
  t.identical( _.objectLike( [ 1, 2, 3 ] ), false );
  t.identical( _.objectLike( new Map ), false );

  t.identical( _.objectLike( sync1 ), false );
  t.identical( _.objectLike( sync2 ), false );
  t.identical( _.objectLike( async1 ), false );
  t.identical( _.objectLike( async2 ), false );

  t.description = 'object-like';

  t.identical( _.objectLike( _global_ ), true );
  t.identical( _.objectLike( new Object() ), true );
  t.identical( _.objectLike( {} ), true );
  t.identical( _.objectLike( Object.create( null ) ), true );

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

    objectLike,
    promiseIs,
    consequenceLike,
    isPrototypeOf,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
