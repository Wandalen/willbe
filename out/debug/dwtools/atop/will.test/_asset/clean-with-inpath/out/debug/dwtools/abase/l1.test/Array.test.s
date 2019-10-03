( function _Long_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );
}

var _ = wTools;

//--
// arguments array
//--

function argumentsArrayMake( test )
{

  test.case = 'empty';
  var src = [];
  var got = _.argumentsArrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'single number';
  var src = [ 0 ];
  var got = _.argumentsArrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'single string';
  var src = [ 'a' ];
  var got = _.argumentsArrayMake( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'several';
  var src = [ 1, 2, 3 ];
  var got = _.argumentsArrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'zero length';
  var got = _.argumentsArrayMake( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'length';
  var got = _.argumentsArrayMake( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayMake();
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayMake( 1, 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayMake( [], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayMake( [], [] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayMake( {} );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayMake( '1' );
  });

}

//

function argumentsArrayFrom( test )
{

  test.case = 'empty';
  var src = [];
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'single number';
  var src = [ 0 ];
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'single string';
  var src = [ 'a' ];
  var got = _.argumentsArrayFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'several';
  var src = [ 1, 2, 3 ];
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'zero length';
  var got = _.argumentsArrayFrom( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'length';
  var got = _.argumentsArrayFrom( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'preserving empty';
  var src = _.argumentsArrayMake( [] );
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single number';
  var src = _.argumentsArrayMake( [ 0 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single string';
  var src = _.argumentsArrayMake( [ 'a' ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving several';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayFrom();
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayFrom( 1, 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayFrom( [], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayFrom( [], [] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayFrom( {} );
  });

  test.shouldThrowErrorSync( function()
  {
    _.argumentsArrayFrom( '1' );
  });

}

//--
// long
//--

function longIs( test )
{

  test.case = 'an empty array';
  var got = _.longIs( [  ] );
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

/* qqq : implement  */

/* qqq : longMake and longMakeUndefined are ugly, please rewrite them from scratch */

/* qqq : tell me how to improve test routine longMake */
/* Dmytro : test routines longMake and longMakeUndefined improved by using test subroutine and automatically created test groups */

function longMake( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var typedList =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < typedList.length; i++ )
  list.push( bufferTyped( typedList[ i ] ) );

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  /* test subroutine */

  function run( long )
  {
    var type = ( dst, got ) => _.argumentsArrayIs( dst ) ?
    got.constructor.name === 'Array' : dst.constructor.name === got.constructor.name;
    var result = ( dst, length ) => _.argumentsArrayIs( dst ) ?
    array( length ) : long( length );

    test.case = 'dst = null, not src';
    var got = _.longMake( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'dst = empty, not src';
    var dst = long( [] );
    var got = _.longMake( dst );
    var expected = result( dst, [] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = empty, src = number';
    var dst = long( [] );
    var got = _.longMake( dst, 2 );
    var expected = result( dst, 2 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = number, src < dst.length';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMake( dst, 2 );
    var expected = result( dst, [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = number, src > dst.length';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMake( dst, 4 );
    var expected = _.bufferTypedIs( dst ) ? result( dst, [ 1, 2, 3, 0 ] ) : result( dst, [ 1, 2, 3, undefined ] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = long, src.length > dst.length';
    var dst = long( [ 0, 1 ] );
    var src = [ 1, 2, 3 ];
    var got = _.longMake( dst, src );
    var expected = result( dst, [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = long, not src';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMake( dst );
    var expected = result( dst, [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = new long, src = array'
    var dst = long( 2 );
    var src = [ 1, 2, 3, 4, 5 ];
    var got = _.longMake( dst, src );
    var expected = result( dst, [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = Array constructor, src = long';
    var src = long( [ 1, 2, 3 ] );
    var got = _.longMake( Array, src );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( _.arrayIs( got ) );
    test.is( got !== src );

    test.case = 'dst = BufferTyped constructor, src = long';
    var src = long( [ 1, 1, 1, 1, 1 ] );
    var got = _.longMake( U32x, src );
    var expected = new U32x( [ 1, 1, 1, 1, 1 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== src );
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
  test.shouldThrowErrorSync( () => _.longMake( Array, BufferNode.from( [ 3 ] ) ) );
  if( Config.interpreter === 'njs' )
  test.shouldThrowErrorSync( () => _.longMake( BufferNode.alloc( 3 ), 2 ) );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.longMake( [ 1, 2, 3 ], 'wrong type of argument' ) );
  test.shouldThrowErrorSync( () => _.longMake( [ 1, 2, 3 ], Infinity  ) );

}

//

function _longMakeOfLength( test )
{

  test.case = 'an empty array';
  var got = _._longMakeOfLength( [  ], 0 );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'length = 1';
  var got = _._longMakeOfLength( [  ], 1 );
  var expected = [ undefined ];
  test.identical( got, expected );

  test.case = 'length = 2';
  var got = _._longMakeOfLength( [ 1, 2, 3 ], 2 );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  test.case = 'length = 4';
  var got = _._longMakeOfLength( [ 1, 2, 3 ], 4 );
  var expected = [ 1, 2, 3, undefined ];
  test.identical( got, expected );

  test.case = 'same length';

  var expected = [ 1, 2, 3 ];
  var ins = [ 1, 2, 3 ];
  var got = _._longMakeOfLength( ins );
  test.identical( got.length, 3 );
  test.is( got !== ins );
  test.identical( got, expected );

  var expected = new U8x( 5 );
  var ins = new U8x( 5 );
  ins[ 0 ] = 1;
  var got = _._longMakeOfLength( ins );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 5 );
  test.is( got !== ins );
  test.identical( got, expected );

  var ins = new U8x( 5 );
  var src = [ 1, 2, 3, 4, 5 ];
  var got = _._longMakeOfLength( ins, src );
  var expected = new U8x( 5 );
  test.is( _.bufferTypedIs( got ) );
  test.is( got instanceof U8x );
  test.identical( got.length, 5 );
  test.identical( got, expected )

  test.case = 'typedArray';
  var expected = new U8x( 4 );
  expected[ 0 ] = 1;
  var ins = new U8x( 5 );
  ins[ 0 ] = 1;
  var got = _._longMakeOfLength( ins, 4 );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 4 );
  test.is( got !== ins );
  test.identical( got, expected );

  test.case = 'ins as Array';
  var expected = new Array( 5 );
  var got = _._longMakeOfLength( Array, 5 );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 5 );
  test.identical( got, expected );

  test.case = 'ins as Array';
  var expected = [ undefined, undefined, undefined ];
  var src = [ 1, 2, 3 ];
  var got = _._longMakeOfLength( Array, src );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 3 );
  test.identical( got, expected );

  test.case = 'ins as Array';
  var expected = [ undefined, undefined, undefined, undefined, undefined ];
  var src = _.longFill( new F32x( 5 ), 1 );
  var got = _._longMakeOfLength( Array, src );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 5 );
  test.identical( got, expected );

  test.case = 'ins as BufferNode';
  var expected = BufferNode.alloc( 5 );
  var src = _.longFill( new F32x( 5 ), 1 );
  var got = _._longMakeOfLength( BufferNode, src );
  test.is( _.bufferNodeIs(  got ) );
  test.identical( got.length, 5 );
  test.identical( got, expected );

  test.case = 'ins as Array';
  var expected = new Array( 5 );
  var src = BufferNode.from( [ 1, 1, 1, 1, 1 ] );
  var got = _._longMakeOfLength( Array, Array.from( src ) );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 5 );
  test.identical( got, expected );

  test.case = 'ins as TypedArray';
  var expected = new U8x( 3 );
  var src = [ 1, 2, 3 ];
  var got = _._longMakeOfLength( U8x, src );
  test.is( _.bufferTypedIs(  got ) );
  test.identical( got.length, 3 );
  test.identical( got, expected );

  test.case = 'ins as TypedArray';
  var expected = new F32x( 5 );
  var src = BufferNode.from( [ 1, 1, 1, 1, 1 ] );
  var got = _._longMakeOfLength( F32x, Array.from( src ) );
  test.is( _.bufferTypedIs(  got ) );
  test.identical( got.length, 5 );
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _._longMakeOfLength();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _._longMakeOfLength('wrong argument');
  });

  test.case = 'arguments[1] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _._longMakeOfLength( [ 1, 2, 3 ], 'wrong type of argument' );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _._longMakeOfLength( [ 1, 2, 3 ], 4, 'redundant argument' );
  });

  test.case = 'argument is not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _._longMakeOfLength( 1, 2, 3, 4 );
  });

};

//

/*
qqq : implement
Dmytro : implemented
*/

function longMakeUndefined( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var typedList =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < typedList.length; i++ )
  list.push( bufferTyped( typedList[ i ] ) );

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    run( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function run( long )
  {
    var type = ( dst, got ) => _.argumentsArrayIs( dst ) ?
    got.constructor.name === 'Array' : dst.constructor.name === got.constructor.name;
    var result = ( dst, length ) => _.argumentsArrayIs( dst ) ?
    array( length ) : long( length );

    test.case = 'dst = null, not src';
    var got = _.longMakeUndefined( null );
    var expected = [];
    test.identical( got, expected );

    test.case = 'dst = empty, not src';
    var dst = long( [] );
    var got = _.longMakeUndefined( dst );
    var expected = result( dst, [] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = empty, src = number';
    var dst = long( [] );
    var got = _.longMakeUndefined( dst, 2 );
    var expected = result( dst, 2 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = number, src < dst.length';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( dst, 2 );
    var expected = result( dst, 2 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = number, src > dst.length';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( dst, 4 );
    var expected = result( dst, 4 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = long, src.length > dst.length';
    var dst = long( [ 0, 1 ] );
    var src = [ 1, 2, 3 ];
    var got = _.longMakeUndefined( dst, src );
    var expected = result( dst, 3 );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = long, not src';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( dst );
    var expected = result( dst, 3 );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = new long, src = array'
    var dst = long( 5 );
    var src = [ 1, 2, 3, 4, 5 ];
    var got = _.longMakeUndefined( dst, src );
    var expected = result( dst, 5 );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = Array constructor, src = long';
    var src = long( [ 1, 2, 3 ] );
    var got = _.longMakeUndefined( Array, src );
    var expected = [ undefined, undefined, undefined ];
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( _.arrayIs( got ) );
    test.is( got !== src );

    test.case = 'dst = BufferTyped constructor, src = long';
    var src = long( [ 1, 1, 1, 1, 1 ] );
    var got = _.longMakeUndefined( U32x, src );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== src );
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

/*
qqq : implement Zeroed routine and test routine
Dmytro : routine longMakeZeroed and its test routine is implemented
*/

function longMakeZeroed( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var typedList =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < typedList.length; i++ )
  list.push( bufferTyped( typedList[ i ] ) );

  /* tests */

  for( let t = 0; t < list.length; t++ )
  {
    test.open( list[ t ].name );
    run( list[ t ] );
    test.close( list[ t ].name );
  }

  /* test subroutine */

  function run( long )
  {
    var type = ( dst, got ) => _.argumentsArrayIs( dst ) ?
    got.constructor.name === 'Array' : dst.constructor.name === got.constructor.name;
    var result = ( dst, length ) =>
    {
      let result = [];
      if( !_.bufferTypedIs( dst ) )
      for( let i = 0; i < length; i++ )
      result.push( 0 );

      else
      result = long( length );

      return result
    }

    test.case = 'dst = empty, not src';
    var dst = long( [] );
    var got = _.longMakeZeroed( dst );
    var expected = result( dst, [] );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = empty, src = number';
    var dst = long( [] );
    var got = _.longMakeZeroed( dst, 2 );
    var expected = result( dst, 2 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = number, src < dst.length';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( dst, 2 );
    var expected = result( dst, 2 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = number, src > dst.length';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( dst, 4 );
    var expected = result( dst, 4 );
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'src = long, src.length > dst.length';
    var dst = long( [ 0, 1 ] );
    var src = [ 1, 2, 3 ];
    var got = _.longMakeZeroed( dst, src );
    var expected = result( dst, 3 );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== src );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = long, not src';
    var dst = long( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( dst );
    var expected = result( dst, 3 );
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = new long, src = array'
    var dst = long( 5 );
    var src = [ 1, 2, 3, 4, 5 ];
    var got = _.longMakeZeroed( dst, src );
    var expected = result( dst, 5 );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got !== dst );
    test.is( type( dst, got ) );

    test.case = 'dst = Array constructor, src = long';
    var src = long( [ 1, 2, 3 ] );
    var got = _.longMakeZeroed( Array, src );
    var expected = [ 0, 0, 0 ];
    test.identical( got, expected );
    test.identical( got.length, 3 );
    test.is( _.arrayIs( got ) );
    test.is( got !== src );

    test.case = 'dst = BufferTyped constructor, src = long';
    var src = long( [ 1, 1, 1, 1, 1 ] );
    var got = _.longMakeZeroed( U32x, src );
    var expected = new U32x( 5 );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( _.bufferTypedIs(  got ) );
    test.is( got !== src );
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

/*
qqq : improve, add exception checking ceases
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

  function makeArray()
  {
    var result = [];
    for( var a = 0 ; a < arguments.length ; a++ )
    result.push( arguments[ a ] );
    return result;
  }

  function makeArgumentsArray()
  {
    return arguments;
  }

  function makeF32()
  {
    var result = new F32x( arguments );
    return result;
  }

  function makeU8()
  {
    var result = new U8x( arguments );
    return result;
  }

  /* test routine */

  function runFor( a )
  {

    test.case = 'empty';

    var srcLong = a();
    var got = _.longSlice( srcLong );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a();
    var got = _.longSlice( srcLong, 0 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a();
    var got = _.longSlice( srcLong, 0, 5 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a();
    var got = _.longSlice( srcLong, -1, 5 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a();
    var got = _.longSlice( srcLong, 0, -1 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'single element';

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong );
    var expected = a( 3 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, 0 );
    var expected = a( 3 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, 0, -1 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, 0, 10 );
    var expected = a( 3 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, 0, -10 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, -1 );
    var expected = a( 3 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, -1, 10 );
    var expected = a( 3 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 3 );
    var got = _.longSlice( srcLong, -1, -2 );
    var expected = a();
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'just pass srcLong';

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong );
    var expected = srcLong;
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'make copy of source';

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 0 );
    var expected = a( 1, 2, 3, 4, 5, 6, 7 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, -1 );
    var expected = a( 7 );
    test.identical( got, expected );

    test.case = 'third argument is not provided';
    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 2 );
    var expected = a( 3, 4, 5, 6, 7 );
    test.identical( got, expected );

    test.case = 'second argument is undefined';
    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, undefined, 4  );
    var expected = a( 1, 2, 3, 4 );
    test.identical( got, expected );

    test.case = 'from two to six';
    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 2, 6 );
    var expected = a( 3, 4, 5, 6 );
    test.identical( got, expected );

    test.case = 'indexes are out of bound';
    var srcLong = a( 1, 2, 3 );
    var got = _.longSlice( srcLong, 5, 8 );
    var expected = a();
    test.identical( got, expected );

    test.case = 'left bound is negative';
    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, -1, srcLong.length );
    var expected = a( 7 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'rigth bound is negative';
    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 0, -1 );
    var expected = a( 1, 2, 3, 4, 5, 6 );
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'rigth bound is out of range';
    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 0, srcLong.length + 2 );
    var expected = srcLong;
    test.identical( got, expected );
    test.is( srcLong !== got );

    test.case = 'etc';

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong );
    test.is( got.constructor === srcLong.constructor );
    test.is( got !== srcLong );
    test.identical( got, srcLong );

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 0 );
    test.is( got.constructor === srcLong.constructor );
    test.is( got !== srcLong );
    test.identical( got, srcLong );

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var expected = a( 7 );
    var got = _.longSlice( srcLong, -1 );
    test.is( got.constructor === srcLong.constructor );
    test.is( got !== srcLong );
    test.identical( got, expected );

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, 0, 1 );
    test.is( got.constructor === srcLong.constructor );
    test.is( got !== srcLong );
    test.identical( got, a( 1 ) );

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, srcLong.length, srcLong.length );
    test.is( got.constructor === srcLong.constructor );
    test.is( got !== srcLong );
    test.identical( got, a() );

    var srcLong = a( 1, 2, 3, 4, 5, 6, 7 );
    var got = _.longSlice( srcLong, -1, srcLong.length + 1 );
    test.is( got.constructor === srcLong.constructor );
    test.is( got !== srcLong );
    test.identical( got, a( 7 ) );

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
qqq : please ask how to improve test routine longBut.
Dmytro : improved by using given clarifications
*/

function longBut( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => _.argumentsArrayMake( src );

  /* - */

  var list =
  [
    array,
    unroll,
    argumentsArray
  ];

  /* - */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function run( make )
  {
    test.case = 'range = number, not src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var got = _.longBut( dst, 2 );
    var expected = [ 1, 2, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = negative number, not src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var got = _.longBut( dst, -1 );
    var expected = [ 1, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var got = _.longBut( dst, 0, [ 0 ] );
    var expected = [ 0, 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range = number, empty src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var src = [];
    var got = _.longBut( dst, 0, src );
    var expected = [ 2, 3, 4 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );


    test.case = 'range, empty src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [];
    var got = _.longBut( dst, [ 1, 3 ], src );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range, not src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longBut( dst, [ 1, 3 ] );
    var expected = [ 1, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ 1, 3 ], src );
    var expected = [ 1, 11, 22, 33, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] == range[ 1 ], src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ 1, 1 ], src );
    var expected = [ 1, 11, 22, 33, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ -10, 2 ], src );
    var expected = [ 11, 22, 33, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 1 ] > dst.length, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ 3, 10 ], src );
    var expected = [ 1, 2, 3, 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ -10, 10 ], src );
    var expected = [ 11, 22, 33 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longBut( dst, [ -1, -1 ], src );
    var expected = [ 11, 22, 33, 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var but = _.longBut( dst, [ 9, 0 ], src );
    var expected = [ 1, 2, 3, 4, 5, 11, 22, 33 ];
    test.identical( but, expected );
    test.is( got !== dst );
    test.is( got !== src );
  }

  /* Buffers */

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];


  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    var dst = new list( 5 );
    var src = [ 6, 7 ]
    for( var j = 0; j < 5; j++ )
    dst[ j ] = j + 1;

    test.case = 'range = number, not src';
    var select = _.longSelect( dst, 0 );
    var but = _.longBut( dst, 0 );
    var expected = _.longMake( new list(), [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range = number, src';
    var select = _.longSelect( dst, [ 6, 7 ] );
    var but = _.longBut( dst, 4, src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range = number, range > dst.length, src';
    var select = _.longSelect( dst, 10 );
    var but = _.longBut( dst, 10, src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length';
    var select = _.longSelect( dst, [ 2, 5 ] );
    var but = _.longBut( dst, [ 2, 5 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2 ] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length, src';
    var select = _.longSelect( dst, [ 4, 5 ] );
    var but = _.longBut( dst, [ 4, 5 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, not src';
    var select = _.longSelect( dst, [ 0, -1 ] );
    var but = _.longBut( dst, [ 0, -1 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, not src';
    var select = _.longSelect( dst, [ -1, -1 ] );
    var but = _.longBut( dst, [ -1, -1 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range[ 0 ] === range[ 1 ], src';
    var select = _.longSelect( dst, [ 0, 0 ] );
    var but = _.longBut( dst, [ 0, 0 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 6, 7, 1, 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, not src';
    var select = _.longSelect( dst, [ 0, 99 ] );
    var but = _.longBut( dst, [ 0, 99 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, src';
    var select = _.longSelect( dst, [ 0, 99 ] );
    var but = _.longBut( dst, [ 0, 99 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var select = _.longSelect( dst, [ 10, 0 ] );
    var but = _.longBut( dst, [ 10, 0 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );
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

function longButInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'range = number, not src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var got = _.longButInplace( dst, 2 );
    var expected = make( [ 1, 2, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range = negative number, not src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var got = _.longButInplace( dst, -1 );
    var expected = make( [ 1, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range = number, src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var got = _.longButInplace( dst, 0, [ 0 ] );
    var expected = make( [ 0, 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range = number, empty src';
    var dst = make( [ 1, 2, 3, 4 ] );
    var src = [];
    var got = _.longButInplace( dst, 0, src );
    var expected = make( [ 2, 3, 4 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );


    test.case = 'range, empty src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [];
    var got = _.longButInplace( dst, [ 1, 3 ], src );
    var expected = make( [ 1, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range, not src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longButInplace( dst, [ 1, 3 ] );
    var expected = make( [ 1, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ 1, 3 ], src );
    var expected = make( [ 1, 11, 22, 33, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] == range[ 1 ], src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ 1, 1 ], src );
    var expected = make( [ 1, 11, 22, 33, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ -10, 2 ], src );
    var expected = make( [ 11, 22, 33, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 1 ] > dst.length, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ 3, 10 ], src );
    var expected = make( [ 1, 2, 3, 11, 22, 33 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] > dst.length, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ -10, 10 ], src );
    var expected = make( [ 11, 22, 33 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var got = _.longButInplace( dst, [ -1, -1 ], src );
    var expected = make( [ 11, 22, 33, 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var src = [ 11, 22, 33 ];
    var but = _.longButInplace( dst, [ 9, 0 ], src );
    var expected = make( [ 1, 2, 3, 4, 5, 11, 22, 33 ] );
    test.identical( but, expected );
    test.is( got !== src );
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

  /* Buffers */

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    var dst = new list( 5 );
    var src = [ 6, 7 ]
    for( var j = 0; j < 5; j++ )
    dst[ j ] = j + 1;

    test.case = 'range = number, not src';
    var select = _.longSelect( dst, 0 );
    var but = _.longButInplace( dst, 0 );
    var expected = _.longMake( new list(), [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range = number, src';
    var select = _.longSelect( dst, [ 6, 7 ] );
    var but = _.longButInplace( dst, 4, src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range = number, range > dst.length, src';
    var select = _.longSelect( dst, 10 );
    var but = _.longButInplace( dst, 10, src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length';
    var select = _.longSelect( dst, [ 2, 5 ] );
    var but = _.longButInplace( dst, [ 2, 5 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2 ] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range[ 0 ] > 0, range[ 1 ] < dst.length, src';
    var select = _.longSelect( dst, [ 4, 5 ] );
    var but = _.longButInplace( dst, [ 4, 5 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, not src';
    var select = _.longSelect( dst, [ 0, -1 ] );
    var but = _.longButInplace( dst, [ 0, -1 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but === dst );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < 0, not src';
    var select = _.longSelect( dst, [ -1, -1 ] );
    var but = _.longButInplace( dst, [ -1, -1 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but === dst );

    test.case = 'range[ 0 ] === range[ 1 ], src';
    var select = _.longSelect( dst, [ 0, 0 ] );
    var but = _.longButInplace( dst, [ 0, 0 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 6, 7, 1, 2, 3, 4, 5 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, not src';
    var select = _.longSelect( dst, [ 0, 99 ] );
    var but = _.longButInplace( dst, [ 0, 99 ] );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [] );
    test.identical( but, expected );
    test.is( but !== dst );

    test.case = 'range[ 0 ] = 0, range[ 1 ] > dst.length, src';
    var select = _.longSelect( dst, [ 0, 99 ] );
    var but = _.longButInplace( dst, [ 0, 99 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );

    test.case = 'range[ 0 ] > range[ 1 ], src';
    var select = _.longSelect( dst, [ 10, 0 ] );
    var but = _.longButInplace( dst, [ 10, 0 ], src );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5 ] );
    test.identical( dst, expected );
    var expected = _.longMake( list, [] );
    test.identical( select, expected );
    var expected = _.longMake( list, [ 1, 2, 3, 4, 5, 6, 7 ] );
    test.identical( but, expected );
    test.is( but !== dst );
    test.is( but !== src );
  }

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

function longSelect( test )
{
  /* resizable longs */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, dst.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, dst.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = make( [ 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.longSelect( dst, [ -1, 3 ] );
    expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, -1 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ 0, dst.length + 2 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.identical( got.length, 5 );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );
  //
  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longSelect( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ 0, -1 ] );
  var expected = [];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelect( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    test.case = 'only dst';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, dst.length + 2 ] );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new list( [ 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, 3 ] );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    got = _.longSelect( dst, [ -1, 3 ] );
    expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ 0, -1 ] );
    var expected = new list();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelect( dst, [ -1, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longSelect() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longSelect( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longSelect( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longSelect( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longSelect( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longSelect( [ 1 ], 'str' ) );
}

//

function longSelectInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, dst.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = make( [ 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.longSelectInplace( dst, [ -1, 3 ] );
    expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, -1 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );
  }

  /* - */

  test.open( 'argumentsArray' );

  test.case = 'only dst';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ 0, dst.length + 2 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.identical( got.length, 5 );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ 0, dst.length + 2 ], 0 );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( got === dst );

  test.case = 'range > dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
  var expected = [ 5 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );
  //
  test.case = 'range < dst.length';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ 0, 3 ] );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'range < dst.length, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ 0, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  got = _.longSelectInplace( dst, [ -1, 3 ] );
  expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'l < 0, not a val';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ 0, -1 ] );
  var expected = [];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.case = 'f < 0, val = number';
  var dst = _.argumentsArrayMake( [ 1, 2, 3, 4, 5 ] );
  var got = _.longSelectInplace( dst, [ -1, 3 ], 0 );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( got !== dst );

  test.close( 'argumentsArray' );

  /* - */

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    test.case = 'only dst';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, dst.length + 2 ] );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.identical( got.length, 5 );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new list( [ 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, 3 ] );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    got = _.longSelectInplace( dst, [ -1, 3 ] );
    expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ 0, -1 ] );
    var expected = new list();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longSelectInplace( dst, [ -1, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.longSelectInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.longSelectInplace( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'array is not long';
  test.shouldThrowErrorSync( () => _.longSelectInplace( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.longSelectInplace( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.longSelectInplace( [ 1 ], [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.longSelectInplace( [ 1 ], 'str' ) );

}

//

function longGrow( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrow( dst, [ -1, 3 ] );
    expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, -1 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
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

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    test.case = 'only dst';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ] );
    var expected = dst.length + 2;
    test.identical( got, new list( [ 1, 2, 3, 4, 5, 0, 0 ] ) );
    test.identical( got.length, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ] );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, 3 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrow( dst, [ -1, 3 ] );
    expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ 0, -1 ] );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrow( dst, [ -1, 3 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }

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

function longGrowInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrowInplace( dst, [ -1, 3 ] );
    expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, -1 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
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

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    test.case = 'only dst';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ] );
    var expected = dst.length + 2;
    test.identical( got, new list( [ 1, 2, 3, 4, 5, 0, 0 ] ) );
    test.identical( got.length, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ] );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, 3 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    got = _.longGrowInplace( dst, [ -1, 3 ] );
    expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ 0, -1 ] );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longGrowInplace( dst, [ -1, 3 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );
  }

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

function longRelength( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = make( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelength( dst, [ -1, 3 ] );
    expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, -1 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
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

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    test.case = 'only dst';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ] );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new list( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ] );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelength( dst, [ -1, 3 ] );
    expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ 0, -1 ] );
    var expected = new list();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelength( dst, [ -1, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }

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

function longRelengthInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'only dst';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range > dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = make( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'range < dst.length, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelengthInplace( dst, [ -1, 3 ] );
    expected = make( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'l < 0, not a val';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, -1 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'f < 0, val = number';
    var dst = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3 ] );
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

  var list =
  [
    I8x,
    U16x,
    F32x,
    F64x,

    // I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    // U16x,
    // I32x,
    // U32x,
    // F32x,
    // F64x,
  ];

  for( var i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run2( list[ i ] );
    test.close( list[ i ].name );
  }

  function run2( list )
  {
    test.case = 'only dst';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst );
    var expected = new list( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got === dst );

    test.case = 'range > dst.length, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ] );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, dst.length + 2 ], 0 );
    var expected = new list( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range > dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ dst.length - 1, dst.length * 2 ], 0 );
    var expected = new list( [ 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ] );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'range < dst.length, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    got = _.longRelengthInplace( dst, [ -1, 3 ] );
    expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'l < 0, not a val';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ 0, -1 ] );
    var expected = new list();
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );

    test.case = 'f < 0, val = number';
    var dst = new list( [ 1, 2, 3, 4, 5 ] );
    var got = _.longRelengthInplace( dst, [ -1, 3 ], 0 );
    var expected = new list( [ 1, 2, 3 ] );
    test.identical( got, expected );
    test.is( _.bufferTypedIs( got ) );
    test.is( got !== dst );
  }

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

function longRepresent( test )
{

  test.case = 'nothing';
  var got = _.longRepresent( [  ], 0, 0 );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'two arguments';
  var got = _.longRepresent( [  ], 0 );
  var expected = [  ];
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

};

//

function longResize( test )
{
  var got, expected;

  test.case = 'defaults';
  var array = [ 1, 2, 3, 4, 5, 6, 7 ];
  array.src = true;

  /* just pass array */

  got = _.longResize( array );
  test.identical( got.src, undefined );
  test.identical( got, array );

  //

  test.case = 'make copy of source';

  /* third argument is not provided */

  got = _.longResize( array, 2 );
  test.identical( got.src, undefined );
  expected = [ 3, 4, 5, 6, 7 ];
  test.identical( got, expected );

  /* second argument is undefined */

  got = _.longResize( array, undefined, 4  );
  test.identical( got.src, undefined );
  expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );

  /**/

  got = _.longResize( array, 0, 3 );
  test.identical( got.src, undefined );
  expected = [ 1, 2, 3 ];
  test.identical( got, expected );

  /* from two to six */

  test.case = 'from two to six';
  got = _.longResize( array, 2, 6 );
  test.identical( got.src, undefined );
  expected = [ 3, 4, 5, 6 ];
  test.identical( got, expected );

  /* rigth bound is negative */

  got = _.longResize( array, 0, -1 );
  test.identical( got.src, undefined );
  expected = [];
  test.identical( got, expected );

  /* both bounds are negative */

  got = _.longResize( array, -1, -3 );
  test.identical( got.src, undefined );
  expected = [];
  test.identical( got, expected );

  /* TypedArray */

  var arr = new U16x( array );
  arr.src = true;
  got = _.longResize( arr, 0, 3 );
  test.identical( got.src, undefined );
  expected = new U16x( [ 1, 2, 3 ] );
  test.identical( got, expected );

  /* BufferNode */

  if( Config.interpreter === 'njs' )
  {
    test.case = 'buffer';
    var got = _.longResize( BufferNode.from( '123' ), 0, 5, 0 );
    var expected = [ 49, 50, 51, 0, 0 ];
    test.identical( got, expected );
  }

  /**/

  test.case = 'increase size of array';

  /* rigth bound is out of range */

  got = _.longResize( array, 0, array.length + 2 );
  test.identical( got.src, undefined );
  expected = array.slice();
  expected.push( undefined, undefined );
  test.identical( got, expected );

  /* indexes are out of bound */

  got = _.longResize( array, array.length + 1, array.length + 3 );
  test.identical( got.src, undefined );
  expected = [ undefined, undefined ];
  test.identical( got, expected );

  /* left bound is negative */

  got = _.longResize( array, -1, array.length );
  test.identical( got.src, undefined );
  expected = array.slice();
  expected.unshift( undefined );
  test.identical( got, expected );

  /* without setting value */

  got = _.longResize( array, 0, array.length + 2 );
  test.identical( got.src, undefined );
  test.identical( got.length, array.length + 2 );

  /* by setting value */

  got = _.longResize( array, 0, array.length + 2, 0 );
  test.identical( got.src, undefined );
  expected = [ 1, 2, 3, 4, 5, 6, 7, 0, 0 ];
  test.identical( got, expected );

  /* by taking only last element of source array */

  got = _.longResize( array, array.length - 1, array.length + 2, 0 );
  test.identical( got.src, undefined );
  expected = [ 7, 0, 0 ];
  test.identical( got, expected );

  test.case = 'decrease size of array';

  /* setting value not affects on array */

  got = _.longResize( array, 0, 3, 0 );
  test.identical( got.src, undefined );
  expected = [ 1, 2, 3 ];
  test.identical( got, expected );

  /* begin index is negative */

  got = _.longResize( array, -1, 3, 0 );
  test.identical( got.src, undefined );
  expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  /* end index is negative */

  got = _.longResize( array, 0, -1 );
  test.identical( got.src, undefined );
  expected = [];
  test.identical( got, expected );

  /* begin index negative, set value */

  got = _.longResize( array, -1, 3, 0 );
  test.identical( got.src, undefined );
  expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  /* TypedArray */

  var arr = new U16x( array );
  arr.src = true;
  got = _.longResize( arr, 0, 4, 4 );
  test.identical( got.src, undefined );
  expected = new U16x( [ 1, 2, 3, 4 ] );
  test.identical( got, expected );

  //

  if( Config.interpreter === 'njs' )
  {
    test.case = 'buffer';
    var got = _.longResize( BufferNode.from( '123' ), 0, 5, 0 );
    var expected = [ 49, 50, 51, 0, 0 ];
    test.identical( got, expected );
  }

  //

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longResize();
  });

  /**/

  test.case = 'invalid arguments type';

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.longResize( 1 );
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.longResize( array, '1', array.length )
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.longResize( array, 0, '1' )
  })

  /**/

  test.case = 'buffer';

  /**/

  got = _.longResize( BufferNode.from( '123' ), 0, 1 );
  expected = [ 49 ];
  test.identical( got, expected );

  //

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.longResize( 'wrong argument', 'wrong argument', 'wrong argument' );
  });

};

//

function longDuplicate( test )
{
  test.case = 'couple of repeats';
  var got = _.longDuplicate( [ 'a', 'b', 'c' ] );
  var expected = [ 'a', 'a', 'b', 'b', 'c', 'c' ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 1 numberOfDuplicatesPerElement 1';
  var options =
  {
    src : [ 10, 20 ],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 1 numberOfDuplicatesPerElement 2';
  var options =
  {
    src : [ 10, 20 ],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 10, 20, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 2 numberOfDuplicatesPerElement 1';
  var options =
  {
    src : [ 10, 20 ],
    numberOfAtomsPerElement : 2,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 10, 20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 2 numberOfDuplicatesPerElement 2';
  var options =
  {
    src : [ 10, 20 ],
    numberOfAtomsPerElement : 2,
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
    numberOfAtomsPerElement : 1,
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
    numberOfAtomsPerElement : 2,
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
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 'abc', 'def',  ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var options =
  {
    src : [ 'abc', 'def' ],
    result : [ 1, 2 ],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 1, 2, 'abc', 'def',  ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var arr = new U8x( 1 );
  arr[ 0 ] = 5;
  var options =
  {
    src : [ 1, 2 ],
    result : arr,
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.longDuplicate( options );
  var expected = [ 5, 1, 2 ];
  var equal = true;
  for( var i = 0; i < expected.length; i++ )
  {
    if( expected[ i ] !== got[ i ]  )
    equal = false;
  }
  test.is( equal );
  test.identical( got.length, expected.length );

  /* */

  test.case = 'second argument is replaced and non-existent elements from options.src is replaced undefined';
  var options = {
    src : [ 'abc', 'def', undefined ],
    numberOfAtomsPerElement : 3,
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
    result : [  ],
    numberOfAtomsPerElement : 3,
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
    numberOfAtomsPerElement : 1,
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

  var got = _.longAllAreRepeated( [] );
  test.identical( got, true );

  var got = _.longAllAreRepeated( [ 1, 1 ] );
  test.identical( got, true );

  var got = _.longAllAreRepeated( [ 1 ] );
  test.identical( got, false );

  var got = _.longAllAreRepeated( [ 1, 2, 2 ] );
  test.identical( got, false );

}

//

function longAnyAreRepeated( test )
{

  var got = _.longAnyAreRepeated( [] );
  test.identical( got, false );

  var got = _.longAnyAreRepeated( [ 1, 1 ] );
  test.identical( got, true );

  var got = _.longAnyAreRepeated( [ 1 ] );
  test.identical( got, false );

  var got = _.longAnyAreRepeated( [ 1, 2, 2 ] );
  test.identical( got, true );

}

//

function longNoneAreRepeated( test )
{

  var got = _.longNoneAreRepeated( [] );
  test.identical( got, true );

  var got = _.longNoneAreRepeated( [ 1, 1 ] );
  test.identical( got, false );

  var got = _.longNoneAreRepeated( [ 1 ] );
  test.identical( got, true );

  var got = _.longNoneAreRepeated( [ 1, 2, 2 ] );
  test.identical( got, false );

}

//

function longMask( test )
{

  test.case = 'nothing';
  var got = _.longMask( [ 1, 2, 3, 4 ], [ undefined, null, 0, '' ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'adds last three values';
  var got = _.longMask( [ 'a', 'b', 'c', 4, 5 ], [ 0, '', 1, 2, 3 ] );
  var expected = [ "c", 4, 5 ];
  test.identical( got, expected );

  test.case = 'adds the certain values';
  var got = _.longMask( [ 'a', 'b', 'c', 4, 5, 'd' ], [ 3, 7, 0, '', 13, 33 ] );
  var expected = [ "a", 'b', 5, 'd' ];
  test.identical( got, expected );

  /**/


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
    _.longMask( [  ], [  ] );
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

function longOnce( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => src === null ? _.argumentsArrayMake( [] ) : _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* callbacks */

  var evaluator = ( e ) => _.mapIs( e ) ? e.v : e;
  var equalizer = function( e1, e2 )
  {
    e1 = _.mapIs( e1 ) ? e1.v : e1;
    e2 = _.mapIs( e2 ) ? e2.v : e2;
    return e1 === e2;
  }

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var listDst =
  [
    array,
    unroll,
    argumentsArray,
  ];

  for( let i in listTyped )
  listDst.push( bufferTyped( listTyped[ i ] ) );

  var listOnEvaluate =
  [
    evaluator,
    equalizer,
  ]

  /* only dst */

  for( let d in listDst )
  {
    test.open( 'dst = ' + listDst[ d ].name );
    dstOnly( listDst[ d ] );
    test.close( 'dst = ' + listDst[ d ].name );
  }

  /* dst and onEvaluate, src in test cases */

  let i = 0;
  while( !_.bufferTypedIs( listDst[ i ]( 0 ) ) )
  {
    test.open( 'dst = ' + listDst[ i ].name );

    for( let d = 0; d < listOnEvaluate.length; d++ )
    {
      test.open( 'onEvaluate = ' + listOnEvaluate[ d ].name );
      dstAndOnEvaluate( listDst[ i ], listOnEvaluate[ d ] );
      test.close( 'onEvaluate = ' + listOnEvaluate[ d ].name );
    }

    test.close( 'dst = ' + listDst[ i ].name );

    i++
  }

  /* test routines */

  function dstOnly( makeDst )
  {
    test.case = 'dst = null';
    var dst = makeDst( null );
    var got = _.longOnce( dst );
    var expected = makeDst( null );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length = 0';
    var dst = makeDst( [] );
    debugger;
    var got = _.longOnce( dst );
    var expected = makeDst( [] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length = 1';
    var dst = makeDst( [ 1 ] );
    var got = _.longOnce( dst );
    var expected = makeDst( [ 1 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length > 1, no duplicates';
    var dst = makeDst( [ 1, 2, 3, 4, 5 ] );
    var got = _.longOnce( dst );
    var expected = makeDst( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === dst );

    test.case = 'dst.length > 1, duplicates';
    var dst = makeDst( [ 1, 2, 2, 1, 5, 3, 4, 5, 5, 3 ] );
    var got = _.longOnce( dst );
    var expected = _.argumentsArrayIs( dst ) ? array( [ 1, 2, 5, 3, 4 ] ) : makeDst( [ 1, 2, 5, 3, 4 ] );
    test.identical( got, expected );
    if( !_.argumentsArrayIs( dst ) && !_.bufferAnyIs( dst ) )
    test.is( got === dst );

  }

  /* - */

  function dstAndOnEvaluate( makeDst, onEvaluate )
  {
    var result = ( dst, src ) =>

    test.case = 'dst has duplicates';
    var dst = makeDst( [ { v : 1 }, { v : 2 }, { v : 1 }, { v : 2 }, { v : 1 }, { v : 3 } ] );
    var got = _.longOnce( dst, onEvaluate );
    var expected = _.argumentsArrayIs( dst ) ?
    array( [ { v : 1 }, { v : 2 }, { v : 3 } ] ) : makeDst( [ { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    if( !_.argumentsArrayIs( dst ) )
    test.is( got === dst );

    test.case = 'dst has not duplicates';
    var dst = makeDst( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    var got = _.longOnce( dst, onEvaluate );
    var expected = makeDst( [ 5, 6, { v : 1 }, { v : 2 }, { v : 3 } ] );
    test.identical( got, expected );
    if( !_.argumentsArrayIs( dst ) )
    test.is( got === dst );
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

function longSelectWithIndices( test )
{

  test.case = 'nothing';
  var got = _.longSelectWithIndices( [  ], [  ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'certain elements';
  var got = _.longSelectWithIndices( [ 1, 2, 3, 4, 5 ], [ 2, 3, 4 ] );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'array of undefined';
  var got = _.longSelectWithIndices( [ 1, 2, 3 ], [ 4, 5 ] );
  var expected = [ undefined, undefined ];
  test.identical( got, expected );

  test.case = 'using object';
  var src = [ 1, 1, 2, 2, 3, 3 ];
  var indices = { atomsPerElement : 2, indices : [ 0, 1, 2 ] }
  var got = _.longSelectWithIndices( src, indices );
  var expected = [ 1, 1, 2, 2, 3, 3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longSelectWithIndices();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longSelectWithIndices( [ 1, 2, 3 ] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.longSelectWithIndices('wrong argument', 'wrong argument');
  });

  test.case = 'arguments are not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.longSelectWithIndices( 1, 2, 3, 4, 5 );
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
  var got = _.longSwapElements( [ 1, 2, 3, 4, 5 ], 0, 4  );
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
 qqq : Dmytro : not used
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
//     _.longFillTimes( [  ] );
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
  /* Array */

  test.case = 'dst = empty array';
  var got = _.longFill( [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'dst = empty array, value = number';
  var got = _.longFill( [], 1 );
  var expected = [];
  test.identical( got, expected );

  test.case = 'dst = empty array, value = number, range';
  var got = _.longFill( [], 1, [ 0, 3 ] );
  var expected = [ 1, 1, 1 ];
  test.identical( got, expected );

  test.case = 'dst = empty array, value = number, left range < 0';
  var got = _.longFill( [], 1, [ -2, 3 ] );
  var expected = [ 1, 1, 1, 1, 1 ];
  test.identical( got, expected );

  test.case = 'dst = array';
  var got = _.longFill( [ 1, 1, 1 ] );
  var expected = [ 0, 0, 0 ];
  test.identical( got, expected );

  test.case = 'dst = array, value = string';
  var got = _.longFill( [ 1, 1, 1 ], '5' );
  var expected = [ '5', '5', '5' ];
  test.identical( got, expected );

  test.case = 'dst = array, value = string, range';
  var got = _.longFill( [ 1, 1, 1 ], '5', [ 0, 2 ] );
  var expected = [ '5', '5', 1 ];
  test.identical( got, expected );

  test.case = 'dst = array, value = string, range';
  var got = _.longFill( [ 1, 1, 1 ], '5', [ -2, 2 ] );
  var expected = [ '5', '5', '5', '5' ];
  test.identical( got, expected );

  test.case = 'dst = array by constructor, value = map';
  var dst = new Array( 3 );
  var got = _.longFill( dst, { a : 1 } );
  var expected = [ { a : 1 }, { a : 1 }, { a : 1 } ];
  test.identical( got, expected );

  /* Unroll */

  test.case = 'dst = empty unroll';
  var got = _.longFill( _.unrollMake( [] ) );
  var expected = [];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = empty unroll, value = number';
  var got = _.longFill( _.unrollMake( [] ), 1 );
  var expected = [];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = empty unroll, value = number, range';
  var got = _.longFill( _.unrollMake( [] ), 1, [ 0, 3 ] );
  var expected = [ 1, 1, 1 ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = empty unroll, value = number, left range < 0';
  var got = _.longFill( _.unrollMake( [] ), 1, [ -2, 3 ] );
  var expected = [ 1, 1, 1, 1, 1 ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = unroll';
  var got = _.longFill( _.unrollMake( [ 1, 2, 'str' ] ) );
  var expected = [ 0, 0, 0 ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = unroll, value = string';
  var got = _.longFill( _.unrollMake( [ 1, 1, 1 ] ), '5' );
  var expected = [ '5', '5', '5' ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = unroll, value = string, range';
  var got = _.longFill( _.unrollMake( [ 1, 1, 1 ] ), '5', [ 0, 2 ] );
  var expected = [ '5', '5', 1 ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  test.case = 'dst = unroll, value = string, range';
  var got = _.longFill( _.unrollMake( [ 1, 1, 1 ] ), '5', [ -2, 2 ] );
  var expected = [ '5', '5', '5', '5' ];
  test.identical( got, expected );
  test.is( _.unrollIs( got ) );

  /* ArgumentsArray */

  test.case = 'dst = empty argumentsArray';
  var got = _.longFill( _.argumentsArrayMake( [] ) );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'dst = empty argumentsArray, value = number';
  var got = _.longFill( _.argumentsArrayMake( [] ), 1 );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'dst = empty argumentsArray, value = number, range';
  var got = _.longFill( _.argumentsArrayMake( [] ), 1, [ 0, 3 ] );
  var expected = [ 1, 1, 1 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );

  test.case = 'dst = empty argumentsArray, value = number, left range < 0';
  var got = _.longFill( _.argumentsArrayMake( [] ), 1, [ -2, 3 ] );
  var expected = [ 1, 1, 1, 1, 1 ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );

  test.case = 'dst = argumentsArray';
  var got = _.longFill( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var expected = [ 0, 0, 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'dst = argumentsArray, value = string';
  var got = _.longFill( _.argumentsArrayMake( [ 1, 1, 1 ] ), '5' );
  var expected = [ '5', '5', '5' ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'dst = argumentsArray, value = string, range';
  var got = _.longFill( _.argumentsArrayMake( [ 1, 1, 1 ] ), '5', [ 0, 2 ] );
  var expected = [ '5', '5', 1 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );

  test.case = 'dst = argumentsArray, value = string, range';
  var got = _.longFill( _.argumentsArrayMake( [ 1, 1, 1 ] ), '5', [ -2, 2 ] );
  var expected = [ '5', '5', '5', '5' ];
  test.equivalent( got, expected );
  test.is( !_.argumentsArrayIs( got ) );

  /* BufferTyped */

  test.case = 'dst = empty typedArray';
  var got = _.longFill( new U8x( [] ) );
  var expected = new U8x();
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = empty typedArray, value = number';
  var got = _.longFill( new I16x( [] ), 1 );
  var expected = new I16x();
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = empty typedArray, value = number, range';
  var got = _.longFill( new F32x( [] ), 1, [ 0, 3 ] );
  var expected = new F32x( [ 1, 1, 1 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = empty typedArray, value = number, left range < 0';
  var got = _.longFill( new F64x( [] ), 1, [ -2, 3 ] );
  var expected = new F64x( [ 1, 1, 1, 1, 1 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = typedArray';
  var got = _.longFill( new I8x( [ 1, 2, 3 ] ) );
  var expected = new I8x( 3 );
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = typedArray, value = string';
  var got = _.longFill( new U16x( [ 1, 1, 1 ] ), 5 );
  var expected = new U16x( [ 5, 5, 5 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = typedArray, value = string, range';
  var got = _.longFill( new U32x( [ 1, 1, 1 ] ), 5, [ 0, 2 ] );
  var expected = new U32x( [ 5, 5, 1 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

  test.case = 'dst = typedArray, value = string, range';
  var got = _.longFill( new Fx( [ 1, 1, 1 ] ), 5, [ -2, 2 ] );
  var expected = new Fx( [ 5, 5, 5, 5 ] );
  test.identical( got, expected );
  test.is( _.bufferTypedIs( got ) );

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

};

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
  var got = _.longExtendScreening( [  ], [  ], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'returns the corresponding values by indexes of the first argument';
  var got = _.longExtendScreening( [ 1, 2, 3 ], [  ], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
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
  var got = _.longExtendScreening( [  ], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
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

function pairIs( test )
{

  test.case = 'an empty array';
  var got = _.pair.is( [] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a pair';
  var got = _.pair.is( [ 1, [] ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'a pair, but not array';
  var got = _.pair.is( new F32x([ 1, 3 ]) );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.pair.is( {} );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.pair.is( 6 );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.pair.is( 'abc' );
  var expected  = false;
  test.identical( got, expected );

}

//

function pairOfIs( test )
{

  test.case = 'an empty array';
  var got = _.pair.is( [] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a pair';
  var got = _.pair.is( [ 1, [] ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'a pair, but not array';
  var got = _.pair.is( new F32x([ 1, 3 ]) );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.pair.is( {} );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.pair.is( 6 );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.pair.is( 'abc' );
  var expected  = false;
  test.identical( got, expected );

}

//

function arrayIs( test )
{

  test.case = 'an empty array';
  var got = _.arrayIs( [] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.arrayIs( [ 1, 2, 3 ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.arrayIs( {} );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.arrayIs( 6 );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.arrayIs( 'abc' );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'boolean';
  var got = _.arrayIs( true );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'function';
  var got = _.arrayIs( function(){  } );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'a pseudo array';
  var got = ( function()
  {
    return _.arrayIs( arguments );
  } )('Hello there!');
  var expected = false;
  test.identical( got, expected );

  test.case = 'no argument';
  var got = _.arrayIs();
  var expected  = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.arrayIs( null );
  var expected  = false;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

}

//

function constructorLikeArray( test )
{

  test.case = 'an array';
  var got = _.constructorLikeArray( [  ].constructor );
  var expected = true;
  test.identical( got, expected );

  test.case = 'arguments, not possible to say yes by constructor';
  var got = _.constructorLikeArray( arguments.constructor );
  var expected = false;
  test.identical( got, expected );

  test.case = 'raw array buffer';
  debugger;
  var got = _.constructorLikeArray( new BufferRaw( 10 ).constructor );
  var expected = false;
  test.identical( got, expected );

  test.case = 'typed array buffer';
  var got = _.constructorLikeArray( new F32x( 10 ).constructor );
  var expected = true;
  test.identical( got, expected );

  test.case = 'no argument';
  var got = _.constructorLikeArray();
  var expected  = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.constructorLikeArray( null );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.constructorLikeArray( 1 );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'function';
  var got = _.constructorLikeArray( (function() {}).constructor );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.constructorLikeArray( 'x'.constructor );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.constructorLikeArray( 'x' );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.constructorLikeArray( {}.constructor );
  var expected  = false;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

}

//

function hasLength( test )
{

  test.case = 'an empty array';
  var got = _.hasLength( [  ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.hasLength( [ 1, 2, 3 ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'a pseudo array';
  var got = ( function() {
    return _.hasLength( arguments );
  } )('Hello there!');
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array-like';
  var got = _.hasLength( { '0' : 1, '1' : 2, '2' : 3, 'length' : 3 } );
  var expected = true;
  test.identical( got, expected );

  test.case = 'a Function.length';
  function fn( a, b, c ) { };
  var got = _.hasLength( fn );
  var expected = true;
  test.identical( got, expected );

  test.case = 'a "string".length';
  var got = _.hasLength( 'Hello there!' );
  var expected = true;
  test.identical( got, expected );

  test.case = 'no arguments';
  var got = _.hasLength();
  var expected = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.hasLength();
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

};

// --
// producer
// --

function arrayMake( test )
{
  test.case = 'src = null';
  var src = null;
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty array';
  var src = [];
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = array, src.length = 1';
  var src = [ 0 ];
  var got = _.arrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = array, src.length > 1';
  var src = [ 1, 2, 3 ];
  var got = _.arrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = number, src = 0';
  var got = _.arrayMake( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = number, src > 0';
  var got = _.arrayMake( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty U8x';
  var src = new U8x();
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U8x, src.length = 1';
  var src = new U8x( 1 );
  var got = _.arrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U8x, src.length > 1';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.arrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty I16x';
  var src = new I16x();
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I16x, src.length = 1';
  var src = new I16x( 1 );
  var got = _.arrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I16x, src.length > 1';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.arrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty F32x';
  var src = new F32x();
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length = 1';
  var src = new F32x( 1 );
  var got = _.arrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length > 1';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.arrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty arguments array';
  var src = _.argumentsArrayMake( [] );
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = arguments array, src.length = 1';
  var src = _.argumentsArrayMake( [ {} ] );
  var got = _.arrayMake( src );
  var expected = [ {} ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = arguments array, src.length > 1';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.arrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty unroll';
  var src = _.unrollMake( [] );
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = unroll, src.length = 1';
  var src = _.unrollMake( [ 'str' ] );
  var got = _.arrayMake( src );
  var expected = [ 'str' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = unroll, src.length > 1';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayMake( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayMake() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayMake( 1, 3 ) );
  test.shouldThrowErrorSync( () => _.arrayMake( [], 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.arrayMake( {} ) );
  test.shouldThrowErrorSync( () => _.arrayMake( 'wrong' ) );
}

//

function arrayMakeUndefined( test )
{
  test.case = 'src = null';
  var src = null;
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = null, length = 2';
  var src = null;
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty array';
  var src = [];
  var got = _.arrayMakeUndefined( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty array, length = 2';
  var src = [];
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = array, src.length = 1';
  var src = [ 0 ];
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = array, src.length = 1, length = 2';
  var src = [ 0 ];
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = array, src.length > 1';
  var src = [ 1, 2, 3 ];
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = array, src.length > 1, length < src.length';
  var src = [ 1, 2, 3 ];
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = number, src = 0';
  var got = _.arrayMakeUndefined( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = number, src = 0, length > src';
  var got = _.arrayMakeUndefined( 0, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = number, src > 0';
  var got = _.arrayMakeUndefined( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = number, src > 0, length < src';
  var got = _.arrayMakeUndefined( 3, 1 );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty U8x';
  var src = new U8x();
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty U8x, length = 2';
  var src = new U8x();
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U8x, src.length = 1';
  var src = new U8x( 1 );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U8x, src.length = 1, length > src.length';
  var src = new U8x( 1 );
  var got = _.arrayMakeUndefined( src, 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U8x, src.length > 1';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U8x, src.length > 1, length < src.length';
  var src = new U8x( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src, 0 );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty I16x';
  var src = new I16x();
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty I16x, length = 2';
  var src = new I16x();
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I16x, src.length = 1';
  var src = new I16x( 1 );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I16x, src.length = 1, length > src.length';
  var src = new I16x( 1 );
  var got = _.arrayMakeUndefined( src, 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I16x, src.length > 1';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I16x, src.length > 1, length < src.length';
  var src = new I16x( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src, 0 );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty F32x';
  var src = new F32x();
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty F32x, length = 2';
  var src = new F32x();
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length = 1';
  var src = new F32x( 1 );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length = 1, length > src.length';
  var src = new F32x( 1 );
  var got = _.arrayMakeUndefined( src, 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length > 1';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length > 1, length < src.length';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src, 0 );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty arguments array';
  var src = _.argumentsArrayMake( [] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty arguments array, length > 0';
  var src = _.argumentsArrayMake( [] );
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = arguments array, src.length = 1';
  var src = _.argumentsArrayMake( [ {} ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = arguments array, src.length = 1, length > src.length';
  var src = _.argumentsArrayMake( [ {} ] );
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = arguments array, src.length > 1';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = arguments array, src.length > 1, length < src.length';
  var src = _.argumentsArrayMake( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src, 1 );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty unroll';
  var src = _.unrollMake( [] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty unroll, length = 2';
  var src = _.unrollMake( [] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array();
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = unroll, src.length = 1';
  var src = _.unrollMake( [ 'str' ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = unroll, src.length = 1, length > src.length';
  var src = _.unrollMake( [ 'str' ] );
  var got = _.arrayMakeUndefined( src, 2 );
  var expected = new Array( 2 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = unroll, src.length > 1';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = unroll, src.length > 1, length < src.length';
  var src = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayMakeUndefined( src, 1 );
  var expected = new Array( 1 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined( 1, 3, 'extra' ) );
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined( [], 3, 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined( {} ) );
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined( 'wrong' ) );

  test.case = 'wrong type of length';
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined( [], 'wrong' ) );
  test.shouldThrowErrorSync( () => _.arrayMakeUndefined( [], [] ) );
}

//

function arrayFrom( test )
{
  test.case = 'src = null';
  var src = null;
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = number';
  var src = 5;
  var got = _.arrayFrom( src );
  var expected = new Array( 5 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = empty array';
  var src = [];
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'src = empty unroll';
  var src = _.unrollMake( [] );
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty argumentsArray';
  var src = _.argumentsArrayMake( [] );
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty I8x';
  var src = new I8x();
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty U16x';
  var src = new U16x();
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = empty F32x';
  var src = new F32x();
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = array, src.length = 1';
  var src = [ 1 ];
  var got = _.arrayFrom( src );
  var expected = [ 1 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'src = unroll, src.length = 1';
  var src = _.unrollMake( [ 1 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = argumentsArray, src.length = 1';
  var src = _.argumentsArrayMake( [ 'str' ] );
  var got = _.arrayFrom( src );
  var expected = [ 'str' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I8x, src.length = 1';
  var src = new I8x( [ 1 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U16x, src.length = 1';
  var src = new U16x( [ 1 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length = 1';
  var src = new F32x( [ 2 ] );
  var got = _.arrayFrom( src );
  var expected = [ 2 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = array, src.length > 1';
  var src = [ 1, 2, 'str' ];
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 'str' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'src = unroll, src.length = 1';
  var src = _.unrollMake( [ 1, 2, 'str' ] );
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 'str' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.unrollIs( got ) );
  test.is( src !== got );

  test.case = 'src = argumentsArray, src.length = 1';
  var src = _.argumentsArrayMake( [ 1, 2, 'str' ] );
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 'str' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( !_.argumentsArrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = I8x, src.length = 1';
  var src = new I8x( [ 1, 2, 3 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = U16x, src.length = 1';
  var src = new U16x( [ 1, 2, 3 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'src = F32x, src.length = 1';
  var src = new F32x( [ 1, 2, 3 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'src = array from _.arrayMake, src = empty array';
  var src = _.arrayMake( [] );
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'src = array from _.arrayMake, src.length = 1';
  var src = _.arrayMake( [ 'a' ] );
  var got = _.arrayFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'src = array from _.arrayMake, src.length > 1';
  var src = _.arrayMake( [ 1, 2, 3 ] );
  var got = _.arrayFrom( src );
  var expected = [ 1, 2, 3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayFrom() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayFrom( 1, 3 ) );
  test.shouldThrowErrorSync( () => _.arrayFrom( [], 3 ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.arrayMake( {} ) );
  test.shouldThrowErrorSync( () => _.arrayMake( 'wrong' ) );

}

//

function arrayFromCoercing( test )
{

  test.case = 'an array';
  var got = _.arrayFromCoercing( [ 3, 7, 13, 'abc', false, undefined, null, {} ] );
  var expected = [ 3, 7, 13, 'abc', false, undefined, null, {} ];
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.arrayFromCoercing( { a : 3, b : 7, c : 13 } );
  var expected = [ [ 'a', 3 ], [ 'b', 7 ], [ 'c', 13 ] ];
  test.identical( got, expected );

  test.case = 'a string';
  var got = _.arrayFromCoercing( "3, 7, 13, 3.5abc, 5def, 7.5ghi, 13jkl" );
  var expected = [ 3, 7, 13, 3.5, 5, 7.5, 13 ];
  test.identical( got, expected );

  test.case = 'arguments[...]';
  var args = ( function() {
    return arguments;
  } )( 3, 7, 13, 'abc', false, undefined, null, { greeting: 'Hello there!' } );
  var got = _.arrayFromCoercing( args );
  var expected = [ 3, 7, 13, 'abc', false, undefined, null, { greeting: 'Hello there!' } ];
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromCoercing();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromCoercing( 6 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromCoercing( true );
  });

}

//

function arrayRandom( test )
{

  test.case = 'an empty object';
  var got = _.arrayRandom( {  } );
  test.identical( got.length, 1 );
  test.is( got[ 0 ] >= 0 && got[ 0 ]<= 1 );

  test.case = 'a number';
  var got = _.arrayRandom( 5 );
  var expected = got;
  test.identical( got.length, 5 );

  test.case = 'onEach';
  var got = _.arrayRandom
  ({
    length : 3,
    range : [ 1, 9 ],
    onEach : ( range ) => _.intRandom( range ),
  });
  var expected = got;
  test.identical( got.length, 3 );
  test.is( _.intIs( got[ 0 ] ) );
  test.is( _.intIs( got[ 1 ] ) );
  test.is( _.intIs( got[ 2 ] ) );
  test.is( _.rangeIn( [ 1, 9 ], got[ 0 ] ) );
  test.is( _.rangeIn( [ 1, 9 ], got[ 1 ] ) );
  test.is( _.rangeIn( [ 1, 9 ], got[ 2 ] ) );

  test.case = 'without length';
  var dst = [ 0, 0, 0 ];
  debugger;
  var got = _.arrayRandom
  ({
    dst : dst,
    range : [ 1, 9 ],
    onEach : ( range ) => _.intRandom( range ),
  });
  test.is( got === dst );
  test.identical( got.length, 3 );
  test.is( _.intIs( got[ 0 ] ) );
  test.is( _.intIs( got[ 1 ] ) );
  test.is( _.intIs( got[ 2 ] ) );
  test.is( _.rangeIn( [ 1, 9 ], got[ 0 ] ) );
  test.is( _.rangeIn( [ 1, 9 ], got[ 1 ] ) );
  test.is( _.rangeIn( [ 1, 9 ], got[ 2 ] ) );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRandom();
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRandom( 'wrong argument' );
  });

  test.case = 'negative length';
  test.shouldThrowErrorSync( function()
  {
    var got = _.arrayRandom( -1 );
    var expected = [];
    test.identical( got, expected );
  });

};

//

function arrayFromRange( test )
{

  test.case = 'single zero';
  var got = _.arrayFromRange( [ 0, 1 ] );
  var expected = [ 0 ];
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.arrayFromRange( [ 1, 1 ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'single not zero';
  var got = _.arrayFromRange( [ 1, 2 ] );
  var expected = [ 1 ];
  test.identical( got, expected );

  test.case = 'couple of elements';
  var got = _.arrayFromRange( [ 1, 3 ] );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  test.case = 'single number as argument';
  var got = _.arrayFromRange( 3 );
  var expected = [ 0, 1, 2 ];
  test.identical( got, expected );

  test.case = 'complex case';
  var got = _.arrayFromRange( [ 3, 9 ] );
  var expected = [ 3, 4, 5, 6, 7, 8 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromRange( [ 1, 3 ], 'wrong arguments' );
  });

  test.case = 'argument not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromRange( 1, 3 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromRange( 'wrong arguments' );
  });

  test.case = 'no arguments'
  test.shouldThrowErrorSync( function()
  {
    _.arrayFromRange();
  });

};

//

function arrayAs( test )
{
  test.case = 'an empty array';
  var got = _.arrayAs( [  ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'null';
  var got = _.arrayAs( null );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'array contains an object';
  var got = _.arrayAs( { a : 1, b : 2 } );
  var expected = [ { a : 1, b : 2 } ];
  test.identical( got, expected );

  test.case = 'array contains boolean';
  var got = _.arrayAs( true );
  var expected = [ true ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'nothing';
  test.shouldThrowErrorSync( () => _.arrayAs() );

  test.case = 'undefined';
  test.shouldThrowErrorSync( () => _.arrayAs( undefined ) );
};

//

function arrayToMap( test )
{

  test.case = 'an empty object';
  var got = _.arrayToMap( [  ] );
  var expected = {  };
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.arrayToMap( [ 3, [ 1, 2, 3 ], 'abc', false, undefined, null, {} ] );
  var expected = { '0' : 3, '1' : [ 1, 2, 3 ], '2' : 'abc', '3' : false, '4' : undefined, '5' : null, '6' : {} };
  test.identical( got, expected );

  test.case = 'arguments[...]';
  var args = ( function() {
    return arguments;
  } )( 3, 'abc', false, undefined, null, { greeting: 'Hello there!' } );
  var got = _.arrayToMap( args );
  var expected = { '0' : 3, '1' : 'abc', '2' : false, '3' : undefined, '4' : null, '5' : { greeting: 'Hello there!' } };
  test.identical( got, expected );

  test.case = 'longIs';
  var arr = [];
  arr[ 'a' ] = 1;
  var got = _.arrayToMap( arr );
  var expected = {};
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayToMap();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayToMap( 'wrong argument' );
  });

};

//

function arrayToStr( test )
{

  test.case = 'nothing';
  var got = _.arrayToStr( [  ] );
  var expected = "";
  test.identical( got, expected );

  test.case = 'returns the string';
  var got = _.arrayToStr( 'abcdefghijklmnopqrstuvwxyz', { type : 'int' } );
  var expected = "a b c d e f g h i j k l m n o p q r s t u v w x y z ";
  test.identical( got, expected );

  test.case = 'returns a single string representing the integer values';
  var got = _.arrayToStr( [ 1, 2, 3 ], { type : 'int' } );
  var expected = "1 2 3 ";
  test.identical( got, expected );

  test.case = 'returns a single string representing the float values';
  var got = _.arrayToStr( [ 3.5, 13.77, 7.33 ], { type : 'float', precission : 4 } );
  var expected = "3.500 13.77 7.330";
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayToStr();
  });

  test.case = 'in second argument property (type) is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayToStr( [ 1, 2, 3 ], { type : 'wrong type' } );
  });

  test.case = 'in second argument property (type) is not provided';
  test.shouldThrowErrorSync( function()
  {
    _.arrayToStr( [ 1, 2, 3 ], { precission : 4 } );
  });

  test.case = 'first argument is string';
  test.shouldThrowErrorSync( function()
  {
    _.arrayToStr( 'wrong argument', {  type : 'float' } );
  });

}

//

function arrayCompare( test )
{

  test.case = 'empty arrays';
  var got = _.arrayCompare( [  ], [  ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'first array is empty';
  var got = _.arrayCompare( [  ], [ 1, 2 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'length of the first array is less than second';
  var got = _.arrayCompare( [ 4 ], [ 1, 2 ] );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'arrays are equal';
  var got = _.arrayCompare( [ 1, 5 ], [ 1, 5 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'a difference';
  var got = _.arrayCompare( [ 1, 5 ], [ 1, 2 ] );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'a negative difference';
  var got = _.arrayCompare( [ 1, 5 ], [ 1, 6 ] );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  var src1 = function src1() {
    return arguments;
  }( 1, 5 );
  var src2 = function src2() {
    return arguments;
  }( 1, 2 );
  var got = _.arrayCompare( src1, src2 );
  var expected = 3;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCompare();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCompare( [ 1, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCompare( [ 1, 5 ], [ 1, 2 ], 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCompare( 'wrong argument', 'wrong argument' );
  });

  test.case = 'second array is empty';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCompare( [ 1, 5 ], [  ] );
  });

  test.case = 'length of the second array is less than first';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCompare( [ 1, 5 ], [ 1 ] );
  });

};

//

function arraysAreIdentical( test )
{
  test.case = 'empty arrays';
  var got = _.arraysAreIdentical( [  ], [  ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'arrays are equal';
  var got = _.arraysAreIdentical( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function src1() {
    return arguments;
  };
  function src2() {
    return arguments;
  };
  var got = _.arraysAreIdentical( src1( 3, 7, 33 ), src2( 3, 7, 13 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays are not equal';
  var got = _.arraysAreIdentical( [ 1, 2, 3, 'Hi!' ], [ 1, 2, 3, 'Hello there!' ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays length are not equal';
  var got = _.arraysAreIdentical( [ 1, 2, 3 ], [ 1, 2 ] );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraysAreIdentical();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraysAreIdentical( [ 1, 2, 3 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraysAreIdentical( [ 1, 2, 3 ], [ 1, 2 ], 'redundant argument' );
  });

};

//

function arrayHasAny( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => src === null ? _.argumentsArrayMake( [] ) : _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < listTyped.length; i++ )
  list.push( bufferTyped( listTyped[ i ] ) );

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  function run( makeLong )
  {
    /* without evaluator */

    test.case = 'src = empty long, one argument';
    var src = makeLong( [] );
    var got = _.arrayHasAny( src );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = undefined';
    var src = makeLong( [] );
    var got = _.arrayHasAny( src, undefined );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = string';
    var src = makeLong( [] );
    var got = _.arrayHasAny( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = array';
    var src = makeLong( [] );
    var got = _.arrayHasAny( src, [ false, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = number, matches';
    var src = makeLong( [ 1, 2, 1, false, 5 ] );
    var got = _.arrayHasAny( src, 5 );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = string, no matches';
    var src = makeLong( [ 1, 2, 5, false ] );
    var got = _.arrayHasAny( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasAny( src, [ 42, false ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, no matches';
    var src = makeLong( [ 5, null, 32, false, 42 ] );
    var got = _.arrayHasAny( src, [ true, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasAny( src, makeLong( [ 42, 12 ] ) );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, no matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasAny( src, makeLong( [ 30, 12 ] ) );
    var expected = false;
    test.identical( got, expected );
  }

  /* with evaluator, equalizer */

  test.case = 'with evaluator, matches';
  var evaluator = ( e ) => e.a;
  var src = [ { a : 2 }, { a : 5 }, 'str', 42, false ];
  var got = _.arrayHasAny( src, [ [ false ], 7, { a : 2 } ], evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'with evaluator, no matches';
  var evaluator = ( e ) => e.a;
  var src = [ { a : 3 }, { a : 5 }, 'str', 42, false ];
  var got = _.arrayHasAny( src, [ { a : 2 }, { a : 4 } ], evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'with equalizer, matches';
  var equalizer = ( e1, e2 ) => e1.a === e2.a;
  var src = [ { a : 4 }, { a : 2 }, 42, false ];
  var got = _.arrayHasAny( src, [ { a : 2 }, { b : 7 } ], equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'with equalizer, no matches';
  var equalizer = ( e1, e2 ) => e1.a === e2.a;
  var src = [ { a : 4 }, { a : 3 }, 42, false ];
  var got = _.arrayHasAny( src, [ { a : 2 }, { a : 7 } ], equalizer );
  var expected = false;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayHasAny() );

  test.case = 'src has wrong type';
  test.shouldThrowErrorSync( () => _.arrayHasAny( 'wrong argument', false ) );
  test.shouldThrowErrorSync( () => _.arrayHasAny( 1, false ) );

  test.case = 'ins has wrong type';
  test.shouldThrowErrorSync( () => _.arrayHasAny( [ 1, 2, 3, false ], new BufferRaw( 2 ) ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.arrayHasAny( [ 1, 2, 3, false ], 2, 3 ) );
};

//

function arrayHasAll( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => src === null ? _.argumentsArrayMake( [] ) : _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < listTyped.length; i++ )
  list.push( bufferTyped( listTyped[ i ] ) );

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  function run( makeLong )
  {
    /* without evaluator */

    test.case = 'src = empty long, one argument';
    var src = makeLong( [] );
    var got = _.arrayHasAll( src );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = undefined';
    var src = makeLong( [] );
    var got = _.arrayHasAll( src, undefined );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = string';
    var src = makeLong( [] );
    var got = _.arrayHasAll( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = array';
    var src = makeLong( [] );
    var got = _.arrayHasAll( src, [ false, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = number, matches';
    var src = makeLong( [ 1, 2, 5, false ] );
    var got = _.arrayHasAll( src, 5 );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = string, no matches';
    var src = makeLong( [ 1, 2, 5, false ] );
    var got = _.arrayHasAll( src, 'str' );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, matches';
    var src = makeLong( [ 5, null, 42, false, 1 ] );
    var got = _.arrayHasAll( src, [ 42, 1 ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, no matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasAll( src, [ 42, 7 ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, matches';
    var src = makeLong( [ 5, null, 42, false, 12 ] );
    var got = _.arrayHasAll( src, makeLong( [ 42, 12 ] ) );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, no matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasAll( src, makeLong( [ 30, 42 ] ) );
    var expected = false;
    test.identical( got, expected );
  }

  /* with evaluator, equalizer */

  test.case = 'with evaluator, matches';
  var evaluator = ( e ) => e.a;
  var src = [ { a : 2 }, { a : 5 }, 'str', 42, false ];
  var got = _.arrayHasAll( src, [ [ false ], 7, { a : 2 } ], evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'with evaluator, no matches';
  var evaluator = ( e ) => e.a;
  var src = [ { a : 3 }, { a : 5 }, 'str', 42, false ];
  var got = _.arrayHasAll( src, [ { a : 2 }, { a : 4 } ], evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'with equalizer, matches';
  var equalizer = ( e1, e2 ) => e1.a === e2.a;
  var src = [ { a : 4 }, { a : 2 }, 42, false ];
  var got = _.arrayHasAll( src, [ { a : 2 }, { b : 7 } ], equalizer );
  var expected = true;
  test.identical( got, expected );

  test.case = 'with equalizer, no matches';
  var equalizer = ( e1, e2 ) => e1.a === e2.a;
  var src = [ { a : 4 }, { a : 3 }, 42, false ];
  var got = _.arrayHasAll( src, [ { a : 2 }, { a : 7 } ], equalizer );
  var expected = false;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayHasAll() );

  test.case = 'src has wrong type';
  test.shouldThrowErrorSync( () => _.arrayHasAll( 'wrong argument', false ) );
  test.shouldThrowErrorSync( () => _.arrayHasAll( 1, false ) );

  test.case = 'ins has wrong type';
  test.shouldThrowErrorSync( () => _.arrayHasAll( [ 1, 2, 3, false ], new BufferRaw( 2 ) ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.arrayHasAll( [ 1, 2, 3, false ], 2, 3 ) );
};

//

function arrayHasNone( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => src === null ? _.argumentsArrayMake( [] ) : _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < listTyped.length; i++ )
  list.push( bufferTyped( listTyped[ i ] ) );

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  function run( makeLong )
  {
    /* without evaluator */

    test.case = 'src = empty long, one argument';
    var src = makeLong( [] );
    var got = _.arrayHasNone( src );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = undefined';
    var src = makeLong( [] );
    var got = _.arrayHasNone( src, undefined );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = string';
    var src = makeLong( [] );
    var got = _.arrayHasNone( src, 'str' );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = empty long, ins = array';
    var src = makeLong( [] );
    var got = _.arrayHasNone( src, [ false, 7 ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = number, matches';
    var src = makeLong( [ 1, 2, 1, false, 5 ] );
    var got = _.arrayHasNone( src, 5 );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = string, no matches';
    var src = makeLong( [ 1, 2, 5, false ] );
    var got = _.arrayHasNone( src, 'str' );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasNone( src, [ 42, false ] );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = array, no matches';
    var src = makeLong( [ 5, null, 32, false, 42 ] );
    var got = _.arrayHasNone( src, [ true, 7 ] );
    var expected = true;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasNone( src, makeLong( [ 42, 12 ] ) );
    var expected = false;
    test.identical( got, expected );

    test.case = 'src = long, ins = long, no matches';
    var src = makeLong( [ 5, null, 42, false ] );
    var got = _.arrayHasNone( src, makeLong( [ 30, 12 ] ) );
    var expected = true;
    test.identical( got, expected );
  }

  /* with evaluator, equalizer */

  test.case = 'with evaluator, matches';
  var evaluator = ( e ) => e.a;
  var src = [ { a : 2 }, { a : 5 }, 'str', 42, false ];
  var got = _.arrayHasNone( src, [ [ false ], 7, { a : 2 } ], evaluator );
  var expected = false;
  test.identical( got, expected );

  test.case = 'with evaluator, no matches';
  var evaluator = ( e ) => e.a;
  var src = [ { a : 3 }, { a : 5 }, 'str', 42, false ];
  var got = _.arrayHasNone( src, [ { a : 2 }, { a : 4 } ], evaluator );
  var expected = true;
  test.identical( got, expected );

  test.case = 'with equalizer, matches';
  var equalizer = ( e1, e2 ) => e1.a === e2.a;
  var src = [ { a : 4 }, { a : 2 }, 42, false ];
  var got = _.arrayHasNone( src, [ { a : 2 }, { b : 7 } ], equalizer );
  var expected = false;
  test.identical( got, expected );

  test.case = 'with equalizer, no matches';
  var equalizer = ( e1, e2 ) => e1.a === e2.a;
  var src = [ { a : 4 }, { a : 3 }, 42, false ];
  var got = _.arrayHasNone( src, [ { a : 2 }, { a : 7 } ], equalizer );
  var expected = true;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayHasNone() );

  test.case = 'src has wrong type';
  test.shouldThrowErrorSync( () => _.arrayHasNone( 'wrong argument', false ) );
  test.shouldThrowErrorSync( () => _.arrayHasNone( 1, false ) );

  test.case = 'ins has wrong type';
  test.shouldThrowErrorSync( () => _.arrayHasNone( [ 1, 2, 3, false ], new BufferRaw( 2 ) ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.arrayHasNone( [ 1, 2, 3, false ], 2, 3 ) );
};

//

function arraySlice( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'f = undefined, l = undefined';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l = src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, undefined, src.length );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, undefined, 3 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, undefined, -2 );
    var expected = [ 1, 2, 3 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l > src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, undefined, src.length + 5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'f = 0, l = undefined';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 0, src.length );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    var expected2 = _.arraySlice( src );
    test.identical( got, expected );
    test.identical( got, expected2 );
    test.is( got !== src );

    test.case = 'f = 0, l = src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 0, src.length );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    var expected2 = _.arraySlice( src );
    test.identical( got, expected );
    test.identical( got, expected2 );
    test.is( got !== src );

    test.case = 'f = 0, l < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 0, src.length - 2 );
    var expected = [ 1, 2, 3,  ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = 0, l < 0';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 0, -2 );
    var expected = [ 1, 2, 3,  ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = 0, l > src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 0, src.length + 5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    var expected2 = _.arraySlice( src );
    test.identical( got, expected );
    test.identical( got, expected2 );
    test.is( got !== src );

    /* */

    test.case = 'f > 0, l = undefined';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 2 );
    var expected = [ 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f > 0, l = src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 2, src.length );
    var expected = [ 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f > 0, l < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 2, src.length - 2 );
    var expected = [ 3 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f > 0, l < 0';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 2, -2 );
    var expected = [ 3 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f > 0, l > src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, 2, src.length + 2 );
    var expected = [ 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'f < 0, l = undefined';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, -2 );
    var expected = [ 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, l = src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, -2, src.length );
    var expected = [ 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, l < src.length, l > f';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, -2, src.length - 1 );
    var expected = [ 'str' ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, l < src.length, l < 0';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, -2, -1 );
    var expected = [ 'str' ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, l < src.length, l < f';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, -2, src.length - 3 );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    /* */

    test.case = 'f > src.length, l = undefined';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, src.length + 1, src.length );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f > src.length, l = src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, src.length + 1, src.length );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, src.length + 1, 3 );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l < 0';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, src.length + 1, -2 );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f = undefined, l > src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySlice( src, src.length + 1, src.length + 5 );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arraySlice() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arraySlice( [ 1, 2, 3 ], 1, 2, 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.arraySlice( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.arraySlice( _.argumentsArrayMake( [ 1, 2 ] ) ) );
  test.shouldThrowErrorSync( () => _.arraySlice( new F32x( 2 ) ) );
}

//

function arrayBut( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'range = undefined, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, 1 );
    var expected = [ 1, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, -5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, 0, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = undefined, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, 1 );
    var expected = [ 1, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, -5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, 0, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* range = array range */

    test.case = 'range = array range, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ 0, 2 ] );
    var expected = [ 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 0 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ -5, 2 ] );
    var expected = [ 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 1 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ 0, -5 ] );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ 0, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 0 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ -5, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 1 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ 0, -5 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ { a : 1 }, 2, [ 10 ], 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ]';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayBut( src, [ 3, 0 ] );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayBut() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], 0, [ 4 ], 4 ) );

  test.case = 'src is not array';
  test.shouldThrowErrorSync( () => _.arrayBut( 'str', 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayBut( { a : 1 }, 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayBut( new Fx(), 0, [ 4 ] ) );

  test.case = 'not range';
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], 'str', [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], [], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], [ 'str' ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], [ 1, 2, 3 ], [ 4 ] ) );

  test.case = 'ins is not long';
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], 0, 4 ) );
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], 0, { a : 1 } ) );
  test.shouldThrowErrorSync( () => _.arrayBut( [ 1, 2 ], 0, new BufferRaw( 2 ) ) );

}

//

function arrayButInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    test.case = 'range = undefined, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, 1 );
    var expected = make( [ 1, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, -5 );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, 0, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ { a : 1 }, 2, [ 10 ], 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ { a : 1 }, 2, [ 10 ], 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    /* range = array range */

    test.case = 'range = array range, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ 0, 2 ] );
    var expected = ( [ 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 0 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ -5, 2 ] );
    var expected = make( [ 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 1 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ 0, -5 ] );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ 0, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ { a : 1 }, 2, [ 10 ], 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 0 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ -5, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ { a : 1 }, 2, [ 10 ], 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 1 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ 0, -5 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ { a : 1 }, 2, [ 10 ], 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] > range[ 1 ]';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayButInplace( src, [ 3, 0 ] );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayButInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], 0, [ 4 ], 4 ) );

  test.case = 'src is not array';
  test.shouldThrowErrorSync( () => _.arrayButInplace( 'str', 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( { a : 1 }, 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( new Fx(), 0, [ 4 ] ) );

  test.case = 'not range';
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], 'str', [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], [], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], [ 'str' ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], [ 1, 2, 3 ], [ 4 ] ) );

  test.case = 'ins is not long';
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], 0, 4 ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], 0, { a : 1 } ) );
  test.shouldThrowErrorSync( () => _.arrayButInplace( [ 1, 2 ], 0, new BufferRaw( 2 ) ) );

}

//

function arraySelect( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, 1 );
    var expected = [ 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, -5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, 0, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* range = array range */

    test.case = 'range = array range, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ 0, 2 ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 0 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ -5, 2 ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 1 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ 0, -5 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ 0, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 0 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ -5, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 1 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ 0, -5 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ]';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelect( src, [ 3, 0 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arraySelect() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arraySelect( [ 1, 2 ], 0, [ 4 ], 4 ) );

  test.case = 'src is not array';
  test.shouldThrowErrorSync( () => _.arraySelect( 'str', 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelect( { a : 1 }, 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelect( new Fx(), 0, [ 4 ] ) );

  test.case = 'not range';
  test.shouldThrowErrorSync( () => _.arraySelect( [ 1, 2 ], 'str', [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelect( [ 1, 2 ], [], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelect( [ 1, 2 ], [ 'str' ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelect( [ 1, 2 ], [ 1, 2, 3 ], [ 4 ] ) );

}

//

function arraySelectInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, 1 );
    var expected = make( [ 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, -5 );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, 0, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    /* range = array range */

    test.case = 'range = array range, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ 0, 2 ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 0 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ -5, 2 ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 1 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ 0, -5 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ 0, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 0 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ -5, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 1 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ 0, -5 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] > range[ 1 ]';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arraySelectInplace( src, [ 3, 0 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arraySelectInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arraySelectInplace( [ 1, 2 ], 0, [ 4 ], 4 ) );

  test.case = 'src is not array';
  test.shouldThrowErrorSync( () => _.arraySelectInplace( 'str', 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelectInplace( { a : 1 }, 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelectInplace( new Fx(), 0, [ 4 ] ) );

  test.case = 'not range';
  test.shouldThrowErrorSync( () => _.arraySelectInplace( [ 1, 2 ], 'str', [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelectInplace( [ 1, 2 ], [], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelectInplace( [ 1, 2 ], [ 'str' ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arraySelectInplace( [ 1, 2 ], [ 1, 2, 3 ], [ 4 ] ) );

}

//

function arrayGrow( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    /* range = number */

    test.case = 'range = number, number < src length, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrow( src, 1 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrow( src, -5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = number, range > src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrow( src, 6, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2, 3, 'str', [ 1 ], [ { a : 1 }, 2, [ 10 ] ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrow( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* range = array range */

    test.case = 'only src';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range > src.length, not a ins';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ 0, src.length + 2 ] );
    var expected = src.length + 2;
    test.identical( got, [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got.length, expected );
    test.is( got !== src );

    test.case = 'range > src.length, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ 0, src.length + 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range > src.length, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ src.length - 1, src.length * 2 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range < src.length';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ 0, 3 ] );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range < src.length, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ 0, 3 ], 0 );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, not a ins';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    got = _.arrayGrow( src, [ -1, 3 ] );
    expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'l < 0, not a ins';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ 0, -1 ] );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ -1, 3 ], 0 );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f < 0, l < 0, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ -1, -1 ], 0 );
    var expected = [ 1, 2, 3, 4, 5 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'f > l, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrow( src, [ 6, 3 ], 0 );
    var expected = [ 1, 2, 3, 4, 5, 0 ];
    test.identical( got, expected );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayGrow() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayGrow( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'src is not long';
  test.shouldThrowErrorSync( () => _.arrayGrow( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.arrayGrow( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.arrayGrow( [ 1 ], 'str' ) );

}

//

function arrayGrowInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    /* range = number */

    test.case = 'range = number, number < src length, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrowInplace( src, 1 );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrowInplace( src, -5 );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = number, range > src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrowInplace( src, 6, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ], [ { a : 1 }, 2, [ 10 ] ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayGrowInplace( src, -5, [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    /* range = array range */

    test.case = 'only src';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range > src.length, not a ins';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ 0, src.length + 2 ] );
    var expected = make( [ 1, 2, 3, 4, 5, undefined, undefined ] );
    test.identical( got, expected );
    test.identical( got.length, 7 );
    test.is( got === src );

    test.case = 'range > src.length, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ 0, src.length + 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range > src.length, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ src.length - 1, src.length * 2 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0, 0, 0, 0, 0 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range < src.length';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ 0, 3 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range < src.length, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ 0, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'f < 0, not a ins';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    got = _.arrayGrowInplace( src, [ -1, 3 ] );
    expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'l < 0, not a ins';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ 0, -1 ] );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'f < 0, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ -1, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'f < 0, l < 0, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ -1, -1 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'f > l, ins = number';
    var src = make( [ 1, 2, 3, 4, 5 ] );
    var got = _.arrayGrowInplace( src, [ 6, 3 ], 0 );
    var expected = make( [ 1, 2, 3, 4, 5, 0 ] );
    test.identical( got, expected );
    test.is( got === src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayGrowInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayGrowInplace( [ 1 ], [ 1, 4 ], '5', 1 ) );

  test.case = 'src is not long';
  test.shouldThrowErrorSync( () => _.arrayGrowInplace( 1, [ 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.arrayGrowInplace( new ArrayBuffer( 4 ), [ 0, 5 ] ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.arrayGrowInplace( [ 1 ], 'str' ) );

}

//

function arrayRelength( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, 1 );
    var expected = [ 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, -5 );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = number, range > src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, 6, 'abc' );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, -5, 'abc' );
    var expected = [ 1, 2, 3, 'str', [ 1 ] ];
    test.identical( got, expected );
    test.is( got !== src );

    /* range = array range */

    test.case = 'range = array range, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 0, 2 ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 0 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ -5, 2 ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range = array range, range[ 1 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 0, -5 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 1 ] < src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 0, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ -5, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [ 1, 2 ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 0, -5 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], range[ 0 ] > src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 8, 0 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] > range[ 1 ], range[ 0 ] < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 3, 1 ] );
    var expected = [];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] > 0, [ 1 ] > src.length, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 3, 6 ] );
    var expected = [ 'str', [ 1 ], undefined ];
    test.identical( got, expected );
    test.is( got !== src );

    test.case = 'range[ 0 ] > 0, [ 1 ] > src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelength( src, [ 3, 7 ], 7 );
    var expected = [ 'str', [ 1 ], 7, 7 ];
    test.identical( got, expected );
    test.is( got !== src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayRelength() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayRelength( [ 1, 2 ], 0, [ 4 ], 4 ) );

  test.case = 'src is not array';
  test.shouldThrowErrorSync( () => _.arrayRelength( 'str', 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelength( { a : 1 }, 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelength( new Fx(), 0, [ 4 ] ) );

  test.case = 'not range';
  test.shouldThrowErrorSync( () => _.arrayRelength( [ 1, 2 ], 'str', [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelength( [ 1, 2 ], [], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelength( [ 1, 2 ], [ 'str' ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelength( [ 1, 2 ], [ 1, 2, 3 ], [ 4 ] ) );

}

//

function arrayRelengthInplace( test )
{
  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );

  /* - */

  test.open( 'array' );
  run( array );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( unroll );
  test.close( 'unroll' );

  /* - */

  function run( make )
  {
    /* range = number */

    test.case = 'range = number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, 1 );
    var expected = make( [ 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, -5 );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = number, range > src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, 6, 'abc' );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = negative number, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, -5, 'abc' );
    var expected = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    test.identical( got, expected );
    test.is( got === src );

    /* range = array range */

    test.case = 'range = array range, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 0, 2 ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 0 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ -5, 2 ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range = array range, range[ 1 ] < 0, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 0, -5 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 1 ] < src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 0, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] < 0, range[ 1 ] < src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ -5, 2 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [ 1, 2 ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] = 0, range[ 1 ] < 0, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 0, -5 ], [ { a : 1 }, 2, [ 10 ] ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] > range[ 1 ], range[ 0 ] > src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 8, 0 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] > range[ 1 ], range[ 0 ] < src.length';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 3, 1 ] );
    var expected = make( [] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] > 0, [ 1 ] > src.length, not ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 3, 6 ] );
    var expected = make( [ 'str', [ 1 ], undefined ] );
    test.identical( got, expected );
    test.is( got === src );

    test.case = 'range[ 0 ] > 0, [ 1 ] > src.length, ins';
    var src = make( [ 1, 2, 3, 'str', [ 1 ] ] );
    var got = _.arrayRelengthInplace( src, [ 3, 7 ], 7 );
    var expected = make( [ 'str', [ 1 ], 7, 7 ] );
    test.identical( got, expected );
    test.is( got === src );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( [ 1, 2 ], 0, [ 4 ], 4 ) );

  test.case = 'src is not array';
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( 'str', 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( { a : 1 }, 0, [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( new Fx(), 0, [ 4 ] ) );

  test.case = 'not range';
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( [ 1, 2 ], 'str', [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( [ 1, 2 ], [], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( [ 1, 2 ], [ 'str' ], [ 4 ] ) );
  test.shouldThrowErrorSync( () => _.arrayRelengthInplace( [ 1, 2 ], [ 1, 2, 3 ], [ 4 ] ) );

}

//

function arrayLeftIndex( test )
{

  test.case = 'nothing';
  var got = _.arrayLeftIndex( [  ], 3 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'second index';
  var got = _.arrayLeftIndex( [ 1, 2, 3 ], 3 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'zero index';
  var got = _.arrayLeftIndex( [ 1, 2, 3 ], 3, function( el, ins ) { return el < ins } );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.arrayLeftIndex( [ 1, 2, 3 ], 4 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.arrayLeftIndex( [ 1, 2, 3 ], 3, function( el, ins ) { return el > ins } );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function arr()
  {
    return arguments;
  }
  var _arr = arr( 3, 7, 13 );
  var got = _.arrayLeftIndex( _arr, 13 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayLeftIndex( [ 0, 0, 0, 0 ], 0, 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayLeftIndex( [ 0, 0, 0, 0 ], 0, 3 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayLeftIndex( [ 0, 0, 0, 0 ], 0, -1 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator';
  var got = _.arrayLeftIndex( [ 1, 1, 2, 2, 3, 3 ], 3, 2, function( el, ins ) { return el < ins } );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator x2';
  var evaluator1 = ( el ) => el + 1;
  var evaluator2 = ( ins ) => ins * 2;
  var got = _.arrayLeftIndex( [ 6, 6, 5, 5 ], 3, 2, evaluator1, evaluator2 );
  var expected = 2;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'one argument';
  test.shouldThrowErrorSync( function()
  {
    var got = _.arrayLeftIndex( [ 1, 2, 3 ] );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayLeftIndex();
  });

  test.case = 'third argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayLeftIndex( [ 1, 2, 3 ], 2, 'wrong argument' );
  });

};

//

function arrayRightIndex( test )
{

  test.case = 'nothing';
  var got = _.arrayRightIndex( [  ], 3 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'second index';
  var got = _.arrayRightIndex( [ 1, 2, 3 ], 3 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'zero index';
  var got = _.arrayRightIndex( [ 1, 2, 3 ], 3, function( el, ins ) { return el < ins } );
  var expected = 1;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.arrayRightIndex( [ 1, 2, 3 ], 4 );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.arrayRightIndex( [ 1, 2, 3 ], 3, function( el, ins ) { return el > ins } );
  var expected = -1;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function arr()
  {
    return arguments;
  }
  var _arr = arr( 3, 7, 13 );
  var got = _.arrayRightIndex( _arr, 13 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fifth index';
  var got = _.arrayRightIndex( 'abcdef', 'e', function( el, ins ) { return el > ins } );
  var expected = 5;
  test.identical( got, expected );

  test.case = 'third index';
  var got = _.arrayRightIndex( 'abcdef', 'd' );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'second index';
  var got = _.arrayRightIndex( 'abcdef', 'c', function( el ) { return el; } );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0, 0, 0, 0 ], 0, 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0, 0, 0, 0 ], 0, 3 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0, 1, 1, 0 ], 0, 1 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0, 1, 1, 0 ], 1, 2 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator';
  var got = _.arrayRightIndex( [ 1, 1, 2, 2, 3, 3 ], 3, 4, function( el, ins ) { return el < ins } );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator x2';
  var evaluator1 = function( el ) { return el + 1 }
  var evaluator2 = function( ins ) { return ins * 2 }
  var got = _.arrayRightIndex( [ 6, 6, 5, 5 ], 3, 2, evaluator1, evaluator2 );
  var expected = 2;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'one argument';
  test.shouldThrowErrorSync( function()
  {
    var got = _.arrayRightIndex( [ 1, 2, 3 ] );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRightIndex();
  });

  test.case = 'third argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRightIndex( [ 1, 2, 3 ], 2, 'wrong argument' );
  });

};

//

function arrayLeft( test )
{

  test.case = 'returns an object';
  var got = _.arrayLeft( [ 1, 2, 3, 4, 5 ], 3 );
  var expected = { index : 2, element : 3 };
  test.identical( got, expected );

  test.case = 'returns an object';
  var got = _.arrayLeft( [ 1, 2, false, 'str', 5 ], 'str', function( a, b ) { return a === b } );
  var expected = { index : 3, element : 'str' };
  test.identical( got, expected );

  test.case = 'returns an object';
  var got = _.arrayLeft( [ 1, 2, false, 'str', 5 ], 5, function( a ) { return a; } );
  var expected = { index : 4, element : 5 };
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayLeft();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayLeft( [] );
  });

  test.case = 'third argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayLeft( [ 1, 2, 3 ], 2, 'wrong argument' );
  });

};

//

function arrayCountElement( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => src === null ? _.argumentsArrayMake( [] ) : _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < listTyped.length; i++ )
  list.push( bufferTyped( listTyped[ i ] ) );

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function run( makeLong )
  {
    test.case = 'src = empty long, element = number';
    var src = makeLong( [] );
    var got = _.arrayCountElement( src, 3 );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = empty long, element = undefined';
    var src = makeLong( [] );
    var got = _.arrayCountElement( src, undefined );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'src = empty long, element = null';
    var src = makeLong( [] );
    var got = _.arrayCountElement( src, null );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'element = string, no matches';
    var src = makeLong( [ 1, 2, null, 10, 10, true ] );
    var got = _.arrayCountElement( src, 'hi' );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'element = number, one matching';
    var src = makeLong( [ 1, 2, null, 10, 10, true ] );
    var got = _.arrayCountElement( src, 2 );
    var expected = 1;
    test.identical( got, expected );

    test.case = 'element = number, four matches';
    var src = makeLong( [ 1, 2, 'str', 10, 10, true, 2, 2, 10, 10 ] );
    var got = _.arrayCountElement( src, 10 );
    var expected = 4;
    test.identical( got, expected );

    // Evaluators

    if( !_.bufferTypedIs( makeLong( 0 ) ) )
    {
      test.case = 'src = complex long, no evaluator, no equalizer';
      var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
      var got = _.arrayCountElement( src, 0 );
      var expected = 0;
      test.identical( got, expected );

      test.case = 'src = complex long, one evaluator, no matches';
      var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
      var got = _.arrayCountElement( src, 2, ( e ) => e[ 0 ] );
      var expected = 0;
      test.identical( got, expected );

      test.case = 'src = complex long, one evaluator, four matches';
      var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
      var got = _.arrayCountElement( src, 0, ( e ) => e[ 0 ] );
      var expected = 0;
      test.identical( got, expected );

      test.case = 'src = complex long, evaluator1 and evaluator2, one matching';
      var src = makeLong( [ [ 1, 3 ], [ 2, 2 ], [ 3, 1 ] ] );
      var got = _.arrayCountElement( src, 1, ( e ) => e[ 1 ], ( e ) => e + 2 );
      var expected = 1;
      test.identical( got, expected );

      test.case = 'src = complex long, evaluator1 and evaluator2, four matches';
      var src = makeLong( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ] );
      var got = _.arrayCountElement( src, 0, ( e ) => e[ 0 ], ( e ) => e );
      var expected = 4;
      test.identical( got, expected );

      test.case = 'element = number, without equalizer, two mathces';
      var got = _.arrayCountElement( [ 1, 2, 3, 2, 'str' ], 2 );
      var expected = 2;
      test.identical( got, expected );

      test.case = 'element = number, equalizer, four mathces';
      var got = _.arrayCountElement( [ 1, 2, 3, 2, 'str' ], 2, ( a, b ) => _.typeOf( a ) === _.typeOf( b ) );
      var expected = 4;
      test.identical( got, expected );
    }
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayCountElement() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 1, 2, 3, 'abc', 13 ] ) );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 1, 2, 3, true ], true, 'extra argument' ) );

  test.case = 'wrong type of first srcArray';
  test.shouldThrowErrorSync( () => _.arrayCountElement( undefined, true ) );
  test.shouldThrowErrorSync( () => _.arrayCountElement( null, true ) );
  test.shouldThrowErrorSync( () => _.arrayCountElement( 'str', true ) );
  test.shouldThrowErrorSync( () => _.arrayCountElement( 4, true ) );

  test.case = 'evaluator is wrong - have no arguments';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 3, 4, 5, true ], 3, () => 3 ) );

  test.case = 'evaluator is wrong - have three arguments';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a, b, c ) => _.typeOf( a ) === _.typeOf( b ) === _.typeOf( c ) ) );

  test.case = 'evaluator2 is unnacessary';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a, b ) => _.typeOf( a ) === _.typeOf( b ), ( e ) => e ) );

  test.case = 'evaluator2 is wrong - have no arguments';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a ) => a, () => e ) );

  test.case = 'fourth argument is wrong - have two arguments';
  test.shouldThrowErrorSync( () => _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a ) => a, ( a, b ) => e ) );
};

//

function arrayCountTotal( test )
{
  /* constructors */

  var array = ( src ) => _.arrayMake( src );
  var unroll = ( src ) => _.unrollMake( src );
  var argumentsArray = ( src ) => src === null ? _.argumentsArrayMake( [] ) : _.argumentsArrayMake( src );
  var bufferTyped = function( buf )
  {
    let name = buf.name;
    return { [ name ] : function( src ){ return new buf( src ) } } [ name ];
  };

  /* lists */

  var listTyped =
  [
    I8x,
    // U8x,
    // U8ClampedX,
    // I16x,
    U16x,
    // I32x,
    // U32x,
    F32x,
    F64x,
  ];
  var list =
  [
    array,
    unroll,
    argumentsArray,
  ];
  for( let i = 0; i < listTyped.length; i++ )
  list.push( bufferTyped( listTyped[ i ] ) );

  /* tests */

  for( let i = 0; i < list.length; i++ )
  {
    test.open( list[ i ].name );
    run( list[ i ] );
    test.close( list[ i ].name );
  }

  /* - */

  function run( makeLong )
  {
    /* zero */

    test.case = 'empty array';
    var src = makeLong( [] );
    var got = _.arrayCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'several nulls';
    var src = makeLong( [ null, null, null ] );
    var got = _.arrayCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'several zeros';
    var src = makeLong( [ 0, 0, 0, 0 ] );
    var got = _.arrayCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'mix of nulls and zeros';
    var src = makeLong( [ 0, null, null, 0, 0, 0, null ] );
    var got = _.arrayCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    /* array elements are numbers */

    test.case = 'sum of no repeated elements';
    var src = makeLong( [ 1, 3, 5, 7, 9, 1, 3 ] );
    var got = _.arrayCountTotal( src );
    var expected = 29;
    test.identical( got, expected );

    /* array elements are booleans */

    test.case = 'all true';
    var src = makeLong( [ true, true, true, true ] );
    var got = _.arrayCountTotal( src );
    var expected = 4;
    test.identical( got, expected );

    test.case = 'all false';
    var src = makeLong( [ false, false, false, false, false ] );
    var got = _.arrayCountTotal( src );
    var expected = 0;
    test.identical( got, expected );

    test.case = 'mix of true and false';
    var src = makeLong( [ false, false, true, false, true, false, false, true ] );
    var got = _.arrayCountTotal( src );
    var expected = 3;
    test.identical( got, expected );

    /* array elements are numbers and booleans */

    test.case = 'all true and numbers';
    var src = makeLong( [ true, 2, 1, true, true, 0, true ] );
    var got = _.arrayCountTotal( src );
    var expected = 7;
    test.identical( got, expected );

    test.case = 'all false and numbers';
    var src = makeLong( [ 1, false, 0, false, false, 4, 3, false, false ] );
    var got = _.arrayCountTotal( src );
    var expected = 8;
    test.identical( got, expected );

    test.case = 'mix of true, false, numbers and null';
    var src = makeLong( [ null, false, false, 0, true, null, false, 10, true, false, false, true, 2, null ] );
    var got = _.arrayCountTotal( src );
    var expected = 15;
    test.identical( got, expected );

    /* array has negative numbers */

    if( !_.bufferTypedIs( makeLong( 0 ) ) )
    {
      test.case = 'numbers, negative result';
      var src = makeLong( [ 2, -3, 4, -4, 6, -7 ] );
      var got = _.arrayCountTotal( src );
      var expected = -2;
      test.identical( got, expected );

      test.case = 'mix of true, false, numbers and null - negative result';
      var src = makeLong( [ null, false, false, 0, true, null, -8, false, 10, true, false, -9, false, true, 2, null ] );
      var got = _.arrayCountTotal( src );
      var expected = -2;
      test.identical( got, expected );
    }
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayCountTotal() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayCountTotal( [ 1, 2, -3, 13 ], [] ) );

  test.case = 'wrong type of srcArray';
  test.shouldThrowErrorSync( () => _.arrayCountTotal( undefined ) );
  test.shouldThrowErrorSync( () => _.arrayCountTotal( null ) );
  test.shouldThrowErrorSync( () => _.arrayCountTotal( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.arrayCountTotal( 3 ) );

  test.case = 'srcArray contains strings';
  test.shouldThrowErrorSync( () => _.arrayCountTotal( [ 1, '2', 3, 'a' ] ) );

  test.case = 'srcArray contains arrays';
  test.shouldThrowErrorSync( () => _.arrayCountTotal( [ 1, [ 2 ], 3, [ null ] ] ) );
};

//

function arrayCountUnique( test )
{

  test.case = 'nothing';
  var got = _.arrayCountUnique( [  ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'nothing';
  var got = _.arrayCountUnique( [ 1, 2, 3, 4, 5 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'three pairs';
  var got = _.arrayCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ] );
  var expected = 3;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCountUnique();
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ], function( e ) { return e }, 'redundant argument' );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCountUnique( 'wrong argument', function( e ) { return e } );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ], 'wrong argument' );
  });

};

// //
//
// function arraySum( test )
// {
//
//   test.case = 'nothing';
//   var got = _.arraySum( [  ] );
//   var expected = 0;
//   test.identical( got, expected );
//
//   test.case = 'returns sum';
//   var got = _.arraySum( [ 1, 2, 3, 4, 5 ] );
//   var expected = 15;
//   test.identical( got, expected );
//
//   test.case = 'returns sum';
//   var got = _.arraySum( [ true, false, 13, '33' ], function( e ) { return e * 2 } );
//   var expected = 94;
//   test.identical( got, expected );
//
//   test.case = 'converts and returns sum';
//   var got = _.arraySum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 } );
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
//     _.arraySum();
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arraySum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 }, 'redundant argument' );
//   });
//
//   test.case = 'first argument is wrong';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arraySum( 'wrong argument', function( e ) { return e / 2 } );
//   });
//
//   test.case = 'second argument is wrong';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arraySum( [ 1, 2, 3, 4, 5 ], 'wrong argument' );
//   });
//
// };

// ---
// array transformation
// ---

function arrayPrepend( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrepend( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'dstArray is empty';

  var dst = [];
  var got = _.arrayPrepend( dst, null );
  test.identical( got, [ null ] );
  test.is( got === dst );

  var dst = [];
  var got = _.arrayPrepend( dst, undefined );
  test.identical( got, [ undefined ] );
  test.is( got === dst );

  var dst = [];
  var got = _.arrayPrepend( dst, 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [];
  var got = _.arrayPrepend( dst, '1' );
  test.identical( got, [ '1' ] );
  test.is( got === dst );

  var dst = [];
  var got = _.arrayPrepend( dst, [ 1, 2 ] );
  test.identical( got, [ [ 1, 2 ] ] );
  test.is( got === dst );

  test.case = 'simple';

  var dst = [ 1 ];
  var got = _.arrayPrepend( dst, 1 );
  test.identical( got, [ 1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrepend( dst, 2 );
  test.identical( got, [ 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrepend( dst, 3 );
  test.identical( got, [ 3, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrepend( dst, '1' );
  test.identical( got, [ '1', 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrepend( dst, undefined );
  test.identical( got, [ undefined, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrepend( dst, -1 );
  test.identical( got, [ -1, 1 ] );
  test.is( got === dst );

  test.case = 'Array prepended as an element';

  var dst = [ 1 ];
  var got = _.arrayPrepend( dst, [ 1 ] );
  test.identical( got, [ [ 1 ], 1 ] );
  test.is( got === dst );

  var dst = [ 'Choose an option' ];
  var got = _.arrayPrepend( dst, [ 1, 0, - 1 ] );
  test.identical( got, [ [ 1, 0, -1 ], 'Choose an option' ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrepend();
  })

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrepend( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrepend( 1, 1 );
  })
}

//

function arrayPrependOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependOnce( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependOnce( dst, 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnce( dst, 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnce( dst, 2 );
  test.identical( got, [ 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependOnce( dst, 3 );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnce( dst, '1' );
  test.identical( got, [ '1', 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnce( dst, -1 );
  test.identical( got, [ -1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnce( dst, [ 1 ] );
  test.identical( got, [ [ 1 ], 1 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayPrependOnce( dst, 4, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayPrependOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependOnce( 1, 1, 1 );
  })

}

//

function arrayPrependOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependOnceStrictly( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependOnceStrictly( dst , 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnceStrictly( dst, 2 );
  test.identical( got, [ 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnceStrictly( dst, '1' );
  test.identical( got, [ '1', 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnceStrictly( dst, -1 );
  test.identical( got, [ -1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependOnceStrictly( dst, [ 1 ] );
  test.identical( got, [ [ 1 ], 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 2, 3, 3 ];
  var got = _.arrayPrependOnceStrictly( dst, 0 );
  test.identical( got, [ 0, 1, 2, 2, 3, 3 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayPrependOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  // test.case = 'onEqualize is not a routine';

  // test.shouldThrowErrorSync( function()
  // {
  //    _.arrayPrependOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  // });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayPrependOnceStrictly( dst, { num : 1 }, onEqualize );
  });

}

//

function arrayPrepended( test )
{

  test.case = 'dstArray is empty';

  var dst = [];
  var got = _.arrayPrepended( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [];
  var got = _.arrayPrepended( dst, null );
  test.identical( dst, [ null ] );
  test.identical( got, 0 );

  var dst = [];
  var got = _.arrayPrepended( dst, undefined );
  test.identical( dst, [ undefined ] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [ 1 ];
  var got = _.arrayPrepended( dst, 1 );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrepended( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrepended( dst, 3 );
  test.identical( dst, [ 3, 1, 2, 3 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrepended( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrepended( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, 0 );

  test.case = 'Array prepended as an element';

  var dst = [ 1 ];
  var got = _.arrayPrepended( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, 0 );

  var dst = [ 'Choose an option' ];
  var got = _.arrayPrepended( dst, [ 1, 0, - 1 ] );
  test.identical( dst, [ [ 1, 0, -1 ], 'Choose an option' ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrepended();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrepended( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrepended( 1, 1 );
  });
}

//

function arrayPrependedOnce( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnce( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedOnce( dst, 3 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnce( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnce( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnce( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, 0 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedOnce( dst, 4, onEqualize );
  test.identical( dst, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayPrependedOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedOnce();
  })

  test.case = 'fourth is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedOnce( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedOnce( 1, 1 );
  })
}

//

function arrayPrependedOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedOnceStrictly( dst , 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnceStrictly( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnceStrictly( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnceStrictly( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 2, 3, 3 ];
  var got = _.arrayPrependedOnceStrictly( dst, 0 );
  test.identical( dst, [ 0, 1, 2, 2, 3, 3 ] );
  test.identical( got, 0 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayPrependedOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayPrependedOnceStrictly( dst, { num : 1 }, onEqualize );
  });

}

//

function arrayPrependElement( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependElement( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependElement( dst, 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElement( dst, 1 );
  test.identical( got, [ 1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElement( dst, 2 );
  test.identical( got, [ 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependElement( dst, 3 );
  test.identical( got, [ 3, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElement( dst, '1' );
  test.identical( got, [ '1', 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElement( dst, -1 );
  test.identical( got, [ -1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElement( dst, [ 1 ] );
  test.identical( got, [ [ 1 ], 1 ] );
  test.is( got === dst );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElement();
  })

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElement( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElement( 1, 1 );
  })
}

//

function arrayPrependElementOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependElementOnce( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [ ];
  var got = _.arrayPrependElementOnce( dst, 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnce( dst, 2 );
  test.identical( got, [ 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnce( dst, '1' );
  test.identical( got, [ '1', 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnce( dst, -1 );
  test.identical( got, [ -1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnce( dst, [ 1 ] );
  test.identical( got, [ [ 1 ], 1 ] );
  test.is( got === dst );

  test.case = 'ins already in srcArray';

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnce( dst, 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependElementOnce( dst, 3 );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ true, false, true ];
  var got = _.arrayPrependElementOnce( dst, false );
  test.identical( got, [ true, false, true ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayPrependElementOnce( dst, 4, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayPrependElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElementOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElementOnce( 1, 1, 1 );
  })

}

//

function arrayPrependElementOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependElementOnceStrictly( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'dstArray is null';
  var got = _.arrayPrependElementOnceStrictly( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependElementOnceStrictly( dst , 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnceStrictly( dst, 2 );
  test.identical( got, [ 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnceStrictly( dst, '1' );
  test.identical( got, [ '1', 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnceStrictly( dst, -1 );
  test.identical( got, [ -1, 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayPrependElementOnceStrictly( dst, [ 1 ] );
  test.identical( got, [ [ 1 ], 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 2, 3, 3 ];
  var got = _.arrayPrependElementOnceStrictly( dst, 0 );
  test.identical( got, [ 0, 1, 2, 2, 3, 3 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependElementOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayPrependElementOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayPrependElementOnceStrictly( dst, { num : 1 }, onEqualize );
  });

}

//

function arrayPrependedElement( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedElement( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, 1 );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedElement( dst, 3 );
  test.identical( dst, [ 3, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, [ 1 ] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElement();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElement( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElement( 1, 1 );
  });
}

//

function arrayPrependedElementOnce( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedElementOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnce( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 2 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnce( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnce( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnce( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'ins already in dstArray';

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, undefined );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedElementOnce( dst, 3 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, undefined );

  var dst = [ false, true, false, true ];
  var got = _.arrayPrependedElementOnce( dst, true );
  test.identical( dst, [ false, true, false, true ] );
  test.identical( got, undefined );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, { num : 4 } );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, undefined );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedElementOnce( dst, 4, onEqualize );
  test.identical( dst, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 4 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayPrependedElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, undefined );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElementOnce();
  })

  test.case = 'fourth is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElementOnce( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElementOnce( 1, 1 );
  })
}

//

function arrayPrependedElementOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedElementOnceStrictly( dst , 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnceStrictly( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 2 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnceStrictly( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnceStrictly( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElementOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, [ 1 ] );

  var dst = [ 1, 2, 2, 3, 3 ];
  var got = _.arrayPrependedElementOnceStrictly( dst, 0 );
  test.identical( dst, [ 0, 1, 2, 2, 3, 3 ] );
  test.identical( got, 0 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 }, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, { num : 4 } );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedElementOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ 4, { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 4 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayPrependedElementOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayPrependedElementOnceStrictly( dst, { num : 1 }, onEqualize );
  });

}

//

function arrayPrependArray( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependArray( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';
  var got = _.arrayPrependArray( [], [] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayPrependArray( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependArray( dst, [ 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependArray( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependArray( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [  'a', 1, [ { a : 1 } ], { b : 2 }, 1  ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArray( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayPrependArray( dst, [ undefined, 2 ] );
  test.identical( dst, [ undefined, 2, 1 ] );
  test.is( got === dst );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArray( dst, dst );
  test.identical( got, [ 1,2,3,1,2,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArray();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArray( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArray( [ 1, 2 ], 2 );
  });
};

//

function arrayPrependArrayOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependArrayOnce( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayPrependArrayOnce( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependArrayOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependArrayOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependArrayOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', [ { a : 1 } ], { b : 2 }, 1  ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArrayOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependArrayOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ undefined, 2, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArrayOnce( dst, dst );
  test.identical( got, [ 1,2,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArrayOnce( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArrayOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArrayOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArrayOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArrayOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayPrependArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });
}

//

function arrayPrependArrayOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependArrayOnceStrictly( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayPrependArrayOnceStrictly( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependArrayOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependArrayOnceStrictly( dst, [ 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayPrependArrayOnceStrictly( dst, [ 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3, 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArrayOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependArrayOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ undefined, 2, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArrayOnceStrictly( dst, dst ) );
  else
  _.arrayPrependArrayOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArrayOnceStrictly( dst, dst ) );
  else
  _.arrayPrependArrayOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e ) );
  else
  _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'one of elements is not unique';

  var dst = [ 1, 2, 3 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArrayOnceStrictly( dst, [ 4, 5, 2 ] );
  })
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );

  var dst = [ 1, 1, 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArrayOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayPrependArrayOnceStrictly( [ 1, 2 ], [ 2 ], 3 );
  // });
}

//

function arrayPrependedArray( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayPrependedArray( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArray( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArray( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 2, 4, 5, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArray( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1, 1 ] );
  test.identical( got, 1 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArray( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 }, 1  ] );
  test.identical( got, 4 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependedArray( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependedArray( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ undefined, 2, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArray( dst, dst );
  test.identical( got, 3 );
  test.identical( dst, [ 1,2,3,1,2,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArray();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArray( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArray( [ 1, 2 ], 2 );
  });

}

//

function arrayPrependedArrayOnce( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayPrependedArrayOnce( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArrayOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArrayOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArrayOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', [ { a : 1 } ], { b : 2 }, 1  ] );
  test.identical( got, 3 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependedArrayOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependedArrayOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ undefined, 2, 1 ] );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrayOnce( dst, dst );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrayOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrayOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrayOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrayOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 6 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayPrependedArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });
}

//

function arrayPrependedArrayOnceStrictly( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayPrependedArrayOnceStrictly( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArrayOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only if all elements are unique';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArrayOnceStrictly( dst, [ 3.5, 4, 5 ] );
  test.identical( dst, [ 3.5, 4, 5, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArrayOnceStrictly( dst, [ 0 ] );
  test.identical( dst, [ 0, 1, 1, 1 ] );
  test.identical( got, 1 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArrayOnceStrictly( dst, [ 'a', 0, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', 0, [ { a : 1 } ], { b : 2 }, 1  ] );
  test.identical( got, 4 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependedArrayOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependedArrayOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ undefined, 2, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArrayOnceStrictly( dst, dst ) );
  else
  {
    var got = _.arrayPrependedArrayOnceStrictly( dst, dst );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArrayOnceStrictly( dst, dst ) );
  else
  {
    var got = _.arrayPrependArrayOnceStrictly( dst, dst );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArrayOnceStrictly( dst, dst, ( e ) => e ) );
  else
  {
    var got = _.arrayPrependedArrayOnceStrictly( dst, dst, ( e ) => e )
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  {
    var got = _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'One of args is not unique';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 1, 1 ], [ 1 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 2, 3 ], [ 2, 4, 5 ] );
  });

}

// --
//arrayPrependElement*Arrays*
// --

function arrayPrependArrays( test )
{

  test.case = 'dstArray is null';
  var got = _.arrayPrependArrays( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';
  var got = _.arrayPrependArrays( [], [] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayPrependArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3, 2, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependArrays( dst, [ 4, 5 ] );
  test.identical( dst, [ 5, 4, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependArrays( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.is( got === dst );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4 ] ] ];
  var got = _.arrayPrependArrays( dst, insArray );
  test.identical( dst, [ 3, [ 4 ], 2, 1 ] );
  test.is( got === dst );

  var dst = [];
  var insArray = [ 1, 2, 3 ]
  var got = _.arrayPrependArrays( dst, insArray );
  test.identical( dst, [ 3, 2, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayPrependArrays( dst, insArray );
  test.identical( dst, [  { b : 2 }, { a : 1 }, 1, 'a', 1 ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got;
  var got = _.arrayPrependArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 2, undefined, 1 ] );
  test.is( got === dst );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArrays( dst, dst );
  test.identical( got, [ 1,2,3,1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArrays( dst, [ dst ] );
  test.identical( got, [ 1,2,3,1,2,3 ] );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArrays( dst, [ [ 4, 5, 6 ], [ 7, 8, 9 ] ] );
  test.identical( dst, [ 7, 8, 9, 4, 5, 6, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArrays( dst, [ 4,5,6 ] );
  test.identical( dst, [ 6, 5, 4, 1, 2, 3  ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrays( 1, [ 2 ] );
  });

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrays( [], 2 );
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArrays( [], [ 1 ], [ 2 ] );
  });

}

//

function arrayPrependArraysOnce( test )
{

  test.case = 'dstArray is null';
  var got = _.arrayPrependArraysOnce( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayPrependArraysOnce( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3, 2, 1 ] );
  test.is( got === dst );

  test.case = 'should keep sequence';

  var dst = [ 6 ];
  var src = [ [ 1, 2 ], 3, [ 6, 4, 5, 1, 2, 3 ] ];
  var srcCopy = [ [ 1, 2 ], 3, [ 6, 4, 5, 1, 2, 3 ] ];
  var got = _.arrayPrependArraysOnce( dst, src );
  test.identical( dst, [ 4, 5, 3, 1, 2, 6 ] );
  test.identical( src, srcCopy );
  test.is( got === dst );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 5, 4, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependArraysOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ { 'b' : 2 }, { 'a' : 1 }, 'a', 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4 ], 5 ] ];
  var got = _.arrayPrependArraysOnce( dst, insArray );
  test.identical( dst, [ [ 4 ], 5, 1, 2, 3, 4 ] );
  test.is( got === dst );

  var dst = [ 1, 3 ];
  var got = _.arrayPrependArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( got, [ 2, 1, 3 ] );
  test.identical( dst, got );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ [ 4, 5, 6 ], [ 7, 8, 9 ] ] );
  test.identical( dst, [ 7, 8, 9, 4, 5, 6, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ [ 4, 5, 6 ], [ 1, 2, 9 ] ] );
  test.identical( dst, [ 9, 4, 5, 6, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ 4,5,6 ] );
  test.identical( dst, [ 6, 5, 4, 1, 2, 3  ] );
  test.is( got === dst );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 1, 3 ];
  var got = _.arrayPrependArraysOnce( dst, [ 1, 2, 3 ], onEqualize );
  test.identical( got, [ 2, 1, 3 ] );
  test.identical( dst, got );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArraysOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependArraysOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 2, undefined, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnce( dst, dst );
  test.identical( got, [ 1,2,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ dst ] );
  test.identical( got, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 3, 3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ dst,dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnce( [], [ 1, 2, 3 ], {} );
  });

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnce( [], 2 );
  });

}

//

function arrayPrependArraysOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependArraysOnceStrictly( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayPrependArraysOnceStrictly( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3, 2, 1 ] );
  test.is( got === dst );

  test.case = 'should keep sequence';

  var dst = [ 6 ];
  var src = [ [ 1, 2 ], 3, [ 4, 5 ] ];
  var srcCopy = [ [ 1, 2 ], 3, [ 4, 5 ] ];
  var got = _.arrayPrependArraysOnceStrictly( dst, src );
  test.identical( dst, [ 4, 5, 3, 1, 2, 6 ] );
  test.identical( src, srcCopy );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ [ 'a' ], [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayPrependArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ { b : 2 },{ a : 1 }, 'a', 1  ] );
  test.is( got === dst );

  var dst = [ 0 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ] ] ];
  var got = _.arrayPrependArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 3, [ 4, [ 5 ] ], 2, 1, 0] );
  test.is( got === dst );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ [ 4, 5, 6 ], [ 7, 8, 9 ] ] );
  test.identical( dst, [ 7, 8, 9, 4, 5, 6, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ 4,5,6 ] );
  test.identical( dst, [ 6, 5, 4, 1, 2, 3  ] );
  test.is( got === dst );

  var dst = [ 4, 5 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ 1, 2, 3 ], onEqualize )
  test.identical( got, [ 3, 2, 1, 4, 5 ] );
  test.identical( dst, got );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 2, undefined, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, dst ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, dst ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, [ dst ], ( e ) => e ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e ) );
  else
  _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 3, 3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3, 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ dst, dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnceStrictly();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnceStrictly( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnceStrictly( [], [ 1, 2, 3 ], {} );
  });

  test.case = 'Same element in insArray and in dstArray';
  var dst = [ 1, 2, 3 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, [ 4, 2, 5 ] );
  })
  test.identical( dst, [ 5, 4, 1, 2, 3 ] )

  var dst = [ 1, 1, 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependArraysOnceStrictly( [], 2 );
  });
}

//

function arrayPrependedArrays( test )
{
  test.case = 'nothing';
  var dst = [];
  var got = _.arrayPrependedArrays( dst, [] );
  var expected = [ ];
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayPrependedArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3, 2, 1 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArrays( dst, [ 4, 5 ] );
  test.identical( dst, [ 5, 4, 1, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArrays( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.identical( got, 2 );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4 ], 5 ] ];
  var got = _.arrayPrependedArrays( dst, insArray );
  test.identical( dst,  [ 3, [ 4 ], 5, 2, 1 ] );
  test.identical( got, 5 );

  var dst = [];
  var got = _.arrayPrependedArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3, 2, 1 ] );
  test.identical( got, 3 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArrays( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ { b : 2 }, { a : 1 }, 1, 'a', 1 ] );
  test.identical( got, 4 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependedArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got;
  var got = _.arrayPrependedArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 2, undefined, 1 ] );
  test.identical( got, 2 );

  test.case = 'dst === ins';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrays( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === ins';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArrays( dst, [ dst ] );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === ins';
  var dst = [ 1,1,2,2 ];
  var got = _.arrayPrependedArrays( dst, [ dst, dst ] );
  test.identical( dst, [ 1,1,2,2,1,1,2,2,1,1,2,2,1,1,2,2 ] );
  test.identical( got, 12);

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArrays( dst, [ [ 4, 5, 6 ], [ 7, 8, 9 ] ] );
  test.identical( dst, [ 7, 8, 9, 4, 5, 6, 1, 2, 3 ] );
  test.identical( got, 6 );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArrays( dst, [ 4,5,6 ] );
  test.identical( dst, [ 6, 5, 4, 1, 2, 3  ] );
  test.identical( got, 3 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrays( 1, [ 2 ] );
  });

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrays( [], 2 );
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArrays( [], [ 1 ], [ 2 ] );
  });

}

//

function arrayPrependedArraysOnce( test )
{

  test.case = 'nothing';

  var dst = [];
  var got = _.arrayPrependedArraysOnce( dst, [] );
  var expected = [];
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3,2,1 ] );
  test.identical( got, 3 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3,2,1 ] );
  test.identical( got, 3 );

  test.case = 'should keep sequence';

  var dst = [ 6 ];
  var src = [ [ 1, 2 ], 3, [ 6, 4, 5, 1, 2, 3 ] ];
  var srcCopy = [ [ 1, 2 ], 3, [ 6, 4, 5, 1, 2, 3 ] ];
  var got = _.arrayPrependedArraysOnce( dst, src );
  test.identical( dst, [ 4, 5, 3, 1, 2, 6 ] );
  test.identical( src, srcCopy );
  test.identical( got, 5 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 5, 4, 1, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ { 'b' : 2 }, { 'a' : 1 }, 'a', 1  ] );
  test.identical( got, 3 );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ] ] ];
  var got = _.arrayPrependedArraysOnce( dst, insArray );
  test.identical( dst, [ 3, [ 4, [ 5 ] ], 2, 1] );
  test.identical( got, 4 );

  var dst = [ 1, 3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 2, 1, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ [ 4, 5, 6 ], [ 7, 8, 9 ] ] );
  test.identical( dst, [ 7, 8, 9, 4, 5, 6, 1, 2, 3 ] );
  test.identical( got, 6 );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 4,5,6 ] );
  test.identical( dst, [ 6, 5, 4, 1, 2, 3  ] );
  test.identical( got, 3 );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }
  var dst = [ 1, 3 ];
  var insArray = [ 1, 2, 3 ]
  var got = _.arrayPrependedArraysOnce( dst, insArray, onEqualize );
  test.identical( dst, [ 2, 1, 3 ] );
  test.identical( got, 1 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependedArraysOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependedArraysOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 2, undefined, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArraysOnce( dst, dst );
  test.identical( dst, [ 1,2,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ dst ] );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 3, 3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ dst,dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3 ] );
  test.identical( got, 18 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnce();
  });

  // test.case = 'dst is not a array';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayPrependedArraysOnce( 1, [ 2 ] );
  // });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnce( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnce( [ 1 ], 2 );
  });

}

//

function arrayPrependedArraysOnceStrictly( test )
{

  test.case = 'nothing';

  var dst = [];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [] );
  var expected = [];
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3,2,1 ] );
  test.identical( got, 3 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3,2,1 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 4, 5, 6 ] );
  test.identical( dst, [ 6, 5, 4, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 0, 0, 0 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ 1, 0, 0, 0 ] );
  test.identical( got, 1 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 'a', 0, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ { 'b' : 2 }, { 'a' : 1 }, 0, 'a',  1 ] );
  test.identical( got, 4 );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ] ] ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 3, [ 4, [ 5 ] ], 2, 1 ] );
  test.identical( got, 4 );

  var dst = [ '1', '3' ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 3, 2, 1, '1', '3' ] );
  test.identical( got, 3 );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }
  var dst = [ 1, 3 ];
  var insArray = [ 0, 2, 4 ]
  var got = _.arrayPrependedArraysOnceStrictly( dst, insArray, onEqualize );
  test.identical( dst, [ 4, 2, 0, 1, 3 ] );
  test.identical( got, 3 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayPrependedArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependedArraysOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 2, undefined, 1 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, dst ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, dst ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, [ dst ], ( e ) => e ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayPrependedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e ) );
  else
  _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 3, 3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ dst, dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 18 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnceStrictly();
  });

  // test.case = 'dst is not a array';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayPrependedArraysOnceStrictly( 1, [ 2 ] );
  // }); sfkldb fiubds lkfbds gbkdsfb gkldsfg fdsbfkldsfbdsl gbjs, fn kgn d

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnceStrictly( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 1 ], 2 );
  });

  test.case = 'Elements must be unique';

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 1, 1, 1 ], [ [ 1 ] ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 1, 2, 3 ], [ [ 4, 5 ], 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 6 ], [ [ 1, 2 ], 3, [ 6, 4, 5, 1, 2, 3 ] ] );
  });

}

//

function arrayAppend( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppend( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var got = _.arrayAppend( [], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayAppend( [ 1 ], 1 );
  test.identical( got, [ 1, 1 ] );

  var got = _.arrayAppend( [ 1 ], 2 );
  test.identical( got, [ 1, 2 ] );

  var got = _.arrayAppend( [ 1, 2, 3 ], 3 );
  test.identical( got, [ 1, 2, 3, 3 ] );

  var got = _.arrayAppend( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppend( [ 1 ], -1 );
  test.identical( got, [  1, -1 ] );

  var got = _.arrayAppend( [ 1 ], [ 1 ] );
  test.identical( got, [  1, [ 1 ] ] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppend();
  })

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppend( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppend( 1, 1 );
  })
}

//

function arrayAppendOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendOnce( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var got = _.arrayAppendOnce( [], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayAppendOnce( [ 1 ], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayAppendOnce( [ 1 ], 2 );
  test.identical( got, [ 1, 2 ] );

  var got = _.arrayAppendOnce( [ 1, 2, 3 ], 3 );
  test.identical( got, [ 1, 2, 3 ] );

  var got = _.arrayAppendOnce( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppendOnce( [ 1 ], -1 );
  test.identical( got, [ 1, -1 ] );

  var got = _.arrayAppendOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayAppendOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnce( 1, 1, 1 );
  })
}

//

function arrayAppendOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendOnceStrictly( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendOnceStrictly( dst , 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, 2 );
  test.identical( got, [ 1, 2 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, '1' );
  test.identical( got, [ 1, '1' ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, -1 );
  test.identical( got, [ 1, -1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  // test.case = 'onEqualize is not a routine';

  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayAppendOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  // });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayAppendOnceStrictly( dst, { num : 1 }, onEqualize );
  });

}

//

function arrayAppended( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppended( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayAppended( dst, 1 );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppended( dst, 2 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppended( dst, 3 );
  test.identical( dst, [ 1, 2, 3, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1 ];
  var got = _.arrayAppended( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppended( dst, -1 );
  test.identical( dst, [ 1, -1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppended( dst, [ 1 ] );
  test.identical( dst, [ 1, [ 1 ] ] );
  test.identical( got, 1 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppended();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppended( [], 1, 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppended( 1, 1 );
  });
}

//

function arrayAppendedOnce( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, 2 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedOnce( dst, 3 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, -1 );
  test.identical( dst, [ 1, -1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, [ 1 ] ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );
  test.identical( got, 3 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );
  test.identical( got, 3 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayAppendedOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnce();
  })

  test.case = 'third is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnce( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnce( 1, 1, 1 );
  })
}

//

function arrayAppendedOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedOnceStrictly( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnceStrictly( dst, 2 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnceStrictly( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnceStrictly( dst, -1 );
  test.identical( dst, [ 1, -1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ 1, [ 1 ] ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );
  test.identical( got, 3 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );
  test.identical( got, 3 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly();
  })

  test.case = 'third is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly( 1, 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayAppendedOnceStrictly( dst, { num : 1 }, onEqualize );
  });
}

//

function arrayAppendElement( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendElement( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var got = _.arrayAppendElement( [], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayAppendElement( [ 1 ], 1 );
  test.identical( got, [ 1, 1 ] );

  var got = _.arrayAppendElement( [ 1 ], 2 );
  test.identical( got, [ 1, 2 ] );

  var got = _.arrayAppendElement( [ 1, 2, 3 ], 3 );
  test.identical( got, [ 1, 2, 3, 3 ] );

  var got = _.arrayAppendElement( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppendElement( [ 1 ], -1 );
  test.identical( got, [  1, -1 ] );

  var got = _.arrayAppendElement( [ 1 ], [ 1 ] );
  test.identical( got, [  1, [ 1 ] ] );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElement();
  })

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElement( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElement( 1, 1 );
  })
}

//

function arrayAppendElementOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendElementOnce( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var got = _.arrayAppendElementOnce( [], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayAppendElementOnce( [ 1 ], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayAppendElementOnce( [ 1 ], 2 );
  test.identical( got, [ 1, 2 ] );

  var got = _.arrayAppendElementOnce( [ 1, 2, 3 ], 3 );
  test.identical( got, [ 1, 2, 3 ] );

  var got = _.arrayAppendElementOnce( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppendElementOnce( [ 1 ], -1 );
  test.identical( got, [ 1, -1 ] );

  var got = _.arrayAppendElementOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendElementOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayAppendElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnce( 1, 1, 1 );
  })
}

//

function arrayAppendElementOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendElementOnceStrictly( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendElementOnceStrictly( dst , 1 );
  test.identical( got, [ 1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, 2 );
  test.identical( got, [ 1, 2 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, '1' );
  test.identical( got, [ 1, '1' ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, -1 );
  test.identical( got, [ 1, -1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendElementOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendElementOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  // test.case = 'onEqualize is not a routine';

  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayAppendOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  // });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayAppendElementOnceStrictly( dst, { num : 1 }, onEqualize );
  });

}

//

function arrayAppendedElement( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedElement( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElement( dst, 1 );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElement( dst, 2 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedElement( dst, 3 );
  test.identical( dst, [ 1, 2, 3, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElement( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElement( dst, -1 );
  test.identical( dst, [ 1, -1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElement( dst, [ 1 ] );
  test.identical( dst, [ 1, [ 1 ] ] );
  test.identical( got, 1 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElement();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElement( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElement( 1, 1 );
  });
}

//

function arrayAppendedElementOnce( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedElementOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, false );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, 2 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedElementOnce( dst, 3 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, false );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, -1 );
  test.identical( dst, [ 1, -1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, [ 1 ] ] );
  test.identical( got, [ 1 ] );

  var dst = [ 0, 1, 2 ];
  var got = _.arrayAppendedElementOnce( dst, NaN );
  test.identical( dst, [ 0, 1, 2, NaN ] );
  test.identical( got, NaN );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );
  test.identical( got, { num : 4 } );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, false );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedElementOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );
  test.identical( got, 4 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayAppendedElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, false );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnce();
  })

  test.case = 'third is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnce( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnce( 1, 1, 1 );
  })
}

//

function arrayAppendedElementOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedElementOnceStrictly( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnceStrictly( dst, 2 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 2 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnceStrictly( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnceStrictly( dst, -1 );
  test.identical( dst, [ 1, -1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ 1, [ 1 ] ] );
  test.identical( got, [ 1 ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, { num : 4 } ] );
  test.identical( got, { num : 4 } );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedElementOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 }, 4 ] );
  test.identical( got, 4 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnceStrictly();
  })

  test.case = 'fourth is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedOnceStrictly( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnceStrictly( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnceStrictly( 1, 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedElementOnceStrictly( [ 1, 2, 3 ], 3 );
  });

  test.shouldThrowErrorSync( function()
  {
    var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayAppendedElementOnceStrictly( dst, { num : 1 }, onEqualize );
  });
}

// //
//
// function arrayAppendArray( test )
// {
//
//   test.case = 'nothing';
//   var got = _.arrayAppendArray( [  ] );
//   var expected = [  ];
//   test.identical( got, expected );
//
//   test.case = 'an argument';
//   var got = _.arrayAppendArray( [ 1, 2, undefined ] );
//   var expected = [ 1, 2, undefined ];
//   test.identical( got, expected );
//
//   test.case = 'an array';
//   var got = _.arrayAppendArray( [ 1, 2 ], 'str', false, { a : 1 }, 42, [ 3, 7, 13 ] );
//   var expected = [ 1, 2, 'str', false, { a : 1 }, 42, 3, 7, 13 ];
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
//     _.arrayAppendArray();
//   });
//
//   test.case = 'arguments[0] is wrong, has to be an array';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayAppendArray( 'wrong argument', 'str', false, { a : 1 }, 42, [ 3, 7, 13 ] );
//   });
//
//   test.case = 'arguments[1] is undefined';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayAppendArray( [ 1, 2 ], undefined, false, { a : 1 }, 42, [ 3, 7, 13 ] );
//   });
//
// };

//

function arrayAppendArray( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendArray( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';
  var got = _.arrayAppendArray( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayAppendArray( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendArray( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendArray( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayAppendArray( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [  1, 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArray( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayAppendArray( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1, undefined, 2 ] );
  test.is( got === dst );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendArray( dst, dst );
  test.identical( got, [ 1,2,3,1,2,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArray();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArray( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArray( [ 1, 2 ], 2 );
  });
};

//

function arrayAppendArrayOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendArrayOnce( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';
  var got = _.arrayAppendArrayOnce( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayAppendArrayOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'src array has duplicates';
  var dst = [ 1, 2, 3, 'str', 5 ];
  var got = _.arrayAppendArrayOnce( dst, [ 1, 1, 2, 2, 3, 3, 'str', 'str', 5 ] );
  test.identical( got, [ 1, 2, 3, 'str', 5 ] );
  test.is( got === dst );

  test.case = 'dst and src array has duplicates';
  var dst = [ 1, 1, 2, 2, 3, 3, 'str', 'str', 5, 5 ];
  var got = _.arrayAppendArrayOnce( dst, [ 1, 1, 2, 2, 3, 3, 'str', 'str', 5 ] );
  test.identical( got, [ 1, 1, 2, 2, 3, 3, 'str', 'str', 5, 5 ] );
  test.is( got === dst );

  test.case = 'appends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendArrayOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayAppendArrayOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 1, 'a', [ { a : 1 } ], { b : 2 } ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArrayOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendArrayOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendArrayOnce( dst, dst );
  test.identical( got, [ 1,2,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArrayOnce( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArrayOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArrayOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArrayOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArrayOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayAppendArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });

}

//

function arrayAppendArrayOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendArrayOnceStrictly( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayAppendArrayOnceStrictly( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendArrayOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendArrayOnceStrictly( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArrayOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendArrayOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArrayOnceStrictly( dst, dst ) );
  else
  _.arrayAppendArrayOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArrayOnceStrictly( dst, dst ) );
  else
  _.arrayAppendArrayOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArrayOnceStrictly( dst, dst, ( e ) => e ) );
  else
  _.arrayAppendArrayOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  _.arrayAppendArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'one of elements is not unique';

  var dst = [ 1, 2, 3 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArrayOnceStrictly( dst, [ 4, 5, 2 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );

  var dst = [ 1, 1, 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArrayOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayAppendArrayOnceStrictly( [ 1, 2 ], [ 2 ], 3 );
  // });
}

//

function arrayAppendedArray( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayAppendedArray( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedArray( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedArray( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 2, 4, 5 ] );
  test.identical( got, 3 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendedArray( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1, 1 ] );
  test.identical( got, 1 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayAppendedArray( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 1, 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( got, 4 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArray( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendedArray( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2, ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedArray( dst, dst );
  test.identical( got, 3 );
  test.identical( dst, [ 1,2,3,1,2,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArray();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArray( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArray( [ 1, 2 ], 2 );
  });
}

//

function arrayAppendedArrayOnce( test )
{

  test.case = 'nothing';

  var dst = [];
  var got = _.arrayAppendedArrayOnce( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedArrayOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendedArrayOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types';

  var dst = [ 1 ];
  var got = _.arrayAppendedArrayOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 1, 'a', [ { a : 1 } ], { b : 2 } ] );
  test.identical( got, 3 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendedArrayOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArrayOnce( dst, dst );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArrayOnce( dst, dst, ( e ) => e );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArrayOnce( dst, dst, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArrayOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArrayOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 6 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArrayOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayAppendedArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });

}

//

function arrayAppendedArrayOnceWithSelector( test )
{

  test.case = 'nothing, single equalizer';

  var dst = [];
  var got = _.arrayAppendedArrayOnce( dst, [], ( e ) => e.a );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple, single equalizer';

  var dst = [];
  var got = _.arrayAppendedArrayOnce( dst, [ { a : 1 }, { a : 2 }, { a : 3 } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 }, { a : 2 }, { a : 3 } ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements, single equalizer';

  var dst = [ { a : 1 }, { a : 2 }, { a : 3 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { a : 2 }, { a : 3 }, { a : 4 } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 }, { a : 2 }, { a : 3 }, { a : 4 } ] );
  test.identical( got, 1 );

  var dst = [ { a : 1 }, { a : 1 }, { a : 1 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { a : 1 } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 }, { a : 1 }, { a : 1 } ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types, single equalizer';

  var dst = [ { a : 1 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { a : 'a' }, { a : 1 }, { a : [{ y : 2 }] } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 }, { a : 'a' }, { a : [{ y : 2 }] } ] );
  test.identical( got, 2 );

  test.case = 'array has undefined, single equalizer';

  var dst = [ { a : 1 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { a : undefined }, { a : 2 } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 }, { a : undefined }, { a : 2 } ] );
  test.identical( got, 2 );

  var dst = [ { a : 1 }, { a : undefined } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { a : undefined }, { a : 2 } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 }, { a : undefined }, { a : 2 } ] );
  test.identical( got, 1 );

  /* */

  test.case = 'nothing, two equalizers';

  var dst = [];
  var got = _.arrayAppendedArrayOnce( dst, [], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple, two equalizers';

  var dst = [];
  var got = _.arrayAppendedArrayOnce( dst, [ { b : 1 }, { b : 2 }, { b : 3 } ], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [ { b : 1 }, { b : 2 }, { b : 3 } ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements, two equalizers';

  var dst = [ { a : 1 }, { a : 2 }, { a : 3 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { b : 2 }, { b : 3 }, { b : 4 } ], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [ { a : 1 }, { a : 2 }, { a : 3 }, { b : 4 } ] );
  test.identical( got, 1 );

  var dst = [ { a : 1 }, { a : 1 }, { a : 1 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { b : 1 } ], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [ { a : 1 }, { a : 1 }, { a : 1 } ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types, two equalizers';

  var dst = [ { a : 1 } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { b : 'a' }, { b : 1 }, { b : [{ y : 2 }] } ], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [ { a : 1 }, { b : 'a' }, { b : [{ y : 2 }] } ] );
  test.identical( got, 2 );

  test.case = 'array has undefined, two equalizers';

  var dst = [ { a : 1 } ];
  var got;
  test.mustNotThrowError( function ()
  {
    var got = _.arrayAppendedArrayOnce( dst, [ { b : undefined }, { b : 2 } ], ( e ) => e.a, ( e ) => e.b );
  });
  test.identical( dst, [ { a : 1 }, { b : undefined }, { b : 2 } ] );
  test.identical( got, 2 );

  var dst = [ { a : 1 }, { a : undefined } ];
  var got = _.arrayAppendedArrayOnce( dst, [ { b : undefined }, { b : 2 } ], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [ { a : 1 }, { b : undefined }, { b : 2 } ] );
  test.identical( got, 1 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArrayOnce( dst, undefined, ( e ) => e.a );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ], 2, ( e ) => e.a );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayAppendedArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });

}

//

function arrayAppendedArrayOnceStrictly( test )
{
  test.case = 'nothing';

  var got = _.arrayAppendedArrayOnceStrictly( [], [] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedArrayOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedArrayOnceStrictly( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.identical( got, 2 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArrayOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendedArrayOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArrayOnceStrictly( dst, dst ) );
  else
  {
    var got = _.arrayAppendedArrayOnceStrictly( dst, dst );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArrayOnceStrictly( dst, dst ) );
  else
  {
    var got = _.arrayPrependArrayOnceStrictly( dst, dst );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArrayOnceStrictly( dst, dst, ( e ) => e ) );
  else
  {
    var got = _.arrayAppendedArrayOnceStrictly( dst, dst, ( e ) => e )
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  {
    var got = _.arrayPrependArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'one of elements is not unique';

  var dst = [ 1, 2, 3 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArrayOnceStrictly( dst, [ 4, 5, 2 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );

  var dst = [ 1, 1, 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArrayOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

}

//

function arrayAppendArrays( test )
{

  test.case = 'dstArray is null, src is scalar';
  var got = _.arrayAppendArrays( null, 1 );
  test.identical( got, [ 1 ] );

  test.case = 'dstArray is null, src = array';
  var got = _.arrayAppendArrays( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  // test.case = 'dstArray is undefined, src is scalar';
  // var got = _.arrayAppendArrays( undefined, 1 );
  // test.identical( got, 1 );
  //
  // test.case = 'dstArray is undefined, src = array';
  // let src = [ 1 ];
  // var got = _.arrayAppendArrays( undefined, src );
  // test.identical( got, [ 1 ] );
  // test.is( src === got );

  test.case = 'nothing';
  var got = _.arrayAppendArrays( [], [] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayAppendArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendArrays( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendArrays( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 5 ] ] ]
  var got = _.arrayAppendArrays( dst, insArray );
  test.identical( dst, [ 1, 2, 3, 1, 2, 3, [ 5 ] ] );
  test.is( got === dst );

  test.case = 'arguments are not arrays';
  var dst = [];
  var got = _.arrayAppendArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayAppendArrays( dst, insArray );
  test.identical( dst, [  1, 'a', 1, { a : 1 }, { b : 2 } ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayAppendArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1, undefined, 2 ] );
  test.is( got === dst );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendArrays( dst, dst );
  test.identical( got, [ 1,2,3,1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendArrays( dst, [ dst ] );
  test.identical( got, [ 1,2,3,1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendArrays( dst, [ dst,dst ] );
  test.identical( got, [ 1,2,3,1,2,3, 1,2,3,1,2,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrays( 1, [ 2 ] );
  });

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrays( [], undefined );
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArrays( [], [ 1 ], [ 2 ] );
  });
};

//

function arrayAppendArraysOnce( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendArraysOnce( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayAppendArraysOnce( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayAppendArraysOnce( dst, insArray );
  test.identical( dst, [ 1, 'a', { a : 1 }, { b : 2 } ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 5 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ], 6 ] ];
  var got = _.arrayAppendArraysOnce( dst, insArray );
  test.identical( dst, [ 1, 2, 3, 5, [ 4, [ 5 ] ], 6 ] );
  test.is( got === dst );

  var dst = [ 1, 3 ];
  var got = _.arrayAppendArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( got, [ 1, 3, 2 ] );
  test.identical( dst, got );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 1, 3 ];
  var got = _.arrayAppendArraysOnce( dst, [ 1, 2, 3 ], onEqualize )
  test.identical( got, [ 1, 3, 2 ] );
  test.identical( dst, got );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendArraysOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendArraysOnce( dst, dst );
  test.identical( got, [ 1,2,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, [ dst ] );
  test.identical( got, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnce( dst, [ dst,dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnce( [], [ 1, 2, 3 ], [] );
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArraysOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

}

//

function arrayAppendArraysOnceStrictly( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendArraysOnceStrictly( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'nothing';

  var got = _.arrayAppendArraysOnceStrictly( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ [ 'a' ], [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayAppendArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 1, 'a', { a : 1 }, { b : 2 } ] );
  test.is( got === dst );

  var dst = [ 0 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ], 6 ] ];
  var got = _.arrayAppendArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 0, 1, 2, 3, [ 4, [ 5 ] ], 6 ] );
  test.is( got === dst );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 4, 5 ];
  var got = _.arrayAppendArraysOnceStrictly( dst, [ 1, 2, 3 ], onEqualize );
  test.identical( got, [ 4, 5, 1, 2, 3 ] );
  test.identical( dst, got );

  test.case = 'ins has existing element';

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () =>{ _.arrayAppendArraysOnceStrictly( dst, dst ) });
  else
  _.arrayAppendArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, dst ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, [ dst ], ( e ) => e ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e ) );
  else
  _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendArraysOnceStrictly( dst, [ dst, dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnceStrictly();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnceStrictly( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnceStrictly( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'One of ins elements is not unique';
  var dst = [ 1, 2, 3 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, [ 4, 2, 5 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] )

  var dst = [ 1, 1, 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendArraysOnceStrictly( [], 1 );
  });

}

//

function arrayAppendedArrays( test )
{
  test.case = 'nothing';
  var dst = [];
  var got = _.arrayAppendedArrays( dst, [] );
  var expected = [ ];
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayAppendedArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedArrays( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendedArrays( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, 5 ], 6 ] ];
  var got = _.arrayAppendedArrays( dst, insArray );
  test.identical( dst, [ 1, 2, 3, 1, 2, 3, [ 4, 5 ], 6 ] );
  test.identical( got, 5 );

  test.case = 'arguments are not arrays';
  var dst = [];
  var got = _.arrayAppendedArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayAppendedArrays( dst, insArray );
  test.identical( dst, [  1, 'a', 1, { a : 1 }, { b : 2 } ] );
  test.identical( got, 4 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayAppendedArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1, undefined, 2 ] );
  test.identical( got, 2 );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedArrays( dst, dst );
  test.identical( got, 3 );
  test.identical( dst, [ 1,2,3,1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedArrays( dst, [ dst ] );
  test.identical( got, 6 );
  test.identical( dst, [ 1,2,3,1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedArrays( dst, [ dst,dst ] );
  test.identical( got, 18 );
  test.identical( dst, [ 1,2,3,1,2,3,1,2,3,1,2,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrays( 1, [ 2 ] );
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrays( [], undefined );
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArrays( [], [ 1 ], [ 2 ] );
  });

}

//

function arrayAppendedArraysOnce( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayAppendedArraysOnce( dst, [] );
  var expected = [];
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayAppendedArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayAppendedArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayAppendedArraysOnce( dst, insArray );
  test.identical( dst, [  1, 'a', { a : 1 }, { b : 2 } ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3, 5 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ], 6 ] ];
  var got = _.arrayAppendedArraysOnce( dst, insArray );
  test.identical( dst, [ 1, 2, 3, 5, [ 4, [ 5 ] ], 6 ] );
  test.identical( got, 2 );

  var dst = [ 1, 3 ];
  var got = _.arrayAppendedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 3, 2 ] );
  test.identical( got, 1 );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 1, 3 ];
  var got = _.arrayAppendedArraysOnce( dst, [ 1, 2, 3 ], onEqualize );
  test.identical( dst, [ 1, 3, 2 ] );
  test.identical( got, 1 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendedArraysOnce( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedArraysOnce( dst, dst );
  test.identical( dst, [ 1,2,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, [ dst ] );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, dst, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [ 1,1,2,2,3,3 ] );
  test.identical( got, 0 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnce( dst, [ dst,dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3, 1,1,2,2,3,3 ] );
  test.identical( got, 18 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnce( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArraysOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnce( [], undefined );
  });

}

//

function arrayAppendedArraysOnceStrictly( test )
{
  test.case = 'nothing';

  var got = _.arrayAppendedArraysOnceStrictly( [], [] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayAppendedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ [ 'a' ], [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayAppendedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 1, 'a', { a : 1 }, { b : 2 } ] );
  test.identical( got, 3 );

  var dst = [ 0 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ], 6 ] ];
  var got = _.arrayAppendedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 0, 1, 2, 3, [ 4, [ 5 ] ], 6 ] );
  test.identical( got, 5 );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 4, 5 ];
  var got = _.arrayAppendedArraysOnceStrictly( dst, [ 1, 2, 3 ], onEqualize );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'ins has existing element';

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ 1, undefined, 2 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, dst ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, dst ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, [ dst ] ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, [ dst ], ( e ) => e ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e )
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayAppendedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e ) );
  else
  _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e)
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayAppendedArraysOnceStrictly( dst, [ dst, dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3,1,1,2,2,3,3 ] );
  test.identical( got, 18 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnceStrictly();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnceStrictly( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnceStrictly( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'One of ins elements is not unique';
  var dst = [ 1, 2, 3 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, [ 4, 2, 5 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] )

  var dst = [ 1, 1, 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowErrorSync( function()
  {
    _.arrayAppendedArraysOnceStrictly( [], 1 );
  });

}

// --
// arrayRemove
// --

function arrayRemove( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemove( dst, 1 );
  test.identical( dst, [ ] );

  var dst = [ 1 ];
  var got = _.arrayRemove( dst, 1 );
  test.identical( dst, [  ] );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemove( dst, 2 );
  test.identical( dst, [ 1 ] );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemove( dst, 1 );
  test.identical( dst, [ 2, 2 ] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemove( dst, 1 );
  test.identical( dst, [ ] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemove( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );

  var dst = [ 1 ];
  var got = _.arrayRemove( dst, '1' );
  test.identical( dst, [ 1 ] );

  var dst = [ 1 ];
  var got = _.arrayRemove( dst, -1 );
  test.identical( dst, [ 1 ] );

  var dst = [ 1 ];
  var got = _.arrayRemove( dst, [ 1 ] );
  test.identical( dst, [ 1 ] );

  var dst = [ { x : 1 } ];
  var got = _.arrayRemove( dst, { x : 1 } );
  test.identical( dst, [ { x : 1 } ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemove( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemove( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemove( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemove( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ [ 1 ], [ 1 ], [ 1 ] ];
  var onEqualize = function( a )
  {
    return a[ 0 ];
  }
  var got = _.arrayRemove( dst, [ 1 ], onEqualize );
  test.identical( dst, [ ] );

  test.case = 'equalizer 2 args';

  var dst = [ [ 1 ], [ 1 ], [ 1 ] ];
  var onEqualize = function( a )
  {
    return a[ 0 ];
  }
  var onEqualize2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemove( dst, 1, onEqualize, onEqualize2 );
  test.identical( dst, [ ] );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemove();
  })

  test.case = 'fourth is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemove( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemove( 1, 1 );
  })
}

//

function arrayRemoveOnce( test )
{
  test.case = 'simple';

  var got = _.arrayRemoveOnce( [], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveOnce( [ 1 ], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveOnce( [ 1, 2, 2 ], 2 );
  test.identical( got, [ 1, 2 ] );

  var got = _.arrayRemoveOnce( [ 1, 3, 2, 3 ], 3 );
  test.identical( got, [ 1, 2, 3 ] );

  var got = _.arrayRemoveOnce( [ 1 ], '1' );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveOnce( [ 1 ], -1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 2 }, { num : 3 } ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var onEqualize2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemoveOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoveOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 1 }, { num : 3 } ];
  var got = _.arrayRemoveOnce( dst, 1, onEqualize, onEqualize2 );
  test.identical( got, [ { num : 2 }, { num : 1 }, { num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnce( 1, 1, 1 );
  })
}

//

function arrayRemoveOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveOnceStrictly( dst, 2 );
  test.identical( got, [ 1, 3 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoveOnceStrictly( dst, 3, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnceStrictly( 1, 1 );
  })

  test.case = 'ins doesn´t exist';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnceStrictly( [ 1 ], 2 );
  });

  test.case = 'ins is not unique in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnceStrictly( [ 1, 2, 2 ], 2 );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemoveOnceStrictly( dst, { num : 4 }, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )


  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemoveOnceStrictly( dst, 4, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )
}

//

function arrayRemoved( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemoved( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemoved( dst, 1 );
  test.identical( dst, [  ] );
  test.identical( got, 1 );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemoved( dst, 2 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 2 );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemoved( dst, 1 );
  test.identical( dst, [ 2, 2 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayRemoved( dst, '1' );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemoved( dst, -1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemoved( dst, [ 1 ] );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoved( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, 3 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoved( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  var dst = [ { x : 1 } ];
  var got = _.arrayRemoved( dst, { x : 1 } );
  test.identical( dst, [ { x : 1 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoved( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoved( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 1 );


  test.case = 'evaluator 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var evaluator1 = function( a )
  {
    return a.num;
  }
  var evaluator2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemoved( dst, 4, evaluator1 );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoved( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 1 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 1 }, { num : 3 } ];
  var got = _.arrayRemoved( dst, 1, evaluator1, evaluator2 );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 2 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoved();
  })

  test.case = 'fourth is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoved( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoved( 1, 1 );
  })
}

//

function arrayRemovedOnce( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedOnce( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedOnce( dst, 1 );
  test.identical( dst, [  ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedOnce( dst, 3 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 2 );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemovedOnce( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedOnce( dst, '1' );
  test.identical( dst, [ 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedOnce( dst, -1 );
  test.identical( dst, [  1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedOnce( dst, [ 1 ] );
  test.identical( dst, [  1 ] );
  test.identical( got, -1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemovedOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnce();
  })

  test.case = 'third is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnce( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnce( 1, 1 );
  })
}

//

function arrayRemovedOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1 ];
  var got = _.arrayRemovedOnceStrictly( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedOnceStrictly( dst, 2 );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 } ] );
  test.identical( got, 2 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedOnceStrictly( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly();
  })

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( 1, 1 );
  })

  test.case = 'Simple no match element';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ ], 1 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], '1' );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], - 1 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], [ 1 ] );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], 2 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], - 1 );
  })

  test.case = 'Ins several times in srcArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( [ 2, 2, 1 ], 2 );
  })

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedOnceStrictly( dst, { num : 4 }, onEqualize );
  })

}

//

function arrayRemoveElement( test )
{
  test.open( 'array' );
  run( ( src ) => _.arrayMake( src ) );
  test.close( 'array' );

  /* - */

  test.open( 'unroll' );
  run( ( src ) => _.unrollMake( src ) );
  test.close( 'unroll' );

  /* - */

  function run( makeLong )
  {
    test.case = 'dst = empty array, ins = number';
    var dst = makeLong( [] );
    var got = _.arrayRemoveElement( dst, 1 );
    test.identical( dst, [] );
    test.is( got === dst );

    test.case = 'dst = array, ins = number, full removing';
    var dst = makeLong( [ 1 ] );
    var got = _.arrayRemoveElement( dst, 1 );
    test.identical( dst, [] );
    test.is( got === dst );

    var dst = makeLong( [ 2, 2, 2, 2, 2 ] );
    var got = _.arrayRemoveElement( dst, 2 );
    test.identical( dst, [] );
    test.is( got === dst );

    test.case = 'dst = array, ins = number, not a full removing';
    var dst = makeLong( [ 2, 2, 1 ] );
    var got = _.arrayRemoveElement( dst, 2 );
    test.identical( dst, [ 1 ] );
    test.is( got === dst );

    test.case = 'dst = array, ins = array, not a evaluator, no removing';
    var dst = makeLong( [ 1, 1, 1 ] );
    var got = _.arrayRemoveElement( dst, [ 1 ] );
    test.identical( dst, [ 1, 1, 1 ] );
    test.is( got === dst );

    test.case = 'dst = array, ins = string, no removing';
    var dst = makeLong( [ 1, 1, 1 ] );
    var got = _.arrayRemoveElement( dst, '1' );
    test.identical( dst, [ 1, 1, 1 ] );
    test.is( got === dst );

    test.case = 'dst = array, ins = negative number, no removing';
    var dst = makeLong( [ 1, 1, 1 ] );
    var got = _.arrayRemoveElement( dst, -1 );
    test.identical( dst, [ 1, 1, 1 ] );
    test.is( got === dst );

    test.case = 'dst = array with map, ins = same map, not a evaluator, not removing';
    var dst = makeLong( [ { x : 1 }, { x : 1 } ] );
    var got = _.arrayRemoveElement( dst, { x : 1 } );
    test.identical( dst, [ { x : 1 }, { x : 1 } ] );
    test.is( got === dst );

    test.case = 'dst = array with map, ins = number, equalizer, removing';
    var dst = makeLong( [ { value : 1 }, { value : 1 }, { value : 2 } ] );
    var onEqualize = ( a, b ) => a.value === b;
    var got = _.arrayRemoveElement( dst, 1, onEqualize );
    test.identical( got, [ { value : 2 } ] );
    test.is( got === dst );

    test.case = 'dst = array, ins = number, offset for removing';
    var dst = makeLong( [ 1, 2, 3, 1, 2, 3 ] );
    var got = _.arrayRemoveElement( dst, 1, 2 );
    test.identical( got, [ 1, 2, 3, 2, 3 ] );
    test.is( dst === got )

    test.case = 'dst = array with maps, ins = map, equalizer, no removing';
    var dst = makeLong( [ { num : 1 }, { num : 2 }, { num : 3 } ] );
    var onEqualize = ( a, b ) => a.num === b.num;
    var got = _.arrayRemoveElement( dst, { num : 4 }, onEqualize );
    test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
    test.is( got === dst );

    test.case = 'dst = array with maps, ins = map, equalizer, removing';
    var dst = makeLong( [ { num : 1 }, { num : 2 }, { num : 3 } ] );
    var onEqualize = ( a, b ) => a.num === b.num;
    var got = _.arrayRemoveElement( dst, { num : 1 }, onEqualize );
    test.identical( dst, [ { num : 2 }, { num : 3 } ] );
    test.is( got === dst );

    test.case = 'dst = array with maps, ins = map, one evaluator, no removing';
    var dst = makeLong( [ { num : 1 }, { num : 2 }, { num : 3 } ] );
    var onEvaluate = ( a ) => a.num;
    var got = _.arrayRemoveElement( dst, { num : 4}, onEvaluate );
    test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
    test.is( got === dst );

    test.case = 'dst = array with maps, ins = map, two evaluators, removing';
    var dst = makeLong( [ { num : 1 }, { num : 2 }, { num : 3 } ] );
    var got = _.arrayRemoveElement( dst, 1, ( e ) => e.num, ( e ) => e );
    test.identical( dst, [ { num : 2 }, { num : 3 } ] );
    test.is( got === dst );

    test.case = 'dst = complex array, ins = array, one evaluator, full removing';
    var dst = makeLong( [ [ 1 ], [ 1 ], [ 1 ] ] );
    var onEvaluate = ( a ) => a[ 0 ];
    var got = _.arrayRemoveElement( dst, [ 1 ], onEvaluate );
    test.identical( dst, [] );
    test.is( got === dst );

    test.case = 'dst = complex array, ins = number, two evaluators, full removing';
    var dst = makeLong( [ [ 1 ], [ 1 ], [ 1 ] ] );
    var onEvaluate1 = ( a ) => a[ 0 ];
    var onEvaluate2 = ( a ) => a;
    var got = _.arrayRemoveElement( dst, 1, onEvaluate1, onEvaluate2 );
    test.identical( dst, [] );
    test.is( got === dst );
  }

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.arrayRemoveElement() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1 ] ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1, 1 ], 0, 1, ( e ) => e, ( e ) => e, 'extra' ) );

  test.case = 'wrong type of dstArray';
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( _.argumentsArrayMake( [ 1 ] ), 1 ) );
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( new U8x( [ 1 ] ), 1 ) );

  test.case = 'evaluator is not a routine';
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1 ], 1, 1, 1 ) );

  test.case = 'evaluator ( equalizer ) has wrong length';
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1 ], 1, () => 1 ) );
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1 ], 1, ( a, b, c ) => a == b && b == c ) );
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1 ], 1, ( a ) => a, () => 1 ) );
  test.shouldThrowErrorSync( () => _.arrayRemoveElement( [ 1 ], 1, ( a ) => a, ( a, b ) => a == b ) );
}

//

function arrayRemoveElementOnce( test )
{
  test.case = 'simple';

  var got = _.arrayRemoveElementOnce( [], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveElementOnce( [ 1 ], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveElementOnce( [ 1, 2, 2 ], 2 );
  test.identical( got, [ 1, 2 ] );

  var got = _.arrayRemoveElementOnce( [ 1, 3, 2, 3 ], 3 );
  test.identical( got, [ 1, 2, 3 ] );

  var got = _.arrayRemoveElementOnce( [ 1 ], '1' );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveElementOnce( [ 1 ], -1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveElementOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 2 }, { num : 3 } ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var onEqualize2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemoveElementOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoveElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 }, { num : 3 } ] );

  var dst = [ { num : 1 }, { num : 2 }, { num : 1 }, { num : 3 } ];
  var got = _.arrayRemoveElementOnce( dst, 1, onEqualize, onEqualize2 );
  test.identical( got, [ { num : 2 }, { num : 1 }, { num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnce( 1, 1, 1 );
  })
}

//

// function arrayRemoveElementOnce( test ) {
//
//   test.case = 'nothing';
//   var got = _.arrayRemoveElementOnce( [  ], 2 );
//   var expected = [  ];
//   test.identical( got, expected );
//
//   test.case = 'one element left';
//   var got = _.arrayRemoveElementOnce( [ 2, 4 ], 4 );
//   var expected = [ 2 ];
//   test.identical( got, expected );
//
//   test.case = 'two elements left';
//   var got = _.arrayRemoveElementOnce( [ true, false, 6 ], true );
//   var expected = [ false, 6 ];
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
//     _.arrayRemoveElementOnce();
//   });
//
//   test.case = 'not enough arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayRemoveElementOnce( [ 2, 4, 6 ] );
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayRemoveElementOnce( [ 2, 4, 6 ], 2, function( el, ins ) { return el > ins }, 'redundant argument' );
//   });
//
//   test.case = 'arguments[0] is wrong';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayRemoveElementOnce( 'wrong argument', 2 );
//   });
//
//   test.case = 'arguments[2] is wrong';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayRemoveElementOnce( [ 2, 4, 6 ], 2, 'wrong argument' );
//   });
//
// };

//

function arrayRemoveElementOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveElementOnceStrictly( dst, 2 );
  test.identical( got, [ 1, 3 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElementOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoveElementOnceStrictly( dst, 3, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins doesn´t exist';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnceStrictly( [ 1 ], 2 );
  });

  test.case = 'ins is not unique in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnceStrictly( [ 1, 2, 2 ], 2 );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveElementOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemoveElementOnceStrictly( dst, { num : 4 }, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )


  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemoveElementOnceStrictly( dst, 4, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )
}

//

function arrayRemovedElement( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedElement( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, 1 );
  test.identical( dst, [  ] );
  test.identical( got, 1 );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemovedElement( dst, 2 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 2 );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemovedElement( dst, 1 );
  test.identical( dst, [ 2, 2 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, '1' );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, -1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, [ 1 ] );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemovedElement( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, 3 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemovedElement( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  var dst = [ { x : 1 } ];
  var got = _.arrayRemovedElement( dst, { x : 1 } );
  test.identical( dst, [ { x : 1 } ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, '1' );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, -1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElement( dst, [ 1 ] );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  function onEqualize( a, b )
  {
    return a.value === b;
  }
  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayRemovedElement( dst, 1, onEqualize );
  test.identical( dst, [ { value : 2 } ] );
  test.identical( got, 2 );

  var src = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayRemovedElement( src, 1, 1 );
  test.identical( got, 1 );
  test.identical( src, [ 1, 2, 3, 2, 3 ] );;

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElement( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElement( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 1 );


  test.case = 'evaluator 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var evaluator1 = function( a )
  {
    return a.num;
  }
  var evaluator2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemovedElement( dst, 4, evaluator1 );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedElement( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 1 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 1 }, { num : 3 } ];
  var got = _.arrayRemovedElement( dst, 1, evaluator1, evaluator2 );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 2 );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElement();
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElement( [ 1 ], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElement( 1, 1 );
  })

}

//

function arrayRemovedElementOnce( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedElementOnce( dst, 1 );
  test.identical( dst, [ ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElementOnce( dst, 1 );
  test.identical( dst, [  ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedElementOnce( dst, 3 );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 2 );

  var dst = [ 2, 2, 1 ];
  var got = _.arrayRemovedElementOnce( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElementOnce( dst, '1' );
  test.identical( dst, [ 1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElementOnce( dst, -1 );
  test.identical( dst, [  1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayRemovedElementOnce( dst, [ 1 ] );
  test.identical( dst, [  1 ] );
  test.identical( got, -1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemovedElementOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, 0 );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnce();
  })

  test.case = 'fourth is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnce( [], 1, 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnce( 1, 1 );
  })
}

//

function arrayRemovedElementOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1 ];
  var got = _.arrayRemovedElementOnceStrictly( dst, 1 );
  test.identical( dst, [] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedElementOnceStrictly( dst, 2 );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 2 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElementOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 } ] );
  test.identical( got, { num : 3 } );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedElementOnceStrictly( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 }, { num : 3 } ] );
  test.identical( got, { num : 1 } );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly();
  })

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( 1, 1 );
  })

  test.case = 'Simple no match element';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ ], 1 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], '1' );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], - 1 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], [ 1 ] );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], 2 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], - 1 );
  })

  test.case = 'Ins several times in srcArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 2, 2, 1 ], 2 );
  })

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedElementOnceStrictly( dst, { num : 4 }, onEqualize );
  })

}

//

function arrayRemoveArray( test )
{

  test.case = 'nothing';
  var got = _.arrayRemoveArray( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayRemoveArray( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArray( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArray( dst, [ 1, 3 ] );
  test.identical( dst, [ 2 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArray( dst, [ 1, 1 ] );
  test.identical( dst, [ ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArray( dst, [ 1 ] );
  test.identical( dst, [ ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayRemoveArray( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1 ] );
  test.is( got === dst );

  test.case = 'dstc === src';
  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArray( dst, dst );
  test.identical( dst, [ ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArray( [ 1 ], undefined );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArray();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArray( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArray( [ 1, 2 ], 2 );
  });
};

//

function arrayRemoveArrayOnce( test )
{
  test.case = 'nothing';

  var got = _.arrayRemoveArrayOnce( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemoveArrayOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.is( got === dst );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArrayOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1 ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    var got = _.arrayRemoveArrayOnce( dst, [ undefined, 2 ] );
    test.identical( dst, [ 1 ] );
    test.is( got === dst );
  });

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnce( dst, dst );
  test.identical( got, [] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnce( dst, dst, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnce( dst, dst, ( e ) => e + 10 );
  test.identical( got, [] );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with evaluators, nothing to delete';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( got, [ 1,1,2,2,3,3 ] );

  //

  if( !Config.debug )
  return;


  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayRemoveArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });
}

//

function arrayRemoveArrayOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 2 ] );
  test.identical( got, [ 1, 3 ] );
  test.is( got === dst );

  test.case = 'ins has several values';

  var dst = [ 1, 2, 3, 4, 5, 6, 6 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 1, 3, 5 ] );
  test.identical( got, [ 2, 4, 6, 6 ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ { num : 3 } ], onEqualize );
  test.identical( got, [ { num : 1 }, { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 3 ], ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 }, { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args - ins several values';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 3, 1 ], ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  test.case = 'dst === src'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, dst );
  test.identical( got, [] );

  test.case = 'dst === src with single evaluator'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, dst, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with single evaluator'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, dst, ( e ) => e + 10 );
  test.identical( got, [] );

  test.case = 'dst === src with two evaluators'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayRemoveArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayRemoveArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
    test.identical( got, [ 1,1,2,2,3,3 ] );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnceStrictly( [ 1, 2, 2 ], [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemoveArrayOnceStrictly( dst, [ { num : 4 } ], onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )


  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemoveArrayOnceStrictly( dst, [ 4 ], onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  });
  test.identical( dst, [ 1,1,2,2,3,3 ] );
}

//

function arrayRemovedArray( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayRemovedArray( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedArray( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArray( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 3] );
  test.identical( got, 1 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemovedArray( dst, [ 1 ] );
  test.identical( dst, [] );
  test.identical( got, 3 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got;
  var got = _.arrayRemovedArray( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ]
  var got = _.arrayRemovedArray( dst, dst );
  test.identical( dst, [] );
  test.identical( got, 3 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArray( [ 1 ], undefined );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArray();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArray( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArray( [ 1, 2 ], 2 );
  });
}

//

function arrayRemovedArrayOnce( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayRemovedArrayOnce( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedArrayOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 3] );
  test.identical( got, 1 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemovedArrayOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 1 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    var got = _.arrayRemovedArrayOnce( dst, [ undefined, 2 ] );
    test.identical( dst, [ 1 ] );
    test.identical( got, 0 );
  });

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnce( dst, dst );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnce( dst, dst, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, nothing to delete';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnce( [ 1, 2 ], [ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayRemovedArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });

}

//

function arrayRemovedArrayOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 2 ] );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  test.case = 'ins has several values';

  var dst = [ 1, 2, 3, 4, 5, 6, 6 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 1, 3, 5 ] );
  test.identical( dst, [ 2, 4, 6, 6 ] );
  test.identical( got, 3 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ { num : 3 } ], onEqualize );
  test.identical( dst, [ { num : 1 }, { num : 2 } ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 3 ], ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 }, { num : 2 } ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args - ins several values';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 3, 1 ], ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 } ] );
  test.identical( got, 2 );

  test.case = 'dst === src'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, dst );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with single evaluator'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, dst, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with single evaluator'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with two evaluators'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayRemovedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayRemovedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnceStrictly( [ 1, 2, 2 ], [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnceStrictly( [ 1, 2, 3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemovedArrayOnceStrictly( dst, [ { num : 4 } ], onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )


  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemovedArrayOnceStrictly( dst, [ 4 ], onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrayOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  });
  test.identical( dst, [ 1,1,2,2,3,3 ] );
}

//

function arrayRemoveArrays( test )
{
  test.case = 'nothing';
  var got = _.arrayRemoveArrays( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.arrayRemoveArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArrays( dst, [ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArrays( dst, [ 1, 3 ] );
  test.identical( dst, [ 2 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1, 2, 2, 2 ];
  var got = _.arrayRemoveArrays( dst, [ [ 1 ], [ 2 ] ] );
  test.identical( dst, [ ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ];
  var got = _.arrayRemoveArrays( dst, insArray );
  test.identical( dst, [ 3, 4 ] );
  test.is( got === dst );

  var dst = [ 5 ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemoveArrays( dst, insArray );
  test.identical( dst, [] );
  test.is( got === dst );

  var dst = [ [ 5 ] ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemoveArrays( dst, insArray );
  test.identical( dst, [ [ 5 ] ] );
  test.is( got === dst );

  var dst = [ [ 5 ] ];
  var insArray = [ [ [ 5 ] ] ];
  var got = _.arrayRemoveArrays( dst, insArray );
  test.identical( dst, [ [ 5 ] ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayRemoveArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1 ] );
  test.is( got === dst );

  test.case = 'dst === ins';
  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArrays( dst, dst );
  test.identical( dst, [ ] );
  test.is( got === dst );

  test.case = 'dst === ins';
  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArrays( dst, [ dst ] );
  test.identical( dst, [ ] );
  test.is( got === dst );

  test.case = 'dst === ins';
  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArrays( dst, [ dst, dst ] );
  test.identical( dst, [ ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArrays();
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemoveArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not longIs entity';
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemoveArrays( [], 1 );
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemoveArrays( [], [ 1 ], [ 1 ] );
  });

};

//

function arrayRemoveArraysOnce( test )
{
  test.case = 'nothing';

  var got = _.arrayRemoveArraysOnce( [], [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemoveArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 2, 3, 3, 4, 5, 5 ];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( got, [ 1, 3, 3, 4, 5 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 2, 2, 3, 4, 4, 5 ];
  var insArray = [ [ 1, 1 ], 2 , [ 3 ], 4, 4, [ 5 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( dst, [ 2 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( got, [ 3, 4 ] );
  test.is( got === dst );

  var dst = [ 5, 5 ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( got, [ 5 ] );
  test.is( got === dst );

  var dst = [ [ 5 ], [ 5 ] ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( dst, [ [ 5 ], [ 5 ] ] );
  test.is( got === dst );

  var dst = [ [ 5 ], [ 5 ] ];
  var insArray = [ [ [ 5 ] ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( dst, [ [ 5 ], [ 5 ] ] );
  test.is( got === dst );

  function onEqualize( a, b ){ return a === b }
  var dst = [ 1, 2, [ 3 ] ];
  var insArray = [ 1, 2, [ 3 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray, onEqualize );
  test.identical( got, [ [ 3 ] ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    var got = _.arrayRemoveArraysOnce( dst, [ undefined, 2 ] );
    test.identical( dst, [ 1 ] );
    test.is( got === dst );
  });

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var insArray = [ [ { num : 3 } ], { num : 1 } ];
  var got = _.arrayRemoveArraysOnce( dst, insArray, onEqualize )
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var insArray = [ [ 3 ], 1  ];
  var got = _.arrayRemoveArraysOnce( dst, insArray, ( e ) => e.num, ( e ) => e )
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  /*  */

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, dst );
  test.identical( got, [] );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ dst ] );
  test.identical( got, [] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, dst, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ dst ], ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, dst, ( e ) => e + 10 );
  test.identical( got, [] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ dst ], ( e ) => e + 10 );
  test.identical( got, [] );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with evaluators, nothing to delete';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( got, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, nothing to delete';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, [ 1,1,2,2,3,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnce( [  ], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not longIs entity';
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemoveArraysOnce( [], 1 );
  });
}

//

function arrayRemoveArraysOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, [ 2 ] );
  test.identical( got, [ 1, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( got, [ ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray );
  test.identical( got, [ ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], [ 2, 3 ], [ 4 ], 5 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray );
  test.identical( got, [] );
  test.is( got === dst );

  var dst = [ 5, 6, 7, 8 ];
  var insArray = [ [ 5, 6 ], 7 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray );
  test.identical( got, [ 8 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var insArray = [ [ { num : 3 } ], { num : 1 }  ]
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray, onEqualize )
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var insArray = [ [ 3 ], 1  ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  /*  */

  test.case = 'dst === src'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, dst );
  test.identical( got, [] );

  test.case = 'dst === src with single evaluator'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, dst, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with single evaluator'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, dst, ( e ) => e + 10 );
  test.identical( got, [] );

  test.case = 'dst === src with two evaluators'

  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( got, [] );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayRemoveArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 ) );
  else
  _.arrayRemoveArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnceStrictly( [ 1, 2, 2 ], [ [ 2 ] ] );
  });

  test.case = 'ins element repeated';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnceStrictly( [ 1, 2, 3, 4, 5 ], [ [ 2, 3 ], 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveArraysOnceStrictly( [], [ 1, 2, 3 ], [] );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    var insArray = [ [ { num : 4 } ] ];
    _.arrayRemoveArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    var insArray = [ [ 4 ] ];
    _.arrayRemoveArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )
}

//

function arrayRemovedArrays( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayRemovedArrays( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedArrays( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArrays( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemovedArrays( dst, [ 1 ] );
  test.identical( dst, [] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3, 4, 5];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ];
  var got = _.arrayRemovedArrays( dst, insArray );
  test.identical( dst, [ 3, 4 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], 2 , [ 3 ], 4, [ 5 ] ]
  var got = _.arrayRemovedArrays( dst, insArray );
  test.identical( dst, [] );
  test.identical( got, 5 );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ];
  var got = _.arrayRemovedArrays( dst, insArray );
  test.identical( dst, [ 3, 4 ] );
  test.identical( got, 3 );

  var dst = [ 5 ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemovedArrays( dst, insArray );
  test.identical( dst, [] );
  test.identical( got, 1 );

  var dst = [ [ 5 ] ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemovedArrays( dst, insArray );
  test.identical( dst, [ [ 5 ] ] );
  test.identical( got, 0 );

  var dst = [ [ 5 ] ];
  var insArray = [ [ [ 5 ] ] ];
  var got = _.arrayRemovedArrays( dst, insArray );
  test.identical( dst, [ [ 5 ] ] );
  test.identical( got, 0 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayRemovedArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ]
  var got = _.arrayRemovedArrays( dst, dst );
  test.identical( dst, [] );
  test.identical( got, 3 );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ]
  var got = _.arrayRemovedArrays( dst, [ dst ] );
  test.identical( dst, [] );
  test.identical( got, 3 );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ]
  var got = _.arrayRemovedArrays( dst, [ dst,dst ] );
  test.identical( dst, [] );
  test.identical( got, 3 );


  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArrays();
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemovedArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not longIs entity';
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemovedArrays( [], 1 );
  });

  test.case = 'too many args';
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemovedArrays( [], [ 1 ], [ 1 ] );
  });
}

//

function arrayRemovedArraysOnce( test )
{
  test.case = 'nothing';

  var dst = [];
  var got = _.arrayRemovedArraysOnce( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'prepends only unique elements';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1, 3] );
  test.identical( got, 1 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemovedArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 1 );

  var dst = [ 1, 1, 2, 3, 3, 4, 5, 5];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ]
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ 1, 3, 3, 4, 5 ] );
  test.identical( got, 3 );

  var dst = [ 1, 1, 2, 2, 3, 4, 4, 5 ];
  var insArray = [ [ 1, 1 ], 2 , [ 3 ], 4, 4, [ 5 ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ 2 ] );
  test.identical( got, 7 );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], [ 2, [ 3 ] ], [ [ [ 4 ] ], 5 ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ 3, 4 ] );
  test.identical( got, 3 );

  var dst = [ 5, 5 ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ 5 ] );
  test.identical( got, 1 );

  var dst = [ [ 5 ], [ 5 ] ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ [ 5 ], [ 5 ] ] );
  test.identical( got, 0 );

  var dst = [ [ 5 ], [ 5 ] ];
  var insArray = [ [ [ 5 ] ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ [ 5 ], [ 5 ] ] );
  test.identical( got, 0 );

  function onEqualize( a, b ){ return a === b }
  var dst = [ 1, 2, [ 3 ] ];
  var insArray = [ 1, 2, [ 3 ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray, onEqualize );
  test.identical( dst, [ [ 3 ] ] );
  test.identical( got, 2 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    var got = _.arrayRemovedArraysOnce( dst, [ undefined, 2 ] );
    test.identical( dst, [ 1 ] );
    test.identical( got, 0 );
  });

  /*  */

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, dst );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, [ dst ] );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, dst, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, [ dst ], ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, [ dst ], ( e ) => e + 10 );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, nothing to delete';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, dst, ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with evaluators, nothing to delete';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnce( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnce( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not longIs entity';
  test.shouldThrowErrorSync( function ()
  {
    _.arrayRemovedArraysOnce( [], 1 );
  });
}

//

function arrayRemovedArraysOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, [ 2 ] );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3, 4 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ ] );
  test.identical( got, 4 );

  var dst = [ 1, 2, 3, 4, 5 ];
  var insArray = [ [ 1 ], [ 2, 3 ], [ 4 ], 5 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [] );
  test.identical( got, 5 );

  var dst = [ 5, 6, 7, 8 ];
  var insArray = [ [ 5, 6 ], 7 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 8 ] );
  test.identical( got, 3 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var insArray = [ [ { num : 3 } ], { num : 1 }  ]
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray, onEqualize )
  test.identical( dst, [ { num : 2 } ] );
  test.identical( got, 2 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];
  var insArray = [ [ 3 ], 1  ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 } ] );
  test.identical( got, 2 );

  /*  */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, dst );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, [ dst ] );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with single evaluator'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, dst, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with single evaluator'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, [ dst ], ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with single evaluator'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, dst, ( e ) => e + 10 );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with single evaluator'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, [ dst ], ( e ) => e + 10 );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e );
  test.identical( dst, [] );
  test.identical( got, 6 );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayRemovedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayRemovedArraysOnceStrictly( dst, dst, ( e ) => e, ( e ) => e + 10 );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src with two evaluators'
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayRemovedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayRemovedArraysOnceStrictly( dst, [ dst ], ( e ) => e, ( e ) => e + 10 );
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnceStrictly( [ 1, 2, 2 ], [ [ 2 ] ] );
  });

  test.case = 'ins element repeated';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnceStrictly( [ 1, 2, 3, 4, 5 ], [ [ 2, 3 ], 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowErrorSync( function()
  {
    _.arrayRemovedArraysOnceStrictly( [], [ 1, 2, 3 ], [] );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 }, { num : 2 }, { num : 3 } ];

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    var insArray = [ [ { num : 4 } ] ];
    _.arrayRemovedArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )

  test.shouldThrowErrorSync( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    var insArray = [ [ 4 ] ];
    _.arrayRemovedArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 }, { num : 2 }, { num : 3 } ] )
}

//

function arrayRemoveDuplicates( test )
{
  test.case = 'empty';

  var dst = [];
  var got = _.arrayRemoveDuplicates( dst );
  var expected = [];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'No duplicates - One element';

  var dst = [ 1 ];
  var got = _.arrayRemoveDuplicates( dst );
  var expected = [ 1 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'No duplicates - Several elements';

  var dst = [ 1, 2, 3, '4', '5' ];
  var got = _.arrayRemoveDuplicates( dst );
  var expected = [ 1, 2, 3, '4', '5' ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'One duplicated element';

  var dst = [ 1, 2, 2 ];
  var got = _.arrayRemoveDuplicates( dst );
  var expected = [ 1, 2 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'One duplicated element - Several elements';

  var dst = [ 1, 2, 1, 1, 1 ];
  var got = _.arrayRemoveDuplicates( dst );
  var expected = [ 1, 2 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'Several duplicates several times';

  var dst = [ 1, 2, 3, '4', '4', 1, 2, 1, 5 ];
  var got = _.arrayRemoveDuplicates( dst );
  var expected = [ 1, 2, 3, '4', 5 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'onEqualize';
  var dst = [ 1, 2, 3, '4', '4', 1, 2, 1, 5 ];

  var got  = _.arrayRemoveDuplicates( dst, function( a, b )
  {
    return  a === b;
  });
  var expected = [ 1, 2, 3, '4', 5 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'Evaluator';
  var dst = [ { 'num' : 0 }, { 'num' : 1 }, { 'num' : 2 }, { 'num' : 0 } ];

  var got  = _.arrayRemoveDuplicates( dst, function( a )
  {
    return  a.num;
  });
  var expected = [ { 'num' : 0 }, { 'num' : 1 }, { 'num' : 2 } ];
  test.identical( dst, expected );
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveDuplicates();
  })

  // test.case = 'more than two args';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayRemoveDuplicates( [ 1 ], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveDuplicates( 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveDuplicates( new U8x( [1, 2, 3, 4, 5] ) );
  })

  test.case = 'second arg is not a function';
  test.shouldThrowErrorSync( function()
  {
    _.arrayRemoveDuplicates( 1, 1 );
  })
}

//

function arrayFlattenCritical( test )
{

  test.case = 'array of the passed arguments';
  var got = _.arrayFlatten( [], [ 'str', {}, [ 1, 2 ], 5, true ] );
  var expected = [ 'str', {}, 1, 2, 5, true ];
  test.identical( got, expected );

  test.case = 'without undefined';
  var got = _.arrayFlatten( [ 1, 2, 3 ], [ 13, 'abc', null ] );
  var expected = [ 1, 2, 3, 13, 'abc', null ];
  test.identical( got, expected );

  // test.case = 'Args are not long';
  // var got = _.arrayFlatten( [ 1, 2 ], 13, 'abc', {} );
  // var expected = [ 1, 2, 13, 'abc', {} ];
  // test.identical( got, expected );

  test.case = 'undefined';
  var got = _.arrayFlatten( [ 1, 2, 3 ], [ 13, 'abc', undefined, null ] );
  var expected = [ 1, 2, 3, 13, 'abc', undefined, null ];
  test.identical( got, expected );

  test.case = 'second argument is number';
  var got = _.arrayFlatten( [ 1, 2, 3 ], 13 );
  var expected = [ 1, 2, 3, 13 ];
  test.identical( got, expected );

  test.case = 'second argument is map';
  var got = _.arrayFlatten( [ 1, 2, 3 ], { k : 'e' } );
  var expected = [ 1, 2, 3, { k : 'e' } ];
  test.identical( got, expected );

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.arrayFlatten( undefined, [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.arrayFlatten( new U32x([ 1, 2, 3 ]), [ 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.arrayFlatten( [], [], [] ) );
  test.shouldThrowErrorSync( () => _.arrayFlatten( [], 0, 1 ) );

  // test.shouldThrowErrorSync( () => _.arrayFlatten( [], 13 ) );
  // test.shouldThrowErrorSync( () => _.arrayFlatten( [], '13' ) );
  // test.shouldThrowErrorSync( () => _.arrayFlatten( [], { k : 'e' } ) );
  // test.shouldThrowErrorSync( () => _.arrayFlatten( [ 1, 2, 3 ], [ 13, 'abc', undefined, null ] ) );

}

//

function arrayFlatten( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlatten( null, [] );
  test.identical( got, [] );

  var got  = _.arrayFlatten( [], [] );
  test.identical( got, [] );

  var got  = _.arrayFlatten( null, [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlatten( [], [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlatten( [], [ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlatten( [], [ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlatten( [], [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( got, [ 1 ] );

  // var got  = _.arrayFlatten( [], 1, 2, '3'  );
  // test.identical( got, [ 1, 2, '3' ] );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlatten( [ 1, 2, 3 ], [ 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlatten( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlatten( [ 1, 2, 3 ], [ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlatten( [ 1, 2, 3 ], [ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlatten( [ 1 ], [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( got, [ 1, 1 ] );

  var got = _.arrayFlatten( [], 1 );
  test.identical( got, [ 1 ] );
  /*
  var got  = _.arrayFlatten( [ 1 ], 2, 3 );
  test.identical( got, [ 1, 2, 3 ] );
  */

  test.case = 'make array flat from multiple arrays as one arg';

  var got  = _.arrayFlatten
  (
    [],
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( got, [ 1, 2, 3, 4 ] );

  test.case = 'make array flat from different inputs -  null dstArray';

  // var got  =  _.arrayFlatten( null, 'str', {}, [ 1, 2 ], 5, true );
  // test.identical( got, [ 'str', {}, 1, 2, 5, true ] );

  var got = _.arrayFlatten( [ 1, 1, 3, 3, [ 5, 5 ] ], 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( null, [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ 0 ], [ [ -1, -2 ] ] ], [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ [ 0 ], [ [ -1, -2 ] ], 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  //

  test.open( 'another criteria' );

  test.open( 'single argument' ); //

  var got = _.arrayFlatten( [ 0, 1, 2, 3 ] )
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ 0, 1, 0, 1 ] )
  var expected = [ 0, 1, 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ 0, 0 ], [ 1, 1 ] ] );
  var expected = [ 0, 0, 1, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  var expected = [ 0, 0, 1, 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ [ 0 ] ] ] );
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  test.close( 'single argument' ); //

  test.open( 'two arguments' ); //

  var got = _.arrayFlatten( [ 0, 1, 2, 3 ] )
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ 0, 1, 0, 1 ] )
  var expected = [ 0, 1, 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ 0, 0 ], [ 1, 1 ] ] );
  var expected = [ 0, 0, 1, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  var expected = [ 0, 0, 1, 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ [ 0 ] ] ] );
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  test.close( 'two arguments' ); //

  test.close( 'another criteria' );

  //

  if( !Config.debug )
  return;

  test.case = 'Empty';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlatten( );
  });
  /*
  test.case = 'Undefined element ina array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlatten( [], [ 1, undefined ] );
  });
  */
}

//

function arrayFlattenOnce( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenOnce( [], [] );
  test.identical( got, [] );

  var got  = _.arrayFlattenOnce( [], [ 1, 1, 2, 2, 3 , 3 ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenOnce( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenOnce( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenOnce( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( got, [ 1 ] );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenOnce( [ 1, 2, 3, 4 ], [ 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnce( [ 1, 2, 3 ], [ 1, 2, 3, [ [ 4 ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnce( [ 1, 2, 3 ], [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnce( [ 1, 2, 3 ], [ [ 1, [ 2, [ 3 ] ] ], 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnce( [ 1 ], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( got, [ 1 ] );

  test.case = 'make array flat from multiple arrays as one arg';

  var got  = _.arrayFlattenOnce
  (
    [ 1, 4 ],
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( got, [ 1, 4, 2, 3 ] );

  test.case = 'onEqualize';
  var got  = _.arrayFlattenOnce( [ 1, 2, 3, 4 ], [ 1, 4, 2, 5 ], function( a, b )
  {
    return  a === b;
  });
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  debugger;
  var got = _.arrayFlattenOnce( [], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayFlattenOnce( [ 1, 1, 3, 3, [ 5, 5 ] ], 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( null, [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 3, 5 ];
  test.identical( got, expected );

  //

  test.open( 'single argument' );

  var got = _.arrayFlattenOnce( [ 0, 1, 2, 3 ] );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( [ 0, 1, 0, 1 ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( [ [ 0, 0 ], [ 1, 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( [ 1, [ [ 0 ], 1 ], 1, 0 ] );
  var expected = [ 1, 0 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 3, 5 ];
  test.identical( got, expected );

  test.close( 'single argument' );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnce();
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnce( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnce( [], [ 1 ], [] );
  });
}

//

function arrayFlattenOnceStrictly( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenOnceStrictly( [], [] );
  test.identical( got, [] );

  var dst = [];
  var got = _.arrayFlattenOnceStrictly( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );
  test.identical( dst, got );

  var dst = [];
  var got = _.arrayFlattenOnceStrictly( dst, [ [ 1 ], [ 2 ], [ 3 ], [ 4 ]  ] );
  test.identical( got, [ 1, 2, 3, 4 ] );
  test.identical( dst, got );

  var dst = [];
  var got = _.arrayFlattenOnceStrictly( dst, [ [ 1, [ 2, [ 3 ], 4 ] ]  ] );
  test.identical( got, [ 1, 2, 3, 4 ] );
  test.identical( dst, got );

  var dst = [];
  var got = _.arrayFlattenOnceStrictly( dst, [ 1, [ 2, [ [ 3, [ 4 ] ] ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );
  test.identical( dst, got );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ] );
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  var got  = _.arrayFlattenOnceStrictly( [ 1, 2, 3 ], [ [ [ 4 ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnceStrictly( [ 1 ], [ [ [ [ [ 0, 2, 3 ] ] ] ] ]  );
  test.identical( got, [ 1, 0, 2, 3 ] );

  test.case = 'make array flat from multiple arrays as one arg';

  var got  = _.arrayFlattenOnceStrictly
  (
    [ 1, 4 ],
    [
      [ [ 2 ] ],
      [ 3, [ [ [ 5 ] ] ] ]
    ]
  );
  test.identical( got, [ 1, 4, 2, 3, 5 ] );

  test.case = 'onEqualize';
  var got  = _.arrayFlattenOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ], function( a, b )
  {
    return  a === b;
  });
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  debugger;

  test.case = 'dstArray has sub arrays';
  var got = _.arrayFlattenOnceStrictly( [ 1, 3, [ 5 ] ], 6 );
  var expected = [ 1, 3, [ 5 ], 6 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ [ 1, [ 3, [ 5 ] ] ], 2 ], 6 );
  var expected = [ [ 1, [ 3, [ 5 ] ] ], 2, 6 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ 1, 3, [ 5 ] ], 5 );
  var expected = [ 1, 3, [ 5 ], 5 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [], [ 1, 3, [ 5, 6 ] ] );
  var expected = [ 1, 3, 5, 6 ];
  test.identical( got, expected );

  //

  test.open( 'single argument' );

  var got = _.arrayFlattenOnceStrictly( [ 0, 1, 2, 3 ] );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ 0, [ 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ [ 0 ], [ 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ [ 0 ], 1, 2, [ 3, 4 ] ] );
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ 0, [ [ 2 ], 1 ], 3, 4 ] );
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly( [ 1, 3, [ 5, 7 ] ] );
  var expected = [ 1, 3, 5, 7 ];
  test.identical( got, expected );

  test.close( 'single argument' );

  //

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly();
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly( 1, [ 1 ] );
  });

  // test.case = 'second is not longIs';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayFlattenOnceStrictly( [], 1 );

  // });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly( [], [ 1 ], [] );
  });

  test.case = 'Elements must not be repeated';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly( [], [ 1, 1, 2, 2, 3, 3 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenOnceStrictly( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 6 ] ] ], 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0 ], 0 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 0 ] ] ], 7 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0, 1, 1 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0, 1, 1 ], 2 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0 ], [ 1, 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0, 1, 1 ], [ 3, 4, [ 5, [ 6 ] ] ] );
  });
}

//

function arrayFlattened( test )
{

  test.case = 'make array flat, dst is empty';

  var dst = [];
  var got  = _.arrayFlattened( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  var dst = [];
  var got  = _.arrayFlattened( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got  = _.arrayFlattened( dst, [ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got  = _.arrayFlattened( dst, [ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got  = _.arrayFlattened( dst, [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  test.case = 'make array flat, dst is not empty';

  var dst = [ 1, 2, 3 ];
  var got  = _.arrayFlattened( dst, [ 4 ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got  = _.arrayFlattened( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattened( dst, [ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( dst, [ 1, 2, 3, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattened( dst, [ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( dst, [ 1, 2, 3, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1 ];
  var got = _.arrayFlattened( dst, [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 1 );

  var dst = [ 1, [ 2, 3 ] ];
  var got  = _.arrayFlattened( dst, [ 4 ] );
  test.identical( dst, [ 1, [ 2, 3 ], 4 ] );
  test.identical( got, 1 );

  test.case = 'make array flat from multiple arrays as one arg';

  var dst = [];
  var got = _.arrayFlattened
  (
    dst,
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 4 );

  test.case = 'Second is not long';

  var dst = [];
  var got  = _.arrayFlattened( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  // var dst = [];
  // var got  = _.arrayFlattened( dst, 1, 2, '3' );
  // test.identical( dst, [ 1, 2, '3' ] );
  // test.identical( got, 3 );

  var dst = [ 1, 1, 3, 3, [ 5, 5 ] ];
  var got = _.arrayFlattened( dst, 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( dst, expected );
  test.identical( got, 1 );

  /* */

  test.open( 'single argument' );

  var got = _.arrayFlattened( [ 0, 1, 2, 3 ] );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ 0, 1, 0, 1 ] );
  var expected = [ 0, 1, 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ [ 0, 0 ], [ 1, 1 ] ] );
  var expected = [ 0, 0, 1, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  var expected = [ 0, 0, 1, 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ [ [ 0 ] ] ] );
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  test.close( 'single argument' );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattened();
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattened( 1, [ 1 ] );
  });

}

//

function arrayFlattenedOnce( test )
{
  test.case = 'make array flat, dst is empty';

  var dst = [];
  var got = _.arrayFlattenedOnce( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  var dst = [];
  var got = _.arrayFlattenedOnce( dst, [ 1, 1, 2, 2, 3 , 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got = _.arrayFlattenedOnce( dst, [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got = _.arrayFlattenedOnce( dst, [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got = _.arrayFlattenedOnce( dst, [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  test.case = 'make array flat, dst is not empty';

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayFlattenedOnce( dst, [ 4 ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattenedOnce( dst, [ 1, 2, 3, [ [ 4 ] ] ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattenedOnce( dst, [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattenedOnce( dst, [ [ 1, [ 2, [ 3 ] ] ], 4 ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayFlattenedOnce( dst, [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  test.case = 'dst contains some inner arrays';

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  var got = _.arrayFlattenedOnce( dst, [ 1, 2, 3 ]  );
  test.identical( dst, [ [ 1 ], [ 2 ], [ 3 ], 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  var got = _.arrayFlattenedOnce( dst, [ 4, 5, 6 ]  );
  test.identical( dst, [ [ 1 ], [ 2 ], [ 3 ], 4, 5, 6 ] );
  test.identical( got, 3 );

  test.case = 'make array flat from multiple arrays as one arg';

  var dst = [ 1, 4 ];
  var got  = _.arrayFlattenedOnce
  (
    dst,
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( dst, [ 1, 4, 2, 3 ] );
  test.identical( got, 2 );

  test.case = 'onEqualize';
  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayFlattenedOnce( dst, [ 1, 4, 2, 5 ], function( a, b )
  {
    return  a === b;
  });
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.identical( got, 1 );

  //

  test.open( 'single argument' );

  var got = _.arrayFlattenedOnce( [ 0, 1, 2, 3 ] );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce( [ 0, 1, 0, 1 ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce( [ [ 0, 0 ], [ 1, 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce( [ 1, [ [ 0 ], 1 ], 1, 0 ] );
  var expected = [ 1, 0 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  var expected = [ 1, 3, 5 ];
  test.identical( got, expected );

  test.close( 'single argument' );

  /*
  test.case = 'Second arg is not long';

  var dst = [];
  var got = _.arrayFlattenedOnce( dst, 2 );
  test.identical( dst, [ undefined ] );
  */
  var dst = [];
  var got = _.arrayFlattenedOnce( dst, 1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  var dst = [ 1, 1, 3, 3, [ 5, 5 ] ];
  var got = _.arrayFlattenedOnce( dst, 6 );
  var expected = 1;
  test.identical( dst, [ 1, 1, 3, 3, [ 5, 5 ], 6 ] );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnce();
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnce( 1, [ 1 ] );
  });

/*
test.case = 'Too many args';
test.shouldThrowErrorSync( function()
{
  _.arrayFlattenedOnce( [ 1 ], 2, 3  );
});
*/

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnce( [], [ 1 ], [] );
  });
}

//

function arrayFlattenedOnceStrictly( test )
{
  test.case = 'make array flat, dst is empty';

  var dst = [];
  var got = _.arrayFlattenedOnceStrictly( dst, [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  var dst = [];
  var got = _.arrayFlattenedOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ 1 ], [ 2 ], 3  ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ 1, [ 2, [ 3, 4 ] ] ]  ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 4 );

  var dst = [];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( dst, [ 1 ] );
  test.identical( got, 1 );

  test.case = 'make array flat, dst is not empty';

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 0 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ [ 4 ] ] ] );
  test.identical( dst, [ 1, 2, 3, 4 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ 4 ], [ 5 ], [ 6 ], [ 7 ] ] );
  test.identical( dst, [ 1, 2, 3, 4, 5, 6, 7 ] );
  test.identical( got, 4 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ 0, [ -1, [ -2 ] ] ], -3 ] );
  test.identical( dst, [ 1, 2, 3, 0, -1, -2, -3 ] );
  test.identical( got, 4 );

  var dst = [ 1 ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ [ [ [ [ 2 ] ] ] ] ]  );
  test.identical( dst, [ 1, 2 ] );
  test.identical( got, 1 );

  test.case = 'dst contains some inner arrays';

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  var got = _.arrayFlattenedOnceStrictly( dst, [  [ 1 ], [ 2 ], [ 3 ] ]  );
  test.identical( dst, [ [ 1 ], [ 2 ], [ 3 ], 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ 4, 5, 6 ]  );
  test.identical( dst, [ [ 1 ], [ 2 ], [ 3 ] , 4, 5, 6 ] );
  test.identical( got, 3 );

  test.case = 'make array flat from multiple arrays as one arg';

  var dst = [ -1, 0 ];
  var got  = _.arrayFlattenedOnceStrictly
  (
    dst,
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( dst, [ -1, 0, 1, 2, 3, 4 ] );
  test.identical( got, 4 );

  test.case = 'onEqualize';
  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayFlattenedOnceStrictly( dst, [ 5, 6, 7, 8 ], function( a, b )
  {
    return  a === b;
  });
  test.identical( dst, [ 1, 2, 3, 4, 5, 6, 7, 8 ] );
  test.identical( got, 4 );

  test.case = 'Second arg is not long';
  var dst = [ 1, 3, [ 5 ] ];
  var got = _.arrayFlattenedOnceStrictly( dst, 5 );
  var expected = [ 1, 3, [ 5 ], 5 ];
  test.identical( dst, expected );
  test.identical( got, 1 );

  var dst = [ 1, 3, [ 5 ] ];
  var got = _.arrayFlattenedOnceStrictly( dst, 6 );
  var expected = [ 1, 3, [ 5 ], 6 ];
  test.identical( dst, expected );
  test.identical( got, 1 );

  //

  test.open( 'single argument' );

  var got = _.arrayFlattenedOnceStrictly( [ 0, 1, 2, 3 ] );
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly( [ 0, [ 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly( [ [ 0 ], [ 1 ] ] );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly( [ [ 0 ], 1, 2, [ 3, 4 ] ] );
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly( [ 0, [ [ 1 ], 2 ], 3, 4 ] );
  var expected = [ 0, 2, 1, 3, 4 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly( [ 1, 3,  [ 5, 7 ] ] );
  var expected = [ 1, 3, 5, 7 ];
  test.identical( got, expected );

  test.close( 'single argument' );


  test.case = 'Second arg is not long';

  var dst = [];
  var got = _.arrayFlattenedOnceStrictly( dst, 2 );
  test.identical( dst, [ 2 ] );
  test.identical( got, 1 );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly();
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ 1 ], [] );
  });

  test.case = 'Elements must not be repeated';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ 1, 1, 2, 2, 3 , 3 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 6 ] ] ], 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0 ], 0 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 0 ] ] ], 7 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0, 1, 1 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0 ], 1 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0, 1, 1 ], 2 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0 ], [ 1, 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0, 1, 1 ], [ 3, 4, [ 5, [ 6 ] ] ] );
  });

}

//

function arrayFlattenDefined( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenDefined( [], [] );
  test.identical( got, [] );

  var got  = _.arrayFlattenDefined( [], [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [], [ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [], [ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [], [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( got, [ 1 ] );

  var got  = _.arrayFlattenDefined( [], 1, 2, '3'  );
  test.identical( got, [ 1, 2, '3' ] );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenDefined( [ 1, 2, 3 ], [ 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenDefined( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [ 1, 2, 3 ], [ [ 1 ], [ 2 ], [ 3 ] ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [ 1, 2, 3 ], [ [ 1, [ 2, [ 3 ] ] ] ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [ 1 ], [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( got, [ 1, 1 ] );

  var got = _.arrayFlattenDefined( [], 1 );
  test.identical( got, [ 1 ] );

  test.case = 'make array flat from multiple arrays as one arg';

  var got  = _.arrayFlattenDefined
  (
    [],
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( got, [ 1, 2, 3, 4 ] );

  test.case = 'make array flat from different inputs -  null dstArray';

  var got  =  _.arrayFlattenDefined( null, 'str', {}, [ 1, 2 ], 5, true );
  test.identical( got, [ 'str', {}, 1, 2, 5, true ] );

  var got = _.arrayFlattenDefined( [ 1, 1, 3, 3, [ 5, 5 ] ], 5 );
  test.identical( got, [ 1, 1, 3, 3, [ 5, 5 ], 5 ] );

  var got = _.arrayFlattenDefined( null, [ 1, 1, 3, 3, [ 5, 5 ] ] );
  test.identical( got, [ 1, 1, 3, 3, 5, 5 ] );

  var got = _.arrayFlattenDefined( [ [ 0 ], [ [ -1, -2 ] ] ], [ 1, 1, 3, 3, [ 5, 5 ] ] );
  test.identical( got, [ [ 0 ], [ [ -1, -2 ] ], 1, 1, 3, 3, 5, 5 ] );

  //

  test.case = 'single argument';

  var got = _.arrayFlattenDefined( [ 0, 1, 2, 3 ] )
  test.identical( got, [ 0, 1, 2, 3 ] );

  var got = _.arrayFlattenDefined( [ [ 0, 0 ], [ 1, 1 ] ] );
  test.identical( got, [ 0, 0, 1, 1 ] );

  var got = _.arrayFlattenDefined( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  test.identical( got, [ 0, 0, 1, 0, 1 ] );

  var got = _.arrayFlattenDefined( [ [ [ 0 ] ] ] );
  test.identical( got, [ 0 ] );

  var got = _.arrayFlattenDefined( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  test.identical( got, [ 1, 1, 3, 3, 5, 5 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'Empty';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefined();
  });

  test.case = 'dstArray is not array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefined( 1, [ 1 ] );
  });

  test.case = 'insArray is undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefined( [ 1 ], undefined );
  });

}

//

function arrayFlattenDefinedOnce( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenDefinedOnce( [], [] );
  test.identical( got, [] );

  var got  = _.arrayFlattenDefinedOnce( [], [ 1, 1, 2, 2, 3, 3, 3 ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenDefinedOnce( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenDefinedOnce( [], [ [ 1, 1, [ 2, 2, 2, [ 3, 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3 ] );

  var got  = _.arrayFlattenDefinedOnce( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( got, [ 1 ] );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenDefinedOnce( [ 1, 2, 3, 4 ], [ 4, 2 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenDefinedOnce( [ 1, 2, 3 ], [ 1, 2, 3, [ [ 4 ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenDefinedOnce( [ 'a', 2, 3 ], [ [ 1 ], [ 4 ], [ 'a' ], [ 4 ] ] );
  test.identical( got, [ 'a', 2, 3, 1, 4 ] );

  var got  = _.arrayFlattenDefinedOnce( [ 1, 2, 3 ], [ [ 1, [ 2, [ 3 ] ] ], 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenDefinedOnce( [ 1 ], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( got, [ 1 ] );

  test.case = 'make array flat from multiple arrays as one arg';
  var got  = _.arrayFlattenDefinedOnce
  (
    [ 1, 4 ],
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( got, [ 1, 4, 2, 3 ] );

  //

  test.case = 'onEqualize';
  var got  = _.arrayFlattenDefinedOnce( [ 1, 2, 3, 4 ], [ 1, 4, 2, 5 ], ( a, b ) =>  a === b );
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  test.case = 'onEvaluate - one evaluator';
  var got  = _.arrayFlattenDefinedOnce( [ 1, 2, 3, 4 ], [ 1, 4, 2, 5 ], ( a ) => a );
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  test.case = 'onEvaluate - two evaluator';

  var got  = _.arrayFlattenDefinedOnce( [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ], [ 1, 4, 2, 5 ], ( a ) => a[ 0 ], ( b ) => b );
  test.identical( got, [ [ 1 ], [ 2 ], [ 3 ], [ 4 ], 5 ] );

  var got  = _.arrayFlattenDefinedOnce( [ [ 1 ], 5, [ 2 ], [ 3 ], [ 4 ] ], [ 1, 4, 2, 5, [ 6 ] ], ( a ) => a[ 0 ], ( b ) => b );
  test.identical( got, [ [ 1 ], 5, [ 2 ], [ 3 ], [ 4 ], 5, 6 ] );

  //

  test.case = 'single argument';

  var got = _.arrayFlattenDefinedOnce( [ 0, 1, 2, 3 ] );
  test.identical( got, [ 0, 1, 2, 3 ] );

  var got = _.arrayFlattenDefinedOnce( [ 0, 1, 0, 1 ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenDefinedOnce( [ [ 0, 0 ], [ 1, 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenDefinedOnce( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenDefinedOnce( [ 1, [ [ 0 ], 1 ], 1, 0 ] );
  test.identical( got, [ 1, 0 ] );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnce();
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnce( [], [ 1 ], ( a ) => a, ( a ) => a, ( a ) => a );
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnce( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnce( [], [ 1 ], [] );
  });
}

//

function arrayFlattenDefinedOnceStrictly( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenDefinedOnceStrictly( [], [] );
  test.identical( got, [] );

  var got = _.arrayFlattenDefinedOnceStrictly( [], [ 1, 2, 3, 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [], [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [], [ [ 1, [ 2, [ 3 ], 4 ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [], [ 1, [ 2, [ [ 3, [ 4 ] ] ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenDefinedOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ] );
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  var got  = _.arrayFlattenDefinedOnceStrictly( [ 1, 2, 3 ], [ [ [ 4 ] ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenDefinedOnceStrictly( [ 1 ], [ [ [ [ [ 0, 2, 3 ] ] ] ] ] );
  test.identical( got, [ 1, 0, 2, 3 ] );

  test.case = 'make array flat from multiple arrays as one arg';
  var got  = _.arrayFlattenDefinedOnceStrictly
  (
    [ 1, 4 ],
    [
      [ [ 2 ] ],
      [ 3, [ [ [ 5 ] ] ] ]
    ]
  );
  test.identical( got, [ 1, 4, 2, 3, 5 ] );

  //

  test.case = 'onEqualize';
  var got  = _.arrayFlattenDefinedOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ], function( a, b )
  {
    return  a === b;
  });
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  test.case = 'onEvaluate - one evaluator';
  var got  = _.arrayFlattenDefinedOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ], ( a ) => a );
  test.identical( got, [ 1, 2, 3, 4, 5 ] );

  test.case = 'onEvaluate - two evaluators';
  var got  = _.arrayFlattenDefinedOnceStrictly( [ 1, 2, 3, 4, 5 ], [ [ 5 ] ], ( a ) => a, ( b ) => b[ 0 ] );
  test.identical( got, [ 1, 2, 3, 4, 5, 5 ] );

  //

  test.case = 'dstArray has sub arrays';

  var got = _.arrayFlattenDefinedOnceStrictly( [ 1, 3, [ 5 ] ], 6 );
  test.identical( got, [ 1, 3, [ 5 ], 6 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [ [ 1, [ 3, [ 5 ] ] ], 2 ], 6 );
  test.identical( got, [ [ 1, [ 3, [ 5 ] ] ], 2, 6 ] );

  test.case = 'single argument';

  var got = _.arrayFlattenDefinedOnceStrictly( [ 0, [ 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [ [ 0 ], [ 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [ [ 0 ], 1, 2, [ 3, 4 ] ] );
  test.identical( got, [ 0, 1, 2, 3, 4 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [ 0, [ [ 2 ], 1 ], 3, 4 ] );
  test.identical( got, [ 0, 1, 2, 3, 4 ] );

  var got = _.arrayFlattenDefinedOnceStrictly( [ 1, 3, [ 7, 5 ] ] );
  test.identical( got, [ 1, 3, 7, 5 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly();
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ 1 ], ( a ) => a, ( b ) => b, ( c ) => c );
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ 1 ], [] );
  });

  test.case = 'second evaluator is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ 1 ], ( a ) => a, [] );
  });

  test.case = 'Elements must not be repeated';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ 1, 1, 2, 2, 3, 3 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenDefinedOnceStrictly( [], [ [ [ [ [ 1, 1 ] ] ] ] ]  );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenDefinedOnceStrictly( [ 0, 1, 7, 6 ], [ [ 4, [ 5, [ 6 ] ] ], 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenDefinedOnceStrictly( [ 0 ], 0 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenDefinedOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 0 ] ] ], 7 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenDefinedOnceStrictly( [ 0, 0, 1, 1 ], [ 3, 4, [ 5, [ 6 ] ] ] );
  });
}

//

function arrayFlattenedDefined( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenedDefined( [], [] );
  test.identical( got, 0 );

  var got  = _.arrayFlattenedDefined( [], [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefined( [], [ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefined( [], [ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefined( [], [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefined( [], 1, 2, '3'  );
  test.identical( got, 3 );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenedDefined( [ 1, 2, 3 ], [ 4 ] );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefined( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefined( [ 1, 2, 3 ], [ [ 1 ], [ 2 ], [ 3 ] ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefined( [ 1, 2, 3 ], [ [ 1, [ 2, [ 3 ] ] ] ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefined( [ 1 ], [ [ [ [ [ 1 ] ] ] ] ]  );
  test.identical( got, 1 );

  var got = _.arrayFlattenedDefined( [], 1 );
  test.identical( got, 1 );

  test.case = 'make array flat from multiple arrays as one arg';
  var got  = _.arrayFlattenedDefined
  (
    [],
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( got, 4 );

  test.case = 'make array flat from different inputs';

  var got = _.arrayFlattenedDefined( [ 1, 1, 3, 3, [ 5, 5 ] ], 5 );
  test.identical( got, 1 );

  var got = _.arrayFlattenedDefined( [ [ 0 ], [ [ -1, -2 ] ] ], [ 1, 1, 3, 3, [ 5, 5 ] ] );
  test.identical( got, 6 );

  //

  test.case = 'single argument';

  var got = _.arrayFlattenedDefined( [ 0, 1, 2, 3 ] )
  test.identical( got, [ 0, 1, 2, 3 ] );

  var got = _.arrayFlattenedDefined( [ [ 0, 0 ], [ 1, 1 ] ] );
  test.identical( got, [ 0, 0, 1, 1 ] );

  var got = _.arrayFlattenedDefined( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  test.identical( got, [ 0, 0, 1, 0, 1 ] );

  var got = _.arrayFlattenedDefined( [ [ [ 0 ] ] ] );
  test.identical( got, [ 0 ] );

  var got = _.arrayFlattenedDefined( [ 1, 1, 3, 3, [ 5, 5 ] ] );
  test.identical( got, [ 1, 1, 3, 3, 5, 5 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'Empty';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefined();
  });

  test.case = 'dstArray is not array';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefined( 1, [ 1 ] );
  });

  test.case = 'insArray is undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefined( [ 1 ], undefined );
  });

}

//

function arrayFlattenedDefinedOnce( test )
{
  test.case = 'make array flat, dst is empty or null';

  var got  = _.arrayFlattenedDefinedOnce( [], [] );
  test.identical( got, 0 );

  var got  = _.arrayFlattenedDefinedOnce( [], [ 1, 1, 2, 2, 3, 3, 3 ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefinedOnce( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefinedOnce( [], [ [ 1, 1, [ 2, 2, 2, [ 3, 3 ] ] ]  ] );
  test.identical( got, 3 );

  var got  = _.arrayFlattenedDefinedOnce( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( got, 1 );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenedDefinedOnce( [ 1, 2, 3, 4 ], [ 4, 2 ] );
  test.identical( got, 0 );

  var got  = _.arrayFlattenedDefinedOnce( [ 1, 2, 3 ], [ 1, 2, 3, [ [ 4 ] ] ] );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefinedOnce( [ 'a', 2, 3 ], [ [ 1 ], [ 4 ], [ 'a' ], [ 4 ] ] );
  test.identical( got, 2 );

  var got  = _.arrayFlattenedDefinedOnce( [ 1, 2, 3 ], [ [ 1, [ 2, [ 3 ] ] ], 4 ] );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefinedOnce( [ 1 ], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  test.identical( got, 0 );

  test.case = 'make array flat from multiple arrays as one arg';
  var got  = _.arrayFlattenedDefinedOnce
  (
    [ 1, 4 ],
    [
      [ 1 ],
      [ [ 2 ] ],
      [ 3, [ [ [ 4 ] ] ] ]
    ]
  );
  test.identical( got, 2 );

  //

  test.case = 'onEqualize';
  var got  = _.arrayFlattenedDefinedOnce( [ 1, 2, 3, 4 ], [ 1, 4, 2, 5 ], ( a, b ) =>  a === b );
  test.identical( got, 1 );

  test.case = 'onEvaluate - one evaluator';
  var got  = _.arrayFlattenedDefinedOnce( [ 1, 2, 3, 4 ], [ 1, 4, 2, 5 ], ( a ) => a );
  test.identical( got, 1 );

  test.case = 'onEvaluate - two evaluator';

  var got  = _.arrayFlattenedDefinedOnce( [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ], [ 1, 4, 2, 5 ], ( a ) => a[ 0 ], ( b ) => b );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefinedOnce( [ [ 1 ], 5, [ 2 ], [ 3 ], [ 4 ] ], [ 1, 4, 2, 5, [ 6 ] ], ( a ) => a[ 0 ], ( b ) => b );
  test.identical( got, 2 );

  //

  test.case = 'single argument';

  var got = _.arrayFlattenedDefinedOnce( [ 0, 1, 2, 3 ] );
  test.identical( got, [ 0, 1, 2, 3 ] );

  var got = _.arrayFlattenedDefinedOnce( [ 0, 1, 0, 1 ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenedDefinedOnce( [ [ 0, 0 ], [ 1, 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenedDefinedOnce( [ [ 0 ], 0, 1, [ 0, 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenedDefinedOnce( [ 1, [ [ 0 ], 1 ], 1, 0 ] );
  test.identical( got, [ 1, 0 ] );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnce();
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnce( [], [ 1 ], ( a ) => a, ( a ) => a, ( a ) => a );
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnce( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnce( [], [ 1 ], [] );
  });
}

//

function arrayFlattenedDefinedOnceStrictly( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenedDefinedOnceStrictly( [], [] );
  test.identical( got, 0 );

  var got = _.arrayFlattenedDefinedOnceStrictly( [], [ 1, 2, 3, 4 ] );
  test.identical( got, 4 );

  var got = _.arrayFlattenedDefinedOnceStrictly( [], [ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ] );
  test.identical( got, 4 );

  var got = _.arrayFlattenedDefinedOnceStrictly( [], [ [ 1, [ 2, [ 3 ], 4 ] ] ] );
  test.identical( got, 4 );

  var got = _.arrayFlattenedDefinedOnceStrictly( [], [ 1, [ 2, [ [ 3, [ 4 ] ] ] ] ] );
  test.identical( got, 4 );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlattenedDefinedOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ] );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefinedOnceStrictly( [ 1, 2, 3 ], [ [ [ 4 ] ] ] );
  test.identical( got, 1 );

  var got  = _.arrayFlattenedDefinedOnceStrictly( [ 1 ], [ [ [ [ [ 0, 2, 3 ] ] ] ] ] );
  test.identical( got, 3 );

  test.case = 'make array flat from multiple arrays as one arg';
  var got  = _.arrayFlattenedDefinedOnceStrictly
  (
    [ 1, 4 ],
    [
      [ [ 2 ] ],
      [ 3, [ [ [ 5 ] ] ] ]
    ]
  );
  test.identical( got, 3 );

  //

  test.case = 'onEqualize';
  var got  = _.arrayFlattenedDefinedOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ], function( a, b )
  {
    return  a === b;
  });
  test.identical( got, 1 );

  test.case = 'onEvaluate - one evaluator';
  var got  = _.arrayFlattenedDefinedOnceStrictly( [ 1, 2, 3, 4 ], [ 5 ], ( a ) => a );
  test.identical( got, 1 );

  test.case = 'onEvaluate - two evaluators';
  var got  = _.arrayFlattenedDefinedOnceStrictly( [ 1, 2, 3, 4, 5 ], [ [ 5 ] ], ( a ) => a, ( b ) => b[ 0 ] );
  test.identical( got, 1 );

  //

  test.case = 'dstArray has sub arrays';

  var got = _.arrayFlattenedDefinedOnceStrictly( [ 1, 3, [ 5 ] ], 6 );
  test.identical( got, 1 );

  var got = _.arrayFlattenedDefinedOnceStrictly( [ [ 1, [ 3, [ 5 ] ] ], 2 ], 6 );
  test.identical( got, 1 );

  test.case = 'single argument';

  var got = _.arrayFlattenedDefinedOnceStrictly( [ 0, [ 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenedDefinedOnceStrictly( [ [ 0 ], [ 1 ] ] );
  test.identical( got, [ 0, 1 ] );

  var got = _.arrayFlattenedDefinedOnceStrictly( [ [ 0 ], 1, 2, [ 3, 4 ] ] );
  test.identical( got, [ 0, 1, 2, 3, 4 ] );

  var got = _.arrayFlattenedDefinedOnceStrictly( [ 0, [ [ 2 ], 1 ], 3, 4 ] );
  test.identical( got, [ 0, 1, 2, 3, 4 ] );

  var got = _.arrayFlattenedDefinedOnceStrictly( [ 1, 3, [ 7, 5 ] ] );
  test.identical( got, [ 1, 3, 7, 5 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly();
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ 1 ], ( a ) => a, ( b ) => b, ( c ) => c );
  });

  test.case = 'first is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ 1 ], [] );
  });

  test.case = 'second evaluator is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ 1 ], ( a ) => a, [] );
  });

  test.case = 'Elements must not be repeated';
  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ 1, 1, 2, 2, 3, 3 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayFlattenedDefinedOnceStrictly( [], [ [ [ [ [ 1, 1 ] ] ] ] ]  );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedDefinedOnceStrictly( [ 0, 1, 7, 6 ], [ [ 4, [ 5, [ 6 ] ] ], 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedDefinedOnceStrictly( [ 0 ], 0 );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedDefinedOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 0 ] ] ], 7 ] );
  });

  test.shouldThrowErrorSync( function()
  {
     _.arrayFlattenedDefinedOnceStrictly( [ 0, 0, 1, 1 ], [ 3, 4, [ 5, [ 6 ] ] ] );
  });
}

//
// array replace
//

function arrayReplace( test )
{
  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplace( dst, undefined, 0 );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplace( dst, 0, 0 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplace( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplace( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'Several elements';
  var dst = [ true, true, true, true, false, false ];
  var got = _.arrayReplace( dst, false, true );
  var expected = [ true, true, true, true, true, true ];
  test.identical( got, expected );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplace( dst, 1, 0 );
  test.identical( got, [ 0, 0, 0 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplace( dst, 1, 0 );
  test.identical( got, [ 0, 2, 0 ] );
  test.is( got === dst );

  test.case = 'No match';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplace( dst, 4, 0 );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  function onEqualize( a, b )
  {
    return a.value === b;
  };

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplace( dst, 1, { value : 0 }, onEqualize );
  test.identical( got, [ { value : 0 }, { value : 0 }, { value : 2 } ] );
  test.is( got === dst );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplace( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplace( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplace( 1, 1, 1, 1);
  })
}

//

function arrayReplaceOnce( test )
{

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplaceOnce( dst, 0, 0 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaceOnce( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplaceOnce( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false, false ];
  var got = _.arrayReplaceOnce( dst, false, true );
  var expected = [ true, true, true, true, true, false ];
  test.is( got === dst );

  test.case = 'element not exists';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1, 2, 3 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'replace just first match';
  var dst = [ 0, 0, 0, 0, 0, 0 ];
  var got = _.arrayReplaceOnce( dst, 0, 1 );
  var expected = [ 1, 0, 0, 0, 0, 0 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'equalize';
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnce( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplaceOnceStrictly( test )
{

  test.case = 'repeated element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaceOnceStrictly( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaceOnceStrictly( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplaceOnceStrictly( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplaceOnceStrictly( dst, false, true );
  var expected = [ true, true, true, true, true ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'equalize';
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceOnceStrictly( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( [], 0, 0 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, 3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element two times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, 3, 1 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( [ 0, 0, 0, 0, 0, 0 ], 0, 1 );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceOnceStrictly( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplaced( test )
{
  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplaced( dst, undefined, 0 );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplaced( dst, 0, 0 );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaced( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'fourth element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplaced( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'Several elements';
  var dst = [ true, true, true, true, false, false ];
  var got = _.arrayReplaced( dst, false, true );
  var expected = [ true, true, true, true, true, true ];
  test.identical( dst, expected );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplaced( dst, 1, 0 );
  test.identical( dst, [ 0, 0, 0 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplaced( dst, 1, 0 );
  test.identical( dst, [ 0, 2, 0 ] );
  test.identical( got, 2 );

  test.case = 'No match';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaced( dst, 4, 0 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 0 );

  function onEqualize( a, b )
  {
    return a.value === b;
  }

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplaced( dst, 1, { value : 0 }, onEqualize );
  test.identical( dst, [ { value : 0 }, { value : 0 }, { value : 2 } ] );
  test.identical( got, 2 );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaced( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaced( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaced( 1, 1, 1, 1);
  })
}

//

function arrayReplacedOnce( test )
{

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplacedOnce( dst, 0, 0 );
  test.identical( dst, [] );
  test.identical( got, -1 );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplacedOnce( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'fourth element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplacedOnce( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( dst, expected );
  test.identical( got, 3 );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplacedOnce( dst, false, true );
  var expected = [ true, true, true, true, true ];
  test.identical( dst, expected );
  test.identical( got, 4 );

  test.case = 'first of several elements';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplacedOnce( dst, true, false );
  var expected = [ false, true, true, true, false ];
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'element not exists';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1, 2, 3 ];
  test.identical( dst, expected );
  test.identical( got, -1 );

  test.case = 'equalize';
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( dst, expected );
  test.identical( got, 0 );


  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnce( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplacedOnceStrictly( test )
{

  test.case = 'first element';
  var dst = [ 1, 2, 3, 4, 5 ];
  var got = _.arrayReplacedOnceStrictly( dst, 1, 2 );
  var expected = [ 2, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplacedOnceStrictly( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplacedOnceStrictly( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( dst, expected );
  test.identical( got, 3 );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplacedOnceStrictly( dst, false, true );
  var expected = [ true, true, true, true, true ];
  test.identical( dst, expected );
  test.identical( got, 4 );

  test.case = 'equalize';
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedOnceStrictly( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( dst, expected );
  test.identical( got, 0 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly( [], 0, 0 );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], 1, 4 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, 3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedOnceStrictly( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplaceElement( test )
{
  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplaceElement( dst, undefined, 0 );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplaceElement( dst, 0, 0 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaceElement( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplaceElement( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'Several elements';
  var dst = [ true, true, true, true, false, false ];
  var got = _.arrayReplaceElement( dst, false, true );
  var expected = [ true, true, true, true, true, true ];
  test.identical( got, expected );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplaceElement( dst, 1, 0 );
  test.identical( got, [ 0, 0, 0 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplaceElement( dst, 1, 0 );
  test.identical( got, [ 0, 2, 0 ] );
  test.is( got === dst );

  test.case = 'No match';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceElement( dst, 4, 0 );
  test.identical( got, [ 1, 2, 3 ] );

  function onEqualize( a, b )
  {
    return a.value === b;
  };

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplaceElement( dst, 1, { value : 0 }, onEqualize );
  test.identical( got, [ { value : 0 }, { value : 0 }, { value : 2 } ] );
  test.is( got === dst );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElement( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElement( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElement( 1, 1, 1, 1);
  })
}

//

function arrayReplaceElement2( test )
{
  test.case = 'replace all ins with sub';

  var dst = [];
  var got = _.arrayReplaceElement( dst, undefined, 0 );
  test.identical( got, [] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplaceElement( dst, 1, 0 );
  test.identical( got, [ 0, 0, 0 ] );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplaceElement( dst, 1, 0 );
  test.identical( got, [ 0, 2, 0 ] );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceElement( dst, 4, 0 );
  test.identical( got, [ 1, 2, 3 ] );

  function onEqualize( a, b )
  {
    return a.value === b;
  }

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplaceElement( dst, 1, { value : 0 }, onEqualize );
  test.identical( got, [ { value : 0 }, { value : 0 }, { value : 2 } ] );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElement( );
  });

  test.case = 'first arg is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElement( 1, 1, 1 );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElement( 1, 1, 1, 1);
  });
}

//

function arrayReplaceElementOnce( test )
{

  test.case = 'nothing';
  var dst = [ ];
  var got = _.arrayReplaceElementOnce( dst, 0, 0 );
  var expected = [];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaceElementOnce( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplaceElementOnce( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false, false ];
  var got = _.arrayReplaceElementOnce( dst, false, true );
  var expected = [ true, true, true, true, true, false ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'element not exists';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceElementOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1, 2, 3 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'replace just first match';
  var dst = [ 0, 0, 0, 0, 0, 0 ];
  var got = _.arrayReplaceElementOnce( dst, 0, 1 );
  var expected = [ 1, 0, 0, 0, 0, 0 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'equalize';
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceElementOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnce( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplaceElementOnceStrictly( test )
{

  test.case = 'second element';
  var dst = [ 1, 0, 3, 4, 5 ];
  var got = _.arrayReplaceElementOnceStrictly( dst, 0, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplaceElementOnceStrictly( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplaceElementOnceStrictly( dst, false, true );
  var expected = [ true, true, true, true, true ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'equalize';
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceElementOnceStrictly( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( [], 0, 0 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, 3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element two times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, 3, 1 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 0, 0, 0, 0, 0, 0 ], 0, 1 );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceElementOnceStrictly( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplacedElement( test )
{
  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplacedElement( dst, undefined, 0 );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplacedElement( dst, 0, 0 );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplacedElement( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'fourth element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplacedElement( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'Several elements';
  var dst = [ true, true, true, true, false, false ];
  var got = _.arrayReplacedElement( dst, false, true );
  var expected = [ true, true, true, true, true, true ];
  test.identical( dst, expected );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplacedElement( dst, 1, 0 );
  test.identical( dst, [ 0, 0, 0 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplacedElement( dst, 1, 0 );
  test.identical( dst, [ 0, 2, 0 ] );
  test.identical( got, 2 );

  test.case = 'No match';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedElement( dst, 4, 0 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 0 );

  function onEqualize( a, b )
  {
    return a.value === b;
  }

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplacedElement( dst, 1, { value : 0 }, onEqualize );
  test.identical( dst, [ { value : 0 }, { value : 0 }, { value : 2 } ] );
  test.identical( got, 2 );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElement( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElement( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElement( 1, 1, 1, 1);
  })
}

//

function arrayReplacedElement2( test )
{
  test.case = 'replace all ins with sub';

  var dst = [];
  var got = _.arrayReplacedElement( dst, undefined, 0 );
  test.identical( got, 0 );
  test.identical( dst, [] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplacedElement( dst, 1, 0 );
  test.identical( got, 3 );
  test.identical( dst, [ 0, 0, 0 ] );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplacedElement( dst, 1, 0 );
  test.identical( got, 2 );
  test.identical( dst, [ 0, 2, 0 ] );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedElement( dst, 4, 0 );
  test.identical( got, 0 );
  test.identical( dst, [ 1, 2, 3 ] );

  function onEqualize( a, b )
  {
    return a.value === b;
  }

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplacedElement( dst, 1, { value : 0 }, onEqualize );
  test.identical( got, 2 );
  test.identical( dst, [ { value : 0 }, { value : 0 }, { value : 2 } ] );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElement( );
  });

  test.case = 'first arg is not longIs';
  debugger;
  test.shouldThrowErrorSync( function()
  {
    debugger;
    _.arrayReplacedElement( 1, 1, 1 );
  });
  debugger;

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElement( 1, 1, 1, 1 );
  });

}

//

function arrayReplacedElementOnce( test )
{

  test.case = 'nothing';
  var dst = [];
  var got = _.arrayReplacedElementOnce( dst, 0, 0 );
  test.identical( dst, [] );
  test.identical( got, undefined );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplacedElementOnce( dst, undefined, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, undefined );

  test.case = 'fourth element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplacedElementOnce( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( dst, expected );
  test.identical( got, 'Dmitry' );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplacedElementOnce( dst, false, true );
  var expected = [ true, true, true, true, true ];
  test.identical( dst, expected );
  test.identical( got, false );

  test.case = 'first of several elements';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplacedElementOnce( dst, true, false );
  var expected = [ false, true, true, true, false ];
  test.identical( dst, expected );
  test.identical( got, true );

  test.case = 'element not exists';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedElementOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1, 2, 3 ];
  test.identical( dst, expected );
  test.identical( got, undefined );

  test.case = 'equalize';
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedElementOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( dst, expected );
  test.identical( got, [ 1 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnce( 'wrong argument', undefined, 3 );
  });
}

//

function arrayReplacedElementOnceStrictly( test )
{

  test.case = 'first element';
  var dst = [ 1, 2, 3, 4, 5 ];
  var got = _.arrayReplacedElementOnceStrictly( dst, 1, 2 );
  var expected = [ 2, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 1 );

  test.case = 'second element';
  var dst = [ 1, 0, 3, 4, 5 ];
  var got = _.arrayReplacedElementOnceStrictly( dst, 0, 2 );
  var expected = [ 1, 2, 3, 4, 5 ] ;
  test.identical( dst, expected );
  test.identical( got, 0 );

  test.case = 'third element';
  var dst = [ 'Petre', 'Mikle', 'Oleg', 'Dmitry' ];
  var got = _.arrayReplacedElementOnceStrictly( dst, 'Dmitry', 'Bob' );
  var expected = [ 'Petre', 'Mikle', 'Oleg', 'Bob' ];
  test.identical( dst, expected );
  test.identical( got, 'Dmitry' );

  test.case = 'fourth element';
  var dst = [ true, true, true, true, false ];
  var got = _.arrayReplacedElementOnceStrictly( dst, false, true );
  var expected = [ true, true, true, true, true ];
  test.identical( dst, expected );
  test.identical( got, false );

  test.case = 'equalize';
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedElementOnceStrictly( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ], 2, 3 ];
  test.identical( dst, expected );
  test.identical( got, [ 1 ] );
/*
  test.case = 'element several times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3, 4 ], 4, 1 );
  });
*/
  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [], 0, 0 );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], 1, 4 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 0, 4, 5 ], 0, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( 'wrong argument', 0, 3 );
  });

  test.case = 'second argument is undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });
}

//

function arrayReplaceArray( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplaceArray( dst, [], [] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArray( dst, [], [] );
  test.identical( got, [ 'a', 'b', 'c', 'd' ] );
  test.is( got === dst );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArray( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArray( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 1 ];
  var got = _.arrayReplaceArray( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4, 5, 4, 3, 2, 1 ];
  var got = _.arrayReplaceArray( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3, 6, 5, 6, 3, 2, 3 ] );
  test.is( got === dst );

  test.case = 'ins has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArray( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'ins and dst have undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplaceArray( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 0, 3 ] );
  test.is( got === dst );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArray( dst, [ 1 ], [ undefined ] );
  test.identical( got, [ 2, 3 ] );
  test.is( got === dst );

  test.case = 'ins and sub have mirror elements';
  var dst = [ 0, 0, 0, 1, 1, 1, 0, 1 ];
  var got = _.arrayReplaceArray( dst, [ 1, 0 ], [ 0, 1 ] );
  test.identical( got, [ 1, 1, 1, 1, 1, 1, 1, 1] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c', false, 'c', 'b', 'a', true, 2 ];
  var got = _.arrayReplaceArray( dst, [ 'a', 'b', 'c', false, true ], [ 'c', 'a', 'b', true, false ] );
  test.identical( got, [ 'b', 'a', 'b', false, 'b', 'a', 'b', false, 2 ] );
  test.is( got === dst );

  test.case = 'onEqualize'

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize( a, b )
  {
    return a[ 0 ] === b[ 0 ];
  }
  var got = _.arrayReplaceArray( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize );
  test.identical( got, [ [ 0 ], [ 2 ], [ 3 ] ] );
  test.is( got === dst );

  /* */

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceArray( dst, dst, [ 4,5,6 ] );
  test.identical( got, dst );
  test.identical( got, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceArray( dst, dst, [ 4,5,6 ], ( e ) => e );
  test.identical( got, dst );
  test.identical( got, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceArray( dst, dst, [ 4,5,6 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, dst );
  test.identical( got, [ 1,2,3 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,1 ];
  var got = _.arrayReplaceArray( dst, dst, [ 2,1 ] );
  test.identical( got, [ 2,2 ] );
  test.identical( got, dst );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArray();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArray( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArray( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArray( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayReplaceArray( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'not equal length of ins and sub';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArray( [ 1, 2, 3 ], [ 1, 2 ], [ 3 ] );
  });

}

//

function arrayReplaceArrayOnce( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplaceArrayOnce( dst, [], [] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArrayOnce( dst, [], [] );
  test.identical( got, [ 'a', 'b', 'c', 'd' ] );
  test.is( got === dst );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrayOnce( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrayOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 1 ];
  var got = _.arrayReplaceArrayOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3, 1 ] );
  test.is( got === dst );

  test.case = 'ins has undefined';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrayOnce( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'ins and dst has undefined';

  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplaceArrayOnce( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 0, 3 ] );
  test.is( got === dst );

  test.case = 'sub has undefined';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrayOnce( dst, [ 1 ], [ undefined ] );
  test.identical( got, [ 2, 3 ] );
  test.is( got === dst );

  test.case = 'onEqualize'

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize( a, b )
  {
    return a[ 0 ] === b[ 0 ];
  }
  var got = _.arrayReplaceArrayOnce( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize );
  test.identical( got, [ [ 0 ], [ 2 ], [ 3 ] ] );
  test.is( got === dst );

  test.case = 'ins and sub have mirror elements';
  var dst = [ 0, 0, 0, 1, 1, 1, 0, 1 ];
  var got = _.arrayReplaceArrayOnce( dst, [ 1, 0 ], [ 0, 1 ] );
  test.identical( got, [ 1, 0, 0, 0, 1, 1, 0, 1 ] );
  test.is( got === dst );

  /* */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnce( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === ins';
  var dst = [ 1,1 ];
  var got = _.arrayReplaceArrayOnce( dst, dst, [ 2,1 ] );
  test.identical( got, dst );
  test.identical( got, [ 2,1 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnce();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnce( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnce( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnce( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayReplaceArrayOnce( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'not equal length of ins and sub';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnce( [ 1, 2, 3 ], [ 1, 2 ], [ 3 ] );
  });

}

//

function arrayReplaceArrayOnceStrictly( test )
{

  test.case = 'trivial';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [ 'a', 'b', 'c' ], [ 'x', 'y', undefined ] );
  test.identical( got, [ 'x', 'y', 'd' ] );
  test.is( got === dst );

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [], [] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [], [] );
  test.identical( got, [ 'a', 'b', 'c', 'd' ] );
  test.is( got === dst );

  test.case = 'only sub is empty';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [ 'a', 'b', 'c' ], [ undefined, undefined, undefined ] );
  test.identical( got, [ 'd' ] );
  test.is( got === dst );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [ 1, 2 ], [ 3, undefined ] );
  test.identical( got, [ 3, 3 ] );
  test.is( got === dst );

  test.case = 'ins and dst has undefined';

  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 0, 3 ] );
  test.is( got === dst );

  test.case = 'onEqualize'

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize( a, b )
  {
    return a[ 0 ] === b[ 0 ];
  }
  var got = _.arrayReplaceArrayOnceStrictly( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize );
  test.identical( got, [ [ 0 ], [ 2 ], [ 3 ] ] );
  test.is( got === dst );

  /* */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, got );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, got );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, got );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, got );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayReplaceArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayReplaceArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 )
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === ins';
  var dst = [ 1,1 ];
  var got = _.arrayReplaceArrayOnceStrictly( dst, dst, [ 2,1 ] );
  test.identical( got, dst );
  test.identical( got, [ 2,1 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly();
  })

  test.shouldThrowErrorSync( function()
  {
    var dst = [ 1, 2, 3 ];
    _.arrayReplaceArrayOnceStrictly( dst, [ undefined ], 0 );
  })

  test.case = 'only one replaced';
  test.shouldThrowErrorSync( function()
  {
    var dst = [ 1, 2, 3 ];
    _.arrayReplaceArrayOnceStrictly( dst, [ 1, 0, 4 ], 3 );
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'ins element several times in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 1 ], 1, 2 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 2, 3, 4, 1, 2, 3 ], [ 1, 2, 3 ], [ 6, 7, 8 ] );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  })

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dst, ins are empty, sub is not, dst does not has ins';

  test.shouldThrowErrorSync( function()
  {
    var dst = [];
    _.arrayReplaceArrayOnceStrictly( dst, [ undefined ], [ 'x' ] );
  });

  test.case = 'dst does not has ins';

  test.shouldThrowErrorSync( function()
  {
    var dst = [ 'b', 'c' ];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [ 'a' ], [ 'x' ] );
  });

  test.case = 'dst, sub are empty, ins is not';

  test.shouldThrowErrorSync( function()
  {
    var dst = [];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [ 'a', 'b' ], [] );
  });

  test.case = 'only ins is empty';

  test.shouldThrowErrorSync( function()
  {
    var dst = [ 'a', 'b', 'c', 'd' ];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [], [ 'x', 'y' ] );
  });

  test.case = 'not equal length of ins and sub';

  test.shouldThrowErrorSync( function()
  {
    var dst = [ 1, 2, 3 ];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [ 1, 2 ], [ 3 ] );
  });

}

//

function arrayReplacedArray( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplacedArray( dst, [], [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplacedArray( dst, [], [] );
  test.identical( dst, [ 'a', 'b', 'c', 'd' ] );
  test.identical( got, 0 );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 3, 2, 3 ] );
  test.identical( got, 1 );

  test.case = 'Repeated elements in dstArray';

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3, 2, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3, 4, 3, 2, 1 ];
  var got = _.arrayReplacedArray( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3, 4, 3, 4, 3 ] );
  test.identical( got, 4 );

  var dst = [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ];
  var got = _.arrayReplacedArray( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 5, 5, 3, 3, 2, 2, 3, 3, 6, 6 ] );
  test.identical( got, 6 );


  test.case = 'ins has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 0 );

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplacedArray( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 0, 3 ] );
  test.identical( got, 1 );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ 2 ], [ undefined ] );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  test.case = 'Element repeated in ins';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArray( dst, [ 2, 2, 2 ], [ 'a', 'b', 'c' ] );
  test.identical( dst, [ 1, 'a', 3 ] );
  test.identical( got, 1 );

  test.case = 'ins and sub have mirror elements';
  var dst = [ 0, 0, 0, 1, 1, 1 ];
  var got = _.arrayReplacedArray( dst, [ 0, 1 ], [ 1, 0 ] );
  test.identical( dst, [ 0, 0, 0, 0, 0, 0 ] );
  test.identical( got, 9 );

  var dst = [ 0, 0, 0, 1, 1, 1, 0, 1 ];
  var got = _.arrayReplacedArray( dst, [ 1, 0 ], [ 0, 1 ] );
  test.identical( dst, [  1, 1, 1, 1, 1, 1, 1, 1 ] );
  test.identical( got, 12 );

  var dst = [ 'a', 'b', 'c', false, 'c', 'b', 'a', true, 2 ];
  var got = _.arrayReplacedArray( dst, [ 'a', 'b', 'c', false, true ], [ 'c', 'a', 'b', true, false ] );
  test.identical( dst, [ 'b', 'a', 'b', false, 'b', 'a', 'b', false, 2 ] );
  test.identical( got, 11 );

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedArray( dst, dst, [ 4,5,6 ] );
  test.identical( got, 3 );
  test.identical( dst, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedArray( dst, dst, [ 4,5,6 ], ( e ) => e );
  test.identical( got, 3 );
  test.identical( dst, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedArray( dst, dst, [ 4,5,6 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArray( dst, dst, [ 2,1 ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,2 ] );

  test.case = 'dst === ins === sub, equalize';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArray( dst, dst, dst );
  test.identical( got, 2 );
  test.identical( dst, [ 1,1 ] );

  test.case = 'onEqualize'
  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize( a, b )
  {
    return a[ 0 ] === b[ 0 ];
  }
  var got = _.arrayReplacedArray( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize );
  test.identical( dst, [ [ 0 ], [ 2 ], [ 3 ] ] );
  test.identical( got, 1 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArray();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArray( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArray( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArray( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayReplacedArray( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
     _.arrayReplacedArray( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

}

//

function arrayReplacedArrayOnce( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplacedArrayOnce( dst, [], [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplacedArrayOnce( dst, [], [] );
  test.identical( dst, [ 'a', 'b', 'c', 'd' ] );
  test.identical( got, 0 );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 3, 2, 3 ] );
  test.identical( got, 1 );

  test.case = 'Repeated elements in dstArray';

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3, 1, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3, 4, 3, 2, 1 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3, 4, 3, 2, 1 ] );
  test.identical( got, 2 );

  var dst = [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 5, 0, 3, 1, 2, 2, 3, 3, 6, 4 ] );
  test.identical( got, 3 );

  test.case = 'ins has undefined';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 0 );

  test.case = 'ins and dst has undefined';

  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 0, 3 ] );
  test.identical( got, 1 );

  test.case = 'sub has undefined';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnce( dst, [ 2 ], [ undefined ] );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  test.case = 'onEqualize'

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize( a, b )
  {
    return a[ 0 ] === b[ 0 ];
  }
  var got = _.arrayReplacedArrayOnce( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize );
  test.identical( dst, [ [ 0 ], [ 2 ], [ 3 ] ] );
  test.identical( got, 1 );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnce( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === ins';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArrayOnce( dst, dst, [ 2,1 ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,1 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnce();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnce( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnce( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnce( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.arrayReplacedArrayOnce( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
     _.arrayReplacedArrayOnce( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

}

//

function arrayReplacedArrayOnceStrictly( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplacedArrayOnceStrictly( dst, [], [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, [], [] );
  test.identical( dst, [ 'a', 'b', 'c', 'd' ] );
  test.identical( got, 0 );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3 ] );
  test.identical( got, 2 );

  test.case = 'ins and dst have undefined';

  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 0, 3 ] );
  test.identical( got, 1 );

  test.case = 'sub has undefined';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, [ 2 ], [ undefined ] );
  test.identical( dst, [ 1, 3 ] );
  test.identical( got, 1 );

  test.case = 'onEqualize'

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize( a, b )
  {
    return a[ 0 ] === b[ 0 ];
  }
  var got = _.arrayReplacedArrayOnceStrictly( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize );
  test.identical( dst, [ [ 0 ], [ 2 ], [ 3 ] ] );
  test.identical( got, 1 );

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayReplacedArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayReplacedArrayOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 )
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === inst';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArrayOnceStrictly( dst, dst, [ 2,1 ] );
  test.identical( dst, [ 2,1 ] );
  test.identical( got, 2 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

  test.case = 'Repeated elements in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], [ 1 ], [ 2 ] );
  });
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ 1, 2 ], [ 3, 4 ] );
  });
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.case = 'Element not found in dstArray';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ undefined ], [ 10 ] );
  });

}

//

function arrayReplaceArrays( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplaceArrays( dst, [], [] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArrays( dst, [], [] );
  test.identical( got, [ 'a', 'b', 'c', 'd' ] );
  test.is( got === dst );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrays( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrays( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( got, [ 3, 4, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrays( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3 ] );
  test.is( got === dst );

  test.case = 'Repeated elements in dstArray';

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayReplaceArrays( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3, 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4, 3, 2, 1 ];
  var got = _.arrayReplaceArrays( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( got, [ 3, 4, 3, 4, 3, 4, 3 ] );
  test.is( got === dst );

  var dst = [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ];
  var got = _.arrayReplaceArrays( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 5, 5, 3, 3, 2, 2, 3, 3, 6, 6 ] );
  test.is( got === dst );

  test.case = 'ins has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrays( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplaceArrays( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 0, 3 ] );
  test.is( got === dst );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArrays( dst, [ 2 ], [ undefined ] );
  test.identical( got, [ 1, undefined, 3 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays';
  var dst = [ 0, 1, 2, 3, 4, 5, 0 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], 2, [ 5 ] ], [ [ '0', '1' ], '2', [ '5' ] ] );
  test.identical( got, [ '0', '1', '2', 3, 4, '5', '0' ] );
  test.is( got === dst );

  var dst = [ 0, 'a', 'b', false, true, 'c', 0 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, false ] ], [ [ 1, true ] ] );
  test.identical( got, [ 1, 'a', 'b', true, true, 'c', 1 ] );
  test.is( got === dst );

  var dst = [ 0, 0, 0, 2, 1, 0, 0 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], 0 ], [ [ 1, 0 ], '0' ] );
  test.identical( got, [ '0', '0', '0', 2, '0', '0', '0'] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 0, 0, 0 ] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 'a', 'a', 'c' ] );
  test.is( got === dst );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ true, true, true, true ] );
  test.is( got === dst );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 'a', true, 2, 'c', true, 'a', 0 ] );
  test.is( got === dst );

  test.case = 'onEqualize'

  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize1( a, b )
  {
    return a[ 0 ] === b;
  }
  var got = _.arrayReplaceArrays( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize1 );
  test.identical( got, [ 0, [ 2 ], [ 3 ] ] );
  test.is( got === dst );

  test.case = 'onEqualize'

  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var got = _.arrayReplaceArrays( dst, [ [ [ 1 ] ] ], [ [ [ 0 ] ] ], onEqualize );
  test.identical( got, [ [ 0 ], 2, 3 ] );
  test.is( got === dst );

  /* */

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceArrays( dst, dst, [ 4,5,6 ] );
  test.identical( got, dst );
  test.identical( dst, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceArrays( dst, dst, [ 4,5,6 ], ( e ) => e );
  test.identical( got, dst );
  test.identical( dst, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceArrays( dst, dst, [ 4,5,6 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, dst );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,1 ];
  var got = _.arrayReplaceArrays( dst, dst, [ 2,1 ] );
  test.identical( got, [ 2,2 ] );
  test.identical( got, dst );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrays();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrays( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrays( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArrays( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
     _.arrayReplaceArrays( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

}

//

function arrayReplaceArraysOnce( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplaceArraysOnce( dst, [], [] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArraysOnce( dst, [], [] );
  test.identical( got, [ 'a', 'b', 'c', 'd' ] );
  test.is( got === dst );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( got, [ 3, 4, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 2, 3 ] );
  test.is( got === dst );

  test.case = 'Repeated elements in dstArray';

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3, 4, 3, 2, 1 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( got, [ 3, 4, 3, 4, 3, 2, 1 ] );
  test.is( got === dst );

  var dst = [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( got, [ 5, 0, 3, 1, 2, 2, 3, 3, 6, 4 ] );
  test.is( got === dst );

  test.case = 'ins has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 0, 3 ] );
  test.is( got === dst );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnce( dst, [ 2 ], [ undefined ] );
  test.identical( got, [ 1, undefined, 3 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays';
  var dst = [ 0, 1, 2, 3, 4, 5, 0 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], 2, [ 5 ] ], [ [ '0', '1' ], '2', [ '5' ] ] );
  test.identical( got, [ '0', '1', '2', 3, 4, '5', 0 ] );
  test.is( got === dst );

  var dst = [ 0, 'a', 'b', false, true, 'c', 0 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, false ] ], [ [ 1, true ] ] );
  test.identical( got, [ 1, 'a', 'b', true, true, 'c', 0 ] );
  test.is( got === dst );

  var dst = [ 0, 0, 0, 2, 1, 0, 0 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], 0 ], [ [ 1, 0 ], '0' ] );
  test.identical( got, [ '0', 0, 0, 2, 1, 0, 0 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 1, 1, 0 ] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 'a', 'b', 'c' ] );
  test.is( got === dst );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ true, false, true, false] );
  test.is( got === dst );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 'a', true, 2, 'c', false, 'b', 1 ] );
  test.is( got === dst );

  test.case = 'onEqualize'
  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize1( a, b )
  {
    return a[ 0 ] === b;
  }
  var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize1 );
  test.identical( got, [ 0, [ 2 ], [ 3 ] ] );
  test.is( got === dst );

  test.case = 'onEqualize'
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var got = _.arrayReplaceArraysOnce( dst, [ [ [ 1 ] ] ], [ [ [ 0 ] ] ], onEqualize );
  test.identical( got, [ [ 0 ], 2, 3 ] );
  test.is( got === dst );

  /* */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnce( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, dst );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src';
  var dst = [ 1,1 ];
  var got = _.arrayReplaceArraysOnce( dst, dst, [ 2,1 ] );
  test.identical( got, dst );
  test.identical( dst, [ 2,1 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnce();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnce( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnce( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnce( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
     _.arrayReplaceArraysOnce( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

}

//

function arrayReplaceArraysOnceStrictly( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [], [] );
  test.identical( got, [] );
  test.is( got === dst );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [], [] );
  test.identical( got, [ 'a', 'b', 'c', 'd' ] );
  test.is( got === dst );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ 1 ], [ 2 ] );
  test.identical( got, [ 2, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( got, [ 3, 4, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ 1, 2, 3 ], [ 4, 5, 6 ] );
  test.identical( got, [ 4, 5, 6 ] );
  test.is( got === dst );

  test.case = 'ins has undefined';

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ undefined ], [ 0 ] );
  test.identical( got, [ 1, 0, 3 ] );
  test.is( got === dst );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ 2 ], [ undefined ] );
  test.identical( got, [ 1, undefined, 3 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays';
  var dst = [ 0, 1, 2, 3, 4, 5, 0 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 0, 1 ], 2, [ 5 ] ], [ [ '0', '1' ], '2', [ '5' ] ] );
  test.identical( got, [ '0', '1', '2', 3, 4, '5', 0 ] );
  test.is( got === dst );

  var dst = [ 0, 'a', 'b', false, true, 'c', 0 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 0, false ] ], [ [ 1, true ] ] );
  test.identical( got, [ 1, 'a', 'b', true, true, 'c', 0 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays with mirror elements';

  var dst = [ 1, 0 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 0, 1 ] ], [ [ 1, 0 ] ] );
  test.identical( got, [ 0, 1 ] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 'a', 'b' ] ], [ [ 'b', 'a' ] ] );
  test.identical( got, [ 'a', 'b', 'c' ] );
  test.is( got === dst );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ true, false ] ], [ [ false, true ] ] );
  test.identical( got, [ true, false, true, false ] );
  test.is( got === dst );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 'a', true, 2, 'c', false, 'b', 1 ] );
  test.is( got === dst );

  test.case = 'onEqualize'
  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize1( a, b )
  {
    return a[ 0 ] === b;
  };
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize1 );
  test.identical( got, [ 0, [ 2 ], [ 3 ] ] );
  test.is( got === dst );

  test.case = 'onEqualize'
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ [ 1 ] ] ], [ [ [ 0 ] ] ], onEqualize );
  test.identical( got, [ [ 0 ], 2, 3 ] );
  test.is( got === dst );

  /* */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, dst );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayReplaceArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayReplaceArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 )
    test.identical( got, dst );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === ins';
  var dst = [ 1,1 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, dst, [ 2,1 ] );
  test.identical( dst, [ 2,1 ] );
  test.identical( got, dst );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

  test.case = 'ins element is not in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3 ], [ undefined ], [ 0 ] );
  });

  test.case = 'Repeated elements in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], [ 1 ], [ 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ 1, 2 ], [ 3, 4 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 0, 0, 0, 2, 1, 0, 0 ], [ [ 0, 1 ], 0 ], [ [ 1, 0 ], '0' ] );
  });

}

//

function arrayReplacedArrays( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplacedArrays( dst, [], [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplacedArrays( dst, [], [] );
  test.identical( dst, [ 'a', 'b', 'c', 'd' ] );
  test.identical( got, 0 );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrays( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrays( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrays( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 3, 2, 3 ] );
  test.identical( got, 1 );

  test.case = 'Repeated elements in dstArray';

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayReplacedArrays( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3, 2, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3, 4, 3, 2, 1 ];
  var got = _.arrayReplacedArrays( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3, 4, 3, 4, 3 ] );
  test.identical( got, 4 );

  var dst = [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ];
  var got = _.arrayReplacedArrays( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 5, 5, 3, 3, 2, 2, 3, 3, 6, 6 ] );
  test.identical( got, 6 );


  test.case = 'ins has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrays( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 0 );

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplacedArrays( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 0, 3 ] );
  test.identical( got, 1 );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArrays( dst, [ 2 ], [ undefined ] );
  test.identical( dst, [ 1, undefined, 3 ] );
  test.identical( got, 1 );

  test.case = 'ins and sub Array of arrays';
  var dst = [ 0, 1, 2, 3, 4, 5, 0 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], 2, [ 5 ] ], [ [ '0', '1' ], '2', [ '5' ] ] );
  test.identical( dst, [ '0', '1', '2', 3, 4, '5', '0' ] );
  test.identical( got, 5 );

  var dst = [ 0, 'a', 'b', false, true, 'c', 0 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, false ] ], [ [ 1, true ] ] );
  test.identical( dst, [ 1, 'a', 'b', true, true, 'c', 1 ] );
  test.identical( got, 3 );

  var dst = [ 0, 0, 0, 2, 1, 0, 0 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], 0 ], [ [ 1, 0 ], '0' ] );
  test.identical( dst, [ '0', '0', '0', 2, '0', '0', '0' ] );
  test.identical( got, 17 );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [  0, 0, 0, 0 ] );
  test.identical( got, 6 );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 'a', 'a', 'c' ] );
  test.identical( got, 3 );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ true, true, true, true ] );
  test.identical( got, 6 );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 0, 'a', true, 2, 'c', true, 'a', 0 ] );
  test.identical( got, 9 );

  test.case = 'onEqualize'
  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize1( a, b )
  {
    return a[ 0 ] === b;
  }
  var got = _.arrayReplacedArrays( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize1 );
  test.identical( dst, [ 0, [ 2 ], [ 3 ] ] );
  test.identical( got, 1 );

  test.case = 'onEqualize'
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var got = _.arrayReplacedArrays( dst, [ [ [ 1 ] ] ], [ [ [ 0 ] ] ], onEqualize );
  test.identical( dst, [ [ 0 ], 2, 3 ] );
  test.identical( got, 1 );

  /* */

  test.case = 'dst === src';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedArrays( dst, dst, [ 4,5,6 ] );
  test.identical( got, 3 );
  test.identical( dst, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedArrays( dst, dst, [ 4,5,6 ], ( e ) => e );
  test.identical( got, 3 );
  test.identical( dst, [ 4,5,6 ] );

  test.case = 'dst === src, equalize';
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedArrays( dst, dst, [ 4,5,6 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,2,3 ] );

  test.case = 'dst === src, loop check';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArrays( dst, dst, [ 2,1 ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,2 ] );

  test.case = 'dst === src ';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArrays( dst, [ dst ], [ [ 2,1 ] ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,2 ] );

  test.case = 'dst === src ';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArrays( dst, [ dst ], [ dst ] );
  test.identical( got, 2 );
  test.identical( dst, [ 1,1 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrays();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrays( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrays( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArrays( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
     _.arrayReplacedArrays( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

}

//

function arrayReplacedArraysOnce( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplacedArraysOnce( dst, [], [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplacedArraysOnce( dst, [], [] );
  test.identical( dst, [ 'a', 'b', 'c', 'd' ] );
  test.identical( got, 0 );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 3, 2, 3 ] );
  test.identical( got, 1 );

  test.case = 'Repeated elements in dstArray';

  var dst = [ 1, 2, 3, 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3, 1, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3, 4, 3, 2, 1 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3, 4, 3, 2, 1 ] );
  test.identical( got, 2 );

  var dst = [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 1, 0, 4 ], [ 3, 5, 6 ] );
  test.identical( dst, [ 5, 0, 3, 1, 2, 2, 3, 3, 6, 4 ] );
  test.identical( got, 3 );


  test.case = 'ins has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 0 );

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 0, 3 ] );
  test.identical( got, 1 );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnce( dst, [ 2 ], [ undefined ] );
  test.identical( dst, [ 1, undefined, 3 ] );
  test.identical( got, 1 );

  test.case = 'ins and sub Array of arrays';
  var dst = [ 0, 1, 2, 3, 4, 5, 0 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], 2, [ 5 ] ], [ [ '0', '1' ], '2', [ '5' ] ] );
  test.identical( dst, [ '0', '1', '2', 3, 4, '5', 0 ] );
  test.identical( got, 4 );

  var dst = [ 0, 'a', 'b', false, true, 'c', 0 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, false ] ], [ [ 1, true ] ] );
  test.identical( dst, [ 1, 'a', 'b', true, true, 'c', 0 ] );
  test.identical( got, 2 );

  var dst = [ 0, 0, 0, 2, 1, 0, 0 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], 0 ], [ [ 1, 0 ], '0' ] );
  test.identical( dst, [ '0', 0, 0, 2, 1, 0, 0 ] );
  test.identical( got, 3 );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 0, 1, 1, 0 ] );
  test.identical( got, 2 );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 'a', 'b', 'c' ] );
  test.identical( got, 2 );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ true, false, true, false ] );
  test.identical( got, 2 );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 0, 'a', true, 2, 'c', false, 'b', 1 ] );
  test.identical( got, 6 );

  test.case = 'onEqualize'
  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize1( a, b )
  {
    return a[ 0 ] === b;
  }
  var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize1 );
  test.identical( dst, [ 0, [ 2 ], [ 3 ] ] );
  test.identical( got, 1 );

  test.case = 'onEqualize'
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var got = _.arrayReplacedArraysOnce( dst, [ [ [ 1 ] ] ], [ [ [ 0 ] ] ], onEqualize );
  test.identical( dst, [ [ 0 ], 2, 3 ] );
  test.identical( got, 1 );

  /* */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnce( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnce( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 );
  test.identical( got, 0 );
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === src, loop check';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArraysOnce( dst, dst, [ 2,1 ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,1 ] );

  test.case = 'dst === src ';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArraysOnce( dst, [ dst ], [ [ 2,1 ] ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,1 ] );

  test.case = 'dst === src ';
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArraysOnce( dst, [ dst ], [ dst ] );
  test.identical( got, 2 );
  test.identical( dst, [ 1,1 ] );


  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnce();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnce( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnce( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnce( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
     _.arrayReplacedArraysOnce( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

}

//

function arrayReplacedArraysOnceStrictly( test )
{

  test.case = 'dst, ins, sub are empty';

  var dst = [];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [], [] );
  test.identical( dst, [] );
  test.identical( got, 0 );

  test.case = 'ins, sub are empty, dst is not';

  var dst = [ 'a', 'b', 'c', 'd' ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [], [] );
  test.identical( dst, [ 'a', 'b', 'c', 'd' ] );
  test.identical( got, 0 );

  test.case = 'other';

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ 1 ], [ 2 ] );
  test.identical( dst, [ 2, 2, 3 ] );
  test.identical( got, 1 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ 1, 2 ], [ 3, 4 ] );
  test.identical( dst, [ 3, 4, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ 1, 2, 3 ], [ 4, 5, 6 ] );
  test.identical( dst, [ 4, 5, 6 ] );
  test.identical( got, 3  );

  test.case = 'ins has undefined';

  test.case = 'ins and dst has undefined';
  var dst = [ 1, undefined, 3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ undefined ], [ 0 ] );
  test.identical( dst, [ 1, 0, 3 ] );
  test.identical( got, 1 );

  test.case = 'sub has undefined';
  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ 2 ], [ undefined ] );
  test.identical( dst, [ 1, undefined, 3 ] );
  test.identical( got, 1 );

  test.case = 'ins and sub Array of arrays';
  var dst = [ 0, 1, 2, 3, 4, 5, 0 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 0, 1 ], 2, [ 5 ] ], [ [ '0', '1' ], '2', [ '5' ] ] );
  test.identical( dst, [ '0', '1', '2', 3, 4, '5', 0 ] );
  test.identical( got, 4 );

  var dst = [ 0, 'a', 'b', false, true, 'c', 0 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 0, false ] ], [ [ 1, true ] ] );
  test.identical( dst, [ 1, 'a', 'b', true, true, 'c', 0 ] );
  test.identical( got, 2 );

  test.case = 'ins and sub Array of arrays with mirror elements';

  var dst = [ 1, 0 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 0, 1 ] ], [ [ 1, 0 ] ] );
  test.identical( dst, [ 0, 1 ]  );
  test.identical( got, 2 );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 'a', 'b' ] ], [ [ 'b', 'a' ] ] );
  test.identical( dst, [ 'a', 'b', 'c'  ]  );
  test.identical( got, 2 );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ true, false ] ], [ [ false, true ] ] );
  test.identical( dst, [ true, false, true, false ]  );
  test.identical( got, 2 );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 0, 'a', true, 2, 'c', false, 'b', 1 ]  );
  test.identical( got, 6 );

  test.case = 'onEqualize'
  var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
  function onEqualize1( a, b )
  {
    return a[ 0 ] === b;
  };
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 1 ] ], [ [ 0 ] ], onEqualize1 );
  test.identical( dst, [ 0, [ 2 ], [ 3 ] ]  );
  test.identical( got, 1 );

  test.case = 'onEqualize'
  var dst = [ 1, 2, 3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ [ 1 ] ] ], [ [ [ 0 ] ] ], onEqualize );
  test.identical( dst, [ [ 0 ], 2, 3 ] );
  test.identical( got, 1 );

  /* */

  test.case = 'dst === src'
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src single evaluator';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e + 10 );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators';
  var dst = [ 1,1,2,2,3,3 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e );
  test.identical( dst, [ 0,0,0,0,0,0 ] );
  test.identical( got, 6 );

  test.case = 'dst === src with evaluators, check for forever lopp';
  var dst = [ 1,1,2,2,3,3 ];
  if( Config.debug )
  test.shouldThrowErrorSync( () => _.arrayReplacedArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 ) );
  else
  {
    var got = _.arrayReplacedArraysOnceStrictly( dst, dst, [ 0,0,0,0,0,0 ], ( e ) => e, ( e ) => e + 10 )
    test.identical( got, 0 );
  }
  test.identical( dst, [ 1,1,2,2,3,3 ] );

  test.case = 'dst === ins'
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, dst, [ 2,1 ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,1 ] );

  test.case = 'dst === ins'
  var dst = [ 1,1 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ dst ], [ [ 2,1 ] ] );
  test.identical( got, 2 );
  test.identical( dst, [ 2,1 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

  test.case = 'ins element is not in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3 ], [ undefined ], [ 0 ] );
  });

  test.case = 'Repeated elements in dstArray';

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], [ 1 ], [ 2 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ 1, 2 ], [ 3, 4 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 0, 0, 0, 2, 1, 0, 0 ], [ [ 0, 1 ], 0 ], [ [ 1, 0 ], '0' ] );
  });

}

// //
//
// function arrayReplaceArraysOnce( test )
// {
//   test.case = 'replace elements from arrays from ins with relevant values from sub';
//
//   var dst = [];
//   var got = _.arrayReplaceArraysOnce( dst, [ [] ], [ [] ] );
//   test.identical( got, [] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ] ], [ [ 3 ] ] );
//   test.identical( got, [ 3, 2, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], [ 3 ] ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], 3 ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ 3, 3 ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1, 2, 3 ] ], [ 3 ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1, 2, 3 ] ], [ [ 3, 3, 3, ] ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1, 2, 3 ] ], [ [ 3 ] ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], [ 4 ] ] );
//   test.identical( got, [ 3, 4, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ [ 1 ] ] ], [ 0 ] );
//   test.identical( got, [ 1, 2, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1, [ 2 ], 3 ] ], [ 0 ] );
//   test.identical( got, [ 0, 2, 0 ] );
//
//   var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
//   function onEqualize( a, b )
//   {
//     return a[ 0 ] === b[ 0 ];
//   }
//   var got = _.arrayReplaceArraysOnce( dst, [ [ [ 1 ], [ 2 ], [ 3 ] ] ], [ [ [ 0 ] ] ], onEqualize );
//   test.identical( got, [ [ 0 ], [ 0 ], [ 0 ] ] );
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce();
//   })
//
//   test.case = 'dstArray is not a longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( 1, [ [ 1 ] ], [ 1 ] );
//   })
//
//   test.case = 'ins is not a longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1, 2 ], 1, [ 1 ] );
//   })
//
//   test.case = 'ins must be array of arrays';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1, 2 ], [ 1 ], [ 1 ] );
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1, 2 ], [ [ 1 ] ], [ 1 ], 1 );
//   })
//
//   test.case = 'ins and sub length are different';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1 ], [ [ 1 ] ], [ 10, 20 ] );
//   })
//
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1 ], [ [ 1, 2 ] ], [ 10, 20 ] );
//   })
//
//   test.case = 'ins[ 0 ] and sub[ 0 ] length are different';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1 ], [ [ 1 ] ], [ [ 10, 20 ] ] );
//   })
// }
//
// //
//
// function arrayReplaceArraysOnceStrictly( test )
// {
//   test.case = 'replace elements from arrays from ins with relevant values from sub';
//
//   var dst = [];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [] ], [ [] ] );
//   test.identical( got, [] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ] ], [ [ 3 ] ] );
//   test.identical( got, [ 3, 2, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], [ 3 ] ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], 3 ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ], [ 2 ] ], [ 3, 3 ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1, 2, 3 ] ], [ 3 ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1, 2, 3 ] ], [ [ 3, 3, 3, ] ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1, 2, 3 ] ], [ [ 3 ] ] );
//   test.identical( got, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], [ 4 ] ] );
//   test.identical( got, [ 3, 4, 3 ] );
//
//   var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
//   function onEqualize( a, b )
//   {
//     return a[ 0 ] === b[ 0 ];
//   }
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ [ 1 ], [ 2 ], [ 3 ] ] ], [ [ [ 0 ] ] ], onEqualize );
//   test.identical( got, [ [ 0 ], [ 0 ], [ 0 ] ] );
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly();
//   })
//
//   test.shouldThrowErrorSync( function()
//   {
//     var dst = [ 1, 2, 3 ];
//     _.arrayReplaceArraysOnceStrictly( dst, [ [ [ 1 ] ] ], [ 0 ] );
//   })
//
//   test.case = 'one element is not replaced';
//   test.shouldThrowErrorSync( function()
//   {
//     var dst = [ 1, 2, 3 ];
//     _.arrayReplaceArraysOnceStrictly( dst, [ [ 1, [ 2 ], 3 ] ], [ 0 ] );
//   })
//
//   test.case = 'dstArray is not a longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( 1, [ [ 1 ] ], [ 1 ] );
//   })
//
//   test.case = 'ins is not a longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
//   })
//
//   test.case = 'ins must be array of arrays';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], [ 1 ], [ 1 ] );
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], [ [ 1 ] ], [ 1 ], 1 );
//   })
//
//   test.case = 'ins and sub length are different';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1 ], [ [ 1 ] ], [ 10, 20 ] );
//   })
//
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1 ], [ [ 1, 2 ] ], [ 10, 20 ] );
//   })
//
//   test.case = 'ins[ 0 ] and sub[ 0 ] length are different';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1 ], [ [ 1 ] ], [ [ 10, 20 ] ] );
//   })
// }
//
// //
//
// function arrayReplacedArraysOnce( test )
// {
//   test.case = 'replace elements from arrays from ins with relevant values from sub';
//
//   var dst = [];
//   var got = _.arrayReplacedArraysOnce( dst, [ [] ], [ [] ] );
//   test.identical( got, 0 );
//   test.identical( dst, [] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ] ], [ [ 3 ] ] );
//   test.identical( got, 1 );
//   test.identical( dst, [ 3, 2, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], [ 3 ] ] );
//   test.identical( got, 2 );
//   test.identical( dst, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], 3 ] );
//   test.identical( got, 2 );
//   test.identical( dst, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ 3, 3 ] );
//   test.identical( got, 2 );
//   test.identical( dst, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1, 2, 3 ] ], [ 3 ] );
//   test.identical( got, 3 );
//   test.identical( dst, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1, 2, 3 ] ], [ [ 3, 3, 3, ] ] );
//   test.identical( got, 3 );
//   test.identical( dst, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1, 2, 3 ] ], [ [ 3 ] ] );
//   test.identical( got, 3 );
//   test.identical( dst, [ 3, 3, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ], [ 4 ] ] );
//   test.identical( got, 2 );
//   test.identical( dst, [ 3, 4, 3 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ [ 1 ] ] ], [ 0 ] );
//   test.identical( dst, [ 1, 2, 3 ] );
//   test.identical( got, 0 );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1, [ 2 ], 3 ] ], [ 0 ] );
//   test.identical( dst, [ 0, 2, 0 ] );
//   test.identical( got, 2 );
//
//   var dst = [ [ 1 ], [ 2 ], [ 3 ] ];
//   function onEqualize( a, b )
//   {
//     return a[ 0 ] === b[ 0 ];
//   }
//   var got = _.arrayReplacedArraysOnce( dst, [ [ [ 1 ], [ 2 ], [ 3 ] ] ], [ [ [ 0 ] ] ], onEqualize );
//   test.identical( dst, [ [ 0 ], [ 0 ], [ 0 ] ] );
//   test.identical( got, 3 );
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce();
//   })
//
//   test.case = 'dstArray is not a longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( 1, [ [ 1 ] ], [ 1 ] );
//   })
//
//   test.case = 'ins is not a longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1, 2 ], 1, [ 1 ] );
//   })
//
//   test.case = 'ins must be array of arrays';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1, 2 ], [ 1 ], [ 1 ] );
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1, 2 ], [ [ 1 ] ], [ 1 ], 1 );
//   })
//
//   test.case = 'ins and sub length are different';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1 ], [ [ 1 ] ], [ 10, 20 ] );
//   })
//
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1 ], [ [ 1, 2 ] ], [ 10, 20 ] );
//   })
//
//   test.case = 'ins[ 0 ] and sub[ 0 ] length are different';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1 ], [ [ 1 ] ], [ [ 10, 20 ] ] );
//   })
// }
//
//
//
// function arrayReplaceAll( test )
// {
//   test.case = 'replace all ins with sub';
//
//   var dst = [];
//   var got = _.arrayReplaceAll( dst, undefined, 0 );
//   test.identical( got, [] );
//
//   var dst = [ 1, 1, 1 ];
//   var got = _.arrayReplaceAll( dst, 1, 0 );
//   test.identical( got, [ 0, 0, 0 ] );
//
//   var dst = [ 1, 2, 1 ];
//   var got = _.arrayReplaceAll( dst, 1, 0 );
//   test.identical( got, [ 0, 2, 0 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplaceAll( dst, 4, 0 );
//   test.identical( got, [ 1, 2, 3 ] );
//
//   function onEqualize( a, b )
//   {
//     return a.value === b;
//   }
//
//   var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
//   var got = _.arrayReplaceAll( dst, 1, { value : 0 }, onEqualize );
//   test.identical( got, [ { value : 0 }, { value : 0 }, { value : 2 } ] );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no args';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceAll( );
//   });
//
//   test.case = 'first arg is not longIs';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceAll( 1, 1, 1 );
//   });
//
//   test.case = 'fourth argument is not a routine';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplaceAll( 1, 1, 1, 1);
//   });
// }
//
// //
//
// function arrayReplacedAll( test )
// {
//   test.case = 'replace all ins with sub';
//
//   var dst = [];
//   var got = _.arrayReplacedAll( dst, undefined, 0 );
//   test.identical( got, 0 );
//   test.identical( dst, [] );
//
//   var dst = [ 1, 1, 1 ];
//   var got = _.arrayReplacedAll( dst, 1, 0 );
//   test.identical( got, 3 );
//   test.identical( dst, [ 0, 0, 0 ] );
//
//   var dst = [ 1, 2, 1 ];
//   var got = _.arrayReplacedAll( dst, 1, 0 );
//   test.identical( got, 2 );
//   test.identical( dst, [ 0, 2, 0 ] );
//
//   var dst = [ 1, 2, 3 ];
//   var got = _.arrayReplacedAll( dst, 4, 0 );
//   test.identical( got, 0 );
//   test.identical( dst, [ 1, 2, 3 ] );
//
//   function onEqualize( a, b )
//   {
//     return a.value === b;
//   }
//
//   var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
//   var got = _.arrayReplacedAll( dst, 1, { value : 0 }, onEqualize );
//   test.identical( got, 2 );
//   test.identical( dst, [ { value : 0 }, { value : 0 }, { value : 2 } ] );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no args';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedAll( );
//   });
//
//   test.case = 'first arg is not longIs';
//   debugger;
//   test.shouldThrowErrorSync( function()
//   {
//     debugger;
//     _.arrayReplacedAll( 1, 1, 1 );
//   });
//   debugger;
//
//   test.case = 'fourth argument is not a routine';
//   test.shouldThrowErrorSync( function()
//   {
//     _.arrayReplacedAll( 1, 1, 1, 1 );
//   });
//
// }

//

function arrayUpdate( test )
{

  test.case = 'add a new element';
  var got = _.arrayUpdate( [  ], 1, 1 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'add a new element';
  var got = _.arrayUpdate( [ 1, 2, 3, 4, 5 ], 6, 6 );
  var expected = 5;
  test.identical( got, expected );

  test.case = 'add a new element';
  var got = _.arrayUpdate( [ 'Petre', 'Mikle', 'Oleg' ], 'Dmitry', 'Dmitry' );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'change the fourth element';
  var got = _.arrayUpdate( [ true, true, true, true, false ], false, true );
  var expected = 4;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayUpdate();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arrayUpdate( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.arrayUpdate( [ 1, 2, 3, 4, 5 ], 6, 6, 'redundant argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.arrayUpdate( 'wrong argument', 6, 6 );
  });

}

// --
// array set
// --

function arraySetDiff( test )
{

  test.case = 'first argument has single extra element, second argument has single extra element either';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetDiff( a, b );
  var expected = [ 15, 5 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4 ];
  var got = _.arraySetDiff( a, b );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'second argument is an empty array';
  var a = [ 1, 2, 3, 4 ];
  var b = [];
  var got = _.arraySetDiff( a, b );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'both arguments are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetDiff( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'all of the elements is present in both arrays';
  var a = [ 3, 3, 3 ];
  var b = [ 3, 3, 3, 3 ];
  var got = _.arraySetDiff( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  /* */

  test.case = 'extra';

  var cases =
  [
    { src1 : [], src2 : [], expected : [] },
    { src1 : [ 1, 2, 3 ], src2 : [], expected : [ 1, 2, 3 ] },
    { src1 : [], src2 : [ 1, 2, 3 ], expected : [ 1, 2, 3 ] },
    { src1 : [ 1, 2, 3 ], src2 : [ 4, 5, 6 ], expected : [ 1, 2, 3, 4, 5, 6 ] },
    { src1 : [ 1, 2, 3 ], src2 : [ 3, 4, 5 ], expected : [ 1, 2, 4, 5 ] },
    { src1 : [ 1, 1, 2, 2, 3, 3 ], src2 : [ 1, 2, 3 ], expected : [] },
    { src1 : [ 1, 1, 2, 3, 3 ], src2 : [ 3, 3, 4, 5, 5 ], expected : [ 1, 1, 2, 4, 5, 5 ] },
    { src1 : 1, src2 : 1, error : true },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.error )
    test.shouldThrowErrorSync( () => _.arraySetDiff( c.src1, c.src2 ) );
    else
    test.identical( _.arraySetDiff( c.src1, c.src2 ), c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff();
  });

  test.case = 'too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( [ 1, 2, 3, 4 ] );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( [ 1, 2, 3, 4 ], [ 5, 7, 8, 9 ], [ 13, 15, 17 ] );
  });


  test.case = 'one or both arguments are not longIs entities, numeric arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( 10, 15 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'both arguments are null';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetDiff( undefined, undefined );
  });

}

//

function arraySetBut( test )
{

  test.case = 'first argument has single extra element, second argument has single extra element either';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetBut( a, b );
  var expected = [ 15 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first argument has single extra element, second argument has single extra element either';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetBut( null, a, b );
  var expected = [ 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first argument has several elements that are not present in second argument';
  var a = [ 1, 4, 9 ];
  var b = [ 2, 5 ];
  var got = _.arraySetBut( a, b );
  var expected = [ 1, 4, 9 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first argument has several elements that are not present in second argument';
  var a = [ 1, 4, 9 ];
  var b = [ 2, 5 ];
  var got = _.arraySetBut( null, a, b );
  var expected = [ 1, 4, 9 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first argument is the same as second';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1, 2, 3, 4 ];
  var got = _.arraySetBut( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first argument is the same as second';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1, 2, 3, 4 ];
  var got = _.arraySetBut( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4 ];
  var got = _.arraySetBut( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4 ];
  var got = _.arraySetBut( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'second argument is an empty array';
  var a = [ 1, 2, 3, 4 ];
  var b = [];
  var got = _.arraySetBut( a, b );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'second argument is an empty array';
  var a = [ 1, 2, 3, 4 ];
  var b = [];
  var got = _.arraySetBut( null, a, b );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first array has the same element as the second ';
  var a = [ 1, 1, 1 ];
  var b = [ 1 ];
  var got = _.arraySetBut( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first array has the same element as the second ';
  var a = [ 1, 1, 1 ];
  var b = [ 1 ];
  var got = _.arraySetBut( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'both arguments are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetBut( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'both arguments are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetBut( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'single empty argument';
  var a = [];
  var got = _.arraySetBut( a );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'single empty argument';
  var a = [];
  var got = _.arraySetBut( null, a );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'single not empty argument';
  var a = [ 3, 4, 5 ];
  var got = _.arraySetBut( a );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'single not empty argument';
  var a = [ 3, 4, 5 ];
  var got = _.arraySetBut( null, a );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'three arguments, same elements';
  var a = [ 3, 4, 5 ];
  var b = [ 3, 4, 5 ];
  var c = [ 3, 4, 5 ];
  var got = _.arraySetBut( a, b, c );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, same elements';
  var a = [ 3, 4, 5 ];
  var b = [ 3, 4, 5 ];
  var c = [ 3, 4, 5 ];
  var got = _.arraySetBut( null, a, b, c );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, differet elements';
  var a = [ 3, 4, 5 ];
  var b = [ 5 ];
  var c = [ 3 ];
  var got = _.arraySetBut( a, b, c );
  var expected = [ 4 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, differet elements';
  var a = [ 3, 4, 5 ];
  var b = [ 5 ];
  var c = [ 3 ];
  var got = _.arraySetBut( null, a, b, c );
  var expected = [ 4 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the second and third';
  var a = [ 3, 4, 5 ];
  var b = [];
  var c = [];
  var got = _.arraySetBut( a, b, c );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the second and third';
  var a = [ 3, 4, 5 ];
  var b = [];
  var c = [];
  var got = _.arraySetBut( null, a, b, c );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the first';
  var a = [];
  var b = [ 3, 4, 5 ];
  var c = [ 3, 4, 5 ];
  var got = _.arraySetBut( a, b, c );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the first';
  var a = [];
  var b = [ 3, 4, 5 ];
  var c = [ 3, 4, 5 ];
  var got = _.arraySetBut( null, a, b, c );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'complex case';
  var got = _.arraySetBut( [ 1, 10, 0, 5 ], [ 5, 8, 2 ], [ 3, 1, 6, 4 ], [ 0 ] );
  var expected = [ 10 ];
  test.identical( got, expected );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetBut( null, a );
  var expected = [ 1, 1, 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetBut( a );
  var expected = [ 1, 1, 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 null';
  var got = _.arraySetBut( null );
  var expected = [];
  test.identical( got, expected );

  /* */

  var cases =
  [
    { src : [], but : [], expected : [] },
    { src : [ 1, 2, 3 ], but : [], expected : [ 1, 2, 3 ] },
    { src : [], but : [ 1, 2, 3 ], expected : [ ] },
    { src : [ 1, 1, 1 ], but : [ 1 ], expected : [] },
    { src : [ 1, 2, 3 ], but : [ 3, 2, 1 ], expected : [] },
    { src : [ 1, 2, 3 ], but : [ 3 ], expected : [ 1, 2 ] },
    { src : [ 1, 2, 3 ], but : [ 4, 5, 6 ], expected : [ 1, 2, 3 ] },
    { src : 1, but : 1, error : true },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.error )
    test.shouldThrowErrorSync( () => _.arraySetBut( c.src, c.but ) );
    else
    test.identical( _.arraySetBut( c.src, c.but ), c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  /* bad arguments */

  test.case = 'not array';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( '3' );
  });

  test.case = 'no arguments, the count of arguments doesn\'t match 2';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut();
  });

  test.case = 'one or both arguments are not longIs entities, numerical arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( 5, 8 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'both arguments are null';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetBut( undefined, undefined );
  });

}

//

function arraySetIntersection( test )
{

  test.case = 'second argument has extra element, third argument has two extra elements';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetIntersection( a, b );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'second argument has extra element, third argument has two extra elements';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetIntersection( null, a, b );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'single array argument';
  var a = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetIntersection( a );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'single array argument';
  var a = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetIntersection( null, a );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetIntersection( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetIntersection( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first and second argument are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetIntersection( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first and second argument are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetIntersection( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = '3 arguments, nothing in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var c = [ 15, 16, 17 ];
  var got = _.arraySetIntersection( a, b, c );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, nothing in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var c = [ 15, 16, 17 ];
  var got = _.arraySetIntersection( null, a, b, c );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, something in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5, ];
  var c = [ 3, 15, 16, 17, 1 ];
  var got = _.arraySetIntersection( null, a, b, c );
  var expected = [ 1, 3 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, something in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 3, ];
  var c = [ 1, 3 ];
  var got = _.arraySetIntersection( null, a, b, c );
  var expected = [ 3 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var b = [ 3, 1 ];
  var c = [ 1, 3 ];
  var got = _.arraySetIntersection( null, a, b, c );
  var expected = [ 1, 1, 1, 3 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetIntersection( null, a );
  var expected = [ 1, 1, 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetIntersection( a );
  var expected = [ 1, 1, 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 null';
  var got = _.arraySetIntersection( null );
  var expected = [];
  test.identical( got, expected );

  /* extra */

  var cases =
  [
    { args : [ [] ], expected : [] },
    { args : [ [ 1 ], [ ] ], expected : [] },
    { args : [ [ ], [ 1 ] ], expected : [] },
    { args : [ [ 1 ], [ 2 ] ], expected : [] },
    { args : [ [ 1, 2, 3 ], [ 2 ] ], expected : [ 2 ] },
    { args : [ [ 1, 2, 3 ], [ 2 ], [ 1 ], [ 3 ] ], expected : [] },
    { args : [ [ 1, 1, 1 ], [ 1 ] ], expected : [ 1, 1, 1 ] },
    { args : [ [ 1, 2, 3 ], [ 0 ], [ 4 ], [ 0, 0, 3 ] ], expected : [] },
    { args : [ [ 1, 2, 3 ], [ 0 ], 1, [ 3 ] ], error : true },
    { args : [ 1 ], error : true },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.error )
    test.shouldThrowErrorSync( () => _.arraySetIntersection.apply( _, c.args ) );
    else
    test.identical( _.arraySetIntersection.apply( _, c.args ) , c.expected );
  }
  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection();
  });

  test.case = 'one or several arguments are not longIs entities, numerical arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection( 10, 15, 25 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'one or more arguments are null';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection( null, null );
  });

  test.case = 'one or more arguments are undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIntersection( undefined, undefined );
  });

}

//

function arraySetUnion( test )
{

  test.case = 'second argument has extra element, third argument has two extra elements';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetUnion( a, b );
  var expected = [ 1, 2, 3, 4, 15, 5 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'second argument has extra element, third argument has two extra elements';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var got = _.arraySetUnion( null, a, b );
  var expected = [ 1, 2, 3, 4, 15, 5 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'single array argument';
  var a = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetUnion( a );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'single array argument';
  var a = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetUnion( null, a );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetUnion( a, b );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3, 4, 15 ];
  var got = _.arraySetUnion( null, a, b );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first and second argument are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetUnion( a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );

  test.case = 'first and second argument are empty arrays';
  var a = [];
  var b = [];
  var got = _.arraySetUnion( null, a, b );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = '3 arguments, nothing in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var c = [ 15, 16, 17 ];
  var got = _.arraySetUnion( a, b, c );
  var expected = [ 1, 2, 3, 4, 15, 5, 16, 17 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, nothing in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5 ];
  var c = [ 15, 16, 17 ];
  var got = _.arraySetUnion( null, a, b, c );
  var expected = [ 1, 2, 3, 4, 15, 5, 16, 17 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, something in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 1, 2, 3, 4, 5, ];
  var c = [ 3, 15, 16, 17, 1 ];
  var got = _.arraySetUnion( null, a, b, c );
  var expected = [ 1, 2, 3, 4, 15, 5, 16, 17 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, something in common';
  var a = [ 1, 2, 3, 4, 15 ];
  var b = [ 3, ];
  var c = [ 1, 3 ];
  var got = _.arraySetUnion( null, a, b, c );
  var expected = [ 1, 2, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '3 arguments, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var b = [ 3, 1 ];
  var c = [ 1, 3 ];
  var got = _.arraySetUnion( null, a, b, c );
  var expected = [ 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetUnion( null, a );
  var expected = [ 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetUnion( a );
  var expected = [ 1, 1, 1, 3, 4, 15 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = '1 null';
  var got = _.arraySetUnion( null );
  var expected = [];
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion();
  });

  test.case = 'one or several arguments are not longIs entities, numerical arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion( 10, 15, 25 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'one or more arguments are null';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion( null, null );
  });

  test.case = 'one or more arguments are undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetUnion( undefined, undefined );
  });

}

//

function arraySetContainAll( test )
{

  test.case = '1 argument, empty';
  var a = [];
  var got = _.arraySetContainAll( a );
  var expected = true;
  test.identical( got, expected );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetContainAll( a );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, empty';
  var a = [];
  var b = [];
  var got = _.arraySetContainAll( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, src empty';
  var a = [];
  var b = [ 1 ];
  var got = _.arraySetContainAll( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = '2 arguments, ins empty';
  var a = [ 1 ];
  var b = [];
  var got = _.arraySetContainAll( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = 'bigger second argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1, 1, 1 ];
  var got = _.arraySetContainAll( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = 'bigger third argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1 ];
  var c = [ 1, 1, 1, 1 ];
  var got = _.arraySetContainAll( a, b, c );
  var expected = true;
  test.identical( got, expected );

  test.case = '4 arguments';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a, b, c, d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 0 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a, b, c, d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 0, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a, b, c, d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 0 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a, b, c, d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 0, 2 ];
  var got = _.arraySetContainAll( a, b, c, d );
  var expected = false;
  test.identical( got, expected );


  test.case = 'Second argument contains all the same values as in the (src), and new ones';
  var a = [ 1, 'b', 'c', 4 ];
  var b = [ 1, 2, 3, 4, 5, 'b', 'c' ];
  var got = _.arraySetContainAll( a, b );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'length of the first argument is more than second argument';
  var a = [ 1, 2, 3, 4, 5 ];
  var b = [ 1, 2, 3, 4 ];
  var got = _.arraySetContainAll( a, b );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'length of the first argument is more than second argument';
  var a = [ 'abc', 'def', true, 26 ];
  var b = [ 1, 2, 3, 4 ];
  var c = [ 26, 'abc', 'def', true ];
  var got = _.arraySetContainAll( a, b, c );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'second argument is an empty array';
  var a = [ 1, 2, 3 ];
  var b = [];
  var got = _.arraySetContainAll( a, b );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 2, 3 ];
  var got = _.arraySetContainAll( a, b );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'both arguments are empty';
  var a = [];
  var b = [];
  var got = _.arraySetContainAll( a, b );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  /* */

  var cases =
  [
    { args : [ [], [] ], expected : true },
    { args : [ [ 1 ], [] ], expected : true },
    { args : [ [ 1 ], [ 1 ] ], expected : true },
    { args : [ [ 1, 1 ], [ 1, 1, 1 ] ], expected : true },
    { args : [ [ 1, 1, 1 ], [ 1, 1 ] ], expected : true },
    { args : [ [ 1 ], [ 1 ], [ 1 ], [] ], expected : true },
    { args : [ [ 1 ], [ 1 ], [ 1 ], [ 1, 1, 1 ] ], expected : true },
    { args : [ [ 1 ], [ 0, 1 ], [ 3, 2, 1 ], [ 1 ] ], expected : false },
    { args : [ [ 1, 2, 3 ], [ 1, 2, 3 ], [ 3, 2, 1 ], [ 1, 2 ] ], expected : true },
    { args : [ [], [ 1, 2, 3 ], [ 3, 2, 1 ], [ 1, 2 ] ], expected : false },
    { args : [ [], 1, [ 3, 2, 1 ], [ 1, 2 ] ], error : true },
    { args : [ 1 ], error : true },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var _case = cases[ i ];
    console.log( _.toStr( _case, { levels : 3 } ) );
    if( _case.error )
    test.shouldThrowErrorSync( () => _.arraySetContainAll.apply( _, _case.args ) );
    else
    test.identical( _.arraySetContainAll.apply( _, _case.args ) , _case.expected );
  }

  /* special cases */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll();
  });

  test.case = 'one or both arguments are not longIs entities, numerical arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll( 5, 8 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll( { a : 1, b : 2 }, { c : 3 } );
  });

  test.case = 'wrong arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll( [ 1, 2, 3, 4 ], 'wrong arguments' );
  });

  test.case = 'both arguments are null';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAll( undefined, undefined );
  });
}

//

function arraySetContainAny( test )
{

  test.case = '1 argument, empty';
  var a = [];
  var got = _.arraySetContainAny( a );
  var expected = true;
  test.identical( got, expected );

  test.case = '1 argument, repeats';
  var a = [ 1, 1, 1, 3, 4, 15 ];
  var got = _.arraySetContainAny( a );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, empty';
  var a = [];
  var b = [];
  var got = _.arraySetContainAny( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, src empty';
  var a = [];
  var b = [ 1 ];
  var got = _.arraySetContainAny( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, ins empty';
  var a = [ 1 ];
  var b = [];
  var got = _.arraySetContainAny( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'bigger second argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1, 1, 1 ];
  debugger;
  var got = _.arraySetContainAny( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = 'bigger third argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1 ];
  var c = [ 1, 1, 1, 1 ];
  var got = _.arraySetContainAny( a, b, c );
  var expected = true;
  test.identical( got, expected );

  test.case = '3 arguments, the first is empty';
  var a = [];
  var b = [ 1 ];
  var c = [ 2, 3];
  var got = _.arraySetContainAny( a, b, c );
  var expected = true;
  test.identical( got, expected );

  test.case = '4 arguments';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a, b, c, d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 0 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a, b, c, d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 0, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a, b, c, d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 0 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a, b, c, d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 0, 2 ];
  var got = _.arraySetContainAny( a, b, c, d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'second and third arrays contains several values from (src) array';
  var a = [ 33, 4, 5, 'b', 'c' ];
  var b = [ 1, 'b', 'c', 4 ];
  var c = [ 33, 13, 3 ];
  var got = _.arraySetContainAny( a, b, c );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'second array is empty, third array contains elements from (src) array';
  var a = [ 33, 4, 5, 'b', 'c' ];
  var b = [];
  var c = [ 33 ];
  var got = _.arraySetContainAny( a, b, c );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'second and third arrays doesn\'t contains matching elemets from (src) array';
  var a = [ 33, 4, 5, 'b', 'c' ];
  var b = [ 1, 'bcda', 'ce', 8 ];
  var c = [ 45, 13, 3 ];
  var got = _.arraySetContainAny( a, b, c );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'first argument is an empty array';
  var a = [];
  var b = [ 1, 'bcda', 'ce', 8 ];
  var c = [ 45, 13, 3 ];
  var got = _.arraySetContainAny( a, b, c );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'following array are empty, (src) array is not empty';
  var a = [ 33, 4, 5, 'b', 'c' ];
  var b = [];
  var c = [];
  var got = _.arraySetContainAny( a, b, c );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'all the array are empty';
  var a = [];
  var b = [];
  var c = [];
  var got = _.arraySetContainAny( a, b, c );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'single argument';
  var got = _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ] );
  var expected = true;
  test.identical( got, expected );

  /**/

  var cases =
  [
    { args : [ [], [] ], expected : true },
    { args : [ [ 1, 2, 3 ], [ 1 ] ], expected : true },
    { args : [ [ 1, 2, 3 ], [], [ 3 ] ], expected : false },
    { args : [ [ 1, 2, 3 ], [ 0, 1 ], [ 9, 3 ] ], expected : true },
    { args : [ [ 1, 2, 3 ], [ 4 ], [ 3 ] ], expected : false },
    { args : [ [], [ 0 ], [ 4 ], [ 3 ] ], expected : true },
    { args : [ [ 1, 2, 3 ], [ 4 ], [ 5 ]  ], expected : false },
    { args : [ [ 0, 0, 0, 1 ], [ 5 ], [ 6 ], [ 2, 1 ]  ], expected : false },
    { args : [ [ 1, 2, 3 ], [ 4 ], 1  ], error : true },
    { args : [ 1, [ 4 ], 1  ], error : true },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.error )
    test.shouldThrowErrorSync( () => _.arraySetContainAny.apply( _, c.args ) );
    else
    test.identical( _.arraySetContainAny.apply( _, c.args ) , c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAny();
  });

  test.case = 'one or several arguments are not longIs entities, numeric arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], 15, 25 );
  });

  test.case = 'one or several arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], 'dfdf', 'ab' );
  });

  test.case = 'one or several arguments are not longIs entities, map like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], { a : 33 }, { b : 44 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetContainAny( [ 1, 2, 3 ], "wrong argument" );
  });

}

//

function arraySetIdentical( test )
{

  console.log( 'xxx' );

  test.case = '2 arguments, empty';
  var a = [];
  var b = [];
  var got = _.arraySetIdentical( a, b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, src empty';
  var a = [];
  var b = [ 1 ];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = '2 arguments, ins empty';
  var a = [ 1 ];
  var b = [];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'repeats, bigger second argument';
  var a = [ 1 ];
  var b = [ 1, 1, 1, 1 ];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'repeats, bigger first argument';
  var a = [ 1, 1, 1, 1 ];
  var b = [ 1 ];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'repeats';
  var a = [ 1, 3 ];
  var b = [ 1, 1, 1, 1 ];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arguments have the same elements but the order is differ';
  var a = [ 1, 2, 4, 7, 5 ];
  var b = [ 4, 2, 1, 5, 7 ];
  var got = _.arraySetIdentical( a, b );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'argument length mismatch';
  var a = [ 1, 2, 4, 7, 5 ];
  var b = [ 1, 5, 7 ];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'arguments have the same elements have inner arrays';
  var a = [ 1, 2, [ 1, 3], 7, 5 ];
  var b = [ [ 1, 3], 2, 1, 5, 7 ];
  var got = _.arraySetIdentical( a, b );
  var expected = false;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  test.case = 'both arrays are empty';
  var a = [];
  var b = [];
  var got = _.arraySetIdentical( a, b );
  var expected = true;
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );

  /* */

  var cases =
  [
    { args : [ [], [] ], expected : true },
    { args : [ [ 1 ], [] ], expected : false },
    { args : [ [ 1 ], [ 1 ] ], expected : true },
    { args : [ [ 1, 1 ], [ 1 ] ], expected : false },
    { args : [ [ 1 ], [ 1, 1 ] ], expected : false },
    { args : [ [ 1, 2, 3 ], [ 1, 2, 4 ] ], expected : false },
    { args : [ [ 1, 2, 3 ], [ 3, 2, 1 ] ], expected : true },
    { args : [ [ 1, 2, 3 ], [ 3, 2, 1 ] ], expected : true },
    { args : [ [ [ 1 ], 2, 3 ], [ 3, 2, [ 1 ] ] ], expected : false },
    { args : [ 1, [ 1 ] ], error : true },
    { args : [ [ 1 ], 1 ], error : true },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    if( c.error )
    test.shouldThrowErrorSync( () => _.arraySetIdentical.apply( _, c.args ) );
    else
    test.identical( _.arraySetIdentical.apply( _, c.args ) , c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical();
  });

  test.case = 'one or 2 arguments are not longIs entities, numeric argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical( [ 1, 2, 4, 7, 5 ], 15 );
  });

  test.case = 'one or 2 arguments are not longIs entities, string like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical( 'a', 'a' );
  });

  test.case = 'one or 2 arguments are not longIs entities, map like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical( [ 1, 2, 4, 7, 5 ], "wrong argument" );
  });

  test.case = 'both arguments are null';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowErrorSync( function()
  {
    _.arraySetIdentical( undefined, undefined );
  });

}

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

  debugger;
  test.case = 'ins as BufferNode';
  var expected = BufferNode.alloc( 5 );
  var expected = new BufferNode( 5 );
  // var src = _.longFill( new F32x( 5 ), 1 );
  // var got = _.longMake( BufferNode, src );
  // test.is( _.bufferNodeIs(  got ) );
  // test.identical( got.length, 5 );
  // test.identical( got, expected );
  test.identical( 1, 1 );
  debugger;

}

//

//--
// unused, routine is not defined
//--

// qqq : this is bufferJoin
//function arrayJoin( test )
//{
//  test.case = 'empty call';
//  test.identical( _.arrayJoin(), null );
//
//  test.case = 'empty arrays';
//  test.identical( _.arrayJoin( [], [] ), null );
//
//  test.case = 'simple';
//
//  var src = [ 1 ];
//  var got = _.arrayJoin( src );
//  var expected = src;
//  test.identical( got, expected );
//
//  var src = [ 1 ];
//  var got = _.arrayJoin( src, src );
//  var expected = [ 1, 1 ];
//  test.identical( got, expected );
//
//  test.case = 'array + typedArray';
//  var got = _.arrayJoin( [ 1 ], new U8x( [ 1, 2 ] ) );
//  var expected = [ 1, 1, 2 ];
//  test.identical( got, expected );
//
//  var got = _.arrayJoin( new U8x( [ 1, 2 ] ), [ 1 ] );
//  var expected = new U8x( [ 1, 2, 1 ] );
//  test.identical( got, expected );
//
//  test.case = 'typedArray + typedArray';
//  var got = _.arrayJoin( new U8x( [ 1, 2 ] ), new U8x( [ 1, 2 ] ) );
//  var expected = new U8x( [ 1, 2, 1, 2 ] );
//  test.identical( got, expected );
//
//  var got = _.arrayJoin( new U8x( [ 1, 2 ] ), new U16x( [ 1, 2 ] ) );
//  var expected = new U8x( [ 1, 2, 1, 0, 2, 0 ] );
//  test.identical( got, expected );
//
//  test.case = 'arrayBuffer + arrayBuffer';
//  var src = new U8x( [ 1, 2 ] );
//  var got = _.arrayJoin( src.buffer, src.buffer );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new U8x( [ 1, 2, 1, 2 ] );
//  test.identical( new U8x( got ), expected );
//
//  test.case = 'arrayBuffer + array';
//  var src = new U8x( [ 1, 2 ] );
//  var got = _.arrayJoin( src.buffer, [ 1, 2 ] );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new U8x( [ 1, 2, 1, 2 ] );
//  test.identical( new U8x( got ), expected );
//
//  test.case = 'arrayBuffer + typedArray';
//  var src = new U8x( [ 1, 2 ] );
//  var got = _.arrayJoin( src.buffer, src );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new U8x( [ 1, 2, 1, 2 ] );
//  test.identical( new U8x( got ), expected );
//
//  test.case = 'typedArray + arrayBuffer';
//  var src = new U8x( [ 1, 2 ] );
//  var got = _.arrayJoin( src, src.buffer );
//  var expected = new U8x( [ 1, 2, 1, 2 ] );
//  test.identical( got, expected );
//
//  test.case = 'typedArray + arrayBuffer + array';
//  var src = new U8x( [ 1 ] );
//  var got = _.arrayJoin( src, src.buffer, [ 1 ] );
//  var expected = new U8x( [ 1, 1, 1 ] );
//  test.identical( got, expected );
//
//  test.case = 'array + typedArray + arrayBuffer';
//  var src = new U8x( [ 1 ] );
//  var got = _.arrayJoin( [ 1 ], src, src.buffer );
//  var expected = [ 1, 1, 1 ];
//  test.identical( got, expected );
//
//  test.case = 'arrayBuffer + array + typedArray';
//  var src = new U8x( [ 1 ] );
//  var got = _.arrayJoin( src.buffer, [ 1 ], src  );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new U8x( [ 1, 1, 1 ] );
//  test.identical( new U8x( got ), expected );
//
//  if( Config.interpreter === 'njs' )
//  {
//    test.case = 'buffer';
//    var got = _.arrayJoin( BufferNode.from( '1' ), [ 1 ] );
//    var expected = BufferNode.from( [ 49, 1 ] );
//    test.identical( got, expected );
//
//    test.case = 'buffer + arrayBuffer';
//    var raw = new U8x( [ 1 ] ).buffer;
//    var got = _.arrayJoin( BufferNode.from( '1' ), raw );
//    var expected = BufferNode.from( [ 49, 1 ] );
//    test.identical( got, expected );
//
//    test.case = 'buffer + typedArray';
//    var typed = new U8x( [ 1 ] );
//    var got = _.arrayJoin( BufferNode.from( '1' ), typed );
//    var expected = BufferNode.from( [ 49, 1 ] );
//    test.identical( got, expected );
//
//    test.case = 'buffer + typedArray + raw + array';
//    var typed = new U8x( [ 1 ] );
//    var got = _.arrayJoin( BufferNode.from( '1' ), typed, typed.buffer, [ 1 ] );
//    var expected = BufferNode.from( [ 49, 1, 1, 1 ] );
//    test.identical( got, expected );
//
//    test.case = 'typedArray + buffer + raw + array';
//    var typed = new U8x( [ 1 ] );
//    var got = _.arrayJoin( typed, BufferNode.from( '1' ), typed.buffer, [ 1 ] );
//    var expected = new U8x( [ 1, 49, 1, 1 ] );
//    test.identical( got, expected );
//
//    test.case = 'raw + typedArray + buffer + array';
//    var typed = new U8x( [ 1 ] );
//    var got = _.arrayJoin( typed.buffer, typed, BufferNode.from( '1' ), [ 1 ] );
//    var expected = new U8x( [ 1, 1, 49, 1 ] );
//    test.identical( new U8x( got ), expected );
//
//    test.case = 'array + raw + typedArray + buffer ';
//    var typed = new U8x( [ 1 ] );
//    var got = _.arrayJoin( [ 1 ], typed.buffer, typed, BufferNode.from( '1' )  );
//    var expected = new U8x( [ 1, 1, 1, 49 ] );
//    test.identical( new U8x( got ), expected );
//  }
//
//  if( !Config.debug )
//  return;
//
//  test.shouldThrowErrorSync( () => _.arrayJoin( [ 1 ], '1' ) );
//  test.shouldThrowErrorSync( () => _.arrayJoin( [ 1 ], { byteLength : 5 } ) );
//
//}

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

    // long l0

    longIs,

    longMake,
    _longMakeOfLength,
    longMakeUndefined,
    longMakeZeroed,

    longSlice,
    longBut,
    longButInplace,
    longSelect,
    longSelectInplace,
    longGrow,
    longGrowInplace,
    longRelength,
    longRelengthInplace,

    longRepresent,
    // longResize, // Dmytro : uncomment when it will be reimplemented
    longDuplicate,

    // long l1

    longAreRepeatedProbe,
    longAllAreRepeated,
    longAnyAreRepeated,
    longNoneAreRepeated,

    longMask,

    longOnce, // Dmytro : uncomment when reimplemented
    longSelectWithIndices,

    // array manipulator

    longSwapElements,
    longPut,
    // arrayFill,
    // longFillTimes,
    longFill,

    longSupplement,
    longExtendScreening,

    // type test

    arrayIs,
    constructorLikeArray,
    hasLength,

    // producer

    arrayMake,
    arrayMakeUndefined,
    arrayFrom,
    arrayFromCoercing,

    arrayRandom,
    arrayFromRange,
    arrayAs,

    // arrayToMap, // Dmytro : routine arrayToMap commented in gLong.s
    // arrayToStr, // Dmytro : routine arrayToStr commented in gLong.s

    // array checker

    arrayCompare,
    arraysAreIdentical,

    arrayHasAny,
    arrayHasAll,
    arrayHasNone,

    // array transformer

    arraySlice,
    arrayBut,
    arrayButInplace,
    arraySelect,
    arraySelectInplace,
    arrayGrow,
    arrayGrowInplace,
    arrayRelength,
    arrayRelengthInplace,

    // array sequential search

    arrayLeftIndex,
    arrayRightIndex,

    arrayLeft,

    arrayCountElement,
    arrayCountTotal,
    arrayCountUnique,

    // array etc

    // arraySum,

    // array prepend

    arrayPrepend,
    arrayPrependOnce,
    arrayPrependOnceStrictly,
    arrayPrepended,
    arrayPrependedOnce,
    arrayPrependedOnceStrictly,

    arrayPrependElement,
    arrayPrependElementOnce,
    arrayPrependElementOnceStrictly,
    arrayPrependedElement,
    arrayPrependedElementOnce,
    arrayPrependedElementOnceStrictly,

    arrayPrependArray,
    arrayPrependArrayOnce,
    arrayPrependArrayOnceStrictly,
    arrayPrependedArray,
    arrayPrependedArrayOnce,
    arrayPrependedArrayOnceStrictly,

    arrayPrependArrays,
    arrayPrependArraysOnce,
    arrayPrependArraysOnceStrictly,
    arrayPrependedArrays,
    arrayPrependedArraysOnce,
    arrayPrependedArraysOnceStrictly,

    // array append

    arrayAppend,
    arrayAppendOnce,
    arrayAppendOnceStrictly,
    arrayAppended,
    arrayAppendedOnce,
    arrayAppendedOnceStrictly,

    arrayAppendElement,
    arrayAppendElementOnce,
    arrayAppendElementOnceStrictly,
    arrayAppendedElement,
    arrayAppendedElementOnce,
    arrayAppendedElementOnceStrictly,

    arrayAppendArray,
    arrayAppendArrayOnce,
    arrayAppendArrayOnceStrictly,
    arrayAppendedArray,
    arrayAppendedArrayOnce,
    arrayAppendedArrayOnceWithSelector,
    arrayAppendedArrayOnceStrictly,

    arrayAppendArrays,
    arrayAppendArraysOnce,
    arrayAppendArraysOnceStrictly,
    arrayAppendedArrays,
    arrayAppendedArraysOnce,
    arrayAppendedArraysOnceStrictly,

    // array remove

    arrayRemove,
    arrayRemoveOnce,
    arrayRemoveOnceStrictly,
    arrayRemoved,
    arrayRemovedOnce,
    arrayRemovedOnceStrictly,

    arrayRemoveElement,
    arrayRemoveElementOnce,
    arrayRemoveElementOnceStrictly,
    arrayRemovedElement,
    arrayRemovedElementOnce,
    arrayRemovedElementOnceStrictly,

    // arrayRemovedOnceStrictly,
    // arrayRemovedElementOnce2,
    // arrayRemovedOnceElementStrictly,

    arrayRemoveArray,
    arrayRemoveArrayOnce,
    arrayRemoveArrayOnceStrictly,
    arrayRemovedArray,
    arrayRemovedArrayOnce,
    arrayRemovedArrayOnceStrictly,

    arrayRemoveArrays,
    arrayRemoveArraysOnce,
    arrayRemoveArraysOnceStrictly,
    arrayRemovedArrays,
    arrayRemovedArraysOnce,
    arrayRemovedArraysOnceStrictly,

    arrayRemoveDuplicates,

    // array flatten

    /* qqq : extend test coverage */
    /* qqq : extend implementation for sets */

    arrayFlattenCritical,
    arrayFlatten,
    arrayFlattenOnce,
    arrayFlattenOnceStrictly,
    arrayFlattened,
    arrayFlattenedOnce,
    arrayFlattenedOnceStrictly,
    // arrayFlattenSame,
    // arrayFlattenOnceSame,
    // arrayFlattenOnceStrictlySame,
    // arrayFlattenedSame,
    // arrayFlattenedOnceSame,
    // arrayFlattenedOnceStrictlySame,
    // arrayFlattenSets,
    // arrayFlattenOnceSets,
    // arrayFlattenOnceStrictlySets,
    // arrayFlattenedSets,
    // arrayFlattenedOnceSets,
    // arrayFlattenedOnceStrictlySets,

    arrayFlattenDefined,
    arrayFlattenDefinedOnce,
    arrayFlattenDefinedOnceStrictly,
    arrayFlattenedDefined,
    arrayFlattenedDefinedOnce,
    arrayFlattenedDefinedOnceStrictly,
    // arrayFlattenDefinedSame,
    // arrayFlattenDefinedOnceSame,
    // arrayFlattenDefinedOnceStrictlySame,
    // arrayFlattenedDefinedSame,
    // arrayFlattenedDefinedOnceSame,
    // arrayFlattenedDefinedOnceStrictlySame,
    // arrayFlattenDefinedSets,
    // arrayFlattenDefinedOnceSets,
    // arrayFlattenDefinedOnceStrictlySets,
    // arrayFlattenedDefinedSets,
    // arrayFlattenedDefinedOnceSets,
    // arrayFlattenedDefinedOnceStrictlySets,

    // array replace

    arrayReplace,
    arrayReplaceOnce,
    arrayReplaceOnceStrictly,
    arrayReplaced,
    arrayReplacedOnce,
    arrayReplacedOnceStrictly,

    arrayReplaceElement,
    arrayReplaceElement2,
    arrayReplaceElementOnce,
    arrayReplaceElementOnceStrictly,
    arrayReplacedElement,
    arrayReplacedElement2,
    arrayReplacedElementOnce,
    arrayReplacedElementOnceStrictly,

    arrayReplaceArray,
    arrayReplaceArrayOnce,
    arrayReplaceArrayOnceStrictly,
    arrayReplacedArray,
    arrayReplacedArrayOnce,
    arrayReplacedArrayOnceStrictly,

    arrayReplaceArrays,
    arrayReplaceArraysOnce,
    arrayReplaceArraysOnceStrictly,
    arrayReplacedArrays,
    arrayReplacedArraysOnce,
    arrayReplacedArraysOnceStrictly,

    // arrayReplaceAll,
    // arrayReplacedAll,

    arrayUpdate,

    // array set

    arraySetDiff,

    arraySetBut,
    arraySetIntersection,
    arraySetUnion,

    arraySetContainAll,
    arraySetContainAny,
    arraySetIdentical,

    loggerProblemExperiment,

    // unused, routine is not defined

    // arrayJoin,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
