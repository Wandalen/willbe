( function _Entity_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );

  try
  {
    _.include( 'wLooker' );
  }
  catch( err )
  {
  }

}

var _global = _global_;
var _ = _global_.wTools;
var Self = {};

// --
// tests
// --

function entityMakeConstructing( test )
{
  test.case = 'null';
  var got = _.entityMakeConstructing( null );
  test.identical( got, null );

  test.case = 'undefined';
  var got = _.entityMakeConstructing( undefined );
  test.identical( got, undefined );

  test.case = 'zero';
  var got = _.entityMakeConstructing( 0 );
  test.identical( got, 0 );

  test.case = 'number';
  var got = _.entityMakeConstructing( 3 );
  test.identical( got, 3 );

  test.case = 'bigInt';
  var got = _.entityMakeConstructing( 1n );
  test.identical( got, 1n );

  test.case = 'empty string';
  var got = _.entityMakeConstructing( '' );
  test.identical( got, '' );

  test.case = 'string';
  var got = _.entityMakeConstructing( 'str' );
  test.identical( got, 'str' );

  test.case = 'false';
  var got = _.entityMakeConstructing( false );
  test.identical( got, false );

  test.case = 'NaN';
  var got = _.entityMakeConstructing( NaN );
  test.identical( got, NaN );

  test.case = 'Symbol';
  var src = Symbol();
  var got = _.entityMakeConstructing( src );
  test.identical( got, src );

  test.case = '_.null';
  var got = _.entityMakeConstructing( _.null );
  test.identical( got, null );

  test.case = '_.undefined';
  var got = _.entityMakeConstructing( _.undefined );
  test.identical( got, undefined );

  test.case = '_.nothing';
  var got = _.entityMakeConstructing( _.nothing );
  test.identical( got, _.nothing );

  test.case = 'empty array';
  var got = _.entityMakeConstructing( [] );
  test.identical( got, [] );

  test.case = 'empty array, length';
  var got = _.entityMakeConstructing( [], 4 );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );

  test.case = 'not empty array';
  var got = _.entityMakeConstructing( [ null, undefined, 1, 2 ] );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );

  test.case = 'not empty array, length';
  var got = _.entityMakeConstructing( [ null, undefined, 1, 2 ], 2 );
  test.identical( got, [ undefined, undefined ] );

  // test.case = 'empty arguments array';
  // var got = _.entityMakeConstructing( _.argumentsArrayMake( [] ) );
  // test.identical( got, [] );
  // test.is( _.arrayIs( got ) );
  //
  // test.case = 'empty arguments array, length';
  // var got = _.entityMakeConstructing( _.argumentsArrayMake( [] ), 4 );
  // test.identical( got, [ undefined, undefined, undefined, undefined ] );
  // test.is( _.arrayIs( got ) );
  //
  // test.case = 'not empty argumentsArray';
  // var got = _.entityMakeConstructing( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
  // test.identical( got, [ null, undefined, 1, 2 ] );
  // test.is( _.arrayIs( got ) );
  //
  // test.case = 'not empty argumentsArray, length';
  // var got = _.entityMakeConstructing( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ), 2 );
  // test.identical( got, [ null, undefined ] );
  // test.is( _.arrayIs( got ) );

  test.case = 'empty unroll';
  var got = _.entityMakeConstructing( _.unrollMake( [] ) );
  test.identical( got, [] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'empty unroll, length';
  var got = _.entityMakeConstructing( _.unrollMake( [] ), 4 );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'not empty unroll';
  var got = _.entityMakeConstructing( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
  test.identical( got, [ null, undefined, 1, 2 ] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'not empty unroll, length';
  var got = _.entityMakeConstructing( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ), 2 );
  test.identical( got, [ null, undefined ] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  // test.case = 'BufferTyped';
  // var got = _.entityMakeConstructing( new U8x( 10 ) );
  // test.identical( got, new U8x( 10 ) );
  //
  // test.case = 'BufferTyped, length';
  // var got = _.entityMakeConstructing( new U8x( 10 ), 4 );
  // test.identical( got, new U8x( 4 ) );

  test.case = 'empty map';
  var got = _.entityMakeConstructing( {} );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty map, length';
  var got = _.entityMakeConstructing( {}, 4 );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'not empty map';
  var got = _.entityMakeConstructing( { '' : null } );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'not empty map, length';
  var got = _.entityMakeConstructing( { '' : null }, 4 );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty pure map';
  var got = _.entityMakeConstructing( Object.create( null ) );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty pure map, length';
  var got = _.entityMakeConstructing( Object.create( null ) );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'instance of constructor';
  var Constr = function( src )
  {
    this.x = src || 1;
    return this;
  };
  var src = new Constr( 2 );
  var got = _.entityMakeConstructing( src );
  test.identical( got, new Constr() );

  test.case = 'instance of constructor, length';
  var Constr = function( src )
  {
    this.x = src || 1;
    return this;
  };
  var src = new Constr( 2 );
  var got = _.entityMakeConstructing( src, 2 );
  test.identical( got, new Constr() );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityMakeConstructing() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.entityMakeConstructing( [], 1, 1 ) );

  test.case = 'unknown type of entity';
  test.shouldThrowErrorSync( () => _.entityMakeConstructing( new Set( [ 1, 'str', false ] ) ) );
  test.shouldThrowErrorSync( () => _.entityMakeConstructing( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) ) );
  test.shouldThrowErrorSync( () => _.entityMakeConstructing( new BufferRaw() ) );
}

//

