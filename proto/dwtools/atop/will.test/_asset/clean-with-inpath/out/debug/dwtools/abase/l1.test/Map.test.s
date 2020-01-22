( function _Map_test_s( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );
}

var _global = _global_;
var _ = _global_.wTools;

//--
// map checker
//--

function iterableIs( test )
{
  test.case = 'without argument';
  var got = _.iterableIs();
  var expected = false;
  test.identical( got, expected );

  test.case = 'undefined';
  var got = _.iterableIs( undefined );
  var expected = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.iterableIs( null );
  var expected = false;
  test.identical( got, expected );

  test.case = 'false';
  var got = _.iterableIs( false );
  var expected = false;
  test.identical( got, expected );

  test.case = 'empty string';
  var got = _.iterableIs( '' );
  var expected = false;
  test.identical( got, expected );

  test.case = 'zero';
  var got = _.iterableIs( 0 );
  var expected = false;
  test.identical( got, expected );

  test.case = 'NaN';
  var got = _.iterableIs( NaN );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a boolean';
  var got = _.iterableIs( true );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a number';
  var got = _.iterableIs( 13 );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a function';
  var got = _.iterableIs( function() {} );
  var expected = false;
  test.identical( got, expected );

  test.case = 'constructor';
  var Constr = function( x )
  {
    this.x = x;
    return this;
  }
  var got = _.iterableIs( new Constr( 0 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a string';
  var got = _.iterableIs( 'str' );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.iterableIs( [] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an unroll';
  var got = _.iterableIs( _.unrollMake( [ 1 ] ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an argumentsArray';
  var got = _.iterableIs( _.argumentsArrayMake( [ 1 ] ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'BufferRaw';
  var got = _.iterableIs( new BufferRaw( 5 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'BufferView';
  var got = _.iterableIs( new BufferView( new BufferRaw( 5 ) ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'BufferTyped';
  var got = _.iterableIs( new U8x( 5 ) );
  var expected = true;
  test.identical( got, expected );

  if( Config.interpreter === 'njs' )
  {
    test.case = 'BufferNode';
    var got = _.iterableIs( BufferNode.alloc( 5 ) );
    var expected = true;
    test.identical( got, expected );
  }

  test.case = 'Set';
  var got = _.iterableIs( new Set( [ 5 ] ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'Map';
  var got = _.iterableIs( new Map( [ [ 1, 2 ] ] ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'pure empty map';
  var got = _.iterableIs( Object.create( null ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'pure map';
  var src = Object.create( null );
  src.x = 1;
  var got = _.iterableIs( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'map from pure map';
  var src = Object.create( Object.create( null ) );
  var got = _.iterableIs( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an empty object';
  var got = _.iterableIs( {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.iterableIs( { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );
}

//

function mapIs( test )
{

  test.case = 'pure empty map';
  var got = _.mapIs( Object.create( null ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'pure map';
  var src = Object.create( null );
  src.x = 1;
  var got = _.mapIs( src );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an empty object';
  var got = _.mapIs( {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.mapIs( { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.case = 'no argument';
  var got = _.mapIs();
  var expected = false;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.mapIs( [  ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a string';
  var got = _.mapIs( 'str' );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a number';
  var got = _.mapIs( 13 );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a boolean';
  var got = _.mapIs( true );
  var expected = false;
  test.identical( got, expected );

  test.case = 'a function';
  var got = _.mapIs( function() {  } );
  var expected = false;
  test.identical( got, expected );

  var sup = Object.create( null );
  var sub = Object.create( sup );
  var expected = false;
  var got = _.mapIs( sub );
  test.identical( got, expected );

}

//

function mapCloneAssigning( test )
{

  test.case = 'an Example';
  function Example() {
    this.name = 'Peter';
    this.age = 27;
  };
  var srcMap = new Example();
  var dstMap = { sex : 'Male' };
  var got = _.mapCloneAssigning({ srcMap, dstMap });
  var expected = { sex : 'Male', name : 'Peter', age : 27 };
  test.is( dstMap === got );
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapCloneAssigning();
  });

  test.case = 'redundant argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapCloneAssigning( {}, {}, 'wrong arguments' );
  });

  test.case = 'wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _.mapCloneAssigning( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapCloneAssigning( 'wrong arguments' );
  });

}

//

function mapExtendConditional( test )
{

  test.case = 'an unique object';
  var got = _.mapExtendConditional( _.field.mapper.dstNotHas, { a : 1, b : 2 }, { a : 1 , c : 3 } );
  var expected = { a : 1, b : 2, c : 3 };
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtendConditional();
  });

  test.case = 'few argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtendConditional( _.field.mapper.dstNotHas );
  });

  test.case = 'wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtendConditional( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtendConditional( 'wrong arguments' );
  });

}

//

function mapExtend( test )
{

  /* */

  test.open( 'first argument is null' );

  test.case = 'trivial'; /* */
  var src1 = { a : 1, b : 2 };
  var src1Copy = { a : 1, b : 2 };
  var src2 = { c : 3, d : 4 };
  var src2Copy = { c : 3, d : 4 };
  var got = _.mapExtend( null, src1, src2 );
  var expected = { a : 1, b : 2, c : 3, d : 4 };
  test.will = 'return';
  test.identical( got, expected );
  test.will = 'preserve src1';
  test.identical( src1, src1Copy );
  test.will = 'preserve src2';
  test.identical( src2, src2Copy );
  test.will = 'return not src1';
  test.is( got !== src1 );
  test.will = 'return not src2';
  test.is( got !== src2 );

  test.case = 'rewriting'; /* */
  var src1 = { a : 1, b : 2 };
  var src1Copy = { a : 1, b : 2 };
  var src2 = { b : 22, c : 3, d : 4 };
  var src2Copy = { b : 22, c : 3, d : 4 };
  var got = _.mapExtend( null, src1, src2 );
  var expected = { a : 1, b : 22, c : 3, d : 4 };
  test.will = 'return';
  test.identical( got, expected );
  test.will = 'preserve src1';
  test.identical( src1, src1Copy );
  test.will = 'preserve src2';
  test.identical( src2, src2Copy );
  test.will = 'return not src1';
  test.is( got !== src1 );
  test.will = 'return not src2';
  test.is( got !== src2 );

  test.close( 'first argument is null' );

  /* */

  test.open( 'first argument is dst' );

  test.case = 'trivial'; /* */
  var dst = { a : 1, b : 2 };
  var src2 = { c : 3, d : 4 };
  var src2Copy = { c : 3, d : 4 };
  var got = _.mapExtend( dst, src2 );
  var expected = { a : 1, b : 2, c : 3, d : 4 };
  test.will = 'return';
  test.identical( got, expected );
  test.will = 'preserve src2';
  test.identical( src2, src2Copy );
  test.will = 'return dst';
  test.is( got === dst );
  test.will = 'return not src2';
  test.is( got !== src2 );

  test.case = 'rewriting'; /* */
  var dst = { a : 1, b : 2 };
  var src2 = { b : 22, c : 3, d : 4 };
  var src2Copy = { b : 22, c : 3, d : 4 };
  var got = _.mapExtend( dst, src2 );
  var expected = { a : 1, b : 22, c : 3, d : 4 };
  test.will = 'return';
  test.identical( got, expected );
  test.will = 'preserve src2';
  test.identical( src2, src2Copy );
  test.will = 'return not dst';
  test.is( got === dst );
  test.will = 'return not src2';
  test.is( got !== src2 );

  test.close( 'first argument is dst' );

  /* */

  test.case = 'trivial, first argument';
  var src1 = { a : 7, b : 13 };
  var src1Copy = { a : 7, b : 13 };
  var src2 = { c : 3, d : 33 };
  var src2Copy = { c : 3, d : 33 };
  var got = _.mapExtend( src1, src2 );
  var expected = { a : 7, b : 13, c : 3, d : 33 };
  test.identical( got, expected );
  test.identical( src2, src2Copy );
  test.is( got === src1 );
  test.is( got !== src2 );

  test.case = 'complex, first argument is null';
  var src1 = { a : 1, b : 1, c : 1, z : 1 };
  var src1Copy = { a : 1, b : 1, c : 1, z : 1 };
  var src2 = { a : 2, c : 2, d : 2 };
  var src2Copy = { a : 2, c : 2, d : 2 };
  var src3 = { a : 3, b : 3, e : 3 };
  var src3Copy = { a : 3, b : 3, e : 3 };
  var got = _.mapExtend( null, src1, src2, src3 );
  var expected = { a : 3, b : 3, c : 2, d : 2, e : 3, z : 1 };
  test.identical( got, expected );
  test.identical( src1, src1Copy );
  test.identical( src2, src2Copy );
  test.identical( src3, src3Copy );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'complex, first argument is not null';
  var src1 = { a : 1, b : 1, c : 1, z : 1 };
  var src1Copy = { a : 1, b : 1, c : 1, z : 1 };
  var src2 = { a : 2, c : 2, d : 2 };
  var src2Copy = { a : 2, c : 2, d : 2 };
  var src3 = { a : 3, b : 3, e : 3 };
  var src3Copy = { a : 3, b : 3, e : 3 };
  var got = _.mapExtend( src1, src2, src3 );
  var expected = { a : 3, b : 3, c : 2, d : 2, e : 3, z : 1 };
  test.identical( got, expected );
  test.identical( src2, src2Copy );
  test.identical( src3, src3Copy );
  test.is( got === src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  test.case = 'extend pure map by empty strings, first argument is null';
  var src1 = Object.create( null );
  src1.a = '1';
  src1.b = '1';
  src1.c = '1';
  src1.z = '1';
  var src1Copy = Object.create( null );
  src1Copy.a = '1';
  src1Copy.b = '1';
  src1Copy.c = '1';
  src1Copy.z = '1';
  var src2 = Object.create( null );
  src2.a = '';
  src2.c = '';
  src2.d = '';
  src2.e = '2';
  var src2Copy = Object.create( null );
  src2Copy.a = '';
  src2Copy.c = '';
  src2Copy.d = '';
  src2Copy.e = '2';
  var got = _.mapExtend( null, src1, src2 );
  var expected = { a : '', b : '1', c : '', d : '', e : '2', z : '1' };
  test.identical( got, expected );
  test.identical( src1, src1Copy );
  test.identical( src2, src2Copy );
  test.is( got !== src1 );
  test.is( got !== src2 );

  test.case = 'extend pure map by empty strings, first argument is not null';
  var src1 = Object.create( null );
  src1.a = '1';
  src1.b = '1';
  src1.c = '1';
  src1.z = '1';
  var src1Copy = Object.create( null );
  src1Copy.a = '1';
  src1Copy.b = '1';
  src1Copy.c = '1';
  src1Copy.z = '1';
  var src2 = Object.create( null );
  src2.a = '';
  src2.c = '';
  src2.d = '';
  src2.e = '2';
  var src2Copy = Object.create( null );
  src2Copy.a = '';
  src2Copy.c = '';
  src2Copy.d = '';
  src2Copy.e = '2';
  var got = _.mapExtend( src1, src2 );
  var expected = { a : '', b : '1', c : '', d : '', e : '2', z : '1' };
  test.identical( got, expected );
  test.identical( src2, src2Copy );
  test.is( got === src1 );
  test.is( got !== src2 );

  test.case = 'object like array';
  var got = _.mapExtend( null, [ 3, 7, 13, 73 ] );
  var expected = { 0 : 3, 1 : 7, 2 : 13, 3 : 73 };
  test.identical( got, expected );

  /**/

  test.case = 'extend complex map by complex map';

  var dst = Object.create( null );
  dst.x1 = '1';
  dst.x2 = 2;
  dst = Object.create( dst );
  dst.x3 = 3;
  dst.x4 = 4;

  var src = Object.create( null );
  src.x1 = '11';
  src.y2 = 12;
  src = Object.create( src );
  src.x3 = 13;
  src.y4 = 14;

  var expected = Object.create( null );
  expected.x1 = '1';
  expected.x2 = 2;
  expected = Object.create( expected );
  expected.x4 = 4;
  expected.x1 = '11';
  expected.y2 = 12;
  expected.x3 = 13;
  expected.y4 = 14;

  var got = _.mapExtend( dst, src );
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  return;
  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtend();
  });

  test.case = 'few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtend( {} );
  });

  test.case = 'wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtend( [] );
  });

  test.case = 'wrong type of number';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtend( 13 );
  });

  test.case = 'wrong type of boolean';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtend( true );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorSync( function()
  {
    _.mapExtend( 'wrong argument' );
  });

}

//

function mapSupplement( test )
{

  test.case = 'an object';
  var got = _.mapSupplement( { a : 1, b : 2 }, { a : 1, c : 3 } );
  var expected = { a : 1, b : 2, c : 3 };
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapSupplement();
  });

  // test.case = 'wrong type of array';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.mapSupplement( [] );
  // });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapSupplement( 'wrong arguments' );
  });

}

//

function mapComplement( test )
{

  test.case = 'an object';
  var got = _.mapComplement( { a : 1, b : 'ab' }, { a : 12 , c : 3 } );
  var expected = { a : 1, b : 'ab', c : 3 };
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapComplement();
  });

  test.case = 'wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _.mapComplement( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapComplement( 'wrong arguments' );
  });

}

//

function mapMake( test )
{
  test.case = 'without arguments';
  var got = _.mapMake();
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );

  test.case = 'src - null';
  var got = _.mapMake( null );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );

  test.case = 'src - undefined';
  var got = _.mapMake( undefined );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );

  /* */

  test.case = 'src - empty map';
  var src = {};
  var got = _.mapMake( src );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - not pure map';
  var src = { a : 7, b : 13 };
  var got = _.mapMake( src );
  var expected = { a : 7, b : 13 };
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - empty pure map';
  var src = Object.create( null );
  var got = _.mapMake( src );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - pure map';
  var src = Object.create( { a : 7, b : 13 } );
  var got = _.mapMake( src );
  var expected = { a : 7, b : 13 };
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - empty Map';
  var src = new Map([]);
  var got = _.mapMake( src );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - pure map';
  var src = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  var got = _.mapMake( src );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  /* */

  test.case = 'src - empty array';
  var src = [];
  var got = _.mapMake( src );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - array with primitives';
  var src = [ 0, 'str', null, undefined ];
  var got = _.mapMake( src );
  var expected = { 0 : 0, 1 : 'str', 2 : null, 3 : undefined };
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  test.case = 'src - array with maps';
  var src = [ { a : 7 }, { b : 13 } ];
  var got = _.mapMake( src );
  var expected = { 0 : { a : 7 }, 1 : { b : 13 } };
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.is( got !== src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapMake( { a : 1 }, { a : 'extra' } ) );

  test.case = 'wrong argument';
  test.shouldThrowErrorSync( () => _.mapMake( '' ) );
  test.shouldThrowErrorSync( () => _.mapMake( 1 ) );
  test.shouldThrowErrorSync( () => _.mapMake( false ) );

}

//

function mapMakeBugWithArray( test )
{
  test.case = 'failed';
  var src = [ { a : 1 }, { b : 2 } ];
  var got = _.mapMake.apply( undefined, src );
  var exp = { 0 : { a : 1 }, 1 : { b : 2 } };
  test.identical( got, exp );
  test.is( got !== src );

  test.case = 'all ok';
  var src = [ { a : 1 }, { b : 2 } ];
  var got = _.mapMake( src );
  var exp = { 0 : { a : 1 }, 1 : { b : 2 } };
  test.identical( got, exp );
  test.is( got !== src );
}
mapMakeBugWithArray.experimental = 1;
mapMakeBugWithArray.description =
`
 routines mapBut and _mapOnly uncorrect use method apply()
 Previus call was :
   _.mapMake.apply( this, src ); // src = [ {...}, {...} ]
   its equivalent to
   _.mapMake( {...}, {...} );

   After changing behavior of mapMake call should be
   _.mapMake.apply( this. [ src ] );
`

//
// map manipulator
//

