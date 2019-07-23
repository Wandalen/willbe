( function _Entity_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );

}

var _global = _global_;
var _ = _global_.wTools;
var Self = {};

// --
// routines
// --

function eachSample( test )
{
  test.case = 'empty sets';
  var got = _.eachSample( [] );
  var expected = [ [] ];
  test.identical( got, expected );

  var got = _.eachSample( { sets : {} } );
  var expected = [ {} ];
  test.identical( got, expected );

  var got = _.eachSample( {}, null );
  var expected = [ {} ];
  test.identical( got, expected );

  test.case = 'empty sets and unroll, Array';
  var got = _.eachSample( _.unrollMake( [] ) );
  var expected = [ [] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.eachSample( new Array() );
  var expected = [ [] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var src = _.arrayFrom( new Float32Array() )
  var got = _.eachSample( src );
  var expected = [ [] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample( _.argumentsArrayMake( 0 ), null );
  var expected = [ [] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  /* - */

  test.case = 'sets with primitive';
  var got = _.eachSample( [ 1 ] );
  var expected = [ [ 1 ] ];
  test.identical( got, expected );

  var got = _.eachSample( { a : 1 }, null );
  var expected = [ { a : 1 } ];
  test.identical( got, expected );

  var got = _.eachSample( [ 1, 2, null ] );
  var expected = [ [ 1, 2, null ] ];
  test.identical( got, expected );

  var got = _.eachSample( { a : 1, b : 2, c : null }, null );
  var expected = [ { a : 1, b : 2, c : null } ];
  test.identical( got, expected );

  test.case = 'sets with primitive and unroll, Array';
  var got = _.eachSample( _.unrollMake( [ 1 ] ) );
  var expected = [ [ 1 ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  var got = _.eachSample( new Array( [ 1 ] ) );
  var expected = [ [ 1 ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var src = _.arrayFrom( new Float32Array( [ 1 ] ) );
  var got = _.eachSample( src );
  var expected = [ [ 1 ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample( _.argumentsArrayMake( [ 1 ] ), null );
  var expected = [ [ 1 ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  /* - */

  test.case = 'sets with empty array, empty map';
  var got = _.eachSample( [ [] ] );
  var expected = [ [ undefined ] ];
  test.identical( got, expected );

  var got = _.eachSample( { a : [] }, null );
  var expected = [ { a : undefined } ];
  test.identical( got, expected );

  var got = _.eachSample( [ [], [] ] );
  var expected = [ [ undefined, undefined ] ];
  test.identical( got, expected );

  var got = _.eachSample( { a : [], b : [] }, null );
  var expected = [ { a : undefined, b : undefined } ];
  test.identical( got, expected );

  var got = _.eachSample( [ [], [], [] ] );
  var expected = [ [ undefined, undefined, undefined ] ];
  test.identical( got, expected );

  var got = _.eachSample( { a : [], b : [], c : [] }, null );
  var expected = [ { a : undefined, b : undefined, c : undefined } ];
  test.identical( got, expected );

  test.case = 'sets with empty unrolls, Arrays';
  var got = _.eachSample( _.unrollMake( [ [], [] ] ) );
  var expected = [ [ undefined, undefined ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample( new Array( [ [], [], [] ] ) );
  var expected = [ [ [] ], [ [] ], [ [] ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var src = _.arrayFrom( new Float32Array( [ [], [], [] ] ) );
  var got = _.eachSample( src );
  var expected = [ [ 0, 0, 0 ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample( _.argumentsArrayMake( [ [], [] ] ) );
  var expected = [ [ undefined, undefined ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  /* - */

  test.case = 'sets with primitive, result : null';

  var got = _.eachSample( { sets : [ 1, 2, 3 ], result : 0 } );
  var expected = 0;
  test.identical( got, expected );

  var got = _.eachSample( { sets : { a : 1, b : 2, c : null }, result : 0 } );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'sets with unroll, Array, result : null';
  var got = _.eachSample( { sets : _.unrollMake( [ 1, 2, 3 ] ), result : 0 } );
  var expected = 0;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  var got = _.eachSample( { sets : new Array( [ 1, 2, 3 ] ), result : 0 } );
  var expected = 2;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  var src = _.arrayFrom( new Float32Array( [ 1, 2, 3 ] ) );
  var got = _.eachSample( { sets : src, result : 0 } );
  var expected = 0;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  var got = _.eachSample( { sets : _.argumentsArrayMake( [ 1, 2, 3 ] ), result : 0 } );
  var expected = 0;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  /* - */

  test.case = 'sets with single not empty array, single not empty map';
  var got = _.eachSample( [ [ 1, 2, null, 'str' ] ] );
  var expected = [ [ 1 ], [ 2 ], [ null ], [ 'str' ] ];
  test.identical( got, expected );

  var got = _.eachSample( { a : [ 1, 2, null, 'str' ] }, null );
  var expected =
  [
    { a : 1 },
    { a : 2 },
    { a : null },
    { a : 'str' }
  ];
  test.identical( got, expected );

  test.case = 'sets with single not empty unroll, Array';
  var got = _.eachSample( _.unrollMake( [ [ 1, 2, null, 'str' ] ] ) );
  var expected = [ [ 1 ], [ 2 ], [ null ], [ 'str' ] ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample( _.argumentsArrayMake( [ [ 1, 2, null, 'str' ] ] ) );
  var expected = [ [ 1 ], [ 2 ], [ null ], [ 'str' ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample( new Array( [ [ 1, 2, null, 'str' ] ] ) );
  var expected = [ [ [ 1, 2, null, 'str' ] ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var src = _.arrayFrom( new Float32Array( [ [ 1, 2, 3 ] ] ) );
  var got = _.eachSample( src );
  test.notIdentical( got, [ [ [ 1, 2, 3 ] ] ] );
  test.is( _.arrayIs( got ) );

  /* - */

  test.case = 'simplest, leftToRight : 1';

  var got = _.eachSample(
    {
      sets : [ [ 0, 1 ], [ 2, 3 ] ]
    });
  var expected =
  [
    [ 0, 2 ], [ 1, 2 ],
    [ 0, 3 ], [ 1, 3 ],
  ];
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : { a : [ 0, 1 ], b : [ 2, 3 ] }
    });
  var expected =
  [
    { a : 0, b : 2 }, { a : 1, b : 2 },
    { a : 0, b : 3 }, { a : 1, b : 3 }
  ];
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : [ [ 0, 1 ], [ 2, 3 ], 6 ]
    });
  var expected =
  [
    [ 0, 2, 6 ], [ 1, 2, 6 ],
    [ 0, 3, 6 ], [ 1, 3, 6 ],
  ];
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : { a : [ 0, 1 ], b : [ 2, 3 ],  c : 6 }
    });
  var expected =
  [
    { a : 0, b : 2, c : 6 },
    { a : 1, b : 2, c : 6 },
    { a : 0, b : 3, c : 6 },
    { a : 1, b : 3, c : 6 }
  ];
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : [ [ 0, 1 ], [ 2, 3 ], [ 6, null ] ]
    });
  var expected =
  [
    [ 0, 2, 6 ], [ 1, 2, 6 ],
    [ 0, 3, 6 ], [ 1, 3, 6 ],
    [ 0, 2, null ], [ 1, 2, null ],
    [ 0, 3, null ], [ 1, 3, null ],
  ];
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : { a : [ 0, 1 ], b : [ 2, 3 ], c: [ 6, null ] }
    });
  var expected =
  [
    { a : 0, b : 2, c : 6 }, { a : 1, b : 2, c : 6 },
    { a : 0, b : 3, c : 6 }, { a : 1, b : 3, c : 6 },
    { a : 0, b : 2, c : null }, { a : 1, b : 2, c : null },
    { a : 0, b : 3, c : null }, { a : 1, b : 3, c : null },
  ];
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : [ _.argumentsArrayMake( [ 0, 1 ] ), _.argumentsArrayMake( [ 2, 3 ] ) ]
    });
  var expected =
  [
    [ 0, 2 ], [ 1, 2 ],
    [ 0, 3 ], [ 1, 3 ],
  ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample(
    {
      sets : [ new Array( [ 0, 1 ] ), new Array( [ 2, 3 ] ) ]
    });
  var expected = [ [ [ 0, 1 ], [ 2, 3 ] ] ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  var a = _.arrayFrom( new Float32Array( [ 0, 1 ] ) );
  var b = _.arrayFrom( new Float32Array( [ 2, 3 ] ) );
  var got = _.eachSample(
    {
      sets : [ a, b ]
    });
  var expected =
  [
    [ 0, 2 ], [ 1, 2 ],
    [ 0, 3 ], [ 1, 3 ],
  ];
  test.identical( got, expected );
  test.is( _.arrayIs( got ) );

  /* - */

  test.case = 'simplest leftToRight : 0';

  var got = _.eachSample
  ({
    sets : [ [ 0, 1 ], [ 5, 6 ] ],
    leftToRight : 0,
  });
  var expected =
  [
    [ 0, 5 ],[ 0, 6 ],
    [ 1, 5 ],[ 1, 6 ]
  ];
  test.identical( got, expected );

  var got = _.eachSample
  ({
    sets : { a : [ 0, 1 ], b : [ 5, 6 ] },
    leftToRight : 0,
  });
  var expected =
  [
    { a : 0, b : 5 }, { a : 0, b : 6 },
    { a : 1, b : 5 }, { a : 1, b : 6 }
  ];
  test.identical( got, expected );

  var got = _.eachSample
  ({
    sets : [ [ 0, 1 ], [ 'str', null ], [ true, 2 ] ],
    leftToRight : 0,
  });
  var expected =
  [
    [ 0, 'str', true ], [ 0, 'str', 2 ],
    [ 0, null, true ], [ 0, null, 2 ],
    [ 1, 'str', true ], [ 1, 'str', 2 ],
    [ 1, null, true ], [ 1, null, 2 ]
  ];
  test.identical( got, expected );

  /* - */

  test.case = 'simplest, leftToRight : 1, result : 0';

  var got = _.eachSample(
    {
      sets : [ [ 0, 1 ], [ 2, 3 ] ],
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : { a : [ 0, 1 ], b : [ 2, 3 ] },
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : [ [ 0, 1 ], [ 2, 3 ], 6 ],
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : { a : [ 0, 1 ], b : [ 2, 3 ],  c : 6 },
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : [ [ 0, 1 ], [ 2, 3 ], [ 6, null ] ],
      result : 0,
    });
  var expected = 7;
  test.identical( got, expected );

  var got = _.eachSample(
    {
      sets : { a : [ 0, 1 ], b : [ 2, 3 ], c: [ 6, null ] },
      result : 0,
    });
  var expected = 7;
  test.identical( got, expected );

  test.case = 'simplest, leftToRight : 1, unroll, Array';
  var got = _.eachSample(
    {
      sets : [ _.unrollMake( [ 0, 1 ] ), _.unrollMake( [ 2, 3 ] ) ],
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  var got = _.eachSample(
    {
      sets : [ _.argumentsArrayMake( [ 0, 1 ] ), _.argumentsArrayMake( [ 2, 3 ] ) ],
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  var got = _.eachSample(
    {
      sets : [ new Array( [ 0, 1 ] ), new Array( [ 2, 3 ] ) ],
      result : 0,
    });
  var expected = 0;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  var a = _.arrayFrom( new Float32Array( [ 0, 1 ] ) );
  var b = _.arrayFrom( new Float32Array( [ 2, 3 ] ) );
  var got = _.eachSample(
    {
      sets : [ a, b ],
      result : 0,
    });
  var expected = 3;
  test.identical( got, expected );
  test.is( _.primitiveIs( got ) );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'not argument, extra arguments';
  test.shouldThrowErrorSync( () => _.eachSample() );
  test.shouldThrowErrorSync( () => _.eachSample( [ [ 1 ], [ 2 ] ], null, [ 1 ] ) );

  test.case = 'o.sets is not arraylike, not mapLike';
  test.shouldThrowErrorSync( () => _.eachSample( {} ) );
  test.shouldThrowErrorSync( () => _.eachSample( 1 ) );
  test.shouldThrowErrorSync( () => _.eachSample( 'str', null ) );

  test.case = 'onEach is not a routine or null';
  test.shouldThrowErrorSync( () => _.eachSample( [ [ 1 ], [ 2 ] ], 'str' ) );

  test.case = 'o.base has a value';
  var o = {};
  o.sets = [ [ 1, 0 ], [ 2, 3 ] ];
  o.base = [ 5 ];
  test.shouldThrowErrorSync( () => _.eachSample( o ) );

  test.case = 'o.add has a value';
  var o = {};
  o.sets = [ [ 1, 0 ], [ 2, 3 ] ];
  o.add = [ 5 ];
  test.shouldThrowErrorSync( () => _.eachSample( o ) );
}

//

function eachSampleExperiment( test )
{
  debugger;

  var got = _.eachSample
  ({
    sets : [ [ 0, 1 ], [ 2, 3 ] ]
  });
  var expected =
  [
    [ 0, 2 ], [ 1, 2 ],
    [ 0, 3 ], [ 1, 3 ],
  ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got = _.eachSample
  ({
    sets : [ _.unrollMake( [ 0, 1 ] ), _.unrollMake( [ 2, 3 ] ) ]
  });
  var expected =
  [
    [ 0, 2 ], [ 1, 2 ],
    [ 0, 3 ], [ 1, 3 ],
  ];
  test.identical( got, expected );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

}
eachSampleExperiment.experimental = 1;

//

function entityEach( test )
{
  test.open( 'src is an ArrayLike');

  test.case = 'empty arrayLike objects';
  var got;
  var src = [];
  _.entityEach( src, ( v ) => got = typeof v );
  test.identical( got, undefined );

  var got = [];
  var src = _.unrollMake( 0 );
  _.entityEach( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = _.argumentsArrayMake( 0 );
  _.entityEach( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = new Array( 0 );
  _.entityEach( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, src );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = new Float32Array( 0 );
  _.entityEach( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  //

  test.case = 'not empty arrayLike objects';

  var got = [];
  var src = [ 0, 1, 2 ];
  _.entityEach( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );

  var got = [];
  var src = _.unrollMake( [ 0, 1, _.unrollMake( [ 2 ] ) ] );
  _.entityEach( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( src ) );

  var got = [];
  var src = _.argumentsArrayMake( [ 0, 1, 2 ] );
  _.entityEach( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Array( 0, 1, 2 );
  _.entityEach( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Float32Array( [ 0, 1, 2 ] );
  _.entityEach( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.is( _.longIs( src ) );

  //

  test.case = 'routine counter';

  var onEach = function( v, i )
  {
    if( _.strIs( v ) && i >= 0 )
    got += 10;
    else
    got -= 1;
  }

  var got = 0;
  _.entityEach( 1, onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEach( 'abc', onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEach( [ 'abc', 1, 'ab', 'a' ], onEach );
  test.identical( got, 29 );

  var got = 0;
  _.entityEach( [ { a : 1 }, { b : 2 } ], onEach );
  test.identical( got, -2 );

  var got = 0;
  var src = _.unrollFrom( [ 1, 'str', _.unrollMake( [ 2, 'str' ] ) ] );
  _.entityEach( src, onEach );
  test.identical( got, 18 );

  var got = 0;
  var src = _.argumentsArrayMake( [ 1, 'str', [ 2, 'str' ] ] );
  _.entityEach( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = new Array( 1, 'str', [ 2, 'str' ] );
  _.entityEach( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = new Float32Array( [ 1, 1, [ 2 ] ] );
  _.entityEach( src, onEach );
  test.identical( got, -3 );

  test.case = 'Third argument in onEach'
  var onEach = function( v, i, src )
  {
    if( _.longIs( src ) )
    got = src;
    else
    got += 10;
  }

  var got;
  var src = [ 0, 1, 3, 5 ];
  _.entityEach( src, onEach );
  test.identical( got, src );

  var got;
  var src = _.unrollMake( [ 0, 1, _.unrollFrom( [ 3, 5 ] ) ] );
  _.entityEach( src, onEach );
  test.identical( got, [ 0, 1, 3, 5 ] );
  test.is( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got;
  var src = _.argumentsArrayMake( [ 0, 1, [ 3, 5 ] ] );
  _.entityEach( src, onEach );
  test.identical( got, src );
  test.is( _.longIs( got ) );

  var got;
  var src = new Array( 1, 2, null, true );
  _.entityEach( src, onEach );
  test.identical( got, src );
  test.is( _.longIs( got ) );

  var got;
  var src = new Float32Array( [ 1, 2, 1, 3 ] );
  _.entityEach( src, onEach );
  test.equivalent( got, [ 1, 2, 1, 3 ] );
  test.is( _.longIs( got ) );

  test.close( 'src is an ArrayLike');

  /* - */

  test.open( 'src is an object' );

  var got = {};
  _.entityEach( {}, ( v ) => got = v );
  test.identical( got, {} );

  var got = {};
  _.entityEach( Object.create( null ), ( v, k ) => got[ k ] = v + k );
  test.identical( got, {} );

  var got = {};
  _.entityEach( { a : 1, b : 3, c : 5 }, ( v, k ) => got[ k ] = v * v + k );
  test.identical( got, { a : '1a', b : '9b', c : '25c' } );

  //

  test.case = 'routine counter';

  var onEach = function( v, k )
  {
    if( _.strIs( v ) && k )
    got += 10;
    else
    got -= 1;
  }

  var got = 0;
  _.entityEach( 'abc', onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEach( { a : 'abc', b : { a : 1 }, c : [ null ], d : undefined }, onEach );
  test.identical( got, 7 );

  var got = 0;
  _.entityEach( { a : 'abc', b : 1, c : 'ab', d : 'a' }, onEach );
  test.identical( got, 29 );

  //

  test.case = 'Third argument in onEach'
  var onEach = function( v, k, src )
  {
    if( _.objectIs( src ) )
    got = src;
    else
    got += 10;
  }

  var got = {};
  var src = { a : 1, b : 2, c : 3 };
  _.entityEach( src, onEach );
  test.identical( got, src );

  test.close( 'src is an object' );

  /* - */

  test.case = 'src is not ArrayLike or ObjectLike';

  var got;
  _.entityEach( null, ( v ) => got = typeof v );
  test.identical( got, 'object' );

  var got;
  _.entityEach( 1, ( v ) => got = typeof v );
  test.identical( got, 'number' );

  var got;
  _.entityEach( 'a', ( v ) => got = v + 2 );
  test.identical( got, 'a2' );

  var got;
  _.entityEach( function b(){ return 'a'}, ( v ) => got = typeof v );
  test.identical( got, 'function' );

  var got;
  _.entityEach( function b(){ return 'a'}, ( v, i ) => got = typeof v + ' ' + typeof i );
  test.identical( got, 'function undefined' );

  //

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityEach() );

  test.case = 'only one argument';
  test.shouldThrowErrorSync( () => _.entityEach( [ 'a' ] ) );

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( () => _.entityEach( [ 'a' ], ( a ) => a, ( b ) => b ) );

  test.case = 'onEach has more then three args';
  test.shouldThrowErrorSync( () => _.entityEach( [ 1 ], ( a, b, c, d ) => a + b + c + d ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.entityEach( { a : 2 }, [] ) );
}

//

function entityEachKey( test )
{
  test.open( 'src is an ArrayLike');

  test.case = 'empty arrayLike objects'
  var got;
  var src = [];
  _.entityEachKey( src, ( v ) => got = typeof v );
  test.identical( got, undefined );

  var got = [];
  var src = _.unrollMake( 0 );
  _.entityEachKey( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = _.argumentsArrayMake( 0 );
  _.entityEachKey( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Array( 0 );
  _.entityEachKey( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, src );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Float32Array( 0 );
  _.entityEachKey( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );

  //

  test.case = 'not empty arrayLike objects';

  var got = [];
  var src = [ 0, 1, 2 ];
  _.entityEachKey( src, ( v, u, i ) => got[ i ] = v * v );
  test.identical( got, [ 0, 1, 4 ] );

  var got = [];
  var src = _.unrollMake( [ 0, 1, _.unrollMake( [ 2 ] ) ] );
  _.entityEachKey( src, ( v, u, i ) => got[ i ] = v * v );
  test.identical( got, [ 0, 1, 4 ] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( src ) );

  var got = [];
  var src = _.argumentsArrayMake( [ 0, 1, 2 ] );
  _.entityEachKey( src, ( v, u, i ) => got[ i ] = v * v );
  test.identical( got, [ 0, 1, 4 ] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Array( 0, 1, 2 );
  _.entityEachKey( src, ( v, u, i ) => got[ i ] = v * v );
  test.identical( got, [ 0, 1, 4 ] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Float32Array( [ 0, 1, 2 ] );
  _.entityEachKey( src, ( v, u, i ) => got[ i ] = v * v );
  test.identical( got, [ 0, 1, 4 ] );
  test.is( _.longIs( src ) );

  //

  test.case = 'routine counter';

  var onEach = function( v, u )
  {
    if( _.strIs( v ) && u === undefined )
    got += 10;
    else
    got -= 1;
  }

  var got = 0;
  _.entityEachKey( 1, onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEachKey( 'abc', onEach );
  test.identical( got, 10 );

  var got = 0;
  _.entityEachKey( [ 'abc', 1, 'ab', 'a',  { a : 1 } ], onEach );
  test.identical( got, 28 );

  var got = 0;
  var src = _.unrollFrom( [ 1, 'str', _.unrollMake( [ { a : 'abc' }, 'str' ] ) ] );
  _.entityEachKey( src, onEach );
  test.identical( got, 18 );

  var got = 0;
  var src = _.argumentsArrayMake( [ 1, 'str', [ [ 'abc' ], 'str' ] ] );
  _.entityEachKey( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = new Array( 1, 'str', [ 2, 'str' ] );
  _.entityEachKey( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = new Float32Array( [ 1, 1, [ 2 ] ] );
  _.entityEachKey( src, onEach );
  test.identical( got, -3 );

  test.case = 'Third argument in onEach'
  var onEach = function( v, u, i )
  {
    if( _.longIs( arguments[ 3 ] ) )
    got = src;
    else
    got += 10;
  }

  var got;
  var src = [ 0, 1, 3, 5 ];
  _.entityEachKey( src, onEach );
  test.identical( got, src );

  var got;
  var src = _.unrollMake( [ 0, 1, _.unrollFrom( [ 3, 5 ] ) ] );
  _.entityEachKey( src, onEach );
  test.identical( got, [ 0, 1, 3, 5 ] );
  test.is( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got;
  var src = _.argumentsArrayMake( [ 0, 1, [ 3, 5 ] ] );
  _.entityEachKey( src, onEach );
  test.identical( got, src );
  test.is( _.longIs( got ) );

  var got;
  var src = new Array( 1, 2, null, true );
  _.entityEachKey( src, onEach );
  test.identical( got, src );
  test.is( _.longIs( got ) );

  var got;
  var src = new Float32Array( [ 1, 2, 1, 3 ] );
  _.entityEachKey( src, onEach );
  test.equivalent( got, [ 1, 2, 1, 3 ] );
  test.is( _.longIs( got ) );

  test.close( 'src is an ArrayLike');

  /* - */

  test.open( 'src is an ObjectLike' );

  test.case = 'not onEach';
  var got = {};
  _.entityEachKey( {}, ( v ) => got = v );
  test.identical( got, {} );

  var got = {};
  _.entityEachKey( Object.create( null ), ( v, k ) => got[ k ] = v + k );
  test.identical( got, {} );

  var got = {};
  _.entityEachKey( { a : 1, b : 3, c : 5 }, ( k, v ) => got[ k ] = v * v + k );
  test.identical( got, { a : '1a', b : '9b', c : '25c' } );

  //

  test.case = 'routine counter';
  var onEach = function( k, v )
  {
    if( _.strIs( v ) && k )
    got += 10;
    else
    got -= 1;
  }

  var got = 0;
  _.entityEachKey( 'abc', onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEachKey( { a : 'abc' }, onEach );
  test.identical( got, 10 );

  var got = 0;
  _.entityEachKey( { a : 'abc', b : 1, c : 'ab', d : null }, onEach );
  test.identical( got, 18 );

  var got = 0;
  _.entityEachKey( { a : [ 'a', 'b' ], b : { e : 1 } }, onEach );
  test.identical( got, -2 );

  //

  test.case = 'Third argument in onEach'
  var onEach = function( v, k, i )
  {
    got[ i ] = v + k;
  }

  var got = {};
  _.entityEachKey( { a : 1, b : 2, c : 3 }, onEach );
  test.identical( got, { 0 : 'a1', 1 : 'b2', 2 : 'c3' } );

  test.close( 'src is an ObjectLike' );

  /* - */

  test.case = 'src is not ArrayLike or ObjectLike';

  var got;
  _.entityEachKey( null, ( v ) => got = typeof v );
  test.identical( got, 'object' );

  var got;
  _.entityEachKey( 1, ( v ) => got = typeof v );
  test.identical( got, 'number' );

  var got;
  _.entityEachKey( 'a', ( v ) => got = v + 2 );
  test.identical( got, 'a2' );

  var got;
  _.entityEachKey( function b(){ return 'a'}, ( v, i ) => got = typeof v + ' ' + typeof i );
  test.identical( got, 'function undefined' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityEachKey() );

  test.case = 'only one argument';
  test.shouldThrowErrorSync( () => _.entityEachKey( [ 'a' ] ) );

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( () => _.entityEachKey( [ 'a' ], ( a ) => a, ( b ) => b ) );

  test.case = 'onEach has more then three arg';
  test.shouldThrowErrorSync( () => _.entityEachKey( [ 1 ], ( a, b, c, d ) => a + b + c + d ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.entityEachKey( { a : 2 }, [] ) );
}

//

function entityEachOwn( test )
{
  test.open( 'src is an ArrayLike');

  test.case = 'empty arrayLike objects';
  var got;
  var src = [];
  _.entityEachOwn( src, ( v ) => got = typeof v );
  test.identical( got, undefined );

  var got = [];
  var src = _.unrollMake( 0 );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = _.argumentsArrayMake( 0 );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = new Array( 0 );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, src );
  test.is( _.arrayIs( got ) );

  var got = [];
  var src = new Float32Array( 0 );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v + i );
  test.identical( got, [] );
  test.is( _.arrayIs( got ) );

  //

  test.case = 'not empty arrayLike objects';

  var got = [];
  var src = [ 0, 1, 2 ];
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );

  var got = [];
  var src = _.unrollMake( [ 0, 1, _.unrollMake( [ 2 ] ) ] );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( src ) );

  var got = [];
  var src = _.argumentsArrayMake( [ 0, 1, 2 ] );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Array( 0, 1, 2 );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.is( _.longIs( src ) );

  var got = [];
  var src = new Float32Array( [ 0, 1, 2 ] );
  _.entityEachOwn( src, ( v, i ) => got[ i ] = v * v + i );
  test.identical( got, [ 0, 2, 6 ] );
  test.is( _.longIs( src ) );

  //

  test.case = 'routine counter';

  var onEach = function( v, i )
  {
    if( _.strIs( v ) && i >= 0 )
    got += 10;
    else
    got -= 1;
  }

  var got = 0;
  _.entityEachOwn( 1, onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEachOwn( 'abc', onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEachOwn( [ 'abc', 1, 'ab', 'a' ], onEach );
  test.identical( got, 29 );

  var got = 0;
  _.entityEachOwn( [ { a : 1 }, { b : 2 } ], onEach );
  test.identical( got, -2 );

  var got = 0;
  var src = _.unrollFrom( [ 1, 'str', _.unrollMake( [ 2, 'str' ] ) ] );
  _.entityEachOwn( src, onEach );
  test.identical( got, 18 );

  var got = 0;
  var src = _.argumentsArrayMake( [ 1, 'str', [ 2, 'str' ] ] );
  _.entityEachOwn( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = new Array( 1, 'str', [ 2, 'str' ] );
  _.entityEachOwn( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = new Float32Array( [ 1, 1, [ 2 ] ] );
  _.entityEachOwn( src, onEach );
  test.identical( got, -3 );

  test.case = 'Third argument in onEach'
  var onEach = function( v, i, src )
  {
    if( _.longIs( src ) )
    got = src;
    else
    got += 10;
  }

  var got;
  var src = [ 0, 1, 3, 5 ];
  _.entityEachOwn( src, onEach );
  test.identical( got, src );

  var got;
  var src = _.unrollMake( [ 0, 1, _.unrollFrom( [ 3, 5 ] ) ] );
  _.entityEachOwn( src, onEach );
  test.identical( got, [ 0, 1, 3, 5 ] );
  test.is( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  var got;
  var src = _.argumentsArrayMake( [ 0, 1, [ 3, 5 ] ] );
  _.entityEachOwn( src, onEach );
  test.identical( got, src );
  test.is( _.longIs( got ) );

  var got;
  var src = new Array( 1, 2, null, true );
  _.entityEachOwn( src, onEach );
  test.identical( got, src );
  test.is( _.longIs( got ) );

  var got;
  var src = new Float32Array( [ 1, 2, 1, 3 ] );
  _.entityEachOwn( src, onEach );
  test.equivalent( got, [ 1, 2, 1, 3 ] );
  test.is( _.longIs( got ) );

  test.close( 'src is an ArrayLike');

  /* - */

  test.open( 'src is an ObjectLike' );

  var got ={};
  _.entityEachOwn( {}, ( v ) => got = v );
  test.identical( got, {} );

  var got = {};
  var src = Object.create( null );
  var src2 = Object.create( src );
  _.entityEachOwn( src, ( v, k ) => got[ k ] = v + k );
  test.identical( got, {} );
  _.entityEachOwn( src2, ( v, k ) => got[ k ] = v + k );
  test.identical( got, {} );

  var got = {};
  var src = Object.create( null );
  src.a = 1;
  src.b = 3;
  var src2 = Object.create( src );
  _.entityEachOwn( src2, ( v, k ) => got[ k ] = v * v + k );
  test.identical( got, {} );
  _.entityEachOwn( src, ( v, k ) => got[ k ] = v * v + k );
  test.identical( got, { a : '1a', b : '9b' } );

  test.case = 'routine counter';

  var onEach = function( v, k )
  {
    if( _.strIs( v ) && k )
    got += 10;
    else
    got -= 1;
  }

  var got = 0;
  _.entityEachOwn( 1, onEach );
  test.identical( got, -1 );

  var got = 0;
  _.entityEachOwn( { a : 'abc', b : 1, c : 'ab', d : null }, onEach );
  test.identical( got, 18 );

  var got = 0;
  var src = { name : 'object', toString : 1, toSource : null };
  var src2 = Object.create( src );
  _.entityEachOwn( src2, onEach );
  test.identical( got, 0 );
  _.entityEachOwn( src, onEach );
  test.identical( got, 8 );

  var got = 0;
  var src = Object.create( null );
  src.a = [ 'a', 'b' ];
  src.b = { a : 1 };
  var src2 = Object.create( src );
  src2.c = 'str';
  test.identical( src.a, src2.a );
  test.identical( src.b, src2.b );
  _.entityEachOwn( src, onEach );
  test.identical( got, -2 );
  _.entityEachOwn( src2, onEach );
  test.identical( got, 8 );

  test.case = 'Third argument in onEach'
  var onEach = function( v, k, src )
  {
    if( _.objectIs( src ) )
    got = src;
    else
    got += 10;
  }

  var got = {};
  var src = Object.create( null );
  src.a = 'str';
  var src2 = Object.create( src );
  _.entityEachOwn( src2, onEach );
  test.identical( got, {} );
  _.entityEachOwn( src, onEach );
  test.identical( got, src );

  test.close( 'src is an ObjectLike' );

  /* - */

  test.case = 'src is not ArrayLike or ObjectLike';

  var got;
  _.entityEachOwn( null, ( v ) => got = typeof v );
  test.identical( got, 'object' );

  var got;
  _.entityEachOwn( 1, ( v ) => got = typeof v );
  test.identical( got, 'number' );

  var got;
  _.entityEachOwn( 'a', ( v ) => got = v + 2 );
  test.identical( got, 'a2' );

  var got;
  _.entityEachOwn( function b(){ return 'a'}, ( v, i ) => got = typeof v + ' ' + typeof i );
  test.identical( got, 'function undefined' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityEachOwn() );

  test.case = 'only one argument';
  test.shouldThrowErrorSync( () => _.entityEachOwn( [ 'a' ] ) );

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( () => _.entityEachOwn( [ 'a' ], ( a ) => a, ( b ) => b ) );

  test.case = 'onEach has more then three arg';
  test.shouldThrowErrorSync( () => _.entityEachOwn( [ 1 ], ( a, b, c, d ) => a + b + c + d ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.entityEachOwn( { a : 2 }, [] ) );
}

//

function entityAll( test )
{
  test.open( 'onEach is routine' );

  test.case = 'array';

  var got = _.entityAll( [ 1, 'str', undefined ], ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var got = _.entityAll( [ 1, 'str', { a : 2 }, 4 ], ( v, i ) => !!v && i + 2 < 6 );
  test.identical( got, true );

  var got = _.entityAll( [ 1, 'str', { a : 2 }, false ], ( v, i ) => !!v && i + 2 < 6 );
  test.identical( got, false );

  var got = _.entityAll( [ 1, 'str', 3, null ], () => undefined );
  test.identical( got, undefined );

  test.case = 'unroll';

  var src = _.unrollFrom( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), undefined, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAll( src, () => undefined );
  test.identical( got, undefined );

  test.case = 'argument array';

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], false, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAll( src, () => undefined );
  test.identical( got, undefined );

  test.case = 'Array';

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = new Array( 1, 2, [ 'str' ], false, 4 );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityAll( src, () => undefined );
  test.identical( got, undefined );

  test.case = 'Float32Array';

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = new Float32Array( [ 1, 2, [ 8 ], false, 4 ] );
  var got = _.entityAll( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAll( src, () => undefined );
  test.identical( got, undefined );

  test.case = 'ObjectLike';

  var got = _.entityAll( { 1 : 2, c : 4, a : undefined }, ( v, k ) => v === k );
  test.identical( got, false );

  var got = _.entityAll( { 'a' : 'a', '4' : '4', 'true' : 'true' }, ( v, k ) => v === k );
  test.identical( got, true );

  var got = _.entityAll( { 1 : 2, 2 : 3, a : null }, ( v, k ) => v !== k );
  test.identical( got, true );

  var got = _.entityAll( { a : 1, b : 3, c : true }, ( v, k ) => v !== k );
  test.identical( got, true );

  var got = _.entityAll( { 'a' : 'a', 'b' : 'str' }, ( v, k ) => typeof v === typeof k );
  test.identical( got, true );

  var got = _.entityAll( { a : 1, b : false }, ( v, k ) => v === k );
  test.identical( got, false );

  var got = _.entityAll( { a : 1, b : false }, ( v, k, src ) => src.length !== k );
  test.identical( got, true );

  test.case = 'no ArrayLike, no ObjectLike'

  var got = _.entityAll( undefined, ( src, u ) => src !== u );
  test.identical( got, false );

  var got = _.entityAll( null, ( src, u ) => src === u );
  test.identical( got, false );

  var got = _.entityAll( 1, ( src, u ) => src === u );
  test.identical( got, false );

  var got = _.entityAll( 'str', ( src, u ) => src === u );
  test.identical( got, false );

  var got = _.entityAll( false, ( src, u ) => src === u );
  test.identical( got, false );

  var got = _.entityAll( true, ( src, u ) => src !== u );
  test.identical( got, true );

  var got = _.entityAll( true, ( src, u, u2 ) => src !== u2 );
  test.identical( got, true );

  test.close( 'onEach is routine' );

  /* - */

  test.open( 'onEach is null' );

  test.case = 'array';

  var got = _.entityAll( [ 1, 'str', undefined ] );
  test.identical( got, undefined );

  var got = _.entityAll( [ 1, 'str', { a : 2 }, 4 ] );
  test.identical( got, true );

  var got = _.entityAll( [ 1, 'str', { a : 2 }, false ] );
  test.identical( got, false );

  test.case = 'unroll';

  var src = _.unrollFrom( [ 1, 2, _.unrollFrom( [ 'str' ] ), null, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, null );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, true );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), false, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, false );

  test.case = 'argument array';

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], undefined, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, undefined );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, true );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], false, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, false );

  test.case = 'Array';

  var src = new Array( 1, 2, [ 'str' ], null, 4 );
  var got = _.entityAll( src );
  test.identical( got, null );

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityAll( src );
  test.identical( got, true );

  var src = new Array( 1, 2, [ 'str' ], false, 4 );
  var got = _.entityAll( src );
  test.identical( got, false );

  test.case = 'Float32Array';

  var src = new Float32Array( [ null, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, 0 );

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAll( src );
  test.identical( got, true );

  var src = new Float32Array( [ 1, 2, [ 8 ], 'str', 4 ] );
  var got = _.entityAll( src );
  test.identical( got, NaN );

  test.case = 'ObjectLike';

  var got = _.entityAll( { 1 : 2, c : 4, a : undefined } );
  test.identical( got, undefined );

  var got = _.entityAll( { 1 : 2, 2 : 3, a : null } );
  test.identical( got, null );

  var got = _.entityAll( { a : 1, b : 3, c : true } );
  test.identical( got, true );

  var got = _.entityAll( { a : 'a', b : 'str' } );
  test.identical( got, true );

  var got = _.entityAll( { a : 1, b : false } );
  test.identical( got, false );

  test.case = 'no ArrayLike, no ObjectLike'

  var got = _.entityAll( undefined );
  test.identical( got, undefined );

  var got = _.entityAll( null );
  test.identical( got, null );

  var got = _.entityAll( 1 );
  test.identical( got, true );

  var got = _.entityAll( 'str' );
  test.identical( got, true );

  var got = _.entityAll( false );
  test.identical( got, false );

  var got = _.entityAll( true );
  test.identical( got, true );

  test.close( 'onEach is null' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityAll() );

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( () => _.entityAll( [ 'a' ], ( a ) => a, ( b ) => b ) );

  test.case = 'onEach has more then three arg';
  test.shouldThrowErrorSync( () => _.entityAll( [ 1 ], ( a, b, c, d ) => a + b + c + d ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.entityAll( { a : 2 }, [] ) );
}

//

function entityAny( test )
{
  test.open( 'onEach is routine' );

  test.case = 'array';

  var got = _.entityAny( [ 1, 'str', undefined ], ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, true );

  var got = _.entityAny( [ false, false, undefined ], ( v, i ) => !!v && i + 2 < 6 );
  test.identical( got, false );

  var got = _.entityAny( [ 1, 'str', { a : 2 }, false ], ( v, i ) => !!v && i + 2 < 6 );
  test.identical( got, true );

  var got = _.entityAny( [ 1, 'str', 3, null ], () => undefined );
  test.identical( got, false );

  test.case = 'unroll';

  var src = _.unrollFrom( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, true );

  var src = _.unrollMake( [ undefined, false, _.unrollFrom( null ) ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = _.unrollMake( [ undefined, false, _.unrollFrom( [ 'str' ] ) ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAny( src, () => undefined );
  test.identical( got, false );

  test.case = 'argument array';

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, true );

  var src = _.argumentsArrayMake( [ false, null, undefined ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], false, 4 ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAny( src, () => undefined );
  test.identical( got, false );

  test.case = 'Array';

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, true );

  var src = new Array( false, undefined, null );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = new Array( 1, 2, [ 'str' ], false, 4 );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityAny( src, () => undefined );
  test.identical( got, false );

  test.case = 'Float32Array';

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, true );

  var src = new Float32Array( [ 'a', undefined, false, null ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = new Float32Array( [ 1, 2, [ 8 ], false, 4 ] );
  var got = _.entityAny( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityAny( src, () => undefined );
  test.identical( got, false );

  test.case = 'ObjectLike';

  var got = _.entityAny( { 1 : 2, c : 4, a : undefined }, ( v, k ) => v === k );
  test.identical( got, false );

  var got = _.entityAny( { 'a' : false, '4' : false, 'true' : 'true' }, ( v, k ) => v === k );
  test.identical( got, true );

  var got = _.entityAny( { 1 : 2, 2 : 3, a : null }, ( v, k ) => typeof v === typeof k );
  test.identical( got, false );

  var got = _.entityAny( { 'a' : [], 'b' : 'str' }, ( v, k ) => typeof v === typeof k );
  test.identical( got, true );

  var got = _.entityAny( { a : 1, b : false }, ( v, k ) => v === k );
  test.identical( got, false );

  var got = _.entityAny( { a : 1, b : false }, ( v, k, u ) => v !== u );
  test.identical( got, true );

  test.case = 'no ArrayLike, no ObjectLike'

  var got = _.entityAny( undefined, ( src, u ) => src !== u );
  test.identical( got, false );

  var got = _.entityAny( null, ( src, u ) => src === u );
  test.identical( got, false );

  var got = _.entityAny( 1, ( src, u ) => src !== u );
  test.identical( got, true );

  var got = _.entityAny( 'str', ( src, u ) => src === u );
  test.identical( got, false );

  var got = _.entityAny( false, ( src, u ) => src !== u );
  test.identical( got, true );

  var got = _.entityAny( true, ( src, u ) => src !== u );
  test.identical( got, true );

  var got = _.entityAny( true, ( src, u, u2 ) => src !== u2 );
  test.identical( got, true );

  test.close( 'onEach is routine' );

  /* - */

  test.open( 'onEach is null' );

  test.case = 'array';

  var got = _.entityAny( [ 1, 'str', undefined ] );
  test.identical( got, 1 );

  var got = _.entityAny( [ 'str', 1, { a : 2 }, 4 ] );
  test.identical( got, 'str' );

  var got = _.entityAny( [ false, null, undefined ] );
  test.identical( got, false );

  test.case = 'unroll';

  var src = _.unrollFrom( [ false, 2, _.unrollFrom( [ 'str' ] ), null, 4 ] );
  var got = _.entityAny( src );
  test.identical( got, 2 );

  var src = _.unrollMake( [ undefined, false, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityAny( src );
  test.identical( got, 'str' );

  var src = _.unrollMake( [ null, undefined, false ] );
  var got = _.entityAny( src );
  test.identical( got, false );

  test.case = 'argument array';

  var src = _.argumentsArrayMake( [ null, false, [ 'str' ], undefined, 4 ] );
  var got = _.entityAny( src );
  test.identical( got, [ 'str' ] );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAny( src );
  test.identical( got, 1 );

  var src = _.argumentsArrayMake( [ null, false, undefined ] );
  var got = _.entityAny( src );
  test.identical( got, false );

  test.case = 'Array';

  var src = new Array( false, 'ab', [ 'str' ], null, 4 );
  var got = _.entityAny( src );
  test.identical( got, 'ab' );

  var src = new Array( null, 22, [ 'str' ], 3, 4 );
  var got = _.entityAny( src );
  test.identical( got, 22 );

  var src = new Array( null, false, undefined );
  var got = _.entityAny( src );
  test.identical( got, false );

  test.case = 'Float32Array';

  var src = new Float32Array( [ 5, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityAny( src );
  test.identical( got, 5 );

  var src = new Float32Array( [ undefined, [ 8 ], 3, 4 ] );
  var got = _.entityAny( src );
  test.identical( got, 8 );

  var src = new Float32Array( [ 'str', undefined, { a : 2 } ] );
  var got = _.entityAny( src );
  test.identical( got, false );

  test.case = 'ObjectLike';

  var got = _.entityAny( { 1 : 2, c : 4, a : undefined } );
  test.identical( got, 2 );

  var got = _.entityAny( { 1 : 2, 2 : 3, a : null } );
  test.identical( got, 2 );

  var got = _.entityAny( { a : false, b : null, c : undefined } );
  test.identical( got, false );

  var got = _.entityAny( { a : 'a', b : 'str' } );
  test.identical( got, 'a' );

  var got = _.entityAny( { a : 1, b : false } );
  test.identical( got, 1 );

  test.case = 'no ArrayLike, no ObjectLike'

  var got = _.entityAny( undefined );
  test.identical( got, false );

  var got = _.entityAny( null );
  test.identical( got, false );

  var got = _.entityAny( 1 );
  test.identical( got, 1 );

  var got = _.entityAny( 'str' );
  test.identical( got, 'str' );

  var got = _.entityAny( false );
  test.identical( got, false );

  var got = _.entityAny( true );
  test.identical( got, true );

  test.close( 'onEach is null' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityAny() );

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( () => _.entityAny( [ 'a' ], ( a ) => a, ( b ) => b ) );

  test.case = 'onEach has more then three arg';
  test.shouldThrowErrorSync( () => _.entityAny( [ 1 ], ( a, b, c, d ) => a + b + c + d ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.entityAny( { a : 2 }, [] ) );
}

//

function entityNone( test )
{
  test.open( 'onEach is routine' );

  test.case = 'array';

  var got = _.entityNone( [ 1, 'str', undefined ], ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var got = _.entityNone( [ false, false, undefined ], ( v, i ) => !!v && i + 2 < 6 );
  test.identical( got, true );

  var got = _.entityNone( [ 1, 'str', { a : 2 }, false ], ( v, i ) => !!v && i + 2 < 6 );
  test.identical( got, false );

  var got = _.entityNone( [ 1, 'str', 3, null ], () => undefined );
  test.identical( got, true );

  test.case = 'unroll';

  var src = _.unrollFrom( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = _.unrollMake( [ undefined, false, _.unrollFrom( null ) ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = _.unrollMake( [ undefined, false, _.unrollFrom( [ 'str' ] ) ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = _.unrollMake( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityNone( src, () => undefined );
  test.identical( got, true );

  test.case = 'argument array';

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ false, null, undefined ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], false, 4 ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityNone( src, () => undefined );
  test.identical( got, true );

  test.case = 'Array';

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = new Array( false, undefined, null );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = new Array( 1, 2, [ 'str' ], false, 4 );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityNone( src, () => undefined );
  test.identical( got, true );

  test.case = 'Float32Array';

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 4 );
  test.identical( got, false );

  var src = new Float32Array( [ 'a', undefined, false, null ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, true );

  var src = new Float32Array( [ 1, 2, [ 8 ], false, 4 ] );
  var got = _.entityNone( src, ( v, i ) => !!v && i + 2 < 7 );
  test.identical( got, false );

  var src = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityNone( src, () => undefined );
  test.identical( got, true );

  test.case = 'ObjectLike';

  var got = _.entityNone( { 1 : 2, c : 4, a : undefined }, ( v, k ) => v === k );
  test.identical( got, true );

  var got = _.entityNone( { 'a' : false, '4' : false, 'true' : 'true' }, ( v, k ) => v === k );
  test.identical( got, false );

  var got = _.entityNone( { 1 : 2, 2 : 3, a : null }, ( v, k ) => typeof v === typeof k );
  test.identical( got, true );

  var got = _.entityNone( { 'a' : [], 'b' : 'str' }, ( v, k ) => typeof v === typeof k );
  test.identical( got, false );

  var got = _.entityNone( { a : 1, b : false }, ( v, k ) => v === k );
  test.identical( got, true );

  var got = _.entityNone( { a : 1, b : false }, ( v, k, src ) => src.length === v );
  test.identical( got, true );

  test.case = 'no ArrayLike, no ObjectLike'

  var got = _.entityNone( undefined, ( src, u ) => src !== u );
  test.identical( got, true );

  var got = _.entityNone( null, ( src, u ) => src === u );
  test.identical( got, true );

  var got = _.entityNone( 1, ( src, u ) => src !== u );
  test.identical( got, false );

  var got = _.entityNone( 'str', ( src, u ) => src === u );
  test.identical( got, true );

  var got = _.entityNone( false, ( src, u ) => src !== u );
  test.identical( got, false );

  var got = _.entityNone( true, ( src, u ) => src !== u );
  test.identical( got, false );

  var got = _.entityNone( true, ( src, u, u2 ) => src !== u2 );
  test.identical( got, false );

  test.close( 'onEach is routine' );

  /* - */

  test.open( 'onEach is undefined' );

  test.case = 'array';

  var got = _.entityNone( [ 1, 'str', undefined ] );
  test.identical( got, false );

  var got = _.entityNone( [ 'str', 1, { a : 2 }, 4 ] );
  test.identical( got, false );

  var got = _.entityNone( [ false, null, undefined ] );
  test.identical( got, true );


  test.case = 'unroll';

  var src = _.unrollFrom( [ false, 2, _.unrollFrom( [ 'str' ] ), null, 4 ] );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = _.unrollMake( [ undefined, false, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = _.unrollMake( [ null, undefined, false ] );
  var got = _.entityNone( src );
  test.identical( got, true );

  test.case = 'argument array';

  var src = _.argumentsArrayMake( [ null, false, [ 'str' ], undefined, 4 ] );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = _.argumentsArrayMake( [ null, false, undefined ] );
  var got = _.entityNone( src );
  test.identical( got, true );

  test.case = 'Array';

  var src = new Array( false, 'ab', [ 'str' ], null, 4 );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = new Array( null, 22, [ 'str' ], 3, 4 );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = new Array( null, false, undefined );
  var got = _.entityNone( src );
  test.identical( got, true );

  test.case = 'Float32Array';

  var src = new Float32Array( [ 5, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = new Float32Array( [ undefined, [ 8 ], 3, 4 ] );
  var got = _.entityNone( src );
  test.identical( got, false );

  var src = new Float32Array( [ 'str', undefined, { a : 2 } ] );
  var got = _.entityNone( src );
  test.identical( got, true );

  test.case = 'ObjectLike';

  var got = _.entityNone( { 1 : 2, c : 4, a : undefined } );
  test.identical( got, false );

  var got = _.entityNone( { 1 : 2, 2 : 3, a : null } );
  test.identical( got, false );

  var got = _.entityNone( { a : false, b : null, c : undefined } );
  test.identical( got, true );

  var got = _.entityNone( { a : 'a', b : 'str' } );
  test.identical( got, false );

  var got = _.entityNone( { a : 1, b : false } );
  test.identical( got, false );

  test.case = 'no ArrayLike, no ObjectLike'

  var got = _.entityNone( undefined );
  test.identical( got, true );

  var got = _.entityNone( null );
  test.identical( got, true );

  var got = _.entityNone( 1 );
  test.identical( got, false );

  var got = _.entityNone( 'str' );
  test.identical( got, false );

  var got = _.entityNone( false );
  test.identical( got, true );

  var got = _.entityNone( true );
  test.identical( got, false );

  test.close( 'onEach is undefined' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.entityNone() );

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( () => _.entityNone( [ 'a' ], ( a ) => a, ( b ) => b ) );

  test.case = 'onEach has more then three arguments';
  test.shouldThrowErrorSync( () => _.entityNone( [ 1 ], ( a, b, c, d ) => a + b + c + d ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.entityNone( { a : 2 }, [] ) );
}

//

function entityMap( test )
{
  test.open( 'src is arrayLike' );

  test.case = 'simple test with mapping array by sqr';
  var got = _.entityMap( [ 3, 4, 5 ], ( v, i, ent ) => v * v );
  test.identical( got,[ 9, 16, 25 ] );

  test.case = 'array';
  var src1 = [ 1, 2, null, 'str' ];
  var got = _.entityMap( src1, ( v, i, s ) => v + i );
  test.identical( got, [ 1, 3, 2, 'str3' ] );

  test.case = 'unroll';
  var src1 = _.unrollFrom( [ 1, 2, _.unrollFrom( [ 'str' ] ), 3, 4 ] );
  var got = _.entityMap( src1, ( v, i, s ) => v + i );
  test.identical( got, [ 1, 3, 'str2', 6, 8 ] );
  test.is( _.arrayIs( got ) );
  test.isNot( _.unrollIs( got ) );

  test.case = 'argument array';
  var src1 = _.argumentsArrayMake( [ 1, 2, [ 'str' ], 3, 4 ] );
  var got = _.entityMap( src1, ( v, i, s ) => v + i );
  test.identical( got, [ 1, 3, 'str2', 6, 8 ] );
  test.is( _.arrayIs( got ) );

  test.case = 'Array';
  var src1 = new Array( 1, 2, [ 'str' ], 3, 4 );
  var got = _.entityMap( src1, ( v, i, s ) => v + i );
  test.identical( got, [ 1, 3, 'str2', 6, 8 ] );
  test.is( _.arrayIs( got ) );

  test.case = 'Float32Array';
  var src1 = new Float32Array( [ 1, 2, [ 8 ], 3, 4 ] );
  var got = _.entityMap( src1, ( v, i, s ) => v + i );
  test.equivalent( got, [ 1, 3, 10, 6, 8 ] );
  test.is( _.longIs( got ) );

  test.close( 'src is arrayLike' );

  /* - */

  test.open( 'src is objectLike' );

  test.case = 'simple test with mapping object by sqr';
  var got = _.entityMap( { '3' : 3, '4' : 4, '5' : 5 }, ( v, i, ent ) => v * v );
  test.identical( got,{ '3' : 9, '4' : 16, '5' : 25 } );
  test.is( _.mapIs( got ) );

  var src1 = { a : 1, b : 2, c : null, d : 'str' };
  var got = _.entityMap( src1, ( v, k, s ) => v + k );
  test.identical( got, { a : '1a', b : '2b', c : 'nullc', d : 'strd' } );
  test.is( _.mapIs( got ) );

  test.case = 'routine constructor';
  function constr()
  {
    this.a = 1;
    this.b = 3;
    this.c = 4;
  }
  var got = _.entityMap( new constr(), ( v, i, ent ) => v * v + i );
  test.identical( got, { a : '1a', b : '9b', c : '16c' } );
  test.is( !( got instanceof constr ) );
  test.is( _.mapIs( got ) );

  test.case = 'simple test with mapping object by sqr : check callback arguments';
  var callback = function( v, i, ent )
  {
    if( externEnt )
    externEnt = ent;
    return v * v + i;
  };
  var externEnt = {};
  var got = _.entityMap( Object.assign( {}, { 'a' : 1, 'b' : 3, 'c' : 4 } ), callback );
  test.identical( externEnt, { 'a' : 1, 'b' : 3, 'c' : 4 } );

  test.case = 'mapping object by sqr : source object should be unmodified';
  test.identical( Object.is( got, Object.assign( {}, { 'a' : 1, 'b' : 3, 'c' : 4 } ) ), false );

  test.close( 'src is objectLike' );

  /* - */

  test.case = 'no ArrayLike, no ObjectLike';
  var got = _.entityMap( 2, ( v, u, u2 ) => v + v );
  test.identical( got, 4 );

  var got = _.entityMap( 'a', ( v, u, u2 ) => v + v );
  test.identical( got, 'aa' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( () => _.entityMap() );

  test.case = 'extra argument';
  test.shouldThrowError( () => _.entityMap( [ 1,3 ], callback1, callback2 ) );

  test.case = 'passed argument has undefines';
  test.shouldThrowError( () => _.entityMap( [ 1, undefined ], ( v, i ) => v ) );
  test.shouldThrowError( () => _.entityMap( { a : 2, b : undefined }, ( v, i ) => v ) );
  test.shouldThrowError( () => _.entityMap( undefined, ( v, i ) => v ) );

  test.case = 'second argument is not routine';
  test.shouldThrowError( () => _.entityMap( [ 1, 2 ], {} ) );
}

//
  //TODO : need to check actuality of this test
  // it works correctly

function entityFilter( test )
{
  test.open( 'onEach is routine' );

  var callback = function( v, i, ent )
  {
    if( v < 0 ) return;
    return Math.sqrt( v );
  };

  test.case = 'number';
  var got = _.entityFilter( 3, callback );
  test.identical( got, Math.sqrt( 3 ) );

  test.case = 'string';
  var got = _.entityFilter( 'str', ( v ) => v + ' ' + v );
  test.identical( got, 'str str' );

  test.case = 'simple test with mapping array by sqrt';
  var got = _.entityFilter( [ 9, -16, 25, 36, -49 ], callback );
  test.identical( got, [ 3, 5, 6 ] );
  test.notIdentical( got, [ 3, 4, 5, 6, 7 ] );

  var src = _.unrollMake( [ 9, _.unrollMake( [ -16, 25, _.unrollFrom( [ 36, -49 ] ) ] ) ] );
  var got = _.entityFilter( src, callback );
  test.identical( got, [ 3, 5, 6 ] );
  test.notIdentical( got, [ 3, 4, 5, 6, 7 ] );
  test.isNot( _.unrollIs( got) );

  var src = _.argumentsArrayMake( [ 9, -16, 25, 36, -49 ] );
  var got = _.entityFilter( src, callback );
  test.identical( got, [ 3, 5, 6 ] );

  var src = new Array( 9, -16, 25, 36, -49 );
  var got = _.entityFilter( src, callback );
  test.identical( got, [ 3, 5, 6 ] );

  var src = new Float32Array( [ 9, -16, 25, 36, -49 ] );
  var src = Array.from( src );
  var got = _.entityFilter( src, callback );
  test.identical( got, [ 3, 5, 6 ] );
  test.notIdentical( got, [ 3, 4, 5, 6, 7 ] );

  test.case = 'simple test with mapping object by sqrt';
  var got = _.entityFilter( { '3' : 9, '4' : 16, '5' : 25, '6' : -36 }, callback );
  test.identical( got, { '3' : 3, '4' : 4, '5' : 5 } );
  test.notIdentical( got, { '3' : 3, '4' : 4, '5' : 5, '6' : 6 } );

  test.case = 'callback in routine';
  var testFn1 = function()
  {
    return _.entityFilter( arguments, callback );
  }
  var got = testFn1( 9, -16, 25, 36, -49 );
  test.identical( got, [ 3, 5, 6 ] );

  test.case = 'src is array, filter make unrolls';
  var onEach = ( e, i, s ) => _.unrollMake( [ e ] );
  var src = [ 1, [ 2, 3 ], [ 'str', null, undefined ] ];
  var got = _.entityFilter( src, onEach );
  test.identical( got, [ 1, [ 2, 3 ], [ 'str', null, undefined ] ] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  test.case = 'src is array, filter check equality';
  var onEach = ( e, i, s ) => e === i;
  var src = [ 0, 2, 2, [ 'str', null ], undefined ];
  var got = _.entityFilter( src, onEach );
  test.identical( got, [ true, false, true, false, false ] );
  test.notIdentical( got, [ true, false, true, false, false, false ] );
  test.is( _.arrayIs( got ) );

  test.close( 'onEach is routine' );

  /* - */

  test.case = 'onEach is objectLike - condition, one entry';
  var callback = { '3' : 9 };
  var got = _.entityFilter( { a : { '3' : 9 }, b : { '3' : 4 } }, callback );
  test.identical( got, { a : { '3' : 9 } } );

  test.case = 'onEach is objectLike - condition, a few entry';
  var callback = { '3' : 9 };
  var src = { a : { '3' : 9 }, b : { '3' : 4 }, c : { '3' : 9 }, d : { '3' : 9 } };
  var got = _.entityFilter( src, callback );
  test.identical( got, { a : { '3' : 9 }, c : { '3' : 9 }, d : { '3' : 9 } } );

  test.case = 'onEach is objectLike - condition, entry nested to next level';
  var callback = { '3' : 9 };
  var src = { a : { b : { '3' : 9 } } };
  var got = _.entityFilter( src, callback );
  test.identical( got, {} );
  test.notIdentical( got, { a : { b : { '3' : 9 } } } );

  test.case = 'onEach is objectLike - routine, entry nested to next level';
  var onEach = function( e )
  {
    return true;
  }
  var callback = { '3' : onEach };
  var src = { a : { '3' : 9 } };
  var got = _.entityFilter( src, callback );
  test.identical( got, {} );
  test.notIdentical( got, { a : { '3' : 9 } } );

  test.case = 'onEach is objectLike - condition, identical entry';
  var onEach = function( e )
  {
    return true;
  }
  var callback = { '3' : onEach };
  var src = { a : { '3' : onEach } };
  var got = _.entityFilter( src, callback );
  test.identical( got, { a : { '3' : onEach } } );
  test.notIdentical( got, {} );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowErrorSync( () => _.entityFilter() );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.entityFilter( [ 1,3 ], () => true, 1 ) );

  test.case = 'onEach is not routine';
  test.shouldThrowErrorSync( () => _.entityFilter( [ 1,3 ], 'callback' ) );

  test.case = 'src is undefined';
  test.shouldThrowErrorSync( () => _.entityFilter( undefined, callback1 ) );
};

//

function entityFilterDeep( test )
{
  test.open( 'onEach is routine' );

  var callback = function( v, i, ent )
  {
    if( v < 0 ) return;
    return Math.sqrt( v );
  };

  test.case = 'simple test with mapping array by sqrt';
  var got = _.entityFilterDeep( [ 9, -16, 25, 36, -49 ], callback );
  test.identical( got, [ 3, 5, 6 ] );
  test.notIdentical( got, [ 3, 4, 5, 6, 7 ] );

  var src = _.unrollMake( [ 9, _.unrollMake( [ -16, 25, _.unrollFrom( [ 36, -49 ] ) ] ) ] );
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, [ 3, 5, 6 ] );
  test.notIdentical( got, [ 3, 4, 5, 6, 7 ] );
  test.isNot( _.unrollIs( got) );

  var src = _.argumentsArrayMake( [ 9, -16, 25, 36, -49 ] );
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, [ 3, 5, 6 ] );

  var src = new Array( 9, -16, 25, 36, -49 );
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, [ 3, 5, 6 ] );

  var src = new Float32Array( [ 9, -16, 25, 36, -49 ] );
  var src = Array.from( src );
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, [ 3, 5, 6 ] );
  test.notIdentical( got, [ 3, 4, 5, 6, 7 ] );

  test.case = 'simple test with mapping object by sqrt';
  var got = _.entityFilterDeep( { '3' : 9, '4' : 16, '5' : 25, '6' : -36 }, callback );
  test.identical( got, { '3' : 3, '4' : 4, '5' : 5 } );
  test.notIdentical( got, { '3' : 3, '4' : 4, '5' : 5, '6' : 6 } );

  test.case = 'callback in routine';
  var testFn1 = function()
  {
    return _.entityFilterDeep( arguments, callback );
  }
  var got = testFn1( 9, -16, 25, 36, -49 );
  test.identical( got, [ 3, 5, 6 ] );

  test.case = 'src is array, filter make unrolls';
  var onEach = ( e, i, s ) => _.unrollMake( [ e ] );
  var src = [ 1, [ 2, 3 ], [ 'str', null, undefined ] ];
  var got = _.entityFilterDeep( src, onEach );
  test.identical( got, [ 1, [ 2, 3 ], [ 'str', null, undefined ] ] );
  test.isNot( _.unrollIs( got ) );
  test.is( _.arrayIs( got ) );

  test.case = 'src is array, filter check equality';
  var onEach = ( e, i, s ) => e === i;
  var src = [ 0, 2, 2, [ 'str', null ], undefined ];
  var got = _.entityFilterDeep( src, onEach );
  test.identical( got, [ true, false, true, false, false ] );
  test.notIdentical( got, [ true, false, true, false, false, false ] );
  test.is( _.arrayIs( got ) );

  test.close( 'onEach is routine' );

  /* - */

  test.case = 'onEach is objectLike - condition, one entry';
  var callback = { '3' : 9 };
  var got = _.entityFilterDeep( { a : { '3' : 9 }, b : { '3' : 4 } }, callback );
  test.identical( got, { a : { '3' : 9 } } );

  test.case = 'onEach is objectLike - condition, a few entry';
  var callback = { '3' : 9 };
  var src = { a : { '3' : 9 }, b : { '4' : 4 }, c : { '3' : 9 }, d : { '3' : 9 } };
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, { a : { '3' : 9 }, c : { '3' : 9 }, d : { '3' : 9 } } );

  test.case = 'onEach is objectLike - condition, entry nested to next levels';
  var callback = { '3' : 9 };
  var src = { a : { a : { b : { c : { '3' : 9, '4' : 6 } } } } };
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, {} );
  test.notIdentical( got, { a : { a : { b : { c : { '3' : 9, '4' : 6 } } } } } );

  test.case = 'onEach is objectLike - routine, entry nested to next level';
  var onEach = function( e )
  {
    return true;
  }
  var callback = { '3' : onEach };
  var src = { a : { b : { '3' : 9 } } };
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, { a : { b : { '3' : 9 } } } );
  test.notIdentical( got, {} );

  test.case = 'onEach is objectLike - routine, entry nested to next level';
  var onEach = function( e )
  {
    for( let k in e )
    {
      e[ k ] = e[ k ] + 5;
      if( e[ k ] !== 10 )
      return false;
    }
    return true;
  }
  var callback = { '3' : onEach };
  var src = { a : { b : 5, c : 5, d : 5 } };
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, { a : { b : 5, c : 5, d : 5 } } );
  test.notIdentical( got, {} );

  test.case = 'onEach is objectLike - condition, identical entry';
  var onEach = function( e )
  {
    return true;
  }
  var callback = { '3' : onEach };
  var src = { a : { '3' : onEach } };
  var got = _.entityFilterDeep( src, callback );
  test.identical( got, { a : { '3' : onEach } } );
  test.notIdentical( got, {} );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowErrorSync( () => _.entityFilterDeep() );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.entityFilterDeep( [ 1,3 ], () => true, 1 ) );

  test.case = 'onEach is not routine';
  test.shouldThrowErrorSync( () => _.entityFilterDeep( [ 1,3 ], 'callback' ) );

  test.case = 'src is not arrayLike or mapLike';
  test.shouldThrowErrorSync( () => _.entityFilterDeep( undefined, callback1 ) );
}

//

function enityExtend( test )
{
  test.case = 'src and dst is ArrayLike';

  var got = _.enityExtend( [ 9, -16 ], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 5, 6 ] );

  var got = _.enityExtend( [], [ 3, 5, 6 ] );
  test.identical( got, [ 3, 5, 6 ] );

  test.case = 'src and dst is ObjectLike';

  var got = _.enityExtend( { a : 1 }, { a : 3, b : 5, c : 6 } );
  test.identical( got, { a : 3, b : 5, c : 6 } );

  var got = _.enityExtend( {}, { a : 3, b : 5, c : 6 } );
  test.identical( got, { a : 3, b : 5, c : 6 } );

  var got = _.enityExtend( { d : 4 }, { a : 3, b : 5, c : 6 } );
  test.identical( got, { d : 4, a : 3, b : 5, c : 6 } );

  test.case = 'dst is ObjectLike, src is ArrayLike';

  var got = _.enityExtend( {}, [ 3, 5, 6 ] );
  test.identical( got, { 0 : 3, 1 : 5, 2 : 6 } );

  var got = _.enityExtend( { a : 1 }, [ 3, 5, 6 ] );
  test.identical( got, { a : 1, 0 : 3, 1 : 5, 2 : 6 } );

  test.case = 'src is ObjectLike, dst is ArrayLike';

  var got = _.enityExtend( [ 9, -16 ], { a : 3, b : 5, c : 6 } );
  test.identical( got, [ 9, -16 ] );

  var got = _.enityExtend( [], { a : 3, b : 5, c : 6 } );
  test.identical( got, [] );

  var got = _.enityExtend( [ 1, 2, -3], { 0 : 3, 1 : 5, 2 : 6 } );
  test.identical( got, [ 3, 5, 6 ] );

  test.case = 'src is not ObjectLike or ArrayLike';

  var got = _.enityExtend( [ 9, -16 ], 1 );
  test.identical( got, 1 );

  var got = _.enityExtend( [], 'str' );
  test.identical( got, 'str' );

  var got = _.enityExtend( { a : 1 }, 1 );
  test.identical( got, 1 );

  var got = _.enityExtend( {}, 'str' );
  test.identical( got, 'str' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( function()
  {
    _.enityExtend();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.enityExtend( [ 1,3 ], [ 1,3 ], [ 1,3 ] );
  });

  test.case = 'dst is undefined';
  test.shouldThrowError( function()
  {
    _.enityExtend( undefined, [ 0, 1 ] );
  });

  test.shouldThrowError( function()
  {
    _.enityExtend( undefined, { a : 1, b : 2 } );
  });

  test.shouldThrowError( function()
  {
    _.enityExtend( null, [ 0, 1 ] );
  });

  test.shouldThrowError( function()
  {
    _.enityExtend( null, { a : 1, b : 2 } );
  });
};

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
  test.shouldThrowError( function()
  {
    _.entityAssign( );
  });

  test.case = 'src.clone throws "unexpected"';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.entityAssignFieldFromContainer( );
  });

}

//

function _entityMost( test )
{

  var args1 = [ 3, 1, 9, 0, 5 ],
    args2 = [3, -4, 9, -16, 5, -2],
    args3 = { a : 25, b : 16, c : 9 },
    expected1 = { index : 2, key : 2, value : 9, element : 9 },
    expected2 = { index : 3, key : 3, value : 0, element : 0 },
    expected3 = { index : 3, key : 3, value : 256, element : -16 },
    expected4 = args2.slice(),
    expected5 = { index : 5, key : 5, value : 4, element : -2 },
    expected6 = { index : 0, key : 'a', value : 25, element : 25  },
    expected7 = { index : 2, key : 'c', value : 3, element : 9  };

  function sqr( v )
  {
    return v * v;
  };

  test.case = 'test entityMost with array and default onElement and returnMax = true';
  var got = _._entityMost( args1, undefined, true );
  test.identical( got, expected1 );

  test.case = 'test entityMost with array and default onElement and returnMax = false';
  var got = _._entityMost( args1, undefined, false );
  test.identical( got, expected2 );

  test.case = 'test entityMost with array simple onElement function and returnMax = true';
  var got = _._entityMost( args2, sqr, true );
  test.identical( got, expected3 );

  test.case = 'test entityMost with array : passed array should be unmodified';
  test.identical( args2, expected4 );

  test.case = 'test entityMost with array simple onElement function and returnMax = false';
  var got = _._entityMost( args2, sqr, false );
  test.identical( got, expected5 );

  test.case = 'test entityMost with map and default onElement and returnMax = true';
  var got = _._entityMost( args3, undefined, true );
  test.identical( got, expected6 );

  test.case = 'test entityMost with map and returnMax = false';
  var got = _._entityMost( args3, Math.sqrt, false );
  test.identical( got, expected7 );

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( function()
  {
    _._entityMost();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _._entityMost( [ 1,3 ], sqr, true, false );
  });

  test.case = 'second argument is not routine';
  test.shouldThrowError( function()
  {
    _._entityMost( [ 1,3 ], 'callback', true );
  });

};

//

function entityMin( test )
{
  var args1 = [ 3, 1, 9, 0, 5 ],
    args2 = [ 3, -4, 9, -16, 5, -2 ],
    args3 = { a : 25, b : 16, c : 9 },
    expected1 = { index : 3, key : 3, value : 0, element : 0 },
    expected2 = { index : 5, key : 5, value : 4, element : -2 },
    expected3 = args2.slice(),
    expected4 = { index : 2, key : 'c', value : 9, element : 9  };

  function sqr(v)
  {
    return v * v;
  };

  test.case = 'test entityMin with array and without onElement callback';
  var got = _.entityMin( args1 );
  test.identical( got, expected1 );



  test.case = 'test entityMin with array simple onElement function';
  var got = _.entityMin( args2, sqr );
  test.identical( got, expected2 );

  test.case = 'test entityMin with array : passed array should be unmodified';
  test.identical( args2, expected3 );



  test.case = 'test entityMin with map';
  var got = _.entityMin( args3 );
  test.identical( got, expected4 );

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( function()
  {
    _.entityMin();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.entityMin( [ 1,3 ], sqr, true );
  });

  test.case = 'second argument is not routine';
  test.shouldThrowError( function()
  {
    _.entityMin( [ 1,3 ], 'callback' );
  });

};

//

function entityMax( test )
{

  var args1 = [ 3, 1, 9, 0, 5 ],
    args2 = [ 3, -4, 9, -16, 5, -2 ],
    args3 = { a : 25, b : 16, c : 9 },
    expected1 = { index : 2, key : 2, value : 9, element : 9 },
    expected2 = args2.slice(),
    expected3 = { index : 3, key : 3, value : 256, element : -16 },
    expected4 = { index : 0, key : 'a', value : 5, element : 25 };

  function sqr( v )
  {
    return v * v;
  };

  test.case = 'test entityMax with array';
  var got = _.entityMax( args1 );
  test.identical( got, expected1 );

  test.case = 'test entityMax with array and simple onElement function';
  var got = _.entityMax( args2, sqr );
  test.identical( got, expected3 );

  test.case = 'test entityMax with array : passed array should be unmodified';
  test.identical( args2, expected2 );

  test.case = 'test entityMax with map';
  var got = _.entityMax( args3, Math.sqrt );
  test.identical( got, expected4 );

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( function()
  {
    _.entityMax();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.entityMax( [ 1,3 ], sqr, true );
  });

  test.case = 'second argument is not routine';
  test.shouldThrowError( function()
  {
    _.entityMax( [ 1,3 ], 'callback' );
  });

};

//

function entityLength( test )
{

  var x1 = undefined,
    x2 = 34,
    x3 = 'hello',
    x4 = [ 23, 17, , 34 ],
    x5 = [ 0, 1, [ 2, 4 ] ],
    x6 = { a : 1, b : 2, c : 3},
    x7 = { a : 1, b : { e : 2, c : 3} },
    x8 = ( function(){ return arguments } )( 0, 1, 2, 4 ); // array like entity

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

  var x9 = new Constr1(),
    x10 = {};

  Object.defineProperties( x10, // add properties, only one is enumerable
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

  var expected1 = 0,
    expected2 = 1,
    expected3 = 1,
    expected4 = 4,
    expected5 = 3,
    expected6 = 3,
    expected7 = 2,
    expected8 = 4,
    expected9 = 3,
    expected10 = 1;

  test.case = 'entity is undefined';
  var got = _.entityLength( x1 );
  test.identical( got, expected1 );

  test.case = 'entity is number';
  var got = _.entityLength( x2 );
  test.identical( got, expected2 );

  test.case = 'entity is string';
  var got = _.entityLength( x3 );
  test.identical( got, expected3 );

  test.case = 'entity is array';
  var got = _.entityLength( x4 );
  test.identical( got, expected4 );

  test.case = 'entity is nested array';
  var got = _.entityLength( x5 );
  test.identical( got, expected5 );

  test.case = 'entity is object';
  var got = _.entityLength( x6 );
  test.identical( got, expected6 );

  test.case = 'entity is nested object';
  var got = _.entityLength( x7 );
  test.identical( got, expected7 );

  test.case = 'entity is array like';
  var got = _.entityLength( x8 );
  test.identical( got, expected8 );

  test.case = 'entity is array like';
  var got = _.entityLength( x8 );
  test.identical( got, expected8 );

  console.log( _.toStr( x9 ) );

  test.case = 'entity is created instance of class';
  var got = _.entityLength( x9 );
  test.identical( got, expected9 );

  test.case = 'some properties are non enumerable';
  var got = _.entityLength( x10 );
  test.identical( got, expected10 );

};

//

function entitySize( test )
{

  test.case = 'string';
  var got = _.entitySize( 'str' );
  var expected = 3 ;
  test.identical( got, expected );

// wrong because routine has this code
// if( _.numberIs( src ) )
// return 8;
// so, expected should be 8

  test.case = 'atomic type';
  var got = _.entitySize( 6 );
  var expected = 8;
  test.identical( got, expected );

  test.case = 'buffer';
  var got = _.entitySize( new ArrayBuffer( 10 ) );
  var expected = 10;
  test.identical( got, expected );

// wrong because routine has code
// if( _.longIs( src ) )
// {
//   let result = 0;
//   for( let i = 0; i < src.length; i++ )
//   {
//     result += _.entitySize( src[ i ] );
//     if( isNaN( result ) )
//     break;
//   }
//   return result;
// }
// so, expected should be 3 * 8 = 24

  test.case = 'arraylike';
  var got = _.entitySize( [ 1, 2, 3 ] );
  var expected = 24;
  test.identical( got, expected );

  // wrong because routine has code
  // if( _.mapIs( src ) )
  // {
  //   let result = 0;
  //   for( let k in src )
  //   {
  //     result += _.entitySize( k );
  //     result += _.entitySize( src[ k ] );
  //     if( isNaN( result ) )
  //     break;
  //   }
  //   return result;
  // }
  // so, expected should be 1 + 8 + 1 + 8 = 18

  test.case = 'object';
  var got = _.entitySize( { a : 1, b : 2 } );
  var expected = 18;
  test.identical( got, expected );

  // wrong because routine has code
  // if( !_.definedIs( src ) )
  // return 8;
  // so, expected should be 8

  test.case = 'empty call';
  var got = _.entitySize( undefined );
  var expected = 8;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.entitySize();
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.entitySize( 1,2 );
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.entitySize( 1,undefined );
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.entitySize( [],undefined );
  });

};

//

var Self =
{

  name : 'Tools/base/l1/Entity',
  silencing : 1,
  // verbosity : 4,
  // importanceOfNegative : 3,

  tests :
  {

    eachSample,
    eachSampleExperiment,

    entityEach,
    entityEachKey,
    entityEachOwn,

    entityAll,
    entityAny,
    entityNone,

    entityMap,
    entityFilter,
    entityFilterDeep,

    enityExtend,

    entityAssign,
    entityAssignFieldFromContainer,

    _entityMost,
    entityMin,
    entityMax,

    //

    entityLength,
    entitySize,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