function entityMakeConstructingArgumentsArray( test )
{
  test.case = 'src = empty long, not ins';
  var src = _.argumentsArrayMake( [] );
  var got = _.entityMakeConstructing( src );
  var expected = _.longDescriptor.make( [] );
  test.identical( got, expected );

  test.case = 'src = long, not ins';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.entityMakeConstructing( src );
  var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = null';
  var src = _.argumentsArrayMake( [] );
  var got = _.entityMakeConstructing( src, null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = number';
  var src = _.argumentsArrayMake( [] );
  var got = _.entityMakeConstructing( src, 2 );
  var expected = _.longDescriptor.make( 2 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.entityMakeConstructing( src, 2 );
  var expected = _.longDescriptor.make( [ 1, 2 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long with an element, ins = empty array';
  var src = new F64x( 10 );
  var got = _.entityMakeConstructing( src, [] );
  var expected = new F64x( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins > src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.entityMakeConstructing( src, 4 );
  var expected = _.longDescriptor.make( [ 1, 2, 3, undefined ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length > src.length';
  var src = _.argumentsArrayMake( [ 0, 1 ] );
  var ins = [ 1, 2, 3 ];
  var got = _.entityMakeConstructing( src, ins );
  var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
  test.identical( got, expected );
  test.is( got !== ins );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length === src.length'
  var src = _.argumentsArrayMake( 5 );
  var ins = [ 1, 2, 3, 4, 5 ];
  var got = _.entityMakeConstructing( src, ins );
  var expected = _.longDescriptor.make( [ 1, 2, 3, 4, 5 ] );
  test.identical( got, expected );
  test.is( got !== src );
}

//

function entityMakeConstructingBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    U16x,
    F32x,
  ];

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    testRun( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function testRun( long )
  {
    test.case = 'src = empty long, not ins';
    var src = new long( [] );
    var got = _.entityMakeConstructing( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new long( [ 1, 2, 3 ] );
    var got = _.entityMakeConstructing( src );
    var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name !== got.constructor.name );

    test.case = 'src = empty long, ins = null';
    var src = new long( [] );
    var got = _.entityMakeConstructing( src, null );
    var expected = new long( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = empty long, ins = number';
    var src = new long( [] );
    var got = _.entityMakeConstructing( src, 2 );
    var expected = new long( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new long( [ 1, 2, 3 ] );
    var got = _.entityMakeConstructing( src, 2 );
    var expected = new long( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _.entityMakeConstructing( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new long( [ 1, 2, 3 ] );
    var got = _.entityMakeConstructing( src, 4 );
    var expected = new long( [ 1, 2, 3, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = new long( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.entityMakeConstructing( src, ins );
    var expected = new long( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new long( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.entityMakeConstructing( src, ins );
    var expected = new long( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );
  }
}

//

function entityMakeConstructingLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'null';
    var got = descriptor.entityMakeConstructing( null );
    test.identical( got, null );

    test.case = 'undefined';
    var got = descriptor.entityMakeConstructing( undefined );
    test.identical( got, undefined );

    test.case = 'zero';
    var got = descriptor.entityMakeConstructing( 0 );
    test.identical( got, 0 );

    test.case = 'number';
    var got = descriptor.entityMakeConstructing( 3 );
    test.identical( got, 3 );

    test.case = 'bigInt';
    var got = descriptor.entityMakeConstructing( 1n );
    test.identical( got, 1n );

    test.case = 'empty string';
    var got = descriptor.entityMakeConstructing( '' );
    test.identical( got, '' );

    test.case = 'string';
    var got = descriptor.entityMakeConstructing( 'str' );
    test.identical( got, 'str' );

    test.case = 'false';
    var got = descriptor.entityMakeConstructing( false );
    test.identical( got, false );

    test.case = 'NaN';
    var got = descriptor.entityMakeConstructing( NaN );
    test.identical( got, NaN );

    test.case = 'Symbol';
    var src = Symbol();
    var got = descriptor.entityMakeConstructing( src );
    test.identical( got, src );

    test.case = '_.null';
    var got = descriptor.entityMakeConstructing( _.null );
    test.identical( got, null );

    test.case = '_.undefined';
    var got = descriptor.entityMakeConstructing( _.undefined );
    test.identical( got, undefined );

    test.case = '_.nothing';
    var got = descriptor.entityMakeConstructing( _.nothing );
    test.identical( got, _.nothing );

    test.case = 'empty array';
    var got = descriptor.entityMakeConstructing( [] );
    test.identical( got, [] );

    test.case = 'empty array, length';
    var got = descriptor.entityMakeConstructing( [], 4 );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );

    test.case = 'not empty array';
    var got = descriptor.entityMakeConstructing( [ null, undefined, 1, 2 ] );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );

    test.case = 'not empty array, length';
    var got = descriptor.entityMakeConstructing( [ null, undefined, 1, 2 ], 2 );
    test.identical( got, [ undefined, undefined ] );

    test.case = 'empty unroll';
    var got = descriptor.entityMakeConstructing( _.unrollMake( [] ) );
    test.identical( got, [] );
    test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

    test.case = 'empty unroll, length';
    var got = descriptor.entityMakeConstructing( _.unrollMake( [] ), 4 );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );
    test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

    test.case = 'not empty unroll';
    var got = descriptor.entityMakeConstructing( _.unrollMake( [ null, undefined, 1, 2 ] ) );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );
    test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

    test.case = 'not empty unroll, length';
    var got = descriptor.entityMakeConstructing( _.unrollMake( [ null, undefined, 1, 2 ] ), 2 );
    test.identical( got, [ undefined, undefined ] );
    test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

    test.case = 'empty map';
    var got = descriptor.entityMakeConstructing( {} );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty map, length';
    var got = descriptor.entityMakeConstructing( {}, 4 );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'not empty map';
    var got = descriptor.entityMakeConstructing( { '' : null } );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'not empty map, length';
    var got = descriptor.entityMakeConstructing( { '' : null }, 4 );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty pure map';
    var got = descriptor.entityMakeConstructing( Object.create( null ) );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty pure map, length';
    var got = descriptor.entityMakeConstructing( Object.create( null ) );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'instance of constructor';
    var Constr = function( src )
    {
      this.x = src || 1;
      return this;
    };
    var src = new Constr( 2 );
    var got = descriptor.entityMakeConstructing( src );
    test.identical( got, new Constr() );

    test.case = 'instance of constructor, length';
    var Constr = function( src )
    {
      this.x = src || 1;
      return this;
    };
    var src = new Constr( 2 );
    var got = descriptor.entityMakeConstructing( src, 2 );
    test.identical( got, new Constr() );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMakeConstructing() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMakeConstructing( [], 1, 1 ) );

      test.case = 'unknown type of entity';
      test.shouldThrowErrorSync( () => descriptor.entityMakeConstructing( new Set( [ 1, 'str', false ] ) ) );
      test.shouldThrowErrorSync( () => descriptor.entityMakeConstructing( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) ) );
      test.shouldThrowErrorSync( () => descriptor.entityMakeConstructing( new BufferRaw() ) );
    }
  }
}

//

function entityMakeConstructingArgumentsArrayLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'src = empty long, not ins';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.entityMakeConstructing( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.entityMakeConstructing( src );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, ins = null';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.entityMakeConstructing( src, null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = empty long, ins = number';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.entityMakeConstructing( src, 2 );
    var expected = descriptor.longDescriptor.make( 2 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.entityMakeConstructing( src, 2 );
    var expected = descriptor.longDescriptor.make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.entityMakeConstructing( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.entityMakeConstructing( src, 4 );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3, undefined ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = _.argumentsArrayMake( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.entityMakeConstructing( src, ins );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = _.argumentsArrayMake( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.entityMakeConstructing( src, ins );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
  }
}

//

function entityMakeConstructingBufferTypedLongDescriptor( test )
{
  var list =
  [
    I8x,
    U16x,
    U16x,
    F32x,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, long - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, long - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, long )
  {
    test.case = 'src = empty long, not ins';
    var src = new long( [] );
    var got = descriptor.entityMakeConstructing( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new long( [ 1, 2, 3 ] );
    var got = descriptor.entityMakeConstructing( src );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = new long( [] );
    var got = descriptor.entityMakeConstructing( src, null );
    var expected = new long( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = empty long, ins = number';
    var src = new long( [] );
    var got = descriptor.entityMakeConstructing( src, 2 );
    var expected = new long( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new long( [ 1, 2, 3 ] );
    var got = descriptor.entityMakeConstructing( src, 2 );
    var expected = new long( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new long( 10 );
    var got = descriptor.entityMakeConstructing( src, [] );
    var expected = new long( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new long( [ 1, 2, 3 ] );
    var got = descriptor.entityMakeConstructing( src, 4 );
    var expected = new long( [ 1, 2, 3, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = new long( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.entityMakeConstructing( src, ins );
    var expected = new long( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new long( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.entityMakeConstructing( src, ins );
    var expected = new long( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );
  }
}

//

function entityMakeEmpty( test )
{
  test.case = 'null';
  var got = _.entityMakeEmpty( null );
  test.identical( got, null );

  test.case = 'undefined';
  var got = _.entityMakeEmpty( undefined );
  test.identical( got, undefined );

  test.case = 'zero';
  var got = _.entityMakeEmpty( 0 );
  test.identical( got, 0 );

  test.case = 'number';
  var got = _.entityMakeEmpty( 3 );
  test.identical( got, 3 );

  test.case = 'bigInt';
  var got = _.entityMakeEmpty( 1n );
  test.identical( got, 1n );

  test.case = 'empty string';
  var got = _.entityMakeEmpty( '' );
  test.identical( got, '' );

  test.case = 'string';
  var got = _.entityMakeEmpty( 'str' );
  test.identical( got, 'str' );

  test.case = 'false';
  var got = _.entityMakeEmpty( false );
  test.identical( got, false );

  test.case = 'NaN';
  var got = _.entityMakeEmpty( NaN );
  test.identical( got, NaN );

  test.case = 'Symbol';
  var src = Symbol();
  var got = _.entityMakeEmpty( src );
  test.identical( got, src );

  test.case = '_.null';
  var got = _.entityMakeEmpty( _.null );
  test.identical( got, null );

  test.case = '_.undefined';
  var got = _.entityMakeEmpty( _.undefined );
  test.identical( got, undefined );

  test.case = '_.nothing';
  var got = _.entityMakeEmpty( _.nothing );
  test.identical( got, _.nothing );

  test.case = 'empty array';
  var got = _.entityMakeEmpty( [] );
  test.identical( got, [] );

  test.case = 'not empty array';
  var got = _.entityMakeEmpty( [ null, undefined, 1, 2 ] );
  test.identical( got, [] );

  test.case = 'empty argumentArray';
  var got = _.entityMakeEmpty( _.argumentsArrayMake( [] ) );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'not empty argumentsArray';
  var got = _.entityMakeEmpty( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty unroll';
  var got = _.entityMakeEmpty( _.unrollMake( [] ) );
  test.identical( got, [] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'not empty unroll';
  var got = _.entityMakeEmpty( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
  test.identical( got, [] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'BufferTyped - U8x';
  var got = _.entityMakeEmpty( new U8x( 10 ) );
  test.identical( got, new U8x() );

  test.case = 'BufferTyped - I16x';
  var got = _.entityMakeEmpty( new I16x() );
  test.identical( got, new I16x() );

  test.case = 'BufferTyped - F64x';
  var got = _.entityMakeEmpty( new F64x( [ 1, 2 ] ) );
  test.identical( got, new F64x() );

  test.case = 'empty map';
  var got = _.entityMakeEmpty( {} );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'not empty map';
  var got = _.entityMakeEmpty( { '' : null } );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty pure map';
  var got = _.entityMakeEmpty( Object.create( null ) );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty Set';
  var got = _.entityMakeEmpty( new Set( [] ) );
  test.identical( got, new Set( [] ) );

  test.case = 'Set';
  var got = _.entityMakeEmpty( new Set( [ 1, 'str', false ] ) );
  test.identical( got, new Set( [] ) );

  test.case = 'empty HashMap';
  var got = _.entityMakeEmpty( new Map( [] ) );
  test.identical( got, new Map( [] ) );

  test.case = 'HashMap';
  var got = _.entityMakeEmpty( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
  test.identical( got, new Map( [] ) );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityMakeEmpty() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.entityMakeEmpty( [], 1 ) );

  test.case = 'unknown type of entity';
  test.shouldThrowErrorSync( () => _.entityMakeEmpty( new BufferRaw() ) );
  var Constr = function(){ this.x = 1; return this };
  test.shouldThrowErrorSync( () => _.entityMakeEmpty( new Constr() ) );
}

//

function entityMakeEmptyLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'null';
    var got = descriptor.entityMakeEmpty( null );
    test.identical( got, null );

    test.case = 'undefined';
    var got = descriptor.entityMakeEmpty( undefined );
    test.identical( got, undefined );

    test.case = 'zero';
    var got = descriptor.entityMakeEmpty( 0 );
    test.identical( got, 0 );

    test.case = 'number';
    var got = descriptor.entityMakeEmpty( 3 );
    test.identical( got, 3 );

    test.case = 'bigInt';
    var got = descriptor.entityMakeEmpty( 1n );
    test.identical( got, 1n );

    test.case = 'empty string';
    var got = descriptor.entityMakeEmpty( '' );
    test.identical( got, '' );

    test.case = 'string';
    var got = descriptor.entityMakeEmpty( 'str' );
    test.identical( got, 'str' );

    test.case = 'false';
    var got = descriptor.entityMakeEmpty( false );
    test.identical( got, false );

    test.case = 'NaN';
    var got = descriptor.entityMakeEmpty( NaN );
    test.identical( got, NaN );

    test.case = 'Symbol';
    var src = Symbol();
    var got = descriptor.entityMakeEmpty( src );
    test.identical( got, src );

    test.case = '_.null';
    var got = descriptor.entityMakeEmpty( _.null );
    test.identical( got, null );

    test.case = '_.undefined';
    var got = descriptor.entityMakeEmpty( _.undefined );
    test.identical( got, undefined );

    test.case = '_.nothing';
    var got = descriptor.entityMakeEmpty( _.nothing );
    test.identical( got, _.nothing );

    test.case = 'empty array';
    var got = descriptor.entityMakeEmpty( [] );
    test.identical( got, [] );

    test.case = 'not empty array';
    var got = descriptor.entityMakeEmpty( [ null, undefined, 1, 2 ] );
    test.identical( got, [] );

    test.case = 'empty argumentArray';
    var got = descriptor.entityMakeEmpty( _.argumentsArrayMake( [] ) );
    test.identical( got, descriptor.longDescriptor.make( [] ) );

    test.case = 'not empty argumentsArray';
    var got = descriptor.entityMakeEmpty( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
    test.identical( got, descriptor.longDescriptor.make( [] ) );

    test.case = 'empty unroll';
    var got = descriptor.entityMakeEmpty( _.unrollMake( [] ) );
    test.identical( got, [] );
    test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

    test.case = 'not empty unroll';
    var got = descriptor.entityMakeEmpty( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
    test.identical( got, descriptor.longDescriptor.make( [] ) );

    test.case = 'BufferTyped - U8x';
    var got = descriptor.entityMakeEmpty( new U8x( 10 ) );
    test.identical( got, new U8x() );

    test.case = 'BufferTyped - I16x';
    var got = descriptor.entityMakeEmpty( new I16x() );
    test.identical( got, new I16x() );

    test.case = 'BufferTyped - F64x';
    var got = descriptor.entityMakeEmpty( new F64x( [ 1, 2 ] ) );
    test.identical( got, new F64x() );

    test.case = 'empty map';
    var got = descriptor.entityMakeEmpty( {} );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'not empty map';
    var got = descriptor.entityMakeEmpty( { '' : null } );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty pure map';
    var got = descriptor.entityMakeEmpty( Object.create( null ) );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty Set';
    var got = descriptor.entityMakeEmpty( new Set( [] ) );
    test.identical( got, new Set( [] ) );

    test.case = 'Set';
    var got = descriptor.entityMakeEmpty( new Set( [ 1, 'str', false ] ) );
    test.identical( got, new Set( [] ) );

    test.case = 'empty HashMap';
    var got = descriptor.entityMakeEmpty( new Map( [] ) );
    test.identical( got, new Map( [] ) );

    test.case = 'HashMap';
    var got = descriptor.entityMakeEmpty( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
    test.identical( got, new Map( [] ) );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMakeEmpty() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMakeEmpty( [], 1 ) );

      test.case = 'unknown type of entity';
      test.shouldThrowErrorSync( () => descriptor.entityMakeEmpty( new BufferRaw() ) );
      var Constr = function(){ this.x = 1; return this };
      test.shouldThrowErrorSync( () => descriptor.entityMakeEmpty( new Constr() ) );
    }
  }
}

//

function entityMakeUndefined( test )
{
  test.case = 'null';
  var got = _.entityMakeUndefined( null );
  test.identical( got, null );

  test.case = 'undefined';
  var got = _.entityMakeUndefined( undefined );
  test.identical( got, undefined );

  test.case = 'zero';
  var got = _.entityMakeUndefined( 0 );
  test.identical( got, 0 );

  test.case = 'number';
  var got = _.entityMakeUndefined( 3 );
  test.identical( got, 3 );

  test.case = 'bigInt';
  var got = _.entityMakeUndefined( 1n );
  test.identical( got, 1n );

  test.case = 'empty string';
  var got = _.entityMakeUndefined( '' );
  test.identical( got, '' );

  test.case = 'string';
  var got = _.entityMakeUndefined( 'str' );
  test.identical( got, 'str' );

  test.case = 'false';
  var got = _.entityMakeUndefined( false );
  test.identical( got, false );

  test.case = 'NaN';
  var got = _.entityMakeUndefined( NaN );
  test.identical( got, NaN );

  test.case = 'Symbol';
  var src = Symbol();
  var got = _.entityMakeUndefined( src );
  test.identical( got, src );

  test.case = '_.null';
  var got = _.entityMakeUndefined( _.null );
  test.identical( got, null );

  test.case = '_.undefined';
  var got = _.entityMakeUndefined( _.undefined );
  test.identical( got, undefined );

  test.case = '_.nothing';
  var got = _.entityMakeUndefined( _.nothing );
  test.identical( got, _.nothing );

  test.case = 'empty array';
  var got = _.entityMakeUndefined( [] );
  test.identical( got, [] );

  test.case = 'empty array, length';
  var got = _.entityMakeUndefined( [], 4 );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );

  test.case = 'not empty array';
  var got = _.entityMakeUndefined( [ null, undefined, 1, 2 ] );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );

  test.case = 'not empty array, length';
  var got = _.entityMakeUndefined( [ null, undefined, 1, 2 ], 2 );
  test.identical( got, [ undefined, undefined ] );

  test.case = 'empty arguments array';
  var got = _.entityMakeUndefined( _.argumentsArrayMake( [] ) );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty arguments array, length';
  var got = _.entityMakeUndefined( _.argumentsArrayMake( [] ), 4 );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );
  test.is( _.arrayIs( got ) );

  test.case = 'not empty argumentsArray';
  var got = _.entityMakeUndefined( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );
  test.is( _.arrayIs( got ) );

  test.case = 'not empty argumentsArray, length';
  var got = _.entityMakeUndefined( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ), 2 );
  test.identical( got, [ undefined, undefined ] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty unroll';
  var got = _.entityMakeUndefined( _.unrollMake( [] ) );
  test.identical( got, [] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'empty unroll, length';
  var got = _.entityMakeUndefined( _.unrollMake( [] ), 4 );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'not empty unroll';
  var got = _.entityMakeUndefined( _.unrollMake( [ null, undefined, 1, 2 ] ) );
  test.identical( got, [ undefined, undefined, undefined, undefined ] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'not empty unroll, length';
  var got = _.entityMakeUndefined( _.unrollMake( [ null, undefined, 1, 2 ] ), 2 );
  test.identical( got, [ undefined, undefined ] );
  test.is( !_.unrollIs( got ) && _.arrayIs( got ) );

  test.case = 'empty BufferTyped - U8x';
  var got = _.entityMakeUndefined( new U8x() );
  test.identical( got, _.longDescriptor.make( 0 ) );

  test.case = 'empty BufferTyped - I16x, length';
  var got = _.entityMakeUndefined( new I16x(), 5 );
  test.identical( got, new I16x( 5 ) );

  test.case = 'BufferTyped - F32x';
  var got = _.entityMakeUndefined( new F32x( 5 ) );
  test.identical( got, _.longDescriptor.make( 5 ) );

  test.case = 'BufferTyped - F32x, length';
  var got = _.entityMakeUndefined( new F32x( 10 ), 5 );
  test.identical( got, new F32x( 5 ) );

  test.case = 'empty map';
  var got = _.entityMakeUndefined( {} );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty map, length';
  var got = _.entityMakeUndefined( {}, 4 );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'not empty map';
  var got = _.entityMakeUndefined( { '' : null } );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'not empty map, length';
  var got = _.entityMakeUndefined( { '' : null }, 4 );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty pure map';
  var got = _.entityMakeUndefined( Object.create( null ) );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty pure map, length';
  var got = _.entityMakeUndefined( Object.create( null ) );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty Set';
  var got = _.entityMakeUndefined( new Set( [] ) );
  test.identical( got, new Set( [] ) );

  test.case = 'empty Set, length';
  var got = _.entityMakeUndefined( new Set( [] ), 4 );
  test.identical( got, new Set( [] ) );

  test.case = 'Set';
  var got = _.entityMakeUndefined( new Set( [ 1, 'str', false ] ) );
  test.identical( got, new Set( [] ) );

  test.case = 'Set, length';
  var got = _.entityMakeUndefined( new Set( [ 1, 'str', false ] ), 4 );
  test.identical( got, new Set( [] ) );

  test.case = 'empty HashMap';
  var got = _.entityMakeUndefined( new Map( [] ) );
  test.identical( got, new Map( [] ) );

  test.case = 'empty HashMap, length';
  var got = _.entityMakeUndefined( new Map( [] ), 4 );
  test.identical( got, new Map( [] ) );

  test.case = 'HashMap';
  var got = _.entityMakeUndefined( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
  test.identical( got, new Map( [] ) );

  test.case = 'HashMap, length';
  var got = _.entityMakeUndefined( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
  test.identical( got, new Map( [] ) );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityMakeUndefined() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.entityMakeUndefined( [], 1, 1 ) );

  test.case = 'unknown type of entity';
  test.shouldThrowErrorSync( () => _.entityMakeUndefined( new BufferRaw() ) );
  var Constr = function(){ this.x = 1; return this };
  test.shouldThrowErrorSync( () => _.entityMakeUndefined( new Constr() ) );
}

//

function entityMakeUndefinedLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'null';
    var got = descriptor.entityMakeUndefined( null );
    test.identical( got, null );

    test.case = 'undefined';
    var got = descriptor.entityMakeUndefined( undefined );
    test.identical( got, undefined );

    test.case = 'zero';
    var got = descriptor.entityMakeUndefined( 0 );
    test.identical( got, 0 );

    test.case = 'number';
    var got = descriptor.entityMakeUndefined( 3 );
    test.identical( got, 3 );

    test.case = 'bigInt';
    var got = descriptor.entityMakeUndefined( 1n );
    test.identical( got, 1n );

    test.case = 'empty string';
    var got = descriptor.entityMakeUndefined( '' );
    test.identical( got, '' );

    test.case = 'string';
    var got = descriptor.entityMakeUndefined( 'str' );
    test.identical( got, 'str' );

    test.case = 'false';
    var got = descriptor.entityMakeUndefined( false );
    test.identical( got, false );

    test.case = 'NaN';
    var got = descriptor.entityMakeUndefined( NaN );
    test.identical( got, NaN );

    test.case = 'Symbol';
    var src = Symbol();
    var got = descriptor.entityMakeUndefined( src );
    test.identical( got, src );

    test.case = '_.null';
    var got = descriptor.entityMakeUndefined( _.null );
    test.identical( got, null );

    test.case = '_.undefined';
    var got = descriptor.entityMakeUndefined( _.undefined );
    test.identical( got, undefined );

    test.case = '_.nothing';
    var got = descriptor.entityMakeUndefined( _.nothing );
    test.identical( got, _.nothing );

    test.case = 'empty array';
    var got = descriptor.entityMakeUndefined( [] );
    test.identical( got, [] );

    test.case = 'empty array, length';
    var got = descriptor.entityMakeUndefined( [], 4 );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );

    test.case = 'not empty array';
    var got = descriptor.entityMakeUndefined( [ null, undefined, 1, 2 ] );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );

    test.case = 'not empty array, length';
    var got = descriptor.entityMakeUndefined( [ null, undefined, 1, 2 ], 2 );
    test.identical( got, [ undefined, undefined ] );

    test.case = 'empty arguments array';
    var got = descriptor.entityMakeUndefined( _.argumentsArrayMake( [] ) );
    test.identical( got, descriptor.longDescriptor.make( [] ) );

    test.case = 'empty arguments array, length';
    var got = descriptor.entityMakeUndefined( _.argumentsArrayMake( [] ), 4 );
    test.identical( got, descriptor.longDescriptor.make( 4 ) );

    test.case = 'not empty argumentsArray';
    var got = descriptor.entityMakeUndefined( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ) );
    test.identical( got, descriptor.longDescriptor.make( 4 ) );

    test.case = 'not empty argumentsArray, length';
    var got = descriptor.entityMakeUndefined( _.argumentsArrayMake( [ null, undefined, 1, 2 ] ), 2 );
    test.identical( got, descriptor.longDescriptor.make( 2 ) );

    test.case = 'empty unroll';
    var got = descriptor.entityMakeUndefined( _.unrollMake( [] ) );
    test.identical( got, [] );

    test.case = 'empty unroll, length';
    var got = descriptor.entityMakeUndefined( _.unrollMake( [] ), 4 );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );

    test.case = 'not empty unroll';
    var got = descriptor.entityMakeUndefined( _.unrollMake( [ null, undefined, 1, 2 ] ) );
    test.identical( got, [ undefined, undefined, undefined, undefined ] );

    test.case = 'not empty unroll, length';
    var got = descriptor.entityMakeUndefined( _.unrollMake( [ null, undefined, 1, 2 ] ), 2 );
    test.identical( got, [ undefined, undefined ] );

    test.case = 'empty BufferTyped - U8x';
    var got = descriptor.entityMakeUndefined( new U8x() );
    test.identical( got, descriptor.longDescriptor.make( 0 ) );

    test.case = 'empty BufferTyped - I16x, length';
    var got = descriptor.entityMakeUndefined( new I16x(), 5 );
    test.identical( got, new I16x( 5 ) );

    test.case = 'BufferTyped - F32x';
    var got = descriptor.entityMakeUndefined( new F32x( 5 ) );
    test.identical( got, descriptor.longDescriptor.make( 5 ) );

    test.case = 'BufferTyped - F32x, length';
    var got = descriptor.entityMakeUndefined( new F32x( 10 ), 5 );
    test.identical( got, new F32x( 5 ) );

    test.case = 'empty map';
    var got = descriptor.entityMakeUndefined( {} );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty map, length';
    var got = descriptor.entityMakeUndefined( {}, 4 );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'not empty map';
    var got = descriptor.entityMakeUndefined( { '' : null } );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'not empty map, length';
    var got = descriptor.entityMakeUndefined( { '' : null }, 4 );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty pure map';
    var got = descriptor.entityMakeUndefined( Object.create( null ) );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty pure map, length';
    var got = descriptor.entityMakeUndefined( Object.create( null ) );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );

    test.case = 'empty Set';
    var got = descriptor.entityMakeUndefined( new Set( [] ) );
    test.identical( got, new Set( [] ) );

    test.case = 'empty Set, length';
    var got = descriptor.entityMakeUndefined( new Set( [] ), 4 );
    test.identical( got, new Set( [] ) );

    test.case = 'Set';
    var got = descriptor.entityMakeUndefined( new Set( [ 1, 'str', false ] ) );
    test.identical( got, new Set( [] ) );

    test.case = 'Set, length';
    var got = descriptor.entityMakeUndefined( new Set( [ 1, 'str', false ] ), 4 );
    test.identical( got, new Set( [] ) );

    test.case = 'empty HashMap';
    var got = descriptor.entityMakeUndefined( new Map( [] ) );
    test.identical( got, new Map( [] ) );

    test.case = 'empty HashMap, length';
    var got = descriptor.entityMakeUndefined( new Map( [] ), 4 );
    test.identical( got, new Map( [] ) );

    test.case = 'HashMap';
    var got = descriptor.entityMakeUndefined( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
    test.identical( got, new Map( [] ) );

    test.case = 'HashMap, length';
    var got = descriptor.entityMakeUndefined( new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
    test.identical( got, new Map( [] ) );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMakeUndefined() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMakeUndefined( [], 1, 1 ) );

      test.case = 'unknown type of entity';
      test.shouldThrowErrorSync( () => descriptor.entityMakeUndefined( new BufferRaw() ) );
      var Constr = function(){ this.x = 1; return this };
      test.shouldThrowErrorSync( () => descriptor.entityMakeUndefined( new Constr() ) );
    }
  }
}

//

function entityMake( test )
{
  test.case = 'null';
  var got = _.entityMake( null );
  test.identical( got, null );

  test.case = 'undefined';
  var got = _.entityMake( undefined );
  test.identical( got, undefined );

  test.case = 'zero';
  var got = _.entityMake( 0 );
  test.identical( got, 0 );

  test.case = 'number';
  var got = _.entityMake( 3 );
  test.identical( got, 3 );

  test.case = 'bigInt';
  var got = _.entityMake( 1n );
  test.identical( got, 1n );

  test.case = 'empty string';
  var got = _.entityMake( '' );
  test.identical( got, '' );

  test.case = 'string';
  var got = _.entityMake( 'str' );
  test.identical( got, 'str' );

  test.case = 'false';
  var got = _.entityMake( false );
  test.identical( got, false );

  test.case = 'NaN';
  var got = _.entityMake( NaN );
  test.identical( got, NaN );

  test.case = 'Symbol';
  var src = Symbol();
  var got = _.entityMake( src );
  test.identical( got, src );

  test.case = '_.null';
  var got = _.entityMake( _.null );
  test.identical( got, null );

  test.case = '_.undefined';
  var got = _.entityMake( _.undefined );
  test.identical( got, undefined );

  test.case = '_.nothing';
  var got = _.entityMake( _.nothing );
  test.identical( got, _.nothing );

  test.case = 'empty array';
  var src = [];
  var got = _.entityMake( src );
  test.identical( got, [] );
  test.is( got !== src );

  test.case = 'not empty array';
  var src = [ null, undefined, 1, 2 ];
  var got = _.entityMake( src );
  test.identical( got, [ null, undefined, 1, 2 ] );
  test.is( got !== src );

  test.case = 'empty argumentArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.entityMake( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'not empty argumentsArray';
  var src = _.argumentsArrayMake( [ null, undefined, 1, 2 ] );
  var got = _.entityMake( src );
  test.identical( got, [ null, undefined, 1, 2 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'empty unroll';
  var src = _.unrollMake( [] );
  var got = _.entityMake( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'not empty unroll';
  var src = _.unrollMake( [ null, undefined, 1, 2 ] );
  var got = _.entityMake( src );
  test.identical( got, [ null, undefined, 1, 2 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'empty BufferTyped - U8x';
  var src = new U8x();
  var got = _.entityMake( src );
  test.identical( got, _.longDescriptor.make( [] ) );
  test.is( got instanceof U8x )
  test.is( got !== src );

  test.case = 'not empty BufferTyped - I16x';
  var src = new I16x( 5 );
  var got = _.entityMake( src );
  test.identical( got, _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] ) );
  test.is( got instanceof I16x )
  test.is( got !== src );

  test.case = 'not empty BufferTyped - F32x';
  var src = new F32x( 5 );
  var got = _.entityMake( src );
  test.identical( got, _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] ) );
  test.is( got instanceof F32x )
  test.is( got !== src );

  test.case = 'not empty BufferTyped - F64x';
  var src = new F64x( 5 );
  var got = _.entityMake( src );
  test.identical( got, _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] ) );
  test.is( got instanceof F64x )
  test.is( got !== src );

  test.case = 'empty map';
  var src = {};
  var got = _.entityMake( src );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'not empty map';
  var src = { '' : null };
  var got = _.entityMake( src );
  test.identical( got, { '' : null } );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'empty pure map';
  var src = Object.create( null );
  var got = _.entityMake( src );
  test.identical( got, {} );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'pure map';
  var src = Object.create( null );
  src.a = 2;
  var got = _.entityMake( src );
  test.identical( got, { a : 2 } );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'empty Set';
  var src = new Set( [] );
  var got = _.entityMake( src );
  test.identical( got, new Set( [] ) );
  test.is( got !== src );

  test.case = 'Set';
  var src = new Set( [ 1, 'str', false ] );
  var got = _.entityMake( src );
  test.identical( got, new Set( [ 1, 'str', false ] ) );
  test.is( got !== src );

  test.case = 'empty HashMap';
  var src = new Map( [] );
  var got = _.entityMake( src );
  test.identical( got, new Map( [] ) );
  test.is( got !== src );

  test.case = 'HashMap';
  var src = new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] );
  var got = _.entityMake( src );
  test.identical( got, new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
  test.is( got !== src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityMake() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.entityMake( [], 1 ) );

  test.case = 'unknown type of entity';
  test.shouldThrowErrorSync( () => _.entityMake( new BufferRaw() ) );
  var Constr = function(){ this.x = 1; return this };
  test.shouldThrowErrorSync( () => _.entityMake( new Constr() ) );
}

//

function entityMakeLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    test.open( `descriptor - ${ name }` );
    testRun( descriptor );
    test.close( `descriptor - ${ name }` );

    if( times < 1 )
    break;
    times--;
  }

  /* - */

  function testRun( descriptor )
  {
    test.case = 'null';
    var got = descriptor.entityMake( null );
    test.identical( got, null );

    test.case = 'undefined';
    var got = descriptor.entityMake( undefined );
    test.identical( got, undefined );

    test.case = 'zero';
    var got = descriptor.entityMake( 0 );
    test.identical( got, 0 );

    test.case = 'number';
    var got = descriptor.entityMake( 3 );
    test.identical( got, 3 );

    test.case = 'bigInt';
    var got = descriptor.entityMake( 1n );
    test.identical( got, 1n );

    test.case = 'empty string';
    var got = descriptor.entityMake( '' );
    test.identical( got, '' );

    test.case = 'string';
    var got = descriptor.entityMake( 'str' );
    test.identical( got, 'str' );

    test.case = 'false';
    var got = descriptor.entityMake( false );
    test.identical( got, false );

    test.case = 'NaN';
    var got = descriptor.entityMake( NaN );
    test.identical( got, NaN );

    test.case = 'Symbol';
    var src = Symbol();
    var got = descriptor.entityMake( src );
    test.identical( got, src );

    test.case = '_.null';
    var got = descriptor.entityMake( _.null );
    test.identical( got, null );

    test.case = '_.undefined';
    var got = descriptor.entityMake( _.undefined );
    test.identical( got, undefined );

    test.case = '_.nothing';
    var got = descriptor.entityMake( _.nothing );
    test.identical( got, _.nothing );

    test.case = 'empty array';
    var src = [];
    var got = descriptor.entityMake( src );
    test.identical( got, [] );
    test.is( got !== src );

    test.case = 'not empty array';
    var src = [ null, undefined, 1, 2 ];
    var got = descriptor.entityMake( src );
    test.identical( got, [ null, undefined, 1, 2 ] );
    test.is( got !== src );

    test.case = 'empty argumentArray';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.entityMake( src );
    test.identical( got, descriptor.longDescriptor.make( [] ) );

    test.case = 'not empty argumentsArray';
    var src = _.argumentsArrayMake( [ null, undefined, 1, 2 ] );
    var got = descriptor.entityMake( src );
    test.identical( got, descriptor.longDescriptor.make( [ null, undefined, 1, 2 ] ) );

    test.case = 'empty unroll';
    var src = _.unrollMake( [] );
    var got = descriptor.entityMake( src );
    test.identical( got, [] );
     test.is( got !== src );

    test.case = 'not empty unroll';
    var src = _.unrollMake( [ null, undefined, 1, 2 ] );
    var got = descriptor.entityMake( src );
    test.identical( got, [ null, undefined, 1, 2 ] );
    test.is( got !== src );

    test.case = 'empty BufferTyped - U8x';
    var src = new U8x();
    var got = descriptor.entityMake( src );
    test.identical( got, descriptor.longDescriptor.make( [] ) );
    test.is( got !== src );

    test.case = 'not empty BufferTyped - I16x';
    var src = new I16x( 5 );
    var got = descriptor.entityMake( src );
    test.identical( got, descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] ) );
    test.is( got !== src );

    test.case = 'not empty BufferTyped - F64x';
    var src = new F64x( 5 );
    var got = descriptor.entityMake( src );
    test.identical( got, descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] ) );
    test.is( got !== src );

    test.case = 'empty map';
    var src = {};
    var got = descriptor.entityMake( src );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );
    test.is( got !== src );

    test.case = 'not empty map';
    var src = { '' : null };
    var got = descriptor.entityMake( src );
    test.identical( got, { '' : null } );
    test.is( _.mapIsPure( got ) );
    test.is( got !== src );

    test.case = 'empty pure map';
    var src = Object.create( null );
    var got = descriptor.entityMake( src );
    test.identical( got, {} );
    test.is( _.mapIsPure( got ) );
    test.is( got !== src );

    test.case = 'pure map';
    var src = Object.create( null );
    src.a = 2;
    var got = descriptor.entityMake( src );
    test.identical( got, { a : 2 } );
    test.is( _.mapIsPure( got ) );
    test.is( got !== src );

    test.case = 'empty Set';
    var src = new Set( [] );
    var got = descriptor.entityMake( src );
    test.identical( got, new Set( [] ) );
    test.is( got !== src );

    test.case = 'Set';
    var src = new Set( [ 1, 'str', false ] );
    var got = descriptor.entityMake( src );
    test.identical( got, new Set( [ 1, 'str', false ] ) );
    test.is( got !== src );

    test.case = 'empty HashMap';
    var src = new Map( [] );
    var got = descriptor.entityMake( src );
    test.identical( got, new Map( [] ) );
    test.is( got !== src );

    test.case = 'HashMap';
    var src = new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] );
    var got = descriptor.entityMake( src );
    test.identical( got, new Map( [ [ 'a', 1 ], [ 'b', 2 ] ] ) );
    test.is( got !== src );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMake() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.entityMake( [], 1 ) );

      test.case = 'unknown type of entity';
      test.shouldThrowErrorSync( () => descriptor.entityMake( new BufferRaw() ) );
      var Constr = function(){ this.x = 1; return this };
      test.shouldThrowErrorSync( () => descriptor.entityMake( new Constr() ) );
    }
  }
}

//

function entityEntityEqualize( test )
{
  test.open( 'without callbacks' );

  test.case = 'two undefined';
  var got = _.entityEntityEqualize( undefined, undefined );
  test.identical( got, true );

  test.case = 'undefined and null';
  var got = _.entityEntityEqualize( undefined, null );
  test.identical( got, false );

  test.case = 'nan and nan';
  var got = _.entityEntityEqualize( NaN, NaN );
  test.identical( got, true );

  test.case = 'equal numbers';
  var got = _.entityEntityEqualize( 1, 1 );
  test.identical( got, true );

  test.case = 'different numbers';
  var got = _.entityEntityEqualize( 1, 2 );
  test.identical( got, false );

  test.case = 'equal strings';
  var got = _.entityEntityEqualize( 'str', 'str' );
  test.identical( got, true );

  test.case = 'different strings';
  var got = _.entityEntityEqualize( 'str', 'src' );
  test.identical( got, false );

  test.case = 'empty arrays';
  var got = _.entityEntityEqualize( [], [] );
  test.identical( got, false );

  test.case = 'equal arrays';
  var got = _.entityEntityEqualize( [ 1, 2, 'str', null, undefined ], [ 1, 2, 'str', null, undefined ] );
  test.identical( got, false );

  test.case = 'not equal arrays';
  var got = _.entityEntityEqualize( [ 1 ], [ 2, 'str', null, undefined ] );
  test.identical( got, false );

  test.case = 'empty maps';
  var got = _.entityEntityEqualize( {}, {} );
  test.identical( got, false );

  test.case = 'equal maps';
  var got = _.entityEntityEqualize( { a : 2, b : 'str' }, { a : 2, b : 'str' } );
  test.identical( got, false );

  test.case = 'not equal maps';
  var got = _.entityEntityEqualize( { a : 'str' }, { b : 'str' } );
  test.identical( got, false );

  test.close( 'without callbacks' );

	/* - */

  test.open( 'only onEvaluate1' );

  test.case = 'two undefined';
  var got = _.entityEntityEqualize( undefined, undefined, ( e ) => e );
  test.identical( got, true );

  test.case = 'undefined and null';
  var got = _.entityEntityEqualize( undefined, null, ( e ) => e );
  test.identical( got, false );

  test.case = 'equal numbers';
  var got = _.entityEntityEqualize( 1, 1, ( e ) => e );
  test.identical( got, true );

  test.case = 'different numbers';
  var got = _.entityEntityEqualize( 1, 2, ( e ) => e === 1 ? e : e - 1 );
  test.identical( got, true );

  test.case = 'equal strings';
  var got = _.entityEntityEqualize( 'str', 'str', ( e ) => e );
  test.identical( got, true );

  test.case = 'different strings';
  var got = _.entityEntityEqualize( 'str', 'src', ( e ) => typeof e );
  test.identical( got, true );

  test.case = 'empty arrays';
  var got = _.entityEntityEqualize( [], [], ( e ) => e.length );
  test.identical( got, true );

  test.case = 'equal arrays';
  var got = _.entityEntityEqualize( [ 1, 2, 'str', null, undefined ], [ 1, 2, 'str', null, undefined ], ( e ) => e[ 3 ] );
  test.identical( got, true );

  test.case = 'not equal arrays';
  var got = _.entityEntityEqualize( [ 1 ], [ 2, 'str', null, undefined ], ( e ) => e[ 0 ] );
  test.identical( got, false );

  test.case = 'empty maps';
  var got = _.entityEntityEqualize( {}, {}, ( e ) => _.mapIs( e ) );
  test.identical( got, true );

  test.case = 'equal maps';
  var got = _.entityEntityEqualize( { a : 2, b : 'str' }, { a : 2, b : 'str' }, ( e ) => e.a );
  test.identical( got, true );

  test.case = 'not equal maps';
  var got = _.entityEntityEqualize( { a : 'str' }, { b : 'str' }, ( e ) => typeof e.a );
  test.identical( got, false );

  test.close( 'only onEvaluate1' );

	/* - */

  test.open( 'onEvaluate1 is equalizer' );

  test.case = 'two undefined';
  var got = _.entityEntityEqualize( undefined, undefined, ( e, ins ) => e === ins );
  test.identical( got, true );

  test.case = 'undefined and null';
  var got = _.entityEntityEqualize( undefined, null, ( e, ins ) => e === ins );
  test.identical( got, false );

  test.case = 'equal numbers';
  var got = _.entityEntityEqualize( 1, 1, ( e, ins ) => e === ins );
  test.identical( got, true );

  test.case = 'different numbers';
  var got = _.entityEntityEqualize( 1, 2, ( e, ins ) => e === ins - 1 );
  test.identical( got, true );

  test.case = 'equal strings';
  var got = _.entityEntityEqualize( 'str', 'str', ( e, ins ) => e !== ins );
  test.identical( got, false );

  test.case = 'different strings';
  var got = _.entityEntityEqualize( 'str', 'src', ( e, ins ) => typeof e === typeof ins );
  test.identical( got, true );

  test.case = 'empty arrays';
  var got = _.entityEntityEqualize( [], [], ( e, ins ) => e.length === ins.length );
  test.identical( got, true );

  test.case = 'equal arrays';
  var got = _.entityEntityEqualize( [ 1, 2, 'str', null, undefined ], [ 1, 2, 'str', null, undefined ], ( e, ins ) => e[ 0 ] === ins[ 1 ] );
  test.identical( got, false );

  test.case = 'not equal arrays';
  var got = _.entityEntityEqualize( [ 1 ], [ 2, 'str', null, undefined ], ( e, ins ) => e[ 0 ] === ins[ 0 ] - 1 );
  test.identical( got, true );

  test.case = 'empty maps';
  var got = _.entityEntityEqualize( {}, {}, ( e, ins ) => _.mapIs( e ) === _.mapIs( ins ) );
  test.identical( got, true );

  test.case = 'equal maps';
  var got = _.entityEntityEqualize( { a : 2, b : 'str' }, { a : 2, b : 'str' }, ( e, ins ) => e.a === ins.b );
  test.identical( got, false );

  test.case = 'not equal maps';
  var got = _.entityEntityEqualize( { a : 'str' }, { b : 'str' }, ( e, ins ) => e.a === ins.b );
  test.identical( got, true );

  test.close( 'onEvaluate1 is equalizer' );

	/* - */

  test.open( 'onEvaluate1 and onEvaluate2' );

  test.case = 'two undefined';
  var got = _.entityEntityEqualize( undefined, undefined, ( e ) => e, ( ins ) => ins );
  test.identical( got, true );

  test.case = 'undefined and null';
  var got = _.entityEntityEqualize( undefined, null, ( e ) => e, ( ins ) => ins );
  test.identical( got, false );

  test.case = 'equal numbers';
  var got = _.entityEntityEqualize( 1, 1, ( e ) => e, ( ins ) => ins );
  test.identical( got, true );

  test.case = 'different numbers';
  var got = _.entityEntityEqualize( 1, 2, ( e ) => e, ( ins ) => ins - 1 );
  test.identical( got, true );

  test.case = 'equal strings';
  var got = _.entityEntityEqualize( 'str', 'str', ( e ) => e, ( ins ) => !ins );
  test.identical( got, false );

  test.case = 'different strings';
  var got = _.entityEntityEqualize( 'str', 'src', ( e ) => !!e, ( ins ) => !!ins );
  test.identical( got, true );

  test.case = 'empty arrays';
  var got = _.entityEntityEqualize( [], [], ( e ) => e.length, ( ins ) => ins.length );
  test.identical( got, true );

  test.case = 'equal arrays';
  var got = _.entityEntityEqualize( [ 1, 2, 'str', null, undefined ], [ 1, 2, 'str', null, undefined ], ( e ) => !!e[ 3 ], ( ins ) => !!ins[ 4 ] );
  test.identical( got, true );

  test.case = 'not equal arrays';
  var got = _.entityEntityEqualize( [ 4 ], [ 2, 'str', null, undefined ], ( e ) => e[ 0 ], ( ins ) => ins.length );
  test.identical( got, true );

  test.case = 'empty maps';
  var got = _.entityEntityEqualize( {}, {}, ( e ) => !!e, ( ins ) => !!ins );
  test.identical( got, true );

  test.case = 'equal maps';
  var got = _.entityEntityEqualize( { a : 2, b : 'str' }, { a : 2, b : 'str' }, ( e ) => e.b, ( ins ) => ins.b );
  test.identical( got, true );

  test.case = 'not equal maps';
  var got = _.entityEntityEqualize( { a : 'str' }, { b : 'str' }, ( e ) => e.a, ( ins ) => ins.b );
  test.identical( got, true );

  test.close( 'onEvaluate1 and onEvaluate2' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1 ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, ( e ) => e, ( ins ) => ins, 'extra' ) );

  test.case = 'wrong length of onEvaluate1';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, () => true ) );
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, ( a, b, c ) => a === b - c ) );

  test.case = 'wrong type of onEvaluate1';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, 3 ) );

  test.case = 'wrong length of onEvaluate2';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, ( e ) => e, () => true ) );
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, ( e ) => e, ( a, b, c ) => a + b + c ) );

  test.case = 'wrong type of onEvaluate2';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, ( e ) => e, [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, ( e ) => e, [ 2 ] ) );

  test.case = 'using onEvaluate2 without onEvaluate1';
  test.shouldThrowErrorSync( () => _.entityEntityEqualize( 1, 2, undefined, ( e ) => e ) );
}