function objectSetWithKeys( test )
{
  test.open( 'dst is null or empty map' );

  test.case = 'dstMap - null, src - empty array, val - 2';
  var dst = null;
  var got = _.objectSetWithKeys( dst, [], 2 );
  test.identical( got, {} );
  test.is( got !== dst );

  test.case = 'dstMap - empty map, src - empty array, val - 2';
  var dst = {};
  var got = _.objectSetWithKeys( dst, [], 2 );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - null, src - string, val - 2';
  var dst = null;
  var got = _.objectSetWithKeys( dst, 'a', 2 );
  test.identical( got, { 'a' : 2 } );
  test.is( got !== dst );

  test.case = 'dstMap - empty map, src - string, val - 2';
  var dst = {};
  var got = _.objectSetWithKeys( dst, 'a', 2 );
  test.identical( got, { 'a' : 2 } );
  test.is( got === dst );

  test.case = 'dstMap - null, src - array of strings, val - 2';
  var dst = null;
  var got = _.objectSetWithKeys( dst, [ 'a', 'b' ], 2 );
  test.identical( got, { 'a' : 2, 'b' : 2 } );
  test.is( got !== dst );

  test.case = 'dstMap - empty map, src - array of strings, val - 2';
  var dst = {};
  var got = _.objectSetWithKeys( dst, [ 'a', 'b' ], 2 );
  test.identical( got, { 'a' : 2, 'b' : 2 } );
  test.is( got === dst );

  test.case = 'dstMap - empty map, src - array of numbers, val - 2';
  var dst = {};
  var got = _.objectSetWithKeys( dst, [ 1, 2 ], 2 );
  test.identical( got, { 1 : 2, 2 : 2 } );
  test.is( got === dst );

  test.close( 'dst is null or empty map' );

  /* - */

  test.open( 'dst is filled  map' );

  test.case = 'src - empty array, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, [], 2 );
  test.identical( got, { a : 1, b : 2 } );
  test.is( got === dst );

  test.case = 'src - string, new key, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, 'd', 2 );
  test.identical( got, { a : 1, b : 2, d : 2 } );
  test.is( got === dst );

  test.case = 'src - string, replace value, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, 'a', 2 );
  test.identical( got, { a : 2, b : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, new keys, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, [ 'c', 'd' ], 2 );
  test.identical( got, { 'a' : 1, 'b' : 2, 'c' : 2, 'd' : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, replace values, val - 3';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, [ 'a', 'b' ], 3 );
  test.identical( got, { 'a' : 3, 'b' : 3 } );
  test.is( got === dst );

  /* */

  test.case = 'src - empty array, val - undefined';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, [], undefined );
  test.identical( got, { a : 1, b : 2 } );
  test.is( got === dst );

  test.case = 'src - string, new key, val - undefined';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, 'd', undefined );
  test.identical( got, { a : 1, b : 2 } );
  test.is( got === dst );

  test.case = 'src - string, replace value, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, 'a', undefined );
  test.identical( got, { b : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, new keys, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, [ 'c', 'd' ], undefined );
  test.identical( got, { 'a' : 1, 'b' : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, replace values, val - 3';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeys( dst, [ 'a', 'b' ], undefined );
  test.identical( got, {} );
  test.is( got === dst );

  test.close( 'dst is filled  map' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments'
  test.shouldThrowErrorSync( () => _.objectSetWithKeys() );

  test.case = 'not enough arguments'
  test.shouldThrowErrorSync( () => _.objectSetWithKeys( {} ) );
  test.shouldThrowErrorSync( () => _.objectSetWithKeys( {}, 'a' ) );

  test.case = 'extra arguments'
  test.shouldThrowErrorSync( () => _.objectSetWithKeys( {}, 'a', 'a', 1 ) );

  test.case = 'dstMap is not object or null'
  test.shouldThrowErrorSync( () => _.objectSetWithKeys( [], 'a', 'a' ) );

  test.case = 'src is not array of strings or string'
  test.shouldThrowErrorSync( () => _.objectSetWithKeys( { 'a' : 1 }, 1, 'a' ) );
  test.shouldThrowErrorSync( () => _.objectSetWithKeys( { 'a' : 1 }, { 'k' : 2 }, 'a' ) );
}

//

function objectSetWithKeyStrictly( test )
{
  test.open( 'dst is null or empty map' );

  test.case = 'dstMap - null, src - empty array, val - 2';
  var dst = null;
  var got = _.objectSetWithKeyStrictly( dst, [], 2 );
  test.identical( got, {} );
  test.is( got !== dst );

  test.case = 'dstMap - empty map, src - empty array, val - 2';
  var dst = {};
  var got = _.objectSetWithKeyStrictly( dst, [], 2 );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - null, src - string, val - 2';
  var dst = null;
  var got = _.objectSetWithKeyStrictly( dst, 'a', 2 );
  test.identical( got, { 'a' : 2 } );
  test.is( got !== dst );

  test.case = 'dstMap - empty map, src - string, val - 2';
  var dst = {};
  var got = _.objectSetWithKeyStrictly( dst, 'a', 2 );
  test.identical( got, { 'a' : 2 } );
  test.is( got === dst );

  test.case = 'dstMap - null, src - array of strings, val - 2';
  var dst = null;
  var got = _.objectSetWithKeyStrictly( dst, [ 'a', 'b' ], 2 );
  test.identical( got, { 'a' : 2, 'b' : 2 } );
  test.is( got !== dst );

  test.case = 'dstMap - empty map, src - array of strings, val - 2';
  var dst = {};
  var got = _.objectSetWithKeyStrictly( dst, [ 'a', 'b' ], 2 );
  test.identical( got, { 'a' : 2, 'b' : 2 } );
  test.is( got === dst );

  test.case = 'dstMap - empty map, src - array of numbers, val - 2';
  var dst = {};
  var got = _.objectSetWithKeyStrictly( dst, [ 1, 2 ], 2 );
  test.identical( got, { 1 : 2, 2 : 2 } );
  test.is( got === dst );

  test.close( 'dst is null or empty map' );

  /* - */

  test.open( 'dst is filled  map' );

  test.case = 'src - empty array, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, [], 2 );
  test.identical( got, { a : 1, b : 2 } );
  test.is( got === dst );

  test.case = 'src - string, new key, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, 'd', 2 );
  test.identical( got, { a : 1, b : 2, d : 2 } );
  test.is( got === dst );

  test.case = 'src - string, replace value, val - 2';
  var dst = { a : 2, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, 'a', 2 );
  test.identical( got, { a : 2, b : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, new keys, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, [ 'c', 'd' ], 2 );
  test.identical( got, { 'a' : 1, 'b' : 2, 'c' : 2, 'd' : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, replace values, val - 3';
  var dst = { a : 3, b : 3 };
  var got = _.objectSetWithKeyStrictly( dst, [ 'a', 'b' ], 3 );
  test.identical( got, { 'a' : 3, 'b' : 3 } );
  test.is( got === dst );

  /* */

  test.case = 'src - empty array, val - undefined';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, [], undefined );
  test.identical( got, { a : 1, b : 2 } );
  test.is( got === dst );

  test.case = 'src - string, new key, val - undefined';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, 'd', undefined );
  test.identical( got, { a : 1, b : 2 } );
  test.is( got === dst );

  test.case = 'src - string, replace value, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, 'a', undefined );
  test.identical( got, { b : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, new keys, val - 2';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, [ 'c', 'd' ], undefined );
  test.identical( got, { 'a' : 1, 'b' : 2 } );
  test.is( got === dst );

  test.case = 'src - array of strings, replace values, val - 3';
  var dst = { a : 1, b : 2 };
  var got = _.objectSetWithKeyStrictly( dst, [ 'a', 'b' ], undefined );
  test.identical( got, {} );
  test.is( got === dst );

  test.close( 'dst is filled  map' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments'
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly() );

  test.case = 'not enough arguments'
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( {} ) );
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( {}, 'a' ) );

  test.case = 'extra arguments'
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( {}, 'a', 'a', 1 ) );

  test.case = 'dstMap is not object or null'
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( [], 'a', 'a' ) );

  test.case = 'src is not array of strings or string'
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( { 'a' : 1 }, 1, 'a' ) );
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( { 'a' : 1 }, { 'k' : 2 }, 'a' ) );

  test.case = 'dstMap has value not identical to val'
  test.shouldThrowErrorSync( () => _.objectSetWithKeyStrictly( { 'a' : 1 }, 1, 'a' ) );
}

//

function mapDelete( test ) 
{
  test.case = 'dstMap - empty map';
  var dst = {};
  var got = _.mapDelete( dst );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - filled map';
  var dst = { a : 1, 1 : 2, c : 3 };
  var got = _.mapDelete( dst );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - empty map, ins - empty map';
  var dst = {};
  var ins = {};
  var got = _.mapDelete( dst, ins );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - empty map, ins - filled map';
  var dst = {};
  var ins = { a : 1, b : 2 };
  var got = _.mapDelete( dst, ins );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - filled map, ins - empty map';
  var dst = { a : 1, 1 : 2, c : 3 };
  var ins = {};
  var got = _.mapDelete( dst, ins );
  test.identical( got, { a : 1, 1 : 2, c : 3 } );
  test.is( got === dst );

  test.case = 'dstMap - filled map, ins - filled map, not equal keys';
  var dst = { a : 1, 1 : 2, c : 3 };
  var ins = { 2 : 6, d : 'e' };
  var got = _.mapDelete( dst, ins );
  test.identical( got, { a : 1, 1 : 2, c : 3 } );
  test.is( got === dst );

  test.case = 'dstMap - filled map, ins - filled map, equal keys exists';
  var dst = { a : 1, 1 : 2, c : 3 };
  var ins = { a : 6, c : 'e', f : [] };
  var got = _.mapDelete( dst, ins );
  test.identical( got, { 1 : 2 } );
  test.is( got === dst );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapDelete() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapDelete( { a : 1 }, { b : 2 }, { c : 'extra' } ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapDelete( 'wrong', { b : 2 } ) );
  test.shouldThrowErrorSync( () => _.mapDelete( undefined, { b : 2 } ) );
}

//

function mapEmpty( test ) 
{
  test.case = 'dstMap - empty map';
  var dst = {};
  var got = _.mapEmpty( dst );
  test.identical( got, {} );
  test.is( got === dst );

  test.case = 'dstMap - filled map';
  var dst = { a : 1, 1 : 2, c : 3 };
  var got = _.mapEmpty( dst );
  test.identical( got, {} );
  test.is( got === dst );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapEmpty() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapEmpty( { a : 1 }, { c : 'extra' } ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapEmpty( 'wrong', { b : 2 } ) );
  test.shouldThrowErrorSync( () => _.mapEmpty( undefined, { b : 2 } ) );
}

// --
// map convert
// --

function mapsFlatten( test )
{

  test.case = 'empty map';
  var src = {};
  var expected = {}
  var got = _.mapsFlatten({ src });
  test.identical( got, expected );

  test.case = 'empty array';
  var src = [];
  var expected = {}
  var got = _.mapsFlatten( src );
  test.identical( got, expected );

  test.case = 'array of empty maps';
  var src = [ {}, {} ];
  var expected = {}
  var got = _.mapsFlatten( src );
  test.identical( got, expected );

  test.case = 'trivial';
  var src = [ { a : 1, b : { c : 1, d : 1 } }, { e : 2, f : { g : { h : 2 } } } ];
  var expected = { a : 1, 'b/c' : 1, 'b/d' : 1, e : 2, 'f/g/h' : 2 }
  var got = _.mapsFlatten( src );
  test.identical( got, expected );

  test.case = 'delimeter : .';
  var src = [ { a : 1, dir : { b : 2 } }, { c : 3 } ];
  var expected = { 'a' : 1, 'dir.b' : 2, 'c' : 3 }
  var got = _.mapsFlatten({ src, delimeter : '.' });
  test.identical( got, expected );

  test.case = 'delimeter : ';
  var src = [ { a : 1, dir : { b : 2 } }, { c : 3 } ];
  var expected = { 'a' : 1, 'dirb' : 2, 'c' : 3 }
  var got = _.mapsFlatten({ src, delimeter : '' });
  test.identical( got, expected );

  test.case = 'delimeter : 0';
  var src = [ { a : 1, dir : { b : 2 } }, { c : 3 } ];
  var expected = { 'a' : 1, 'b' : 2, 'c' : 3 }
  var got = _.mapsFlatten({ src, delimeter : 0 });
  test.identical( got, expected );

  test.case = 'delimeter : false';
  var src = [ { a : 1, dir : { b : 2 } }, { c : 3 } ];
  var expected = { 'a' : 1, 'b' : 2, 'c' : 3 }
  var got = _.mapsFlatten({ src, delimeter : false });
  test.identical( got, expected );

  test.case = 'allowingCollision : 1';
  var src = [ { a : 1, dir : { b : 2 } }, { a : 3, dir : { b : 4, c : 5 } } ];
  var expected = { 'a' : 3, 'dir/b' : 4, 'dir/c' : 5 }
  var got = _.mapsFlatten({ src, allowingCollision : 1 });
  test.identical( got, expected );

  test.case = 'delimeter : 0, allowingCollision : 1';
  var src = [ { a : 1, dir : { b : 2 } }, { a : 3, dir : { b : 4, c : 5 } } ];
  var expected = { 'a' : 3, 'b' : 4, 'c' : 5 }
  var got = _.mapsFlatten({ src, delimeter : 0, allowingCollision : 1 });
  test.identical( got, expected );

  test.case = 'delimeter : 0, allowingCollision : 1';
  var dst = { a : 0, d : 6 }
  var src = [ { a : 1, dir : { b : 2 } }, { a : 3, dir : { b : 4, c : 5 } } ];
  var expected = { 'a' : 3, 'b' : 4, 'c' : 5, 'd' : 6 }
  var got = _.mapsFlatten({ src, dst, delimeter : 0, allowingCollision : 1 });
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'collision';

  test.shouldThrowErrorSync( () =>
  {
    var dst = { 'dir/a' : 1 }
    var src = { dir : { a : 2 } };
    var got = _.mapsFlatten({ src, dst });
  });

  test.shouldThrowErrorSync( () =>
  {
    var src = [ { dir : { a : 2 } }, { dir : { a : 2 } } ];
    var got = _.mapsFlatten({ src });
  });

  test.shouldThrowErrorSync( () =>
  {
    var src = [ { dir : { a : 2 } }, { dir : { a : 2 } } ];
    var got = _.mapsFlatten({ src, allowingCollision : 0 });
  });

  test.shouldThrowErrorSync( () =>
  {
    var src = [ { dir : { a : 2 } }, { dir : { a : 2 } } ];
    var got = _.mapsFlatten({ src, delimeter : 0 });
  });

  test.shouldThrowErrorSync( () =>
  {
    var src = [ { dir : { a : 2 } }, { dir : { a : 2 } } ];
    var got = _.mapsFlatten({ src, delimeter : 0, allowingCollision : 0 });
  });

  test.case = 'bad arguments';

  test.shouldThrowErrorSync( () => _.mapsFlatten() );
  test.shouldThrowErrorSync( () => _.mapsFlatten( {} ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( {}, {} ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( 'a' ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( 1 ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( null ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( [ 'a' ] ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( [ 1 ] ) );
  test.shouldThrowErrorSync( () => _.mapsFlatten( [ null ] ) );

  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : undefined }) );
  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : 'a' }) );
  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : 1 }) );
  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : null }) );
  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : [ 'a' ] }) );
  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : [ 1 ] }) );
  test.shouldThrowErrorSync( () => _.mapsFlatten({ src : [ null ] }) );

}

//

function mapFirstPair( test )
{

  test.case = 'first pair [ key, value ]';
  var got = _.mapFirstPair( { a : 3, b : 13 } );
  var expected = [ 'a', 3 ];
  test.identical( got, expected );

  test.case = 'undefined';
  var got = _.mapFirstPair( {} );
  var expected = [];
  test.identical( got, expected );

  test.case = 'pure map';
  var obj = Object.create( null );
  obj.a = 7;
  var got = _.mapFirstPair( obj );
  var expected = [ 'a', 7 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapFirstPair();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapFirstPair( 'wrong argument' );
  });

}

//

function mapValWithIndex( test )
{

  test.case = 'second index';
  var got = _.mapValWithIndex( { 0 : 3, 1 : 13, 2 : 'c', 3 : 7 }, 2 );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'an element';
  var got = _.mapValWithIndex( { 0 : [ 'a', 3 ] }, 0 );
  var expected = [ 'a', 3 ];
  test.identical( got, expected );

  test.case = 'a list of arrays';
  var got = _.mapValWithIndex( { 0 : [ 'a', 3 ], 1 : [ 'b', 13 ], 2 : [ 'c', 7 ] }, 2 );
  var expected = ['c', 7];
  test.identical( got, expected );

  test.case = 'a list of objects';
  var got = _.mapValWithIndex( { 0 : { a : 3 }, 1 : { b : 13 }, 2 : { c : 7 } }, 2 );
  var expected = {c: 7};
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function() {
    _.mapValWithIndex();
  });

  test.case = 'few argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapValWithIndex( [ [] ] );
  });

  test.case = 'first the four argument not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    _.mapValWithIndex( 3, 13, 'c', 7 , 2 );
  });

  test.case = 'redundant argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapValWithIndex( [ [] ], 2, 'wrong arguments' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapValWithIndex( 'wrong argumetns' );
  });

}

//

