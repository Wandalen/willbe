( function _Map_test_s( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
}

var _global = _global_;
var _ = _global_.wTools;

//

function mapIs( test )
{

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

  test.case = 'a string';
  var got = _.mapIs( Object.create( { a : 7 } ) );
  var expected = false;
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
  var got = _.mapCloneAssigning({ srcMap : srcMap, dstMap : dstMap });
  var expected = { sex : 'Male', name : 'Peter', age : 27 };
  test.is( dstMap === got );
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapCloneAssigning();
  });

  test.case = 'redundant argument';
  test.shouldThrowError( function()
  {
    _.mapCloneAssigning( {}, {}, 'wrong arguments' );
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapCloneAssigning( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapCloneAssigning( 'wrong arguments' );
  });

}

//

function mapExtendConditional( test )
{

  test.case = 'an unique object';
  debugger;
  var got = _.mapExtendConditional( _.field.mapper.dstNotHas, { a : 1, b : 2 }, { a : 1 , c : 3 } );
  var expected = { a : 1, b : 2, c : 3 };
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional();
  });

  test.case = 'few argument';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional( _.field.mapper.dstNotHas );
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapExtendConditional( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapExtend();
  });

  test.case = 'few arguments';
  test.shouldThrowError( function()
  {
    _.mapExtend( {} );
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapExtend( [] );
  });

  test.case = 'wrong type of number';
  test.shouldThrowError( function()
  {
    _.mapExtend( 13 );
  });

  test.case = 'wrong type of boolean';
  test.shouldThrowError( function()
  {
    _.mapExtend( true );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapSupplement();
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapSupplement( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapComplement();
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapComplement( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapComplement( 'wrong arguments' );
  });

}

//

function mapMake( test )
{

  test.case = 'empty'; /**/

  var got = _.mapMake();
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );

  var got = _.mapMake( null );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );

  var got = _.mapMake( undefined );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );

  test.case = 'empty map'; /**/

  var src1 = {};
  var src1Copy = _.mapExtend( null, src1 );
  var got = _.mapMake( src1 );
  var expected = {};
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.identical( src1, src1Copy );
  test.is( got !== src1 );

  test.case = 'single map'; /**/

  var src1 = { a : 7, b : 13 };
  var src1Copy = _.mapExtend( null, src1 );
  var got = _.mapMake( src1 );
  var expected = { a : 7, b : 13 };
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.identical( src1, src1Copy );
  test.is( got !== src1 );

  test.case = 'trivial'; /**/

  var src1 = { a : 7, b : 13 };
  var src2 = { a : 77, c : 3, d : 33 };
  var src3 = { a : 'x', e : 77 };
  var src1Copy = _.mapExtend( null, src1 );
  var src2Copy = _.mapExtend( null, src2 );
  var src3Copy = _.mapExtend( null, src3 );
  var got = _.mapMake( src1, src2, src3 );
  var expected = { a : 'x', b : 13, c : 3, d : 33, e : 77 };
  test.identical( got, expected );
  test.is( _.mapIsPure( got ) );
  test.identical( src1, src1Copy );
  test.identical( src2, src2Copy );
  test.identical( src3, src3Copy );
  test.is( got !== src1 );
  test.is( got !== src2 );
  test.is( got !== src3 );

  /* */

  test.case = 'bad arguments'; /**/

  test.shouldThrowError( function()
  {
    _.mapMake( '' );
  });

  test.case = 'bad arguments'; /**/

  test.shouldThrowError( function()
  {
    _.mapMake( 'x' );
  });

  test.case = 'bad arguments'; /**/

  test.shouldThrowError( function()
  {
    _.mapMake( null, 'x' );
  });

  test.case = 'bad arguments'; /**/

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
  test.shouldThrowError( function()
  {
    _.mapFirstPair();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function() {
    _.mapValWithIndex();
  });

  test.case = 'few argument';
  test.shouldThrowError( function()
  {
    _.mapValWithIndex( [ [] ] );
  });

  test.case = 'first the four argument not wrapped into array';
  test.shouldThrowError( function()
  {
    _.mapValWithIndex( 3, 13, 'c', 7 , 2 );
  });

  test.case = 'redundant argument';
  test.shouldThrowError( function()
  {
    _.mapValWithIndex( [ [] ], 2, 'wrong arguments' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapKeyWithIndex();
  });

  test.case = 'few arguments';
  test.shouldThrowError( function()
  {
    _.mapKeyWithIndex( [] );
  });

  test.case = 'redundant argument';
  test.shouldThrowError( function()
  {
    _.mapKeyWithIndex( [  ], 2, 'wrong arguments' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapKeyWithIndex( 'wrong argumetns' );
  });

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
  test.shouldThrowError( function()
  {
    _.mapToStr();
  });

  test.case = 'wrong type of number';
  test.shouldThrowError( function()
  {
    _.mapToStr( 13 );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapToStr( true );
  });

}

//

function mapsFlatten2( test )
{

  test.case = 'trivial';

  let expected = { a : 1, 'b.c' : 1, 'b.d' : 1, e : 2, 'f.g.h' : 2 }
  debugger;
  let got = _.mapsFlatten2([ { a : 1, b : { c : 1, d : 1 } }, { e : 2, f : { g : { h : 2 } } } ]);
  debugger;
  test.identical( got, expected );

}

//

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
  test.shouldThrowError( function()
  {
    _.mapKeys();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapKeys( 'wrong arguments' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
  {
    debugger;
    _.mapKeys.call( { x : 1 }, {} );
    debugger;
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
  test.shouldThrowError( function()
  {
    _.mapOwnKeys();
  })

  test.case = 'invalid type';
  test.shouldThrowError( function()
  {
    _.mapOwnKeys( 1 );
  })

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapAllKeys();
  })

  test.case = 'invalid argument';
  test.shouldThrowError( function()
  {
    _.mapAllKeys();
  })

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapVals();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapVals( 'wrong argument' );
  });

  test.case = 'wrong option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapOwnVals();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapOwnVals( 'wrong argument' );
  });

  test.case = 'wrong option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapAllVals();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapAllVals( 'wrong argument' );
  });

  test.case = 'wrong option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapPairs();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapPairs( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapPairs( 'wrong argument' );
  });

  test.case = 'redundant argument';
  test.shouldThrowError( function()
  {
    _.mapPairs( {}, 'wrong arguments' );
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapOwnPairs();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapOwnPairs( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapAllPairs();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapAllPairs( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapProperties();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapProperties( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapProperties( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapOwnProperties();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapOwnProperties( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapOwnProperties( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapAllProperties();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapAllProperties( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapAllProperties( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapRoutines();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapRoutines( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapRoutines( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapOwnRoutines();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapOwnRoutines( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapOwnRoutines( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapAllRoutines();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapAllRoutines( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapAllRoutines( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapFields();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapFields( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapFields( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapOwnFields();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapOwnFields( 'x' );
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapOwnFields( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapOwnFields( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapAllFields();
  });

  test.case = 'primitive';
  test.shouldThrowError( function()
  {
    _.mapAllFields( 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapAllFields( 'wrong argument' );
  });

  test.case = 'unknown option';
  test.shouldThrowError( function()
  {
    _.mapAllFields.call( { x : 1 }, {} );
  });

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
    j : new ArrayBuffer( 5 )
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
  test.shouldThrowError( function()
  {
    _.mapOnlyPrimitives( null )
  });

  test.case = 'no args';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.mapButConditional();
  });

  test.case = 'few arguments';
  test.shouldThrowError( function()
  {
    _.mapButConditional( _.field.mapper.primitive );
  });

  test.case = 'second argument is wrong type of array';
  test.shouldThrowError( function()
  {
    _.mapButConditional( _.field.mapper.primitive, [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapButConditional( 'wrong arguments' );
  });

}

//

function mapBut( test )
{

  test.case = 'empty src map'; /* */

  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'empty src array'; /* */

  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var srcMapCopy = srcMap.slice();
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'empty screen'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = {};
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapBut( srcMap, screenMap );
  var expected = { d : 'name', c : 33, a : 'abc' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'trivial'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  var srcMap = { d : 'name', c : 33, a : 'abc', x : 13 };
  var screenMap = { b : 77, c : 3, d : 'name' };
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapBut( srcMap, screenMap );
  var expected = { a : 'abc', x : 13 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'several screens'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = screenMap.slice();
  var got = _.mapBut( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'several srcs'; /* */

  var srcMap = [ { a : 1 }, { b : 1 }, { c : 1 } ];
  var screenMap = { a : 2, b : 2, d : 2 };
  var srcMapCopy = srcMap.slice();
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapBut( srcMap, screenMap );
  var expected = { c :1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'several srcs and screens'; /* */

  var srcMap = [ { a : 1 }, { b : 1 }, { c : 1 } ];
  var screenMap = [ { a : 2 }, { b : 2 }, { d : 2 } ];
  var srcMapCopy = srcMap.slice();
  var screenMapCopy = screenMap.slice();
  var got = _.mapBut( srcMap, screenMap );
  var expected = { c : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapBut();
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapBut( 'wrong arguments' );
  });

  test.case = 'only src map';
  test.shouldThrowError( function()
  {
    _.mapBut( srcMap );
  });

  test.case = 'first argument is not an object-like';
  test.shouldThrowError( function()
  {
    _.mapBut( 3, [] );
  });

  test.case = 'second argument is not an object-like';
  test.shouldThrowError( function()
  {
    _.mapBut( [], '' );
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.mapBut( [], [], {} );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapBut( {}, 'wrong arguments' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapBut( 'wrong arguments', {} );
  });

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
  test.shouldThrowError( function()
  {
    _.mapOwnBut();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.mapOwnBut( {} );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.mapOwnBut( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapOwnBut( 'wrong arguments' );
  });

}

//

function mapOnly( test )
{

  test.case = 'empty src map'; /* */

  var srcMap = {};
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'empty src array'; /* */

  var srcMap = [];
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var srcMapCopy = srcMap.slice();
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'empty screen'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = {};
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapOnly( srcMap, screenMap );
  var expected = {};
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'only srcMap'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var srcMapCopy = _.mapExtend( null, srcMap );
  var got = _.mapOnly( srcMap );
  var expected = { d : 'name', c : 33, a : 'abc' };
  test.identical( got, expected );
  test.is( got !== srcMap );

  test.case = 'trivial'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = { a : 13, b : 77, c : 3, d : 'name' };
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'several screens'; /* */

  var srcMap = { d : 'name', c : 33, a : 'abc' };
  var screenMap = [ { a : 13 }, { b : 77 }, { c : 3 }, { d : 'name' } ];
  var srcMapCopy = _.mapExtend( null, srcMap );
  var screenMapCopy = screenMap.slice();
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 'abc', c : 33, d : 'name' };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'several srcs'; /* */

  var srcMap = [ { a : 1 }, { b : 1 }, { c : 1 } ];
  var screenMap = { a : 2, b : 2, d : 2 };
  var srcMapCopy = srcMap.slice();
  var screenMapCopy = _.mapExtend( null, screenMap );
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 1, b : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  test.case = 'several srcs and screens'; /* */

  var srcMap = [ { a : 1 }, { b : 1 }, { c : 1 } ];
  var screenMap = [ { a : 2 }, { b : 2 }, { d : 2 } ];
  var srcMapCopy = srcMap.slice();
  var screenMapCopy = screenMap.slice();
  var got = _.mapOnly( srcMap, screenMap );
  var expected = { a : 1, b : 1 };
  test.identical( got, expected );
  test.is( got !== srcMap );
  test.identical( srcMap, srcMapCopy );
  test.identical( screenMap, screenMapCopy );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapOnly();
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapOnly( 'wrong arguments' );
  });

  test.case = 'first argument is not an object-like';
  test.shouldThrowError( function()
  {
    _.mapOnly( 3, [] );
  });

  test.case = 'second argument is not an object-like';
  test.shouldThrowError( function()
  {
    _.mapOnly( [], '' );
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.mapOnly( [], [], {} );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapOnly( {}, 'wrong arguments' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.mapOnly( 'wrong arguments', {} );
  });

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
  test.shouldThrowError( function()
  {
    _._mapOnly();
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _._mapOnly( {}, 'wrong arguments' );
  });

  test.case = 'wrong type of array';
  test.shouldThrowError( function()
  {
    _._mapOnly( [] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _._mapOnly( 'wrong arguments' );
  });

}

//

function mapIdentical( test )
{

  test.case = 'same values';
  var got = _.mapIdentical( { a : 7, b : 13 }, { a : 7, b : 13 } );
  var expected = true;
  test.identical( got, expected );

  test.case = 'not the same values in'
  var got = _.mapIdentical( { 'a' : 7, 'b' : 13 }, { 'a' : 7, 'b': 14 } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'different number of keys, more in the first argument'
  var got = _.mapIdentical( { 'a' : 7, 'b' : 13, 'с' : 15 }, { 'a' : 7, 'b' : 13 } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'different number of keys, more in the second argument'
  var got = _.mapIdentical( { 'a' : 7, 'b' : 13 }, { 'a' : 7, 'b' : 13, 'с' : 15 } );
  var expected = false;
  test.identical( got, expected );

  /* special cases */

  test.case = 'empty maps, standrard'
  var got = _.mapIdentical( {}, {} );
  var expected = true;
  test.identical( got, expected );

  test.case = 'empty maps, pure'
  var got = _.mapIdentical( Object.create( null ), Object.create( null ) );
  var expected = true;
  test.identical( got, expected );

  test.case = 'empty maps, one standard another pure'
  var got = _.mapIdentical( {}, Object.create( null ) );
  var expected = true;
  test.identical( got, expected );

  /* bad arguments */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.mapIdentical();
  });

  test.case = 'not object-like arguments';
  test.shouldThrowError( function()
  {
    _.mapIdentical( [ 'a', 7, 'b', 13 ], [ 'a', 7, 'b', 14 ] );
  });
  test.shouldThrowError( function()
  {
    _.mapIdentical( 'a','b' );
  });
  test.shouldThrowError( function()
  {
    _.mapIdentical( 1,3 );
  });
  test.shouldThrowError( function()
  {
    _.mapIdentical( null,null );
  });
  test.shouldThrowError( function()
  {
    _.mapIdentical( undefined,undefined );
  });

  test.case = 'too few arguments';
  test.shouldThrowError( function()
  {
    _.mapIdentical( {} );
  });

  test.case = 'too many arguments';
  test.shouldThrowError( function()
  {
    _.mapIdentical( {}, {}, 'redundant argument' );
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
  test.shouldThrowError( function()
  {
    _.mapContain();
  });

  test.case = 'few arguments';
  test.shouldThrowError( function()
  {
    _.mapContain( {} );
  });

  test.case = 'too many arguments';
  test.shouldThrowError( function()
  {
    _.mapContain( {}, {}, 'redundant argument' );
  });

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
  test.shouldThrowError( function()
  {
    _.mapOwnKey();
  });

  test.case = 'few arguments';
  test.shouldThrowError( function()
  {
    _.mapOwnKey( {}, 'a', 'b' );
  });

  test.case = 'wrong type of key';
  test.shouldThrowError( function()
  {
    _.mapOwnKey( [], 1 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.mapOwnKey( 1 );
  });

  test.case = 'wrong type of second argument';
  test.shouldThrowError( function()
  {
    _.mapOwnKey( {}, 13 );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
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
    test.shouldThrowError( function()
    {
      _.mapHasAll( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasAll( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowError( function()
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
    test.shouldThrowError( function()
    {
      _.mapHasAny( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasAny( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowError( function()
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

  debugger;
  var got = _.mapHasNone( a, { a : 1 } );
  debugger;
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
    test.shouldThrowError( function()
    {
      _.mapHasNone( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapHasNone( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowError( function()
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
    test.shouldThrowError( function()
    {
      _.mapOwnAll( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnAll( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapOwnAll( {}, {}, {} );
    });

    test.case = 'src is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAll( a,{ a : 1 } );
    });

    test.case = 'screen is not a map';
    test.shouldThrowError( function()
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
    test.shouldThrowError( function()
    {
      _.mapOwnAny( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnAny( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapOwnAny( {}, {}, {} );
    });

    test.case = 'src is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnAny( a,{ a : 1 } );
    });

    test.case = 'screen is not a map';
    test.shouldThrowError( function()
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
    test.shouldThrowError( function()
    {
      _.mapOwnNone( 1, {} );
    });

    test.case = 'screen is no object like';
    test.shouldThrowError( function()
    {
      _.mapOwnNone( {}, 1 );
    });

    test.case = 'too much args';
    test.shouldThrowError( function()
    {
      _.mapOwnNone( {}, {}, {} );
    });

    test.case = 'src is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnNone( a,{ a : 1 } );
    });

    test.case = 'screen is not a map';
    test.shouldThrowError( function()
    {
      var a = {};
      var b = { a : 1 };
      Object.setPrototypeOf( a, b )
      _.mapOwnNone( { a : 1 }, a );
    });
  }

}

// --
//
// --

var Self =
{

  name : 'Tools/base/l1/Map',
  silencing : 1,

  tests :
  {

    // map tester

    mapIs : mapIs,

    // map move

    mapCloneAssigning : mapCloneAssigning,

    mapExtendConditional : mapExtendConditional,
    mapExtend : mapExtend,
    mapSupplement : mapSupplement,
    mapComplement : mapComplement,

    mapMake : mapMake,

    // map convert

    mapFirstPair : mapFirstPair,
    mapValWithIndex : mapValWithIndex,
    mapKeyWithIndex : mapKeyWithIndex,
    mapToStr : mapToStr,

    mapsFlatten2 : mapsFlatten2,

    // map properties

    mapKeys : mapKeys,
    mapOwnKeys : mapOwnKeys,
    mapAllKeys : mapAllKeys,

    mapVals : mapVals,
    mapOwnVals : mapOwnVals,
    mapAllVals : mapAllVals,

    mapPairs : mapPairs,
    mapOwnPairs : mapOwnPairs,
    mapAllPairs : mapAllPairs,

    mapProperties : mapProperties,
    mapOwnProperties : mapOwnProperties,
    mapAllProperties : mapAllProperties,

    mapRoutines : mapRoutines,
    mapOwnRoutines : mapOwnRoutines,
    mapAllRoutines : mapAllRoutines,

    mapFields : mapFields,
    mapOwnFields : mapOwnFields,
    mapAllFields : mapAllFields,

    mapOnlyPrimitives : mapOnlyPrimitives,

    // map logic

    mapButConditional : mapButConditional,
    mapBut : mapBut,
    mapOwnBut : mapOwnBut,

    mapOnly : mapOnly,
    _mapOnly : _mapOnly,

    mapIdentical : mapIdentical,
    mapContain : mapContain,

    mapOwnKey : mapOwnKey,

    mapHasAll : mapHasAll,
    mapHasAny : mapHasAny,
    mapHasNone : mapHasNone,

    mapOwnAll : mapOwnAll,
    mapOwnAny : mapOwnAny,
    mapOwnNone : mapOwnNone,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