//

function entityAssign( test )
{
  test.case = 'src null';
  var dst = new String( 'string' );
  var src = null;
  var got = _.entityAssign( dst, src  );
  var expected = null;
  test.identical( got, expected );

  test.case = 'dst.copy';
  var dst = { copy : function( src ) { for( var i in src ) this[ i ] = src[ i ] } };
  var src = { src : 'string', num : 123 }
  _.entityAssign( dst, src  );
  var got = dst;
  var expected =
  {
    copy : dst.copy,
    src : 'string',
    num : 123

  };
  test.identical( got, expected );

  test.case = 'src.clone';
  var dst = 1;
  // var src = { src : 'string', num : 123, clone : function() { var clone = _.cloneObject( { src : this } ); return clone; } }
  var src = { src : 'string', num : 123, clone : function() { return { src : 'string', num : 123 } } }
  var got = _.entityAssign( dst, src  );
  var expected = { src : 'string', num : 123 };
  test.identical( got, expected );
  test.is( got !== expected );
  test.is( got !== src );

  test.case = 'src.slice returns copy of array';
  var dst = [ ];
  var src = [ 1, 2 ,3 ];
  var got = _.entityAssign( dst, src  );
  var expected = src;
  test.identical( got, expected );

  test.case = 'dst.set ';
  var dst = { set : function( src ){ this.value = src[ 'value' ]; } };
  var src = { value : 100 };
  _.entityAssign( dst, src  );
  var got = dst;
  var expected = { set : dst.set, value : 100 };
  test.identical( got, expected );

  test.case = 'onRecursive ';
  var dst = { };
  var src = { value : 100, a : {  b : 101 } };
  function onRecursive( dstContainer,srcContainer,key )
  {
    _.assert( _.strIs( key ) );
    dstContainer[ key ] = srcContainer[ key ];
  };
  _.entityAssign( dst, src, onRecursive  );
  var got = dst;
  var expected = src;
  test.identical( got, expected );

  test.case = 'atomic ';
  var src = 2;
  var got = _.entityAssign( null, src );
  var expected = src;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowErrorSync( function()
  {
    _.entityAssign( );
  });

  test.case = 'src.clone throws "unexpected"';
  test.shouldThrowErrorSync( function()
  {
    var dst = {};
    var src = { src : 'string', num : 123, clone : function() { var clone = _.cloneObject( { src : this } ); return clone; } }
    _.entityAssign( dst, src  );
  });

}