function mapKeyWithIndex( test )
{

  test.case = 'last key';
  var got = _.mapKeyWithIndex( { 'a': 3, 'b': 13, 'c': 7 }, 2 );
  var expected = 'c';
  test.identical( got, expected );

  test.case = 'first key';
  var got = _.mapKeyWithIndex( { 0 : { a : 3 },  1 : 13, 2 : 'c', 3 : 7 }, 3 );
  var expected = '3';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeyWithIndex();
  });

  test.case = 'few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeyWithIndex( [] );
  });

  test.case = 'redundant argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeyWithIndex( [  ], 2, 'wrong arguments' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeyWithIndex( 'wrong argumetns' );
  });

}

//

function mapToArray( test )
{
  test.case = 'src - empty map';
  var got = _.mapToArray( {} );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty array';
  var got = _.mapToArray( [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - filled map';
  var got = _.mapToArray( { a : 7, b : 13 } );
  var expected = [ [ 'a', 7 ], [ 'b', 13 ] ];
  test.identical( got, expected );

  test.case = 'src - filled map'
  var got = _.mapToArray( { a : 3, b : 13, 1 : 7 } );
  var expected = [ [ '1', 7 ], [ 'a', 3 ], [ 'b', 13 ] ];
  test.identical( got, expected );

  test.case = 'src - array with literal key';
  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapToArray( arrObj );
  var expected = [ [ 'k', 1 ] ];
  test.identical( got, expected );

  test.case = 'src - Date object';
  var got = _.mapToArray( new Date );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - map prototyped by another map';
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapToArray( a );
  var expected = [ [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, expected );

  test.case = 'src - map prototyped by another map, own pairs';
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapToArray.call( { own : 1 }, a );
  var expected = [ [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, expected );

  test.case = 'src - map prototyped by another map, own pairs, not enumerable property';
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapToArray.call( { enumerable : 0, own : 1 }, a );
  var expected = [ [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, expected );

  test.case = 'src - map prototyped by another map, own pairs disable, not enumerable property';
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapToArray.call( { enumerable : 0, own : 0 }, a );
  var expected = [ [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without argument';
  test.shouldThrowErrorSync( () => _.mapToArray() );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.mapToArray( 1 ) );
  test.shouldThrowErrorSync( () => _.mapToArray( 'wrong' ) );
}

//

function mapToStr( test )
{

  test.case = 'returns an empty string';
  var got = _.mapToStr({ src : [  ], keyValDelimeter : ' : ',  entryDelimeter : '; '});
  var expected = '';
  test.identical( got, expected );

  test.case = 'returns a string representing an object';
  var got = _.mapToStr({ src : { a : 1, b : 2, c : 3, d : 4 }, keyValDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = 'a : 1; b : 2; c : 3; d : 4';
  test.identical( got, expected );

  test.case = 'returns a string representing an array';
  var got = _.mapToStr({ src : [ 1, 2, 3 ], keyValDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = '0 : 1; 1 : 2; 2 : 3';
  test.identical( got, expected );

  test.case = 'returns a string representing an array-like object';
  function args() { return arguments };
  var got = _.mapToStr({ src : args(  1, 2, 3, 4, 5 ), keyValDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = '0 : 1; 1 : 2; 2 : 3; 3 : 4; 4 : 5';
  test.identical( got, expected );

  test.case = 'returns a string representing a string';
  var got = _.mapToStr({ src : 'abc', keyValDelimeter : ' : ',  entryDelimeter : '; ' });
  var expected = '0 : a; 1 : b; 2 : c';
  test.identical( got, expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapToStr();
  });

  test.case = 'wrong type of number';
  test.shouldThrowErrorSync( function()
  {
    _.mapToStr( 13 );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapToStr( true );
  });

}

// --
// map properties
// --

function mapKeys( test )
{

  test.case = 'trivial';

  var got = _.mapKeys( {} );
  var expected = [];
  test.identical( got, expected );

  var got = _.mapKeys( { a : 1, b : undefined } );
  var expected = [ 'a', 'b' ];
  test.identical( got, expected );

  var got = _.mapKeys( { a : 7, b : 13 } );
  var expected = [ 'a', 'b' ];
  test.identical( got, expected );

  var got = _.mapKeys( { 7 : 'a', 3 : 'b', 13 : 'c' } );
  var expected = [ '3', '7', '13' ];
  test.identical( got, expected );

  var f = function(){};
  Object.setPrototypeOf( f, String );
  f.a = 1;
  var got = _.mapKeys( f );
  var expected = [ 'a' ];
  test.identical( got, expected );

  var got = _.mapKeys( new Date );
  var expected = [ ];
  test.identical( got, expected );

  //

  test.case = 'options';
  var a = { a : 1 }
  var b = { b : 2 }
  Object.setPrototypeOf( a, b );

  /* own off */

  var got = _.mapKeys( a );
  var expected = [ 'a', 'b' ];
  test.identical( got, expected );

  /* own on */

  var o = { own : 1 };
  var got = _.mapKeys.call( o, a );
  var expected = [ 'a' ];
  test.identical( got, expected );

  /* enumerable/own off */

  var o = { enumerable : 0, own : 0 };
  Object.defineProperty( b, 'k', { enumerable : 0 } );
  var got = _.mapKeys.call( o, a );
  var expected = _.mapAllKeys( a );
  test.identical( got, expected );

  /* enumerable off, own on */

  var o = { enumerable : 0, own : 1 };
  Object.defineProperty( a, 'k', { enumerable : 0 } );
  var got = _.mapKeys.call( o, a );
  var expected = [ 'a', 'k' ]
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeys();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeys( 'wrong arguments' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapKeys.call( { x : 1 }, {} );
  });

}

//

function mapOwnKeys( test )
{
  test.case = 'empty'
  var got = _.mapOwnKeys( {} );
  var expected = [];
  test.identical( got, expected )

  //

  test.case = 'simplest'

  var got = _.mapOwnKeys( { a : '1', b : '2' } );
  var expected = [ 'a', 'b' ];
  test.identical( got, expected )

  var got = _.mapOwnKeys( new Date );
  var expected = [ ];
  test.identical( got, expected )

  //

  test.case = ''

  var a = { a : 1 };
  var b = { b : 2 };
  var c = { c : 3 };
  Object.setPrototypeOf( a, b );
  Object.setPrototypeOf( b, c );

  var got = _.mapOwnKeys( a );
  var expected = [ 'a' ];
  test.identical( got, expected )

  var got = _.mapOwnKeys( b );
  var expected = [ 'b' ];
  test.identical( got, expected )

  var got = _.mapOwnKeys( c );
  var expected = [ 'c' ];
  test.identical( got, expected );

  //

  test.case = 'enumerable on/off';
  var a = { a : '1' };

  var got = _.mapOwnKeys( a );
  var expected = [ 'a' ]
  test.identical( got, expected );

  Object.defineProperty( a, 'k', { enumerable : false } );
  var o = { enumerable : 0 };
  var got = _.mapOwnKeys.call( o, a );
  var expected = [ 'a', 'k' ]
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKeys();
  })

  test.case = 'invalid type';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKeys( 1 );
  })

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKeys.call( { own : 0 }, {} );
  })

}

//

function mapAllKeys( test )
{
  var _expected =
  [
    '__defineGetter__',
    '__defineSetter__',
    'hasOwnProperty',
    '__lookupGetter__',
    '__lookupSetter__',
    'propertyIsEnumerable',
    '__proto__',
    'constructor',
    'toString',
    'toLocaleString',
    'valueOf',
    'isPrototypeOf'
  ]

  //

  test.case = 'empty'
  var got = _.mapAllKeys( {} );
  test.identical( got.sort(), _expected.sort() )

  //

  test.case = 'one own property'
  var got = _.mapAllKeys( { a : 1 } );
  var expected = _expected.slice();
  expected.push( 'a' );
  test.identical( got.sort(), expected.sort() )

  //

  test.case = 'date'
  var got = _.mapAllKeys( new Date );
  test.identical( got.length, 55 );

  //

  test.case = 'not enumerable'
  var a = { };
  Object.defineProperty( a, 'k', { enumerable : 0 })
  var got = _.mapAllKeys( a );
  var expected = _expected.slice();
  expected.push( 'k' );
  test.identical( got.sort(), expected.sort() );

  //

  test.case = 'from prototype'
  var a = { a : 1 };
  var b = { b : 1 };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( a, 'k', { enumerable : 0 } );
  Object.defineProperty( b, 'y', { enumerable : 0 } );
  var got = _.mapAllKeys( a );
  var expected = _expected.slice();
  expected = expected.concat( [ 'a','b','k','y' ] );
  test.identical( got.sort(), expected.sort() );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllKeys();
  })

  test.case = 'invalid argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllKeys();
  })

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllKeys.call( { own : 0 }, {} );
  })

}

//

function mapVals( test )
{

  test.case = 'trivial';

  var got = _.mapVals( {} );
  var expected = [];
  test.identical( got, expected );

  var got = _.mapVals( { a : 1, b : undefined } );
  var expected = [ 1, undefined ];
  test.identical( got, expected );

  var got = _.mapVals( { a : 7, b : 13 } );
  var expected = [ 7, 13 ];
  test.identical( got, expected );

  var got = _.mapVals( { 7 : 'a', 3 : 'b', 13 : 'c' } );
  var expected = [ 'b', 'a', 'c' ];
  test.identical( got, expected );

  var got = _.mapVals( new Date );
  var expected = [ ];
  test.identical( got, expected );

  /* */

  test.case = 'own'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapVals.call( { own : 0, enumerable : 1 }, a );
  var expected = [ 1, 2 ]
  test.identical( got, expected );

  /**/

  var got = _.mapVals.call( { own : 1, enumerable : 1 }, a );
  var expected = [ 1 ];
  test.identical( got, expected );

  //

  test.case = 'enumerable'
  var a = { a : 1 };
  Object.defineProperty( a, 'k', { enumerable : 0, value : 2 } );

  /**/

  var got = _.mapVals.call( { enumerable : 1, own : 0 }, a );
  var expected = [ 1 ];
  test.identical( got, expected );

  /**/

  var got = _.mapVals.call( { enumerable : 0, own : 0 }, a );
  var contains = false;
  for( var i = 0; i < got.length; i++ )
  {
    contains = _.mapContain( a, got[ i ] )
    if( !contains )
    break;
  }
  test.is( contains );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapVals();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapVals( 'wrong argument' );
  });

  test.case = 'wrong option';
  test.shouldThrowErrorSync( function()
  {
    _.mapVals.call( { a : 1 }, {} );
  });

}

//

function mapOwnVals( test )
{

  test.case = 'trivial';

  var got = _.mapOwnVals( {} );
  var expected = [];
  test.identical( got, expected );

  var got = _.mapOwnVals( { a : 7, b : 13 } );
  var expected = [ 7, 13 ];
  test.identical( got, expected );

  var got = _.mapOwnVals( { 7 : 'a', 3 : 'b', 13 : 'c' } );
  var expected = [ 'b', 'a', 'c' ];
  test.identical( got, expected );

  var got = _.mapOwnVals( new Date );
  var expected = [ ];
  test.identical( got, expected );

  //

  test.case = ' only own values'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnVals( a );
  var expected = [ 1 ];
  test.identical( got, expected );

  /* enumerable off */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  Object.defineProperty( b, 'y', { enumerable : 0, value : 4 } );
  var got = _.mapOwnVals.call({ enumerable : 0 }, a );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnVals();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnVals( 'wrong argument' );
  });

  test.case = 'wrong option';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnVals.call( { a : 1 }, {} );
  });

}

//

function mapAllVals( test )
{
  test.case = 'trivial';

  var got = _.mapAllVals( {} );
  test.is( got.length );

  /**/

  var got = _.mapAllVals( { a : 7, b : 13 } );
  test.is( got.length );
  test.is( got.indexOf( 7 ) !== -1 );
  test.is( got.indexOf( 13 ) !== -1 );

  /**/

  var got = _.mapAllVals( new Date );
  test.is( got.length > _.mapAllVals( {} ).length );

  //

  test.case = 'from prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllVals( a );
  var expected = [ 1 ];
  test.is( got.length > _.mapAllVals( {} ).length );
  test.is( got.indexOf( 1 ) !== -1 );
  test.is( got.indexOf( 2 ) !== -1 );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllVals();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllVals( 'wrong argument' );
  });

  test.case = 'wrong option';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllVals.call( { a : 1 }, {} );
  });

}

//

function mapPairs( test )
{

  test.case = 'empty';

  var got = _.mapPairs( {} );
  var expected = [];
  test.identical( got, expected );

  var got = _.mapPairs( [] );
  var expected = [];
  test.identical( got, expected );

  /**/

  test.case = 'a list of [ key, value ] pairs';

  var got = _.mapPairs( { a : 7, b : 13 } );
  var expected = [ [ 'a', 7 ], [ 'b', 13 ] ];
  test.identical( got, expected );

  test.case = 'a list of [ key, value ] pairs'
  var got = _.mapPairs( { a : 3, b : 13, c : 7 } );
  var expected = [ [ 'a', 3 ], [ 'b', 13 ], [ 'c', 7 ] ];
  test.identical( got, expected );

  /**/

  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapPairs( arrObj );
  var expected = [ [ 'k', 1 ] ];
  test.identical( got, expected );

  /**/

  var got = _.mapPairs( new Date );
  var expected = [];
  test.identical( got, expected );

  /* */

  test.case = 'from prototype';

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapPairs( a );
  var expected = [ [ 'a', 1 ], [ 'b', 2 ] ];
  test.identical( got, expected );

  /* using own */

  var got = _.mapPairs.call( { own : 1 }, a );
  var expected = [ [ 'a', 1 ] ];
  test.identical( got, expected );

  /* using enumerable off, own on */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapPairs.call( { enumerable : 0, own : 1 }, a );
  var expected = [ [ 'a', 1 ], [ 'k', 3 ] ];
  test.identical( got, expected );

  /* using enumerable off, own off */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapPairs.call( { enumerable : 0, own : 0 }, a );
  test.is( got.length > 2 );
  test.identical( got[ 0 ], [ 'a', 1 ] );
  test.identical( got[ 1 ], [ 'k', 3 ] );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapPairs();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapPairs( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapPairs( 'wrong argument' );
  });

  test.case = 'redundant argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapPairs( {}, 'wrong arguments' );
  });

  test.case = 'wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _.mapPairs( null );
  });

}

//

function mapOwnPairs( test )
{
  test.case = 'empty';
  var got = _.mapOwnPairs( {} );
  var expected = [];
  test.identical( got, expected );

  //

  test.case = 'a list of [ key, value ] pairs';

  var got = _.mapOwnPairs( { a : 7, b : 13 } );
  var expected = [ [ 'a', 7 ], [ 'b', 13 ] ];
  test.identical( got, expected );

  /**/

  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapOwnPairs( arrObj );
  var expected = [ [ 'k', 1 ] ];
  test.identical( got, expected );

  /**/

  var got = _.mapOwnPairs( new Date );
  var expected = [];
  test.identical( got, expected );

  //

  test.case = 'from prototype';

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapOwnPairs( a );
  var expected = [ [ 'a', 1 ] ];
  test.identical( got, expected );

  /* using enumerable off */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnPairs.call( { enumerable : 0 }, a );
  var expected = [ [ 'a', 1 ], [ 'k', 3 ] ];
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnPairs();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnPairs( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnPairs( 'wrong argument' );
  });

}

//

