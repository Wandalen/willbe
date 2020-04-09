( function _Long_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer1.s' );
  _.include( 'wTesting' );
}

var _ = _global_.wTools;

//--
// arguments array
//--

function argumentsArrayMake( test )
{
  test.case = 'without arguments';
  var got = _.argumentsArrayMake();
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'src - null';
  var got = _.argumentsArrayMake( null );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'src - undefined';
  var got = _.argumentsArrayMake( undefined );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'src - number, zero';
  var got = _.argumentsArrayMake( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - number, src > 0';
  var got = _.argumentsArrayMake( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty array';
  var src = [];
  var got = _.argumentsArrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - array with single element';
  var src = [ 0 ];
  var got = _.argumentsArrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - array with several elements';
  var src = [ 1, 2, 3 ];
  var got = _.argumentsArrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty unroll';
  var src = _.unrollMake( [] );
  var got = _.argumentsArrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll with single element';
  var src = _.unrollMake( [ 0 ] );
  var got = _.argumentsArrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll with several elements';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.argumentsArrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.argumentsArrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - argumentsArray with single element';
  var src = _.argumentsArrayMake( [ 0 ] );
  var got = _.argumentsArrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - argumentsArray with several elements';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.argumentsArrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty BufferTyped';
  var src = new U8x( [] );
  var got = _.argumentsArrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - BufferTyped with single element';
  var src = new I16x( [ 0 ] );
  var got = _.argumentsArrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - BufferTyped with several elements';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.argumentsArrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.argumentsArrayMake( 1, 3 ) );
  test.shouldThrowErrorSync( () => _.argumentsArrayMake( [], 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.argumentsArrayMake( {} ) );
  test.shouldThrowErrorSync( () => _.argumentsArrayMake( 'wrong' ) );
}

//

function argumentsArrayFrom( test )
{
  test.case = 'src - null';
  var got = _.argumentsArrayFrom( null );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'src - undefined';
  var got = _.argumentsArrayFrom( undefined );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'src - number, zero';
  var got = _.argumentsArrayFrom( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - number, src > 0';
  var got = _.argumentsArrayFrom( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty array';
  var src = [];
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - array with single element';
  var src = [ 0 ];
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - array with several elements';
  var src = [ 1, 2, 3 ];
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty unroll';
  var src = _.unrollMake( [] );
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll with single element';
  var src = _.unrollMake( [ 0 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - unroll with several elements';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src - empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'src - argumentsArray with single element';
  var src = _.argumentsArrayMake( [ 0 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'src - argumentsArray with several elements';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  /* */

  test.case = 'src - empty BufferTyped';
  var src = new U8x( [] );
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - BufferTyped with single element';
  var src = new I16x( [ 0 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src - BufferTyped with several elements';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.argumentsArrayFrom() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.argumentsArrayFrom( 1, 3 ) );
  test.shouldThrowErrorSync( () => _.argumentsArrayFrom( [], 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.argumentsArrayFrom( {} ) );
  test.shouldThrowErrorSync( () => _.argumentsArrayFrom( 'wrong' ) );
}

//--
// long
//--

function longIs( test )
{
  test.case = 'an empty array';
  var got = _.longIs( [] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.longIs( [ 1, 2, 3 ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'a pseudo array';
  var got = _.longIs( arguments );
  var expected = true;
  test.identical( got, expected );

  test.case = 'raw array buffer';
  var got = _.longIs( new BufferRaw( 10 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'typed array buffer';
  var got = _.longIs( new F32x( 10 ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'no argument';
  var got = _.longIs();
  var expected  = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.longIs( null );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'function';
  var got = _.longIs( function() {} );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.longIs( 'x' );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.longIs( 1 );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'boolean';
  var got = _.longIs( true );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.longIs( {} );
  var expected  = false;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;
}

//

/* aaa : implement */
/* Dmytro : implemented */
/* aaa : no! */
/* Dmytro : improved test routines, split on separate types, tested with default longDescriptor and with no default */

function longMakeWithArrayAndUnroll( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _.longMake( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _.longMake( 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _.longMake( 5, null );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins = number';
    var got = _.longMake( null, 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _.longMake( 5, undefined );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = _.longMake( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src );
    var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = _.longMake( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'src = long, ins = null';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src, null );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src, 2 );
    var expected = makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src, 4 );
    // var expected = long( [ 1, 2, 3, undefined ] )
    var expected = makeLong( [ 1, 2, 3, undefined ] )
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'ins = long, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.longMake( src, ins );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'src = new long, ins = array'
    var src = makeLong( 2 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.longMake( src, ins );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = null';
    var got = _.longMake( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = number';
    var got = _.longMake( Array, 3 );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = long';
    var ins = makeLong( [ 1, 1, 1, 1, 1 ] );
    var got = _.longMake( U32x, ins );
    var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== ins );

    /* aaa : make sure each _.longMake, _.longForm, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long constructor, ins = null';
    var src = makeLong( 5 );
    var got = _.longMake( src.constructor, null );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( got !== ins );

    test.case = 'src = long constructor, ins = undefined';
    var src = makeLong( 5 );
    var got = _.longMake( src.constructor, undefined );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== ins );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longMake() );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.longMake( [ 1, 2, 3 ], 4, 'extra argument' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.longMake( 'wrong argument', 1 ) );
  test.shouldThrowErrorSync( () => _.longMake( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.longMake( new BufferRaw( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _.longMake( ( e ) => { return { [ e ] : e } }, 5 ) );
  if( Config.interpreter === 'njs' )
  {
    test.shouldThrowErrorSync( () => _.longMake( Array, BufferNode.from( [ 3 ] ) ) );
    test.shouldThrowErrorSync( () => _.longMake( BufferNode.alloc( 3 ), 2 ) );
  }

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.longMake( [ 1, 2, 3 ], 'wrong type of argument' ) );
  test.shouldThrowErrorSync( () => _.longMake( [ 1, 2, 3 ], Infinity  ) );
}

//

function longMakeWithArgumentsArray( test )
{
  test.case = 'src = null, not ins';
  var got = _.longMake( null );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src = number, not ins';
  var got = _.longMake( 5 );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = number, ins = null';
  var got = _.longMake( 5, null );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = null, ins = number';
  var got = _.longMake( null, 5 );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = number, ins = undefined';
  var got = _.longMake( 5, undefined );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = empty long, not ins';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMake( src );
  var expected = _.longDescriptor.make( [] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, not ins';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMake( src );
  var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
  test.identical( got, expected );
  test.identical( got.length, 3 );
  test.is( got !== src );

  test.case = 'src = empty long, ins = number';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMake( src, 2 );
  var expected = _.longDescriptor.make( 2 );
  test.identical( got, expected );
  test.is( got !== src );
  test.is( _.arrayIs( got ) );

  test.case = 'src = long, ins = null';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMake( src, null );
  var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
  test.identical( got, expected );
  test.is( got !== src );
  test.is( _.arrayIs( got ) );

  test.case = 'ins = number, ins < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMake( src, 2 );
  var expected = _.longDescriptor.make( [ 1, 2 ] );
  test.identical( got, expected );
  test.is( got !== src );
  test.is( _.arrayIs( got ) );

  test.case = 'ins = number, ins > src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMake( src, 4 );
  var expected = _.longDescriptor.make( [ 1, 2, 3, undefined ] )
  test.identical( got, expected );
  test.is( got !== src );
  test.is( _.arrayIs( got ) );

  test.case = 'ins = long, ins.length > src.length';
  var src = _.argumentsArrayMake( [ 0, 1 ] );
  var ins = [ 1, 2, 3 ];
  var got = _.longMake( src, ins );
  var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
  test.identical( got, expected );
  test.is( got !== ins );
  test.is( got !== src );
  test.is( _.arrayIs( got ) );

  test.case = 'src = new long, ins = array'
  var src = _.argumentsArrayMake( 2 );
  var ins = [ 1, 2, 3, 4, 5 ];
  var got = _.longMake( src, ins );
  var expected = _.longDescriptor.make( [ 1, 2, 3, 4, 5 ] );
  test.identical( got, expected );
  test.is( got !== src );
  test.is( _.arrayIs( got ) );

  test.case = 'src = Array constructor, ins = null';
  var got = _.longMake( Array, null );
  var expected = [];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  test.case = 'src = Array constructor, ins = number';
  var got = _.longMake( Array, 3 );
  var expected = [ undefined, undefined, undefined ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  test.case = 'src = BufferTyped constructor, ins = long';
  var ins = _.argumentsArrayMake( [ 1, 1, 1, 1, 1 ] );
  var got = _.longMake( U32x, ins );
  var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs(  got ) );
  test.is( got !== ins );
}

//

function longMakeWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _.longMake( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _.longMake( 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _.longMake( 5, null );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins = number';
    var got = _.longMake( null, 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _.longMake( 5, undefined );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = _.longMake( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src );
    var expected = _.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = _.longMake( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'src = long, ins = null';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src, null );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src, 2 );
    var expected = new makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMake( src, 4 );
    // var expected = new long( [ 1, 2, 3, 0 ] )
    var expected = new makeLong( [ 1, 2, 3, 0 ] )
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'ins = long, ins.length > src.length';
    var src = new makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.longMake( src, ins );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'src = new long, ins = array'
    var src = new makeLong( 2 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.longMake( src, ins );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'src = Array constructor, ins = null';
    var got = _.longMake( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = number';
    var got = _.longMake( Array, 3 );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = long';
    var ins = new makeLong( [ 1, 1, 1, 1, 1 ] );
    var got = _.longMake( U32x, ins );
    var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== ins );

    /* aaa : make sure each _.longMake, _.longForm, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long constructor, ins = null';
    var src = new makeLong( 5 );
    var got = _.longMake( src.constructor, null );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( got !== ins );

    test.case = 'src = long constructor, ins = undefined';
    var src = new makeLong( 5 );
    var got = _.longMake( src.constructor, undefined );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== ins );
  }
}

//

function longMakeWithArrayAndUnrollLongDescriptor( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor.longMake( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMake( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMake( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins = number';
    var got = descriptor.longMake( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMake( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = descriptor.longMake( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = descriptor.longMake( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'src = long, ins = null';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, null );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, 2 );
    var expected = makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, 4 );
    // var expected = long( [ 1, 2, 3, undefined ] )
    var expected = makeLong( [ 1, 2, 3, undefined ] )
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'ins = long, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMake( src, ins );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'src = new long, ins = array'
    var src = makeLong( 2 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMake( src, ins );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMake( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = number';
    var got = descriptor.longMake( Array, 3 );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = long';
    var ins = makeLong( [ 1, 1, 1, 1, 1 ] );
    var got = descriptor.longMake( U32x, ins );
    var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== ins );

    /* aaa : make sure each descriptor.longMake, _.longForm, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long constructor, ins = null';
    var src = makeLong( 5 );
    var got = descriptor.longMake( src.constructor, null );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( got !== ins );

    test.case = 'src = long constructor, ins = undefined';
    var src = makeLong( 5 );
    var got = descriptor.longMake( src.constructor, undefined );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== ins );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.longMake() );

      test.case = 'extra argument';
      test.shouldThrowErrorSync( () => descriptor.longMake( [ 1, 2, 3 ], 4, 'extra argument' ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.longMake( 'wrong argument', 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMake( 1, 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMake( new BufferRaw( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longMake( ( e ) => { return { [ e ] : e } }, 5 ) );
      if( Config.interpreter === 'njs' )
      {
        test.shouldThrowErrorSync( () => descriptor.longMake( Array, BufferNode.from( [ 3 ] ) ) );
        test.shouldThrowErrorSync( () => descriptor.longMake( BufferNode.alloc( 3 ), 2 ) );
      }

      test.case = 'wrong type of ins';
      test.shouldThrowErrorSync( () => descriptor.longMake( [ 1, 2, 3 ], 'wrong type of argument' ) );
      test.shouldThrowErrorSync( () => descriptor.longMake( [ 1, 2, 3 ], Infinity  ) );
    }
  }
}

longMakeWithArrayAndUnrollLongDescriptor.timeOut = 15000;

//

function longMakeWithArgumentsArrayLongDescriptor( test )
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
    test.case = 'src = null, not ins';
    var got = descriptor.longMake( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMake( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMake( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins = number';
    var got = descriptor.longMake( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMake( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMake( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, ins = number';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMake( src, 2 );
    var expected = descriptor.longDescriptor.make( 2 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = null';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, null );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );

    test.case = 'ins = number, ins < src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, 2 );
    var expected = descriptor.longDescriptor.make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'ins = number, ins > src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, 4 );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3, undefined ] )
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'ins = long, ins.length > src.length';
    var src = _.argumentsArrayMake( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMake( src, ins );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );

    test.case = 'src = new long, ins = array'
    var src = _.argumentsArrayMake( 2 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMake( src, ins );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMake( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = number';
    var got = descriptor.longMake( Array, 3 );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = long';
    var ins = _.argumentsArrayMake( [ 1, 1, 1, 1, 1 ] );
    var got = descriptor.longMake( U32x, ins );
    var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== ins );
  }
}

longMakeWithArgumentsArrayLongDescriptor.timeOut = 10000;

//

function longMakeWithBufferTypedLongDescriptor( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor.longMake( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMake( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMake( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins = number';
    var got = descriptor.longMake( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMake( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = descriptor.longMake( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src );
    var expected = descriptor.longDescriptor.make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = descriptor.longMake( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'src = long, ins = null';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, null );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, 2 );
    var expected = new makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMake( src, 4 );
    // var expected = new long( [ 1, 2, 3, 0 ] )
    var expected = new makeLong( [ 1, 2, 3, 0 ] )
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'ins = long, ins.length > src.length';
    var src = new makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMake( src, ins );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'src = new long, ins = array'
    var src = new makeLong( 2 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMake( src, ins );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( _.bufferTypedIs( got ) );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMake( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = Array constructor, ins = number';
    var got = descriptor.longMake( Array, 3 );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = long';
    var ins = new makeLong( [ 1, 1, 1, 1, 1 ] );
    var got = descriptor.longMake( U32x, ins );
    var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== ins );

    /* aaa : make sure each descriptor.longMake, _.longForm, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long constructor, ins = null';
    var src = new makeLong( 5 );
    var got = descriptor.longMake( src.constructor, null );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( got !== ins );

    test.case = 'src = long constructor, ins = undefined';
    var src = new makeLong( 5 );
    var got = descriptor.longMake( src.constructor, undefined );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== ins );
  }
}

longMakeWithBufferTypedLongDescriptor.timeOut = 20000;

//

function longMakeEmptyWithArrayAndUnroll( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
    Array,
  ];

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'without arguments';
    var got = _.longMakeEmpty();
    var expected = _.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - null';
    var got = _.longMakeEmpty( null );
    var expected = _.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - empty long';
    var src = makeLong( [] );
    var got = _.longMakeEmpty( src );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src - filled long';
    var src = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longMakeEmpty( src );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.longMakeEmpty( [ 1, 2, 3 ], 'extra argument' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.longMakeEmpty( 1 ) );
  test.shouldThrowErrorSync( () => _.longMakeEmpty( undefined ) );
  test.shouldThrowErrorSync( () => _.longMakeEmpty( 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longMakeEmpty( new BufferRaw( 3 ) ) );
  if( Config.interpreter === 'njs' )
  test.shouldThrowErrorSync( () => _.longMakeEmpty( BufferNode.alloc( 3 ) ) );
}

//

function longMakeEmptyWithArgumentsArray( test )
{
  test.case = 'without arguments';
  var got = _.longMakeEmpty();
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );

  test.case = 'src - null';
  var got = _.longMakeEmpty( null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );

  test.case = 'src - empty long';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeEmpty( src );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src - filled long';
  var src = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longMakeEmpty( src );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );
  test.is( got !== src );
}

//

function longMakeEmptyWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'without arguments';
    var got = _.longMakeEmpty();
    var expected = _.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - null';
    var got = _.longMakeEmpty( null );
    var expected = _.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - empty long';
    var src = new makeLong( [] );
    var got = _.longMakeEmpty( src );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src - filled long';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longMakeEmpty( src );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
  }
}

//

function longMakeEmptyWithArrayAndUnrollLongDescriptor( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
    Array,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'without arguments';
    var got = descriptor.longMakeEmpty();
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - null';
    var got = descriptor.longMakeEmpty( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - empty long';
    var src = makeLong( [] );
    var got = descriptor.longMakeEmpty( src );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src - filled long';
    var src = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = descriptor.longMakeEmpty( src );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    /* - */

    if( Config.debug )
    {
      test.case = 'extra argument';
      test.shouldThrowErrorSync( () => descriptor.longMakeEmpty( [ 1, 2, 3 ], 'extra argument' ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.longMakeEmpty( 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeEmpty( undefined ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeEmpty( 'wrong argument' ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeEmpty( new BufferRaw( 3 ) ) );
      if( Config.interpreter === 'njs' )
      test.shouldThrowErrorSync( () => descriptor.longMakeEmpty( BufferNode.alloc( 3 ) ) );
    }
  }
}

longMakeEmptyWithArrayAndUnrollLongDescriptor.timeOut = 20000;

//

function longMakeEmptyWithArgumentsArrayLongDescriptor( test )
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
    test.case = 'without arguments';
    var got = descriptor.longMakeEmpty();
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - null';
    var got = descriptor.longMakeEmpty( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - empty long';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeEmpty( src );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src - filled long';
    var src = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
    var got = descriptor.longMakeEmpty( src );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );
    test.is( got !== src );
  }
}

//

function longMakeEmptyWithBufferTypedLongDescriptor( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'without arguments';
    var got = descriptor.longMakeEmpty();
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - null';
    var got = descriptor.longMakeEmpty( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src - empty long';
    var src = new makeLong( [] );
    var got = descriptor.longMakeEmpty( src );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src - filled long';
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = descriptor.longMakeEmpty( src );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
  }
}

longMakeEmptyWithBufferTypedLongDescriptor.timeOut = 20000;

//

function _longMakeOfLengthWithArrayAndUnroll( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    testRun( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _._longMakeOfLength( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _._longMakeOfLength( 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _._longMakeOfLength( 5, null );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _._longMakeOfLength( 5, undefined );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = _._longMakeOfLength( null, 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = _._longMakeOfLength( null, makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = _._longMakeOfLength( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( src );
    var expected = makeLong( 3 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = empty long, ins = null';
    var src = makeLong( [] );
    var got = _._longMakeOfLength( src, null );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = makeLong( 10 );
    var got = _._longMakeOfLength( src.constructor, 4 );
    var expected = makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = _._longMakeOfLength( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( src, 2 );
    var expected = makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _._longMakeOfLength( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( src, 4 );
    var expected = makeLong( [ 1, 2, 3, undefined ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _._longMakeOfLength( src, ins );
    var expected = makeLong( [ 0, 1, undefined ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _._longMakeOfLength( src, ins );
    var expected = makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = _._longMakeOfLength( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = _._longMakeOfLength( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _._longMakeOfLength() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _._longMakeOfLength( [ 1, 2, 3 ], 4, 'extra argument' ) );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _._longMakeOfLength( 'wrong argument', 1 ) );
  test.shouldThrowErrorSync( () => _._longMakeOfLength( 1, 1 ) );
  test.shouldThrowErrorSync( () => _._longMakeOfLength( BufferNode.alloc( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _._longMakeOfLength( new BufferRaw( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _._longMakeOfLength( Array, BufferNode.from( [ 3 ] ) ) );

  test.case = 'wrong type of len';
  test.shouldThrowErrorSync( () => _._longMakeOfLength( [ 1, 2, 3 ], 'wrong type of argument' ) );
  test.shouldThrowErrorSync( () => _._longMakeOfLength( [ 1, 2, 3 ], Infinity ) );
}

//

function _longMakeOfLengthWithArgumentsArray( test )
{
  test.case = 'src = null, not ins';
  var got = _._longMakeOfLength( null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );

  test.case = 'src = number, not ins';
  var got = _._longMakeOfLength( 5 );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = number, ins = null';
  var got = _._longMakeOfLength( 5, null );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = number, ins = undefined';
  var got = _._longMakeOfLength( 5, undefined );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = null, ins - number';
  var got = _._longMakeOfLength( null, 5 );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = null, ins - long';
  var got = _._longMakeOfLength( null, _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] ) );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = empty long, not ins';
  var src = _.argumentsArrayMake( [] );
  var got = _._longMakeOfLength( src );
  var expected = _.longDescriptor.make( [] );
  test.identical( got, expected );

  test.case = 'src = long, not ins';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _._longMakeOfLength( src );
  var expected = _.longDescriptor.make( 3 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = null';
  var src = _.argumentsArrayMake( [] );
  var got = _._longMakeOfLength( src, null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = number';
  var src = _.argumentsArrayMake( [] );
  var got = _._longMakeOfLength( src, 2 );
  var expected = _.longDescriptor.make( 2 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _._longMakeOfLength( src, 2 );
  var expected = _.longDescriptor.make( 2 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long with an element, ins = empty array';
  var src = new F64x( 10 );
  var got = _._longMakeOfLength( src, [] );
  var expected = new F64x( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins > src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _._longMakeOfLength( src, 4 );
  var expected = _.longDescriptor.make( 4 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length > src.length';
  var src = _.argumentsArrayMake( [ 0, 1 ] );
  var ins = [ 1, 2, 3 ];
  var got = _._longMakeOfLength( src, ins );
  var expected = _.longDescriptor.make( 3 );
  test.identical( got, expected );
  test.is( got !== ins );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length === src.length'
  var src = _.argumentsArrayMake( 5 );
  var ins = [ 1, 2, 3, 4, 5 ];
  var got = _._longMakeOfLength( src, ins );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = Array constructor, ins = null';
  var got = _._longMakeOfLength( Array, null );
  var expected = [];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  test.case = 'src = BufferTyped constructor, ins = number';
  var got = _._longMakeOfLength( U32x, 5 );
  var expected = new U32x( 5 );
  test.identical( got, expected );
  test.is( _.bufferTypedIs(  got ) );

  test.case = 'src = Array constructor, ins = long';
  var ins = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _._longMakeOfLength( Array, ins );
  var expected = [ undefined, undefined, undefined ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( got !== ins );
}

//

function _longMakeOfLengthWithBufferTyped( test )
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

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _._longMakeOfLength( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _._longMakeOfLength( 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _._longMakeOfLength( 5, null );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _._longMakeOfLength( 5, undefined );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = _._longMakeOfLength( null, 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = _._longMakeOfLength( null, new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = _._longMakeOfLength( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( src );
    var expected = _.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name !== got.constructor.name );

    test.case = 'src = empty long, ins = null';
    var src = new makeLong( [] );
    var got = _._longMakeOfLength( src, null );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = new makeLong( 10 );
    var got = _._longMakeOfLength( src.constructor, 4 );
    var expected = new makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = _._longMakeOfLength( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( src, 2 );
    var expected = new makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _._longMakeOfLength( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( src, 4 );
    var expected = new makeLong( [ 1, 2, 3, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _._longMakeOfLength( src, ins );
    var expected = new makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = _._longMakeOfLength( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = _._longMakeOfLength( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = new makeLong( [ 1, 2, 3 ] );
    var got = _._longMakeOfLength( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

//

function _longMakeOfLengthWithArrayAndUnrollLongDescriptor( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor._longMakeOfLength( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor._longMakeOfLength( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor._longMakeOfLength( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor._longMakeOfLength( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor._longMakeOfLength( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor._longMakeOfLength( null, makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = descriptor._longMakeOfLength( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = makeLong( [] );
    var got = descriptor._longMakeOfLength( src, null );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = makeLong( 10 );
    var got = descriptor._longMakeOfLength( src.constructor, 4 );
    var expected = makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = descriptor._longMakeOfLength( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src, 2 );
    var expected = makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor._longMakeOfLength( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src, 4 );
    var expected = makeLong( [ 1, 2, 3, undefined ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor._longMakeOfLength( src, ins );
    var expected = makeLong( [ 0, 1, undefined ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor._longMakeOfLength( src, ins );
    var expected = makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor._longMakeOfLength( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor._longMakeOfLength( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( [ 1, 2, 3 ], 4, 'extra argument' ) );

      test.case = 'wrong type of ins';
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( 'wrong argument', 1 ) );
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( 1, 1 ) );
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( BufferNode.alloc( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( new BufferRaw( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( Array, BufferNode.from( [ 3 ] ) ) );

      test.case = 'wrong type of len';
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( [ 1, 2, 3 ], 'wrong type of argument' ) );
      test.shouldThrowErrorSync( () => descriptor._longMakeOfLength( [ 1, 2, 3 ], Infinity ) );
    }
  }
}

_longMakeOfLengthWithArrayAndUnrollLongDescriptor.timeOut = 20000;

//

function _longMakeOfLengthWithArgumentsArrayLongDescriptor( test )
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
    test.case = 'src = null, not ins';
    var got = descriptor._longMakeOfLength( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor._longMakeOfLength( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor._longMakeOfLength( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor._longMakeOfLength( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor._longMakeOfLength( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor._longMakeOfLength( null, _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor._longMakeOfLength( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor._longMakeOfLength( src, null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor._longMakeOfLength( src, 2 );
    var expected = descriptor.longDescriptor.make( 2 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src, 2 );
    var expected = descriptor.longDescriptor.make( 2 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor._longMakeOfLength( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src, 4 );
    var expected = descriptor.longDescriptor.make( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = _.argumentsArrayMake( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor._longMakeOfLength( src, ins );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = _.argumentsArrayMake( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor._longMakeOfLength( src, ins );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor._longMakeOfLength( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor._longMakeOfLength( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

//

function _longMakeOfLengthWithBufferTypedLongDescriptor( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor._longMakeOfLength( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor._longMakeOfLength( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor._longMakeOfLength( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor._longMakeOfLength( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor._longMakeOfLength( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor._longMakeOfLength( null, new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = descriptor._longMakeOfLength( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = new makeLong( [] );
    var got = descriptor._longMakeOfLength( src, null );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = new makeLong( 10 );
    var got = descriptor._longMakeOfLength( src.constructor, 4 );
    var expected = new makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = descriptor._longMakeOfLength( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src, 2 );
    var expected = new makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor._longMakeOfLength( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( src, 4 );
    var expected = new makeLong( [ 1, 2, 3, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor._longMakeOfLength( src, ins );
    var expected = new makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor._longMakeOfLength( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor._longMakeOfLength( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor._longMakeOfLength( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

_longMakeOfLengthWithBufferTypedLongDescriptor.timeOut = 20000;

//

/* aaa : implement */
/* Dmytro : implemented */
/* aaa : no! */
/* Dmytro : improved test routines, split on separate types, tested with default longDescriptor and with no default */

function longMakeUndefinedWithArrayAndUnroll( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    testRun( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    /* aaa : thouse routines are too makeLong code to be such routine. use function nameOfRoutine(){} an move it out of run */
    /* aaa : bad names of routines. not clear what it does */
    /* aaa : bad names of routines. don't use nouns for routines */
    /* Dmytro : improved test routines, split on separate types, tested with default longDescriptor and with no default, removed unnacessary function and variables */

    test.case = 'src = null, not ins';
    var got = _.longMakeUndefined( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _.longMakeUndefined( 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _.longMakeUndefined( 5, null );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _.longMakeUndefined( 5, undefined );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = _.longMakeUndefined( null, 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = _.longMakeUndefined( null, makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = _.longMakeUndefined( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );
    /* aaa : analyze and fix that */
    /* Dmytro : this test case is the same as above. That is src defines only length, but longDescriptor defines type */
    // test.isNot( src.constructor.name === got.constructor.name );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( src );
    var expected = makeLong( 3 );
    test.identical( got, expected );
    test.is( got !== src );
    /* aaa : improve this line. make it proepr + redable */
    /* Dmytro : line below not use strange subroutine */
    test.is( src.constructor.name === got.constructor.name );

    /* aaa : make sure each _.longMake, _.longFrom, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = empty long, ins = null';
    var src = makeLong( [] );
    var got = _.longMakeUndefined( src, null );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    /* aaa : make sure each _.longMake, _.longFrom, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long, ins = number';
    var src = makeLong( 10 );
    var got = _.longMakeUndefined( src.constructor, 4 );
    var expected = makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = _.longMakeUndefined( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    /* aaa : make sure each _.longMake, _.longFrom, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _.longMakeUndefined( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    /* aaa : make sure each _.longMake, _.longFrom, _.arrayMake, _.arrayFrom test routine has the same test case */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = long, ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( src, 4 );
    var expected = makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.longMakeUndefined( src, ins );
    var expected = makeLong( 3 );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.longMakeUndefined( src, ins );
    var expected = makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = _.longMakeUndefined( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    /* aaa : there are no such arguments */
    /* aaa : make sure all similar test routines has good naming of variables */
    /* Dmytro : each test routine that accepts two arguments has this test case */
    test.case = 'src = BufferTyped constructor, ins = number';
    var got = _.longMakeUndefined( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longMakeUndefined() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longMakeUndefined( [ 1, 2, 3 ], 4, 'extra argument' ) );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.longMakeUndefined( 'wrong argument', 1 ) );
  test.shouldThrowErrorSync( () => _.longMakeUndefined( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.longMakeUndefined( BufferNode.alloc( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _.longMakeUndefined( new BufferRaw( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _.longMakeUndefined( Array, BufferNode.from( [ 3 ] ) ) );

  test.case = 'wrong type of len';
  test.shouldThrowErrorSync( () => _.longMakeUndefined( [ 1, 2, 3 ], 'wrong type of argument' ) );
  test.shouldThrowErrorSync( () => _.longMakeUndefined( [ 1, 2, 3 ], Infinity ) );
}

//

function longMakeUndefinedWithArgumentsArray( test )
{
  test.case = 'src = null, not ins';
  var got = _.longMakeUndefined( null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );

  test.case = 'src = number, not ins';
  var got = _.longMakeUndefined( 5 );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = number, ins = null';
  var got = _.longMakeUndefined( 5, null );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = number, ins = undefined';
  var got = _.longMakeUndefined( 5, undefined );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = null, ins - number';
  var got = _.longMakeUndefined( null, 5 );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = null, ins - long';
  var got = _.longMakeUndefined( null, _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] ) );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );

  test.case = 'src = empty long, not ins';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeUndefined( src );
  var expected = _.longDescriptor.make( [] );
  test.identical( got, expected );

  test.case = 'src = long, not ins';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeUndefined( src );
  var expected = _.longDescriptor.make( 3 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = null';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeUndefined( src, null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = number';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeUndefined( src, 2 );
  var expected = _.longDescriptor.make( 2 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeUndefined( src, 2 );
  var expected = _.longDescriptor.make( 2 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long with an element, ins = empty array';
  var src = new F64x( 10 );
  var got = _.longMakeUndefined( src, [] );
  var expected = new F64x( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins > src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeUndefined( src, 4 );
  var expected = _.longDescriptor.make( 4 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length > src.length';
  var src = _.argumentsArrayMake( [ 0, 1 ] );
  var ins = [ 1, 2, 3 ];
  var got = _.longMakeUndefined( src, ins );
  var expected = _.longDescriptor.make( 3 );
  test.identical( got, expected );
  test.is( got !== ins );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length === src.length'
  var src = _.argumentsArrayMake( 5 );
  var ins = [ 1, 2, 3, 4, 5 ];
  var got = _.longMakeUndefined( src, ins );
  var expected = _.longDescriptor.make( 5 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = Array constructor, ins = null';
  var got = _.longMakeUndefined( Array, null );
  var expected = [];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  test.case = 'src = BufferTyped constructor, ins = number';
  var got = _.longMakeUndefined( U32x, 5 );
  var expected = new U32x( 5 );
  test.identical( got, expected );
  test.is( _.bufferTypedIs(  got ) );

  test.case = 'src = Array constructor, ins = long';
  var ins = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeUndefined( Array, ins );
  var expected = [ undefined, undefined, undefined ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( got !== ins );
}

//

function longMakeUndefinedWithBufferTyped( test )
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

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _.longMakeUndefined( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _.longMakeUndefined( 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _.longMakeUndefined( 5, null );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _.longMakeUndefined( 5, undefined );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = _.longMakeUndefined( null, 5 );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = _.longMakeUndefined( null, new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = _.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = _.longMakeUndefined( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( src );
    var expected = _.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name !== got.constructor.name );

    test.case = 'src = empty long, ins = null';
    var src = new makeLong( [] );
    var got = _.longMakeUndefined( src, null );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = new makeLong( 10 );
    var got = _.longMakeUndefined( src.constructor, 4 );
    var expected = new makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = _.longMakeUndefined( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _.longMakeUndefined( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( src, 4 );
    var expected = new makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = new makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.longMakeUndefined( src, ins );
    var expected = new makeLong( 3 );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.longMakeUndefined( src, ins );
    var expected = new makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = _.longMakeUndefined( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = _.longMakeUndefined( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

//

function longMakeUndefinedWithArrayAndUnrollLongDescriptor( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor.longMakeUndefined( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMakeUndefined( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMakeUndefined( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMakeUndefined( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor.longMakeUndefined( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor.longMakeUndefined( null, makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = descriptor.longMakeUndefined( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = makeLong( [] );
    var got = descriptor.longMakeUndefined( src, null );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = makeLong( 10 );
    var got = descriptor.longMakeUndefined( src.constructor, 4 );
    var expected = makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = descriptor.longMakeUndefined( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src, 2 );
    var expected = makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.longMakeUndefined( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src, 4 );
    var expected = makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMakeUndefined( src, ins );
    var expected = makeLong( 3 );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMakeUndefined( src, ins );
    var expected = makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMakeUndefined( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor.longMakeUndefined( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( [ 1, 2, 3 ], 4, 'extra argument' ) );

      test.case = 'wrong type of ins';
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( 'wrong argument', 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( 1, 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( BufferNode.alloc( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( new BufferRaw( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( Array, BufferNode.from( [ 3 ] ) ) );

      test.case = 'wrong type of len';
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( [ 1, 2, 3 ], 'wrong type of argument' ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeUndefined( [ 1, 2, 3 ], Infinity ) );
    }
  }
}

longMakeUndefinedWithArrayAndUnrollLongDescriptor.timeOut = 20000;

//

function longMakeUndefinedWithArgumentsArrayLongDescriptor( test )
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
    test.case = 'src = null, not ins';
    var got = descriptor.longMakeUndefined( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMakeUndefined( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMakeUndefined( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMakeUndefined( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor.longMakeUndefined( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor.longMakeUndefined( null, _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeUndefined( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeUndefined( src, null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeUndefined( src, 2 );
    var expected = descriptor.longDescriptor.make( 2 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src, 2 );
    var expected = descriptor.longDescriptor.make( 2 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.longMakeUndefined( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src, 4 );
    var expected = descriptor.longDescriptor.make( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = _.argumentsArrayMake( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMakeUndefined( src, ins );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = _.argumentsArrayMake( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMakeUndefined( src, ins );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMakeUndefined( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor.longMakeUndefined( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

//

function longMakeUndefinedWithBufferTypedLongDescriptor( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor.longMakeUndefined( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMakeUndefined( 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMakeUndefined( 5, null );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMakeUndefined( 5, undefined );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor.longMakeUndefined( null, 5 );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor.longMakeUndefined( null, new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( 5 );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = descriptor.longMakeUndefined( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src );
    var expected = descriptor.longDescriptor.make( 3 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = new makeLong( [] );
    var got = descriptor.longMakeUndefined( src, null );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = new makeLong( 10 );
    var got = descriptor.longMakeUndefined( src.constructor, 4 );
    var expected = new makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = descriptor.longMakeUndefined( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src, 2 );
    var expected = new makeLong( 2 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.longMakeUndefined( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( src, 4 );
    var expected = new makeLong( 4 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = new makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMakeUndefined( src, ins );
    var expected = new makeLong( 3 );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMakeUndefined( src, ins );
    var expected = new makeLong( 5 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMakeUndefined( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor.longMakeUndefined( U32x, 5 );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeUndefined( Array, ins );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

longMakeUndefinedWithBufferTypedLongDescriptor.timeOut = 20000;

//

/* aaa : implement Zeroed routine and test routine */
/* Dmytro : routine longMakeZeroed and its test routine is implemented */
/* aaa : no! */
/* Dmytro : improved test routines, split on separate types, tested with default longDescriptor and with no default */

//

function longMakeZeroedWithArrayAndUnroll( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    testRun( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _.longMakeZeroed( null );
    var expected = _.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _.longMakeZeroed( 5 );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _.longMakeZeroed( 5, null );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _.longMakeZeroed( 5, undefined );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = _.longMakeZeroed( null, 5 );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = _.longMakeZeroed( null, makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = _.longMakeZeroed( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( src );
    var expected = makeLong( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = empty long, ins = null';
    var src = makeLong( [] );
    var got = _.longMakeZeroed( src, null );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = makeLong( 10 );
    var got = _.longMakeZeroed( src.constructor, 4 );
    var expected = makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = _.longMakeZeroed( src, 2 );
    var expected = makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( src, 2 );
    var expected = makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _.longMakeZeroed( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( src, 4 );
    var expected = makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.longMakeZeroed( src, ins );
    var expected = makeLong( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.longMakeZeroed( src, ins );
    var expected = makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = _.longMakeZeroed( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = _.longMakeZeroed( U32x, 5 );
    var expected = new U32x( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( Array, ins );
    var expected = [ 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longMakeZeroed() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longMakeZeroed( [ 1, 2, 3 ], 4, 'extra argument' ) );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.longMakeZeroed( 'wrong argument', 1 ) );
  test.shouldThrowErrorSync( () => _.longMakeZeroed( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.longMakeZeroed( BufferNode.alloc( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _.longMakeZeroed( new BufferRaw( 3 ), 2 ) );
  test.shouldThrowErrorSync( () => _.longMakeZeroed( Array, BufferNode.from( [ 3 ] ) ) );

  test.case = 'wrong type of len';
  test.shouldThrowErrorSync( () => _.longMakeZeroed( [ 1, 2, 3 ], 'wrong type of argument' ) );
  test.shouldThrowErrorSync( () => _.longMakeZeroed( [ 1, 2, 3 ], Infinity ) );
}

//

function longMakeZeroedWithArgumentsArray( test )
{
  test.case = 'src = null, not ins';
  var got = _.longMakeZeroed( null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );

  test.case = 'src = number, not ins';
  var got = _.longMakeZeroed( 5 );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );

  test.case = 'src = number, ins = null';
  var got = _.longMakeZeroed( 5, null );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );

  test.case = 'src = number, ins = undefined';
  var got = _.longMakeZeroed( 5, undefined );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );

  test.case = 'src = null, ins - number';
  var got = _.longMakeZeroed( null, 5 );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );

  test.case = 'src = null, ins - long';
  var got = _.longMakeZeroed( null, _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] ) );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );

  test.case = 'src = empty long, not ins';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeZeroed( src );
  var expected = _.longDescriptor.make( [] );
  test.identical( got, expected );

  test.case = 'src = long, not ins';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeZeroed( src );
  var expected = _.longDescriptor.make( [ 0, 0, 0 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = null';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeZeroed( src, null );
  var expected = _.longDescriptor.make( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = empty long, ins = number';
  var src = _.argumentsArrayMake( [] );
  var got = _.longMakeZeroed( src, 2 );
  var expected = _.longDescriptor.make( [ 0, 0 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeZeroed( src, 2 );
  var expected = _.longDescriptor.make( [ 0, 0 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long with an element, ins = empty array';
  var src = new F64x( 10 );
  var got = _.longMakeZeroed( src, [] );
  var expected = new F64x( 0 );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = number, ins > src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeZeroed( src, 4 );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length > src.length';
  var src = _.argumentsArrayMake( [ 0, 1 ] );
  var ins = [ 1, 2, 3 ];
  var got = _.longMakeZeroed( src, ins );
  var expected = _.longDescriptor.make( [ 0, 0, 0 ] );
  test.identical( got, expected );
  test.is( got !== ins );
  test.is( got !== src );

  test.case = 'src = long, ins = array, ins.length === src.length'
  var src = _.argumentsArrayMake( 5 );
  var ins = [ 1, 2, 3, 4, 5 ];
  var got = _.longMakeZeroed( src, ins );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.is( got !== src );

  test.case = 'src = Array constructor, ins = null';
  var got = _.longMakeZeroed( Array, null );
  var expected = [];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  test.case = 'src = BufferTyped constructor, ins = number';
  var got = _.longMakeZeroed( U32x, 5 );
  var expected = new U32x( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs(  got ) );

  test.case = 'src = Array constructor, ins = long';
  var ins = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.longMakeZeroed( Array, ins );
  var expected = [ 0, 0, 0 ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( got !== ins );
}

//

function longMakeZeroedWithBufferTyped( test )
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

  function testRun( makeLong )
  {
    test.case = 'src = null, not ins';
    var got = _.longMakeZeroed( null );
    var expected = _.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = _.longMakeZeroed( 5 );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = _.longMakeZeroed( 5, null );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = _.longMakeZeroed( 5, undefined );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = _.longMakeZeroed( null, 5 );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = _.longMakeZeroed( null, new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = _.longMakeZeroed( src );
    var expected = _.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( src );
    var expected = _.longDescriptor.make( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name !== got.constructor.name );

    test.case = 'src = empty long, ins = null';
    var src = new makeLong( [] );
    var got = _.longMakeZeroed( src, null );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = new makeLong( 10 );
    var got = _.longMakeZeroed( src.constructor, 4 );
    var expected = new makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = _.longMakeZeroed( src, 2 );
    var expected = new makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( src, 2 );
    var expected = new makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = _.longMakeZeroed( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( src, 4 );
    var expected = new makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = new makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = _.longMakeZeroed( src, ins );
    var expected = new makeLong( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = _.longMakeZeroed( src, ins );
    var expected = new makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = _.longMakeZeroed( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = _.longMakeZeroed( U32x, 5 );
    var expected = new U32x( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = new makeLong( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( Array, ins );
    var expected = [ 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

//

function longMakeZeroedWithArrayAndUnrollLongDescriptor( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor.longMakeZeroed( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMakeZeroed( 5 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMakeZeroed( 5, null );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMakeZeroed( 5, undefined );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor.longMakeZeroed( null, 5 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor.longMakeZeroed( null, makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = makeLong( [] );
    var got = descriptor.longMakeZeroed( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = makeLong( [] );
    var got = descriptor.longMakeZeroed( src, null );
    var expected = makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = makeLong( 10 );
    var got = descriptor.longMakeZeroed( src.constructor, 4 );
    var expected = makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = makeLong( [] );
    var got = descriptor.longMakeZeroed( src, 2 );
    var expected = makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src, 2 );
    var expected = makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.longMakeZeroed( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src, 4 );
    var expected = makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMakeZeroed( src, ins );
    var expected = makeLong( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMakeZeroed( src, ins );
    var expected = makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMakeZeroed( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor.longMakeZeroed( U32x, 5 );
    var expected = new U32x( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( Array, ins );
    var expected = [ 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( [ 1, 2, 3 ], 4, 'extra argument' ) );

      test.case = 'wrong type of ins';
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( 'wrong argument', 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( 1, 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( BufferNode.alloc( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( new BufferRaw( 3 ), 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( Array, BufferNode.from( [ 3 ] ) ) );

      test.case = 'wrong type of len';
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( [ 1, 2, 3 ], 'wrong type of argument' ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeZeroed( [ 1, 2, 3 ], Infinity ) );
    }
  }
}

longMakeZeroedWithArrayAndUnrollLongDescriptor.timeOut = 20000;

//

function longMakeZeroedWithArgumentsArrayLongDescriptor( test )
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
    test.case = 'src = null, not ins';
    var got = descriptor.longMakeZeroed( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMakeZeroed( 5 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMakeZeroed( 5, null );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMakeZeroed( 5, undefined );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor.longMakeZeroed( null, 5 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor.longMakeZeroed( null, _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeZeroed( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeZeroed( src, null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longMakeZeroed( src, 2 );
    var expected = descriptor.longDescriptor.make( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src, 2 );
    var expected = descriptor.longDescriptor.make( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.longMakeZeroed( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src, 4 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = _.argumentsArrayMake( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMakeZeroed( src, ins );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = _.argumentsArrayMake( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMakeZeroed( src, ins );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMakeZeroed( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor.longMakeZeroed( U32x, 5 );
    var expected = new U32x( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = _.argumentsArrayMake( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( Array, ins );
    var expected = [ 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

//

function longMakeZeroedWithBufferTypedLongDescriptor( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  /* tests */

  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    let descriptor = _.withDefaultLong[ name ];

    for( let i = 0; i < list.length; i++ )
    {
      test.open( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
      testRun( descriptor, list[ i ] );
      test.close( `descriptor - ${ name }, makeLong - ${ list[ i ].name }` );
    }

    if( times < 1 )
    break;
    times--;
  }

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'src = null, not ins';
    var got = descriptor.longMakeZeroed( null );
    var expected = descriptor.longDescriptor.make( 0 );
    test.identical( got, expected );

    test.case = 'src = number, not ins';
    var got = descriptor.longMakeZeroed( 5 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = null';
    var got = descriptor.longMakeZeroed( 5, null );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = number, ins = undefined';
    var got = descriptor.longMakeZeroed( 5, undefined );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - number';
    var got = descriptor.longMakeZeroed( null, 5 );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = null, ins - long';
    var got = descriptor.longMakeZeroed( null, new makeLong( [ 1, 2, 3, 4, 5 ] ) );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    test.case = 'src = empty long, not ins';
    var src = new makeLong( [] );
    var got = descriptor.longMakeZeroed( src );
    var expected = descriptor.longDescriptor.make( [] );
    test.identical( got, expected );

    test.case = 'src = long, not ins';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = null';
    var src = new makeLong( [] );
    var got = descriptor.longMakeZeroed( src, null );
    var expected = new makeLong( 0 );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number';
    var src = new makeLong( 10 );
    var got = descriptor.longMakeZeroed( src.constructor, 4 );
    var expected = new makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = empty long, ins = number';
    var src = new makeLong( [] );
    var got = descriptor.longMakeZeroed( src, 2 );
    var expected = new makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = number, ins < src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src, 2 );
    var expected = new makeLong( [ 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long with an element, ins = empty array';
    var src = new F64x( 10 );
    var got = descriptor.longMakeZeroed( src, [] );
    var expected = new F64x( 0 );
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'src = long, ins = number, ins > src.length';
    var src = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( src, 4 );
    var expected = new makeLong( [ 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length > src.length';
    var src = new makeLong( [ 0, 1 ] );
    var ins = [ 1, 2, 3 ];
    var got = descriptor.longMakeZeroed( src, ins );
    var expected = new makeLong( [ 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== ins );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = long, ins = array, ins.length === src.length'
    var src = new makeLong( 5 );
    var ins = [ 1, 2, 3, 4, 5 ];
    var got = descriptor.longMakeZeroed( src, ins );
    var expected = new makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== src );
    test.is( src.constructor.name === got.constructor.name );

    test.case = 'src = Array constructor, ins = null';
    var got = descriptor.longMakeZeroed( Array, null );
    var expected = [];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );

    test.case = 'src = BufferTyped constructor, ins = number';
    var got = descriptor.longMakeZeroed( U32x, 5 );
    var expected = new U32x( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs(  got ) );

    test.case = 'src = Array constructor, ins = long';
    var ins = new makeLong( [ 1, 2, 3 ] );
    var got = descriptor.longMakeZeroed( Array, ins );
    var expected = [ 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.arrayIs( got ) );
    test.is( got !== ins );
  }
}

longMakeZeroedWithBufferTypedLongDescriptor.timeOut = 20000;

//

function longMakeFillingWithArrayAndUnroll( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
  ];

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    testRun( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function testRun( makeLong )
  {
    test.case = 'value - null, length - number';
    var got = _.longMakeFilling( null, 5 );
    var expected = _.longDescriptor.make( [ null, null, null, null, null ] );
    test.identical( got, expected );

    test.case = `value - zero, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( 0, makeLong( 5 ) );
    var expected = makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    /* */

    test.case = 'type - null, value - string, length - number';
    var got = _.longMakeFilling( null, 'str', 5 );
    var expected = _.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = 'type - null, value - string, length - BufferTyped';
    var got = _.longMakeFilling( null, 'str', new U8x( 5 ) );
    var expected = _.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - number`;
    var got = _.longMakeFilling( makeLong( 0 ).constructor, [ 1 ], 3 );
    var expected = makeLong( [ [ 1 ], [ 1 ], [ 1 ] ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - empty ${ makeLong.name }`;
    var got = _.longMakeFilling( makeLong( 0 ).constructor, [ 1 ], makeLong( 0 ) );
    var expected = makeLong( [] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - number`;
    var got = _.longMakeFilling( makeLong( 0 ), { a : 1 }, 3 );
    var expected = makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( makeLong( 0 ), { a : 1 }, makeLong( 3 ) );
    var expected = makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - U8x, value - number, length - number`;
    var got = _.longMakeFilling( U8x, 10, 3 );
    var expected = new U8x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - I16x, value - number, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( I16x, 10, makeLong( 3 ) );
    var expected = new I16x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - F32x instance, value - number, length - number`;
    var got = _.longMakeFilling( new F32x( 10 ), 10, 3 );
    var expected = new F32x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - F32x instance, value - number, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( new F32x( 10 ), 10, makeLong( 3 ) );
    var expected = new F32x( [ 10, 10, 10 ] );
    test.identical( got, expected );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longMakeFilling() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.longMakeFilling( null ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longMakeFilling( [ 1, 2, 3 ], 4, 4, 'extra' ) );

  test.case = 'wrong type of type argument';
  test.shouldThrowErrorSync( () => _.longMakeFilling( {}, 2, 2 ) );
  test.shouldThrowErrorSync( () => _.longMakeFilling( undefined, 2, 2 ) );

  test.case = 'wrong type of value';
  test.shouldThrowErrorSync( () => _.longMakeFilling( undefined, 1 ) );
  test.shouldThrowErrorSync( () => _.longMakeFilling( [], undefined, 1 ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.longMakeFilling( [ 1, 2, 3 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longMakeFilling( [ 1, 2, 3 ], 2, undefined ) );
}

//

function longMakeFillingWithArgumentsArray( test )
{
  test.case = 'value - null, length - number';
  var got = _.longMakeFilling( null, 5 );
  var expected = _.longDescriptor.make( [ null, null, null, null, null ] );
  test.identical( got, expected );

  test.case = `value - zero, length - ArgumentsArray`;
  var got = _.longMakeFilling( 0, _.argumentsArrayMake( 5 ) );
  var expected = _.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
  test.identical( got, expected );

  /* */

  test.case = 'type - null, value - string, length - number';
  var got = _.longMakeFilling( null, 'str', 5 );
  var expected = _.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
  test.identical( got, expected );

  test.case = 'type - null, value - string, length - ArgumentsArray';
  var got = _.longMakeFilling( null, 'str', _.argumentsArrayMake( 5 ) );
  var expected = _.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
  test.identical( got, expected );

  test.case = `type - ArgumentsArray instance, value - map, length - number`;
  var got = _.longMakeFilling( _.argumentsArrayMake( 0 ), { a : 1 }, 3 );
  var expected = _.longDescriptor.make( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
  test.identical( got, expected );

  test.case = `type - ArgumentsArray instance, value - map, length - ArgumentsArray`;
  var got = _.longMakeFilling( _.argumentsArrayMake( 0 ), { a : 1 }, _.argumentsArrayMake( 3 ) );
  var expected = _.longDescriptor.make( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
  test.identical( got, expected );

  test.case = `type - U8x, value - number, length - number`;
  var got = _.longMakeFilling( U8x, 10, 3 );
  var expected = new U8x( [ 10, 10, 10 ] );
  test.identical( got, expected );

  test.case = `type - I16x, value - number, length - ArgumentsArray`;
  var got = _.longMakeFilling( I16x, 10, _.argumentsArrayMake( 3 ) );
  var expected = new I16x( [ 10, 10, 10 ] );
  test.identical( got, expected );

  test.case = `type - F32x instance, value - number, length - number`;
  var got = _.longMakeFilling( new F32x( 10 ), 10, 3 );
  var expected = new F32x( [ 10, 10, 10 ] );
  test.identical( got, expected );

  test.case = `type - F32x instance, value - number, length - ArgumentsArray`;
  var got = _.longMakeFilling( new F32x( 10 ), 10, _.argumentsArrayMake( 3 ) );
  var expected = new F32x( [ 10, 10, 10 ] );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = `type - ArgumentsArray constructor, value - array, length - number`;
  test.shouldThrowErrorSync( () => _.longMakeFilling( _.argumentsArrayMake( 0 ).constructor, [ 1 ], 3 ) );
}

//

function longMakeFillingWithBufferTyped( test )
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


  function testRun( makeLong )
  {
    test.case = 'value - null, length - number';
    var got = _.longMakeFilling( null, 5 );
    var expected = _.longDescriptor.make( [ null, null, null, null, null ] );
    test.identical( got, expected );

    test.case = `value - zero, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( 0, new makeLong( 5 ) );
    var expected = new makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    /* */

    test.case = 'type - null, value - string, length - number';
    var got = _.longMakeFilling( null, 'str', 5 );
    var expected = _.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = 'type - null, value - string, length - BufferTyped';
    var got = _.longMakeFilling( null, 'str', new U8x( 5 ) );
    var expected = _.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - number`;
    var got = _.longMakeFilling( new makeLong, [ 1 ], 3 );
    var expected = new makeLong( [ [ 1 ], [ 1 ], [ 1 ] ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - empty ${ makeLong.name }`;
    var got = _.longMakeFilling( new makeLong, [ 1 ], new makeLong( 0 ) );
    var expected = new makeLong( [] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - number`;
    var got = _.longMakeFilling( new makeLong( 0 ), { a : 1 }, 3 );
    var expected = new makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( new makeLong( 0 ), { a : 1 }, new makeLong( 3 ) );
    var expected = new makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - Array, value - number, length - number`;
    var got = _.longMakeFilling( Array, 10, 3 );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );

    test.case = `type - Array, value - number, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( Array, 10, new makeLong( 3 ) );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );

    test.case = `type - Array instance, value - number, length - number`;
    var got = _.longMakeFilling( new Array( 10 ), 10, 3 );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );

    test.case = `type - Array instance, value - number, length - ${ makeLong.name }`;
    var got = _.longMakeFilling( new Array( 10 ), 10, new makeLong( 3 ) );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );
  }
}

//

function longMakeFillingWithArrayAndUnrollLongDescriptor( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var longConstr = function( src )
  {
    if( src )
    return _.longDescriptor.make( src );
    return _.longDescriptor.make( 0 );
  }
  var list =
  [
    array,
    unroll,
    longConstr,
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

  function testRun( descriptor, makeLong )
  {
    test.case = 'value - null, length - number';
    var got = descriptor.longMakeFilling( null, 5 );
    var expected = descriptor.longDescriptor.make( [ null, null, null, null, null ] );
    test.identical( got, expected );

    test.case = `value - zero, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( 0, makeLong( 5 ) );
    var expected = makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    /* */

    test.case = 'type - null, value - string, length - number';
    var got = descriptor.longMakeFilling( null, 'str', 5 );
    var expected = descriptor.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = 'type - null, value - string, length - BufferTyped';
    var got = descriptor.longMakeFilling( null, 'str', new U8x( 5 ) );
    var expected = descriptor.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - number`;
    var got = descriptor.longMakeFilling( makeLong( 0 ).constructor, [ 1 ], 3 );
    var expected = makeLong( [ [ 1 ], [ 1 ], [ 1 ] ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - empty ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( makeLong( 0 ).constructor, [ 1 ], makeLong( 0 ) );
    var expected = makeLong( [] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - number`;
    var got = descriptor.longMakeFilling( makeLong( 0 ), { a : 1 }, 3 );
    var expected = makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( makeLong( 0 ), { a : 1 }, makeLong( 3 ) );
    var expected = makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - U8x, value - number, length - number`;
    var got = descriptor.longMakeFilling( U8x, 10, 3 );
    var expected = new U8x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - I16x, value - number, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( I16x, 10, makeLong( 3 ) );
    var expected = new I16x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - F32x instance, value - number, length - number`;
    var got = descriptor.longMakeFilling( new F32x( 10 ), 10, 3 );
    var expected = new F32x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - F32x instance, value - number, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( new F32x( 10 ), 10, makeLong( 3 ) );
    var expected = new F32x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling() );

      test.case = 'not enough arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( null ) );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( [ 1, 2, 3 ], 4, 4, 'extra' ) );

      test.case = 'wrong type of type argument';
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( {}, 2, 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( undefined, 2, 2 ) );

      test.case = 'wrong type of value';
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( undefined, 1 ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( [], undefined, 1 ) );

      test.case = 'wrong type of length';
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( [ 1, 2, 3 ], 'wrong' ) );
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( [ 1, 2, 3 ], 2, undefined ) );
    }
  }
}

longMakeFillingWithArrayAndUnrollLongDescriptor.timeOut = 15000;

//

function longMakeFillingWithArgumentsArrayLongDescriptor( test )
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

  /* test subroutine */

  function testRun( descriptor )
  {
    test.case = 'value - null, length - number';
    var got = descriptor.longMakeFilling( null, 5 );
    var expected = descriptor.longDescriptor.make( [ null, null, null, null, null ] );
    test.identical( got, expected );

    test.case = `value - zero, length - ArgumentsArray`;
    var got = descriptor.longMakeFilling( 0, _.argumentsArrayMake( 5 ) );
    var expected = descriptor.longDescriptor.make( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    /* */

    test.case = 'type - null, value - string, length - number';
    var got = descriptor.longMakeFilling( null, 'str', 5 );
    var expected = descriptor.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = 'type - null, value - string, length - ArgumentsArray';
    var got = descriptor.longMakeFilling( null, 'str', _.argumentsArrayMake( 5 ) );
    var expected = descriptor.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = `type - ArgumentsArray instance, value - map, length - number`;
    var got = descriptor.longMakeFilling( _.argumentsArrayMake( 0 ), { a : 1 }, 3 );
    var expected = descriptor.longDescriptor.make( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - ArgumentsArray instance, value - map, length - ArgumentsArray`;
    var got = descriptor.longMakeFilling( _.argumentsArrayMake( 0 ), { a : 1 }, _.argumentsArrayMake( 3 ) );
    var expected = descriptor.longDescriptor.make( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - U8x, value - number, length - number`;
    var got = descriptor.longMakeFilling( U8x, 10, 3 );
    var expected = new U8x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - I16x, value - number, length - ArgumentsArray`;
    var got = descriptor.longMakeFilling( I16x, 10, _.argumentsArrayMake( 3 ) );
    var expected = new I16x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - F32x instance, value - number, length - number`;
    var got = descriptor.longMakeFilling( new F32x( 10 ), 10, 3 );
    var expected = new F32x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    test.case = `type - F32x instance, value - number, length - ArgumentsArray`;
    var got = descriptor.longMakeFilling( new F32x( 10 ), 10, _.argumentsArrayMake( 3 ) );
    var expected = new F32x( [ 10, 10, 10 ] );
    test.identical( got, expected );

    /* */

    if( Config.debug )
    {
      test.case = `type - ArgumentsArray constructor, value - array, length - number`;
      test.shouldThrowErrorSync( () => descriptor.longMakeFilling( _.argumentsArrayMake( 0 ).constructor, [ 1 ], 3 ) );
    }
  }
}

//

function longMakeFillingWithBufferTypedLongDescriptor( test )
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

  function testRun( descriptor, makeLong )
  {
    test.case = 'value - null, length - number';
    var got = descriptor.longMakeFilling( null, 5 );
    var expected = descriptor.longDescriptor.make( [ null, null, null, null, null ] );
    test.identical( got, expected );

    test.case = `value - zero, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( 0, new makeLong( 5 ) );
    var expected = new makeLong( [ 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );

    /* */

    test.case = 'type - null, value - string, length - number';
    var got = descriptor.longMakeFilling( null, 'str', 5 );
    var expected = descriptor.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = 'type - null, value - string, length - BufferTyped';
    var got = descriptor.longMakeFilling( null, 'str', new U8x( 5 ) );
    var expected = descriptor.longDescriptor.make( [ 'str', 'str', 'str', 'str', 'str' ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - number`;
    var got = descriptor.longMakeFilling( new makeLong, [ 1 ], 3 );
    var expected = new makeLong( [ [ 1 ], [ 1 ], [ 1 ] ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } constructor, value - array, length - empty ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( new makeLong, [ 1 ], new makeLong( 0 ) );
    var expected = new makeLong( [] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - number`;
    var got = descriptor.longMakeFilling( new makeLong( 0 ), { a : 1 }, 3 );
    var expected = new makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - ${ makeLong.name } instance, value - map, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( new makeLong( 0 ), { a : 1 }, new makeLong( 3 ) );
    var expected = new makeLong( [ { a : 1 }, { a : 1 }, { a : 1 } ] );
    test.identical( got, expected );

    test.case = `type - Array, value - number, length - number`;
    var got = descriptor.longMakeFilling( Array, 10, 3 );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );

    test.case = `type - Array, value - number, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( Array, 10, new makeLong( 3 ) );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );

    test.case = `type - Array instance, value - number, length - number`;
    var got = descriptor.longMakeFilling( new Array( 10 ), 10, 3 );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );

    test.case = `type - Array instance, value - number, length - ${ makeLong.name }`;
    var got = descriptor.longMakeFilling( new Array( 10 ), 10, new makeLong( 3 ) );
    var expected = new Array( 10, 10, 10 );
    test.identical( got, expected );
  }
}

longMakeFillingWithBufferTypedLongDescriptor.timeOut = 15000;

//

function longFrom( test )
{
  test.case = 'null';
  var src = null;
  var got = _.longFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'number';
  var src = 2;
  var got = _.longFrom( src );
  test.identical( got, [ undefined, undefined ] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty array';
  var src = [];
  var got = _.longFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got === src );

  test.case = 'filled array';
  var src = [ 1, '', 'abc', undefined, null, false, true, 0 ];
  var got = _.longFrom( src );
  test.identical( got, [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got === src );

  test.case = 'empty unroll';
  var src = _.unrollMake( [] );
  var got = _.longFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled unroll';
  var src = _.unrollMake( [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  var got = _.longFrom( src );
  test.identical( got, [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.longFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled argumentsArray';
  var src = _.argumentsArrayMake( [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  var got = _.longFrom( src );
  test.identical( got, [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'empty BufferTyped';
  var src = new U8x( [] );
  var got = _.longFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  var src = new I16x( [] );
  var got = _.longFrom( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferTyped';
  var src = new F32x( [ 1, 2, 3, 4, 0 ] );
  var got = _.longFrom( src );
  test.identical( got, [ 1, 2, 3, 4, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  var src = new F64x( [ 1, 2, 3, 4, 0 ] );
  var got = _.longFrom( src );
  test.identical( got, [ 1, 2, 3, 4, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longFrom() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longFrom( 1, [] ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.longFrom( undefined ) );
  test.shouldThrowErrorSync( () => _.longFrom( 'str' ) );
  test.shouldThrowErrorSync( () => _.longFrom( { 1 : 2 } ) );
}

//

function longFromLongDescriptor( test )
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
    var src = null;
    var got = descriptor.longFrom( src );
    var exp = descriptor.longDescriptor.make( 0 );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'number';
    var src = 2;
    var got = descriptor.longFrom( src );
    var exp = descriptor.longDescriptor.make( 2 );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'empty array';
    var src = [];
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? [] : descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled array';
    var src = [ 1, 2, 3, 4, 0 ];
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? [ 1, 2, 3, 4, 0 ] : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'empty unroll';
    var src = _.unrollMake( [] );
    var got = descriptor.longFrom( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src !== got );

    test.case = 'filled unroll';
    var src = _.unrollMake( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFrom( src );
    var exp = descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src !== got );

    test.case = 'empty argumentsArray';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longFrom( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled argumentsArray';
    var src = _.argumentsArrayMake( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? _.argumentsArrayMake( [ 1, 2, 3, 4, 0 ] ) : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'empty BufferTyped';
    var src = new U8x( [] );
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new U8x( [] ) : descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    var src = new I16x( [] );
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new I16x( [] ) : descriptor.longDescriptor.make( [] );;
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled BufferTyped';
    var src = new F32x( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new F32x( [ 1, 2, 3, 4, 0 ] ) : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    var src = new F64x( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFrom( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new F64x( [ 1, 2, 3, 4, 0 ] ) : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.longFrom() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.longFrom( 1, [] ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.longFrom( undefined ) );
      test.shouldThrowErrorSync( () => descriptor.longFrom( 'str' ) );
      test.shouldThrowErrorSync( () => descriptor.longFrom( { 1 : 2 } ) );
    }
  }
}

//

function longFromCoercing( test )
{
  test.case = 'string without number literals';
  var src = 'a b c';
  var got = _.longFromCoercing( src );
  test.identical( got, [ NaN, NaN, NaN ] );
  test.is( _.arrayIs( got ) );

  test.case = 'string with number literals';
  var src = '0 12 345 5678';
  var got = _.longFromCoercing( src );
  test.identical( got, [ 0, 12, 345, 5678 ] );
  test.is( _.arrayIs( got ) );

  test.case = 'string with number literals, has not number literals';
  var src = '0 12, 345 a5678';
  var got = _.longFromCoercing( src );
  test.identical( got, [ 0, 12, 345, NaN ] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty map';
  var src = {};
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'filled map';
  var src = { a : 1, b : 2, 3 : 'd' };
  var got = _.longFromCoercing( src );
  test.identical( got, [ [ '3', 'd' ], [ 'a', 1 ], [ 'b', 2 ] ] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty pure map';
  var src = Object.create( null );
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'filled map';
  var src = Object.create( null );
  src.a = 1;
  src.b = 2;
  src[ 3 ] = 'd';
  var got = _.longFromCoercing( src );
  test.identical( got, [ [ '3', 'd' ], [ 'a', 1 ], [ 'b', 2 ] ] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty object from constructor';
  var Constr = function(){ return this };
  var src = new Constr();
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  test.case = 'object with properties, from constructor';
  var Constr = function(){ this.a = 2; this.b = 3; return this };
  var src = new Constr();
  var got = _.longFromCoercing( src );
  test.identical( got, [ [ 'a', 2 ], [ 'b', 3 ] ] );
  test.is( _.arrayIs( got ) );

  test.case = 'empty array';
  var src = [];
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got === src );

  test.case = 'filled array';
  var src = [ 1, '', 'abc', undefined, null, false, true, 0 ];
  var got = _.longFromCoercing( src );
  test.identical( got, [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got === src );

  test.case = 'empty unroll';
  var src = _.unrollMake( [] );
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got === src );

  test.case = 'filled unroll';
  var src = _.unrollMake( [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  var got = _.longFromCoercing( src );
  test.identical( got, [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got === src );

  test.case = 'empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled argumentsArray';
  var src = _.argumentsArrayMake( [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  var got = _.longFromCoercing( src );
  test.identical( got, [ 1, '', 'abc', undefined, null, false, true, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'empty BufferTyped';
  var src = new U8x( [] );
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  var src = new I16x( [] );
  var got = _.longFromCoercing( src );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferTyped';
  var src = new F32x( [ 1, 2, 3, 4, 0 ] );
  var got = _.longFromCoercing( src );
  test.identical( got, [ 1, 2, 3, 4, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  var src = new F64x( [ 1, 2, 3, 4, 0 ] );
  var got = _.longFromCoercing( src );
  test.identical( got, [ 1, 2, 3, 4, 0 ] );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longFromCoercing() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longFromCoercing( 1, [] ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.longFromCoercing( null ) );
  test.shouldThrowErrorSync( () => _.longFromCoercing( undefined ) );
  test.shouldThrowErrorSync( () => _.longFromCoercing( 2 ) );
  test.shouldThrowErrorSync( () => _.longFromCoercing( new Set() ) );
}

//

function longFromCoercingLongDescriptor( test )
{
  let times = 4;
  for( let e in _.LongDescriptors )
  {
    let name = _.LongDescriptors[ e ].name;
    if( name === 'ArgumentsArray' )
    continue;
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
    test.case = 'string without number literals';
    var src = 'a b c';
    var got = descriptor.longFromCoercing( src );
    var exp = _.bufferTypedIs( got ) ? descriptor.longDescriptor.make( [ 0, 0, 0 ] ) : descriptor.longDescriptor.make( [ NaN, NaN, NaN ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'string with number literals';
    var src = '0 12 345 5678';
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [ 0, 12, 345, 5678 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'string with number literals, has not number literals';
    var src = '0 12, 345 a5678';
    var got = descriptor.longFromCoercing( src );
    var exp = _.bufferTypedIs( got ) ? descriptor.longDescriptor.make( [ 0, 12, 345, 0 ] ) : descriptor.longDescriptor.make( [ 0, 12, 345, NaN ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'empty map';
    var src = {};
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'filled map';
    var src = { a : 1, b : 2, 3 : 'd' };
    var got = descriptor.longFromCoercing( src );
    var exp = _.bufferTypedIs( got ) ? descriptor.longDescriptor.make( [ 0, 0, 0 ] ) : descriptor.longDescriptor.make( [ [ '3', 'd' ], [ 'a', 1 ], [ 'b', 2 ] ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'empty pure map';
    var src = Object.create( null );
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'filled map';
    var src = Object.create( null );
    src.a = 1;
    src.b = 2;
    src[ 3 ] = 'd';
    var got = descriptor.longFromCoercing( src );
    var exp = _.bufferTypedIs( got ) ? descriptor.longDescriptor.make( [ 0, 0, 0 ] ) : descriptor.longDescriptor.make( [ [ '3', 'd' ], [ 'a', 1 ], [ 'b', 2 ] ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'empty object from constructor';
    var Constr = function(){ return this };
    var src = new Constr();
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'object with properties, from constructor';
    var Constr = function(){ this.a = 2; this.b = 3; return this };
    var src = new Constr();
    var got = descriptor.longFromCoercing( src );
    var exp = _.bufferTypedIs( got ) ? descriptor.longDescriptor.make( [ 0, 0 ] ) : descriptor.longDescriptor.make( [ [ 'a', 2 ], [ 'b', 3 ] ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );

    test.case = 'empty array';
    var src = [];
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? [] : descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled array';
    var src = [ 1, 2, 3, 4, 0 ];
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? [ 1, 2, 3, 4, 0 ] : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'empty unroll';
    var src = _.unrollMake( [] );
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled unroll';
    var src = _.unrollMake( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'empty argumentsArray';
    var src = _.argumentsArrayMake( [] );
    var got = descriptor.longFromCoercing( src );
    var exp = descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled argumentsArray';
    var src = _.argumentsArrayMake( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? _.argumentsArrayMake( [ 1, 2, 3, 4, 0 ] ) : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'empty BufferTyped';
    var src = new U8x( [] );
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new U8x( [] ) : descriptor.longDescriptor.make( [] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    var src = new I16x( [] );
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new I16x( [] ) : descriptor.longDescriptor.make( [] );;
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    test.case = 'filled BufferTyped';
    var src = new F32x( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new F32x( [ 1, 2, 3, 4, 0 ] ) : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    var src = new F64x( [ 1, 2, 3, 4, 0 ] );
    var got = descriptor.longFromCoercing( src );
    var exp = src instanceof descriptor.longDescriptor.type ? new F64x( [ 1, 2, 3, 4, 0 ] ) : descriptor.longDescriptor.make( [ 1, 2, 3, 4, 0 ] );
    test.identical( got, exp );
    test.is( got instanceof descriptor.longDescriptor.type );
    test.is( src instanceof descriptor.longDescriptor.type ? src === got : src !== got );

    /* - */

    if( Config.debug )
    {
      test.case = 'without arguments';
      test.shouldThrowErrorSync( () => descriptor.longFromCoercing() );

      test.case = 'extra arguments';
      test.shouldThrowErrorSync( () => descriptor.longFromCoercing( 1, [] ) );

      test.case = 'wrong type of src';
      test.shouldThrowErrorSync( () => descriptor.longFromCoercing( null ) );
      test.shouldThrowErrorSync( () => descriptor.longFromCoercing( undefined ) );
      test.shouldThrowErrorSync( () => descriptor.longFromCoercing( 2 ) );
      test.shouldThrowErrorSync( () => descriptor.longFromCoercing( new Set() ) );
    }
  }
}

//

function longFromCoercingArgumentsArrayLongDescriptor( test )
{
  let descriptor = _.withDefaultLong.ArgumentsArray;

  /* */

  test.case = 'string without number literals';
  var src = 'a b c';
  var got = descriptor.longFromCoercing( src );
  var exp = [ NaN, NaN, NaN ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'string with number literals';
  var src = '0 12 345 5678';
  var got = descriptor.longFromCoercing( src );
  var exp = [ 0, 12, 345, 5678 ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'string with number literals, has not number literals';
  var src = '0 12, 345 a5678';
  var got = descriptor.longFromCoercing( src );
  var exp = [ 0, 12, 345, NaN ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'empty map';
  var src = {};
  var got = descriptor.longFromCoercing( src );
  var exp = [];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'filled map';
  var src = { a : 1, b : 2, 3 : 'd' };
  var got = descriptor.longFromCoercing( src );
  var exp = [ [ '3', 'd' ], [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'empty pure map';
  var src = Object.create( null );
  var got = descriptor.longFromCoercing( src );
  var exp = [];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'filled map';
  var src = Object.create( null );
  src.a = 1;
  src.b = 2;
  src[ 3 ] = 'd';
  var got = descriptor.longFromCoercing( src );
  var exp = [ [ '3', 'd' ], [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'empty object from constructor';
  var Constr = function(){ return this };
  var src = new Constr();
  var got = descriptor.longFromCoercing( src );
  var exp = [];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'object with properties, from constructor';
  var Constr = function(){ this.a = 2; this.b = 3; return this };
  var src = new Constr();
  var got = descriptor.longFromCoercing( src );
  var exp = [ [ 'a', 2 ], [ 'b', 3 ] ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );

  test.case = 'empty array';
  var src = [];
  var got = descriptor.longFromCoercing( src );
  var exp = [];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'filled array';
  var src = [ 1, 2, 3, 4, 0 ];
  var got = descriptor.longFromCoercing( src );
  var exp = [ 1, 2, 3, 4, 0 ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'empty unroll';
  var src = _.unrollMake( [] );
  var got = descriptor.longFromCoercing( src );
  var exp = [];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'filled unroll';
  var src = _.unrollMake( [ 1, 2, 3, 4, 0 ] );
  var got = descriptor.longFromCoercing( src );
  var exp = [ 1, 2, 3, 4, 0 ];
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = descriptor.longFromCoercing( src );
  var exp = _.argumentsArrayMake( [] );
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'filled argumentsArray';
  var src = _.argumentsArrayMake( [ 1, 2, 3, 4, 0 ] );
  var got = descriptor.longFromCoercing( src );
  var exp = _.argumentsArrayMake( [ 1, 2, 3, 4, 0 ] );
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'empty BufferTyped';
  var src = new U8x( [] );
  var got = descriptor.longFromCoercing( src );
  var exp = new U8x( [] );
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  var src = new I16x( [] );
  var got = descriptor.longFromCoercing( src );
  var exp = new I16x( [] );
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  test.case = 'filled BufferTyped';
  var src = new F32x( [ 1, 2, 3, 4, 0 ] );
  var got = descriptor.longFromCoercing( src );
  var exp = new F32x( [ 1, 2, 3, 4, 0 ] );
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  var src = new F64x( [ 1, 2, 3, 4, 0 ] );
  var got = descriptor.longFromCoercing( src );
  var exp = new F64x( [ 1, 2, 3, 4, 0 ] );
  test.identical( got, exp );
  test.is( got instanceof descriptor.longDescriptor.type );
  test.is( src === got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => descriptor.longFromCoercing() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => descriptor.longFromCoercing( 1, [] ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => descriptor.longFromCoercing( null ) );
  test.shouldThrowErrorSync( () => descriptor.longFromCoercing( undefined ) );
  test.shouldThrowErrorSync( () => descriptor.longFromCoercing( 2 ) );
  test.shouldThrowErrorSync( () => descriptor.longFromCoercing( new Set() ) );
}

/*
//

qqq : improve, add exception checking ceases | Dmytro : improved, added exception checking cases
*/

function longSlice( test )
{

  test.open( 'Array' );
  runFor( makeArray );
  test.close( 'Array' );

  /* - */

  test.open( 'ArgumentsArray' );
  runFor( makeU8 );
  test.close( 'ArgumentsArray' );

  /* - */

  test.open( 'F32x' );
  runFor( makeF32 );
  test.close( 'F32x' );

  /* - */

  test.open( 'U8x' );
  runFor( makeU8 );
  test.close( 'U8x' );

  /* instance makers */

  function makeArray( src )
  {
    return _.arrayMake( src );
  }

  function makeArgumentsArray( src )
  {
    return arguments;
  }

  function makeF32( src )
  {
    var result = new F32x( src );
    return result;
  }

  function makeU8( src )
  {
    var result = new U8x( src );
    return result;
  }

  /* test routine */

  function runFor( makeLong )
  {
    test.open( 'src - empty long' );

    test.case = 'not start and end';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 0 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end - 0';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 0, 0 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end > src.length';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 0, 5 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end - -1';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 0, -1 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    /* */

    test.case = 'start > 0';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 2 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start > 0, end === start';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 2, 2 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start > 0, end > src.length';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 2, 5 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start > 0, end < start';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, 2, -1 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    /* */

    test.case = 'start < 0';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, -2 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, end === start';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, -2, -2 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, end > src.length';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, -2, 5 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, end < start';
    var srcLong = makeLong();
    var got = _.longSlice( srcLong, -2, -4 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.close( 'src - empty long' );

    /* - */

    test.open( 'src - filled long' );

    test.case = 'not start and end';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 0 );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - undefined, end - 0';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, undefined, 0 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end - 0';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 0, 0 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - undefined, end < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, undefined, 3 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 0, 3 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - undefined, end > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, undefined, 5 );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 0, 5 );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - undefined, end - -1';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, undefined, -1 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start - 0, end - -1';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 0, -1 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    /* */

    test.case = '0 < start < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 2 );
    var expected = makeLong( [ 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 5 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start < src.length, end === start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 2, 2 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start > src.length, end === start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 5, 5 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start < src.length, end < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 2, 3 );
    var expected = makeLong( [ 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start > src.length, end < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 5, 3 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start < src.length, end > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 2, 5 );
    var expected = makeLong( [ 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start > src.length, end > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 5, 7 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start < src.length, end < start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 2, -1 );
    var expected = makeLong( [ 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = '0 < start > src.length, end < start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, 5, -1 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    /* */

    test.case = 'start < 0, src.length > |start|';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -2 );
    var expected = makeLong( [ 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length < |start|';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -5 );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length > |start|, end === start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -2, -2 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length < |start|, end === start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -5, -5 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length > |start|, end < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -2, 3 );
    var expected = makeLong( [ 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length < |start|, end < src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -5, 3 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length > |start|, end > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -2, 5 );
    var expected = makeLong( [ 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length < |start|, end > src.length';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -5, 5 );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length > |start|, end < start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -2, -4 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'start < 0, src.length < |start|, end < start';
    var srcLong = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longSlice( srcLong, -5, -7 );
    var expected = makeLong();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.close( 'src - filled long' );

    /* - */

    if( !Config.debug )
    return;

    test.case = 'without arguments';
    test.shouldThrowErrorSync( () => _.longSlice() );

    test.case = 'extra arguments';
    test.shouldThrowErrorSync( () => _.longSlice( [ 1, 2, 3 ], 1, 2, 'extra' ) );

    test.case = 'array is not long';
    test.shouldThrowErrorSync( () => _.longSlice( 'x' ) );
    test.shouldThrowErrorSync( () => _.longSlice( new BufferRaw() ) );

    test.case = 'f is not number';
    test.shouldThrowErrorSync( () => _.longSlice( [ 1 ], 'x', 1 ) );

    test.case = 'l is not number';
    test.shouldThrowErrorSync( () => _.longSlice( [ 1 ], 0, 'x' ) );
  }

}

longSlice.timeOut = 20000;

//

/*
aaa : please ask how to improve test routine longBut
Dmytro : improved by using given clarifications
*/

function longButWithArrayUnrollArgumentsArray( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake
  ];

  /* - */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'range = number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut( dst, 2 );
    var expected = [ 1, 2, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = negative number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut( dst, -1 );
    var expected = [ 1, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut( dst, 0, [ 0 ] );
    var expected = [ 0, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, empty src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var src = [];
    var got = _.longBut( dst, 0, src );
    var expected = [ 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );


    test.case = 'range, empty src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [];
    var got = _.longBut( dst, [ 1, 3 ], src );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range, not src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut( dst, [ 1, 3 ] );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ 1, 3 ], src );
    var expected = [ 1, 11, 22, 33, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] == range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ 1, 1 ], src );
    var expected = [ 1, 11, 22, 33, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ -10, 2 ], src );
    var expected = [ 11, 22, 33, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ 3, 10 ], src );
    var expected = [ 1, 2, 3, 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ -10, 10 ], src );
    var expected = [ 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ -1, -1 ], src );
    var expected = [ 11, 22, 33, 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var but = _.longBut( dst, [ 9, 0 ], src );
    var expected = [ 1, 2, 3, 4, 5, 11, 22, 33 ];
    test.identical( but, expected );
    test.is( got !== dst );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longBut() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longBut( [ 1, 'a', 'b', 'c', 5 ], [ 2, 3, 4 ], 1, 3, 'redundant argument' ) );

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( () => _.longBut( 'wrong argument', 'wrong argument', 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longBut( [], 2, '3' ) );

  test.case = 'wrong range';
  test.shouldThrowErrorSync( () => _.longBut( [ 1, 2, 3, 4 ], [ 1 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.longBut( [ 1, 2, 3, 4 ], [ undefined, 1 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.longBut( [ 1, 2, 3, 4 ], [], [] ) );
}

//

function longButWithBufferTyped( test )
{
  /* Buffers */

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];


  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'range = number, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut( dst, 0 );
    var expected = new makeLong( [ 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, 4, src );
    var expected = new makeLong( [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range = number, range > dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, 10, src );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut( dst, [ 2, 5 ] );
    var expected = new makeLong( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, [ 4, 5 ], src );
    var expected = new makeLong( [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut( dst, [ 0, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut( dst, [ -1, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] === range[ 1 ], src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, [ 0, 0 ], src );
    var expected = new makeLong( [ 6, 7, 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, [ 0, 99 ] );
    var expected = new makeLong( [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, [ 0, 99 ], src );
    var expected = new makeLong( [ 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut( dst, [ 10, 0 ], src );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );
  }
}

//

function longButInplaceWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'range = number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longButInplace( dst, 2 );
    var expected = makeLong( [ 1, 2, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range = negative number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longButInplace( dst, -1 );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range = number, src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longButInplace( dst, 0, [ 0 ] );
    var expected = makeLong( [ 0, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range = number, empty src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var src = [];
    var got = _.longButInplace( dst, 0, src );
    var expected = makeLong( [ 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range, empty src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [];
    var got = _.longButInplace( dst, [ 1, 3 ], src );
    var expected = makeLong( [ 1, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range, not src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longButInplace( dst, [ 1, 3 ] );
    var expected = makeLong( [ 1, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ 1, 3 ], src );
    var expected = makeLong( [ 1, 11, 22, 33, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] == range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ 1, 1 ], src );
    var expected = makeLong( [ 1, 11, 22, 33, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ -10, 2 ], src );
    var expected = makeLong( [ 11, 22, 33, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ 3, 10 ], src );
    var expected = makeLong( [ 1, 2, 3, 11, 22, 33 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ -10, 10 ], src );
    var expected = makeLong( [ 11, 22, 33 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ -1, -1 ], src );
    var expected = makeLong( [ 11, 22, 33, 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var but = _.longButInplace( dst, [ 9, 0 ], src );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 11, 22, 33 ] );
    test.identical( but, expected );
    test.is( got !== src );

    test.case = 'container is not extensible, range = number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    Object.preventExtensions( dst );
    var got = _.longButInplace( dst, 2 );
    var expected = makeLong( [ 1, 2, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'container is not extensible, range = number, src.length = 1';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    Object.preventExtensions( dst );
    var got = _.longButInplace( dst, 0, [ 0 ] );
    var expected = makeLong( [ 0, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'container is not extensible, range, src.length > range[ 1 ] - range[ 0 ]';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    Object.preventExtensions( dst );
    var src = [ 1, 2, 3 ];
    test.shouldThrowErrorSync( () => _.longButInplace( dst, [ 1, 3 ], src ) );
    var expected = makeLong( [ 1, 2, 3, 4 ] );
    test.identical( dst, expected );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'range = number, not src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4 ] );
  var got = _.longButInplace( dst, 2 );
  var expected = [ 1, 2, 4 ];
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'range = negative number, not src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4 ] );
  var got = _.longButInplace( dst, -1 );
  var expected = _.argumentsArrayMake( [ 1, 2, 3, 4 ] );
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'range = number, src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4 ] );
  var got = _.longButInplace( dst, 0, [ 0 ] );
  var expected = [ 0, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'range = number, empty src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4 ] );
  var src = [];
  var got = _.longButInplace( dst, 0, src );
  var expected = [ 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );


  test.case = 'range, empty src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [];
  var got = _.longButInplace( dst, [ 1, 3 ], src );
  var expected = [ 1, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range, not src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longButInplace( dst, [ 1, 3 ] );
  var expected = [ 1, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== dst );

  test.case = 'range, src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var got = _.longButInplace( dst, [ 1, 3 ], src );
  var expected = [ 1, 11, 22, 33, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range[ 0 ] == range[ 1 ], src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var got = _.longButInplace( dst, [ 1, 1 ], src );
  var expected = [ 1, 11, 22, 33, 2, 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range[ 0 ] < 0, src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var got = _.longButInplace( dst, [ -10, 2 ], src );
  var expected = [ 11, 22, 33, 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range[ 1 ] > dst.length, src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var got = _.longButInplace( dst, [ 3, 10 ], src );
  var expected = [ 1, 2, 3, 11, 22, 33 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var got = _.longButInplace( dst, [ -10, 10 ], src );
  var expected = [ 11, 22, 33 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var got = _.longButInplace( dst, [ -1, -1 ], src );
  var expected = [ 11, 22, 33, 1, 2, 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'range[ 0 ] > range[ 1 ], src';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var src = [ 11, 22, 33 ];
  var but = _.longButInplace( dst, [ 9, 0 ], src );
  var expected = [ 1, 2, 3, 4, 5, 11, 22, 33 ];
  test.identical( but, expected );
  test.is( got !== dst );
  test.is( got !== src );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longButInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longButInplace( [ 1, 'a', 'b', 'c', 5 ], [ 2, 3, 4 ], 1, 3, 'redundant argument' ) );

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( () => _.longButInplace( 'wrong argument', 'wrong argument', 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longButInplace( [], 2, '3' ) );

  test.case = 'wrong range';
  test.shouldThrowErrorSync( () => _.longButInplace( [ 1, 2, 3, 4 ], [ 1 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.longButInplace( [ 1, 2, 3, 4 ], [ undefined, 1 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.longButInplace( [ 1, 2, 3, 4 ], [], [] ) );
}

//

function longButInplaceWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'range = number, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longButInplace( dst, 0 );
    var expected = _.longMake( makeLong, [ 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, 4, src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range = number, range > dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, 10, src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longButInplace( dst, [ 2, 5 ] );
    var expected = _.longMake( makeLong, [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, [ 4, 5 ], src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longButInplace( dst, [ 0, -1 ] );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longButInplace( dst, [ -1, -1 ] );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] === range[ 1 ], src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, [ 0, 0 ], src );
    var expected = _.longMake( makeLong, [ 6, 7, 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, [ 0, 99 ] );
    var expected = _.longMake( makeLong, [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, [ 0, 99 ], src );
    var expected = _.longMake( makeLong, [ 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longButInplace( dst, [ 10, 0 ], src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );
  }
}

//

function longBut_WithArrayUnrollArgumentsArray( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake
  ];

  /* - */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'range = number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut_( null, dst, 2 );
    var expected = [ 1, 2, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = negative number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut_( null, dst, -1 );
    var expected = [ 1, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut_( null, dst, 0, [ 0 ] );
    var expected = [ 0, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, empty src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var src = [];
    var got = _.longBut_( null, dst, 0, src );
    var expected = [ 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range, empty src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [];
    var got = _.longBut_( null, dst, [ 1, 3 ], src );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range, not src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( null, dst, [ 1, 3 ] );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ 1, 3 ], src );
    var expected = [ 1, 11, 22, 33, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] == range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ 1, 1 ], src );
    var expected = [ 1, 11, 22, 33, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ -10, 2 ], src );
    var expected = [ 11, 22, 33, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ 3, 10 ], src );
    var expected = [ 1, 2, 3, 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ -10, 10 ], src );
    var expected = [ 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ -1, -1 ], src );
    var expected = [ 11, 22, 33, 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( null, dst, [ 9, 0 ], src );
    var expected = [ 1, 2, 3, 4, 5, 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.close( 'not inplace' );

    /* */

    test.open( 'inplace' );

    test.case = 'range = number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut_( dst, dst, 2 );
    var expected = [ 1, 2, 4 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range = negative number, not src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut_( dst, dst, -1 );
    var expected = [ 1, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range = number, src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var got = _.longBut_( dst, dst, 0, [ 0 ] );
    var expected = [ 0, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range = number, empty src';
    var dst = makeLong( [ 1, 2, 3, 4 ] );
    var src = [];
    var got = _.longBut_( dst, dst, 0, src );
    var expected = [ 2, 3, 4 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range, empty src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [];
    var got = _.longBut_( dst, dst, [ 1, 3 ], src );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range, not src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( dst, dst, [ 1, 3 ] );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( dst, dst, [ 1, 3 ], src );
    var expected = [ 1, 11, 22, 33, 4, 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] == range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( dst, dst, [ 1, 1 ], src );
    var expected = [ 1, 11, 22, 33, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( dst, dst, [ -10, 2 ], src );
    var expected = [ 11, 22, 33, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_(dst, dst, [ 3, 10 ], src );
    var expected = [ 1, 2, 3, 11, 22, 33 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( dst, dst, [ -10, 10 ], src );
    var expected = [ 11, 22, 33 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( dst, dst, [ -1, -1 ], src );
    var expected = [ 11, 22, 33, 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut_( dst, dst, [ 9, 0 ], src );
    var expected = [ 1, 2, 3, 4, 5, 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.close( 'inplace' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longBut_() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longBut_( [ 1, 'a', 'b', 'c', 5 ], [ 2, 3, 4 ], 1, 3, 'redundant argument' ) );

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( () => _.longBut_( 'wrong argument', 'wrong argument', 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longBut_( [], 2, '3' ) );

  test.case = 'wrong range';
  test.shouldThrowErrorSync( () => _.longBut_( [ 1, 2, 3, 4 ], [ 1 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.longBut_( [ 1, 2, 3, 4 ], [ undefined, 1 ], [ 5 ] ) );
  test.shouldThrowErrorSync( () => _.longBut_( [ 1, 2, 3, 4 ], [], [] ) );
}

//

function longBut_WithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];


  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'range = number, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( dst, 0 );
    var expected = _.longMake( makeLong, [ 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, 4, src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range = number, range > dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, 10, src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( dst, [ 2, 5 ] );
    var expected = _.longMake( makeLong, [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, [ 4, 5 ], src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( dst, [ 0, -1 ] );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( dst, [ -1, -1 ] );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] === range[ 1 ], src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, [ 0, 0 ], src );
    var expected = _.longMake( makeLong, [ 6, 7, 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut_( dst, [ 0, 99 ] );
    var expected = _.longMake( makeLong, [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, [ 0, 99 ], src );
    var expected = _.longMake( makeLong, [ 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, [ 10, 0 ], src );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, dst, [ 0, -1 ] );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, not src';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var src = [ 6, 7 ];
    var got = _.longBut_( dst, dst, [ -1, -1 ] );
    var expected = _.longMake( makeLong, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.close( 'inplace' );
  }
}

//

function longShrinkWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = makeLong( [ 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longShrink( dst, [ -1, 3 ] );
    expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, -1 ] );
    var expected = makeLong( [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ 0, dst.length + 2 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.identical( got.length, 5 );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );
  //
  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longShrink( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ 0, -1 ] );
  var expected = [];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrink( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longShrink() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longShrink( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longShrink( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longShrink( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longShrink( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longShrink( [ 1 ], 'str' ) );
}

//

function longShrinkWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ -1, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }
}

//

function longShrinkInplaceWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = makeLong( [ 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longShrinkInplace( dst, [ -1, 3 ] );
    expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, -1 ] );
    var expected = makeLong( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ 0, dst.length + 2 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.identical( got.length, 5 );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );
  //
  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longShrinkInplace( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ 0, -1 ] );
  var expected = [];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShrinkInplace( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longShrinkInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longShrinkInplace( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longShrinkInplace( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longShrinkInplace( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longShrinkInplace( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longShrinkInplace( [ 1 ], 'str' ) );
}

//

function longShrinkInplaceWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longShrinkInplace( dst, [ -1, 3 ] );
    expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrinkInplace( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }
}

//

function longShrink_WithArrayUnrollArgumentsArray( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ 0, dst.length + 2 ] );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ 0, dst.length + 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = [ 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ 0, 3 ] );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ 0, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longShrink_( null, dst, [ -1, 3 ] );
    expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ 0, -1 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( null, dst, [ -1, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = [ 5 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, 3 ] );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longShrink_( dst, dst, [ -1, 3 ] );
    expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, -1 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ -1, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.close( 'inplace' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longShrink_() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longShrink_( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longShrink_( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longShrink_( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longShrink_( [ 1 ], 'str' ) );
}

//

function longShrink_WithBufferTyped( test )
{

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longShrink_( dst, [ -1, 3 ] );
    expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShrink_( dst, dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.close( 'inplace' );
  }
}

//

function longGrowWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrow( dst, [ -1, 3 ] );
    expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, -1 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ 0, dst.length + 2 ] );
  var expected = dst.length + 2;
  test.equivalent( got, [ 1, 2, 3, 4, 5, undefined, undefined ] );
  test.identical( got.length, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longGrow( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ 0, -1 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrow( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longGrow() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longGrow( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longGrow( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longGrow( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longGrow( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longGrow( [ 1 ], 'str' ) );
}

//

function longGrowWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ] );
    var expected = dst.length + 2;
    test.identical( got, new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] ) );
    test.identical( got.length, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrow( dst, [ -1, 3 ] );
    expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }
}

//

function longGrowInplaceWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrowInplace( dst, [ -1, 3 ] );
    expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, -1 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ] );
  var expected = 7;
  test.equivalent( got, [ 1, 2, 3, 4, 5, undefined, undefined ] );
  test.identical( got.length, expected );
  test.is( !_.argumentsArrayIs( got ) );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );

  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longGrowInplace( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ 0, -1 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longGrowInplace( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longGrowInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longGrowInplace( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longGrowInplace( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longGrowInplace( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longGrowInplace( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longGrowInplace( [ 1 ], 'str' ) );
}

//

function longGrowInplaceWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ] );
    var expected = dst.length + 2;
    test.identical( got, new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] ) );
    test.identical( got.length, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrowInplace( dst, [ -1, 3 ] );
    expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );
  }
}

//

function longGrow_WithArrayUnrollArgumentsArray( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 0, 7 ] );
    var expected = [ 1, 2, 3, 4, 5, undefined, undefined ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 0, 7 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 4, 10 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 0, 3 ] );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 0, 3 ], 0 );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ -1, 3 ] );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 0, -1 ] );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ -1, 3 ], 0 );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, dst.length + 2 ] );
    var expected = [ 1, 2, 3, 4, 5, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, dst.length + 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ -1, 3 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, -1 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.close( 'inplace' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longGrow_() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longGrow_( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longGrow_( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longGrow_( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longGrow_( [ 1 ], 'str' ) );
}

//

function longGrow_WithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ -1, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ 0, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    /* */

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ -1, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ 0, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( null, dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 1 ] === dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, dst.length ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ -1, 3 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 1 ] < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ 0, -1 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range[ 0 ] < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow_( dst, dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.close( 'inplace' );
  }
}

//

function longRelengthWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = makeLong( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelength( dst, [ -1, 3 ] );
    expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, -1 ] );
    var expected = makeLong( [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ 0, dst.length + 2 ] );
  var expected = [ 1, 2, 3, 4, 5, undefined, undefined ];
  test.equivalent( got, expected );
  test.identical( got.length, 7 );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 5, 0, 0, 0, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );
  //
  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longRelength( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ 0, -1 ] );
  var expected = [];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelength( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longRelength() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longRelength( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longRelength( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longRelength( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longRelength( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longRelength( [ 1 ], 'str' ) );
}

//

function longRelengthWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelength( dst, [ -1, 3 ] );
    expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }
}

//

function longRelengthInplaceWithArrayUnrollArgumentsArray( test )
{
  /* - */

  test.open( 'array' );
  testRun( _.arrayMake );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  testRun( _.unrollMake );
  test.close( 'unroll' );

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ] );
    var expected = makeLong( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = makeLong( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ] );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelengthInplace( dst, [ -1, 3 ] );
    expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, -1 ] );
    var expected = makeLong( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ -1, 3 ], 0 );
    var expected = makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ] );
  var expected = [ 1, 2, 3, 4, 5, undefined, undefined ];
  test.equivalent( got, expected );
  test.identical( got.length, 7 );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 5, 0, 0, 0, 0, 0 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );
  //
  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longRelengthInplace( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ 0, -1 ] );
  var expected = [];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longRelengthInplace( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longRelengthInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longRelengthInplace( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longRelengthInplace( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longRelengthInplace( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longRelengthInplace( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longRelengthInplace( [ 1 ], 'str' ) );
}

//

function longRelengthInplaceWithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelengthInplace( dst, [ -1, 3 ] );
    expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }
}

//

function longRelength_WithArrayUnrollArgumentsArray( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake
  ]

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ 0, dst.length + 2 ] );
    var expected = [ 1, 2, 3, 4, 5, undefined, undefined ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ 0, dst.length + 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = [ 5, 0, 0, 0, 0, 0 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ 0, 3 ] );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ 0, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ -1, 3 ] );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ 0, -1 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ -1, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'only dst';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst );
    var expected = makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ 0, dst.length + 2 ] );
    var expected = [ 1, 2, 3, 4, 5, undefined, undefined ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ 0, dst.length + 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ 0, dst.length + 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = [ 5, 0, 0, 0, 0, 0 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range < dst.length';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ 0, 3 ] );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ 0, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'f < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ -1, 3 ] );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'l < 0, not a val';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ 0, -1 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'f < 0, val = number';
    var dst = makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ -1, 3 ], 0 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.close( 'inplace' );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longRelength_() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longRelength_( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longRelength_( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longRelength_( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longRelength_( [ 1 ], 'str' ) );
}

//

function longRelength_WithBufferTyped( test )
{
  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.open( 'not inplace' );

    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ 0, dst.length + 2 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new makeLong( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new makeLong( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ 0, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ 0, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ -1, 3 ] );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    /* */

    test.case = 'l < 0, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ 0, -1 ] );
    var expected = new makeLong();
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( null, dst, [ -1, 3 ], 0 );
    var expected = new makeLong( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var src = new U8x( [ 0, 1, 0, 1, 0 ] );
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( src, dst, [ 0, 5 ], 0 );
    var expected = new U8x( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got === src );

    test.close( 'not inplace' );

    /* - */

    test.open( 'inplace' );

    test.case = 'only dst';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range === dst.length, not a val';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength_( dst, dst, [ 0, 5 ] );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.close( 'inplace' );
  }
}

//

function longShallowCloneOneArgument( test )
{
  test.open( 'single argument' );

  test.case = 'empty array';
  var src = [];
  var got = _.longShallowClone( src );
  var exp = [];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled array';
  var src = [ 1, 'str', {}, null, undefined ];
  var got = _.longShallowClone( src );
  var exp = [ 1, 'str', {}, null, undefined ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  /* */

  test.case = 'empty unroll';
  var src = _.unrollMake( [] );
  var got = _.longShallowClone( src );
  var exp = _.unrollMake( [] );
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src );

  test.case = 'filled unroll';
  var src = _.unrollMake( [ 1, 'str', {}, null, undefined ] );
  var got = _.longShallowClone( src );
  var exp = _.unrollMake( [ 1, 'str', {}, null, undefined ] );
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src );

  /* */

  test.case = 'empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.longShallowClone( src );
  var exp = [];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  test.case = 'filled argumentsArray';
  var src = _.argumentsArrayMake( [ 1, 'str', {}, null, undefined ] );
  var got = _.longShallowClone( src );
  var exp = [ 1, 'str', {}, null, undefined ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src );

  /* */

  test.case = 'empty BufferRaw';
  var src = new BufferRaw();
  var got = _.longShallowClone( src );
  var exp = new BufferRaw();
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferRaw';
  var src = new U8x( [ 1, 2, 3, 4, 5 ] ).buffer;
  var got = _.longShallowClone( src );
  var exp = new U8x( [ 1, 2, 3, 4, 5 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src );

  /* */

  test.case = 'empty BufferView';
  var src = new BufferView( new BufferRaw() );
  var got = _.longShallowClone( src );
  var exp = new BufferView( new BufferRaw() );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferView';
  var src = new BufferView( new U8x( [ 1, 2, 3, 4, 5 ] ).buffer );
  var got = _.longShallowClone( src );
  var exp = new BufferView( new U8x( [ 1, 2, 3, 4, 5 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src );

  /* */

  test.case = 'empty bufferTyped - U8x';
  var src = new U8x();
  var got = _.longShallowClone( src );
  var exp = new U8x();
  test.identical( got, exp );
  test.is( _.bufferTypedIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferView - U8x';
  var src = new U8x( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShallowClone( src );
  var exp = new U8x( [ 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( _.bufferTypedIs( got ) );
  test.is( got !== src );

  test.case = 'empty bufferTyped - I16x';
  var src = new I16x();
  var got = _.longShallowClone( src );
  var exp = new I16x();
  test.identical( got, exp );
  test.is( _.bufferTypedIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferView - I16x';
  var src = new I16x( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShallowClone( src );
  var exp = new I16x( [ 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( _.bufferTypedIs( got ) );
  test.is( got !== src );

  test.case = 'empty bufferTyped - F64x';
  var src = new F64x();
  var got = _.longShallowClone( src );
  var exp = new F64x();
  test.identical( got, exp );
  test.is( _.bufferTypedIs( got ) );
  test.is( got !== src );

  test.case = 'filled BufferView - F64x';
  var src = new F64x( [ 1, 2, 3, 4, 5 ] );
  var got = _.longShallowClone( src );
  var exp = new F64x( [ 1, 2, 3, 4, 5 ] );
  test.identical( got, exp );
  test.is( _.bufferTypedIs( got ) );
  test.is( got !== src );

  /* */

  if( Config.interpreter === 'njs' )
  {
    test.case = 'empty BufferNode';
    var src = BufferNode.alloc( 0 );
    var got = _.longShallowClone( src );
    var exp = BufferNode.alloc( 0 );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src );

    test.case = 'filled BufferNode';
    var src = BufferNode.from( [ 1, 2, 3, 4, 5 ] );
    var got = _.longShallowClone( src );
    var exp = BufferNode.from( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src );
  }

  test.close( 'single argument' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longShallowClone() );

  test.case = 'wrong type of first argument';
  test.shouldThrowErrorSync( () => _.longShallowClone( 1 ) );
  test.shouldThrowErrorSync( () => _.longShallowClone( {} ) );

  test.case = 'one of the arguments is undefined';
  test.shouldThrowErrorSync( () => _.longShallowClone( [ 1 ], 2, undefined, 'str' ) );
}

//

function longShallowCloneFirstArrayLike( test )
{
  test.open( 'first argument - array' );

  test.case = 'first - empty array, other - not containers';
  var src1 = [];
  var src2 = 'str';
  var src3 = { a : 1 };
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled array, next - not containers';
  var src1 = [ [ 1 ], null ];
  var src2 = 'str';
  var src3 = { a : 1 };
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'empty arrays';
  var src1 = [];
  var src2 = [];
  var src3 = [];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty array, other - empty containers';
  var src1 = [];
  var src2 = _.argumentsArrayMake( 0 );
  var src3 = new F64x( 0 );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty array, other - filled arrays';
  var src1 = [];
  var src2 = [ 1, 2 ];
  var src3 = [ 'str', { a : 1 } ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'filled arrays';
  var src1 = [ [ 1 ], null ];
  var src2 = [ 1, 2 ];
  var src3 = [ 'str', { a : 1 } ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled array, other - BufferRaw and unroll';
  var src1 = [ [ 1 ], null ];
  var src2 = new U8x( [ 1, 2 ] ).buffer;
  var src3 = _.unrollMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled array, other - BufferView and argumentsArray';
  var src1 = [ [ 1 ], null ];
  var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src3 = _.argumentsArrayMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled array, other - BufferTyped';
  var src1 = [ [ 1 ], null ];
  var src2 = new U8x( [ 1, 2 ] );
  var src3 = new I32x( [ -2, 3 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, -2, 3 ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'first - filled array, other - BufferNode';
    var src1 = [ [ 1 ], null ];
    var src2 = BufferNode.from( [ 1, 2 ] );
    var src3 = BufferNode.alloc( 2 );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = [ [ 1 ], null, 1, 2, 0, 0 ];
    test.identical( got, exp );
    test.is( _.arrayIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );
  }

  test.close( 'first argument - array' );

  /* - */

  test.open( 'first argument - argumentsArray' );

  test.case = 'first - empty argumentsArray, other - not containers';
  var src1 = _.argumentsArrayMake( [] );
  var src2 = 'str';
  var src3 = { a : 1 };
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled argument, next - not containers';
  var src1 = _.argumentsArrayMake( [ [ 1 ], null ] );
  var src2 = 'str';
  var src3 = { a : 1 };
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'empty argumentsArray';
  var src1 = _.argumentsArrayMake( [] );
  var src2 = _.argumentsArrayMake( [] );
  var src3 = _.argumentsArrayMake( [] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty argumentsArray, other - empty containers';
  var src1 = _.argumentsArrayMake( [] );
  var src2 = _.unrollMake( [] );
  var src3 = new U8x().buffer;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty argumentsArray, other - filled argumentsArray';
  var src1 = _.argumentsArrayMake( [] );
  var src2 = _.argumentsArrayMake( [ 1, 2 ] );
  var src3 = _.argumentsArrayMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled argumentsArray, other - filled arrays';
  var src1 = _.argumentsArrayMake( [ [ 1 ], null ] );
  var src2 = [ 1, 2 ];
  var src3 = [ 'str', { a : 1 } ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled argumentsArray, other - BufferRaw and unroll';
  var src1 = _.argumentsArrayMake( [ [ 1 ], null ] );
  var src2 = new U8x( [ 1, 2 ] ).buffer;
  var src3 = _.unrollMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled argumentsArray, other - BufferView and array';
  var src1 = _.argumentsArrayMake( [ [ 1 ], null ] );
  var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src3 = [ 'str', { a : 1 } ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled argumentsArray, other - BufferTyped';
  var src1 = _.argumentsArrayMake( [ [ 1 ], null ] );
  var src2 = new U8x( [ 1, 2 ] );
  var src3 = new I32x( [ -2, 3 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, -2, 3 ];
  test.identical( got, exp );
  test.is( _.arrayIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'first - filled argumentsArray, other - BufferNode';
    var src1 = _.argumentsArrayMake( [ [ 1 ], null ] );
    var src2 = BufferNode.from( [ 1, 2 ] );
    var src3 = BufferNode.alloc( 2 );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = [ [ 1 ], null, 1, 2, 0, 0 ];
    test.identical( got, exp );
    test.is( _.arrayIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );
  }

  test.close( 'first argument - argumentsArray' );

  /* - */

  test.open( 'first argument - unroll' );

  test.case = 'first - empty unroll, other - not containers';
  var src1 = _.unrollMake( [] );
  var src2 = 'str';
  var src3 = { a : 1 };
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, other - not containers';
  var src1 = _.unrollMake( [ [ 1 ], null ] );
  var src2 = 'str';
  var src3 = { a : 1 };
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, empty argumentsArray';
  var src1 = _.unrollMake( [] );
  var src2 = _.unrollMake( [] );
  var src3 = _.unrollMake( [] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, first - empty unroll, other - empty containers';
  var src1 = _.unrollMake( [] );
  var src2 = _.argumentsArrayMake( [] );
  var src3 = new U8x().buffer;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, first - empty unroll, other - filled unrolls';
  var src1 = _.unrollMake( [] );
  var src2 = _.unrollMake( [ 1, 2 ] );
  var src3 = _.unrollMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, other - filled arrays';
  var src1 = _.unrollMake( [ [ 1 ], null ] );
  var src2 = [ 1, 2 ];
  var src3 = [ 'str', { a : 1 } ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, other - BufferRaw and argumentsArray';
  var src1 = _.unrollMake( [ [ 1 ], null ] );
  var src2 = new U8x( [ 1, 2 ] ).buffer;
  var src3 = _.argumentsArrayMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, other - BufferView and argumentsArray';
  var src1 = _.unrollMake( [ [ 1 ], null ] );
  var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src3 = _.argumentsArrayMake( [ 'str', { a : 1 } ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, 'str', { a : 1 } ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled unroll, other - BufferTyped';
  var src1 = _.unrollMake( [ [ 1 ], null ] );
  var src2 = new U8x( [ 1, 2 ] );
  var src3 = new I32x( [ -2, 3 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = [ [ 1 ], null, 1, 2, -2, 3 ];
  test.identical( got, exp );
  test.is( _.unrollIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'first - filled unroll, other - BufferNode';
    var src1 = _.unrollMake( [ [ 1 ], null ] );
    var src2 = BufferNode.from( [ 1, 2 ] );
    var src3 = BufferNode.alloc( 2 );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = [ [ 1 ], null, 1, 2, 0, 0 ];
    test.identical( got, exp );
    test.is( _.unrollIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );
  }

  test.close( 'first argument - unroll' );
}

//

function longShallowCloneFirstBuffer( test )
{
  test.open( 'first argument - BufferRaw' );

  test.case = 'first - empty BufferRaw, other - not containers';
  var src1 = new BufferRaw();
  var src2 = 1;
  var src3 = 2;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 1, 2 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - BufferRaw with length, other - not containers';
  var src1 = new BufferRaw( 2 );
  var src2 = 1;
  var src3 = 2;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 0, 0, 1, 2 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'empty BufferRaws';
  var src1 = new BufferRaw();
  var src2 = new BufferRaw();
  var src3 = new BufferRaw();
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferRaw();
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty BufferRaw, other - empty containers';
  var src1 = new BufferRaw();
  var src2 = _.argumentsArrayMake( [] );
  var src3 = new U8x();
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferRaw();
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty BufferRaw, other - filled BufferRaw';
  var src1 = new BufferRaw();
  var src2 = new U8x( [ 1, 2 ] ).buffer;
  var src3 = new U8x( [ 3, 4 ] ).buffer;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 1, 2, 3, 4 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - BufferRaw with length, filled arrays';
  var src1 = new BufferRaw( 2 );
  var src2 = [ 1, 2 ];
  var src3 = [ 3, 4 ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 0, 0, 1, 2, 3, 4 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled BufferRaw, other - unroll and argumentsArray';
  var src1 = new U8x( [ 1, 2 ] ).buffer;
  var src2 = _.unrollMake( [ 1, 2 ] );
  var src3 = _.argumentsArrayMake( [ 3, 4 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 1, 2, 1, 2, 3, 4 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled BufferRaw, other - BufferView and argumentsArray';
  var src1 = new U8x( [ 1, 2 ] ).buffer;
  var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src3 = _.argumentsArrayMake( [ 3, 4 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 1, 2, 1, 2, 3, 4 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled BufferRaw, other - BufferTyped';
  var src1 = new U8x( [ 1, 2 ] ).buffer;
  var src2 = new U8x( [ 1, 2 ] );
  var src3 = new I32x( [ 2, 3 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new U8x( [ 1, 2, 1, 2, 2, 3 ] ).buffer;
  test.identical( got, exp );
  test.is( _.bufferRawIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'first - filled BufferRaw, other - BufferNode';
    var src1 = new U8x( [ 1, 2 ] ).buffer;
    var src2 = BufferNode.from( [ 1, 2 ] );
    var src3 = BufferNode.from( [ 0, 0 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new U8x( [ 1, 2, 1, 2, 0, 0 ] ).buffer;
    test.identical( got, exp );
    test.is( _.bufferRawIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );
  }

  test.close( 'first argument - BufferRaw' );

  /* - */

  test.open( 'first argument - BufferView' );

  test.case = 'first - empty BufferView, other - not containers';
  var src1 = new BufferView( new BufferRaw() );
  var src2 = 1;
  var src3 = 2;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - BufferView with length, other - not containers';
  var src1 = new BufferView( new BufferRaw( 2 ) );
  var src2 = 1;
  var src3 = 2;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 0, 0, 1, 2 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'empty BufferView';
  var src1 = new BufferView( new BufferRaw() );
  var src2 = new BufferView( new BufferRaw() );
  var src3 = new BufferView( new BufferRaw() );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new BufferRaw() );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty BufferView, other - empty containers';
  var src1 = new BufferView( new BufferRaw() );
  var src2 = _.argumentsArrayMake( [] );
  var src3 = new U8x();
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new BufferRaw() );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - empty BufferView, other - filled BufferView';
  var src1 = new BufferView( new BufferRaw() );
  var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src3 = new U8x( [ 3, 4 ] ).buffer;
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 1, 2, 3, 4 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - BufferRaw with length, filled arrays';
  var src1 = new BufferView( new BufferRaw( 2 ) );
  var src2 = [ 1, 2 ];
  var src3 = [ 3, 4 ];
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 0, 0, 1, 2, 3, 4 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled BufferView, other - unroll and argumentsArray';
  var src1 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src2 = _.unrollMake( [ 1, 2 ] );
  var src3 = _.argumentsArrayMake( [ 3, 4 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 1, 2, 1, 2, 3, 4 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled BufferView, other - BufferRaw and argumentsArray';
  var src1 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src2 = new U8x( [ 1, 2 ] ).buffer;
  var src3 = _.argumentsArrayMake( [ 3, 4 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 1, 2, 1, 2, 3, 4 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'first - filled BufferView, other - BufferTyped';
  var src1 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
  var src2 = new U8x( [ 1, 2 ] );
  var src3 = new I32x( [ 2, 3 ] );
  var got = _.longShallowClone( src1, src2, src3 );
  var exp = new BufferView( new U8x( [ 1, 2, 1, 2, 2, 3 ] ).buffer );
  test.identical( got, exp );
  test.is( _.bufferViewIs( got ) );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'first - filled BufferView, other - BufferNode';
    var src1 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
    var src2 = BufferNode.from( [ 1, 2 ] );
    var src3 = BufferNode.alloc( 2 );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new BufferView( new U8x( [ 1, 2, 1, 2, 0, 0 ] ).buffer );
    test.identical( got, exp );
    test.is( _.bufferViewIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );
  }

  test.close( 'first argument - BufferView' );

  /* - */

  var bufferTyped =
  [
    U8x,
    I16x,
    F64x
  ];

  for( let i = 0; i < bufferTyped.length; i++ )
  {
    test.open( 'first argument - ' + bufferTyped[ i ].name  );

    test.case = 'first - empty ' + bufferTyped[ i ].name + ', other - not containers';
    var src1 = new bufferTyped[ i ]();
    var src2 = 1;
    var src3 = 2;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 1, 2 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - ' + bufferTyped[ i ].name + ' with length, other - not containers';
    var src1 = new bufferTyped[ i ]( 2 );
    var src2 = 1;
    var src3 = 2;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 0, 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'empty ' + bufferTyped[ i ].name;
    var src1 = new bufferTyped[ i ]();
    var src2 = new bufferTyped[ i ]();
    var src3 = new bufferTyped[ i ]();
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]();
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - empty ' + bufferTyped[ i ].name + ', other - empty containers';
    var src1 = new bufferTyped[ i ]();
    var src2 = _.argumentsArrayMake( [] );
    var src3 = _.unrollMake( 0 );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]();
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - empty ' + bufferTyped[ i ].name + ', other - filled ' + bufferTyped[ i ].name;
    var src1 = new bufferTyped[ i ]();
    var src2 = new U8x( [ 1, 2 ] ).buffer;
    var src3 = new U8x( [ 3, 4 ] ).buffer;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - ' + bufferTyped[ i ].name + ' with length, other - filled arrays';
    var src1 = new bufferTyped[ i ]( 2 );
    var src2 = [ 1, 2 ];
    var src3 = [ 3, 4 ];
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 0, 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - ' + bufferTyped[ i ].name + ' with length, other - unroll and argumentsArray';
    var src1 = new bufferTyped[ i ]( [ 1, 2 ] );
    var src2 = _.unrollMake( [ 1, 2 ] );
    var src3 = _.argumentsArrayMake( [ 3, 4 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 1, 2, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - ' + bufferTyped[ i ].name + ' with length, other - BufferView and argumentsArray';
    var src1 = new bufferTyped[ i ]( [ 1, 2 ] );
    var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
    var src3 = _.argumentsArrayMake( [ 3, 4 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 1, 2, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - ' + bufferTyped[ i ].name + ' with length, other - BufferRaw';
    var src1 = new bufferTyped[ i ]( [ 1, 2 ] );
    var src2 = new U8x( [ 1, 2 ] ).buffer;
    var src3 = new U8x( [ 2, 3 ] ).buffer;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = new bufferTyped[ i ]( [ 1, 2, 1, 2, 2, 3 ] );
    test.identical( got, exp );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    if( Config.interpreter === 'njs' )
    {
      test.case = 'first - ' + bufferTyped[ i ].name + ' with length, other - BufferNode';
      var src1 = new bufferTyped[ i ]( [ 1, 2 ] );
      var src2 = BufferNode.from( [ 1, 2 ] );
      var src3 = BufferNode.from( [ 0, 0 ] );
      var got = _.longShallowClone( src1, src2, src3 );
      var exp = new bufferTyped[ i ]( [ 1, 2, 1, 2, 0, 0 ] );
      test.identical( got, exp );
      test.is( _.bufferTypedIs( got ) );
      test.is( got !== src1 );
      test.is( got !== src2 );
      test.is( got !== src3 );
    }

    test.close( 'first argument - ' + bufferTyped[ i ].name );
  }

  /* - */

  if( Config.interpreter === 'njs' )
  {
    test.open( 'first argument - BufferNode' );

    test.case = 'first - empty BufferRaw, other - not containers';
    var src1 = BufferNode.alloc( 0 );
    var src2 = 1;
    var src3 = 2;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 1, 2 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - BufferNode with length, other - not containers';
    var src1 = BufferNode.alloc( 2 );
    var src2 = 1;
    var src3 = 2;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 0, 0, 1, 2 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - empty BufferNode, empty BufferNode';
    var src1 = BufferNode.alloc( 0 );
    var src2 = BufferNode.alloc( 0 );
    var src3 = BufferNode.alloc( 0 );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.alloc( 0 );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - empty BufferNode, other - empty containers';
    var src1 = BufferNode.alloc( 0 );
    var src2 = _.argumentsArrayMake( [] );
    var src3 = new U8x();
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.alloc( 0 );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - empty BufferNode, other - filled BufferNode';
    var src1 = BufferNode.alloc( 0 );
    var src2 = BufferNode.from( [ 1, 2 ] );
    var src3 = BufferNode.from( [ 3, 4 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - BufferNode with length, filled arrays';
    var src1 = BufferNode.alloc( 2 );
    var src2 = [ 1, 2 ];
    var src3 = [ 3, 4 ];
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 0, 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - filled BufferNode, other - unroll and argumentsArray';
    var src1 = BufferNode.from( [ 1, 2 ] );
    var src2 = _.unrollMake( [ 1, 2 ] );
    var src3 = _.argumentsArrayMake( [ 3, 4 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 1, 2, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - filled BufferNode, other - BufferView and argumentsArray';
    var src1 = BufferNode.from( [ 1, 2 ] );
    var src2 = new BufferView( new U8x( [ 1, 2 ] ).buffer );
    var src3 = _.argumentsArrayMake( [ 3, 4 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 1, 2, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - filled BufferNode, other - BufferTyped';
    var src1 = BufferNode.from( [ 1, 2 ] );
    var src2 = new U8x( [ 1, 2 ] );
    var src3 = new I32x( [ 2, 3 ] );
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 1, 2, 1, 2, 2, 3 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.case = 'first - filled BufferNode, other - BufferRaw';
    var src1 = BufferNode.from( [ 1, 2 ] );
    var src2 = new U8x( [ 1, 2 ] ).buffer;
    var src3 = new U8x( 2 ).buffer;
    var got = _.longShallowClone( src1, src2, src3 );
    var exp = BufferNode.from( [ 1, 2, 1, 2, 0, 0 ] );
    test.identical( got, exp );
    test.is( _.bufferNodeIs( got ) );
    test.is( got !== src1 );
    test.is( got !== src2 );
    test.is( got !== src3 );

    test.close( 'first argument - BufferNode' );
  }
}
longShallowCloneFirstBuffer.timeOut = 10000;

//

function longRepresent( test )
{

  test.case = 'nothing';
  var got = _.longRepresent( [], 0, 0 );
  var expected = [];
  test.identical( got, expected );

  test.case = 'two arguments';
  var got = _.longRepresent( [], 0 );
  var expected = [];
  test.identical( got, expected );

  test.case = 'full copy of an array';
  var got = _.longRepresent( [ 1, 2, 3, 4, 5 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'an array of two elements';
  var got = _.longRepresent( [ 1, 2, 3, 4, 5 ], 2, 4 );
  var expected = [ 3, 4 ];
  test.identical( got, expected );

  test.case = 'from second index to the (arr.length - 1)';
  var got = _.longRepresent( [ 1, 2, 3, 4, 5 ], 2 );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'an offset from the end of the sequence';
  var got = _.longRepresent( [ 1, 2, 3, 4, 5 ], -4 );
  var expected = [ 2, 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'the two negative index';
  var got = _.longRepresent( [ 1, 2, 3, 4, 5 ], -4, -2 );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  test.case = 'the third index is negative';
  var got = _.longRepresent( [ 1, 2, 3, 4, 5 ], 1, -1 );
  var expected = [ 2, 3, 4 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longRepresent();
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longRepresent( 'wrong argument', 1, -1 );
  });

  test.case = 'argument is not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.longRepresent( 1, 2, 3, 4, 5, 2, 4 );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.longRepresent( [ 1, 2, 3, 4, 5 ], 2, 4, 'redundant argument' );
  });

}

//

// function longResize( test )
// {
//   var got, expected;
//
//   test.case = 'defaults';
//   var array = [ 1, 2, 3, 4, 5, 6, 7 ];
//   array.src = true;
//
//   /* just pass array */
//
//   got = _.longResize( array );
//   test.identical( got.src, undefined );
//   test.identical( got, array );
//
//   //
//
//   test.case = 'make copy of source';
//
//   /* third argument is not provided */
//
//   got = _.longResize( array, 2 );
//   test.identical( got.src, undefined );
//   expected = [ 3, 4, 5, 6, 7 ];
//   test.identical( got, expected );
//
//   /* second argument is undefined */
//
//   got = _.longResize( array, undefined, 4  );
//   test.identical( got.src, undefined );
//   expected = [ 1, 2, 3, 4 ];
//   test.identical( got, expected );
//
//   /**/
//
//   got = _.longResize( array, 0, 3 );
//   test.identical( got.src, undefined );
//   expected = [ 1, 2, 3 ];
//   test.identical( got, expected );
//
//   /* from two to six */
//
//   test.case = 'from two to six';
//   got = _.longResize( array, 2, 6 );
//   test.identical( got.src, undefined );
//   expected = [ 3, 4, 5, 6 ];
//   test.identical( got, expected );
//
//   /* rigth bound is negative */
//
//   got = _.longResize( array, 0, -1 );
//   test.identical( got.src, undefined );
//   expected = [];
//   test.identical( got, expected );
//
//   /* both bounds are negative */
//
//   got = _.longResize( array, -1, -3 );
//   test.identical( got.src, undefined );
//   expected = [];
//   test.identical( got, expected );
//
//   /* TypedArray */
//
//   var arr = new U16x( array );
//   arr.src = true;
//   got = _.longResize( arr, 0, 3 );
//   test.identical( got.src, undefined );
//   expected = new U16x( [ 1, 2, 3 ] );
//   test.identical( got, expected );
//
//   /* BufferNode */
//
//   if( Config.interpreter === 'njs' )
//   {
//     test.case = 'buffer';
//     var got = _.longResize( BufferNode.from( '123' ), 0, 5, 0 );
//     var expected = [ 49, 50, 51, 0, 0 ];
//     test.identical( got, expected );
//   }
//
//   /**/
//
//   test.case = 'increase size of array';
//
//   /* rigth bound is out of range */
//
//   got = _.longResize( array, 0, array.length + 2 );
//   test.identical( got.src, undefined );
//   expected = array.slice();
//   expected.push( undefined, undefined );
//   test.identical( got, expected );
//
//   /* indexes are out of bound */
//
//   got = _.longResize( array, array.length + 1, array.length + 3 );
//   test.identical( got.src, undefined );
//   expected = [ undefined, undefined ];
//   test.identical( got, expected );
//
//   /* left bound is negative */
//
//   got = _.longResize( array, -1, array.length );
//   test.identical( got.src, undefined );
//   expected = array.slice();
//   expected.unshift( undefined );
//   test.identical( got, expected );
//
//   /* without setting value */
//
//   got = _.longResize( array, 0, array.length + 2 );
//   test.identical( got.src, undefined );
//   test.identical( got.length, array.length + 2 );
//
//   /* by setting value */
//
//   got = _.longResize( array, 0, array.length + 2, 0 );
//   test.identical( got.src, undefined );
//   expected = [ 1, 2, 3, 4, 5, 6, 7, 0, 0 ];
//   test.identical( got, expected );
//
//   /* by taking only last element of source array */
//
//   got = _.longResize( array, array.length - 1, array.length + 2, 0 );
//   test.identical( got.src, undefined );
//   expected = [ 7, 0, 0 ];
//   test.identical( got, expected );
//
//   test.case = 'decrease size of array';
//
//   /* setting value not affects on array */
//
//   got = _.longResize( array, 0, 3, 0 );
//   test.identical( got.src, undefined );
//   expected = [ 1, 2, 3 ];
//   test.identical( got, expected );
//
//   /* begin index is negative */
//
//   got = _.longResize( array, -1, 3, 0 );
//   test.identical( got.src, undefined );
//   expected = [ 0, 1, 2, 3 ];
//   test.identical( got, expected );
//
//   /* end index is negative */
//
//   got = _.longResize( array, 0, -1 );
//   test.identical( got.src, undefined );
//   expected = [];
//   test.identical( got, expected );
//
//   /* begin index negative, set value */
//
//   got = _.longResize( array, -1, 3, 0 );
//   test.identical( got.src, undefined );
//   expected = [ 0, 1, 2, 3 ];
//   test.identical( got, expected );
//
//   /* TypedArray */
//
//   var arr = new U16x( array );
//   arr.src = true;
//   got = _.longResize( arr, 0, 4, 4 );
//   test.identical( got.src, undefined );
//   expected = new U16x( [ 1, 2, 3, 4 ] );
//   test.identical( got, expected );
//
//   //
//
//   if( Config.interpreter === 'njs' )
//   {
//     test.case = 'buffer';
//     var got = _.longResize( BufferNode.from( '123' ), 0, 5, 0 );
//     var expected = [ 49, 50, 51, 0, 0 ];
//     test.identical( got, expected );
//   }
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longResize();
//   });
//
//   /**/
//
//   test.case = 'invalid arguments type';
//
//   /**/
//
//   test.shouldThrowErrorSync( function()
//   {
//     _.longResize( 1 );
//   })
//
//   /**/
//
//   test.shouldThrowErrorSync( function()
//   {
//     _.longResize( array, '1', array.length )
//   })
//
//   /**/
//
//   test.shouldThrowErrorSync( function()
//   {
//     _.longResize( array, 0, '1' )
//   })
//
//   /**/
//
//   test.case = 'buffer';
//
//   /**/
//
//   got = _.longResize( BufferNode.from( '123' ), 0, 1 );
//   expected = [ 49 ];
//   test.identical( got, expected );
//
//   //
//
//   test.case = 'wrong type of argument';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longResize( 'wrong argument', 'wrong argument', 'wrong argument' );
//   });
//
// };

//

function longDuplicate( test )
{
  test.case = 'couple of repeats';
  var got = _.longDuplicate( [ 'a', 'b', 'c' ] );
  var expected = [ 'a', 'a', 'b', 'b', 'c', 'c' ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfScalarsPerElement 1 numberOfDuplicatesPerElement 1';
  var options =
  {
    src : [ 10, 20 ],
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfScalarsPerElement 1 numberOfDuplicatesPerElement 2';
  var options =
  {
    src : [ 10, 20 ],
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 10, 20, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfScalarsPerElement 2 numberOfDuplicatesPerElement 1';
  var options =
  {
    src : [ 10, 20 ],
    numberOfScalarsPerElement : 2,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfScalarsPerElement 2 numberOfDuplicatesPerElement 2';
  var options =
  {
    src : [ 10, 20 ],
    numberOfScalarsPerElement : 2,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 20, 10, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'result provided';
  var options =
  {
    src : [ 10, 20 ],
    result : [ 1, 1, 1, 1 ],
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 10, 20, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var options =
  {
    src : [ 'abc', 'def' ],
    result : new Array( 6 ),
    numberOfScalarsPerElement : 2,
    numberOfDuplicatesPerElement : 3
  };
  var got = _.longDuplicate( options );
  var expected = [ 'abc', 'def', 'abc', 'def', 'abc', 'def' ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var options =
  {
    src : [ 'abc', 'def' ],
    result : [],
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 'abc', 'def', ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var options =
  {
    src : [ 'abc', 'def' ],
    result : [ 1, 2 ],
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 1, 2, 'abc', 'def', ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var arr = new U8x( 1 );
  arr[ 0 ] = 5;
  var options =
  {
    src : [ 1, 2 ],
    result : arr,
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 5, 1, 2 ];
  var equal = true;
  for( var i = 0; i < expected.length; i++ )
  {
    if( expected[ i ] !== got[ i ] )
    equal = false;
  }
  test.is( equal );
  test.identical( got.length, expected.length );

  /* */

  test.case = 'second argument is replaced and non-existent elements from options.src is replaced undefined';
  var options = {
    src : [ 'abc', 'def', undefined ],
    numberOfScalarsPerElement : 3,
    numberOfDuplicatesPerElement : 3
  };
  var got = _.longDuplicate( options );
  var expected = [ 'abc', 'def', undefined, 'abc', 'def', undefined, 'abc', 'def', undefined ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longDuplicate();
  });

  test.case = 'second argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longDuplicate( [ 'a', 'b', 'c' ], 'wrong argument' );
  });

  test.case = 'options.src is not provided or "undefined"';
  var options = {
    src : undefined,
    result : [],
    numberOfScalarsPerElement : 3,
    numberOfDuplicatesPerElement : 3
  };
  test.shouldThrowErrorSync( function()
  {
    _.longDuplicate( options, { a : 13 } );
  });

  test.case = 'result provided, but not enough length';
  var options =
  {
    src : [ 10, 20 ],
    result : [],
    numberOfScalarsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  test.shouldThrowErrorSync( function ()
  {
    _.longDuplicate( options );
  })


};

// !!!

function longAreRepeatedProbe( test )
{

  _.diagnosticEachLongType( ( make, descriptor ) =>
  {
    _.diagnosticEachElementComparator( make, ( make, evaluate, description ) =>
    {
      if( _.arrayIs( evaluate ) )
      return;
      if( descriptor.isTyped && evaluate )
      return;
      test.open( descriptor.name + ', ' + description );
      group( make, evaluate );
      test.close( descriptor.name + ', ' + description );
    });
  });

  function group( onMake, onEvaluate )
  {

    test.case = 'empty';
    var l1 = onMake( [] );
    var expected = { uniques : 0, condensed : 0, array : [] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

    test.case = 'single';
    var l1 = onMake( [ 0 ] );
    var expected = { uniques : 1, condensed : 1, array : [ 0 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

    test.case = 'two zeros';
    var l1 = onMake( [ 0, 0 ] );
    var expected = { uniques : 0, condensed : 1, array : [ 1, 1 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

    test.case = 'none unique';
    var l1 = onMake( [ 1, 2, 3, 1, 2, 3 ] );
    var expected = { uniques : 0, condensed : 3, array : [ 1, 1, 1, 1, 1, 1 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

    test.case = 'several uniques';
    var l1 = onMake( [ 0, 1, 2, 3, 4, 1, 2, 3, 5 ] );
    var expected = { uniques : 3, condensed : 6, array : [ 0, 1, 1, 1, 0, 1, 1, 1, 0 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

  }

}

//

function longAllAreRepeated( test )
{

  /* Without evaluator */

  test.case = 'empty array';
  var src = [];
  var got = _.longAllAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical numbers of array';
  var src = [ 1, 1 ];
  var got = _.longAllAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical strings of array';
  var src = [ 'string', 'string' ];
  var got = _.longAllAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single number of array';
  var src = [ 1 ];
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical';
  var src = [ 1, 2, 2 ];
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some strings of array are identical';
  var src = [ 'string', 'string', 'diff string' ];
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'complex data of array';
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty';
  var src = _.unrollMake( [] );
  var got = _.longAllAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers';
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longAllAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single number';
  var src = _.unrollMake( [ 1 ] );
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical';
  var src = _.unrollMake( [ 1, 1, 2 ] );
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, complex data';
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longAllAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  /* With evaluator */

  test.case = 'empty array with evaluator';
  var evaluator = ( e ) => e;
  var src = [];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical numbers of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ 1, 1 ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical values of array with evaluator';
  var evaluator = ( e ) => e.val;
  var src = [ { val: 1 }, { val: 1 } ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single number of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ 1 ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single value of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ { val: 1 } ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical with evaluator';
  var evaluator = ( e ) => _.numberIs( e );
  var src = [ 1, 2, 2 ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some values of array are identical with evaluator';
  var evaluator = ( e ) => e.val;
  var src = [ { val: 1 }, { val: 1 }, { val: 3 } ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'complex data of array with evaluator';
  var evaluator = ( e ) => e[ 0 ];
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical values with evaluator';
  var evaluator = ( e ) => e.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 } ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single number with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ 1 ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single value with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ { val: 1 } ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical with evaluator';
  var evaluator = ( e ) => _.numberIs( e );
  var src = _.unrollMake( [ 1, 2, 2 ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some values are identical with evaluator';
  var evaluator = ( e ) => e.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 }, { val: 3 } ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, complex data of array with evaluator';
  var evaluator = ( e ) => e[ 0 ];
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  /* With equalizer */

  test.case = 'empty array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical numbers of array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1, 1 ];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical values of array with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 }, { val: 1 } ];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single number of array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1 ];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single value of array with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 } ];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1, 2, 2 ];
  var got = _.longAllAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some values of array are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 }, { val: 1 }, 11, 3 ];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'complex data of array with equalizer';
  var equalizer = ( e1, e2 ) => e1[ 0 ] === e2[ 0 ];
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical values with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 } ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single number with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1 ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single value with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 } ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1, 2, 2 ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some values are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 }, 11, 3 ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, complex data of array with equalizer';
  var equalizer = ( e1, e2 ) => e1[ 0 ] === e2[ 0 ];
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longAllAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( undefined ) );
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( {} ) );
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( 1 ) );

  test.case = 'onEvalueate is not a routine';
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( [ 1, 1 ], 'wrong' ) );

  test.case = 'single onEvalueate argument';
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( ( e ) => e ) );

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longAllAreRepeated() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longAllAreRepeated( [ 1, 1 ], ( e ) => e, 'extra' ) );
}

//

function longAnyAreRepeated( test )
{

  /* Without evaluator */

  test.case = 'empty array';
  var src = [];
  var got = _.longAnyAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'identical numbers of array';
  var src = [ 1, 1 ];
  var got = _.longAnyAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical strings of array';
  var src = [ 'string', 'string' ];
  var got = _.longAnyAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single number of array';
  var src = [ 1 ];
  var got = _.longAnyAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical';
  var src = [ 1, 2, 2 ];
  var got = _.longAnyAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some strings of array are identical';
  var src = [ 'string', 'string', 'diff string' ];
  var got = _.longAnyAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'complex data of array';
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longAnyAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty';
  var src = _.unrollMake( [] );
  var got = _.longAnyAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers';
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longAnyAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single number';
  var src = _.unrollMake( [ 1 ] );
  var got = _.longAnyAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical';
  var src = _.unrollMake( [ 1, 1, 2 ] );
  var got = _.longAnyAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, complex data';
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longAnyAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  /* With evaluator */

  test.case = 'empty array with evaluator';
  var evaluator = ( e ) => e;
  var src = [];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'identical numbers of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ 1, 1 ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical values of array with evaluator';
  var evaluator = ( e ) => e.val;
  var src = [ { val: 1 }, { val: 1 } ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single number of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ 1 ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single value of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ { val: 1 } ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical with evaluator';
  var evaluator = ( e ) => _.numberIs( e );
  var src = [ 1, 2, 2 ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some values of array are identical with evaluator';
  var evaluator = ( e ) => e.val;
  var src = [ { val: 1 }, { val: 1 }, { val: 3 } ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'complex data of array with evaluator';
  var evaluator = ( e ) => e[ 0 ];
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical values with evaluator';
  var evaluator = ( e ) => e.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 } ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single number with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ 1 ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single value with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ { val: 1 } ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical with evaluator';
  var evaluator = ( e ) => _.numberIs( e );
  var src = _.unrollMake( [ 1, 2, 2 ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some values are identical with evaluator';
  var evaluator = ( e ) => e.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 }, { val: 3 } ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, complex data of array with evaluator';
  var evaluator = ( e ) => e[ 0 ];
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  /* With equalizer */

  test.case = 'empty array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'identical numbers of array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1, 1 ];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical values of array with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 }, { val: 1 } ];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single number of array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1 ];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single value of array with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 } ];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1, 2, 2 ];
  var got = _.longAnyAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some values of array are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 }, { val: 1 }, 11, 3 ];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'complex data of array with equalizer';
  var equalizer = ( e1, e2 ) => e1[ 0 ] === e2[ 0 ];
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical values with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 } ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single number with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1 ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single value with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 } ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1, 2, 2 ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some values are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 }, 11, 3 ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, complex data of array with equalizer';
  var equalizer = ( e1, e2 ) => e1[ 0 ] === e2[ 0 ];
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longAnyAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( undefined ) );
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( {} ) );
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( 1 ) );

  test.case = 'onEvalueate is not a routine';
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( [ 1, 1, 2 ], 'wrong' ) );

  test.case = 'single onEvalueate argument';
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( ( e ) => e ) );

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longAnyAreRepeated( [ 1, 1, 2 ], ( e ) => e, 'extra' ) )
}

//

function longNoneAreRepeated( test )
{

  /* Without evaluator */

  test.case = 'empty array';
  var src = [];
  var got = _.longNoneAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical numbers of array';
  var src = [ 1, 1 ];
  var got = _.longNoneAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'identical strings of array';
  var src = [ 'string', 'string' ];
  var got = _.longNoneAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single number of array';
  var src = [ 1 ];
  var got = _.longNoneAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical';
  var src = [ 1, 2, 2 ];
  var got = _.longNoneAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some strings of array are identical';
  var src = [ 'string', 'string', 'diff string' ];
  var got = _.longNoneAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'complex data of array';
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longNoneAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty';
  var src = _.unrollMake( [] );
  var got = _.longNoneAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers';
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longNoneAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single number';
  var src = _.unrollMake( [ 1 ] );
  var got = _.longNoneAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical';
  var src = _.unrollMake( [ 1, 1, 2 ] );
  var got = _.longNoneAreRepeated( src );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, complex data';
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longNoneAreRepeated( src );
  var expected = true;
  test.identical( got, expected );

  /* With evaluator */

  test.case = 'empty array with evaluator';
  var evaluator = ( e ) => e;
  var src = [];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical numbers of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ 1, 1 ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'identical values of array with evaluator';
  var evaluator = ( e ) => e.val;
  var src = [ { val: 1 }, { val: 1 } ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single number of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ 1 ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single value of array with evaluator';
  var evaluator = ( e ) => e;
  var src = [ { val: 1 } ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical with evaluator';
  var evaluator = ( e ) => _.numberIs( e );
  var src = [ 1, 2, 2 ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some values of array are identical with evaluator';
  var evaluator = ( e ) => e.val;
  var src = [ { val: 1 }, { val: 1 }, { val: 3 } ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'complex data of array with evaluator';
  var evaluator = ( e ) => e[ 0 ];
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, identical values with evaluator';
  var evaluator = ( e ) => e.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 } ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single number with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ 1 ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single value with evaluator';
  var evaluator = ( e ) => e;
  var src = _.unrollMake( [ { val: 1 } ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical with evaluator';
  var evaluator = ( e ) => _.numberIs( e );
  var src = _.unrollMake( [ 1, 2, 2 ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some values are identical with evaluator';
  var evaluator = ( e ) => e.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 }, { val: 3 } ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, complex data of array with evaluator';
  var evaluator = ( e ) => e[ 0 ];
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  /* With equalizer */

  test.case = 'empty array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'identical numbers of array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1, 1 ];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'identical values of array with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 }, { val: 1 } ];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'single number of array with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1 ];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'single value of array with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 } ];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'some numbers of array are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = [ 1, 2, 2 ];
  var got = _.longNoneAreRepeated( src, evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'some values of array are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = [ { val: 1 }, { val: 1 }, 11, 3 ];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'complex data of array with equalizer';
  var equalizer = ( e1, e2 ) => e1[ 0 ] === e2[ 0 ];
  var src = [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ];
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  /**/

  test.case = 'unroll empty with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, identical numbers with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1, 1 ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, identical values with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 } ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, single number with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1 ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, single value with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 } ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'unroll, some numbers are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1 === e2;
  var src = _.unrollMake( [ 1, 2, 2 ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, some values are identical with equalizer';
  var equalizer = ( e1, e2 ) => e1.val === e2.val;
  var src = _.unrollMake( [ { val: 1 }, { val: 1 }, 11, 3 ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'unroll, complex data of array with equalizer';
  var equalizer = ( e1, e2 ) => e1[ 0 ] === e2[ 0 ];
  var src = _.unrollMake( [ [ 1, 0 ], [ 1, 1 ], [ 1, 2 ] ] );
  var got = _.longNoneAreRepeated( src, equalizer );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( 'wrong argument' ) );
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( undefined ) );
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( {} ) );
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( 1 ) );

  test.case = 'onEvalueate is not a routine';
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( [ 1, 2 ], 'wrong' ) );

  test.case = 'single onEvalueate argument';
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( ( e ) => e ) );

  test.case = 'without argument';
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longNoneAreRepeated( [ 1, 2 ], ( e ) => e, 'extra' ) );
}

//

function longMask( test )
{

  test.case = 'nothing';
  var got = _.longMask( [ 1, 2, 3, 4 ], [ undefined, null, 0, '' ] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'adds last three values';
  var got = _.longMask( [ 'a', 'b', 'c', 4, 5 ], [ 0, '', 1, 2, 3 ] );
  var expected = [ "c", 4, 5 ];
  test.identical( got, expected );

  test.case = 'adds the certain values';
  var got = _.longMask( [ 'a', 'b', 'c', 4, 5, 'd' ], [ 3, 7, 0, '', 13, 33 ] );
  var expected = [ "a", 'b', 5, 'd' ];
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longMask();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longMask( [ 1, 2, 3, 4 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.longMask( [ 'a', 'b', 'c', 4, 5 ], [ 0, '', 1, 2, 3 ], 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longMask( 'wrong argument', 'wrong argument' );
  });

  test.case = 'both arrays are empty';
  test.shouldThrowErrorSync( function()
  {
    _.longMask( [], [] );
  });

  test.case = 'length of the first array is not equal to the second array';
  test.shouldThrowErrorSync( function()
  {
    _.longMask( [ 1, 2, 3 ], [ undefined, null, 0, '' ] );
  });

  test.case = 'length of the second array is not equal to the first array';
  test.shouldThrowErrorSync( function()
  {
    _.longMask( [ 1, 2, 3, 4 ], [ undefined, null, 0 ] );
  });
}

//

function longOnceWithoutCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x
  ];

  for( let d = 0 ; d < list.length ; d++ )
  {
    test.open( 'dst = ' + list[ d ].name );
    testRun( list[ d ] );
    test.close( 'dst = ' + list[ d ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'dst = null';
    var dst = new makeLong( null );
    var got = _.longOnce( dst );
    var expected = new makeLong( null );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length = 0';
    var dst = new makeLong( [] );
    var got = _.longOnce( dst );
    var expected = new makeLong( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length = 1';
    var dst = new makeLong( [ 1 ] );
    var got = _.longOnce( dst );
    var expected = new makeLong( [ 1 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length > 1, no duplicates';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longOnce( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length > 1, duplicates';
    var dst = new makeLong( [ 1, 2, 2, 1, 5, 3, 4, 5, 5, 3 ] );
    var got = _.longOnce( dst );
    var expected = _.argumentsArrayIs( dst ) ? [ 1, 2, 5, 3, 4 ] : new makeLong( [ 1, 2, 5, 3, 4 ] );
    test.identical( got, expected );
    test.is( !_.argumentsArrayIs( dst ) && !_.bufferAnyIs( dst ) ? got === dst : got !== dst );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longOnce() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longOnce( [ 1, 2 ], [ 1, 3 ], ( a, b ) => a === b, 'extra' ) );

  test.case = 'wrong dst type';
  test.shouldThrowErrorSync( () => _.longOnce( 'wrong' ) );

  test.case = 'wrong src type';
  test.shouldThrowErrorSync( () => _.longOnce( [ 1, 2 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longOnce( [ 1, 2 ], { a : 1 } ) );

  test.case = 'onEvaluate is not a routine';
  test.shouldThrowErrorSync( () => _.longOnce( [ 1, 2 ], [ 1, 3 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longOnce( [ 1, 2 ], [ 1, 3 ], [ 1, 2, 3 ] ) );
}

//

function longOnceWithCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
  ];

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( 'dst = ' + list[ i ].name );
    testRun( list[ i ] );
    test.close( 'dst = ' + list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'dst has duplicates, evaluator';
    var dst = makeLong( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce( dst, ( e ) => e.v );
    var expected = _.argumentsArrayIs( dst ) ? [ { v : 1 }, { v : 2 }, { v : 3 } ] : makeLong( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'dst has not duplicates, evaluator';
    var dst = makeLong( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    var got = _.longOnce( dst, ( e ) => _.mapIs( e ) ? e.v : e );
    var expected = makeLong( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    test.is( got === dst );

    /* */

    test.case = 'dst has duplicates';
    var equalizer = function( e1, e2 )
    {
      e1 = _.mapIs( e1 ) ? e1.v : e1;
      e2 = _.mapIs( e2 ) ? e2.v : e2;
      return e1 === e2;
    }
    var dst = makeLong( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce( dst, equalizer );
    var expected = _.argumentsArrayIs( dst ) ? [ { v : 1 }, { v : 2 }, { v : 3 } ] : makeLong( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );

    test.case = 'dst has not duplicates';
    var equalizer = function( e1, e2 )
    {
      e1 = _.mapIs( e1 ) ? e1.v : e1;
      e2 = _.mapIs( e2 ) ? e2.v : e2;
      return e1 === e2;
    }
    var dst = makeLong( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    var got = _.longOnce( dst, equalizer );
    var expected = makeLong( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    test.is( got === dst );
  }
}

//

function longOnce_WithoutCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x
  ];

  for( let d = 0 ; d < list.length ; d++ )
  {
    test.open( 'dst = ' + list[ d ].name );
    testRun( list[ d ] );
    test.close( 'dst = ' + list[ d ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'dst - null, src - undefined';
    var dst = null;
    var got = _.longOnce_( dst );
    var expected = [];
    test.identical( got, expected );

    test.case = 'dst - long from null, src - undefined';
    var dst = new makeLong( null );
    var got = _.longOnce_( dst );
    var expected = new makeLong( null );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length - 0, src - undefined';
    var dst = new makeLong( [] );
    var got = _.longOnce_( dst );
    var expected = new makeLong( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length - 1, src - undefined';
    var dst = new makeLong( [ 1 ] );
    var got = _.longOnce_( dst );
    var expected = new makeLong( [ 1 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length > 1, no duplicates, src - undefined';
    var dst = new makeLong( [ 1, 2, 3, 4, 5 ] );
    var got = _.longOnce_( dst );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length > 1, duplicates, src - undefined';
    var dst = new makeLong( [ 1, 2, 2, 1, 5, 3, 4, 5, 5, 3 ] );
    var got = _.longOnce_( dst );
    var expected = _.argumentsArrayIs( dst ) ? [ 1, 2, 5, 3, 4 ] : new makeLong( [ 1, 2, 5, 3, 4 ] );
    test.identical( got, expected );
    test.is( !_.argumentsArrayIs( dst ) && !_.bufferAnyIs( dst ) ? got === dst : got !== dst );

    /* */

    test.case = 'dst - null, src - empty ' + makeLong.name;
    var dst = null;
    var src = new makeLong( null );
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( null );
    test.equivalent( got, expected );
    test.is( got !== dst );

    test.case = 'dst - null, src - ' + makeLong.name + ' without duplicates';
    var dst = null;
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.equivalent( got, expected );
    test.is( got !== dst );

    test.case = 'dst - null, src - ' + makeLong.name + ' with duplicates';
    var dst = null;
    var src = new makeLong( [ 1, 2, 3, 4, 5, 1, 2, 3, 4, 5  ] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 1, 2, 3, 4, 5 ] );
    test.equivalent( got, expected );
    test.is( got !== dst );

    /* */

    test.case = 'dst - empty' + makeLong.name + ' src - empty ' + makeLong.name;
    var dst = new makeLong( [] );
    var src = new makeLong( null );
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( null );
    test.equivalent( got, expected );
    test.is( got === dst );

    test.case = 'dst - empty ' + makeLong.name + ', src - ' + makeLong.name + ' with duplicates';
    var dst = new makeLong( [] );
    var src = new makeLong( [ 0, 0, 0 ] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 0 ] );
    test.equivalent( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );

    test.case = 'dst - with duplicates, src - empty ' + makeLong.name;
    var dst = new makeLong( [ 0, 0, 0 ] );
    var src = new makeLong( [] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 0, 0, 0 ] );
    test.equivalent( got, expected );
    test.is( got === dst );

    test.case = 'dst and src is almost identical';
    var dst = new makeLong( [ 0, 0, 0 ] );
    var src = new makeLong( [ 0, 0, 0 ] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 0, 0, 0 ] );
    test.equivalent( got, expected );
    test.is( got === dst );

    test.case = 'dst - ' + makeLong.name + ' with, duplicates, src - ' + makeLong.name + ' without duplicates';
    var dst = new makeLong( [ 0, 0, 0 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5 ] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 0, 0, 0, 1, 2, 3, 4, 5 ] );
    test.equivalent( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );

    test.case = 'dst - ' + makeLong.name + ' with, duplicates, src - ' + makeLong.name + ' with duplicates';
    var dst = new makeLong( [ 0, 0, 0 ] );
    var src = new makeLong( [ 1, 2, 3, 4, 5, 0, 0, 1, 2, 3, 4, 5 ] )
    var got = _.longOnce_( dst, src );
    var expected = new makeLong( [ 0, 0, 0, 1, 2, 3, 4, 5 ] );
    test.equivalent( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longOnce_() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longOnce_( [ 1, 2 ], [ 1, 3 ], ( a, b ) => a === b, 'extra' ) );

  test.case = 'wrong dst type';
  test.shouldThrowErrorSync( () => _.longOnce_( 'wrong' ) );

  test.case = 'wrong src type';
  test.shouldThrowErrorSync( () => _.longOnce_( [ 1, 2 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longOnce_( [ 1, 2 ], { a : 1 } ) );

  test.case = 'onEvaluate is not a routine';
  test.shouldThrowErrorSync( () => _.longOnce_( [ 1, 2 ], [ 1, 3 ], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longOnce_( [ 1, 2 ], [ 1, 3 ], [ 1, 2, 3 ] ) );
}

//

function longOnce_WithCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
  ];

  var evaluator = ( e ) => _.mapIs( e ) ? e.v : e;
  var equalizer = function( e1, e2 )
  {
    e1 = _.mapIs( e1 ) ? e1.v : e1;
    e2 = _.mapIs( e2 ) ? e2.v : e2;
    return e1 === e2;
  }

  /* - */

  for( let i = 0 ; i < list.length ; i++ )
  {
    test.open( 'dst = ' + list[ i ].name );

    test.open( 'onEvaluate = evaluator' );
    testRun( list[ i ], evaluator );
    test.close( 'onEvaluate = evaluator' );

    /* - */

    test.open( 'onEvaluate = equalizer' );
    testRun( list[ i ], equalizer );
    test.close( 'onEvaluate = equalizer' );

    test.close( 'dst = ' + list[ i ].name );
  }

  /* - */

  function testRun( makeDst, onEvaluate )
  {
    var result = ( dst, src ) =>

    test.case = 'dst has duplicates, src - undefined';
    var dst = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce_( dst, onEvaluate );
    var expected = _.argumentsArrayIs( dst ) ? [ { v : 1 }, { v : 2 }, { v : 3 } ] : makeDst( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );

    test.case = 'dst has not duplicates, src - undefined';
    var dst = makeDst( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    var got = _.longOnce_( dst, onEvaluate );
    var expected = makeDst( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    test.is( got === dst );

    /* */

    test.case = 'dst - null, src - undefined';
    var dst = null;
    var got = _.longOnce_( dst, onEvaluate );
    var expected = [];
    test.equivalent( got, expected );
    test.is( got !== dst );

    test.case = 'dst - null, src - empty ' + makeDst.name;
    var dst = null;
    var src = makeDst( null );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( null );
    test.equivalent( got, expected );
    test.is( got !== dst );

    test.case = 'dst - null, src - ' + makeDst.name + ' without duplicates';
    var dst = null;
    var src = makeDst( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.equivalent( got, expected );
    test.is( got !== dst );

    test.case = 'dst - null, src - ' + makeDst.name + ' with duplicates';
    var dst = null;
    var src = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.equivalent( got, expected );
    test.is( got !== dst );

    /* */

    test.case = 'dst - empty' + makeDst.name + ' src - empty ' + makeDst.name;
    var dst = makeDst( [] );
    var src = makeDst( null );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( null );
    test.equivalent( got, expected );
    test.is( got === dst );

    test.case = 'dst - empty ' + makeDst.name + ', src - ' + makeDst.name + ' with duplicates';
    var dst = makeDst( [] );
    var src = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.equivalent( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );

    test.case = 'dst - with duplicates, src - empty ' + makeDst.name;
    var dst = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var src = makeDst( [] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    test.equivalent( got, expected );
    test.is( got === dst );

    test.case = 'dst and src is almost identical';
    var dst = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var src = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    test.equivalent( got, expected );
    test.is( got === dst );

    test.case = 'dst - ' + makeDst.name + ' with, duplicates, src - ' + makeDst.name + ' without duplicates';
    var dst = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var src = makeDst( [ { v : 4 }, { v : 5 } ] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 }, { v : 4 }, { v : 5 } ] );
    test.equivalent( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );

    test.case = 'dst - ' + makeDst.name + ' with, duplicates, src - ' + makeDst.name + ' with duplicates';
    var dst = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var src = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 4 } ] );
    var got = _.longOnce_( dst, src, onEvaluate );
    var expected = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 }, { v : 4 } ] );
    test.equivalent( got, expected );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
  }
}

//

function longShrinkWithIndices( test )
{

  test.case = 'nothing';
  var got = _.longShrinkWithIndices( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'certain elements';
  var got = _.longShrinkWithIndices( [ 1, 2, 3, 4, 5 ], [ 2, 3, 4 ] );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'array of undefined';
  var got = _.longShrinkWithIndices( [ 1, 2, 3 ], [ 4, 5 ] );
  var expected = [ undefined, undefined ];
  test.identical( got, expected );

  test.case = 'using object';
  var src = [ 1, 1, 2, 2, 3, 3 ];
  var indices = { scalarsPerElement : 2, indices : [ 0, 1, 2 ] }
  var got = _.longShrinkWithIndices( src, indices );
  var expected = [ 1, 1, 2, 2, 3, 3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longShrinkWithIndices();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longShrinkWithIndices( [ 1, 2, 3 ] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longShrinkWithIndices('wrong argument', 'wrong argument');
  });

  test.case = 'arguments are not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.longShrinkWithIndices( 1, 2, 3, 4, 5 );
  });

};

//

function longSwapElements( test )
{

  test.case = 'an element';
  var got = _.longSwapElements( [ 7 ], 0, 0 );
  var expected = [ 7 ];
  test.identical( got, expected );

  test.case = 'reverses first index and last index';
  var got = _.longSwapElements( [ 1, 2, 3, 4, 5 ], 0, 4 );
  var expected = [ 5, 2, 3, 4, 1 ];
  test.identical( got, expected );

  test.case = 'swaps first two';
  var got = _.longSwapElements( [ 1, 2, 3 ] );
  var expected = [ 2, 1, 3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longSwapElements();
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longSwapElements('wrong argument', 'wrong argument', 'wrong argument');
  });

  test.case = 'arguments[1] and arguments[2] are out of bound';
  test.shouldThrowErrorSync( function()
  {
    _.longSwapElements( [ 1, 2, 3, 4, 5 ], -1, -4 );
  });

  test.case = 'first five arguments are not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.longSwapElements( 1, 2, 3, 4, 5, 0, 4 );
  });

};

//

function longPut( test )
{

  test.case = 'adds after second element';
  var got = _.longPut( [ 1, 2, 3, 4, 5, 6, 9 ], 2, 'str', true, [ 7, 8 ] );
  var expected = [ 1, 2, 'str', true, 7, 8, 9 ];
  test.identical( got, expected );

  test.case = 'adds at the beginning';
  var got = _.longPut( [ 1, 2, 3, 4, 5, 6, 9 ], 0, 'str', true, [ 7, 8 ] );
  var expected = [ 'str', true, 7, 8, 5, 6, 9 ];
  test.identical( got, expected );

  test.case = 'add to end';
  var got = _.longPut( [ 1, 2, 3 ], 3, 4, 5, 6 );
  var expected = [ 1, 2, 3, 4, 5, 6 ];
  test.identical( got, expected );

  test.case = 'offset is negative';
  var got = _.longPut( [ 1, 2, 3 ], -1, 4, 5, 6 );
  var expected = [ 5, 6, 3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longPut();
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longPut( 'wrong argument', 'wrong argument', 'str', true, [ 7, 8 ] );
  });

};

//

/*
 aaa : Dmytro : not used
*/
// function longFillTimes( test )
// {
//   test.case = 'empty array';
//   var got = _.longFillTimes( [], 1 );
//   var expected = [ 0 ];
//   test.identical( got, expected );
//
//   test.case = 'times is negative, times = length + times';
//   var got = _.longFillTimes( [ 0, 0, 0 ], -1, 1 );
//   var expected = [ 1, 1, 0 ];
//   test.identical( got, expected );
//
//   test.case = 'times is negative';
//   var got = _.longFillTimes( [ 0, 0 ], -2, 1 );
//   var expected = [ 0, 0 ];
//   test.identical( got, expected );
//
//   test.case = 'empty array, value passed';
//   var got = _.longFillTimes( [], 1, 1 );
//   var expected = [ 1 ];
//   test.identical( got, expected );
//
//   test.case = 'empty array, value is an array';
//   var got = _.longFillTimes( [], 1, [ 1, 2, 3 ] );
//   var expected = [ [ 1, 2, 3 ]];
//   test.identical( got, expected );
//
//   test.case = 'times > array.length';
//   var got = _.longFillTimes( [ 0 ], 3, 1 );
//   var expected = [ 1, 1, 1 ];
//   test.identical( got, expected );
//
//   test.case = 'times < array.length';
//   var got = _.longFillTimes( [ 0, 0, 0 ], 1, 1 );
//   var expected = [ 1, 0, 0 ];
//   test.identical( got, expected );
//
//   test.case = 'TypedArray';
//   var arr = new U16x();
//   var got = _.longFillTimes( arr, 3, 1 );
//   var expected = new U16x( [ 1, 1, 1 ] );
//   test.identical( got, expected );
//
//   test.case = 'ArrayLike without fill routine';
//   var arr = (() => arguments )( 1 );
//   var got = _.longFillTimes( arr, 3, 1 );
//   var expected = [ 1, 1, 1 ];
//   test.identical( got, expected );
//
//   test.case = 'no fill routine, times is negative';
//   var arr = [ 1, 1, 1 ];
//   arr.fill = null;
//   var got = _.longFillTimes( arr, -1, 3 );
//   var expected = [ 3, 3, 1 ];
//   test.identical( got, expected );
//
//   /**/
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longFillTimes();
//
//   });
//
//   test.case = 'zero';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longFillTimes( 0 );
//   });
//
//   test.case = 'only one argument';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longFillTimes( [] );
//   });
//
//   test.case = 'wrong argument type';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longFillTimes( new BufferRaw(), 1 );
//   });
//
// };

//

function longFill( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( let d = 0 ; d < list.length ; d++ )
  {
    test.open( list[ d ].name );
    testRun( list[ d ] );
    test.close( list[ d ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'empty container, no value, no range';
    var dst = new makeLong( [] );
    var got = _.longFill( dst );
    var expected = new makeLong( [] );
    test.is( got === dst );
    test.identical( got, expected );

    test.case = 'dst - empty container, value';
    var dst = new makeLong( [] );
    var got = _.longFill( dst, 1 );
    var expected = new makeLong( [] );
    test.is( got === dst );
    test.identical( got, expected );

    test.case = 'dst = empty container, value, range[ 1 ] > dst.length';
    var dst = new makeLong( [] );
    var got = _.longFill( dst, 1, [ 0, 3 ] );
    var expected = _.argumentsArrayIs( dst ) ? [ 1, 1, 1 ] : new makeLong( [ 1, 1, 1 ] );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
    test.identical( got, expected );

    test.case = 'dst = empty container, value, range[ 0 ] < 0, range[ 1 ] > dst.length';
    var dst = new makeLong( [] );
    var got = _.longFill( dst, 1, [ -2, 3 ] );
    var expected = _.argumentsArrayIs( dst ) ? [ 1, 1, 1, 1, 1 ] : new makeLong( [ 1, 1, 1, 1, 1 ] );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
    test.identical( got, expected );

    test.case = 'dst = empty container, value, range[ 1 ] < range[ 0 ]';
    var dst = new makeLong( [] );
    var got = _.longFill( dst, 1, [ 0, -2 ] );
    var expected = new makeLong( [] );
    test.is( got === dst );
    test.identical( got, expected );

    test.case = 'dst = not empty container, no value, no range';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst );
    var expected = new makeLong( [ 0, 0, 0 ] );
    test.is( got === dst );
    test.identical( got, expected );

    test.case = 'dst = not empty container, value';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst, 3 );
    var expected = new makeLong( [ 3, 3, 3 ] );
    test.is( got === dst );
    test.identical( got, expected );

    test.case = 'dst - not empty container, value, range - number';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst, 2, 4 );
    var expected = _.argumentsArrayIs( dst ) ? [ 2, 2, 2, 2 ] : new makeLong( [ 2, 2, 2, 2 ] );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
    test.identical( got, expected );

    test.case = 'dst = not empty container, value, range';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst, 4, [ 1, 2 ] );
    var expected = new makeLong( [ 1, 4, 1 ] );
    test.is( got === dst );
    test.identical( got, expected );

    test.case = 'dst - not empty container, value, range[ 0 ] < 0';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst, 2, [ -2, 2 ] );
    var expected = _.argumentsArrayIs( dst ) ? [ 2, 2, 2, 2 ] : new makeLong( [ 2, 2, 2, 2 ] );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
    test.identical( got, expected );

    test.case = 'dst - not empty container, value, range[ 1 ] > dst.length';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst, 2, [ 0, 4 ] );
    var expected = _.argumentsArrayIs( dst ) ? [ 2, 2, 2, 2 ] : new makeLong( [ 2, 2, 2, 2 ] );
    test.is( _.arrayIs( dst ) ? got === dst : got !== dst );
    test.identical( got, expected );

    test.case = 'dst - not empty container, value, range[ 1 ] < range[ 0 ]';
    var dst = new makeLong( [ 1, 1, 1 ] );
    var got = _.longFill( dst, 2, [ 2, 1 ] );
    var expected = new makeLong( [ 1, 1, 1 ] );
    test.is( got === dst );
    test.identical( got, expected );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longFill() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longFill( [ 1, 1, 1 ], 2, [ 1, 3 ], 1, 2 ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longFill( [ 1, 1 ], 2, [ 1 ] ) );

  test.case = 'wrong argument type';
  test.shouldThrowErrorSync( () => _.longFill( new BufferRaw(), 1 ) );
  test.shouldThrowErrorSync( () => _.longFill( BufferNode.alloc( 10 ), 1 ) );
}

//

function longSupplement( test )
{

  test.case = 'empty array';
  var got = _.longSupplement( [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'only numbers';
  var got = _.longSupplement( [ 4, 5 ], [ 1, 2, 3 ], [ 6, 7, 8, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
  var expected = [ 4, 5, 33, 13, 9, 7 ];
  test.identical( got, expected );

  test.case = 'only numbers and undefined';
  var got = _.longSupplement( [ 4, 5 ], [ 1, 2, 3 ], [ 6, 7, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
  var expected = [ 4, 5, 33, 13, undefined, 7 ];
  test.identical( got, expected );

  test.case = 'only numbers';
  var got = _.longSupplement( [ 'a', 'b' ], [ 1, 2, 3 ], [ 6, 7, 8, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
  var expected = [ 6, 7, 33, 13, 9, 7 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longSupplement();
  });

  test.case = 'arguments are wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longSupplement( 'wrong argument', 'wrong arguments' );
  });

};

//

function longExtendScreening( test )
{

  test.case = 'returns an empty array';
  var got = _.longExtendScreening( [], [], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'returns the corresponding values by indexes of the first argument';
  var got = _.longExtendScreening( [ 1, 2, 3 ], [], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [ 5, 6, 2 ];
  test.identical( got, expected );

  test.case = 'creates a new array and returns the corresponding values by indexes of the first argument';
  var got = _.longExtendScreening( [ 1, 2, 3 ], null, [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [ 5, 6, 2 ];
  test.identical( got, expected );

  test.case = 'returns the corresponding values by indexes of the first argument';
  var got = _.longExtendScreening( [ 1, 2, 3 ], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
  var expected = [ 'a', 6, 2, 13 ];
  test.identical( got, expected );

  test.case = 'returns the second argument';
  var got = _.longExtendScreening( [], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
  var expected = [ 3, 'abc', 7, 13 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longExtendScreening();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longExtendScreening( [ 1, 2, 3, 'abc', 13 ] );
  });

  test.case = 'next arguments are wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longExtendScreening( [ 1, 2, 3 ], [ 3, 'abc', 7, 13 ], [ 3, 7 ], 'wrong arguments' );
  });

  test.case = 'arguments are wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longExtendScreening( 'wrong argument', 'wrong argument', 'wrong arguments' );
  });

};

//

function longSortDstIsNull( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x
  ];

  for( let d = 0 ; d < list.length ; d++ )
  {
    test.open( `dst - null, src - ${ list[ d ].name }` );
    testRun( list[ d ] );
    test.close( `dst - null, src - ${ list[ d ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'empty container';
    var dst = null;
    var src = new makeLong( [] );
    var got = _.longSort( dst, src );
    test.identical( got, [] );

    test.case = 'not empty container';
    if( makeLong.name !== 'Uint8ClampedArray' && makeLong.name !== 'Uint8Array' && makeLong.name !== 'Uint16Array' && makeLong.name !== 'Uint32Array' )
    {
      var dst = null;
      var src = new makeLong( [ 1, 5, 14, 4, 3, 0, -2, 10, -12 ] );
      var got = _.longSort( dst, src );
      test.identical( got, [ -12, -2, 0, 1, 10, 14, 3, 4, 5 ] );
    }

    test.case = 'not empty container, onEvaluate - comparator';
    var dst = null;
    var src = new makeLong( [ 1, 5, 14, 4, 3, 0, 0, 10, 10 ] );
    var comparator = ( a, b ) =>
    {
      if( a > b )
      return 1;
      else if( a === b )
      return 0;
      else
      return -1;
    };
    var got = _.longSort( dst, src, comparator );
    test.identical( got, [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] );

    test.case = 'not empty container, onEvaluate - evaluator';
    var dst = null;
    var src = new makeLong( [ 1, 5, 14, 4, 3, 0, 0, 10, 10 ] );
    var got = _.longSort( dst, src, ( a ) => a );
    test.identical( got, [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] );
  }

}

//

function longSortDstIsNotNull( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x
  ];

  var comparator = ( a, b ) =>
  {
    if( a > b )
    return 1;
    else if( a === b )
    return 0;
    else
    return -1;
  };

  for( let d = 0 ; d < list.length ; d++ )
  {
    test.open( `dst - ${ list[ d ].name }` );
    testRun( list[ d ] );
    test.close( `dst - ${ list[ d ].name }` );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'not empty container, onEvaluate - evaluator, negative numbers';
    if( makeLong.name !== 'Uint8ClampedArray' && makeLong.name !== 'Uint8Array' && makeLong.name !== 'Uint16Array' && makeLong.name !== 'Uint32Array' )
    {
      var dst = new makeLong( [ 1, 5, 14, 4, 3, 0, -2, 10, -12 ] );
      var got = _.longSort( dst, ( e ) => e );
      var exp = _.argumentsArrayIs( dst ) ? [ -12, -2, 0, 1, 3, 4, 5, 10, 14 ] : new makeLong( [ -12, -2, 0, 1, 3, 4, 5, 10, 14 ] );
      test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
      test.identical( got, exp );
    }

    test.case = 'not empty container, onEvaluate - comparator';
    var dst = new makeLong( [ 1, 5, 14, 4, 3, 0, 0, 10, 10 ] );
    var got = _.longSort( dst, comparator );
    var exp = _.argumentsArrayIs( dst ) ? [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] : new makeLong( [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.identical( got, exp );

    test.case = 'not empty container, srcLong - array, onEvaluate - comparator';
    var dst = new makeLong( [ 1, 5, 14, 4, 3, 0, 0, 10, 10 ] );
    var src = [ 1, 5, 14 ];
    var got = _.longSort( dst, src, comparator );
    var exp = _.argumentsArrayIs( dst ) ? [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] : new makeLong( [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.identical( got, exp );

    test.case = 'not empty container, onEvaluate - evaluator';
    var dst = new makeLong( [ 1, 5, 14, 4, 3, 0, 0, 10, 10 ] );
    var got = _.longSort( dst, ( a ) => a );
    var exp = _.argumentsArrayIs( dst ) ? [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] : new makeLong( [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.identical( got, exp );

    test.case = 'not empty container, srcLong - empty array, onEvaluate - evaluator';
    var dst = new makeLong( [ 1, 5, 14, 4, 3, 0, 0, 10, 10 ] );
    var src = [];
    var got = _.longSort( dst, src, ( a ) => a );
    var exp = _.argumentsArrayIs( dst ) ? [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] : new makeLong( [ 0, 0, 1, 3, 4, 5, 10, 10, 14 ] );
    test.is( _.argumentsArrayIs( dst ) ? got !== dst : got === dst );
    test.identical( got, exp );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longSort() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longSort( [ 1, 2 ], [ null, 1 ], ( e ) => e, 'extra' ) );

  test.case = 'wrong type of onEvaluate';
  test.shouldThrowErrorSync( () => _.longSort( [ 1, 2 ], [ null, 1 ], 'wrong' ) );

  test.case = 'wrong type of dstLong';
  test.shouldThrowErrorSync( () => _.longSort( 'wrong', [ 1, 2 ] ) );

  test.case = 'wrong type of srcLong';
  test.shouldThrowErrorSync( () => _.longSort( [ 1, 2 ], 'wrong' ) );

  test.case = 'wrong length of onEvaluate';
  test.shouldThrowErrorSync( () => _.longSort( [ 1, 2 ], [ null, 1 ], () => 1 ) );
  test.shouldThrowErrorSync( () => _.longSort( [ 1, 2 ], [ null, 1 ], ( a, b, c ) => a + b > c ) );
}

//

function longRandom( test )
{
  test.case = 'length - number';
  var got = _.longRandom( 5 );
  test.identical( got.length, 5 );
  test.is( got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] >= 0 && got[ 1 ] <= 1 );

  test.case = 'length - range';
  var got = _.longRandom( [ 2, 5 ] );
  test.is( got.length >= 2 && got.length <= 5 );
  test.is( got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] >= 0 && got[ 1 ] <= 1 );

  test.case = 'dst, range, length === dst.length';
  var dst = [ 2, 2, 2 ];
  var got = _.longRandom( dst, [ 0, 1 ], 3 );
  test.is( got === dst );
  test.is( got[ 0 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] !== 2 && got[ 1 ] >= 0 && got[ 1 ] <= 1 );
  test.is( got[ 2 ] !== 2 && got[ 2 ] >= 0 && got[ 2 ] <= 1 );

  test.case = 'dst, range - number, length === dst.length';
  var dst = [ 2, 2, 2 ];
  var got = _.longRandom( dst, 5, 3 );
  test.is( got === dst );
  test.is( got[ 0 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 5 );
  test.is( got[ 1 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 5 );
  test.is( got[ 2 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 5 );

  test.case = 'dst, range, length === null';
  var dst = [ 2, 2, 2 ];
  var got = _.longRandom( dst, [ 0, 1 ], null );
  test.is( got === dst );
  test.is( got[ 0 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] !== 2 && got[ 1 ] >= 0 && got[ 1 ] <= 1 );
  test.is( got[ 2 ] !== 2 && got[ 2 ] >= 0 && got[ 2 ] <= 1 );

  test.case = 'dst - unroll, range, length === null';
  var dst = _.unrollMake( [ 2, 2, 2 ] );
  var got = _.longRandom( dst, [ 0, 1 ], null );
  test.is( got === dst );
  test.is( _.unrollIs( got ) );
  test.is( got[ 0 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] !== 2 && got[ 1 ] >= 0 && got[ 1 ] <= 1 );
  test.is( got[ 2 ] !== 2 && got[ 2 ] >= 0 && got[ 2 ] <= 1 );

  test.case = 'dst, range, length !== dst.length';
  var dst = [ 2, 2, 2 ];
  var got = _.longRandom( dst, [ 0, 1 ], 4 );
  test.identical( dst, [ 2, 2, 2 ] );
  test.is( got !== dst );
  test.is( got[ 0 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] !== 2 && got[ 1 ] >= 0 && got[ 1 ] <= 1 );
  test.is( got[ 2 ] !== 2 && got[ 2 ] >= 0 && got[ 2 ] <= 1 );
  test.is( got[ 3 ] !== 2 && got[ 3 ] >= 0 && got[ 3 ] <= 1 );

  test.case = 'dst - unroll, range, length !== dst.length';
  var dst = _.unrollMake( [ 2, 2, 2 ] );
  var got = _.longRandom( dst, [ 0, 1 ], 4 );
  test.identical( dst, [ 2, 2, 2 ] );
  test.is( _.unrollIs( dst ) );
  test.is( _.unrollIs( got ) );
  test.is( got !== dst );
  test.is( got[ 0 ] !== 2 && got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] !== 2 && got[ 1 ] >= 0 && got[ 1 ] <= 1 );
  test.is( got[ 2 ] !== 2 && got[ 2 ] >= 0 && got[ 2 ] <= 1 );
  test.is( got[ 3 ] !== 2 && got[ 3 ] >= 0 && got[ 3 ] <= 1 );

  /* */

  test.case = 'an empty object is provided';
  var got = _.longRandom( {} );
  test.identical( got.length, 1 );
  test.is( got[ 0 ] >= 0 && got[ 0 ]<= 1 );

  test.case = 'only length - number';
  var got = _.longRandom( { length : 3 } );
  test.identical( got.length, 3 );
  test.is( got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] >= 0 && got[ 1 ] <= 1 );
  test.is( got[ 2 ] >= 0 && got[ 2 ] <= 1 );

  test.case = 'only length - range';
  var got = _.longRandom( { length : [ 2, 5 ] } );
  test.is( got.length >= 2 && got.length <= 5 );
  test.is( got[ 0 ] >= 0 && got[ 0 ] <= 1 );
  test.is( got[ 1 ] >= 0 && got[ 1 ] <= 1 );

  test.case = 'without dst, length, range, onEach';
  var got = _.longRandom
  ({
    length : 3,
    value : [ 1, 9 ],
    onEach : ( value ) => _.intRandom( value ),
  });
  test.identical( got.length, 3 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 9 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 9 );
  test.is( _.intIs( got[ 2 ] ) && got[ 2 ] >= 1 && got[ 2 ] <= 9 );

  test.case = 'without dst, length, range - number, onEach';
  var got = _.longRandom
  ({
    length : 3,
    value : 5,
    onEach : ( value ) => _.intRandom( value ),
  });
  test.identical( got.length, 3 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 5 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 5 );
  test.is( _.intIs( got[ 2 ] ) && got[ 2 ] >= 1 && got[ 2 ] <= 5 );

  test.case = 'dst, range, onEach, length > dst.length';
  var dst = [ 0, 0 ];
  var got = _.longRandom
  ({
    dst : dst,
    length : 4,
    value : [ 1, 9 ],
    onEach : ( value ) => _.intRandom( value ),
  });
  test.is( got !== dst );
  test.identical( got.length, 4 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 9 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 9 );
  test.is( _.intIs( got[ 2 ] ) && got[ 2 ] >= 1 && got[ 2 ] <= 9 );
  test.is( _.intIs( got[ 3 ] ) && got[ 3 ] >= 1 && got[ 3 ] <= 9 );

  test.case = 'dst - unroll, range, onEach, length < dst.length';
  var dst = _.unrollMake( [ 0, 0 ] );
  var got = _.longRandom
  ({
    dst : dst,
    length : 4,
    value : [ 1, 9 ],
    onEach : ( value ) => _.intRandom( value ),
  });
  test.is( got !== dst );
  test.is( _.unrollIs( got ) );
  test.identical( got.length, 4 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 9 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 9 );
  test.is( _.intIs( got[ 2 ] ) && got[ 2 ] >= 1 && got[ 2 ] <= 9 );
  test.is( _.intIs( got[ 3 ] ) && got[ 3 ] >= 1 && got[ 3 ] <= 9 );

  test.case = 'dst, range, onEach, length < dst.length';
  var dst = [ 0, 0, 0, 0 ];
  var got = _.longRandom
  ({
    dst : dst,
    length : 2,
    value : [ 1, 9 ],
    onEach : ( value ) => _.intRandom( value ),
  });
  test.is( got === dst );
  test.identical( got.length, 4 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 9 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 9 );
  test.identical( got[ 2 ], 0 );
  test.identical( got[ 3 ], 0 );

  test.case = 'dst - unroll, range, onEach, length < dst.length';
  var dst = _.unrollMake( [ 0, 0, 0, 0 ] );
  var got = _.longRandom
  ({
    dst : dst,
    length : 2,
    value : [ 1, 9 ],
    onEach : ( value ) => _.intRandom( value ),
  });
  test.is( got === dst );
  test.is( _.unrollIs( got ) );
  test.identical( got.length, 4 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 9 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 9 );
  test.identical( got[ 2 ], 0 );
  test.identical( got[ 3 ], 0 );

  test.case = 'dst, range, onEach, without length';
  var dst = [ 0, 0, 0 ];
  var got = _.longRandom
  ({
    dst : dst,
    value : [ 1, 9 ],
    onEach : ( value ) => _.intRandom( value ),
  });
  test.is( got === dst );
  test.identical( got.length, 3 );
  test.is( _.intIs( got[ 0 ] ) && got[ 0 ] >= 1 && got[ 0 ] <= 9 );
  test.is( _.intIs( got[ 1 ] ) && got[ 1 ] >= 1 && got[ 1 ] <= 9 );
  test.is( _.intIs( got[ 2 ] ) && got[ 2 ] >= 1 && got[ 2 ] <= 9 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longRandom() );

  test.case = 'two arguments';
  test.shouldThrowErrorSync( () => _.longRandom( 3, 3 ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.longRandom( 'wrong' ) );

  test.case = 'negative length';
  test.shouldThrowErrorSync( () => _.longRandom( -1 ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.longRandom( 'wrong', [ 1, 2 ], 2 ) );
  test.shouldThrowErrorSync( () => _.longRandom( { dst : 2 } ) );

  test.case = 'wrong type of range';
  test.shouldThrowErrorSync( () => _.longRandom( [], 'wrong', 2 ) );
  test.shouldThrowErrorSync( () => _.longRandom( { length : 2, value : 'wrong' } ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.longRandom( [], 2, 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longRandom( { length : 'wrong' } ) );

  test.case = 'wrong type of onEach';
  test.shouldThrowErrorSync( () => _.longRandom( { onEach : 'wrong' } ) );
}

//

function longFromRange( test )
{
  test.case = 'single zero';
  var got = _.longFromRange( [ 0, 1 ] );
  var expected = [ 0 ];
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.longFromRange( [ 1, 1 ] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'single not zero';
  var got = _.longFromRange( [ 1, 2 ] );
  var expected = [ 1 ];
  test.identical( got, expected );

  test.case = 'couple of elements';
  var got = _.longFromRange( [ 1, 3 ] );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  test.case = 'single number as argument';
  var got = _.longFromRange( 3 );
  var expected = [ 0, 1, 2 ];
  test.identical( got, expected );

  test.case = 'complex case';
  var got = _.longFromRange( [ 3, 9 ] );
  var expected = [ 3, 4, 5, 6, 7, 8 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.longFromRange( [ 1, 3 ], 'wrong arguments' );
  });

  test.case = 'argument not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.longFromRange( 1, 3 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.longFromRange( 'wrong arguments' );
  });

  test.case = 'no arguments'
  test.shouldThrowErrorSync( function()
  {
    _.longFromRange();
  });
};

//

function longFromRangeWithStepDefaultLongDescriptor( test )
{
  test.case = 'range[ 0 ] === range[ 1 ], step - -1';
  var range = [ 0, 0 ];
  var got = _.longFromRangeWithStep( range, -1 );
  var exp = [];
  test.identical( got, exp );
  test.is( got !== range );

  /* - */

  test.open( 'range[ 0 ] < range[ 1 ]' );

  test.case = 'range[ 0 ] - 0, difference of range numbers is much lower than 1, step - 2'
  var got =  _.longFromRangeWithStep( [ 0, 0.000001 ], 2 );
  var expected = [ 0 ];
  test.identical( got, expected );
  test.is( got !== range );

  test.case = 'range[ 0 ] - 0, step - undefined';
  var range = [ 0, 5 ];
  var got = _.longFromRangeWithStep( range, undefined );
  var exp = [ 0, 1, 2, 3, 4 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - 0, step - 1';
  var range = [ 0, 5 ];
  var got = _.longFromRangeWithStep( range, 1 );
  var exp = [ 0, 1, 2, 3, 4 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - 0, step - 3.5';
  var range = [ 0, 14 ];
  var got = _.longFromRangeWithStep( range, 3.5 );
  var exp = [ 0, 3.5, 7, 10.5 ];
  test.identical( got, exp );
  test.is( got !== range );

  /* */

  test.case = 'range[ 0 ] - positive number, difference of range numbers is much lower than 1, step - 2'
  var got =  _.longFromRangeWithStep( [ 5, 5.000001 ], 2 );
  var expected = [ 5 ];
  test.identical( got, expected );
  test.is( got !== range );

  test.case = 'range[ 0 ] - positive number, step - undefined';
  var range = [ 3, 8 ];
  var got = _.longFromRangeWithStep( range, undefined );
  var exp = [ 3, 4, 5, 6, 7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - positive number, step - 1';
  var range = [ 3, 8 ];
  var got = _.longFromRangeWithStep( range, 1 );
  var exp = [ 3, 4, 5, 6, 7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - positive number, step - 3.5';
  var range = [ 2, 16 ];
  var got = _.longFromRangeWithStep( range, 3.5 );
  var exp = [ 2, 5.5, 9, 12.5 ];
  test.identical( got, exp );
  test.is( got !== range );

  /* */

  test.case = 'range[ 0 ] - negative number, difference of range numbers is much lower than 1, step is positive'
  var got =  _.longFromRangeWithStep( [ -5.000001, -5 ], 2 );
  var expected = [ -5.000001 ];
  test.identical( got, expected );
  test.is( got !== range );

  test.case = 'range[ 0 ] - negative number, step - undefined';
  var range = [ -3, 8 ];
  var got = _.longFromRangeWithStep( range, undefined );
  var exp = [ -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - negative number, step - 1';
  var range = [ -3, 8 ];
  var got = _.longFromRangeWithStep( range, 1 );
  var exp = [ -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - negative number, step - 3.5';
  var range = [ -2, 8 ];
  var got = _.longFromRangeWithStep( range, 3.5 );
  var exp = [ -2, 1.5, 5 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.close( 'range[ 0 ] < range[ 1 ]' );

  /* - */

  test.open( 'range[ 0 ] > range[ 1 ]' );

  test.case = 'range[ 0 ] - 0, difference of range numbers is much lower than 1, step - -2'
  var got =  _.longFromRangeWithStep( [ 0, -0.000001 ], -2 );
  var expected = [ 0 ];
  test.identical( got, expected );
  test.is( got !== range );

  test.case = 'range[ 0 ] - 0, step - undefined';
  var range = [ 0, -5 ];
  var got = _.longFromRangeWithStep( range, undefined );
  var exp = [ 0, -1, -2, -3, -4 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - 0, step - 1';
  var range = [ 0, -5 ];
  var got = _.longFromRangeWithStep( range, -1 );
  var exp = [ 0, -1, -2, -3, -4 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - 0, step - -3.5';
  var range = [ 0, -14 ];
  var got = _.longFromRangeWithStep( range, -3.5 );
  var exp = [ 0, -3.5, -7, -10.5 ];
  test.identical( got, exp );
  test.is( got !== range );

  /* */

  test.case = 'range[ 0 ] - positive number, difference of range numbers is much lower than 1, step - -2'
  var got =  _.longFromRangeWithStep( [ 5.000001, 5 ], -2 );
  var expected = [ 5.000001 ];
  test.identical( got, expected );
  test.is( got !== range );

  test.case = 'range[ 0 ] - positive number, step - undefined';
  var range = [ 3, -8 ];
  var got = _.longFromRangeWithStep( range, undefined );
  var exp = [ 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - positive number, step - -1';
  var range = [ 3, -8 ];
  var got = _.longFromRangeWithStep( range, -1 );
  var exp = [ 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - positive number, step - -3.5';
  var range = [ 2, -8 ];
  var got = _.longFromRangeWithStep( range, -3.5 );
  var exp = [ 2, -1.5, -5 ];
  test.identical( got, exp );
  test.is( got !== range );

  /* */

  test.case = 'range[ 0 ] - negative number, difference of range numbers is much lower than 1, step - -2'
  var got =  _.longFromRangeWithStep( [ -5, -5.000001 ], -2 );
  var expected = [ -5 ];
  test.identical( got, expected );
  test.is( got !== range );

  test.case = 'range[ 0 ] - negative number, step - undefined';
  var range = [ -3, -8 ];
  var got = _.longFromRangeWithStep( range, undefined );
  var exp = [ -3, -4, -5, -6, -7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - negative number, step - -1';
  var range = [ -3, -8 ];
  var got = _.longFromRangeWithStep( range, -1 );
  var exp = [ -3, -4, -5, -6, -7 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.case = 'range[ 0 ] - negative number, step - -3.5';
  var range = [ -2, -16 ];
  var got = _.longFromRangeWithStep( range, -3.5 );
  var exp = [ -2, -5.5, -9, -12.5 ];
  test.identical( got, exp );
  test.is( got !== range );

  test.close( 'range[ 0 ] > range[ 1 ]' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 1, 3 ] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 1, 3 ], 1, 'extra' ) );

  test.case = 'range[ 0 ] is infinite number';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ Infinity, 2 ], -1 ) );
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ -Infinity, 2 ], 1 ) );

  test.case = 'range[ 1 ] is infinite number';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 2, Infinity ], 1 ) );
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 2, -Infinity ], -1 ) );

  test.case = 'step === 0';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 2, 10 ], 0 ) );

  test.case = 'wrong type of step';
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 2, 10 ], null ) );
  test.shouldThrowErrorSync( () => _.longFromRangeWithStep( [ 2, 10 ], [] ) );
}

//

function longFromRangeWithStepNotDefaultLongDescriptor( test )
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

  /* test subroutine */

  function testRun( descriptor, makeLong )
  {
    test.case = 'range[ 0 ] === range[ 1 ], step - -1';
    var range = [ 0, 0 ];
    var got = descriptor.longFromRangeWithStep( range, -1 );
    var exp = descriptor.longDescriptor.from( [] );
    test.identical( got, exp );
    test.is( got !== range );

    /* - */

    test.open( 'range[ 0 ] < range[ 1 ]' );

    test.case = 'range[ 0 ] - 0, difference of range numbers is much lower than 1, step - 2'
    var got =  _.longFromRangeWithStep( [ 0, 0.000001 ], 2 );
    var expected = [ 0 ];
    test.identical( got, expected );
    test.is( got !== range );

    test.case = 'range[ 0 ] - 0, step - undefined';
    var range = [ 0, 5 ];
    var got = descriptor.longFromRangeWithStep( range, undefined );
    var exp = descriptor.longDescriptor.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - 0, step - 1';
    var range = [ 0, 5 ];
    var got = descriptor.longFromRangeWithStep( range, 1 );
    var exp = descriptor.longDescriptor.from( [ 0, 1, 2, 3, 4 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - 0, step - 3.5';
    var range = [ 0, 14 ];
    var got = descriptor.longFromRangeWithStep( range, 3.5 );
    var exp = descriptor.longDescriptor.from( [ 0, 3.5, 7, 10.5 ] );
    test.identical( got, exp );
    test.is( got !== range );

    /* */

    test.case = 'range[ 0 ] - positive number, difference of range numbers is much lower than 1, step - 2'
    var got =  _.longFromRangeWithStep( [ 5, 5.000001 ], 2 );
    var expected = [ 5 ];
    test.identical( got, expected );
    test.is( got !== range );

    test.case = 'range[ 0 ] - positive number, step - undefined';
    var range = [ 3, 8 ];
    var got = descriptor.longFromRangeWithStep( range, undefined );
    var exp = descriptor.longDescriptor.from( [ 3, 4, 5, 6, 7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - positive number, step - 1';
    var range = [ 3, 8 ];
    var got = descriptor.longFromRangeWithStep( range, 1 );
    var exp = descriptor.longDescriptor.from( [ 3, 4, 5, 6, 7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - positive number, step - 3.5';
    var range = [ 2, 16 ];
    var got = descriptor.longFromRangeWithStep( range, 3.5 );
    var exp = descriptor.longDescriptor.from( [ 2, 5.5, 9, 12.5 ] );
    test.identical( got, exp );
    test.is( got !== range );

    /* */

    test.case = 'range[ 0 ] - negative number, difference of range numbers is much lower than 1, step is positive'
    var got =  _.longFromRangeWithStep( [ -5.000001, -5 ], 2 );
    var expected = [ -5.000001 ];
    test.identical( got, expected );
    test.is( got !== range );

    test.case = 'range[ 0 ] - negative number, step - undefined';
    var range = [ -3, 8 ];
    var got = descriptor.longFromRangeWithStep( range, undefined );
    var exp = descriptor.longDescriptor.from( [ -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - negative number, step - 1';
    var range = [ -3, 8 ];
    var got = descriptor.longFromRangeWithStep( range, 1 );
    var exp = descriptor.longDescriptor.from( [ -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - negative number, step - 3.5';
    var range = [ -2, 8 ];
    var got = descriptor.longFromRangeWithStep( range, 3.5 );
    var exp = descriptor.longDescriptor.from( [ -2, 1.5, 5 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.close( 'range[ 0 ] < range[ 1 ]' );

    /* - */

    test.open( 'range[ 0 ] > range[ 1 ]' );

    test.case = 'range[ 0 ] - 0, difference of range numbers is much lower than 1, step - -2'
    var got =  _.longFromRangeWithStep( [ 0, -0.000001 ], -2 );
    var expected = [ 0 ];
    test.identical( got, expected );
    test.is( got !== range );

    test.case = 'range[ 0 ] - 0, step - undefined';
    var range = [ 0, -5 ];
    var got = descriptor.longFromRangeWithStep( range, undefined );
    var exp = descriptor.longDescriptor.from( [ 0, -1, -2, -3, -4 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - 0, step - 1';
    var range = [ 0, -5 ];
    var got = descriptor.longFromRangeWithStep( range, -1 );
    var exp = descriptor.longDescriptor.from( [ 0, -1, -2, -3, -4 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - 0, step - -3.5';
    var range = [ 0, -14 ];
    var got = descriptor.longFromRangeWithStep( range, -3.5 );
    var exp = descriptor.longDescriptor.from( [ 0, -3.5, -7, -10.5 ] );
    test.identical( got, exp );
    test.is( got !== range );

    /* */

    test.case = 'range[ 0 ] - positive number, difference of range numbers is much lower than 1, step - -2'
    var got =  _.longFromRangeWithStep( [ 5.000001, 5 ], -2 );
    var expected = [ 5.000001 ];
    test.identical( got, expected );
    test.is( got !== range );

    test.case = 'range[ 0 ] - positive number, step - undefined';
    var range = [ 3, -8 ];
    var got = descriptor.longFromRangeWithStep( range, undefined );
    var exp = descriptor.longDescriptor.from( [ 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - positive number, step - -1';
    var range = [ 3, -8 ];
    var got = descriptor.longFromRangeWithStep( range, -1 );
    var exp = descriptor.longDescriptor.from( [ 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - positive number, step - -3.5';
    var range = [ 2, -8 ];
    var got = descriptor.longFromRangeWithStep( range, -3.5 );
    var exp = descriptor.longDescriptor.from( [ 2, -1.5, -5 ] );
    test.identical( got, exp );
    test.is( got !== range );

    /* */

    test.case = 'range[ 0 ] - negative number, difference of range numbers is much lower than 1, step - -2'
    var got =  _.longFromRangeWithStep( [ -5, -5.000001 ], -2 );
    var expected = [ -5 ];
    test.identical( got, expected );
    test.is( got !== range );

    test.case = 'range[ 0 ] - negative number, step - undefined';
    var range = [ -3, -8 ];
    var got = descriptor.longFromRangeWithStep( range, undefined );
    var exp = descriptor.longDescriptor.from( [ -3, -4, -5, -6, -7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - negative number, step - -1';
    var range = [ -3, -8 ];
    var got = descriptor.longFromRangeWithStep( range, -1 );
    var exp = descriptor.longDescriptor.from( [ -3, -4, -5, -6, -7 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.case = 'range[ 0 ] - negative number, step - -3.5';
    var range = [ -2, -16 ];
    var got = descriptor.longFromRangeWithStep( range, -3.5 );
    var exp = descriptor.longDescriptor.from( [ -2, -5.5, -9, -12.5 ] );
    test.identical( got, exp );
    test.is( got !== range );

    test.close( 'range[ 0 ] > range[ 1 ]' );
  }
}

//

function longToMap( test )
{

  test.case = 'an empty object';
  var got = _.longToMap( [] );
  var expected = {  };
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.longToMap( [ 3, [ 1, 2, 3 ], 'abc', false, undefined, null, {} ] );
  var expected = { '0' : 3, '1' : [ 1, 2, 3 ], '2' : 'abc', '3' : false, '4' : undefined, '5' : null, '6' : {} };
  test.identical( got, expected );

  test.case = 'arguments[...]';
  var args = ( function() {
    return arguments;
  } )( 3, 'abc', false, undefined, null, { greeting: 'Hello there!' } );
  var got = _.longToMap( args );
  var expected = { '0' : 3, '1' : 'abc', '2' : false, '3' : undefined, '4' : null, '5' : { greeting: 'Hello there!' } };
  test.identical( got, expected );

  test.case = 'longIs';
  var arr = [];
  arr[ 'a' ] = 1;
  var got = _.longToMap( arr );
  var expected = {};
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.longToMap();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.longToMap( 'wrong argument' );
  });
};

//

function longToStr( test )
{

  test.case = 'nothing';
  var got = _.longToStr( [] );
  var expected = "";
  test.identical( got, expected );

  test.case = 'returns the string';
  var got = _.longToStr( 'abcdefghijklmnopqrstuvwxyz', { type : 'int' } );
  var expected = "a b c d e f g h i j k l m n o p q r s t u v w x y z ";
  test.identical( got, expected );

  test.case = 'returns a single string representing the integer values';
  var got = _.longToStr( [ 1, 2, 3 ], { type : 'int' } );
  var expected = "1 2 3 ";
  test.identical( got, expected );

  test.case = 'returns a single string representing the float values';
  var got = _.longToStr( [ 3.5, 13.77, 7.33 ], { type : 'float', precission : 4 } );
  var expected = "3.500 13.77 7.330";
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longToStr();
  });

  test.case = 'in second argument property (type) is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longToStr( [ 1, 2, 3 ], { type : 'wrong type' } );
  });

  test.case = 'in second argument property (type) is not provided';
  test.shouldThrowErrorSync( function()
  {
    _.longToStr( [ 1, 2, 3 ], { precission : 4 } );
  });

  test.case = 'first argument is string';
  test.shouldThrowErrorSync( function()
  {
    _.longToStr( 'wrong argument', {  type : 'float' } );
  });
}

//

function longCompare( test )
{
  test.case = 'empty arrays';
  var got = _.longCompare( [], [] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'first array is empty';
  var got = _.longCompare( [], [ 1, 2 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'length of the first array is less than second';
  var got = _.longCompare( [ 4 ], [ 1, 2 ] );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'arrays are equal';
  var got = _.longCompare( [ 1, 5 ], [ 1, 5 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'a difference';
  var got = _.longCompare( [ 1, 5 ], [ 1, 2 ] );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'a negative difference';
  var got = _.longCompare( [ 1, 5 ], [ 1, 6 ] );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  var src1 = function src1() {
    return arguments;
  }( 1, 5 );
  var src2 = function src2() {
    return arguments;
  }( 1, 2 );
  var got = _.longCompare( src1, src2 );
  var expected = 3;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longCompare();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longCompare( [ 1, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.longCompare( [ 1, 5 ], [ 1, 2 ], 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longCompare( 'wrong argument', 'wrong argument' );
  });

  test.case = 'second array is empty';
  test.shouldThrowErrorSync( function()
  {
    _.longCompare( [ 1, 5 ], [] );
  });

  test.case = 'length of the second array is less than first';
  test.shouldThrowErrorSync( function()
  {
    _.longCompare( [ 1, 5 ], [ 1 ] );
  });
};

//

function longIdentical( test )
{
  test.case = 'empty arrays';
  var got = _.longIdentical( [], [] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'arrays are equal';
  var got = _.longIdentical( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function src1() {
    return arguments;
  };
  function src2() {
    return arguments;
  };
  var got = _.longIdentical( src1( 3, 7, 33 ), src2( 3, 7, 13 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays are not equal';
  var got = _.longIdentical( [ 1, 2, 3, 'Hi!' ], [ 1, 2, 3, 'Hello there!' ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays length are not equal';
  var got = _.longIdentical( [ 1, 2, 3 ], [ 1, 2 ] );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longIdentical();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longIdentical( [ 1, 2, 3 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.longIdentical( [ 1, 2, 3 ], [ 1, 2 ], 'redundant argument' );
  });
};

//

function longHasAnyWithoutCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src = empty long, one argument';
    var src = new makeLong( [] );
    var got = _.longHasAny( src );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = undefined';
    var src = new makeLong( [] );
    var got = _.longHasAny( src, undefined );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = string';
    var src = new makeLong( [] );
    var got = _.longHasAny( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = array';
    var src = new makeLong( [] );
    var got = _.longHasAny( src, [ false, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = number, matches';
    var src = new makeLong( [ 1, 2, 1, false, 5 ] );
    var got = _.longHasAny( src, 5 );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = string, no matches';
    var src = new makeLong( [ 1, 2, 5, false ] );
    var got = _.longHasAny( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasAny( src, [ 42, false ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, no matches';
    var src = new makeLong( [ 5, null, 32, false, 42 ] );
    var got = _.longHasAny( src, [ true, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasAny( src, new makeLong( [ 42, 12 ] ) );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, no matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasAny( src, new makeLong( [ 30, 12 ] ) );
    var expected = false;
    test.identical( got, expected );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longHasAny() );

  test.case = 'src has wrong type';
  test.shouldThrowErrorSync( () => _.longHasAny( 'wrong argument', false ) );
  test.shouldThrowErrorSync( () => _.longHasAny( 1, false ) );

  test.case = 'ins has wrong type';
  test.shouldThrowErrorSync( () => _.longHasAny( [ 1, 2, 3, false ], new BufferRaw( 2 ) ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.longHasAny( [ 1, 2, 3, false ], 2, 3 ) );
};

//

function longHasAnyWithCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'with evaluator, matches';
    var evaluator = ( e ) => e.a;
    var src = makeLong( [ { a : 2 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasAny( src, [ [ false ], 7, { a : 2 } ], evaluator );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with evaluator, no matches';
    var evaluator = ( e ) => e.a;
    var src = makeLong( [ { a : 3 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasAny( src, [ { a : 2 }, { a : 4 } ], evaluator );
    var expected = false;
    test.identical( got, expected );

    test.case = 'with equalizer, matches';
    var equalizer = ( e1, e2 ) => e1.a === e2.a;
    var src = makeLong( [ { a : 4 }, { a : 2 }, 42, false ] );
    var got = _.longHasAny( src, [ { a : 2 }, { b : 7 } ], equalizer );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with equalizer, no matches';
    var equalizer = ( e1, e2 ) => e1.a === e2.a;
    var src = makeLong( [ { a : 4 }, { a : 3 }, 42, false ] );
    var got = _.longHasAny( src, [ { a : 2 }, { a : 7 } ], equalizer );
    var expected = false;
    test.identical( got, expected );
  }
}

//

function longHasAllWithoutCallback( test )
{
  /* tests

  |                        | ins = primitive | ins = long | ins = empty long | equalizer | evaluator |
  | ---------------------- | --------------- | ---------- | ---------------- | --------- | --------- |
  | src === empty long     | +               |            |                  |           |           |
  | src === empty long     |                 | +          |                  |           |           |
  | src === empty long     | +               |            |                  | +         | +         |
  | src === empty long     |                 | +          |                  | +         | +         |
  | src === empty long     |                 |            | +                |           |           |
  | src === empty long     |                 |            | +                | +         | +         |
  | src === not empty long | +               |            |                  |           |           |
  | src === not empty long |                 | +          |                  |           |           |
  | src === not empty long | +               |            |                  | +         | +         |
  | src === not empty long |                 | +          |                  | +         | +         |
  | src === not empty long |                 |            | +                |           |           |
  | src === not empty long |                 |            | +                | +         | +         |

  */

  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'src = empty long, one argument';
    var src = new makeLong( [] );
    var got = _.longHasAll( src );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = undefined';
    var src = new makeLong( [] );
    var got = _.longHasAll( src, undefined );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = string';
    var src = new makeLong( [] );
    var got = _.longHasAll( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = empty array';
    var src = new makeLong( [] );
    var got = _.longHasAll( src, [] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = array';
    var src = new makeLong( [] );
    var got = _.longHasAll( src, [ false, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = number, matches';
    var src = new makeLong( [ 1, 2, 5, false ] );
    var got = _.longHasAll( src, 5 );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = string, no matches';
    var src = new makeLong( [ 1, 2, 5, false ] );
    var got = _.longHasAll( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = empty array';
    var src = new makeLong( [  5, null, 42, false, 2, undefined ] );
    var got = _.longHasAll( src, [] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, matches';
    var src = new makeLong( [ 5, null, 42, false, 1 ] );
    var got = _.longHasAll( src, [ 42, 1 ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, no matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasAll( src, [ 42, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, matches';
    var src = new makeLong( [ 5, null, 42, false, 12 ] );
    var got = _.longHasAll( src, new makeLong( [ 42, 12 ] ) );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, no matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasAll( src, new makeLong( [ 30, 42 ] ) );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src === ins';
    var src = new makeLong( [ 5, null, 42, false, 12 ] );
    var got = _.longHasAll( src, src );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src and ins is identical';
    var src = new makeLong( [ 5, null, 42, false, 12 ] );
    var ins = new makeLong( [ 5, null, 42, false, 12 ] );
    var got = _.longHasAll( src, ins );
    var expected = true;
    test.identical( got, expected );

    test.case = 'ins has reverse elements of src';
    var src = new makeLong( [ 5, null, 42, false, 12 ] );
    var ins = new makeLong( [ 12, false, 42, null, 5 ] );
    var got = _.longHasAll( src, ins );
    var expected = true;
    test.identical( got, expected );

    if( !_.bufferTypedIs( src ) )
    {
      test.case = 'src has udefined, ins has null';
      var src = new makeLong( [ undefined, undefined, undefined ] );
      var ins = new makeLong( [ null, null, null ] );
      var got = _.longHasAll( src, ins );
      var expected = false;
      test.identical( got, expected );
    }
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longHasAll() );

  test.case = 'src has wrong type';
  test.shouldThrowErrorSync( () => _.longHasAll( 'wrong argument', false ) );
  test.shouldThrowErrorSync( () => _.longHasAll( 1, false ) );

  test.case = 'ins has wrong type';
  test.shouldThrowErrorSync( () => _.longHasAll( [ 1, 2, 3, false ], new BufferRaw( 2 ) ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.longHasAll( [ 1, 2, 3, false ], 2, 3 ) );
}

//

function longHasAllWithCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  function testRun( makeLong )
  {
    test.case = 'src = empty array, ins = number, with evaluator';
    var evaluator = ( e ) => e;
    var src = makeLong( [] );
    var got = _.longHasAll( src, 42, evaluator );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty array, ins = number, with equalizer';
    var equalizer = ( e1, e2 ) => e1.a === e2;
    var src = makeLong( [] );
    var got = _.longHasAll( src, 4, equalizer );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty array, ins = empty array, with evaluator';
    var evaluator = ( e ) => e;
    var src = makeLong( [] );
    var got = _.longHasAll( src, [], evaluator );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty array, ins = empty array, with equalizer';
    var equalizer = ( e1, e2 ) => e1.a === e2;
    var src = makeLong( [] );
    var got = _.longHasAll( src, [], equalizer );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty array, ins = array, with evaluator';
    var evaluator = ( e ) => e;
    var src = makeLong( [] );
    var got = _.longHasAll( src, [ 1, 2 ], evaluator );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty array, ins = array, with equalizer';
    var equalizer = ( e1, e2 ) => e1.a === e2;
    var src = makeLong( [ { a : 4 }, { a : 2 }, 42, false ] );
    var got = _.longHasAll( src, [ 1, 2 ], equalizer );
    var expected = false;
    test.identical( got, expected );

    /* */

    test.case = 'with evaluator, matches';
    var evaluator = ( e ) => e;
    var src = makeLong( [ 42, 42, 42, 42, 42 ] );
    var got = _.longHasAll( src, 42, evaluator );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with evaluator, no matches';
    var evaluator = ( e ) => e;
    var src = makeLong( [ { a : 3 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasAll( src, 4, evaluator );
    var expected = false;
    test.identical( got, expected );

    test.case = 'with equalizer, matches';
    var equalizer = ( e1, e2 ) => e1.a === e2;
    var src = makeLong( [ { a : 4 }, { a : 2 }, 42, false ] );
    var got = _.longHasAll( src, 4, equalizer );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with equalizer, no matches';
    var equalizer = ( e1, e2 ) => e1.a === e2;
    var src = makeLong( [ { a : 4 }, { a : 3 }, 42, false ] );
    var got = _.longHasAll( src, 5, equalizer );
    var expected = false;
    test.identical( got, expected );

    test.case = 'with evaluator, matches';
    var evaluator = ( e ) => e.a;
    var src = makeLong( [ { a : 2 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasAll( src, [ [ false ], 7, { a : 2 } ], evaluator );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with evaluator, no matches';
    var evaluator = ( e ) => e.a;
    var src = makeLong( [ { a : 3 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasAll( src, [ { a : 2 }, { a : 4 } ], evaluator );
    var expected = false;
    test.identical( got, expected );

    test.case = 'with equalizer, matches';
    var equalizer = ( e1, e2 ) => e1.a === e2.a;
    var src = makeLong( [ { a : 4 }, { a : 2 }, 42, false ] );
    var got = _.longHasAll( src, [ { a : 2 }, { b : 7 } ], equalizer );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with equalizer, no matches';
    var equalizer = ( e1, e2 ) => e1.a === e2.a;
    var src = makeLong( [ { a : 4 }, { a : 3 }, 42, false ] );
    var got = _.longHasAll( src, [ { a : 2 }, { a : 7 } ], equalizer );
    var expected = false;
    test.identical( got, expected );
  }
}

//

function longHasNoneWithoutCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src = empty long, one argument';
    var src = new makeLong( [] );
    var got = _.longHasNone( src );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = undefined';
    var src = new makeLong( [] );
    var got = _.longHasNone( src, undefined );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = string';
    var src = new makeLong( [] );
    var got = _.longHasNone( src, 'str' );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = array';
    var src = new makeLong( [] );
    var got = _.longHasNone( src, [ false, 7 ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = number, matches';
    var src = new makeLong( [ 1, 2, 1, false, 5 ] );
    var got = _.longHasNone( src, 5 );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = string, no matches';
    var src = new makeLong( [ 1, 2, 5, false ] );
    var got = _.longHasNone( src, 'str' );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasNone( src, [ 42, false ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, no matches';
    var src = new makeLong( [ 5, null, 32, false, 42 ] );
    var got = _.longHasNone( src, [ true, 7 ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasNone( src, new makeLong( [ 42, 12 ] ) );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, no matches';
    var src = new makeLong( [ 5, null, 42, false ] );
    var got = _.longHasNone( src, new makeLong( [ 30, 12 ] ) );
    var expected = true;
    test.identical( got, expected );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longHasNone() );

  test.case = 'src has wrong type';
  test.shouldThrowErrorSync( () => _.longHasNone( 'wrong argument', false ) );
  test.shouldThrowErrorSync( () => _.longHasNone( 1, false ) );

  test.case = 'ins has wrong type';
  test.shouldThrowErrorSync( () => _.longHasNone( [ 1, 2, 3, false ], new BufferRaw( 2 ) ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.longHasNone( [ 1, 2, 3, false ], 2, 3 ) );
}

//

function longHasNoneWithCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'with evaluator, matches';
    var evaluator = ( e ) => e.a;
    var src = makeLong( [ { a : 2 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasNone( src, [ [ false ], 7, { a : 2 } ], evaluator );
    var expected = false;
    test.identical( got, expected );

    test.case = 'with evaluator, no matches';
    var evaluator = ( e ) => e.a;
    var src = makeLong( [ { a : 3 }, { a : 5 }, 'str', 42, false ] );
    var got = _.longHasNone( src, [ { a : 2 }, { a : 4 } ], evaluator );
    var expected = true;
    test.identical( got, expected );

    test.case = 'with equalizer, matches';
    var equalizer = ( e1, e2 ) => e1.a === e2.a;
    var src = makeLong( [ { a : 4 }, { a : 2 }, 42, false ] );
    var got = _.longHasNone( src, [ { a : 2 }, { b : 7 } ], equalizer );
    var expected = false;
    test.identical( got, expected );

    test.case = 'with equalizer, no matches';
    var equalizer = ( e1, e2 ) => e1.a === e2.a;
    var src = makeLong( [ { a : 4 }, { a : 3 }, 42, false ] );
    var got = _.longHasNone( src, [ { a : 2 }, { a : 7 } ], equalizer );
    var expected = true;
    test.identical( got, expected );
  }
}

//

function longHasDepth( test )
{
  test.case = 'check null';
  var got = _.longHasDepth( null );
  test.identical( got, false );

  test.case = 'check undefined';
  var got = _.longHasDepth( undefined );
  test.identical( got, false );

  test.case = 'check _.nothing';
  var got = _.longHasDepth( _.nothing );
  test.identical( got, false );

  test.case = 'check false';
  var got = _.longHasDepth( false );
  test.identical( got, false );

  test.case = 'check NaN';
  var got = _.longHasDepth( NaN );
  test.identical( got, false );

  test.case = 'check Symbol';
  var got = _.longHasDepth( Symbol() );
  test.identical( got, false );

  test.case = 'check map';
  var got = _.longHasDepth( {} );
  test.identical( got, false );

  test.case = 'check pure map';
  var got = _.longHasDepth( Object.create( null ) );
  test.identical( got, false );

  test.case = 'check Set';
  var got = _.longHasDepth( new Set( [] ) );
  test.identical( got, false );

  test.case = 'check Map';
  var got = _.longHasDepth( new Map( [] ) );
  test.identical( got, false );

  test.case = 'check BufferRaw';
  var got = _.longHasDepth( new BufferRaw() );
  test.identical( got, false );

  test.case = 'check number';
  var got = _.longHasDepth( 3 );
  test.identical( got, false );

  test.case = 'check bigInt';
  var got = _.longHasDepth( 1n );
  test.identical( got, false );

  test.case = 'check string';
  var got = _.longHasDepth( 'str' );
  test.identical( got, false );

  test.case = 'check array';
  var got = _.longHasDepth( [ null ] );
  test.identical( got, false );

  test.case = 'check map';
  var got = _.longHasDepth( { '' : null } );
  test.identical( got, false );

  test.case = 'check instance of constructor';
  var Constr = function()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.longHasDepth( src );
  test.identical( got, false );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'BufferNode';
    var got = _.longHasDepth( BufferNode.alloc( 0 ) );
    test.identical( got, false );
  }

  /* - */

  test.open( 'empty long, level - default' );

  test.case = 'array';
  var got = _.longHasDepth( [] );
  test.identical( got, false );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [] ) );
  test.identical( got, false );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [] ) );
  test.identical( got, false );

  test.case = 'BufferTyped';
  var got = _.longHasDepth( new U8x() );
  test.identical( got, false );

  test.close( 'empty long, level - default' );

  /* - */

  test.open( 'empty long, level - 0' );

  test.case = 'array';
  var got = _.longHasDepth( [], 0 );
  test.identical( got, true );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [] ), 0 );
  test.identical( got, true );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [] ), 0 );
  test.identical( got, true );

  test.case = 'BufferTyped';
  var got = _.longHasDepth( new U16x(), 0 );
  test.identical( got, true );

  test.close( 'empty long, level - 0' );

  /* - */

  test.open( 'flat long, level - default' );

  test.case = 'array';
  var got = _.longHasDepth( [ 1, 2, 3 ] );
  test.identical( got, false );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [ 1, 2, 3 ] ) );
  test.identical( got, false );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [ 1, 2, 3 ] ) );
  test.identical( got, false );

  test.case = 'BufferTyped';
  var got = _.longHasDepth( new U32x( [ 1, 2, 3 ] ) );
  test.identical( got, false );

  test.close( 'flat long, level - default' );

  /* - */

  test.open( 'flat long, level - -1' );

  test.case = 'array';
  var got = _.longHasDepth( [ 1, 2, 3 ], -1 );
  test.identical( got, true );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [ 1, 2, 3 ] ), -1 );
  test.identical( got, true );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [ 1, 2, 3 ] ), -1 );
  test.identical( got, true );

  test.case = 'BufferTyped';
  var got = _.longHasDepth( new I8x( [ 1, 2, 3 ] ), -1 );
  test.identical( got, true );

  test.close( 'flat long, level - -1' );

  /* - */

  test.open( 'long with nested levels, level - default' );

  test.case = 'array';
  var got = _.longHasDepth( [ [ 1, [ 2 ] ], [ 3 ] ] );
  test.identical( got, true );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [ [ 1, [ 2 ] ], [ 3 ] ] ) );
  test.identical( got, true );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [ [ 1, [ 2 ] ], [ 3 ] ] ) );
  test.identical( got, true );

  test.close( 'long with nested levels, level - default' );

  /* - */

  test.open( 'long with nested levels, level - 2' );

  test.case = 'array';
  var got = _.longHasDepth( [ [ 1, [ 2 ] ], [ 3 ] ], 2 );
  test.identical( got, true );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [ [ 1, [ 2 ] ], [ 3 ] ] ), 2 );
  test.identical( got, true );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [ [ 1, [ 2 ] ], [ 3 ] ] ), 2 );
  test.identical( got, true );

  test.close( 'long with nested levels, level - 2' );

  /* - */

  test.open( 'long with nested levels, level - 3' );

  test.case = 'array';
  var got = _.longHasDepth( [ [ 1, [ 2 ] ], [ 3 ] ], 3 );
  test.identical( got, false );

  test.case = 'arguments array';
  var got = _.longHasDepth( _.argumentsArrayMake( [ [ 1, [ 2 ] ], [ 3 ] ] ), 3 );
  test.identical( got, false );

  test.case = 'unroll';
  var got = _.longHasDepth( _.unrollMake( [ [ 1, [ 2 ] ], [ 3 ] ] ), 3 );
  test.identical( got, false );

  test.close( 'long with nested levels, level - 3' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without argument';
  test.shouldThrowErrorSync( () => _.longHasDepth() );

  test.case = 'level is not an integer';
  test.shouldThrowErrorSync( () => _.longHasDepth( [ 1, [ 2 ] ], 1.001 ) );
}

//

function longLeftIndex( test )
{
  test.case = 'nothing';
  var got = _.longLeftIndex( [], 3 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'second index';
  var got = _.longLeftIndex( [ 1, 2, 3 ], 3 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'zero index';
  var got = _.longLeftIndex( [ 1, 2, 3 ], 3, ( el, ins ) => el < ins );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.longLeftIndex( [ 1, 2, 3 ], 4 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.longLeftIndex( [ 1, 2, 3 ], 3, ( el, ins ) => el > ins );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function arr()
  {
    return arguments;
  }
  var _arr = arr( 3, 7, 13 );
  var got = _.longLeftIndex( _arr, 13 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longLeftIndex( [ 0, 0, 0, 0 ], 0, 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longLeftIndex( [ 0, 0, 0, 0 ], 0, 3 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longLeftIndex( [ 0, 0, 0, 0 ], 0, -1 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator';
  var got = _.longLeftIndex( [ 1, 1, 2, 2, 3, 3 ], 3, 2, ( el, ins ) => el < ins );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator x2';
  var evaluator1 = ( el ) => el + 1;
  var evaluator2 = ( ins ) => ins * 2;
  var got = _.longLeftIndex( [ 6, 6, 5, 5 ], 3, 2, evaluator1, evaluator2 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'evaluator search first element of array';
  var evaluator = ( e ) => e[ 0 ];
  var got = _.longLeftIndex( [ 1, 2, 3, [ 2 ], 3, [ 4 ] ], [ 2 ], evaluator );
  var expected = 3;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'one argument';
  test.shouldThrowErrorSync( function()
  {
    var got = _.longLeftIndex( [ 1, 2, 3 ] );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longLeftIndex();
  });

  test.case = 'third argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longLeftIndex( [ 1, 2, 3 ], 2, 'wrong argument' );
  });

};

//

function longRightIndex( test )
{

  test.case = 'nothing';
  var got = _.longRightIndex( [], 3 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'second index';
  var got = _.longRightIndex( [ 1, 2, 3 ], 3 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'zero index';
  var got = _.longRightIndex( [ 1, 2, 3 ], 3, function( el, ins ) { return el < ins } );
  var expected = 1;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.longRightIndex( [ 1, 2, 3 ], 4 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.longRightIndex( [ 1, 2, 3 ], 3, function( el, ins ) { return el > ins } );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function arr()
  {
    return arguments;
  }
  var _arr = arr( 3, 7, 13 );
  var got = _.longRightIndex( _arr, 13 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fifth index';
  var got = _.longRightIndex( 'abcdef', 'e', function( el, ins ) { return el > ins } );
  var expected = 5;
  test.identical( got, expected );

  test.case = 'third index';
  var got = _.longRightIndex( 'abcdef', 'd' );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'second index';
  var got = _.longRightIndex( 'abcdef', 'c', function( el ) { return el; } );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longRightIndex( [ 0, 0, 0, 0 ], 0, 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longRightIndex( [ 0, 0, 0, 0 ], 0, 3 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longRightIndex( [ 0, 1, 1, 0 ], 0, 1 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.longRightIndex( [ 0, 1, 1, 0 ], 1, 2 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator';
  var got = _.longRightIndex( [ 1, 1, 2, 2, 3, 3 ], 3, 4, function( el, ins ) { return el < ins } );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator x2';
  var evaluator1 = function( el ) { return el + 1 }
  var evaluator2 = function( ins ) { return ins * 2 }
  var got = _.longRightIndex( [ 6, 6, 5, 5 ], 3, 2, evaluator1, evaluator2 );
  var expected = 2;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'one argument';
  test.shouldThrowErrorSync( function()
  {
    var got = _.longRightIndex( [ 1, 2, 3 ] );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longRightIndex();
  });

  test.case = 'third argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longRightIndex( [ 1, 2, 3 ], 2, 'wrong argument' );
  });

};

//

function longLeft( test )
{
  test.case = 'empty array';
  var src = [];
  var got = _.longLeft( src, 1 );
  test.identical( got, { index : -1 } );

  test.case = 'array has not searched element';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3 );
  test.identical( got, { index : -1 } );

  test.case = 'array has duplicated searched element';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, { a : 2 } ];
  var got = _.longLeft( src, 3 );
  test.identical( got, { index : 2, element : 3 } );

  test.case = 'searches complex data without evaluators';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, [ 3 ] );
  test.identical( got, { index : -1 } );

  /* */

  test.case = 'array has not searched element, fromIndex';
  var src = [ 1, 2, 3, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, 4 );
  test.identical( got, { index : -1 } );

  test.case = 'array has duplicated searched element, fromIndex';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longLeft( src, 'str', 4 );
  test.identical( got, { index : 6, element : 'str' } );

  test.case = 'searches complex data, fromIndex';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, [ 3 ], 2 );
  test.identical( got, { index : -1 } );

  /* */

  test.case = 'array has not searched element, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, ( e ) => typeof e );
  test.identical( got, { index : 0, element : 1 } );

  test.case = 'array has duplicated searched element, onEvaluate1';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longLeft( src, 'str', ( e ) => e );
  test.identical( got, { index : 3, element : 'str' } );

  test.case = 'searches complex data, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, [ 3 ], ( e ) => e[ 0 ] );
  test.identical( got, { index : 3, element : [ 3 ] } );

  /* */

  test.case = 'array has not searched element, fromIndex, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, 2, ( e ) => typeof e );
  test.identical( got, { index : -1 } );

  test.case = 'array has duplicated searched element, fromIndex, onEvaluate1';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longLeft( src, 'str', 4, ( e ) => typeof e );
  test.identical( got, { index : 6, element : 'str' } );

  test.case = 'searches complex data, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, [ 3 ], 4, ( e ) => e[ 0 ] );
  test.identical( got, { index : -1 } );

  /* */

  test.case = 'array has not searched element, onEvaluate1, onEvaluate2';
  var src =[ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 3, element : [ 3 ] } );

  test.case = 'array has duplicated searched element, onEvaluate1, onEvaluate2';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longLeft( src, 2, ( e ) => e.a, ( ins ) => ins );
  test.identical( got, { index : 7, element : { a : 2 } } );

  test.case = 'searches complex data, onEvaluate, onEvaluate2';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 3, element : [ 3 ] } );

  /* */

  test.case = 'array has not searched element, fromIndex, onEvaluate1, onEvaluate2';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, 2, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 3, element : [ 3 ] } );

  test.case = 'array has duplicated searched element, fromIndex, onEvaluate1, onEvaluate2';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longLeft( src, 2, 7, ( e ) => e.a, ( ins ) => ins );
  test.identical( got, { index : 7, element : { a : 2 } } );

  test.case = 'searches complex data, fromIndex, onEvaluate, onEvaluate2';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, 4, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : -1 } );

  /* */

  test.case = 'array has not searched element, equalizer';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, ( e, ins ) => e[ 0 ] === ins );
  test.identical( got, { index : 3, element : [ 3 ] } );

  test.case = 'array has duplicated searched element, equalizer';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longLeft( src, 2, ( e, ins ) => e.a === ins );
  test.identical( got, { index : 7, element : { a : 2 } } );

  test.case = 'searches complex data, equalizer';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longLeft( src, 3, ( e, ins ) => e[ 0 ] ===  ins );
  test.identical( got, { index : 3, element : [ 3 ] } );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longLeft() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longLeft( [ 1, 2 ], 1, 0, ( e ) => e, ( ins ) => ins, 'extra' ) );

  test.case = 'fromIndex is not a number';
  test.shouldThrowErrorSync( () => _.longLeft( [ 1, 2 ], 1, 'wrong' ) );

  test.case = 'onEvaluate1 is not a routine, not a number';
  test.shouldThrowErrorSync( () => _.longLeft( [ 1, 2 ], 1, 0, 'wrong' ) );

  test.case = 'onEvaluate1 has wrong length';
  test.shouldThrowErrorSync( () => _.longLeft( [ 1, 2 ], 1, 0, () => 1 ) );

  test.case = 'onEvaluate2 has wrong length';
  test.shouldThrowErrorSync( () => _.longLeft( [ 1, 2 ], 1, 0, ( e ) => e, () => 1 ) );
}

//

function longRight( test )
{
  test.case = 'empty array';
  var src = [];
  var got = _.longRight( src, 1 );
  test.identical( got, { index : -1 } );

  test.case = 'array has not searched element';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3 );
  test.identical( got, { index : -1 } );

  test.case = 'array has duplicated searched element';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, { a : 2 } ];
  var got = _.longRight( src, 3 );
  test.identical( got, { index : 5, element : 3 } );

  test.case = 'searches complex data without evaluators';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, [ 3 ] );
  test.identical( got, { index : -1 } );

  /* */

  test.case = 'array has not searched element, fromIndex';
  var src = [ 1, 2, 3, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, 4 );
  test.identical( got, { index : 2, element : 3 } );

  test.case = 'array has duplicated searched element, fromIndex';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longRight( src, 'str', 4 );
  test.identical( got, { index : 3, element : 'str' } );

  test.case = 'searches complex data, fromIndex';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, [ 3 ], 2 );
  test.identical( got, { index : -1 } );

  /* */

  test.case = 'array has not searched element, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, ( e ) => typeof e );
  test.identical( got, { index : 1, element : 2 } );

  test.case = 'array has duplicated searched element, onEvaluate1';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longRight( src, 'str', ( e ) => e );
  test.identical( got, { index : 6, element : 'str' } );

  test.case = 'searches complex data, onEvaluate1';
  var src = [ 1, 2, [ 3 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, [ 3 ], ( e ) => e[ 0 ] );
  test.identical( got, { index : 4, element : [ 3 ] } );

  /* */

  test.case = 'array has not searched element, fromIndex, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, 2, ( e ) => typeof e );
  test.identical( got, { index : 1, element : 2 } );

  test.case = 'array has duplicated searched element, fromIndex, onEvaluate1';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longRight( src, 'str', 4, ( e ) => typeof e );
  test.identical( got, { index : 3, element : 'str' } );

  test.case = 'searches complex data, onEvaluate1';
  var src = [ 1, 2, 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, [ 3 ], 4, ( e ) => e[ 0 ] );
  test.identical( got, { index : 3, element : [ 3 ] } );

  /* */

  test.case = 'array has not searched element, onEvaluate1, onEvaluate2';
  var src =[ 1, 2, [ 3 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 4, element : [ 3 ] } );

  test.case = 'array has duplicated searched element, onEvaluate1, onEvaluate2';
  var src = [ 1, 2, 3, { a : 2 }, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longRight( src, 2, ( e ) => e.a, ( ins ) => ins );
  test.identical( got, { index : 8, element : { a : 2 } } );

  test.case = 'searches complex data, onEvaluate, onEvaluate2';
  var src = [ 1, 2, [ 3 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 4, element : [ 3 ] } );

  /* */

  test.case = 'array has not searched element, fromIndex, onEvaluate1, onEvaluate2';
  var src = [ 1, 2, [ 3 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, 2, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 2, element : [ 3 ] } );

  test.case = 'array has duplicated searched element, fromIndex, onEvaluate1, onEvaluate2';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longRight( src, 2, 7, ( e ) => e.a, ( ins ) => ins );
  test.identical( got, { index : 7, element : { a : 2 } } );

  test.case = 'searches complex data, fromIndex, onEvaluate, onEvaluate2';
  var src = [ 1, 2, [ 3, 4 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, 4, ( e ) => e[ 0 ], ( ins ) => ins );
  test.identical( got, { index : 4, element : [ 3 ] } );

  /* */

  test.case = 'array has not searched element, equalizer';
  var src = [ 1, 2, [ 3 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, ( e, ins ) => e[ 0 ] === ins );
  test.identical( got, { index : 4, element : [ 3 ] } );

  test.case = 'array has duplicated searched element, equalizer';
  var src = [ 1, 2, 3, 'str', [ 3 ], 3, 'str', { a : 2 } ];
  var got = _.longRight( src, 2, ( e, ins ) => e.a === ins );
  test.identical( got, { index : 7, element : { a : 2 } } );

  test.case = 'searches complex data, equalizer';
  var src = [ 1, 2, [ 3 ], 'str', [ 3 ], { a : 2 } ];
  var got = _.longRight( src, 3, ( e, ins ) => e[ 0 ] ===  ins );
  test.identical( got, { index : 4, element : [ 3 ] } );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longRight() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longRight( [ 1, 2 ], 1, 0, ( e ) => e, ( ins ) => ins, 'extra' ) );

  test.case = 'fromIndex is not a number';
  test.shouldThrowErrorSync( () => _.longRight( [ 1, 2 ], 1, 'wrong' ) );

  test.case = 'onEvaluate1 is not a routine, not a number';
  test.shouldThrowErrorSync( () => _.longRight( [ 1, 2 ], 1, 0, 'wrong' ) );

  test.case = 'onEvaluate1 has wrong length';
  test.shouldThrowErrorSync( () => _.longRight( [ 1, 2 ], 1, 0, () => 1 ) );

  test.case = 'onEvaluate2 has wrong length';
  test.shouldThrowErrorSync( () => _.longRight( [ 1, 2 ], 1, 0, ( e ) => e, () => 1 ) );
}

//

function longCountElementWithoutCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src = empty long, element = number';
    var src = new makeLong( [] );
    var got = _.longCountElement( src, 3 );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = empty long, element = undefined';
    var src = new makeLong( [] );
    var got = _.longCountElement( src, undefined );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = empty long, element = null';
    var src = new makeLong( [] );
    var got = _.longCountElement( src, null );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'element = string, no matches';
    var src = new makeLong( [ 1, 2, null, 10, 10, true ] );
    var got = _.longCountElement( src, 'hi' );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'element = number, one matching';
    var src = new makeLong( [ 1, 2, null, 10, 10, true ] );
    var got = _.longCountElement( src, 2 );
    var expected = 1;
    test.identical( got, expected );

    test.case = 'element = number, four matches';
    var src = new makeLong( [ 1, 2, 'str', 10, 10, true, 2, 2, 10, 10 ] );
    var got = _.longCountElement( src, 10 );
    var expected = 4;
    test.identical( got, expected );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longCountElement() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 1, 2, 3, 'abc', 13 ] ) );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 1, 2, 3, true ], true, 'extra argument' ) );

  test.case = 'wrong type of first srcArray';
  test.shouldThrowErrorSync( () => _.longCountElement( undefined, true ) );
  test.shouldThrowErrorSync( () => _.longCountElement( null, true ) );
  test.shouldThrowErrorSync( () => _.longCountElement( 'str', true ) );
  test.shouldThrowErrorSync( () => _.longCountElement( 4, true ) );

  test.case = 'evaluator is wrong - have no arguments';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 3, 4, 5, true ], 3, () => 3 ) );

  test.case = 'evaluator is wrong - have three arguments';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 3, 4, 5, true ], 3, ( a, b, c ) => _.typeOf( a ) === _.typeOf( b ) === _.typeOf( c ) ) );

  test.case = 'evaluator2 is unnacessary';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 3, 4, 5, true ], 3, ( a, b ) => _.typeOf( a ) === _.typeOf( b ), ( e ) => e ) );

  test.case = 'evaluator2 is wrong - have no arguments';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 3, 4, 5, true ], 3, ( a ) => a, () => e ) );

  test.case = 'fourth argument is wrong - have two arguments';
  test.shouldThrowErrorSync( () => _.longCountElement( [ 3, 4, 5, true ], 3, ( a ) => a, ( a, b ) => e ) );
}

//

function longCountElementWithCallback( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    test.case = 'src = complex long, no evaluator, no equalizer';
    var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
    var got = _.longCountElement( src, 0 );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = complex long, one evaluator, no matches';
    var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
    var got = _.longCountElement( src, 2, ( e ) => e[ 0 ] );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = complex long, one evaluator, four matches';
    var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
    var got = _.longCountElement( src, 0, ( e ) => e[ 0 ] );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = complex long, evaluator1 and evaluator2, one matching';
    var src = makeLong( [ [ 1, 3 ], [ 2, 2 ], [ 3, 1 ] ] );
    var got = _.longCountElement( src, 1, ( e ) => e[ 1 ], ( e ) => e + 2 );
    var expected = 1;
    test.identical( got, expected );

    test.case = 'src = complex long, evaluator1 and evaluator2, four matches';
    var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
    var got = _.longCountElement( src, 0, ( e ) => e[ 0 ], ( e ) => e );
    var expected = 4;
    test.identical( got, expected );

    test.case = 'element = number, without equalizer, two mathces';
    var got = _.longCountElement( [ 1, 2, 3, 2, 'str' ], 2 );
    var expected = 2;
    test.identical( got, expected );

    test.case = 'element = number, equalizer, four mathces';
    var got = _.longCountElement( [ 1, 2, 3, 2, 'str' ], 2, ( a, b ) => _.typeOf( a ) === _.typeOf( b ) );
    var expected = 4;
    test.identical( got, expected );
  }
}

//

function longCountTotal( test )
{
  var list =
  [
    _.arrayMake,
    _.unrollMake,
    _.argumentsArrayMake,
    I8x,
    U16x,
    F32x,
    F64x,
  ];

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    testRun( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function testRun( makeLong )
  {
    /* zero */

    test.case = 'empty array';
    var src = new makeLong( [] );
    var got = _.longCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'several nulls';
    var src = new makeLong( [ null, null, null ] );
    var got = _.longCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'several zeros';
    var src = new makeLong( [ 0, 0, 0, 0 ] );
    var got = _.longCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'mix of nulls and zeros';
    var src = new makeLong( [ 0, null, null, 0, 0, 0, null ] );
    var got = _.longCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    /* array elements are numbers */

    test.case = 'sum of no repeated elements';
    var src = new makeLong( [ 1, 3, 5, 7, 9, 1, 3 ] );
    var got = _.longCountTotal( src );
    var expected = 29;
    test.identical( got, expected );

    /* array elements are booleans */

    test.case = 'all true';
    var src = new makeLong( [ true, true, true, true ] );
    var got = _.longCountTotal( src );
    var expected = 4;
    test.identical( got, expected );

    test.case = 'all false';
    var src = new makeLong( [ false, false, false, false, false ] );
    var got = _.longCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'mix of true and false';
    var src = new makeLong( [ false, false, true, false, true, false, false, true ] );
    var got = _.longCountTotal( src );
    var expected = 3;
    test.identical( got, expected );

    /* array elements are numbers and booleans */

    test.case = 'all true and numbers';
    var src = new makeLong( [ true, 2, 1, true, true, 0, true ] );
    var got = _.longCountTotal( src );
    var expected = 7;
    test.identical( got, expected );

    test.case = 'all false and numbers';
    var src = new makeLong( [ 1, false, 0, false, false, 4, 3, false, false ] );
    var got = _.longCountTotal( src );
    var expected = 8;
    test.identical( got, expected );

    test.case = 'mix of true, false, numbers and null';
    var src = new makeLong( [ null, false, false, 0, true, null, false, 10, true, false, false, true, 2, null ] );
    var got = _.longCountTotal( src );
    var expected = 15;
    test.identical( got, expected );

    /* array has negative numbers */

    if( !_.bufferTypedIs( new makeLong( 0 ) ) )
    {
      test.case = 'numbers, negative result';
      var src = new makeLong( [ 2, -3, 4, -4, 6, -7 ] );
      var got = _.longCountTotal( src );
      var expected = -2;
      test.identical( got, expected );

      test.case = 'mix of true, false, numbers and null - negative result';
      var src = new makeLong( [ null, false, false, 0, true, null, -8, false, 10, true, false, -9, false, true, 2, null ] );
      var got = _.longCountTotal( src );
      var expected = -2;
      test.identical( got, expected );
    }
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longCountTotal() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longCountTotal( [ 1, 2, -3, 13 ], [] ) );

  test.case = 'wrong type of srcArray';
  test.shouldThrowErrorSync( () => _.longCountTotal( undefined ) );
  test.shouldThrowErrorSync( () => _.longCountTotal( null ) );
  test.shouldThrowErrorSync( () => _.longCountTotal( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.longCountTotal( 3 ) );

  test.case = 'srcArray contains strings';
  test.shouldThrowErrorSync( () => _.longCountTotal( [ 1, '2', 3, 'a' ] ) );

  test.case = 'srcArray contains arrays';
  test.shouldThrowErrorSync( () => _.longCountTotal( [ 1, [ 2 ], 3, [ null ] ] ) );
}

//

function longCountUnique( test )
{

  test.case = 'nothing';
  var got = _.longCountUnique( [] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.longCountUnique( [ 1, 2, 3, 4, 5 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'three pairs';
  var got = _.longCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ] );
  var expected = 3;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longCountUnique();
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.longCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ], function( e ) { return e }, 'redundant argument' );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longCountUnique( 'wrong argument', function( e ) { return e } );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.longCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ], 'wrong argument' );
  });

};

// //
//
// function longSum( test )
// {
//
//   test.case = 'nothing';
//   var got = _.longSum( [] );
//   var expected = 0;
//   test.identical( got, expected );
//
//   test.case = 'returns sum';
//   var got = _.longSum( [ 1, 2, 3, 4, 5 ] );
//   var expected = 15;
//   test.identical( got, expected );
//
//   test.case = 'returns sum';
//   var got = _.longSum( [ true, false, 13, '33' ], function( e ) { return e * 2 } );
//   var expected = 94;
//   test.identical( got, expected );
//
//   test.case = 'converts and returns sum';
//   var got = _.longSum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 } );
//   var expected = 30;
//   test.identical( got, expected );
//
//   /**/
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longSum();
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longSum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 }, 'redundant argument' );
//   });
//
//   test.case = 'first argument is wrong';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longSum( 'wrong argument', function( e ) { return e / 2 } );
//   });
//
//   test.case = 'second argument is wrong';
//   test.shouldThrowErrorSync( function()
//   {
//     _.longSum( [ 1, 2, 3, 4, 5 ], 'wrong argument' );
//   });
//
// };

//

function experiment( test )
{

}

experiment.experimental = 1;

//

function loggerProblemExperiment( test )
{

  /*
  qqq : Vova, please investigate
        it gives

    ExitCode : -1
    Passed test checks 1 / 1
    Passed test cases 1 / 1
    Passed test routines 1 / 1
    Test suite ( Tools/base/l1/Long ) ... in 2.745s ... failed

  */

  test.case = 'ins as BufferNode';
  var expected = BufferNode.alloc( 5 );
  var expected = new BufferNode( 5 );
  // var src = _.longFill( new F32x( 5 ), 1 );
  // var got = _.longMake( BufferNode, src );
  // test.is( _.bufferNodeIs(  got ) );
  // test.identical( got.length, 5 );
  // test.identical( got, expected );
  test.identical( 1, 1 );
}

// --
//
// --

var Self =
{

  name : 'Tools.base.Long',
  silencing : 1,
  enabled : 1,

  tests :
  {

    // arguments array

    argumentsArrayMake,
    argumentsArrayFrom,

    // long l0/l3

    longIs,

    // long, l0/l5

    longMakeWithArrayAndUnroll,
    longMakeWithArgumentsArray,
    longMakeWithBufferTyped,
    longMakeWithArrayAndUnrollLongDescriptor,
    longMakeWithArgumentsArrayLongDescriptor,
    longMakeWithBufferTypedLongDescriptor,

    longMakeEmptyWithArrayAndUnroll,
    longMakeEmptyWithArgumentsArray,
    longMakeEmptyWithBufferTyped,
    longMakeEmptyWithArrayAndUnrollLongDescriptor,
    longMakeEmptyWithArgumentsArrayLongDescriptor,
    longMakeEmptyWithBufferTypedLongDescriptor,

    _longMakeOfLengthWithArrayAndUnroll,
    _longMakeOfLengthWithArgumentsArray,
    _longMakeOfLengthWithBufferTyped,
    _longMakeOfLengthWithArrayAndUnrollLongDescriptor,
    _longMakeOfLengthWithArgumentsArrayLongDescriptor,
    _longMakeOfLengthWithBufferTypedLongDescriptor,

    longMakeUndefinedWithArrayAndUnroll,
    longMakeUndefinedWithArgumentsArray,
    longMakeUndefinedWithBufferTyped,
    longMakeUndefinedWithArrayAndUnrollLongDescriptor,
    longMakeUndefinedWithArgumentsArrayLongDescriptor,
    longMakeUndefinedWithBufferTypedLongDescriptor,

    longMakeZeroedWithArrayAndUnroll,
    longMakeZeroedWithArgumentsArray,
    longMakeZeroedWithBufferTyped,
    longMakeZeroedWithArrayAndUnrollLongDescriptor,
    longMakeZeroedWithArgumentsArrayLongDescriptor,
    longMakeZeroedWithBufferTypedLongDescriptor,

    longMakeFillingWithArrayAndUnroll,
    longMakeFillingWithArgumentsArray,
    longMakeFillingWithBufferTyped,
    longMakeFillingWithArrayAndUnrollLongDescriptor,
    longMakeFillingWithArgumentsArrayLongDescriptor,
    longMakeFillingWithBufferTypedLongDescriptor,

    //

    longFrom,
    longFromLongDescriptor,
    longFromCoercing,
    longFromCoercingLongDescriptor,
    longFromCoercingArgumentsArrayLongDescriptor,

    //

    longSlice,

    longButWithArrayUnrollArgumentsArray,
    longButWithBufferTyped,
    longButInplaceWithArrayUnrollArgumentsArray,
    longButInplaceWithBufferTyped,
    longBut_WithArrayUnrollArgumentsArray,
    longBut_WithBufferTyped,

    longShrinkWithArrayUnrollArgumentsArray,
    longShrinkWithBufferTyped,
    longShrinkInplaceWithArrayUnrollArgumentsArray,
    longShrinkInplaceWithBufferTyped,
    longShrink_WithArrayUnrollArgumentsArray,
    longShrink_WithBufferTyped,

    longGrowWithArrayUnrollArgumentsArray,
    longGrowWithBufferTyped,
    longGrowInplaceWithArrayUnrollArgumentsArray,
    longGrowInplaceWithBufferTyped,
    longGrow_WithArrayUnrollArgumentsArray,
    longGrow_WithBufferTyped,

    longRelengthWithArrayUnrollArgumentsArray,
    longRelengthWithBufferTyped,
    longRelengthInplaceWithArrayUnrollArgumentsArray,
    longRelengthInplaceWithBufferTyped,
    longRelength_WithArrayUnrollArgumentsArray,
    longRelength_WithBufferTyped,

    //

    longShallowCloneOneArgument,
    longShallowCloneFirstArrayLike,
    longShallowCloneFirstBuffer,

    longRepresent,
    // longResize, // Dmytro : uncomment when it will be reimplemented
    longDuplicate,

    // long l0/l8

    longAreRepeatedProbe,
    longAllAreRepeated,
    longAnyAreRepeated,
    longNoneAreRepeated,

    longMask,

    longOnceWithoutCallback,
    longOnceWithCallback,
    longOnce_WithoutCallback,
    longOnce_WithCallback,

    longShrinkWithIndices,

    // array manipulator

    longSwapElements,
    // longPut, /* Dmytro : has not link in l8/gLong.s */
    // longFillTimes,
    longFill,

    longSupplement,
    longExtendScreening,

    longSortDstIsNull,
    longSortDstIsNotNull,

    longRandom,
    longFromRange,
    longFromRangeWithStepDefaultLongDescriptor,
    longFromRangeWithStepNotDefaultLongDescriptor,

    // longToMap, // Dmytro : routine longToMap commented in gLong.s
    // longToStr, // Dmytro : routine longToStr commented in gLong.s

    // long checker

    longCompare,
    longIdentical,

    longHasAnyWithoutCallback,
    longHasAnyWithCallback,
    longHasAllWithoutCallback,
    longHasAllWithCallback,
    longHasNoneWithoutCallback,
    longHasNoneWithCallback,

    longHasDepth,

    // array sequential search

    longLeftIndex,
    longRightIndex,

    longLeft,
    longRight,

    longCountElementWithoutCallback,
    longCountElementWithCallback,
    longCountTotal,
    longCountUnique,

    // // array etc
    //
    // // longSum,

    experiment,
    loggerProblemExperiment,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