//

function entityAssignFieldFromContainer( test )
{

  test.case = 'non recursive';
  var dst ={};
  var src = { a : 'string' };
  var name = 'a';
  var got = _.entityAssignFieldFromContainer(dst, src, name );
  var expected = dst[ name ];
  test.identical( got, expected );

  test.case = 'undefined';
  var dst ={};
  var src = { a : undefined };
  var name = 'a';
  var got = _.entityAssignFieldFromContainer(dst, src, name );
  var expected = undefined;
  test.identical( got, expected );

  test.case = 'recursive';
  var dst ={};
  var src = { a : 'string' };
  var name = 'a';
  function onRecursive( dstContainer,srcContainer,key )
  {
    _.assert( _.strIs( key ) );
    dstContainer[ key ] = srcContainer[ key ];
  };
  var got = _.entityAssignFieldFromContainer(dst, src, name,onRecursive );
  var expected = dst[ name ];
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'argument missed';
  test.shouldThrowErrorSync( function()
  {
    _.entityAssignFieldFromContainer( );
  });

}

//

/*
qqq : improve test entityLength, normalize it, please | Dmytro : improved, normalized, extended
*/

function entityLength( test )
{
  test.case = 'undefined';
  var got = _.entityLength( undefined );
  test.identical( got, 0 );

  test.case = 'null';
  var got = _.entityLength( null );
  test.identical( got, 1 );

  test.case = 'false';
  var got = _.entityLength( false );
  test.identical( got, 1 );

  test.case = 'true';
  var got = _.entityLength( true );
  test.identical( got, 1 );

  test.case = 'zero';
  var got = _.entityLength( 0 );
  test.identical( got, 1 );

  test.case = 'number';
  var got = _.entityLength( 34 );
  test.identical( got, 1 );

  test.case = 'NaN';
  var got = _.entityLength( NaN );
  test.identical( got, 1 );

  test.case = 'Infinity';
  var got = _.entityLength( Infinity );
  test.identical( got, 1 );

  test.case = 'empty string';
  var got = _.entityLength( '' );
  test.identical( got, 1 );

  test.case = 'string';
  var got = _.entityLength( 'str' );
  test.identical( got, 1 );

  test.case = 'symbol';
  var got = _.entityLength( Symbol.for( 'x' ) );
  test.identical( got, 1 );

  test.case = 'empty array';
  var got = _.entityLength( [] );
  test.identical( got, 0 );

  test.case = 'array';
  var got = _.entityLength( [ [ 23, 17 ], undefined, 34 ] );
  test.identical( got, 3 );

  test.case = 'argumentsArray';
  var got = _.entityLength( _.argumentsArrayMake( [ 1, [ 2, 3 ], 4 ] ) );
  test.identical( got, 3 );

  test.case = 'unroll';
  var got = _.entityLength( _.argumentsArrayMake( [ 1, 2, [ 3, 4 ] ] ) );
  test.identical( got, 3 );

  test.case = 'BufferTyped';
  var got = _.entityLength( new U8x( [ 1, 2, 3, 4 ] ) );
  test.identical( got, 4 );

  test.case = 'BufferRaw';
  var got = _.entityLength( new BufferRaw( 10 ) );
  test.identical( got, 1 );

  test.case = 'BufferView';
  var got = _.entityLength( new BufferView( new BufferRaw( 10 ) ) );
  test.identical( got, 1 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'BufferNode';
    var got = _.entityLength( BufferNode.from( [ 1, 2, 3, 4 ] ) );
    test.identical( got, 4 );
  }

  test.case = 'Set';
  var got = _.entityLength( new Set( [ 1, 2, undefined, 4 ] ) );
  test.identical( got, 4 );

  test.case = 'map';
  var got = _.entityLength( { a : 1, b : 2, c : { d : 3 } } );
  test.identical( got, 3 );

  test.case = 'HashMap';
  var got = _.entityLength( new Map( [ [ undefined, undefined ], [ 1, 2 ], [ '', 'str' ] ] ) );
  test.identical( got, 3 );

  test.case = 'function';
  var got = _.entityLength( function(){} );
  test.identical( got, 1 );

  test.case = 'instance of class';
  function Constr1()
  {
    this.a = 34;
    this.b = 's';
    this[100] = 'sms';
  };
  Constr1.prototype.toString = function()
  {
    console.log('some message');
  }
  Constr1.prototype.c = 99;
  var got = _.entityLength( new Constr1() );
  test.identical( got, 3 );

  test.case = 'object, some properties are non enumerable';
  var src = Object.create( null );
  Object.defineProperties( src,
    {
      "property1" : {
        value : true,
        writable : true
      },
      "property2" : {
        value : "Hello",
        writable : true
      },
      "property3" : {
        enumerable : true,
        value : "World",
        writable : true
      }
  });
  var got = _.entityLength( src );
  test.identical( got, 1 );
}