function mapAllPairs( test )
{
  test.case = 'empty';
  var got = _.mapAllPairs( {} );
  test.is( got.length );

  //

  test.case = 'a list of [ key, value ] pairs';

  var got = _.mapAllPairs( { a : 7, b : 13 } );
  test.is( got.length > 2 );
  test.identical( got[ 0 ], [ 'a', 7 ] );
  test.identical( got[ 1 ], [ 'b', 13 ] );

  /**/

  var arrObj = [];
  arrObj[ 'k' ] = 1;
  var got = _.mapAllPairs( arrObj );
  test.is( got.length > 1 );
  got = _.arrayFlatten( [], got );
  test.is( got.indexOf( 'k' ) !== -1 );
  test.identical( got[ got.indexOf( 'k' ) + 1 ], 1 );

  /**/

  var got = _.mapAllPairs( new Date );
  test.is( got.length > 1 );
  got = _.arrayFlatten( [], got );
  test.is( got.indexOf( 'constructor' ) !== -1 );
  test.identical( got[ got.indexOf( 'constructor' ) + 1 ].name, 'Date' );

  //

  test.case = 'from prototype';

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  var got = _.mapAllPairs( a );
  test.is( got.length > 2 );
  test.identical( got[ 0 ], [ 'a', 1 ] );
  test.identical( got[ 1 ], [ 'b', 2 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllPairs();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllPairs( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllPairs( 'wrong argument' );
  });

}

//

function mapProperties( test )
{
  test.case = 'empty';

  var got = _.mapProperties( {} );
  test.identical( got, {} );

  var got = _.mapProperties( [] );
  test.identical( got, {} );

  //

  test.case = 'trivial';

  var got = _.mapProperties( { a : 1 } );
  var expected = { a : 1 };
  test.identical( got, expected );

  var a = [];
  a.a = 1;
  var got = _.mapProperties( a );
  var expected = { a : 1 };
  test.identical( got, expected );

  var got = _.mapProperties( new Date() );
  var expected = {};
  test.identical( got, expected );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapProperties( a );
  var expected = { a : 1, b : 2 };
  test.identical( got, expected );

  /**/

  var got = _.mapProperties.call( { own : 1, enumerable : 1 }, a );
  var expected = { a : 1 };
  test.identical( got, expected );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapProperties.call( { enumerable : 0, own : 1 }, a );
  var expected = { a : 1, k : 3 };
  test.identical( got, expected );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapProperties.call( { enumerable : 0, own : 0 }, a );
  test.is( Object.keys( got ).length > 3 );
  test.is( got.a === 1 );
  test.is( got.b === 2 );
  test.is( got.k === 3 );

  /**/

  var got = _.mapProperties.call( { enumerable : 0, own : 0 }, new Date() );
  test.is( Object.keys( got ).length );
  test.is( got.constructor.name === 'Date' );
  test.is( _.routineIs( got.getDate ) );
  test.is( !!got.__proto__ );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapProperties();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapProperties( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapProperties( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapProperties.call( { x : 1 }, {} );
  });

}

//

function mapOwnProperties( test )
{
  test.case = 'empty';

  var got = _.mapOwnProperties( {} );
  test.identical( got, {} );

  var got = _.mapOwnProperties( [] );
  test.identical( got, {} );

  //

  test.case = 'trivial';

  var got = _.mapOwnProperties( { a : 1 } );
  var expected = { a : 1 };
  test.identical( got, expected );

  var a = [];
  a.a = 1;
  var got = _.mapOwnProperties( a );
  var expected = { a : 1 };
  test.identical( got, expected );

  var got = _.mapOwnProperties( new Date() );
  var expected = {};
  test.identical( got, expected );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnProperties( a );
  var expected = { a : 1 };
  test.identical( got, expected );

  /**/

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnProperties.call( { enumerable : 0 }, a );
  var expected = { a : 1, k : 3 };
  test.identical( got, expected );

  /**/

  var got = _.mapOwnProperties.call( { enumerable : 0 }, new Date() );
  test.identical( got, {} )

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnProperties();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnProperties( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnProperties( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnProperties.call( { x : 1 }, {} );
  });

}

//

function mapAllProperties( test )
{
  test.case = 'empty';

  var got = _.mapAllProperties( {} );
  test.is( Object.keys( got ).length  )
  test.identical( got.constructor.name, 'Object' );

  var got = _.mapAllProperties( [] );
  test.is( Object.keys( got ).length  )
  test.identical( got.constructor.name, 'Array' );

  //

  test.case = 'trivial';

  var got = _.mapAllProperties( { a : 1 } );
  test.is( Object.keys( got ).length > 1 )
  test.identical( got.a, 1 );

  var a = [];
  a.a = 1;
  var got = _.mapAllProperties( a );
  test.is( Object.keys( got ).length > 1 )
  var expected = { a : 1 };
  test.identical( got.a, 1 );

  var got = _.mapAllProperties( new Date() );
  test.is( _.routineIs( got.getDate ) );
  test.identical( got.constructor.name, 'Date' );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllProperties( a );
  test.is( Object.keys( got ).length > 2 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapAllProperties( a );
  test.is( Object.keys( got ).length > 3 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, 3 );

  /**/

  var a = { a : 1 };
  var b = { b : 2 };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : undefined } );
  var got = _.mapAllProperties( a );
  test.is( Object.keys( got ).length > 3 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, undefined );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllProperties();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllProperties( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllProperties( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllProperties.call( { x : 1 }, {} );
  });

}

//

function mapRoutines( test )
{
  test.case = 'empty';

  var got = _.mapRoutines( {} );
  test.identical( got, {} );

  var got = _.mapRoutines( [] );
  test.identical( got, {} );

  //

  test.case = 'trivial';

  var got = _.mapRoutines( { a : 1, b : function(){} } );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.b ) );

  var a = [];
  a.a = function(){};
  var got = _.mapRoutines( a );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.a ) );

  var got = _.mapRoutines( new Date() );
  test.identical( got, {} );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapRoutines( a );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.c ) );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapRoutines( a );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.c ) );

  /* enumerable : 0 */

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapRoutines.call( { enumerable : 0 }, a );
  test.is( Object.keys( got ).length > 1 )
  test.is( _.routineIs( got.c ) );
  test.is( _.routineIs( got.__defineGetter__ ) );
  test.is( _.routineIs( got.__defineSetter__ ) );


  /**/

  a.y = function(){}
  var got = _.mapRoutines.call( { own : 1 }, a );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.y ) );

  /* own : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  var got = _.mapRoutines.call( { own : 0 }, a );
  test.is( Object.keys( got ).length === 2 )
  test.is( _.routineIs( got.y ) );
  test.is( _.routineIs( got.c ) );

  /* own : 0, enumerable : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : function(){} } );
  var got = _.mapRoutines.call( { own : 0, enumerable : 0 }, a );
  test.is( Object.keys( got ).length > 3 )
  test.is( _.routineIs( got.y ) );
  test.is( _.routineIs( got.c ) );
  test.is( _.routineIs( got.k ) );
  test.is( _.routineIs( got.__defineGetter__ ) );
  test.is( _.routineIs( got.__defineSetter__ ) );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapRoutines();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapRoutines( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapRoutines( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapRoutines.call( { x : 1 }, {} );
  });

}

//

function mapOwnRoutines( test )
{
  test.case = 'empty';

  var got = _.mapOwnRoutines( {} );
  test.identical( got, {} );

  var got = _.mapOwnRoutines( [] );
  test.identical( got, {} );

  //

  test.case = 'trivial';

  var got = _.mapOwnRoutines( { a : 1, b : function(){} } );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.b ) );

  var a = [];
  a.a = function(){};
  var got = _.mapOwnRoutines( a );
  test.is( Object.keys( got ).length === 1 )
  test.is( _.routineIs( got.a ) );

  var got = _.mapRoutines( new Date() );
  test.identical( got, {} );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapOwnRoutines( a );
  test.identical( got, {} );

  /* enumerable : 0 */

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnRoutines( a );
  test.identical( got, {} );

  /* enumerable : 0 */

  var a = {};
  var b = {};
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : function(){} } );
  var got = _.mapOwnRoutines( a );
  test.identical( got, {} );

  /* enumerable : 0 */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnRoutines.call( { enumerable : 0 }, a );
  test.identical( got, {} );

  /* enumerable : 0 */

  var a = {};
  var b = {};
  Object.defineProperty( a, 'k', { enumerable : 0, value : function(){} } );
  var got = _.mapOwnRoutines.call( { enumerable : 0 }, a );
  test.identical( got.k, a.k );
  test.is( _.routineIs( got.k ) );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnRoutines();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnRoutines( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnRoutines( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnRoutines.call( { x : 1 }, {} );
  });

}

//

function mapAllRoutines( test )
{
  test.case = 'empty';

  var got = _.mapAllRoutines( {} );
  test.is( Object.keys( got ).length );
  test.is( _.routineIs( got.__defineGetter__ ) );
  test.is( _.routineIs( got.__defineSetter__ ) );

  var got = _.mapAllRoutines( [] );
  test.is( Object.keys( got ).length );
  test.is( _.routineIs( got.__defineGetter__ ) );
  test.is( _.routineIs( got.__defineSetter__ ) );

  //

  test.case = 'trivial';

  var got = _.mapAllRoutines( { a : 1, b : function(){} } );
  test.is( Object.keys( got ).length );
  test.is( _.routineIs( got.__defineGetter__ ) );
  test.is( _.routineIs( got.__defineSetter__ ) );
  test.is( _.routineIs( got.b ) );

  var a = [];
  a.a = function(){};
  var got = _.mapAllRoutines( a );
  test.is( Object.keys( got ).length );
  test.is( _.routineIs( got.__defineGetter__ ) );
  test.is( _.routineIs( got.__defineSetter__ ) );
  test.is( _.routineIs( got.a ) );

  var got = _.mapAllRoutines( new Date() );
  test.is( Object.keys( got ).length );
  test.identical( got.constructor.name, 'Date' );
  test.is( _.routineIs( got.getDate ) );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllRoutines( a );
  test.is( Object.keys( got ).length > 1 );
  test.is( _.routineIs( got.c ) );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapAllRoutines( a );
  test.is( Object.keys( got ).length > 1 );
  test.is( _.routineIs( got.c ) );

  /**/

  Object.defineProperty( a, 'z', { enumerable : 0, value : function(){} } );
  Object.defineProperty( b, 'y', { enumerable : 0, value : function(){} } );
  var got = _.mapAllRoutines( a );
  test.is( Object.keys( got ).length > 2 );
  test.is( _.routineIs( got.c ) );
  test.is( _.routineIs( got.y ) );
  test.is( _.routineIs( got.z ) );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllRoutines();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllRoutines( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllRoutines( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllRoutines.call( { x : 1 }, {} );
  });

}

//

function mapFields( test )
{
  test.case = 'empty';

  var got = _.mapFields( {} );
  test.identical( got, {} );

  var got = _.mapFields( [] );
  test.identical( got, {} );

  //

  test.case = 'trivial';

  var got = _.mapFields( { a : 1, b : function(){} } );
  test.is( Object.keys( got ).length === 1 )
  test.is( got.a === 1 );

  var a = [ ];
  a.a = function(){};
  a.b = 1;
  var got = _.mapFields( a );
  test.is( Object.keys( got ).length === 1 )
  test.is( got.b === 1 );

  var got = _.mapFields( new Date() );
  test.identical( got, {} );

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapFields( a );
  test.is( Object.keys( got ).length === 2 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapFields( a );
  test.is( Object.keys( got ).length === 2 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /* enumerable : 0 */

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapFields.call( { enumerable : 0 }, a );
  test.is( Object.keys( got ).length === 4 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, 3 );

  /**/

  a.y = function(){}
  var got = _.mapFields.call( { own : 1 }, a );
  test.is( Object.keys( got ).length === 1 )
  test.identical( got.a, 1 );

  /* own : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  var got = _.mapFields.call( { own : 0, enumerable : 1 }, a );
  test.is( Object.keys( got ).length === 2 )
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );

  /* enumerable : 0 */

  var a = { a : 1, y : function(){} };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );
  Object.defineProperty( b, 'k', { enumerable : 0, value : function(){} } );
  Object.defineProperty( b, 'z', { enumerable : 0, value : 3 } );
  var got = _.mapFields.call( { enumerable : 0 }, a );
  test.identical( Object.keys( got ).length, 4 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.z, 3 );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapFields();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapFields( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapFields( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapFields.call( { x : 1 }, {} );
  });

}

//

function mapOwnFields( test )
{
  test.case = 'empty';

  var got = _.mapOwnFields( {} );
  test.identical( got, {} );

  var got = _.mapOwnFields( [] );
  test.identical( got, {} );

  /* */

  test.case = 'trivial';

  var got = _.mapOwnFields( { a : 1, b : function(){} } );
  test.is( Object.keys( got ).length === 1 )
  test.is( got.a === 1 );

  var a = [ ];
  a.a = function(){};
  a.b = 1;
  var got = _.mapOwnFields( a );
  test.is( Object.keys( got ).length === 1 )
  test.is( got.b === 1 );

  var got = _.mapOwnFields( new Date() );
  test.identical( got, {} );

  /* */

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /* */

  var got = _.mapOwnFields( a );
  test.is( Object.keys( got ).length === 1 );
  test.identical( got.a, 1 );

  /* */

  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapOwnFields( a );
  test.is( Object.keys( got ).length === 1 );
  test.identical( got.a, 1 );

  /* enumerable : 0 */

  Object.defineProperty( a, 'y', { enumerable : 0, value : 3 } );
  var got = _.mapOwnFields.call( { enumerable : 0 }, a );
  test.is( Object.keys( got ).length === 3 )
  test.identical( got.a, 1 );
  test.identical( got.y, 3 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnFields();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnFields( 'x' );
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnFields( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnFields( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnFields.call( { x : 1 }, {} );
  });

}

//

function mapAllFields( test )
{
  test.case = 'empty';

  var got = _.mapAllFields( {} );
  test.is( Object.keys( got ).length === 1 )
  test.identical( got.__proto__, {}.__proto__ );

  var got = _.mapAllFields( [] );
  test.is( Object.keys( got ).length === 2 )
  test.identical( got.__proto__, [].__proto__ );
  test.identical( got.length, 0 );

  //

  test.case = 'trivial';

  var got = _.mapAllFields( { a : 1, b : function(){} } );
  test.is( Object.keys( got ).length === 2 )
  test.is( got.a === 1 );
  test.is( got.__proto__ === {}.__proto__ );

  var a = [ ];
  a.a = function(){};
  a.b = 1;
  var got = _.mapAllFields( a );
  console.log(got);
  test.is( Object.keys( got ).length === 3 )
  test.is( got.length === 0 );
  test.is( got.b === 1 );
  test.is( got.__proto__ === [].__proto__ );

  var str = new Date();
  var got = _.mapAllFields( str );
  test.identical( got.__proto__, str.__proto__);

  //

  test.case = 'prototype'
  var a = { a : 1 };
  var b = { b : 2, c : function(){} };
  Object.setPrototypeOf( a, b );

  /**/

  var got = _.mapAllFields( a );
  test.is( Object.keys( got ).length === 3 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.__proto__, b );

  /**/

  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  var got = _.mapAllFields( a );
  test.is( Object.keys( got ).length === 4 );
  test.identical( got.a, 1 );
  test.identical( got.b, 2 );
  test.identical( got.k, 3 );
  test.identical( got.__proto__, b );

  //

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllFields();
  });

  test.case = 'primitive';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllFields( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllFields( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowErrorSync( function()
  {
    _.mapAllFields.call( { x : 1 }, {} );
  });

}

//

function hashMapExtend( test ) 
{
  test.case = 'dst - null, src - empty hash map';
  var dst = null;
  var src = new Map();
  var got = _.hashMapExtend( dst, src );
  var exp = new Map();
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst - null, src - empty simple map';
  var dst = null;
  var src = {};
  var got = _.hashMapExtend( dst, src );
  var exp = new Map();
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst - null, src - filled hash map';
  var dst = null;
  var src = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got !== dst );
  test.is( got !== src );

  test.case = 'dst - null, src - filled simple map';
  var dst = null;
  var src = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ '1', 1 ], [ 'null', null ], [ 'str', 'str' ], [ 'undefined', undefined ], [ '', '' ], [ 'false', false ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got !== dst );
  test.is( got !== src );

  /* - */

  test.open( 'dst - hash map, src - hash map' );

  test.case = 'dst - empty, src - empty';
  var dst = new Map();
  var src = new Map();
  var got = _.hashMapExtend( dst, src );
  var exp = new Map();
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - empty, src - filled';
  var dst = new Map();
  var src = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - filled, src - filled';
  var dst = new Map( [ [ { a : 1 }, { a : 1 } ] ] );
  var src = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ { a : 1 }, { a : 1 } ], [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src - almost identical';
  var dst = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var src = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ], [ [ 1 ], [ 1 ] ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src have identical keys';
  var dst = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var src = new Map( [ [ 1, 2 ], [ null, undefined ], [ 'str', '' ], [ undefined, null ], [ '', 'str' ], [ false, true ], [ [ 1 ], [  2 ] ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, 2 ], [ null, undefined ], [ 'str', '' ], [ undefined, null ], [ '', 'str' ], [ false, true ], [ [ 1 ], [ 1 ] ], [ [ 1 ], [  2 ] ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst === src';
  var dst = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var src = dst;
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got === src );

  test.close( 'dst - hash map, src - hash map' );

  /* - */ 

  test.open( 'dst - hash map, src - simple map' );

  test.case = 'dst - empty, src - empty';
  var dst = new Map();
  var src = {};
  var got = _.hashMapExtend( dst, src );
  var exp = new Map();
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - empty, src - filled';
  var dst = new Map();
  var src = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false, [ 1 ] : [ 1 ] };
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ '1', [ 1 ] ], [ 'null', null ], [ 'str', 'str' ], [ 'undefined', undefined ], [ '', '' ], [ 'false', false ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - filled, src - filled';
  var dst = new Map( [ [ { a : 1 }, { a : 1 } ] ] );
  var src = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false, [ 1 ] : [ 1 ] };
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ { a : 1 }, { a : 1 } ], [ '1', [ 1 ] ], [ 'null', null ], [ 'str', 'str' ], [ 'undefined', undefined ], [ '', '' ], [ 'false', false ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src - almost identical';
  var dst = new Map( [ [ 1, [ 1 ] ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ] ] );
  var src = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false, [ 1 ] : [ 1 ] };
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, [ 1 ] ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ '1', [ 1 ] ], [ 'null', null ], [ 'undefined', undefined ], [ 'false', false ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src have identical keys';
  var dst = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', 'str' ], [ undefined, undefined ], [ '', '' ], [ false, false ], [ [ 1 ], [ 1 ] ] ] );
  var src = { 1 : 1, null : undefined, 'str' : '', undefined : null, '' : 'str', false : true, [ 1 ] : 2 };
  var got = _.hashMapExtend( dst, src );
  var exp = new Map( [ [ 1, 1 ], [ null, null ], [ 'str', '' ], [ undefined, undefined ], [ '', 'str' ], [ false, false ], [ [ 1 ], [ 1 ] ], [ '1', 2 ], [ 'null', undefined ], [ 'undefined', null ], [ 'false', true ] ] );
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.is( got === dst );
  test.is( got !== src );

  test.close( 'dst - hash map, src - simple map' );

  /* - */

  test.open( 'dst - simple map, src - hash map' );

  test.case = 'dst - empty, src - empty';
  var dst = {};
  var src = new Map();
  var got = _.hashMapExtend( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - empty, src - filled';
  var dst = {};
  var src = new Map( [ [ '1', [ 1 ] ], [ 'null', null ], [ 'str', 'str' ], [ 'undefined', undefined ], [ '', '' ], [ 'false', false ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : [ 1 ], null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - filled, src - filled';
  var dst = { a : 1 };
  var src = new Map( [ [ '1', [ 1 ] ], [ 'null', null ], [ 'str', 'str' ], [ 'undefined', undefined ], [ '', '' ], [ 'false', false ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = { a : 1, 1 : [ 1 ], null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src - almost identical';
  var dst = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var src = new Map( [ [ '1', 1 ], [ 'null', null ], [ 'str', 'str' ], [ 'undefined', undefined ], [ '', '' ], [ 'false', false ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src have identical keys';
  var dst = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var src = new Map( [ [ '1', [ 1 ] ], [ 'null', undefined ], [ 'str', '' ], [ 'undefined', null ], [ '', 'str' ], [ 'false', true ] ] );
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : [ 1 ], null : undefined, 'str' : '', undefined : null, '' : 'str', false : true };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.close( 'dst - simple map, src - hash map' );

  /* - */

  test.open( 'dst - simple map, src - simple map' );

  test.case = 'dst - empty, src - empty';
  var dst = {};
  var src = {};
  var got = _.hashMapExtend( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - empty, src - filled';
  var dst = {};
  var src = { 1 : [ 1 ], null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : [ 1 ], null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst - filled, src - filled';
  var dst = { a : 1 };
  var src = { 1 : [ 1 ], null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var got = _.hashMapExtend( dst, src );
  var exp = { a : 1, 1 : [ 1 ], null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src - almost identical';
  var dst = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var src = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst and src have identical keys';
  var dst = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var src = { 1 : [ 1 ], null : undefined, 'str' : '', undefined : null, '' : 'str', false : true };
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : [ 1 ], null : undefined, 'str' : '', undefined : null, '' : 'str', false : true };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got !== src );

  test.case = 'dst === src';
  var dst = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  var src = dst;
  var got = _.hashMapExtend( dst, src );
  var exp = { 1 : 1, null : null, 'str' : 'str', undefined : undefined, '' : '', false : false };
  test.identical( got, exp );
  test.is( got === dst );
  test.is( got === src );

  test.close( 'dst - simple map, src - simple map' );

  /* - */

  if( !Config.debug ) 
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.hashMapExtend() );

  test.case = 'one argument';
  test.shouldThrowErrorSync( () => _.hashMapExtend( new Map( [ [ 1, 1 ] ] ) ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.hashMapExtend( new Map( [ [ 1, 1 ] ] ), {}, {} ) );

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.hashMapExtend( 'wrong', {} ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.hashMapExtend( new Map( [ [ 1, 2 ] ] ), 'wrong' ) );
  test.shouldThrowErrorSync( () => _.hashMapExtend( null, null ) );

  test.case = 'dst - simple map, src - hash map with unliteral keys';
  test.shouldThrowErrorSync( () => _.hashMapExtend( { a : 1 }, new Map( [ [ 1, 2 ], [ null, null ] ] ) ) );
}

//

function mapOnlyPrimitives( test )
{
  test.case = 'emtpy';

  var got = _.mapOnlyPrimitives( {} )
  test.identical( got, {} );

  test.case = 'primitives';

  var src =
  {
    a : null,
    b : undefined,
    c : 5,
    e : false,
    f : 'a',
    g : function(){},
    h : [ 1 ],
    i : new Date(),
    j : new BufferRaw( 5 )
  }
  var got = _.mapOnlyPrimitives( src );
  var expected =
  {
    a : null,
    b : undefined,
    c : 5,
    e : false,
    f : 'a',
  }
  test.identical( got, expected );

  /* */

  test.case = 'only enumerable';
  var a = {};
  Object.defineProperty( a, 'k', { enumerable : 0, value : 3 } )
  var got = _.mapOnlyPrimitives( a );
  test.identical( got, {} );

  /* */

  test.case = 'from prototype';
  var a = {};
  var b = { a : 1, c : function(){} };
  Object.defineProperty( b, 'k', { enumerable : 0, value : 3 } );
  Object.setPrototypeOf( a, b );
  var got = _.mapOnlyPrimitives( a );
  test.identical( got, { a : 1 } );

  /* */

  if( !Config.debug )
  return;

  test.case = 'invalid arg type';
  test.shouldThrowErrorSync( function()
  {
    _.mapOnlyPrimitives( null )
  });

  test.case = 'no args';
  test.shouldThrowErrorSync( function()
  {
    _.mapOnlyPrimitives()
  })

}

//

function mapButConditional( test )
{

  test.case = 'an object';
  var got = _.mapButConditional( _.field.filter.dstNotHasSrcPrimitive, { a : 1, b : 'ab', c : [ 1, 2, 3 ] }, { a : 1, b : 'ab', d : [ 1, 2, 3 ] }  );
  var expected = {};
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapButConditional();
  });

  test.case = 'few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapButConditional( _.field.mapper.primitive );
  });

  test.case = 'second argument is wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _.mapButConditional( _.field.mapper.primitive, [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapButConditional( 'wrong arguments' );
  });

}

//

function mapButConditionalThreeArguments_( test )
{
  var filter = function ( dstContainer, srcContainer, key )
  {
    if( !_.primitiveIs( srcContainer[ key ] ) )
    return false;
    if( dstContainer === key )
    return false;
    if( _.mapIs( dstContainer ) && key in dstContainer )
    return false;

    return true;
  }
  filter.functionFamily = 'field-filter';

  /* - */

  test.open( 'srcMap - map' );

  test.case = 'srcMap - null, butMap - empty map';
  var srcMap = null;
  var screenMap = {};
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - null, butMap - empty array';
  var srcMap = null;
  var screenMap = [];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - null, butMap - filled map';
  var srcMap = null;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - null, butMap - filled array';
  var srcMap = null;
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not primitive, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'srcMap - filled map has not primitive, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : [ 1, 2 ] };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, has identical keys';
  var srcMap = { a : 1, b : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not primitive, butMap - filled map, not identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map has not primitive, butMap - filled map, has identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, has identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapButConditional_( filter, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapButConditional_() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.mapButConditional_( { a : 1 } ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapButConditional_( filter, {}, [], {}, [] ) );

  test.case = 'wrong type of fieldFilter';
  test.shouldThrowErrorSync( () => _.mapButConditional_( 'wrong', {}, [] ) );
  test.shouldThrowErrorSync( () => _.mapButConditional_( [], null, {}, {} ) );

  test.case = 'fieldFilter has not field field-filter';
  var filter = ( a, b, c ) => a > ( b + c );
  test.shouldThrowErrorSync( () => _.mapButConditional_( filter, null, {}, {} ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapButConditional_( filter, 3, [] ) );
  test.shouldThrowErrorSync( () => _.mapButConditional_( filter, [], {}, {} ) );

  test.case = 'wrong type of butMap';
  test.shouldThrowErrorSync( () => _.mapButConditional_( filter, [], '' ) );
  test.shouldThrowErrorSync( () => _.mapButConditional_( filter, null, [], '' ) );
}

//

function mapButConditionalDstMapNull_( test )
{
  var filter = function ( dstContainer, srcContainer, key )
  {
    if( !_.primitiveIs( srcContainer[ key ] ) )
    return false;
    if( dstContainer === key )
    return false;
    if( _.mapIs( dstContainer ) && key in dstContainer )
    return false;

    return true;
  }
  filter.functionFamily = 'field-filter';

  /* - */

  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not primitive, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'srcMap - filled map has not primitive, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : [ 1, 2 ] };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, has identical keys';
  var srcMap = { a : 1, b : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not primitive, butMap - filled map, not identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map has not primitive, butMap - filled map, has identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not primitive, butMap - filled array, has identical keys';
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapButConditional_( filter, null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' );
}

//

function mapButConditionalDstMapMap_( test ) 
{
  var filter = function ( dstContainer, srcContainer, key )
  {
    if( !_.primitiveIs( srcContainer[ key ] ) )
    return false;
    if( dstContainer === key )
    return false;
    if( _.mapIs( dstContainer ) && key in dstContainer )
    return false;

    return true;
  }
  filter.functionFamily = 'field-filter';

  /* - */

  test.open( 'srcMap - map' );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty map';
  var dstMap = { a : 1 };
  var srcMap = {};
  var screenMap = {};
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty array';
  var dstMap = { a : 1 };
  var srcMap = {};
  var screenMap = [];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled map';
  var dstMap = Object.create( null );
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled array';
  var dstMap = Object.create( null );
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has identical keys, srcMap - filled map has not primitive, butMap - filled map, not identical keys';
  var dstMap = { aa : 'some', c : 'key' };
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, c : 'key' };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : [ 1, 2 ] } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var dstMap = { aa : 'some', c : 'key' };
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, c : 'key' };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : [ 1, 2 ] } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has not identical keys, srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = { aa : 1, bb : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : [ 1, 2 ] } );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'dstMap - has not identical keys, srcMap - filled map has not primitive, butMap - filled map, has identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = { a : 1, b : 2, cc : [ 1, 2 ] };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { a : 1, b : 2, cc : [ 1, 2 ] } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map has not primitive, butMap - filled array, has identical keys';
  var dstMap = { a : 1, b : 4 };
  var srcMap = { a : 1, b : 2, cc : [ 1, 2 ] };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 4 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { a : 1, b : 2, cc : [ 1, 2 ] } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty map';
  var dstMap = { a : 1 };
  var srcMap = [];
  var screenMap = {};
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty array';
  var dstMap = { a : 1 };
  var srcMap = [];
  var screenMap = [];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled map';
  var dstMap = Object.create( null );
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled array';
  var dstMap = Object.create( null );
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has not identical keys, srcMap - filled map has not primitive, butMap - filled map, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has not identical keys, srcMap - filled map has not primitive, butMap - filled array, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'dstMap - has identical keys, srcMap - filled map has not primitive, butMap - filled map, has identical keys';
  var dstMap = { 0 : 'some', 2 : 'key', a : 1 };
  var srcMap = [ { a : 'a' }, 0, [ 'b' ], 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { 0 : 'some', 2 : 'key', a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map has not primitive, butMap - filled array, has identical keys';
  var dstMap = { 0 : 'some', 2 : 'key', a : 1 };
  var srcMap =[ { a : 'a' }, 0, [ 'b' ], 1 ]; 
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapButConditional_( filter, dstMap, srcMap, screenMap );
  var expected = { 0 : 'some', 2 : 'key', a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ { a : 'a' }, 0, [ 'b' ], 1 ]);
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' ); 
}

//

function mapBut( test )
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut( srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : 3 } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : 3 } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : 3 } );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'srcMap - filled map, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut( srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { a : 1, b : 2, cc : 3 } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, has identical keys';
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { a : 1, b : 2, cc : 3 } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled map, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut( srcMap, screenMap );
  var expected = { 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = { 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map, butMap - filled map, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapBut( srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ]
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapBut( srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapBut() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.mapBut( { a : 1 } ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapBut( [], [], {} ) );

  test.case = 'first argument is not an object-like';
  test.shouldThrowErrorSync( () => _.mapBut( 3, [] ) );

  test.case = 'second argument is not an object-like';
  test.shouldThrowErrorSync( () => _.mapBut( [], '' ) );
}

//

function mapButTwoArguments_( test )
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - null, butMap - empty map';
  var srcMap = null;
  var screenMap = {};
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - null, butMap - empty array';
  var srcMap = null;
  var screenMap = [];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - null, butMap - filled map';
  var srcMap = null;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - null, butMap - filled array';
  var srcMap = null;
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'srcMap - filled map, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, has identical keys';
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled map, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map, butMap - filled map, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ]
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapBut_( srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapBut_() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.mapBut_( { a : 1 } ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapBut_( {}, [], {}, [] ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapBut_( 3, [] ) );
  test.shouldThrowErrorSync( () => _.mapBut_( [], {}, {} ) );

  test.case = 'wrong type of butMap';
  test.shouldThrowErrorSync( () => _.mapBut_( [], '' ) );
  test.shouldThrowErrorSync( () => _.mapBut_( null, [], '' ) );
}

//

function mapButDstMapNull_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'srcMap - filled map, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, has identical keys';
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { cc : 3 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map, butMap - filled map, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map, butMap - filled map, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map, butMap - filled array, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ]
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapBut_( null, srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' ); 
}

//

function mapButDstMapMap_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty map';
  var dstMap = { a : 1 };
  var srcMap = {};
  var screenMap = {};
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty array';
  var dstMap = { a : 1 };
  var srcMap = {};
  var screenMap = [];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled map';
  var dstMap = Object.create( null );
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled array';
  var dstMap = Object.create( null );
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has identical keys, srcMap - filled map, butMap - filled map, not identical keys';
  var dstMap = { aa : 'some', c : 'key' };
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3, c : 'key' };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : 3 } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map, butMap - filled array, not identical keys';
  var dstMap = { aa : 'some', c : 'key' };
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, cc : 3, c : 'key' };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : 3 } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has not identical keys, srcMap - filled map, butMap - filled array, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = { aa : 1, bb : 2, cc : 3 };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : 3 } );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'dstMap - has not identical keys, srcMap - filled map, butMap - filled map, has identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { a : 1, b : 2, cc : 3 } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map, butMap - filled array, has identical keys';
  var dstMap = { a : 1, b : 4 };
  var srcMap = { a : 1, b : 2, cc : 3 };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 4, cc : 3 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { a : 1, b : 2, cc : 3 } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty map';
  var dstMap = { a : 1 };
  var srcMap = [];
  var screenMap = {};
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty array';
  var dstMap = { a : 1 };
  var srcMap = [];
  var screenMap = [];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled map';
  var dstMap = Object.create( null );
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled array';
  var dstMap = Object.create( null );
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has not identical keys, srcMap - filled map, butMap - filled map, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has not identical keys, srcMap - filled map, butMap - filled array, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, 0 : 'a', 1 : 0, 2 : 'b', 3 : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'dstMap - has identical keys, srcMap - filled map, butMap - filled map, has identical keys';
  var dstMap = { 0 : 'some', 2 : 'key', a : 1 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b', a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map, butMap - filled array, has identical keys';
  var dstMap = { 0 : 'some', 2 : 'key', a : 1 };
  var srcMap = [ 'a', 0, 'b', 1 ]
  var screenMap = [ 'a', '3', 'b', '1' ];
  var got = _.mapBut_( dstMap, srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b', a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ 'a', '3', 'b', '1' ] );
  
  test.close( 'srcMap - array' ); 
}

//

function mapButIgnoringUndefinesThreeArguments_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - null, butMap - empty map';
  var srcMap = null;
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - null, butMap - empty array';
  var srcMap = null;
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - null, butMap - filled map';
  var srcMap = null;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - null, butMap - filled array';
  var srcMap = null;
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has undefined, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : undefined };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : undefined };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var srcMap = { 0 : 1, 1 : 2, cc : undefined };
  var screenMap = [ 'aa', 0, 'bb', '1' ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'aa', 0, 'bb', '1' ] );
  
  test.case = 'srcMap - filled map has undefined, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : undefined };
  var screenMap = { a : undefined, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : undefined, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, has identical keys';
  var srcMap = { 0 : 1, b : 2, cc : undefined };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = { b : 2 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has undefined, butMap - filled map, not identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map has undefined, butMap - filled map, has identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, has identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ];
  var got = _.mapButIgnoringUndefines_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ] );
  
  test.close( 'srcMap - array' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_( { a : 1 } ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_( {}, [], {}, [] ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_( 3, [] ) );
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_( [], {}, {} ) );

  test.case = 'wrong type of butMap';
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_( [], '' ) );
  test.shouldThrowErrorSync( () => _.mapButIgnoringUndefines_( null, [], '' ) );
}