//

function uncountableSize( test )
{
  test.case = 'undefined';
  var got = _.uncountableSize( undefined );
  test.identical( got, 8 );

  test.case = 'null';
  var got = _.uncountableSize( null );
  test.identical( got, 8 );

  test.case = 'false';
  var got = _.uncountableSize( false );
  test.identical( got,  8);

  test.case = 'true';
  var got = _.uncountableSize( true );
  test.identical( got, 8 );

  test.case = 'zero';
  var got = _.uncountableSize( 0 );
  test.identical( got, 8 );

  test.case = 'number';
  var got = _.uncountableSize( 34 );
  test.identical( got, 8 );

  test.case = 'NaN';
  var got = _.uncountableSize( NaN );
  test.identical( got, 8 );

  test.case = 'Infinity';
  var got = _.uncountableSize( Infinity );
  test.identical( got, 8 );

  test.case = 'empty string';
  var got = _.uncountableSize( '' );
  test.identical( got, 0 );

  test.case = 'string';
  var got = _.uncountableSize( 'str' );
  test.identical( got, 3 );

  test.case = 'symbol';
  var got = _.uncountableSize( Symbol.for( 'x' ) );
  test.identical( got, 8 );

  test.case = 'empty array';
  var got = _.uncountableSize( [] );
  test.identical( got, NaN );

  test.case = 'array';
  var got = _.uncountableSize( [ [ 23, 17 ], undefined, 34 ] );
  test.identical( got, NaN );

  test.case = 'argumentsArray';
  var got = _.uncountableSize( _.argumentsArrayMake( [ 1, [ 2, 3 ], 4 ] ) );
  test.identical( got, NaN );

  test.case = 'unroll';
  var got = _.uncountableSize( _.argumentsArrayMake( [ 1, 2, [ 3, 4 ] ] ) );
  test.identical( got, NaN );

  test.case = 'BufferTyped';
  var got = _.uncountableSize( new U8x( [ 1, 2, 3, 4 ] ) );
  test.identical( got, 4 );

  test.case = 'BufferRaw';
  var got = _.uncountableSize( new BufferRaw( 10 ) );
  test.identical( got, 10 );

  test.case = 'BufferView';
  var got = _.uncountableSize( new BufferView( new BufferRaw( 10 ) ) );
  test.identical( got, 10 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'BufferNode';
    var got = _.uncountableSize( BufferNode.from( [ 1, 2, 3, 4 ] ) );
    test.identical( got, 4 );
  }

  test.case = 'Set';
  var got = _.uncountableSize( new Set( [ 1, 2, undefined, 4 ] ) );
  test.identical( got, NaN );

  test.case = 'map';
  var got = _.uncountableSize( { a : 1, b : 2, c : { d : 3 } } );
  test.identical( got, NaN );

  test.case = 'HashMap';
  var got = _.uncountableSize( new Map( [ [ undefined, undefined ], [ 1, 2 ], [ '', 'str' ] ] ) );
  test.identical( got, NaN );

  test.case = 'function';
  var got = _.uncountableSize( function(){} );
  test.identical( got, 8 );

  test.case = 'instance of class';
  function Constr1()
  {
    this.a = 34;
    this.b = 's';
    this[100] = 'sms';
  };
  var got = _.uncountableSize( new Constr1() );
  test.identical( got, 8 );

  test.case = 'object, some properties are non enumerable';
  var src = Object.create( null );
  Object.defineProperties( src,
    {
      "property3" :
      {
        enumerable : true,
        value : "World",
        writable : true
      }
  });
  var got = _.uncountableSize( src );
  test.identical( got, NaN );

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.uncountableSize() );
}