//

function mapButIgnoringUndefinesDstMapNull_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has undefined, butMap - filled map, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : undefined };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var srcMap = { aa : 1, bb : 2, cc : undefined };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var srcMap = { 0 : 1, 1 : 2, cc : undefined };
  var screenMap = [ 'aa', 0, 'bb', '1' ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'aa', 0, 'bb', '1' ] );
  
  test.case = 'srcMap - filled map has undefined, butMap - filled map, has identical keys';
  var srcMap = { a : 1, b : 2, cc : undefined };
  var screenMap = { a : undefined, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : undefined, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, has identical keys';
  var srcMap = { 0 : 1, b : 2, cc : undefined };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = { b : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has undefined, butMap - filled map, not identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'srcMap - filled map has undefined, butMap - filled map, has identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has undefined, butMap - filled array, has identical keys';
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ];
  var got = _.mapButIgnoringUndefines_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ] );
  
  test.close( 'srcMap - array' );
}

//

function mapButIgnoringUndefinesDstMapMap_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty map';
  var dstMap = { a : undefined };
  var srcMap = {};
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : undefined };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty array';
  var dstMap = { a : undefined };
  var srcMap = {};
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : undefined };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled map';
  var dstMap = Object.create( null );
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled array';
  var dstMap = Object.create( null );
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has identical keys, srcMap - filled map has undefined, butMap - filled map, not identical keys';
  var dstMap = { aa : 'some', c : 'key' };
  var srcMap = { aa : undefined, bb : 2, cc : 3 };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { aa : 'some', c : 'key', bb : 2, cc : 3 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : undefined, bb : 2, cc : 3 } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var dstMap = { aa : 'some', c : 'key' };
  var srcMap = { aa : 1, bb : 2, cc : undefined };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, c : 'key' };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { aa : 1, bb : 2, cc : undefined } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has not identical keys, srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = { 0 : 1, bb : 2, cc : undefined };
  var screenMap = [ 'aa', 0, 'bb', 1 ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, bb : 2 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { 0 : 1, bb : 2, cc : undefined } );
  test.identical( screenMap, [ 'aa', 0, 'bb', 1 ] );
  
  test.case = 'dstMap - has not identical keys, srcMap - filled map has undefined, butMap - filled map, has identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = { a : 1, b : 2, cc : undefined };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { a : 1, b : 2, cc : undefined } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map has undefined, butMap - filled array, has identical keys';
  var dstMap = { a : 1, b : 4 };
  var srcMap = { a : 1, b : undefined, cc : undefined };
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 4 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, { a : 1, b : undefined, cc : undefined } );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty map';
  var dstMap = { a : 1 };
  var srcMap = [];
  var screenMap = {};
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'dstMap - filled map, srcMap - empty map, butMap - empty array';
  var dstMap = { a : 1 };
  var srcMap = [];
  var screenMap = [];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled map';
  var dstMap = Object.create( null );
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - empty pure map, srcMap - empty map, butMap - filled array';
  var dstMap = Object.create( null );
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'dstMap - has not identical keys, srcMap - filled map has undefined, butMap - filled map, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has not identical keys, srcMap - filled map has undefined, butMap - filled array, not identical keys';
  var dstMap = { a : 1, b : 2 };
  var srcMap = [ undefined, 0, undefined, 1 ];;
  var screenMap = [ 'a', 'b', 'c', 'd' ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { a : 1, b : 2, 1 : 0, 3 : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, [ 'a', 'b', 'c', 'd' ] );
  
  test.case = 'dstMap - has identical keys, srcMap - filled map has undefined, butMap - filled map, has identical keys';
  var dstMap = { 0 : 'some', 2 : 'key', a : 1 };
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { 0 : 'some', 2 : 'key', a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'dstMap - has identical keys, srcMap - filled map has undefined, butMap - filled array, has identical keys';
  var dstMap = { 0 : 'some', 2 : 'key', a : 1 };
  var srcMap = [ undefined, 0, undefined, 1 ];
  var screenMap = [ { 0 : 1 }, [ '3', 'b', '1', '3'] ];
  var got = _.mapButIgnoringUndefines_( dstMap, srcMap, screenMap );
  var expected = { 0 : 'some', 2 : 'key', a : 1 };
  test.identical( got, expected );
  test.is( got === dstMap );
  test.identical( srcMap, [ undefined, 0, undefined, 1 ] );
  test.identical( screenMap, [ { 0 : 1 }, [ '3', 'b', '1', '3'] ] );
  
  test.close( 'srcMap - array' ); 
}

//

function mapOwnBut( test )
{

  test.case = 'an empty object';
  var got = _.mapOwnBut( {}, {} );
  var expected = {  };
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.mapOwnBut( { a : 7, b : 13, c : 3 }, { a : 7, b : 13 } );
  var expected = { c : 3 };
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.mapOwnBut( { a : 7, 'toString' : 5 }, { b : 33, c : 77 } );
  var expected = { a : 7 };
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnBut();
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnBut( {} );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnBut( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnBut( 'wrong arguments' );
  });
}

//

function mapOwnButThreeArguments_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - null, butMap - empty map';
  var srcMap = null;
  var screenMap = {};
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - null, butMap - empty array';
  var srcMap = null;
  var screenMap = [];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - null, butMap - filled map';
  var srcMap = null;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - null, butMap - filled array';
  var srcMap = null;
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled map, not identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = { aa : 1 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = [ { 'a' : 0 }, { 'b' : 1 } ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = { aa : 1 };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ { 'a' : 0 }, { 'b' : 1 } ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = [ { 'aa' : 0 }, { 'bb' : 1 } ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ { 'aa' : 0 }, { 'bb' : 1 } ] );
  
  test.case = 'srcMap - filled map has not own property, butMap - filled map, has identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.a = 1;
  var screenMap = { a : 1, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, { a : 1, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, has identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.a = 1;
  var screenMap = [ { 'a' : 0 }, { 'b' : 1 } ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( screenMap, [ { 'a' : 0 }, { 'b' : 1 } ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled map, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1, 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ { 0 : 1 }, { 1 : 2 } ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = { 2 : 'b', 3 : 1, };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ { 0 : 1 }, { 1 : 2 } ] );
  
  test.case = 'srcMap - filled map has not own property, butMap - filled map, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ];
  var got = _.mapOwnBut_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ] );
  
  test.close( 'srcMap - array' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapOwnBut_() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.mapOwnBut_( { a : 1 } ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapOwnBut_( {}, [], {}, [] ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapOwnBut_( 3, [] ) );
  test.shouldThrowErrorSync( () => _.mapOwnBut_( [], {}, {} ) );

  test.case = 'wrong type of butMap';
  test.shouldThrowErrorSync( () => _.mapOwnBut_( [], '' ) );
  test.shouldThrowErrorSync( () => _.mapOwnBut_( null, [], '' ) );
}

//

function mapOwnButDstMapNull_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled map, not identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = { aa : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = [ { 'a' : 0 }, { 'b' : 1 } ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = { aa : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ { 'a' : 0 }, { 'b' : 1 } ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = [ { 'aa' : 0 }, { 'bb' : 1 } ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ { 'aa' : 0 }, { 'bb' : 1 } ] );
  
  test.case = 'srcMap - filled map has not own property, butMap - filled map, has identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.a = 1;
  var screenMap = { a : 1, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 1, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, has identical keys';
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.a = 1;
  var screenMap = [ { 'a' : 0 }, { 'b' : 1 } ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ { 'a' : 0 }, { 'b' : 1 } ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled map, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = { 1 : 0, 3 : 1, 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ { 0 : 1 }, { 1 : 2 } ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = { 2 : 'b', 3 : 1, };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ { 0 : 1 }, { 1 : 2 } ] );
  
  test.case = 'srcMap - filled map has not own property, butMap - filled map, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = { 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, has identical keys';
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ];
  var got = _.mapOwnBut_( null, srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ] );
  
  test.close( 'srcMap - array' );
}

//

function mapOwnButDstMapMap_( test ) 
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = {};
  var screenMap = {};
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = {};
  var screenMap = [];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = {};
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled map, not identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 2;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 2, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 2;
  var screenMap = [ { 'a' : 0 }, { 'b' : 1 } ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 2, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ { 'a' : 0 }, { 'b' : 1 } ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.aa = 1;
  var screenMap = [ { 'aa' : 0 }, { 'bb' : 1 } ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ { 'aa' : 0 }, { 'bb' : 1 } ] );
  
  test.case = 'srcMap - filled map has not own property, butMap - filled map, has identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.a = 1;
  var screenMap = { a : 1, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 1, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, has identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = Object.create( { bb : 2, cc : 3 } );
  srcMap.a = 1;
  var screenMap = [ { 'a' : 0 }, { 'b' : 1 } ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ { 'a' : 0 }, { 'b' : 1 } ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - array' );

  test.case = 'srcMap - empty map, butMap - empty map';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [];
  var screenMap = {};
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, butMap - empty array';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [];
  var screenMap = [];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, butMap - filled map';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, butMap - filled array';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [];
  var screenMap = [ 'a', 0, 'b', 1 ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', 0, 'b', 1 ] );

  test.case = 'srcMap - filled map has not own property, butMap - filled map, not identical keys';
  var dstMap = { 0 : 1, bb : 2 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { bb : 2, 1 : 0, 3 : 1, 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, not identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ { 0 : 1 }, { 1 : 2 } ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, 2 : 'b', 3 : 1, };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ { 0 : 1 }, { 1 : 2 } ] );
  
  test.case = 'srcMap - filled map has not own property, butMap - filled map, has identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = { 1 : 13, 3 : 77, c : 3, d : 'name' };
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2, 0 : 'a', 2 : 'b' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, { 1 : 13, 3 : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - filled map has not own property, butMap - filled array, has identical keys';
  var dstMap = { aa : 1, bb : 2 };
  var srcMap = [ 'a', 0, 'b', 1 ];
  var screenMap = [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ];
  var got = _.mapOwnBut_( dstMap, srcMap, screenMap );
  var expected = { aa : 1, bb : 2 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ 'a', 0, 'b', 1 ] );
  test.identical( screenMap, [ { 1 : 'a' }, [ '3', 'b', '1', 'c' ] ] );
  
  test.close( 'srcMap - array' );
}

//

function mapOnly( test )
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, screenMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, screenMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, screenMap - map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, screenMap - array';
  var srcMap = {};
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'screenMap - empty map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = {};
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, {} );

  test.case = 'screenMap - empty array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, [] );

  test.case = 'only srcMap';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var got = _.mapOnly( srcMap );
  var expected = { d : 'name', c : 33, a : 'abc' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );

  test.case = 'all keys in srcMap exists in screenMap - map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'all keys in srcMap exists in screenMap - array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 'abc', c : 33 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'none keys in srcMap exists in screenMap - map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { aa : 13, bb : 77, cc : 3, dd : 'name' };
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, { aa : 13, bb : 77, cc : 3, dd : 'name' } );

  test.case = 'none keys in srcMap exists in screenMap - array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ] );

  test.case = 'srcMap has numerical keys, screenMap has not primitives';
  var srcMap = { 0 : 'name', 1 : 33, 2 : 'abc' };
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { 2 : 'abc', 1 : 33, 0 : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { 0 : 'name', 1 : 33, 2 : 'abc' } );
  test.identical( screenMap, [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - long' );

  test.case = 'srcMap - empty array, screenMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty array, screenMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty array, screenMap - map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty array, screenMap - array';
  var srcMap = [];
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'screenMap - empty map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = {};
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, {} );

  test.case = 'screenMap - empty array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [] );

  test.case = 'only srcMap';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var got = _.mapOnly( srcMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );

  test.case = 'all keys in srcMap exists in screenMap - map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'all keys in srcMap exists in screenMap - array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 'abc', c : 33 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'none keys in srcMap exists in screenMap - map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = { aa : 13, bb : 77, cc : 3, dd : 'name' };
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, { aa : 13, bb : 77, cc : 3, dd : 'name' } );

  test.case = 'none keys in srcMap exists in screenMap - array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ] );

  test.case = 'srcMap has numerical keys, screenMap has not primitives';
  var srcMap = [ { 0 : 'name' }, { 1 : 33 }, { 2 : 'abc' } ];
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { 2 : 'abc', 1 : 33, 0 : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { 0 : 'name' }, { 1 : 33 }, { 2 : 'abc' } ] );
  test.identical( screenMap, [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ] );

  test.close( 'srcMap - long' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapOnly() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapOnly( {}, {}, {} ) );

  test.case = 'wrong type of srcMap';
  test.shouldThrowErrorSync( () => _.mapOnly( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.mapOnly( 'wrong', {} ) );
  test.shouldThrowErrorSync( () => _.mapOnly( 3, [] ) );

  test.case = 'wrong type of screenMap';
  test.shouldThrowErrorSync( () => _.mapOnly( [], '' ) );
}

//

function mapOnlyTwoArguments_( test )
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - null, screenMap - empty map';
  var srcMap = null;
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, screenMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'srcMap - null, screenMap - empty array';
  var srcMap = null;
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, screenMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'srcMap - null, screenMap - map';
  var srcMap = null;
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, screenMap - map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - null, screenMap - array';
  var srcMap = null;
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'srcMap - empty map, screenMap - array';
  var srcMap = {};
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'screenMap - empty map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'screenMap - empty array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'only srcMap';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var got = _.mapOnly_( srcMap );
  var expected = { d : 'name', c : 33, a : 'abc' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );

  test.case = 'all keys in srcMap exists in screenMap - map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'all keys in srcMap exists in screenMap - array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'none keys in srcMap exists in screenMap - map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { aa : 13, bb : 77, cc : 3, dd : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { aa : 13, bb : 77, cc : 3, dd : 'name' } );

  test.case = 'none keys in srcMap exists in screenMap - array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ] );

  test.case = 'srcMap has numerical keys, screenMap has not primitives';
  var srcMap = { 0 : 'name', 1 : 33, 2 : 'abc' };
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { 2 : 'abc', 1 : 33, 0 : 'name' };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, { 0 : 'name', 1 : 33, 2 : 'abc' } );
  test.identical( screenMap, [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - long' );

  test.case = 'srcMap - empty array, screenMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty array, screenMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty array, screenMap - map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty array, screenMap - array';
  var srcMap = [];
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'screenMap - empty map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, {} );

  test.case = 'screenMap - empty array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [] );

  test.case = 'only srcMap';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var got = _.mapOnly_( srcMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );

  test.case = 'all keys in srcMap exists in screenMap - map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'all keys in srcMap exists in screenMap - array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'none keys in srcMap exists in screenMap - map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = { aa : 13, bb : 77, cc : 3, dd : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, { aa : 13, bb : 77, cc : 3, dd : 'name' } );

  test.case = 'none keys in srcMap exists in screenMap - array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ] );

  test.case = 'srcMap has numerical keys, screenMap has not primitives';
  var srcMap = [ { 0 : 'name' }, { 1 : 33 }, { 2 : 'abc' } ];
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { 2 : 'abc', 1 : 33, 0 : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { 0 : 'name' }, { 1 : 33 }, { 2 : 'abc' } ] );
  test.identical( screenMap, [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ] );

  test.close( 'srcMap - long' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.mapOnly_() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.mapOnly_( {}, {}, {}, {} ) );

  test.case = 'wrong type of srcMap';
  test.shouldThrowErrorSync( () => _.mapOnly_( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.mapOnly_( 'wrong', {} ) );
  test.shouldThrowErrorSync( () => _.mapOnly_( {}, 2, [] ) );

  test.case = 'wrong type of dstMap';
  test.shouldThrowErrorSync( () => _.mapOnly_( 'wrong', {}, {} ) );
  test.shouldThrowErrorSync( () => _.mapOnly_( 2, {}, {} ) );

  test.case = 'wrong type of screenMap';
  test.shouldThrowErrorSync( () => _.mapOnly_( [], '' ) );
  test.shouldThrowErrorSync( () => _.mapOnly_( {}, [], '' ) );
}

//

function mapOnlyDstMapNull_( test )
{
  test.open( 'srcMap - map' );

  test.case = 'srcMap - empty map, screenMap - empty map';
  var srcMap = {};
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty map, screenMap - empty array';
  var srcMap = {};
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty map, screenMap - map';
  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty map, screenMap - array';
  var srcMap = {};
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'screenMap - empty map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, {} );

  test.case = 'screenMap - empty array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [] );

  test.case = 'only srcMap';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var got = _.mapOnly_( srcMap );
  var expected = { d : 'name', c : 33, a : 'abc' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );

  test.case = 'all keys in srcMap exists in screenMap - map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'all keys in srcMap exists in screenMap - array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, { d : 'name', c : 33, a : 'abc' } );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'none keys in srcMap exists in screenMap - map';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { aa : 13, bb : 77, cc : 3, dd : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, { aa : 13, bb : 77, cc : 3, dd : 'name' } );

  test.case = 'none keys in srcMap exists in screenMap - array';
  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, {} );
  test.identical( screenMap, [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ] );

  test.case = 'srcMap has numerical keys, screenMap has not primitives';
  var srcMap = { 0 : 'name', 1 : 33, 2 : 'abc' };
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { 2 : 'abc', 1 : 33, 0 : 'name' };
  test.identical( got, expected );
  test.is( got === srcMap );
  test.identical( srcMap, { 0 : 'name', 1 : 33, 2 : 'abc' } );
  test.identical( screenMap, [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ] );

  test.close( 'srcMap - map' );

  /* - */

  test.open( 'srcMap - long' );

  test.case = 'srcMap - empty array, screenMap - empty map';
  var srcMap = [];
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, {} );

  test.case = 'srcMap - empty array, screenMap - empty array';
  var srcMap = [];
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [] );

  test.case = 'srcMap - empty array, screenMap - map';
  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'srcMap - empty array, screenMap - array';
  var srcMap = [];
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [] );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'screenMap - empty map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = {};
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, {} );

  test.case = 'screenMap - empty array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [] );

  test.case = 'only srcMap';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var got = _.mapOnly_( srcMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );

  test.case = 'all keys in srcMap exists in screenMap - map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, { a : 13, b : 77, c : 3, d : 'name' } );

  test.case = 'all keys in srcMap exists in screenMap - array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { a : 'abc', c : 33 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [ 'a', '13', { b : 77 }, 'c', '3', { d : 'name' } ] );

  test.case = 'none keys in srcMap exists in screenMap - map';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = { aa : 13, bb : 77, cc : 3, dd : 'name' };
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, { aa : 13, bb : 77, cc : 3, dd : 'name' } );

  test.case = 'none keys in srcMap exists in screenMap - array';
  var srcMap = [ { a : 'abc' }, { c : 33 }, { d : 'name' } ];
  var screenMap = [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { a : 'abc' }, { c : 33 }, { d : 'name' } ] );
  test.identical( screenMap, [ 'aa', '13', { bb : 77 }, 'cc', '3', { dd : 'name' } ] );

  test.case = 'srcMap has numerical keys, screenMap has not primitives';
  var srcMap = [ { 0 : 'name' }, { 1 : 33 }, { 2 : 'abc' } ];
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var got = _.mapOnly_( srcMap, screenMap );
  var expected = { 2 : 'abc', 1 : 33, 0 : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, [ { 0 : 'name' }, { 1 : 33 }, { 2 : 'abc' } ] );
  test.identical( screenMap, [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ] );

  test.close( 'srcMap - long' );
}