//

/* zzz : find better solution instead of `_.look ?` */

function entitySize( test )
{
  test.case = 'undefined';
  var got = _.entitySize( undefined );
  test.identical( got, 8 );

  test.case = 'null';
  var got = _.entitySize( null );
  test.identical( got, 8 );

  test.case = 'false';
  var got = _.entitySize( false );
  test.identical( got,  8);

  test.case = 'true';
  var got = _.entitySize( true );
  test.identical( got, 8 );

  test.case = 'zero';
  var got = _.entitySize( 0 );
  test.identical( got, 8 );

  test.case = 'number';
  var got = _.entitySize( 34 );
  test.identical( got, 8 );

  test.case = 'NaN';
  var got = _.entitySize( NaN );
  test.identical( got, 8 );

  test.case = 'Infinity';
  var got = _.entitySize( Infinity );
  test.identical( got, 8 );

  test.case = 'empty string';
  var got = _.entitySize( '' );
  test.identical( got, 0 );

  test.case = 'string';
  var got = _.entitySize( 'str' );
  test.identical( got, 3 );

  test.case = 'symbol';
  var got = _.entitySize( Symbol.for( 'x' ) );
  test.identical( got, 8 );

  /* zzz : temp fix */

  test.case = 'empty array';
  var got = _.entitySize( [] );
  var exp = _.look ? 0 : NaN;
  test.identical( got, exp );

  test.case = 'array';
  var got = _.entitySize( [ 3, undefined, 34 ] );
  var exp = _.look ? 24 : NaN;
  test.identical( got, exp );

  test.case = 'argumentsArray';
  var got = _.entitySize( _.argumentsArrayMake( [ 1, null, 4 ] ) );
  var exp = _.look ? 24 : NaN;
  test.identical( got, exp );

  test.case = 'unroll';
  var got = _.entitySize( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var exp = _.look ? 19 : NaN;
  test.identical( got, exp );

  test.case = 'BufferTyped';
  var got = _.entitySize( new U8x( [ 1, 2, 3, 4 ] ) );
  test.identical( got, 4 );

  test.case = 'BufferRaw';
  var got = _.entitySize( new BufferRaw( 10 ) );
  test.identical( got, 10 );

  test.case = 'BufferView';
  var got = _.entitySize( new BufferView( new BufferRaw( 10 ) ) );
  test.identical( got, 10 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'BufferNode';
    var got = _.entitySize( BufferNode.from( [ 1, 2, 3, 4 ] ) );
    test.identical( got, 4 );
  }

  test.case = 'Set';
  var got = _.entitySize( new Set( [ 1, 2, undefined, 4 ] ) );
  var exp = _.look ? 32 : NaN;
  test.identical( got, exp );

  test.case = 'map';
  var got = _.entitySize( { a : 1, b : 2, c : 'str' } );
  var exp = _.look ? 19 : NaN;
  test.identical( got, exp );

  test.case = 'HashMap';
  var got = _.entitySize( new Map( [ [ undefined, undefined ], [ 1, 2 ], [ '', 'str' ] ] ) );
  var exp = _.look ? 19 : NaN;
  test.identical( got, exp );

  test.case = 'function';
  var got = _.entitySize( function(){} );
  test.identical( got, 8 );

  test.case = 'instance of class';
  function Constr1()
  {
    this.a = 34;
    this.b = 's';
    this[100] = 'sms';
  };
  var got = _.entitySize( new Constr1() );
  test.identical( got, 8 );

  test.case = 'object, some properties are non enumerable';
  var src = Object.create( null );
  Object.defineProperties( src,
    {
      "property3" :
      {
        enumerable : true,
        value : "World",
        writable : true
      }
  });
  var got = _.entitySize( src );
  var exp = _.look ? 5 : NaN;
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entitySize() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.entitySize( 1, 2 ) );
  test.shouldThrowErrorSync( () => _.entitySize( 1, 'extra' ) );
}

//

var Self =
{

  name : 'Tools.base.Entity',
  silencing : 1,

  tests :
  {

    entityMakeConstructing,
    entityMakeConstructingArgumentsArray,
    entityMakeConstructingBufferTyped,
    entityMakeConstructingLongDescriptor,
    entityMakeConstructingArgumentsArrayLongDescriptor,
    entityMakeConstructingBufferTypedLongDescriptor,

    entityMakeEmpty,
    entityMakeEmptyLongDescriptor,

    entityMakeUndefined,
    entityMakeUndefinedLongDescriptor,

    entityMake,
    entityMakeLongDescriptor,

    entityEntityEqualize,

    entityAssign,
    entityAssignFieldFromContainer,

    entityLength,
    uncountableSize,
    entitySize,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