//

function _mapOnly( test )
{

  test.case = 'an object';
  var options = {};
  options.screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Mikle' };
  options.srcMaps = { 'a' : 33, 'd' : 'name', 'name' : 'Mikle', 'c' : 33 };
  var got = _._mapOnly( options );
  var expected = { a : 33, c : 33, name : 'Mikle' };
  test.identical( got, expected );

  test.case = 'an object2'
  var options = {};
  options.screenMaps = { a : 13, b : 77, c : 3, d : 'name' };
  options.srcMaps = { d : 'name', c : 33, a : 'abc' };
  var got = _._mapOnly( options );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _._mapOnly();
  });

  test.case = 'redundant arguments';
  test.shouldThrowErrorSync( function()
  {
    _._mapOnly( {}, 'wrong arguments' );
  });

  test.case = 'wrong type of array';
  test.shouldThrowErrorSync( function()
  {
    _._mapOnly( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _._mapOnly( 'wrong arguments' );
  });

}

//

function mapsAreIdentical( test )
{

  test.case = 'same values';
  var got = _.mapsAreIdentical( { a : 7, b : 13 }, { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.case = 'not the same values in'
  var got = _.mapsAreIdentical( { 'a' : 7, 'b' : 13 }, { 'a' : 7, 'b': 14 } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'different number of keys, more in the first argument'
  var got = _.mapsAreIdentical( { 'a' : 7, 'b' : 13, 'с' : 15 }, { 'a' : 7, 'b' : 13 } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'different number of keys, more in the second argument'
  var got = _.mapsAreIdentical( { 'a' : 7, 'b' : 13 }, { 'a' : 7, 'b' : 13, 'с' : 15 } );
  var expected = false;
  test.identical( got, expected );

  /* special cases */

  test.case = 'empty maps, standrard'
  var got = _.mapsAreIdentical( {}, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'empty maps, pure'
  var got = _.mapsAreIdentical( Object.create( null ), Object.create( null ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'empty maps, one standard another pure'
  var got = _.mapsAreIdentical( {}, Object.create( null ) );
  var expected = true;
  test.identical( got, expected );

  /* bad arguments */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical();
  });

  test.case = 'not object-like arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( [ 'a', 7, 'b', 13 ], [ 'a', 7, 'b', 14 ] );
  });
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( 'a','b' );
  });
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( 1,3 );
  });
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( null,null );
  });
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( undefined,undefined );
  });

  test.case = 'too few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( {} );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapsAreIdentical( {}, {}, 'redundant argument' );
  });

}

//

function mapContain( test )
{

  test.case = 'first has same keys like second';
  var got = _.mapContain( { a : 7, b : 13, c : 15 }, { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.case = 'in the array';
  var got = _.mapContain( [ 'a', 7, 'b', 13, 'c', 15 ], [ 'a', 7, 'b', 13 ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'number of keys in first not equal';
  var got = _.mapContain( { a : 1 }, { a : 1, b : 2 } );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapContain();
  });

  test.case = 'few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapContain( {} );
  });

  test.case = 'too many arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapContain( {}, {}, 'redundant argument' );
  });

}

//

function objectSatisfy( test ) 
{
  test.open( 'default option' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( template, src );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( template, src );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( template, src );
  test.identical( got, false );

  test.case = 'template is object, src identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( template, src );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( template, src );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( template, src );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( template, src );
  test.identical( got, true );

  /* */

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src } );
  test.identical( got, true );

  test.close( 'default option' );

  /* - */

  test.open( 'levels - 0' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var src = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0 } );
  test.identical( got, false );

  test.close( 'levels - 0' );

  /* - */

  test.open( 'levels - -1' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var src = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1 } );
  test.identical( got, false );

  test.close( 'levels - -1' );

  /* - */

  test.open( 'levels - 2' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var src = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : { identicalWith : identicalWith } }, b : 2, c : 3 };
  var src = { a : { val : { identicalWith : identicalWith } }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2 } );
  test.identical( got, true );

  test.close( 'levels - 2' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.objectSatisfy() );

  test.case = 'o.template is not an object or a routine';
  test.shouldThrowErrorSync( () => _.objectSatisfy( 'wrong', { a : 2 } ) );
  test.shouldThrowErrorSync( () => _.objectSatisfy( { template : 'wrong', src : { a : 2 } } ) );

  test.case = 'o.src is undefined';
  test.shouldThrowErrorSync( () => _.objectSatisfy( { a : 2 }, undefined ) );
  test.shouldThrowErrorSync( () => _.objectSatisfy( { template : { a : 2 }, src : undefined } ) );

  test.case = 'map o has wrong fields';
  test.shouldThrowErrorSync( () => _.objectSatisfy( { template : { a : 2 }, wrong : { a : 2 } } ) );
}

//

function objectSatisfyOptionStrict( test )
{
  test.open( 'default option levels' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, strict : 0 } );
  test.identical( got, true );

  test.close( 'default option levels' );

  /* - */

  test.open( 'levels - 0' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var src = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 0, strict : 0 } );
  test.identical( got, false );

  test.close( 'levels - 0' );

  /* - */

  test.open( 'levels - -1' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var src = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var src = { a : { val : 1, identicalWith : identicalWith }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : -1, strict : 0 } );
  test.identical( got, false );

  test.close( 'levels - -1' );

  /* - */

  test.open( 'levels - 2' );

  test.case = 'template === src, values - undefined';
  var template = { a : undefined, b : undefined, c : undefined };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.case = 'template === src';
  var template = { a : 1, b : 2, c : 3 };
  var src = template;
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.case = 'src is not an object';
  var template = { a : 1, b : 2, c : 3 };
  var src = 'wrong';
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, false );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template';
  var template = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : undefined, d : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src identical to template, without identicalWith';
  var template = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var src = { a : 1, b : 2, c : 3, identicalWith : identicalWith };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, without identicalWith';
  var template = { a : { val : 1 }, b : 2, c : 3 };
  var src = { a : { val : 1 }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.case = 'template is object, src not identical to template, values is objects, with identicalWith';
  var identicalWith = () => true;
  var template = { a : { val : { identicalWith : identicalWith } }, b : 2, c : 3 };
  var src = { a : { val : { identicalWith : identicalWith } }, b : 2, c : 3 };
  var got = _.objectSatisfy( { template : template, src : src, levels : 2, strict : 0 } );
  test.identical( got, true );

  test.close( 'levels - 2' );
}

//

function mapOwnKey( test )
{

  test.case = 'second argument is string';
  var got = _.mapOwnKey( { a : 7, b : 13 }, 'a' );
  var expected = true;
  test.identical( got, expected );

  test.case = 'second argument is object';
  var got = _.mapOwnKey( { a : 7, b : 13 }, Object.create( null ).a = 'a' );
  var expected = true;
  test.identical( got, expected );

  test.case = 'second argument is symbol';
  var symbol = Symbol( 'b' ), obj = { a : 7, [ symbol ] : 13 };
  var got = _.mapOwnKey( obj, symbol );
  var expected = true;
  test.identical( got, expected );

  test.case = 'false';
  var got = _.mapOwnKey( Object.create( { a : 7, b : 13 } ), 'a' );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKey();
  });

  test.case = 'few arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKey( {}, 'a', 'b' );
  });

  test.case = 'wrong type of key';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKey( [], 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKey( 1 );
  });

  test.case = 'wrong type of second argument';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKey( {}, 13 );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.mapOwnKey( '', 7 );
  });

}

//

function mapHasAll( test )
{
  test.case = 'empty';
  var got = _.mapHasAll( {}, {} );
  test.is( got );

  test.case = 'screen empty';
  var got = _.mapHasAll( { a : 1 }, {} );
  test.is( got );

  test.case = 'same keys';
  var got = _.mapHasAll( { a : 1 }, { a : 2 } );
  test.is( got );

  test.case = 'has only one';
  var got = _.mapHasAll( { a : 1, b : 2, c :  3 }, { b : 2 } );
  test.is( got );

  test.case = 'has all';
  var got = _.mapHasAll( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.is( got );

  test.case = 'one is mising';
  var got = _.mapHasAll( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.is( !got );

  test.case = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAll( a, { a : 1 } );
  test.is( got );

  var got = _.mapHasAll( a, a );
  test.is( got );

  test.case = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapHasAll( src, screen );
  test.is( got );

  test.case = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAll( a, { a : undefined } );
  test.is( got );

  var got = _.mapHasAll( { a : undefined }, { a : undefined } );
  test.is( got );

  test.case = 'src has toString on proto';
  var got = _.mapHasAll( {}, { toString : 1 } );
  test.is( got );

  test.case = 'map has on proto';
  var a = {};
  var b = { a : 1 };
  Object.setPrototypeOf( a, b );
  var got = _.mapHasAll( a, { a : 1 } );
  test.is( got );

  //

  if( Config.degub )
  {
    test.case = 'src is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasAll( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasAll( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasAll( {}, {}, {} );
    });
  }

}

//

function mapHasAny( test )
{
  test.case = 'empty';
  var got = _.mapHasAny( {}, {} );
  test.is( !got );

  test.case = 'screen empty';
  var got = _.mapHasAny( { a : 1 }, {} );
  test.is( !got );

  test.case = 'same keys';
  var got = _.mapHasAny( { a : 1 }, { a : 2 } );
  test.is( got );

  test.case = 'has only one';
  var got = _.mapHasAny( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.is( got );

  test.case = 'has all';
  var got = _.mapHasAny( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.is( got );

  test.case = 'one is mising';
  var got = _.mapHasAny( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.is( got );

  test.case = 'has no one';
  var got = _.mapHasAny( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.is( !got );

  test.case = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAny( a, { a : 1 } );
  test.is( got );

  var got = _.mapHasAny( a, a );
  test.is( !got );

  test.case = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapHasAny( src, screen );
  test.is( !got );

  test.case = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasAny( a, { a : undefined } );
  test.is( got );

  var got = _.mapHasAny( { a : undefined }, { a : undefined } );
  test.is( got );

  test.case = 'src has toString on proto';
  var got = _.mapHasAny( {}, { x : 1, toString : 1 } );
  test.is( got );

  test.case = 'map has on proto';
  var a = {};
  var b = { a : 1 };
  Object.setPrototypeOf( a, b );
  var got = _.mapHasAny( a, { a : 1, x : 1 } );
  test.is( got );

  //

  if( Config.degub )
  {
    test.case = 'src is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasAny( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasAny( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasAny( {}, {}, {} );
    });
  }

}

//

function mapHasNone( test )
{
  test.case = 'empty';
  var got = _.mapHasNone( {}, {} );
  test.is( got );

  test.case = 'screen empty';
  var got = _.mapHasNone( { a : 1 }, {} );
  test.is( got );

  test.case = 'same keys';
  var got = _.mapHasNone( { a : 1 }, { a : 2 } );
  test.is( !got );

  test.case = 'has only one';
  var got = _.mapHasNone( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.is( !got );

  test.case = 'has all';
  var got = _.mapHasNone( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.is( !got );

  test.case = 'one is mising';
  var got = _.mapHasNone( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.is( !got );

  test.case = 'has no one';
  var got = _.mapHasNone( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.is( got );

  test.case = 'src has non enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasNone( a, { a : 1 } );
  test.is( !got );

  var got = _.mapHasNone( a, a );
  test.is( got );

  test.case = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapHasNone( src, screen );
  test.is( got );

  test.case = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapHasNone( a, { a : undefined } );
  test.is( !got );

  var got = _.mapHasNone( { a : undefined }, { a : undefined } );
  test.is( !got );

  test.case = 'src has toString on proto';
  var got = _.mapHasNone( {}, { x : 1, toString : 1 } );
  test.is( !got );

  test.case = 'map has on proto';
  var a = {};
  var b = { a : 1 };
  Object.setPrototypeOf( a, b );

  var got = _.mapHasNone( a, { x : 1 } );
  test.is( got );

  var got = _.mapHasNone( a, { a : 1 } );
  test.is( !got );

  //

  if( Config.degub )
  {
    test.case = 'src is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasNone( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasNone( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowErrorSync( function()
    {
      _.mapHasNone( {}, {}, {} );
    });
  }

}

//

function mapOwnAll( test )
{
  test.case = 'empty';
  var got = _.mapOwnAll( {}, {} );
  test.is( got );

  test.case = 'screen empty';
  var got = _.mapOwnAll( { a : 1 }, {} );
  test.is( got );

  test.case = 'same keys';
  var got = _.mapOwnAll( { a : 1 }, { a : 2 } );
  test.is( got );

  test.case = 'has only one';
  var got = _.mapOwnAll( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.is( !got );

  test.case = 'has all';
  var got = _.mapOwnAll( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.is( got );

  test.case = 'one is mising';
  var got = _.mapOwnAll( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.is( !got );

  test.case = 'has no one';
  var got = _.mapOwnAll( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.is( !got );

  test.case = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAll( a, { a : 1 } );
  test.is( got );

  var got = _.mapOwnAll( a, a );
  test.is( got );

  test.case = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapOwnAll( src, screen );
  test.is( got );

  test.case = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAll( a, { a : undefined } );
  test.is( got );

  var got = _.mapOwnAll( { a : undefined }, { a : undefined } );
  test.is( got );

  test.case = 'src has toString on proto';
  var got = _.mapOwnAll( {}, { x : 1, toString : 1 } );
  test.is( !got );

  //

  if( Config.degub )
  {
    test.case = 'src is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnAll( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnAll( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnAll( {}, {}, {} );
    });

    test.case = 'src is not a map';
    test.shouldThrowErrorSync( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAll( a,{ a : 1 } );
    });

    test.case = 'screen is not a map';
    test.shouldThrowErrorSync( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAll( { a : 1 }, a );
    });
  }

}

//

function mapOwnAny( test )
{
  test.case = 'empty';
  var got = _.mapOwnAny( {}, {} );
  test.is( !got );

  test.case = 'screen empty';
  var got = _.mapOwnAny( { a : 1 }, {} );
  test.is( !got );

  test.case = 'same keys';
  var got = _.mapOwnAny( { a : 1 }, { a : 2 } );
  test.is( got );

  test.case = 'has only one';
  var got = _.mapOwnAny( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.is( got );

  test.case = 'has all';
  var got = _.mapOwnAny( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.is( got );

  test.case = 'one is mising';
  var got = _.mapOwnAny( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.is( got );

  test.case = 'has no one';
  var got = _.mapOwnAny( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.is( !got );

  test.case = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAny( a, { a : 1 } );
  test.is( got );

  var got = _.mapOwnAny( a, a );
  test.is( !got );

  test.case = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapOwnAny( src, screen );
  test.is( !got );

  test.case = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnAny( a, { a : undefined } );
  test.is( got );

  var got = _.mapOwnAny( { a : undefined }, { a : undefined } );
  test.is( got );

  test.case = 'src has toString on proto';
  var got = _.mapOwnAny( {}, { x : 1, toString : 1 } );
  test.is( !got );

  //

  if( Config.degub )
  {
    test.case = 'src is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnAny( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnAny( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnAny( {}, {}, {} );
    });

    test.case = 'src is not a map';
    test.shouldThrowErrorSync( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAny( a,{ a : 1 } );
    });

    test.case = 'screen is not a map';
    test.shouldThrowErrorSync( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAny( { a : 1 }, a );
    });
  }

}

//

function mapOwnNone( test )
{
  test.case = 'empty';
  var got = _.mapOwnNone( {}, {} );
  test.is( got );

  test.case = 'screen empty';
  var got = _.mapOwnNone( { a : 1 }, {} );
  test.is( got );

  test.case = 'same keys';
  var got = _.mapOwnNone( { a : 1 }, { a : 2 } );
  test.is( !got );

  test.case = 'has only one';
  var got = _.mapOwnNone( { a : 1, b : 2, c :  3 }, { b : 2, x : 1 } );
  test.is( !got );

  test.case = 'has all';
  var got = _.mapOwnNone( { a : 1, b : 2, c :  3 }, { b : 2, a : 3, c : 4 } );
  test.is( !got );

  test.case = 'one is mising';
  var got = _.mapOwnNone( { a : 1, b : 2 }, { b : 2, a : 3, c : 1 } );
  test.is( !got );

  test.case = 'has no one';
  var got = _.mapOwnNone( { a : 1, b : 2 }, { x : 1, y : 1} );
  test.is( got );

  test.case = 'src has enumerable';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnNone( a, { a : 1 } );
  test.is( !got );

  var got = _.mapOwnNone( a, a );
  test.is( got );

  test.case = 'screen has enumerable';

  /* for..in skips enumerable */
  var src = { a : 1 };
  var screen = {};
  Object.defineProperty( screen, 'a',{ enumerable : 0, value : 3 } );
  var got = _.mapOwnNone( src, screen );
  test.is( got );

  test.case = 'screen has undefined';
  var a = {};
  Object.defineProperty( a, 'a',{ enumerable : 0 } );

  var got = _.mapOwnNone( a, { a : undefined } );
  test.is( !got );

  var got = _.mapOwnNone( { a : undefined }, { a : undefined } );
  test.is( !got );

  test.case = 'src has toString on proto';
  var got = _.mapOwnNone( {}, { x : 1, toString : 1 } );
  test.is( got );

  //

  if( Config.degub )
  {
    test.case = 'src is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnNone( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnNone( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowErrorSync( function()
    {
      _.mapOwnNone( {}, {}, {} );
    });

    test.case = 'src is not a map';
    test.shouldThrowErrorSync( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnNone( a,{ a : 1 } );
    });

    test.case = 'screen is not a map';
    test.shouldThrowErrorSync( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnNone( { a : 1 }, a );
    });
  }

}

// --
// sure
// --

function sureMapHasExactly( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapHasExactly( srcMap, screenMap ), true );
  test.identical( _.sureMapHasExactly( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapHasExactly( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapHasExactly( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapHasExactly( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasExactly( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasExactly( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasExactly( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasExactly( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasExactly( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapOwnExactly( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapOwnExactly( srcMap, screenMap ), true );
  test.identical( _.sureMapOwnExactly( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapOwnExactly( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapOwnExactly( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapOwnExactly( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnExactly( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnExactly( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnExactly( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnExactly( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnExactly( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapHasOnly( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapHasOnly( srcMap, screenMap ), true );
  test.identical( _.sureMapHasOnly( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapHasOnly( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapHasOnly( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapHasOnly( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasOnly( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasOnly( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasOnly( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasOnly( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasOnly( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapOwnOnly( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapOwnOnly( srcMap, screenMap ), true );
  test.identical( _.sureMapOwnOnly( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapOwnOnly( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapOwnOnly( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapOwnOnly( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnOnly( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnOnly( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnOnly( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnOnly( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnOnly( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapHasAll( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapHasAll( srcMap, screenMap ), true );
  test.identical( _.sureMapHasAll( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapHasAll( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapHasAll( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapHasAll( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have fields : "name"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasAll( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "name"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasAll( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "name"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasAll( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "name"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasAll( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "name"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasAll( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapOwnAll( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapOwnAll( srcMap, screenMap ), true );
  test.identical( _.sureMapOwnAll( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapOwnAll( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapOwnAll( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapOwnAll( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own fields : "name"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnAll( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "name"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnAll( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "name"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnAll( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "name"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnAll( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "name"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnAll( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapHasNone( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'e' : 13, 'f' : 77, 'g' : 3, 'h' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapHasNone( srcMap, screenMap ), true );
  test.identical( _.sureMapHasNone( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapHasNone( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapHasNone( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapHasNone( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no fields : "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasNone( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasNone( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "a", "b", "c"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasNone( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasNone( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "a", "b", "c"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapHasNone( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapOwnNone( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'e' : 13, 'f' : 77, 'g' : 3, 'h' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.sureMapOwnNone( srcMap, screenMap ), true );
  test.identical( _.sureMapOwnNone( srcMap, screenMap, msg ), true );
  test.identical( _.sureMapOwnNone( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.sureMapOwnNone( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.sureMapOwnNone( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own no fields : "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnNone( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnNone( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "a", "b", "c"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnNone( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnNone( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "a", "b", "c"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.sureMapOwnNone( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

// --
// assert
// --

function assertMapHasFields( test )
{
  var err;

  // in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    test.case = 'Config.debug === false';
    var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
    var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
    test.identical( _.assertMapHasFields( srcMap, screenMaps ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.assertMapHasFields( srcMap, screenMap ), true );
  test.identical( _.assertMapHasFields( srcMap, screenMap, msg ), true );
  test.identical( _.assertMapHasFields( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.assertMapHasFields( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.assertMapHasFields( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasFields( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasFields( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasFields( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasFields( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasFields( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function assertMapOwnFields( test )
{
  var err;

// in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
    var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
    test.identical( _.assertMapOwnFields( srcMap, screenMaps ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.assertMapOwnFields( srcMap, screenMap ), true );
  test.identical( _.assertMapOwnFields( srcMap, screenMap, msg ), true );
  test.identical( _.assertMapOwnFields( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.assertMapOwnFields( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.assertMapOwnFields( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnFields( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnFields( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnFields( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnFields( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnFields( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function assertMapHasOnly( test )
{
  var err;

// in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    test.case = 'Config.debug === false';
    var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
    var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
    test.identical( _.assertMapHasOnly( srcMap, screenMaps ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.assertMapHasOnly( srcMap, screenMap ), true );
  test.identical( _.assertMapHasOnly( srcMap, screenMap, msg ), true );
  test.identical( _.assertMapHasOnly( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.assertMapHasOnly( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.assertMapHasOnly( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasOnly( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasOnly( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasOnly( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasOnly( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasOnly( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function assertMapOwnOnly( test )
{
  var err;

// in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    test.case = 'Config.debug === false';
    var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
    var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
    test.identical( _.assertMapOwnOnly( srcMap, screenMaps ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.assertMapOwnOnly( srcMap, screenMap ), true );
  test.identical( _.assertMapOwnOnly( srcMap, screenMap, msg ), true );
  test.identical( _.assertMapOwnOnly( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.assertMapOwnOnly( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.assertMapOwnOnly( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own no fields : "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnOnly( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnOnly( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnOnly( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnOnly( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnOnly( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function assertMapHasNone( test )
{
  var err;

// in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    test.case = 'Config.debug === false';
    var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
    var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
    test.identical( _.assertMapHasNone( srcMap, screenMaps ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'e' : 13, 'f' : 77, 'g' : 3, 'h' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.assertMapHasNone( srcMap, screenMap ), true );
  test.identical( _.assertMapHasNone( srcMap, screenMap, msg ), true );
  test.identical( _.assertMapHasNone( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.assertMapHasNone( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.assertMapHasNone( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no fields : "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasNone( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasNone( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "a", "b", "c"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasNone( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasNone( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "a", "b", "c"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapHasNone( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function assertMapOwnNone( test )
{
  var err;

// in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    test.case = 'Config.debug === false';
    var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
    var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
    test.identical( _.assertMapOwnNone( srcMap, screenMaps ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMap = { 'e' : 13, 'f' : 77, 'g' : 3, 'h' : 'Mikle' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  test.identical( _.assertMapOwnNone( srcMap, screenMap ), true );
  test.identical( _.assertMapOwnNone( srcMap, screenMap, msg ), true );
  test.identical( _.assertMapOwnNone( srcMap, screenMap, msg, 'msg' ), true );
  test.identical( _.assertMapOwnNone( srcMap, screenMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  try
  {
    _.assertMapOwnNone( srcMap, screenMaps )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should own no fields : "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnNone( srcMap, screenMaps, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg string';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnNone( srcMap, screenMaps, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "a", "b", "c"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnNone( srcMap, screenMaps, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "a", "b", "c"' ), true );

  test.case = 'check error message, msg routine';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnNone( srcMap, screenMaps, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "a", "b", "c"' ), true );

  test.case = 'check error message, five or more arguments';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var screenMaps = { 'a' : 13, 'b' : 77, 'c' : 3, 'name' : 'Hello' };
  var msg = function(){ return srcMap.a + screenMaps.b };
  try
  {
    _.assertMapOwnNone( srcMap, screenMaps, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects two, three or four arguments' ), true );
}

//

function sureMapHasNoUndefine( test )
{
  var err;

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + srcMap.b };
  test.identical( _.sureMapHasNoUndefine( srcMap), true );
  test.identical( _.sureMapHasNoUndefine( srcMap, msg ), true );
  test.identical( _.sureMapHasNoUndefine( srcMap, msg, 'msg' ), true );
  test.identical( _.sureMapHasNoUndefine( srcMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var otherMap = { 'd' : undefined };
  try
  {
    _.sureMapHasNoUndefine( otherMap )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no undefines, but has : "d"' ), true );

  test.case = 'check error message, msg routine';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.sureMapHasNoUndefine( otherMap, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var otherMap = { 'd' : undefined };
  try
  {
    _.sureMapHasNoUndefine( otherMap, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.sureMapHasNoUndefine( otherMap, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.sureMapHasNoUndefine( otherMap, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, four or more arguments';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.sureMapHasNoUndefine( srcMap, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects one, two or three arguments' ), true );
}

//

function assertMapHasNoUndefine( test )
{
  var err;

// in normal mode this test should throw error. The routine return true when Config.debug === false
  if( !Config.debug )
  {
    test.case = 'Config.debug === false';
    var otherMap = { 'd' : undefined };
    test.identical( _.assertMapHasNoUndefine( otherMap ), true );
  }

  test.case = 'correct input';
  var srcMap = { 'a' : 13, 'b' : 77, 'c' : 3, 'd' : 'Mikle' };
  var msg = function(){ return srcMap.a + srcMap.b };
  test.identical( _.assertMapHasNoUndefine( srcMap), true );
  test.identical( _.assertMapHasNoUndefine( srcMap, msg ), true );
  test.identical( _.assertMapHasNoUndefine( srcMap, msg, 'msg' ), true );
  test.identical( _.assertMapHasNoUndefine( srcMap, () => 'This is ' + 'explanation' ), true );

  test.case = 'check error message, no msg';
  var otherMap = { 'd' : undefined };
  try
  {
    _.assertMapHasNoUndefine( otherMap )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Object should have no undefines, but has : "d"' ), true );

  test.case = 'check error message, msg routine';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.assertMapHasNoUndefine( otherMap, msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, '90 "d"' ), true );

  test.case = 'check error message, msg string';
  var otherMap = { 'd' : undefined };
  try
  {
    _.assertMapHasNoUndefine( otherMap, 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg "d"' ), true );

  test.case = 'check error message, msg string & msg routine';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.assertMapHasNoUndefine( otherMap, 'msg', msg )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'msg 90 "d"' ), true );

  test.case = 'check error message, msg routine';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.assertMapHasNoUndefine( otherMap, () => 'This is ' + 'explanation' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'This is explanation "d"' ), true );

  test.case = 'check error message, four or more arguments';
  var otherMap = { 'd' : undefined };
  var msg = function(){ return srcMap.a + srcMap.b };
  try
  {
    _.assertMapHasNoUndefine( srcMap, msg, 'msg', 'msg' )
  }
  catch ( e )
  {
    err = e;
  }
  test.identical( err instanceof Error, true );
  test.identical( _.strHas( err.message, 'Expects one, two or three arguments' ), true );
}

// --
// define test suite
// --

var Self =
{

  name : 'Tools.base.Map',
  silencing : 1,

  tests :
  {

    // map checker l0/l3/iMap.s

    iterableIs,

    mapIs,

    // map move

    mapCloneAssigning,

    mapExtendConditional,
    mapExtend,
    mapSupplement,
    mapComplement,

    mapMake,
    mapMakeBugWithArray,

    // map manipulator

    objectSetWithKeys,
    objectSetWithKeyStrictly,
    mapDelete,
    mapEmpty,

    // map convert

    mapsFlatten,

    mapFirstPair,
    mapValWithIndex,
    mapKeyWithIndex,
    mapToArray,
    mapToStr,

    // map properties

    mapKeys,
    mapOwnKeys,
    mapAllKeys,

    mapVals,
    mapOwnVals,
    mapAllVals,

    mapPairs,
    mapOwnPairs,
    mapAllPairs,

    mapProperties,
    mapOwnProperties,
    mapAllProperties,

    mapRoutines,
    mapOwnRoutines,
    mapAllRoutines,

    mapFields,
    mapOwnFields,
    mapAllFields,

    // hash map 

    hashMapExtend,

    // map selector

    mapOnlyPrimitives,

    // map logic

    mapButConditional,

    mapButConditionalThreeArguments_,
    mapButConditionalDstMapNull_,
    mapButConditionalDstMapMap_,

    mapBut,

    mapButTwoArguments_,
    mapButDstMapNull_,
    mapButDstMapMap_,

    mapButIgnoringUndefinesThreeArguments_,
    mapButIgnoringUndefinesDstMapNull_,
    mapButIgnoringUndefinesDstMapMap_,

    mapOwnBut,

    mapOwnButThreeArguments_,
    mapOwnButDstMapNull_,
    mapOwnButDstMapMap_,

    mapOnly,

    mapOnlyTwoArguments_,

    _mapOnly,

    mapsAreIdentical,
    mapContain,
    
    objectSatisfy,
    objectSatisfyOptionStrict,

    mapOwnKey,

    mapHasAll,
    mapHasAny,
    mapHasNone,

    mapOwnAll,
    mapOwnAny,
    mapOwnNone,

    // test sureMap*

    sureMapHasExactly,
    sureMapOwnExactly,

    sureMapHasOnly,
    sureMapOwnOnly,

    sureMapHasAll,
    sureMapOwnAll,

    sureMapHasNone,
    sureMapOwnNone,

    // test assertMap*

    assertMapHasFields,
    assertMapOwnFields,

    assertMapHasOnly,
    assertMapOwnOnly,

    assertMapHasNone,
    assertMapOwnNone,

    sureMapHasNoUndefine,
    assertMapHasNoUndefine,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
