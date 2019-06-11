( function _Array_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  var _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
}

var _ = wTools;

// --
// buffer
// --

function bufferFrom( test )
{
  /*src: number,str,array,raw,typed,node */
  /*bufferConstructor: typed,raw,node */

  /* typed buffer */

  test.case = 'src:number,bufferConstructor:typed buffer';
  var src = 1;
  var got = _.bufferFrom({ src : src, bufferConstructor : Uint8Array });
  var expected = new Uint8Array([ src ]);
  test.identical( got, expected );

  test.case = 'src:str,bufferConstructor:typed buffer';
  var src = 'abc';
  var got = _.bufferFrom({ src : src, bufferConstructor : Uint8Array });
  var expected = new Uint8Array([ 97,98,99 ]);
  test.identical( got, expected );

  test.case = 'src:array,bufferConstructor:typed buffer';
  var src = [ 97,98,99 ];
  var got = _.bufferFrom({ src : src, bufferConstructor : Uint8Array });
  var expected = new Uint8Array([ 97,98,99 ]);
  test.identical( got, expected );

  test.case = 'src:raw buffer,bufferConstructor:typed buffer';
  var src = new ArrayBuffer( 3 );
  var got = _.bufferFrom({ src : src, bufferConstructor : Uint8Array });
  var expected = new Uint8Array([ 0, 0, 0 ]);
  test.identical( got, expected );

  test.case = 'src:typed,bufferConstructor:typed buffer';
  var src = new Int32Array([ 97,98,99 ]);
  var got = _.bufferFrom({ src : src, bufferConstructor : Uint8Array });
  var expected = new Uint8Array([ 97,98,99 ]);
  test.identical( got, expected );

  if( Config.platform === 'nodejs' )
  {
    test.case = 'src:node buffer,bufferConstructor:typed buffer';
    var src = Buffer.from([ 97,98,99 ]);
    var got = _.bufferFrom({ src : src, bufferConstructor : Uint8Array });
    var expected = new Uint8Array([ 97,98,99 ]);
    test.identical( got, expected );
  }

  /* raw buffer */

  test.case = 'src:number,bufferConstructor:raw buffer';
  var src = 1;
  var got = _.bufferFrom({ src : src, bufferConstructor : ArrayBuffer });
  var expected = new Uint8Array([ 1 ]).buffer;
  test.identical( got, expected );

  test.case = 'src:str,bufferConstructor:raw buffer';
  var src = 'abc';
  var got = _.bufferFrom({ src : src, bufferConstructor : ArrayBuffer });
  var expected = new Uint8Array([ 97,98,99 ]).buffer;
  test.identical( got, expected );

  test.case = 'src:array,bufferConstructor:raw buffer';
  var src = [ 97,98,99 ];
  var got = _.bufferFrom({ src : src, bufferConstructor : ArrayBuffer });
  var expected = new Uint8Array([ 97,98,99 ]).buffer;
  test.identical( got, expected );

  test.case = 'src:raw buffer,bufferConstructor:raw buffer';
  var src = new ArrayBuffer( 3 );
  var got = _.bufferFrom({ src : src, bufferConstructor : ArrayBuffer });
  var expected = src;
  test.identical( got, expected );

  test.case = 'src:typed,bufferConstructor:raw buffer';
  var src = new Int32Array([ 97,98,99 ]);
  var got = _.bufferFrom({ src : src, bufferConstructor : ArrayBuffer });
  var expected = new Int32Array([ 97,98,99 ]).buffer;
  test.identical( got, expected );

  if( Config.platform === 'nodejs' )
  {
    test.case = 'src:node buffer,bufferConstructor:raw buffer';
    var src = Buffer.from([ 97,98,99 ]);
    var got = _.bufferFrom({ src : src, bufferConstructor : ArrayBuffer });
    var expected = new Uint8Array([ 97,98,99 ]).buffer;
    test.identical( got, expected );
  }

  if( !Config.platform === 'nodejs' )
  return;

  /* node buffer */

  test.case = 'src:number,bufferConstructor:node buffer';
  var src = 1;
  var got = _.bufferFrom({ src : src, bufferConstructor : Buffer });
  var expected = Buffer.from( [ src ] );
  test.identical( got, expected );

  test.case = 'src:str,bufferConstructor:node buffer';
  var src = 'abc';
  var got = _.bufferFrom({ src : src, bufferConstructor : Buffer });
  var expected = Buffer.from( src );
  test.identical( got, expected );

  test.case = 'src:array,bufferConstructor:node buffer';
  var src = [ 97,98,99 ];
  var got = _.bufferFrom({ src : src, bufferConstructor : Buffer });
  var expected = Buffer.from( src );
  test.identical( got, expected );

  test.case = 'src:raw buffer,bufferConstructor:node buffer';
  var src = new ArrayBuffer( 3 );
  var got = _.bufferFrom({ src : src, bufferConstructor : Buffer });
  var expected = Buffer.from( src );
  test.identical( got, expected );

  test.case = 'src:typed,bufferConstructor:node buffer';
  var src = new Int32Array([ 97,98,99 ]);
  var got = _.bufferFrom({ src : src, bufferConstructor : Buffer });
  var expected = Buffer.from( src.buffer, src.buteOffset, src.byteLength );
  test.identical( got, expected );

  test.case = 'src:node buffer,bufferConstructor:node buffer';
  var src = Buffer.from([ 97,98,99 ]);
  var got = _.bufferFrom({ src : src, bufferConstructor : Buffer });
  var expected = src;
  test.identical( got, expected );

}

//

function bufferRelen( test )
{

  test.case = 'second argument is more than ints.length';
  var ints = new Int8Array( [ 3, 7, 13 ] );
  var got = _.bufferRelen( ints, 4 );
  var expected = got; // [ 3, 7, 13, 0 ];
  test.identical( got, expected );

  test.case = 'second argument is less than ints2.length';
  var ints2 = new Int16Array( [ 3, 7, 13, 33, 77 ] );
  var got = _.bufferRelen( ints2, 3 );
  var expected = got; // [ 3, 7, 13 ];
  test.identical( got, expected );

  test.case = 'invalid values are replaced by zero';
  var ints3 = new Int32Array( [ 3, 'a', 13, 'b', 77 ] );
  var got = _.bufferRelen( ints3, 6 );
  var expected = got; // [ 3, 0, 13, 0, 77, 0 ];
  test.identical( got, expected );

  test.case = 'returns the initial typed array';
  var floats = new Float32Array( [ 3.35, 7.5, 13.35, 33.75, 77.25 ] );
  var got = _.bufferRelen( floats, 5 );
  var expected = got; // [ 3.3499999046325684, 7.5, 13.350000381469727, 33.75, 77.25 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.bufferRelen();
  });

};

//

function bufferRetype( test )
{

  test.case = 'converts and returns the new type of Int16Array';
  var view1 = new Int8Array( [ 1, 2, 3, 4, 5, 6 ] );
  var got = _.bufferRetype(view1, Int16Array);
  var expected = got; // [ 513, 1027, 1541 ];
  test.identical( got, expected );

  test.case = 'converts and returns the new type of Int8Array';
  var view1 = new Int16Array( [ 513, 1027, 1541 ] );
  var got = _.bufferRetype(view1, Int8Array);
  var expected = got; // [ 1, 2, 3, 4, 5, 6 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.bufferRetype();
  });

  test.case = 'arguments are wrong';
  test.shouldThrowError( function()
  {
    _.bufferRetype( 'wrong argument', 'wrong argument' );
  });

};

//

function bufferRawFrom( test )
{
  test.case = 'typed';
  var src = new Uint8Array( 3 );
  var got = _.bufferRawFrom( src );
  var expected = new ArrayBuffer( 3 );
  test.identical( got, expected );

  test.case = 'raw';
  var src = new ArrayBuffer( 3 );
  var got = _.bufferRawFrom( src );
  var expected = src;
  test.identical( got, expected );

  test.case = 'view';
  var buffer = new ArrayBuffer( 10 );
  var src = new DataView( buffer );
  var got = _.bufferRawFrom( src );
  var expected = buffer;
  test.identical( got, expected );

  test.case = 'str';
  var src = 'abc';
  var got = _.bufferRawFrom( src );
  var expected = new Uint8Array([ 97,98,99 ]).buffer;
  test.identical( got, expected );

  if( Config.platform === 'nodejs' )
  {
    test.case = 'node-buffer';
    var src = Buffer.from( 'abc' );
    var got = _.bufferRawFrom( src );
    var expected = new Uint8Array([ 97,98,99 ]).buffer;
    test.identical( got, expected );
  }

  if( !Config.debug )
  return;

  test.case = 'unknown source';
  test.shouldThrowError( () => _.bufferRawFrom( 5 ) );
  test.shouldThrowError( () => _.bufferRawFrom( {} ) );
}

//

function bufferBytesFrom( test )
{
  test.case = 'raw';
  var src = new ArrayBuffer( 3 );
  var got = _.bufferBytesFrom( src );
  var expected = new Uint8Array([ 0,0,0 ]);
  test.identical( got, expected );

  test.case = 'arr';
  var src = [ 97,98,99 ];
  var got = _.bufferBytesFrom( src );
  var expected = new Uint8Array([ 97,98,99 ]);
  test.identical( got, expected );

  test.case = 'typed';
  var src = new Int8Array([ 97,98,99 ]);
  var got = _.bufferBytesFrom( src );
  var expected = new Uint8Array([ 97,98,99 ]);
  test.identical( got, expected );

  test.case = 'view';
  var buffer = new ArrayBuffer( 3 );
  var src = new DataView( buffer );
  var got = _.bufferBytesFrom( src );
  var expected = new Uint8Array([ 0,0,0 ]);
  test.identical( got, expected );

  test.case = 'str';
  var src = 'abc';
  var got = _.bufferBytesFrom( src );
  var expected = new Uint8Array([ 97,98,99 ]);
  test.identical( got, expected );

  if( Config.platform === 'nodejs' )
  {
    test.case = 'node';
    var src = Buffer.from( 'abc' );
    var got = _.bufferBytesFrom( src );
    var expected = new Uint8Array([ 97,98,99 ]);
    test.identical( got, expected );
  }

  if( !Config.debug )
  return;

  test.case = 'unknown source';
  test.shouldThrowError( () => _.bufferBytesFrom( 5 ) );
  // test.shouldThrowError( () => _.bufferBytesFrom( [] ) );
  test.shouldThrowError( () => _.bufferBytesFrom( {} ) );

}

//

function bufferNodeFrom( test )
{
  if( Config.platform !== 'nodejs' )
  return;

  test.case = 'raw';
  var src = new ArrayBuffer( 3 );
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.from([ 0,0,0 ])
  test.identical( got, expected );

  test.case = 'typed';
  var src = new Int8Array([ 97,98,99 ]);
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.from([ 97,98,99 ]);
  test.identical( got, expected );

  test.case = 'view';
  var buffer = new ArrayBuffer( 3 );
  var src = new DataView( buffer );
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.from([ 0,0,0 ]);
  test.identical( got, expected );

  test.case = 'str';
  var src = 'abc';
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.from( src );
  test.identical( got, expected );

  test.case = 'node';
  var src = Buffer.from( 'abc' );
  var got = _.bufferNodeFrom( src );
  var expected = src
  test.identical( got, expected );

  test.case = 'empty raw';
  var src = new ArrayBuffer( 0 );
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.alloc( 0 );
  test.identical( got, expected );

  test.case = 'empty typed';
  var src = new Int8Array([]);
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.alloc( 0 );
  test.identical( got, expected );

  test.case = 'empty node';
  var src = Buffer.alloc( 0 );
  var got = _.bufferNodeFrom( src );
  var expected = src;
  test.identical( got, expected );

  test.case = 'array';
  var src = [ 97,98,99 ];
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.from( src );
  test.identical( got, expected );

  test.case = 'object';
  var src = new String( 'abc' );
  var got = _.bufferNodeFrom( src );
  var expected = Buffer.from([ 97,98,99 ]);
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'unknown source';
  test.shouldThrowError( () => _.bufferNodeFrom( 5 ) );
  // test.shouldThrowError( () => _.bufferNodeFrom( [] ) );
  test.shouldThrowError( () => _.bufferNodeFrom( {} ) );

}

//

function bufferRawFromTyped( test )
{

  var buffer1 = new ArrayBuffer(10);
  var view1 = new Int8Array( buffer1 );
  test.case = 'returns the same length of typed array';
  var got = _.bufferRawFromTyped( view1 );
  var expected = got; // [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
  test.identical( got, expected );

  var buffer2 = new ArrayBuffer(10);
  var view2 = new Int8Array( buffer2, 2 );
  test.case = 'returns the new sub typed array';
  var got = _.bufferRawFromTyped( view2 );
  var expected = got; // [ 0, 0, 0, 0, 0, 0 ]
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.bufferRawFromTyped();
  });

  test.case = 'arguments are wrong';
  test.shouldThrowError( function()
  {
    _.bufferRawFromTyped( 'wrong argument' );
  });

}

//

function arrayIs( test )
{

  test.case = 'an empty array';
  var got = _.arrayIs( [  ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'an array';
  var got = _.arrayIs( [ 1, 2, 3 ] );
  var expected  = true;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.arrayIs( {  } );
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
  var got = _.arrayIs( function() {  } );
  var expected  = false;
  test.identical( got, expected );

  test.case = 'a pseudo array';
  var got = ( function() {
    return _.arrayIs( arguments );
  } )('Hello there!');
  var expected = false;
  test.identical( got, expected );

  test.case = 'no argument';
  var got = _.arrayIs();
  var expected  = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.arrayIs();
  var expected  = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

}

//

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
  var got = _.longIs( new ArrayBuffer( 10 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'typed array buffer';
  var got = _.longIs( new Float32Array( 10 ) );
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

  /* */

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

  test.case = 'raw array buffer'; debugger;
  var got = _.constructorLikeArray( new ArrayBuffer( 10 ).constructor );
  var expected = false;
  test.identical( got, expected );

  test.case = 'typed array buffer';
  var got = _.constructorLikeArray( new Float32Array( 10 ).constructor );
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

  /* */

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
  var src = [ 1,2,3 ];
  var got = _.argumentsArrayMake( src );
  var expected = [ 1,2,3 ];
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

  test.shouldThrowError( function()
  {
    _.argumentsArrayMake();
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayMake( 1,3 );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayMake( [], 3 );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayMake( [], [] );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayMake( {} );
  });

  test.shouldThrowError( function()
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
  var src = [ 1,2,3 ];
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1,2,3 ];
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
  var src = _.argumentsArrayMake([]);
  var got = _.argumentsArrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single number';
  var src = _.argumentsArrayMake([ 0 ]);
  var got = _.argumentsArrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single string';
  var src = _.argumentsArrayMake([ 'a' ]);
  var got = _.argumentsArrayFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving several';
  var src = _.argumentsArrayMake([ 1,2,3 ]);
  var got = _.argumentsArrayFrom( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.argumentsArrayIs( got ) );
  test.is( src === got );

  if( !Config.debug )
  return;

  test.shouldThrowError( function()
  {
    _.argumentsArrayFrom();
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayFrom( 1,3 );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayFrom( [], 3 );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayFrom( [], [] );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayFrom( {} );
  });

  test.shouldThrowError( function()
  {
    _.argumentsArrayFrom( '1' );
  });

}

//

function unrollMake( test )
{

  test.case = 'empty';
  var src = [];
  var got = _.unrollMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single number';
  var src = [ 0 ];
  var got = _.unrollMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single string';
  var src = [ 'a' ];
  var got = _.unrollMake( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'several';
  var src = [ 1,2,3 ];
  var got = _.unrollMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'zero length';
  var got = _.unrollMake( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'length';
  var got = _.unrollMake( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from empty Float32';
  var src = new Float32Array();
  var got = _.unrollMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from Float32';
  var src = new Float32Array([ 1,2,3 ]);
  var got = _.unrollMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from empty arguments array';
  var src = _.argumentsArrayMake([]);
  var got = _.unrollMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from arguments array';
  var src = _.argumentsArrayMake([ 1,2,3 ]);
  var got = _.unrollMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from empty array';
  var src = _.arrayMake([]);
  var got = _.unrollMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from array';
  var src = _.arrayMake([ 1,2,3 ]);
  var got = _.unrollMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  if( !Config.debug )
  return;

  test.shouldThrowError( function()
  {
    _.unrollMake();
  });

  test.shouldThrowError( function()
  {
    _.unrollMake( 1,3 );
  });

  test.shouldThrowError( function()
  {
    _.unrollMake( [], 3 );
  });

  test.shouldThrowError( function()
  {
    _.unrollMake( [], [] );
  });

  test.shouldThrowError( function()
  {
    _.unrollMake( {} );
  });

  test.shouldThrowError( function()
  {
    _.unrollMake( '1' );
  });

}

//

function unrollFrom( test )
{

  test.case = 'empty';
  var src = [];
  var got = _.unrollFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single number';
  var src = [ 0 ];
  var got = _.unrollFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single string';
  var src = [ 'a' ];
  var got = _.unrollFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'several';
  var src = [ 1,2,3 ];
  var got = _.unrollFrom( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'zero length';
  var got = _.unrollFrom( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'length';
  var got = _.unrollFrom( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'preserving empty';
  var src = _.unrollMake([]);
  var got = _.unrollFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single number';
  var src = _.unrollMake([ 0 ]);
  var got = _.unrollFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single string';
  var src = _.unrollMake([ 'a' ]);
  var got = _.unrollFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving several';
  var src = _.unrollMake([ 1,2,3 ]);
  var got = _.unrollFrom( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  if( !Config.debug )
  return;

  test.shouldThrowError( function()
  {
    _.unrollFrom();
  });

  test.shouldThrowError( function()
  {
    _.unrollFrom( 1,3 );
  });

  test.shouldThrowError( function()
  {
    _.unrollFrom( [], 3 );
  });

  test.shouldThrowError( function()
  {
    _.unrollFrom( [], [] );
  });

  test.shouldThrowError( function()
  {
    _.unrollFrom( {} );
  });

  test.shouldThrowError( function()
  {
    _.unrollFrom( '1' );
  });

}

//

/* qqq : implement bufferMakeSimilar */

function longMake( test )
{

  test.case = 'an empty array';
  var got = _.longMake( [  ], 0 );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'length = 1';
  var got = _.longMake( [  ], 1 );
  var expected = [ ,  ];
  test.identical( got, expected );

  test.case = 'length = 2';
  var got = _.longMake( [ 1, 2, 3 ], 2 );
  var expected = [ , , ];
  test.identical( got, expected );

  test.case = 'length = 4';
  var got = _.longMake( [ 1, 2, 3 ], 4 );
  var expected = [ , , , , ];
  test.identical( got, expected );

  test.case = 'same length';

  var ins = [ 1, 2, 3 ];
  var got = _.longMake( ins );
  test.identical( got.length, 3 );
  test.is( got !== ins );

  var ins = [];
  var src = _.arrayFillWhole( Buffer.alloc( 5 ), 1 );
  var got = _.longMake( ins, Array.from( src ) );
  test.identical( got.length, 5 );
  test.is( _.arrayIs( got ) );
  test.identical( got, [ 1,1,1,1,1 ] );

  // var ins = [];
  // var src = new ArrayBuffer( 5 )
  // var got = _.longMake( ins, src );
  // test.identical( got.length, 5 );
  // test.is( _.arrayIs( got ) );

  var ins = new Uint8Array( 5 );
  ins[ 0 ] = 1;
  var got = _.longMake( ins );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 5 );
  test.is( got !== ins );

  var ins = new Uint8Array( 5 );
  var src = [ 1, 2, 3, 4, 5 ];
  var got = _.longMake( ins,src );
  test.is( _.bufferTypedIs( got ) );
  test.is( got instanceof Uint8Array );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  test.case = 'typedArray';
  var ins = new Uint8Array( 5 );
  ins[ 0 ] = 1;
  var got = _.longMake( ins, 4 );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 4 );
  test.is( got !== ins );

  test.case = 'ArrayBuffer';
  var ins = new ArrayBuffer( 5 );
  var got = _.longMake( ins, 4 );
  test.is( _.bufferRawIs( got ) );
  test.identical( got.byteLength, 4 );

  test.case = 'NodeBuffer'
  var got = _.longMake( Buffer.alloc( 5 ) );
  test.is( _.bufferNodeIs( got ) );
  test.identical( got.length, 5 );

  test.case = 'NodeBuffer and src'
  var src = _.arrayFillWhole( new Uint8Array( 5 ), 1 );
  var got = _.longMake( Buffer.alloc( 5 ), src );
  test.is( _.bufferNodeIs( got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  test.case = 'NodeBuffer as src'
  var src = Buffer.alloc(10);
  for( var i = 0; i < src.length; i++ )
  src[ i ] = i;
  var got = _.longMake( [], Array.from( src ) );
  test.is( _.arrayIs( got ) );
  test.identical( got.length, src.length );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  test.case = 'ins as Array';
  var got = _.longMake( Array, 5 );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 5 );

  test.case = 'ins as Array';
  var src = [ 1,2,3 ];
  var got = _.longMake( Array, src );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 3 );
  test.identical( got, src );

  test.case = 'ins as Array';
  var src = _.arrayFillWhole( new Float32Array( 5 ), 1 );
  var got = _.longMake( Array, src );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 5 );
  test.identical( got, [ 1, 1, 1, 1, 1 ] );

  test.case = 'ins as Buffer';
  var src = _.arrayFillWhole( new Float32Array( 5 ), 1 );
  var got = _.longMake( Buffer, src );
  test.is( _.bufferNodeIs(  got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  test.case = 'ins as Array';
  var src = _.arrayFillWhole( Buffer.alloc( 5 ), 1 );
  var got = _.longMake( Array, src );
  test.is( _.arrayIs(  got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  test.case = 'ins as TypedArray';
  var src = [ 1,2,3 ];
  var got = _.longMake( Uint8Array, src );
  test.is( _.bufferTypedIs(  got ) );
  test.identical( got.length, 3 );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  test.case = 'ins as TypedArray';
  var src = _.arrayFillWhole( Buffer.alloc( 5 ), 1 );
  var got = _.longMake( Float32Array, src );
  test.is( _.bufferTypedIs(  got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < src.length; i++ )
  isEqual = got[ i ] !== src[ i ] ? false : true;
  test.is( isEqual );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.longMake();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.longMake('wrong argument');
  });

  test.case = 'arguments[1] is wrong';
  test.shouldThrowError( function()
  {
    _.longMake( [ 1, 2, 3 ], 'wrong type of argument' );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.longMake( [ 1, 2, 3 ], 4, 'redundant argument' );
  });

  test.case = 'argument is not wrapped into array';
  test.shouldThrowError( function()
  {
    _.longMake( 1, 2, 3, 4 );
  });
};

//

/*

qqq : implement bufferMakeZeroed routine and test routine

*/

function longMakeZeroed( test )
{
  test.case = 'Array';
  var got = _.longMakeZeroed( Array, 1 );
  var expected = [ 0 ];
  test.identical( got, expected );

  //

  test.case = 'Array';
  var got = _.longMakeZeroed( Array, new Float32Array( 2 ) );
  var expected = [ 0, 0 ];
  test.identical( got, expected );

  //

  test.case = 'ArrayBuffer';
  var got = _.longMakeZeroed( ArrayBuffer, 3 );
  test.is( _.bufferRawIs( got ) );
  test.identical( got.byteLength, 3 );

  //

  test.case = 'Uint8Array';
  var got = _.longMakeZeroed( Uint8Array, [ 1, 2, 3 ] );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 3 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  // test.case = 'Uint8Array';
  // var got = _.longMakeZeroed( Buffer, new ArrayBuffer( 3) );
  // test.is( _.bufferNodeIs( got ) );
  // test.identical( got.length, 3 );
  // var isEqual = true;
  // for( var i = 0; i < got.length; i++ )
  // isEqual = got[ i ] === 0 ? true : false;
  // test.is( isEqual );

  //

  test.case = 'an empty array';
  var got = _.longMakeZeroed( [  ], 0 );
  var expected = [  ];
  test.identical( got, expected );

  //

  test.case = 'length = 1';
  var got = _.longMakeZeroed( [  ], 1 );
  var expected = [ 0 ];
  test.identical( got, expected );

  //

  test.case = 'length = 2';
  var got = _.longMakeZeroed( [ 1, 2, 3 ], 2 );
  var expected = [ 0, 0 ];
  test.identical( got, expected );

  //

  test.case = 'length = 4';
  var got = _.longMakeZeroed( [ 1, 2, 3 ], 4 );
  var expected = [ 0, 0, 0, 0 ];
  test.identical( got, expected );

  //

  test.case = 'same length';
  var ins = [ 1, 2, 3 ];
  var got = _.longMakeZeroed( ins );
  test.identical( got.length, 3 );
  test.identical( got, [ 0, 0, 0 ] )

  //

  // test.case = 'same length';
  // var ins = new ArrayBuffer(5);
  // var got = _.longMakeZeroed( ins );
  // test.is( _.bufferRawIs( got ) );
  // test.identical( got.byteLength, 5 );

  //

  test.case = 'same length';
  var got = _.longMakeZeroed( ArrayBuffer, 5 );
  test.is( _.bufferRawIs( got ) );
  test.identical( got.byteLength, 5 );

  //

  test.case = 'same length, ins is a typed array';
  var ins = _.arrayFillWhole( new Uint8Array( 5 ), 1 );
  var got = _.longMakeZeroed( ins );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  test.case = 'same length, ins is a node buffer';
  var ins = _.arrayFillWhole( Buffer.alloc( 5 ), 1 );
  var got = _.longMakeZeroed( ins );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  var ins = [];
  var src = _.arrayFillWhole( Buffer.alloc( 5 ), 1 );
  var got = _.longMakeZeroed( ins, src );
  test.identical( got.length, 5 );
  test.is( _.arrayIs( got ) );
  test.identical( got, [ 0,0,0,0,0 ] );

  //

  var ins = new Uint8Array( 5 );
  ins[ 0 ] = 1;
  var got = _.longMakeZeroed( ins );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  test.case = 'typedArray';
  var ins = new Uint8Array( 5 );
  ins[ 0 ] = 1;
  var got = _.longMakeZeroed( ins, 4 );
  test.is( _.bufferTypedIs( got ) );
  test.identical( got.length, 4 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  test.case = 'ArrayBuffer';
  var ins = new ArrayBuffer( 5 );
  var got = _.longMakeZeroed( ins, 4 );
  test.is( _.bufferRawIs( got ) );
  test.identical( got.byteLength, 4 );
  got = new Uint8Array( got );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  // test.case = 'ArrayBuffer';
  // var ins = [];
  // var src = new ArrayBuffer( 5 );
  // var got = _.longMakeZeroed( ins, src );
  // test.is( _.arrayIs( got ) );
  // test.identical( got.length, 5 );
  // var isEqual = true;
  // for( var i = 0; i < got.length; i++ )
  // isEqual = got[ i ] === 0 ? true : false;
  // test.is( isEqual );

  //

  test.case = 'NodeBuffer'
  var got = _.longMakeZeroed( Buffer.alloc( 5 ) );
  test.is( _.bufferNodeIs( got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  //

  test.case = 'NodeBuffer and src'
  var src = new Int8Array(5);
  for( var i = 0; i < src.length; i++ )
  src[ i ] = i;
  var got = _.longMakeZeroed( Buffer.alloc( 5 ), src );
  test.is( _.bufferNodeIs( got ) );
  test.identical( got.length, 5 );
  var isEqual = true;
  for( var i = 0; i < got.length; i++ )
  isEqual = got[ i ] === 0 ? true : false;
  test.is( isEqual );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.longMakeZeroed();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.longMakeZeroed('wrong argument');
  });

  test.case = 'arguments[1] is wrong';
  test.shouldThrowError( function()
  {
    _.longMakeZeroed( [ 1, 2, 3 ], 'wrong type of argument' );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.longMakeZeroed( [ 1, 2, 3 ], 4, 'redundant argument' );
  });

  test.case = 'argument is not wrapped into array';
  test.shouldThrowError( function()
  {
    _.longMakeZeroed( 1, 2, 3, 4 );
  });

}

//

function arrayMake( test )
{

  test.case = 'empty';
  var src = [];
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single number';
  var src = [ 0 ];
  var got = _.arrayMake( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single string';
  var src = [ 'a' ];
  var got = _.arrayMake( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'several';
  var src = [ 1,2,3 ];
  var got = _.arrayMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'zero length';
  var got = _.arrayMake( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'length';
  var got = _.arrayMake( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from empty Float32';
  var src = new Float32Array();
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from Float32';
  var src = new Float32Array([ 1,2,3 ]);
  var got = _.arrayMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from empty arguments array';
  var src = _.argumentsArrayMake([]);
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from arguments array';
  var src = _.argumentsArrayMake([ 1,2,3 ]);
  var got = _.arrayMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from empty unroll';
  var src = _.unrollMake([]);
  var got = _.arrayMake( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'from unroll';
  var src = _.unrollMake([ 1,2,3 ]);
  var got = _.arrayMake( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  if( !Config.debug )
  return;

  test.shouldThrowError( function()
  {
    _.arrayMake();
  });

  test.shouldThrowError( function()
  {
    _.arrayMake( 1,3 );
  });

  test.shouldThrowError( function()
  {
    _.arrayMake( [], 3 );
  });

  test.shouldThrowError( function()
  {
    _.arrayMake( [], [] );
  });

  test.shouldThrowError( function()
  {
    _.arrayMake( {} );
  });

  test.shouldThrowError( function()
  {
    _.arrayMake( '1' );
  });

}

//

function arrayFrom( test )
{

  test.case = 'empty';
  var src = new Float32Array([]);
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single number';
  var src = new Float32Array([ 0 ]);
  var got = _.arrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'single string';
  var src = _.argumentsArrayMake([ 'a' ]);
  var got = _.arrayFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'several';
  var src = new Float32Array([ 1,2,3 ]);
  var got = _.arrayFrom( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'zero length';
  var got = _.arrayFrom( 0 );
  var expected = new Array( 0 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  test.case = 'length';
  var got = _.arrayFrom( 3 );
  var expected = new Array( 3 );
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src !== got );

  /* */

  test.case = 'preserving empty';
  var src = _.arrayMake([]);
  var got = _.arrayFrom( src );
  var expected = [];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single number';
  var src = _.arrayMake([ 0 ]);
  var got = _.arrayFrom( src );
  var expected = [ 0 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving single string';
  var src = _.arrayMake([ 'a' ]);
  var got = _.arrayFrom( src );
  var expected = [ 'a' ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  test.case = 'preserving several';
  var src = _.arrayMake([ 1,2,3 ]);
  var got = _.arrayFrom( src );
  var expected = [ 1,2,3 ];
  test.equivalent( got, expected );
  test.is( _.arrayIs( got ) );
  test.is( src === got );

  if( !Config.debug )
  return;

  test.shouldThrowError( function()
  {
    _.arrayFrom();
  });

  test.shouldThrowError( function()
  {
    _.arrayFrom( 1,3 );
  });

  test.shouldThrowError( function()
  {
    _.arrayFrom( [], 3 );
  });

  test.shouldThrowError( function()
  {
    _.arrayFrom( [], [] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFrom( {} );
  });

  test.shouldThrowError( function()
  {
    _.arrayFrom( '1' );
  });

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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no argument';
  test.shouldThrowError( function()
  {
    _.arrayFromCoercing();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.arrayFromCoercing( 6 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.arrayFromCoercing( true );
  });

}

//

function scalarAppend( test )
{

  test.case = 'none arguments';
  var got = _.scalarAppend();
  test.identical( got, [] );

  test.case = 'single undefined';
  var got = _.scalarAppend( undefined );
  test.identical( got, [] );

  test.case = 'two undefined';
  var got = _.scalarAppend( undefined, undefined );
  test.identical( got, [] );

  test.case = 'three undefined';
  var got = _.scalarAppend( undefined, undefined, undefined );
  test.identical( got, [] );

  test.case = 'dstArray is undefined, src is scalar';
  var got = _.scalarAppend( undefined, 1 );
  test.identical( got, 1 );

  test.case = 'dstArray is undefined, src is array';
  var src = [ 1 ];
  var got = _.scalarAppend( undefined, src );
  test.identical( got, [ 1 ] );
  test.is( src !== got );

  test.case = 'dstArray is scalar, src is undefined';
  var got = _.scalarAppend( 1, undefined );
  test.identical( got, 1 );

  test.case = 'dstArray is array, src is undefined';
  var dst = [ 1 ];
  var got = _.scalarAppend( dst, undefined );
  test.identical( got, [ 1 ] );
  test.is( dst === got );

  test.case = 'dstArray is null, src is scalar';
  var got = _.scalarAppend( null, 1 );
  test.identical( got, [ null, 1 ] );

  test.case = 'dstArray is null, src is array';
  var src = [ 1 ];
  var got = _.scalarAppend( null, src );
  test.identical( got, [ null, 1 ] );
  test.is( src !== got );

  test.case = 'nothing';
  var got = _.scalarAppend( [], [] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'simple';
  var dst = [];
  var got = _.scalarAppend( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.scalarAppend( dst,[ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.scalarAppend( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.scalarAppend( dst, [ 1 ], [ 2 ], [ 3, [ 5 ] ] );
  test.identical( dst, [ 1, 2, 3, 1, 2, 3, [ 5 ] ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 5 ] ] ];
  var got = _.scalarAppend( dst, insArray );
  test.identical( dst, [ 1, 2, 3, [ 1 ], [ 2 ], [ 3, [ 5 ] ] ] );
  test.is( got === dst );

  test.case = 'arguments are not arrays';
  var dst = [];
  var got = _.scalarAppend( dst, [ 1, 2, 3 ]);
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.scalarAppend( dst, insArray );
  test.identical( dst, [  1, 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.scalarAppend( dst, 'a', 1, [ { a : 1 } ], { b : 2 } );
  test.identical( dst, [  1, 'a', 1, { a : 1 }, { b : 2 } ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  var got = _.scalarAppend( dst, undefined );
  test.identical( dst, [ 1 ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [];
  var got = _.scalarAppend( dst, [ 1 ], [ 3 ] );
  test.identical( dst, [ 1, 3 ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [ 0 ];
  var got = _.scalarAppend( dst, [ 1 ], [ 3 ] );
  test.identical( dst, [ 0, 1, 3 ] );
  test.is( got === dst );

  test.case = 'argument is undefined';
  var dst = [];
  var got = _.scalarAppend( dst, undefined );
  test.identical( dst, [] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.scalarAppend( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1, undefined, 2 ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var got = _.scalarAppend( 1, [ 2 ] );
  test.identical( got, [ 1, 2 ] );

  /**/

  if( !Config.debug )
  return;

  // test.case = 'no arguments';
  // test.shouldThrowError( function()
  // {
  //   _.scalarAppend();
  // });

}

//

function arrayMakeRandom( test )
{

  test.case = 'an empty object';
  var got = _.arrayMakeRandom( {  } );
  test.identical( got.length, 1 );
  test.is( got[ 0 ] >= 0 && got[ 0 ]<= 1 );

  test.case = 'a number';
  var got = _.arrayMakeRandom( 5 );
  var expected = got;
  test.identical( got.length, 5 );

  var got = _.arrayMakeRandom( -1 );
  var expected = [];
  test.identical( got, expected );

  test.case = 'an object';
  var got = _.arrayMakeRandom( {
    length : 5,
    range : [ 1, 9 ],
    int : true
  } );
  var expected = got;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayMakeRandom();
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
  {
    _.arrayMakeRandom( 'wrong argument' );
  });

};

//

function scalarToVector( test )
{

  test.case = 'nothing';
  var got = _.scalarToVector( [  ], 0 );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'static array';
  var got = _.scalarToVector( 3, 7 );
  var expected = [ 3, 3, 3, 3, 3, 3, 3 ];
  test.identical( got, expected );

  test.case = 'original array';
  var got = _.scalarToVector( [ 3, 7, 13 ], 3 );
  var expected = [ 3, 7, 13 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.scalarToVector();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.scalarToVector( [ 1, 2, 3 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.scalarToVector( [ 1, 2, 3 ], 3, 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.scalarToVector('wrong argument', 'wrong argument');
  });

  test.case = 'second argument too much';
  test.shouldThrowError( function()
  {
    _.scalarToVector( [ 1, 2, 3 ], 4 );
  });

  test.case = 'first three arguments are not wrapped into array';
  test.shouldThrowError( function()
  {
    _.scalarToVector( 1, 2, 3, 3 );
  });

};

//

function arrayFromRange( test )
{

  test.case = 'single zero';
  var got = _.arrayFromRange( [ 0, 1 ] );
  var expected = [ 0 ];
  test.identical( got,expected );

  test.case = 'nothing';
  var got = _.arrayFromRange( [ 1, 1 ] );
  var expected = [  ];
  test.identical( got,expected );

  test.case = 'single not zero';
  var got = _.arrayFromRange( [ 1, 2 ] );
  var expected = [ 1 ];
  test.identical( got,expected );

  test.case = 'couple of elements';
  var got = _.arrayFromRange( [ 1, 3 ] );
  var expected = [ 1, 2 ];
  test.identical( got,expected );

  test.case = 'single number as argument';
  var got = _.arrayFromRange( 3 );
  var expected = [ 0, 1, 2 ];
  test.identical( got,expected );

  test.case = 'complex case';
  var got = _.arrayFromRange( [ 3, 9 ] );
  var expected = [ 3, 4, 5, 6, 7, 8 ];
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayFromRange( [ 1, 3 ],'wrong arguments' );
  });

  test.case = 'argument not wrapped into array';
  test.shouldThrowError( function()
  {
    _.arrayFromRange( 1, 3 );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.arrayFromRange( 'wrong arguments' );
  });

  test.case = 'no arguments'
  test.shouldThrowError( function()
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
  test.shouldThrowError( () => _.arrayAs() );

  test.case = 'undefined';
  test.shouldThrowError( () => _.arrayAs( undefined ) );
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
  test.shouldThrowError( function()
  {
    _.arrayToMap();
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.arrayToStr();
  });

  test.case = 'in second argument property (type) is wrong';
  test.shouldThrowError( function()
  {
    _.arrayToStr( [ 1, 2, 3 ], { type : 'wrong type' } );
  });

  test.case = 'in second argument property (type) is not provided';
  test.shouldThrowError( function()
  {
    _.arrayToStr( [ 1, 2, 3 ], { precission : 4 } );
  });

  test.case = 'first argument is string';
  test.shouldThrowError( function()
  {
    _.arrayToStr( 'wrong argument', {  type : 'float' } );
  });

}

//

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
    var expected = { uniques : 0, condensed : 1, array : [ 1,1 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

    test.case = 'none unique';
    var l1 = onMake( [ 1,2,3,1,2,3 ] );
    var expected = { uniques : 0, condensed : 3, array : [ 1,1,1, 1,1,1 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

    test.case = 'several uniques';
    var l1 = onMake( [ 0,1,2,3,4,1,2,3,5 ] );
    var expected = { uniques : 3, condensed : 6, array : [ 0, 1,1,1, 0, 1,1,1, 0 ] };
    var got = _.longAreRepeatedProbe( l1, onEvaluate );
    test.identical( got, expected );

  }

}

//

function longAllAreRepeated( test )
{

  var got = _.longAllAreRepeated([]);
  test.identical( got, true );

  var got = _.longAllAreRepeated([ 1, 1 ]);
  test.identical( got, true );

  var got = _.longAllAreRepeated([ 1 ]);
  test.identical( got, false );

  var got = _.longAllAreRepeated([ 1, 2, 2 ]);
  test.identical( got, false );

}

//

function longAnyAreRepeated( test )
{

  var got = _.longAnyAreRepeated([]);
  test.identical( got, false );

  var got = _.longAnyAreRepeated([ 1, 1 ]);
  test.identical( got, true );

  var got = _.longAnyAreRepeated([ 1 ]);
  test.identical( got, false );

  var got = _.longAnyAreRepeated([ 1, 2, 2 ]);
  test.identical( got, true );

}

//

function longNoneAreRepeated( test )
{

  var got = _.longNoneAreRepeated([]);
  test.identical( got, true );

  var got = _.longNoneAreRepeated([ 1, 1 ]);
  test.identical( got, false );

  var got = _.longNoneAreRepeated([ 1 ]);
  test.identical( got, true );

  var got = _.longNoneAreRepeated([ 1, 2, 2 ]);
  test.identical( got, false );

}

//

function arraySub( test )
{

  test.case = 'nothing';
  var got = _.arraySub( [  ], 0, 0 );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'two arguments';
  var got = _.arraySub( [  ], 0 );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'full copy of an array';
  var got = _.arraySub( [ 1, 2, 3, 4, 5 ] );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'an array of two elements';
  var got = _.arraySub( [ 1, 2, 3, 4, 5 ], 2, 4 );
  var expected = [ 3, 4 ];
  test.identical( got, expected );

  test.case = 'from second index to the (arr.length - 1)';
  var got = _.arraySub( [ 1, 2, 3, 4, 5 ], 2 );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'an offset from the end of the sequence';
  var got = _.arraySub( [ 1, 2, 3, 4, 5 ], -4 );
  var expected = [ 2, 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'the two negative index';
  var got = _.arraySub( [ 1, 2, 3, 4, 5 ], -4, -2 );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  test.case = 'the third index is negative';
  var got = _.arraySub( [ 1, 2, 3, 4, 5 ], 1, -1 );
  var expected = [ 2, 3, 4 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySub();
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySub( 'wrong argument', 1, -1 );
  });

  test.case = 'argument is not wrapped into array';
  test.shouldThrowError( function()
  {
    _.arraySub( 1, 2, 3, 4, 5, 2, 4 );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySub( [ 1, 2, 3, 4, 5 ], 2, 4, 'redundant argument' );
  });

};

//

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
//  var expected = [ 1,1 ];
//  test.identical( got, expected );
//
//  test.case = 'array + typedArray';
//  var got = _.arrayJoin( [ 1 ], new Uint8Array([ 1,2 ]) );
//  var expected = [ 1,1,2 ];
//  test.identical( got, expected );
//
//  var got = _.arrayJoin( new Uint8Array( [ 1,2 ] ), [ 1 ] );
//  var expected = new Uint8Array( [ 1,2,1 ] );
//  test.identical( got, expected );
//
//  test.case = 'typedArray + typedArray';
//  var got = _.arrayJoin( new Uint8Array( [ 1,2 ] ), new Uint8Array( [ 1,2 ] ) );
//  var expected = new Uint8Array( [ 1,2,1,2 ] );
//  test.identical( got, expected );
//
//  var got = _.arrayJoin( new Uint8Array( [ 1,2 ] ), new Uint16Array( [ 1,2 ] ) );
//  var expected = new Uint8Array( [ 1,2,1,0,2,0 ] );
//  test.identical( got, expected );
//
//  test.case = 'arrayBuffer + arrayBuffer';
//  var src = new Uint8Array( [ 1,2 ] );
//  var got = _.arrayJoin( src.buffer, src.buffer );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new Uint8Array( [ 1,2,1,2 ] );
//  test.identical( new Uint8Array( got ), expected );
//
//  test.case = 'arrayBuffer + array';
//  var src = new Uint8Array( [ 1,2 ] );
//  var got = _.arrayJoin( src.buffer, [ 1,2 ] );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new Uint8Array( [ 1,2,1,2 ] );
//  test.identical( new Uint8Array( got ), expected );
//
//  test.case = 'arrayBuffer + typedArray';
//  var src = new Uint8Array( [ 1,2 ] );
//  var got = _.arrayJoin( src.buffer, src );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new Uint8Array( [ 1,2,1,2 ] );
//  test.identical( new Uint8Array( got ), expected );
//
//  test.case = 'typedArray + arrayBuffer';
//  var src = new Uint8Array( [ 1,2 ] );
//  var got = _.arrayJoin( src, src.buffer );
//  var expected = new Uint8Array( [ 1,2,1,2 ] );
//  test.identical( got, expected );
//
//  test.case = 'typedArray + arrayBuffer + array';
//  var src = new Uint8Array( [ 1 ] );
//  var got = _.arrayJoin( src, src.buffer, [ 1 ] );
//  var expected = new Uint8Array( [ 1,1,1 ] );
//  test.identical( got, expected );
//
//  test.case = 'array + typedArray + arrayBuffer';
//  var src = new Uint8Array( [ 1 ] );
//  var got = _.arrayJoin( [ 1 ], src, src.buffer );
//  var expected = [ 1,1,1 ];
//  test.identical( got, expected );
//
//  test.case = 'arrayBuffer + array + typedArray';
//  var src = new Uint8Array( [ 1 ] );
//  var got = _.arrayJoin( src.buffer, [ 1 ], src  );
//  test.is( _.bufferRawIs( got ) );
//  var expected = new Uint8Array( [ 1,1,1 ] );
//  test.identical( new Uint8Array( got ), expected );
//
//  if( Config.platform === 'nodejs' )
//  {
//    test.case = 'buffer';
//    var got = _.arrayJoin( Buffer.from( '1' ), [ 1 ] );
//    var expected = Buffer.from( [ 49,1 ] );
//    test.identical( got, expected );
//
//    test.case = 'buffer + arrayBuffer';
//    var raw = new Uint8Array( [ 1 ] ).buffer;
//    var got = _.arrayJoin( Buffer.from( '1' ), raw );
//    var expected = Buffer.from( [ 49,1 ] );
//    test.identical( got, expected );
//
//    test.case = 'buffer + typedArray';
//    var typed = new Uint8Array( [ 1 ] );
//    var got = _.arrayJoin( Buffer.from( '1' ), typed );
//    var expected = Buffer.from( [ 49,1 ] );
//    test.identical( got, expected );
//
//    test.case = 'buffer + typedArray + raw + array';
//    var typed = new Uint8Array( [ 1 ] );
//    var got = _.arrayJoin( Buffer.from( '1' ), typed, typed.buffer, [ 1 ] );
//    var expected = Buffer.from( [ 49,1,1,1 ] );
//    test.identical( got, expected );
//
//    test.case = 'typedArray + buffer + raw + array';
//    var typed = new Uint8Array( [ 1 ] );
//    var got = _.arrayJoin( typed, Buffer.from( '1' ), typed.buffer, [ 1 ] );
//    var expected = new Uint8Array( [ 1,49,1,1 ] );
//    test.identical( got, expected );
//
//    test.case = 'raw + typedArray + buffer + array';
//    var typed = new Uint8Array( [ 1 ] );
//    var got = _.arrayJoin( typed.buffer, typed, Buffer.from( '1' ), [ 1 ] );
//    var expected = new Uint8Array( [ 1,1,49,1 ] );
//    test.identical( new Uint8Array( got ), expected );
//
//    test.case = 'array + raw + typedArray + buffer ';
//    var typed = new Uint8Array( [ 1 ] );
//    var got = _.arrayJoin( [ 1 ], typed.buffer, typed, Buffer.from( '1' )  );
//    var expected = new Uint8Array( [ 1,1,1,49 ] );
//    test.identical( new Uint8Array( got ), expected );
//  }
//
//  if( !Config.debug )
//  return;
//
//  test.shouldThrowError( () => _.arrayJoin( [ 1 ], '1' ) );
//  test.shouldThrowError( () => _.arrayJoin( [ 1 ], { byteLength : 5 } ) );
//
//}

//

function arrayGrow( test )
{
  var got,expected;
  var array = [ 1,2,3,4,5 ];

  test.case = 'defaults';

  /* default call returns copy */

  got = _.arrayGrow( array );
  expected = array;
  test.identical( got, expected );

  test.case = 'increase size of array';

  /* without setting value */

  got = _.arrayGrow( array, 0, array.length + 2 );
  expected = array.length + 2;
  test.identical( got.length, expected );

  /* by setting value */

  got = _.arrayGrow( array, 0, array.length + 2, 0 );
  expected = [ 1,2,3,4,5,0,0 ];
  test.identical( got, expected );

  /* by taking only last element of source array */

  got = _.arrayGrow( array, array.length - 1, array.length * 2, 0 );
  expected = [ 5,0,0,0,0,0 ];
  test.identical( got, expected );

  test.case = 'decrease size of array';

  /**/

  got = _.arrayGrow( array, 0, 3 );
  expected = [ 1,2,3 ];
  test.identical( got, expected );

  /* setting value not affects on array */

  got = _.arrayGrow( array, 0, 3, 0 );
  expected = [ 1,2,3 ];
  test.identical( got, expected );

  /* begin index is negative */

  got = _.arrayGrow( array, -1, 3 );
  expected = [ undefined,1,2,3 ];
  test.identical( got, expected );

  /* end index is negative */

  got = _.arrayGrow( array, 0, -1 );
  expected = [];
  test.identical( got, expected );

  /* begin index negative, set value */

  got = _.arrayGrow( array, -1, 3, 0 );
  expected = [ 0, 1,2,3 ];
  test.identical( got, expected );

  //

  if( Config.platform === 'nodejs' )
  {
    test.case = 'buffer';
    var got = _.arrayGrow( Buffer.from( '123' ), 0, 5, 0 );
    var expected = [ 49, 50, 51, 0, 0 ];
    test.identical( got, expected );
  }

  //

  if( !Config.debug )
  return;

  test.case = 'invalid arguments type';

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.arrayGrow( 1 );
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.arrayGrow( array, '1', array.length )
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.arrayGrow( array, 0, '1' )
  })

}

function arrayResize( test )
{
  var got,expected;

  test.case = 'defaults';
  var array = [ 1, 2, 3, 4, 5, 6, 7 ];
  array.src = true;

  /* just pass array */

  got = _.arrayResize( array );
  test.identical( got.src, undefined );
  test.identical( got, array );

  //

  test.case = 'make copy of source';

  /* third argument is not provided */

  got = _.arrayResize( array, 2 );
  test.identical( got.src, undefined );
  expected = [ 3, 4, 5, 6, 7 ];
  test.identical( got, expected );

  /* second argument is undefined */

  got = _.arrayResize( array, undefined, 4  );
  test.identical( got.src, undefined );
  expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );

  /**/

  got = _.arrayResize( array, 0, 3 );
  test.identical( got.src, undefined );
  expected = [ 1,2,3 ];
  test.identical( got, expected );

  /* from two to six */

  test.case = 'from two to six';
  got = _.arrayResize( array, 2, 6 );
  test.identical( got.src, undefined );
  expected = [ 3, 4, 5, 6 ];
  test.identical( got, expected );

  /* rigth bound is negative */

  got = _.arrayResize( array, 0, -1 );
  test.identical( got.src, undefined );
  expected = [];
  test.identical( got, expected );

  /* both bounds are negative */

  got = _.arrayResize( array, -1, -3 );
  test.identical( got.src, undefined );
  expected = [];
  test.identical( got, expected );

  /* TypedArray */

  var arr = new Uint16Array( array );
  arr.src = true;
  got = _.arrayResize( arr, 0, 3 );
  test.identical( got.src, undefined );
  expected = new Uint16Array([ 1, 2, 3 ]);
  test.identical( got, expected );

  /* Buffer */

  if( Config.platform === 'nodejs' )
  {
    test.case = 'buffer';
    var got = _.arrayResize( Buffer.from( '123' ), 0, 5, 0 );
    var expected = [ 49, 50, 51, 0, 0 ];
    test.identical( got, expected );
  }

  /**/

  test.case = 'increase size of array';

  /* rigth bound is out of range */

  got = _.arrayResize( array, 0, array.length + 2 );
  test.identical( got.src, undefined );
  expected = array.slice();
  expected.push( undefined,undefined );
  test.identical( got, expected );

  /* indexes are out of bound */

  got = _.arrayResize( array, array.length + 1, array.length + 3 );
  test.identical( got.src, undefined );
  expected = [ undefined, undefined ];
  test.identical( got, expected );

  /* left bound is negative */

  got = _.arrayResize( array, -1, array.length );
  test.identical( got.src, undefined );
  expected = array.slice();
  expected.unshift( undefined );
  test.identical( got, expected );

  /* without setting value */

  got = _.arrayResize( array, 0, array.length + 2 );
  test.identical( got.src, undefined );
  test.identical( got.length, array.length + 2 );

  /* by setting value */

  got = _.arrayResize( array, 0, array.length + 2, 0 );
  test.identical( got.src, undefined );
  expected = [ 1,2,3,4,5,6,7,0,0 ];
  test.identical( got, expected );

  /* by taking only last element of source array */

  got = _.arrayResize( array, array.length - 1, array.length + 2, 0 );
  test.identical( got.src, undefined );
  expected = [ 7, 0, 0 ];
  test.identical( got, expected );

  test.case = 'decrease size of array';

  /* setting value not affects on array */

  got = _.arrayResize( array, 0, 3, 0 );
  test.identical( got.src, undefined );
  expected = [ 1,2,3 ];
  test.identical( got, expected );

  /* begin index is negative */

  got = _.arrayResize( array, -1, 3, 0 );
  test.identical( got.src, undefined );
  expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  /* end index is negative */

  got = _.arrayResize( array, 0, -1 );
  test.identical( got.src, undefined );
  expected = [];
  test.identical( got, expected );

  /* begin index negative, set value */

  got = _.arrayResize( array, -1, 3, 0 );
  test.identical( got.src, undefined );
  expected = [ 0, 1,2,3 ];
  test.identical( got, expected );

  /* TypedArray */

  var arr = new Uint16Array( array );
  arr.src = true;
  got = _.arrayResize( arr, 0, 4, 4 );
  test.identical( got.src, undefined );
  expected = new Uint16Array([ 1, 2, 3, 4 ]);
  test.identical( got, expected );

  //

  if( Config.platform === 'nodejs' )
  {
    test.case = 'buffer';
    var got = _.arrayResize( Buffer.from( '123' ), 0, 5, 0 );
    var expected = [ 49, 50, 51, 0, 0 ];
    test.identical( got, expected );
  }

  //

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayResize();
  });

  /**/

  test.case = 'invalid arguments type';

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.arrayResize( 1 );
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.arrayResize( array, '1', array.length )
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.arrayResize( array, 0, '1' )
  })

  /**/

  test.case = 'buffer';

  /**/

  got = _.arrayResize( Buffer.from( '123' ), 0, 1 );
  expected = [ 49 ];
  test.identical( got, expected );

  //

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.arrayResize( 'wrong argument', 'wrong argument', 'wrong argument' );
  });

};

//

/*
qqq : improve, add exception checking ceases
*/

function longSlice( test )
{

  test.open( 'Array' );
  runFor( makeArray );
  test.close( 'Array' );

  test.open( 'ArgumentsArray' );
  runFor( makeU8 );
  test.close( 'ArgumentsArray' );

  test.open( 'F32x' );
  runFor( makeF32 );
  test.close( 'F32x' );

  test.open( 'U8x' );
  runFor( makeU8 );
  test.close( 'U8x' );

  /* */

  if( !Config.debug )
  return;

  test.case = 'raw buffer';
  test.shouldThrowError( function()
  {
    _.longSlice( new ArrayBuffer() );
  });

  /* */

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

  /* */

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

    var srcLong = a( 1,2,3 );
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
    var expected = a( 1,2,3,4,5,6 );
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

    /* */

    if( !Config.debug )
    return;

    test.case = 'no arguments';
    test.shouldThrowError( function()
    {
      _.longSlice();
    });

    test.case = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.longSlice( 'x' );
    });

    test.case = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.longSlice( [ 1 ], 'x', 1 );
    });

    test.case = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.longSlice( [ 1 ], 0, 'x' );
    });

    test.case = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      var array = new ArrayBuffer();
      _.longSlice( array );
    });

  }

}

longSlice.timeOut = 20000;

//

function arrayDuplicate( test )
{
  test.case = 'couple of repeats';
  var got = _.arrayDuplicate( [ 'a', 'b', 'c' ] );
  var expected = [ 'a', 'a', 'b', 'b', 'c', 'c' ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 1 numberOfDuplicatesPerElement 1';
  var options =
  {
    src : [ 10,20 ],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.arrayDuplicate( options );
  var expected = [ 10,20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 1 numberOfDuplicatesPerElement 2';
  var options =
  {
    src : [ 10,20 ],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.arrayDuplicate( options );
  var expected = [ 10,10,20,20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 2 numberOfDuplicatesPerElement 1';
  var options =
  {
    src : [ 10,20 ],
    numberOfAtomsPerElement : 2,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.arrayDuplicate( options );
  var expected = [ 10,20 ];
  test.identical( got, expected );

  /* */

  test.case = 'numberOfAtomsPerElement 2 numberOfDuplicatesPerElement 2';
  var options =
  {
    src : [ 10,20 ],
    numberOfAtomsPerElement : 2,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.arrayDuplicate( options );
  var expected = [ 10,20,10,20 ];
  test.identical( got, expected );

  /* */

  test.case = 'result provided';
  var options =
  {
    src : [ 10,20 ],
    result : [ 1,1,1,1 ],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  var got = _.arrayDuplicate( options );
  var expected = [ 10,10,20,20 ];
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
  var got = _.arrayDuplicate( options );
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
  var got = _.arrayDuplicate( options );
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
  var got = _.arrayDuplicate( options );
  var expected = [ 1, 2, 'abc', 'def',  ];
  test.identical( got, expected );

  /* */

  test.case = 'different options';
  var arr = new Uint8Array( 1 );
  arr[ 0 ] = 5;
  var options =
  {
    src : [ 1, 2 ],
    result : arr,
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 1
  };
  var got = _.arrayDuplicate( options );
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
  var got = _.arrayDuplicate( options );
  var expected = [ 'abc', 'def', undefined, 'abc', 'def', undefined, 'abc', 'def', undefined ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayDuplicate();
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.arrayDuplicate( [ 'a', 'b', 'c' ], 'wrong argument' );
  });

  test.case = 'options.src is not provided or "undefined"';
  var options = {
    src : undefined,
    result : [  ],
    numberOfAtomsPerElement : 3,
    numberOfDuplicatesPerElement : 3
  };
  test.shouldThrowError( function()
  {
    _.arrayDuplicate( options, { a : 13 } );
  });

  test.case = 'result provided, but not enough length';
  var options =
  {
    src : [ 10,20 ],
    result : [],
    numberOfAtomsPerElement : 1,
    numberOfDuplicatesPerElement : 2
  };
  test.shouldThrowError( function ()
  {
    _.arrayDuplicate( options );
  })


};

//

function arrayMask( test )
{

  test.case = 'nothing';
  var got = _.arrayMask( [ 1, 2, 3, 4 ], [ undefined, null, 0, '' ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'adds last three values';
  var got = _.arrayMask( [ 'a', 'b', 'c', 4, 5 ], [ 0, '', 1, 2, 3 ] );
  var expected = [ "c", 4, 5 ];
  test.identical( got, expected );

  test.case = 'adds the certain values';
  var got = _.arrayMask( [ 'a', 'b', 'c', 4, 5, 'd' ], [ 3, 7, 0, '', 13, 33 ] );
  var expected = [ "a", 'b', 5, 'd' ];
  test.identical( got, expected );

  /**/


  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayMask();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayMask( [ 1, 2, 3, 4 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayMask( [ 'a', 'b', 'c', 4, 5 ], [ 0, '', 1, 2, 3 ], 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.arrayMask( 'wrong argument', 'wrong argument' );
  });

  test.case = 'both arrays are empty';
  test.shouldThrowError( function()
  {
    _.arrayMask( [  ], [  ] );
  });

  test.case = 'length of the first array is not equal to the second array';
  test.shouldThrowError( function()
  {
    _.arrayMask( [ 1, 2, 3 ], [ undefined, null, 0, '' ] );
  });

  test.case = 'length of the second array is not equal to the first array';
  test.shouldThrowError( function()
  {
    _.arrayMask( [ 1, 2, 3, 4 ], [ undefined, null, 0 ] );
  });

};

//

function arraySelect( test )
{

  test.case = 'nothing';
  var got = _.arraySelect( [  ], [  ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'certain elements';
  var got = _.arraySelect( [ 1, 2, 3, 4, 5 ], [ 2, 3, 4 ] );
  var expected = [ 3, 4, 5 ];
  test.identical( got, expected );

  test.case = 'array of undefined';
  var got = _.arraySelect( [ 1, 2, 3 ], [ 4, 5 ] );
  var expected = [ undefined, undefined ];
  test.identical( got, expected );

  test.case = 'using object';
  var src = [ 1, 1, 2, 2, 3, 3 ];
  var indices = { atomsPerElement : 2, indices : [ 0, 1, 2 ] }
  var got = _.arraySelect( src,indices );
  var expected = [ 1, 1, 2, 2, 3, 3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySelect();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySelect( [ 1, 2, 3 ] );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.arraySelect('wrong argument', 'wrong argument');
  });

  test.case = 'arguments are not wrapped into array';
  test.shouldThrowError( function()
  {
    _.arraySelect( 1, 2, 3, 4, 5 );
  });

};

//

function arraySwap( test )
{

  test.case = 'an element';
  var got = _.arraySwap( [ 7 ], 0, 0 );
  var expected = [ 7 ];
  test.identical( got, expected );

  test.case = 'reverses first index and last index';
  var got = _.arraySwap( [ 1, 2, 3, 4, 5 ], 0, 4  );
  var expected = [ 5, 2, 3, 4, 1 ];
  test.identical( got, expected );

  test.case = 'swaps first two';
  var got = _.arraySwap( [ 1, 2, 3 ] );
  var expected = [ 2,1,3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySwap();
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.arraySwap('wrong argument', 'wrong argument', 'wrong argument');
  });

  test.case = 'arguments[1] and arguments[2] are out of bound';
  test.shouldThrowError( function()
  {
    _.arraySwap( [ 1, 2, 3, 4, 5 ], -1, -4 );
  });

  test.case = 'first five arguments are not wrapped into array';
  test.shouldThrowError( function()
  {
    _.arraySwap( 1, 2, 3, 4, 5, 0, 4 );
  });

};

//

function arrayCutin( test )
{

  debugger;

  test.case = 'range as single number';

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayCutin( dst, 2 );
  var expected = [ 3 ];
  test.identical( got, expected );
  test.identical( dst, [ 1, 2, 4 ] )

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayCutin( dst, -1 );
  var expected = [];
  test.identical( got, expected );
  test.identical( dst, [ 1, 2, 3, 4 ] )

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayCutin( dst, 0, [ 0 ] );
  var expected = [ 1 ];
  test.identical( got, expected );
  test.identical( dst, [ 0, 2, 3, 4 ] )

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayCutin( dst, 0, [] );
  var expected = [ 1 ];
  test.identical( got, expected );
  test.identical( dst, [ 2, 3, 4 ] )

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayCutin( dst, [ 0 ], [] );
  var expected = [ 1, 2, 3, 4 ];
  test.identical( got, expected );
  test.identical( dst, [] )

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var expected = dst.slice().splice( 1 );
  var got = _.arrayCutin( dst, [ 1 ], [ 5 ] );
  test.identical( got, expected );
  test.identical( dst, [ 1, 5 ] )

  /* */

  var dst = [ 1, 2, 3, 4 ];
  var got = _.arrayCutin( dst, [ undefined, 1 ], [ 5 ] );
  test.identical( got, [ 1 ] );
  test.identical( dst, [ 5, 2, 3, 4 ] );

  //

  test.case = 'empth';
  var dst = [];
  var cut = _.arrayCutin( [],[],[] );
  test.identical( cut, [] );
  test.identical( dst, [] );

  /* */

  test.case = 'remove two elements';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 1, 3 ], [] );
  var expected = [ 1, 4, 5 ];
  test.identical( dst, expected );
  var expected = [ 2, 3 ];
  test.identical( cut, expected );

  /* */

  test.case = 'remove two elements and incut three';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 1, 3 ], [ 11, 22, 33 ] );
  var expected = [ 1, 11, 22, 33, 4, 5 ];
  test.identical( dst, expected );
  var expected = [ 2, 3 ];
  test.identical( cut, expected );

  /* */

  test.case = 'pass only begin of range';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 1 ], [ 11, 22, 33 ] );
  var expected = [ 1, 11, 22, 33 ];
  test.identical( dst, expected );
  var expected = [ 2, 3, 4, 5 ];
  test.identical( cut, expected );

  /* */

  test.case = 'pass empty range';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [], [ 11, 22, 33 ] );
  var expected = [ 11, 22, 33 ];
  test.identical( dst, expected );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.identical( cut, expected );

  /* */

  test.case = 'pass number instead of range';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, 1, [ 11, 22, 33 ] );
  var expected = [ 1, 11, 22, 33, 3, 4, 5 ];
  test.identical( dst, expected );
  var expected = [ 2 ];
  test.identical( cut, expected );

  /* */

  test.case = 'no source, number istead of range';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, 1 );
  var expected = [ 1, 3, 4, 5 ];
  test.identical( dst, expected );
  var expected = [ 2 ];
  test.identical( cut, expected );

  /* */

  test.case = 'no source';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 1, 3 ] );
  var expected = [ 1, 4, 5 ];
  test.identical( dst, expected );
  var expected = [ 2, 3 ];
  test.identical( cut, expected );

  /* */

  test.case = 'out of bound, begin';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ -10,2 ],[ 11, 22, 33 ] );
  var expected = [ 11, 22, 33, 3, 4, 5 ];
  test.identical( dst, expected );
  var expected = [ 1, 2 ];
  test.identical( cut, expected );

  /* */

  test.case = 'out of bound, end';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 3,10 ],[ 11, 22, 33 ] );
  var expected = [ 1, 2, 3, 11, 22, 33 ];
  test.identical( dst, expected );
  var expected = [ 4, 5 ];
  test.identical( cut, expected );

  /* */

  test.case = 'out of bound, both sides';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ -10,10 ],[ 11, 22, 33 ] );
  var expected = [ 11, 22, 33 ];
  test.identical( dst, expected );
  var expected = [ 1, 2, 3, 4, 5 ];
  test.identical( cut, expected );

  /* */

  test.case = 'negative, both sides';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ -1, -1 ],[ 11, 22, 33 ] );
  var expected = dst;
  test.identical( dst, expected );
  var expected = [ ];
  test.identical( cut, expected );

  /* */

  test.case = 'zero, both sides';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 0, 0 ],[ 11, 22, 33 ] );
  var expected = dst;
  test.identical( dst, expected );
  var expected = [ ];
  test.identical( cut, expected );

  /* first > last */

  test.case = 'first > last';
  var dst = [ 1, 2, 3, 4, 5 ];
  var cut = _.arrayCutin( dst, [ 9, 0 ],[ 11, 22, 33 ] );
  var expected = dst;
  test.identical( dst, expected );
  var expected = [ ];
  test.identical( cut, expected );

  /* Buffers */

  var list =
  [
    Int8Array,
    Uint8Array,
    Uint8ClampedArray,
    Int16Array,
    Uint16Array,
    Int32Array,
    Uint32Array,
    Float32Array,
    Float64Array,
    ArrayBuffer
  ];

  if( Config.platform === 'nodejs' )
  list.push( Buffer );

  for( var i = 0; i < list.length; i++ )
  {
    test.case = 'buffers: ' + list[ i ].name;

    var array = new list[ i ]( 5 );
    for( var j = 0; j < 5; j++ )
    array[ j ] = j + 1;

    //array [ 1,2,3,4,5 ]

    /* simple cut */

    var got = _.arrayCutin( array, 0 );
    var expected = [ 2, 3, 4, 5 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* simple cut, add one element to begin */

    var got = _.arrayCutin( array, 0, [ 9 ] );
    var expected = [ 9, 2, 3, 4, 5 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* simple cut */

    var got = _.arrayCutin( array, 4 );
    var expected = [ 1, 2, 3, 4 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* range */

    var got = _.arrayCutin( array, [ 0, 1 ] );
    var expected = [ 2, 3, 4, 5 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* range */

    var got = _.arrayCutin( array, [ 2, 5 ] );
    var expected = [ 1, 2 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* single, add new elements to end */

    var got = _.arrayCutin( array, 4, [ 6, 7 ] );
    var expected = [ 1, 2, 3, 4, 6, 7 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* range, add new elements to end */

    var got = _.arrayCutin( array, [ 4, 5 ], [ 6, 7 ] );
    var expected = [ 1, 2, 3, 4, 6, 7 ];
    var expected = _.arrayCutin( new list[ i ]( 1 ), 0, expected );
    test.identical( got,expected );

    /* out of range, returns original */

    var got = _.arrayCutin( array, 10, [ 6, 7 ] );
    var expected = array;
    test.identical( got,expected );

    /* remove all, last index is out of range */

    var got = _.arrayCutin( array, [ 0, 99 ] );
    var expected = new list[ i ]( 0 );
    test.identical( got.byteLength,expected.byteLength );

    /* remove all and fill with new values */

    var got = _.arrayCutin( array, [ 0, 99 ], [ 1, 2, 3, 4, 5 ] );
    var expected = array;
    test.identical( got,expected );

    /* negative */

    var got = _.arrayCutin( array, [ 0, -1 ] );
    var expected = array;
    test.identical( got,expected );

    /* negative */

    var got = _.arrayCutin( array, [ -1, -1 ] );
    var expected = array;
    test.identical( got,expected );

    /* zero, returns original */

    var got = _.arrayCutin( array, [ 0, 0 ], [ 1 ] );
    var expected = array;
    test.identical( got,expected );

    /* empty */

    var got = _.arrayCutin( array, [], [] );
    var got = _.definedIs( got.length ) ? got.length : got.byteLength;
    test.identical( got, 0 );

  }

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayCutin();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayCutin( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'redundant argument';
  test.shouldThrowError( function()
  {
    _.arrayCutin( [ 1, 'a', 'b', 'c', 5 ], [ 2, 3, 4 ], 1, 3, 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.arrayCutin( 'wrong argument', 'wrong argument', 'wrong argument', 'wrong argument' );
  });

  test.case = 'wrong type of argument';
  test.shouldThrowError( function()
  {
    _.arrayCutin( [],[ 'x' ],3 );
  });
};

//

function arrayPut( test )
{

  test.case = 'adds after second element';
  var got = _.arrayPut( [ 1, 2, 3, 4, 5, 6, 9 ], 2, 'str', true, [ 7, 8 ] );
  var expected = [ 1, 2, 'str', true, 7, 8, 9 ];
  test.identical( got, expected );

  test.case = 'adds at the beginning';
  var got = _.arrayPut( [ 1, 2, 3, 4, 5, 6, 9 ], 0, 'str', true, [ 7, 8 ] );
  var expected = [ 'str', true, 7, 8, 5, 6, 9 ];
  test.identical( got, expected );

  test.case = 'add to end';
  var got = _.arrayPut( [ 1,2,3 ], 3, 4, 5, 6 );
  var expected = [ 1, 2, 3, 4, 5, 6 ];
  test.identical( got, expected );

  test.case = 'offset is negative';
  var got = _.arrayPut( [ 1,2,3 ], -1, 4, 5, 6 );
  var expected = [ 5, 6, 3 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPut();
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.arrayPut( 'wrong argument', 'wrong argument', 'str', true, [ 7, 8 ] );
  });

};

//

function arrayFillTimes( test )
{
  test.case = 'empty array';
  var got = _.arrayFillTimes( [], 1 );
  var expected = [ 0 ];
  test.identical( got, expected );

  test.case = 'times is negative, times = length + times';
  var got = _.arrayFillTimes( [ 0, 0, 0 ], -1, 1 );
  var expected = [ 1, 1, 0 ];
  test.identical( got, expected );

  test.case = 'times is negative';
  var got = _.arrayFillTimes( [ 0, 0 ], -2, 1 );
  var expected = [ 0, 0 ];
  test.identical( got, expected );

  test.case = 'empty array, value passed';
  var got = _.arrayFillTimes( [], 1, 1 );
  var expected = [ 1 ];
  test.identical( got, expected );

  test.case = 'empty array, value is an array';
  var got = _.arrayFillTimes( [], 1, [ 1, 2, 3 ] );
  var expected = [ [ 1, 2, 3 ]];
  test.identical( got, expected );

  test.case = 'times > array.length';
  var got = _.arrayFillTimes( [ 0 ], 3, 1 );
  var expected = [ 1, 1, 1 ];
  test.identical( got, expected );

  test.case = 'times < array.length';
  var got = _.arrayFillTimes( [ 0, 0, 0 ], 1, 1 );
  var expected = [ 1, 0, 0 ];
  test.identical( got, expected );

  test.case = 'TypedArray';
  var arr = new Uint16Array();
  var got = _.arrayFillTimes( arr, 3, 1 );
  var expected = new Uint16Array( [ 1, 1, 1 ] );
  test.identical( got, expected );

  test.case = 'ArrayLike without fill routine';
  var arr = (() => arguments )( 1 );
  var got = _.arrayFillTimes( arr, 3, 1 );
  var expected = [ 1, 1, 1 ];
  test.identical( got, expected );

  test.case = 'no fill routine, times is negative';
  var arr = [ 1, 1, 1 ];
  arr.fill = null;
  var got = _.arrayFillTimes( arr, -1, 3 );
  var expected = [ 3, 3, 1 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayFillTimes();

  });

  test.case = 'zero';
  test.shouldThrowError( function()
  {
    _.arrayFillTimes( 0 );
  });

  test.case = 'only one argument';
  test.shouldThrowError( function()
  {
    _.arrayFillTimes( [  ] );
  });

  test.case = 'wrong argument type';
  test.shouldThrowError( function()
  {
    _.arrayFillTimes( new ArrayBuffer(), 1 );
  });

};

function arrayFillWhole( test )
{
  test.case = 'empty array';
  var got = _.arrayFillWhole( [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'empty array, value passed';
  var got = _.arrayFillWhole( [], 1 );
  var expected = [];
  test.identical( got, expected );

  test.case = 'array with elements';
  var got = _.arrayFillWhole( [ 1, 1, 1 ] );
  var expected = [ 0, 0, 0 ];
  test.identical( got, expected );

  test.case = 'array with elements';
  var got = _.arrayFillWhole( [ 1, 1, 1 ], 5 );
  var expected = [ 5, 5, 5 ];
  test.identical( got, expected );

  test.case = 'array with elements';
  var arr = [];
  arr.length = 3;
  var got = _.arrayFillWhole( arr, 5 );
  var expected = [ 5, 5, 5 ];
  test.identical( got, expected );

  test.case = 'TypedArray';
  var arr = new Uint16Array( 3 );
  var got = _.arrayFillWhole( arr );
  var expected = new Uint16Array( [ 0, 0, 0 ] );
  test.identical( got, expected );

  test.case = 'no fill routine';
  var arr = [ 1, 1, 1 ];
  arr.fill = null;
  var got = _.arrayFillWhole( arr, 2 );
  var expected = [ 2, 2, 2 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayFillWhole();

  });

  test.case = 'wrong argument type';
  test.shouldThrowError( function()
  {
    _.arrayFillTimes( new ArrayBuffer(), 1 );
  });

};

//

function arraySupplement( test )
{

  test.case = 'nothing';
  var got = _.arraySupplement( [  ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'only numbers';
  var got = _.arraySupplement( [ 4, 5 ], [ 1, 2, 3 ], [ 6, 7, 8, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
  var expected = [ 4, 5, 33, 13, 9, 7 ];
  test.identical( got, expected );

  test.case = 'only numbers and undefined';
  var got = _.arraySupplement( [ 4, 5 ], [ 1, 2, 3 ], [ 6, 7, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
  var expected = [ 4, 5, 33, 13, undefined, 7 ];
  test.identical( got, expected );

  test.case = 'only numbers';
  var got = _.arraySupplement( [ 'a', 'b' ], [ 1, 2, 3 ], [ 6, 7, 8, true, 9 ], [ 'a', 'b', 33, 13, 'e', 7 ] );
  var expected = [ 6, 7, 33, 13, 9, 7 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySupplement();
  });

  test.case = 'arguments are wrong';
  test.shouldThrowError( function()
  {
    _.arraySupplement( 'wrong argument', 'wrong arguments' );
  });

};

//

function arrayExtendScreening( test )
{

  test.case = 'returns an empty array';
  var got = _.arrayExtendScreening( [  ], [  ], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [  ];
  test.identical( got, expected );

  test.case = 'returns the corresponding values by indexes of the first argument';
  var got = _.arrayExtendScreening( [ 1, 2, 3 ], [  ], [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [ 5, 6, 2 ];
  test.identical( got, expected );

  test.case = 'creates a new array and returns the corresponding values by indexes of the first argument';
  var got = _.arrayExtendScreening( [ 1, 2, 3 ], null, [ 0, 1, 2 ], [ 3, 4 ], [ 5, 6 ] );
  var expected = [ 5, 6, 2 ];
  test.identical( got, expected );

  test.case = 'returns the corresponding values by indexes of the first argument';
  var got = _.arrayExtendScreening( [ 1, 2, 3 ], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
  var expected = [ 'a', 6, 2, 13 ];
  test.identical( got, expected );

  test.case = 'returns the second argument';
  var got = _.arrayExtendScreening( [  ], [ 3, 'abc', 7, 13 ], [ 0, 1, 2 ], [ 3, 4 ], [ 'a', 6 ] );
  var expected = [ 3, 'abc', 7, 13 ];
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayExtendScreening();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayExtendScreening( [ 1, 2, 3, 'abc', 13 ] );
  });

  test.case = 'next arguments are wrong';
  test.shouldThrowError( function()
  {
    _.arrayExtendScreening( [ 1, 2, 3 ], [ 3, 'abc', 7, 13 ], [ 3, 7 ], 'wrong arguments' );
  });

  test.case = 'arguments are wrong';
  test.shouldThrowError( function()
  {
    _.arrayExtendScreening( 'wrong argument', 'wrong argument', 'wrong arguments' );
  });

};

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
  test.shouldThrowError( function()
  {
    _.arrayCompare();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayCompare( [ 1, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayCompare( [ 1, 5 ], [ 1, 2 ], 'redundant argument' );
  });

  test.case = 'wrong type of arguments';
  test.shouldThrowError( function()
  {
    _.arrayCompare( 'wrong argument', 'wrong argument' );
  });

  test.case = 'second array is empty';
  test.shouldThrowError( function()
  {
    _.arrayCompare( [ 1, 5 ], [  ] );
  });

  test.case = 'length of the second array is less than first';
  test.shouldThrowError( function()
  {
    _.arrayCompare( [ 1, 5 ], [ 1 ] );
  });

};

//

function arrayIdentical( test )
{

  test.case = 'empty arrays';
  var got = _.arrayIdentical( [  ], [  ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'arrays are equal';
  var got = _.arrayIdentical( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  var expected = true;
  test.identical( got, expected );

  test.case = 'array-like arguments';
  function src1() {
    return arguments;
  };
  function src2() {
    return arguments;
  };
  var got = _.arrayIdentical( src1( 3, 7, 33 ), src2( 3, 7, 13 ) );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays are not equal';
  var got = _.arrayIdentical( [ 1, 2, 3, 'Hi!' ], [ 1, 2, 3, 'Hello there!' ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'arrays length are not equal';
  var got = _.arrayIdentical( [ 1, 2, 3 ], [ 1, 2 ] );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayIdentical();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayIdentical( [ 1, 2, 3 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayIdentical( [ 1, 2, 3 ], [ 1, 2 ], 'redundant argument' );
  });

};

//

function arrayHasAny( test )
{

  test.case = 'false';
  var got = _.arrayHasAny( [  ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'false';
  var got = _.arrayHasAny( [  ], false, 7 );
  var expected = false;
  test.identical( got, expected );

  test.case = 'true';
  var got = _.arrayHasAny( [ 5, 'str', 42, false ], false, 7 );
  var expected = true;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayHasAny();
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arrayHasAny( 'wrong argument', false, 7 );
  });

};

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
  var got = _.arrayLeftIndex( [ 0,0,0,0 ], 0, 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayLeftIndex( [ 0,0,0,0 ], 0, 3 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayLeftIndex( [ 0,0,0,0 ], 0, -1 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator';
  var got = _.arrayLeftIndex( [ 1,1,2,2,3,3 ], 3, 2, function( el, ins ) { return el < ins } );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator x2';
  var evaluator1 = function( el ) { return el + 1 }
  var evaluator2 = function( ins ) { return ins * 2 }
  var got = _.arrayLeftIndex( [ 6,6,5,5 ], 3, 2, evaluator1, evaluator2 );
  var expected = 2;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'one argument';
  test.shouldThrowError( function()
  {
    var got = _.arrayLeftIndex( [ 1, 2, 3 ] );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayLeftIndex();
  });

  test.case = 'third argument is wrong';
  test.shouldThrowError( function()
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
  var got = _.arrayRightIndex( [ 0,0,0,0 ], 0, 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0,0,0,0 ], 0, 3 );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0,1,1,0 ], 0, 1 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'fromIndex';
  var got = _.arrayRightIndex( [ 0,1,1,0 ], 1, 2 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator';
  var got = _.arrayRightIndex( [ 1,1,2,2,3,3 ], 3, 4, function( el, ins ) { return el < ins } );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'fromIndex + evaluator x2';
  var evaluator1 = function( el ) { return el + 1 }
  var evaluator2 = function( ins ) { return ins * 2 }
  var got = _.arrayRightIndex( [ 6,6,5,5 ], 3, 2, evaluator1, evaluator2 );
  var expected = 2;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'one argument';
  test.shouldThrowError( function()
  {
    var got = _.arrayRightIndex( [ 1, 2, 3 ] );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRightIndex();
  });

  test.case = 'third argument is wrong';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.arrayLeft();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayLeft( [] );
  });

  test.case = 'third argument is wrong';
  test.shouldThrowError( function()
  {
    _.arrayLeft( [ 1, 2, 3 ], 2, 'wrong argument' );
  });

};

//

function arrayCountElement( test )
{

  test.case = 'Empty array';
  var got = _.arrayCountElement( [  ], 3 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'Undefined element';
  var got = _.arrayCountElement( [  ], undefined );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'Null element';
  var got = _.arrayCountElement( [  ], null );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'No match';
  var got = _.arrayCountElement( [ 1, 2, 'str', 10, 10, true ], 'hi' );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'One match - bool';
  var got = _.arrayCountElement( [ 1, 2, 'str', 10, 10, true ], true );
  var expected = 1;
  test.identical( got, expected );

  test.case = 'Two matching - number';
  var got = _.arrayCountElement( [ 1, 2, 'str', 10, 10, true ], 10 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'Three matching - string';
  var got = _.arrayCountElement( [ 'str', 10, 'str', 10, true, 'str' ], 'str' );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'longIs';
  var src = [ 1, 2, 3 ];
  src[ 'a' ] = 1;
  var got = _.arrayCountElement( src, 1 );
  var expected = 1;
  test.identical( got, expected );

  // Evaluators

  test.case = 'Without evaluators - no match';
  var got = _.arrayCountElement( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ], 0 );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'With evaluators - 1 matches';
  var got = _.arrayCountElement( [ [ 1, 3 ], [ 2, 2 ], [ 3, 1 ] ], 1, ( e ) => e[ 1 ], ( e ) => e + 2 );
  var expected = 1;
  test.identical( got, expected );

  test.case = 'With evaluators - 4 matches';
  var got = _.arrayCountElement( [ [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ] ], 0, ( e ) => e[ 0 ], ( e ) => e );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'Without equalizer - two matches';
  var got = _.arrayCountElement( [ true, false, true, false ], true );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'With equalizer - 4 matches';
  var got = _.arrayCountElement( [ true, false, true, false ], true, ( a, b ) => _.typeOf( a ) === _.typeOf( b ) );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'With equalizer - 4 matches';
  var got = _.arrayCountElement( [ 1, 2, 'str', 10, 10, true ], 10, ( a, b ) => _.typeOf( a ) === _.typeOf( b ) );
  var expected = 4;
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountElement();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 1, 2, 3, 'abc', 13 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 1, 2, 3, true ], true, 'redundant argument' );
  });

  test.case = 'first argument is wrong - undefined';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( undefined, true );
  });

  test.case = 'first argument is wrong - null';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( null, true );
  });

  test.case = 'first argument is wrong - string';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( 'wrong argument', true );
  });

  test.case = 'first argument is wrong - number';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( 3, true );
  });

  test.case = 'third argument is wrong - have no arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 3, 4, 5, true ], 3, () => 3 );
  });

  test.case = 'third argument is wrong - have three arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a, b, c ) => _.typeOf( a ) === _.typeOf( b ) === _.typeOf( c ) );
  });

  test.case = 'fourth element is unnacessary';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a, b ) => _.typeOf( a ) === _.typeOf( b ), ( e ) => e );
  });

  test.case = 'fourth argument is wrong - have no arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a, b ) => _.typeOf( a ) === _.typeOf( b ), () => e );
  });

  test.case = 'fourth argument is wrong - have two arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountElement( [ 3, 4, 5, true ], 3, ( a, b ) => _.typeOf( a ) === _.typeOf( b ), ( a, b ) => e );
  });

};

//

function arrayCountTotal( test )
{
  // Zero

  test.case = 'Empty array';
  var got = _.arrayCountTotal( [] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.arrayCountTotal( [ null ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'several nulls';
  var got = _.arrayCountTotal( [ null, null, null ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'Zero';
  var got = _.arrayCountTotal( [ 0 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'Several zeros';
  var got = _.arrayCountTotal( [ 0, 0, 0, 0 ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'Mix of nulls and zeros';
  var got = _.arrayCountTotal( [ 0, null, null, 0, 0, 0, null ] );
  var expected = 0;
  test.identical( got, expected );

  // Array elements are numbers

  test.case = 'Sum of no repeated elements';
  var got = _.arrayCountTotal( [ 1, 3, 5, 7, 9 ] );
  var expected = 25;
  test.identical( got, expected );

  test.case = 'Sum of repeated elements';
  var got = _.arrayCountTotal( [ 2, 2, 4, 4, 6, 6 ] );
  var expected = 24;
  test.identical( got, expected );

  test.case = 'Sum with negative numbers';
  var got = _.arrayCountTotal( [ 2, -3, 4, -4, 6, -7, 8 ] );
  var expected = 6;
  test.identical( got, expected );

  test.case = 'Negative result';
  var got = _.arrayCountTotal( [ 2, -3, 4, -4, 6, -7 ] );
  var expected = -2;
  test.identical( got, expected );

  test.case = 'Zero';
  var got = _.arrayCountTotal( [ 2, -2, 4, -4, 6, -6 ] );
  var expected = 0;
  test.identical( got, expected );

  // Array elements are booleans

  test.case = 'All true';
  var got = _.arrayCountTotal( [ true, true, true, true ] );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'All false';
  var got = _.arrayCountTotal( [ false, false, false, false, false ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'Mix of true and false';
  var got = _.arrayCountTotal( [ false, false, true, false, true, false, false, true ] );
  var expected = 3;
  test.identical( got, expected );

  // Array elements are numbers and booleans

  test.case = 'All true and numbers';
  var got = _.arrayCountTotal( [ true, 2, 1, true, true, 0, true ] );
  var expected = 7;
  test.identical( got, expected );

  test.case = 'All false and numbers';
  var got = _.arrayCountTotal( [ 1, false, 0, false, false, 4, 3, false, false ] );
  var expected = 8;
  test.identical( got, expected );

  test.case = 'Mix of true, false and numbers';
  var got = _.arrayCountTotal( [ false, false, 0, true, false, 10, true, false, false, true, 2 ] );
  var expected = 15;
  test.identical( got, expected );

  test.case = 'Mix of true, false, numbers and null';
  var got = _.arrayCountTotal( [ null, false, false, 0, true, null, false, 10, true, false, false, true, 2, null ] );
  var expected = 15;
  test.identical( got, expected );

  test.case = 'Mix of true, false, numbers and null - negative result';
  var got = _.arrayCountTotal( [ null, false, false, 0, true, null, -8, false, 10, true, false, -9, false, true, 2, null ] );
  var expected = -2;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal();
  });

  test.case = 'Too many arguments';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( [ 1, 2, 3, 'abc', 13 ], [] );
  });

  test.case = 'srcArray is undefined';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( undefined );
  });

  test.case = 'srcArray is null';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( null  );
  });

  test.case = 'srcArray is string';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( 'wrong argument' );
  });

  test.case = 'srcArray is number';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( 3 );
  });

  test.case = 'srcArray contains strings';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( [ 1, '2', 3, 'a' ] );
  });

  test.case = 'srcArray contains arrays';
  test.shouldThrowError( function()
  {
    _.arrayCountTotal( [ 1, [ 2 ], 3, [ null ] ] );
  });

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
  test.shouldThrowError( function()
  {
    _.arrayCountUnique();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ], function( e ) { return e }, 'redundant argument' );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arrayCountUnique( 'wrong argument', function( e ) { return e } );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.arrayCountUnique( [ 1, 1, 2, 'abc', 'abc', 4, true, true ], 'wrong argument' );
  });

};

//

function arraySum( test )
{

  test.case = 'nothing';
  var got = _.arraySum( [  ] );
  var expected = 0;
  test.identical( got, expected );

  test.case = 'returns sum';
  var got = _.arraySum( [ 1, 2, 3, 4, 5 ] );
  var expected = 15;
  test.identical( got, expected );

  test.case = 'returns sum';
  var got = _.arraySum( [ true, false, 13, '33' ], function( e ) { return e * 2 } );
  var expected = 94;
  test.identical( got, expected );

  test.case = 'converts and returns sum';
  var got = _.arraySum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 } );
  var expected = 30;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySum();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySum( [ 1, 2, 3, 4, 5 ], function( e ) { return e * 2 }, 'redundant argument' );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySum( 'wrong argument', function( e ) { return e / 2 } );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySum( [ 1, 2, 3, 4, 5 ], 'wrong argument' );
  });

};

// ---
// array transformation
// ---

//

function arrayPrependUnrolling( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayPrependUnrolling( null );
  test.identical( got, [] );

  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayPrependUnrolling( null, unroll );
  test.identical( got, unroll );

  test.case = 'only dstArray';
  var got = _.arrayPrependUnrolling( [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'dstArray is empty';
  var got = _.arrayPrependUnrolling( [], null );
  test.identical( got, [ null ] );

  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayPrependUnrolling( [], unroll );
  test.identical( got, [ 1, 2, 3 ] );

  test.case = 'simple';
  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayPrependUnrolling( [ 1 ], unroll );
  test.identical( got, [ 1, 2, 3, 1 ] );

  test.case = 'few arguments';
  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayPrependUnrolling( [ 1 ], unroll, [ 'a' ], 4 );
  test.identical( got, [ 1, 2, 3, [ 'a' ], 4, 1 ] );

  test.case = 'with undefined element';
  var unroll = _.unrollMake( [ 1, undefined, 3 ] );
  var got = _.arrayPrependUnrolling( [ 1 ], unroll, [ 'a' ], 4 );
  test.identical( got, [ 1, undefined, 3, [ 'a' ], 4, 1 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependUnrolling();
  });

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependUnrolling( 1, 1 );
  });
}

//

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

  var dst = [ 1,2,3 ];
  var got = _.arrayPrepend( dst, 3 );
  test.identical( got, [ 3,1,2,3 ] );
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
  test.shouldThrowError( function()
  {
    _.arrayPrepend();
  })

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrepend( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayPrependOnce( dst, 4,( e ) => e.num, ( e ) => e );
  test.identical( got, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayPrependOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayPrependOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
     _.arrayPrependOnceStrictly( [ 1,2,3 ], 3 );
  });

  // test.case = 'onEqualize is not a routine';

  // test.shouldThrowError( function()
  // {
  //    _.arrayPrependOnceStrictly( [ 1,2,3 ], 3, 3 );
  // });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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

  var dst = [ 1,2,3 ];
  var got = _.arrayPrepended( dst, 3 );
  test.identical( dst, [ 3,1,2,3 ] );
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
  test.shouldThrowError( function()
  {
    _.arrayPrepended();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrepended( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedOnce( dst, 3 );
  test.identical( dst, [ 1,2,3 ] );
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedOnce( dst, 4, onEqualize );
  test.identical( dst, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayPrependedOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedOnce();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayPrependedOnce( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependedOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayPrependedOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
     _.arrayPrependedOnceStrictly( [ 1,2,3 ], 3 );
  });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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
  test.identical( got, [ 3,1,2,3 ] );
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

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependElement();
  })

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependElement( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayPrependElementOnce( dst, 4,( e ) => e.num, ( e ) => e );
  test.identical( got, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayPrependElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependElementOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependElementOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayPrependElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
     _.arrayPrependElementOnceStrictly( [ 1,2,3 ], 3 );
  });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, 1 );
  test.identical( dst, [ 1, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, 2 );
  test.identical( dst, [ 2, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedElement( dst, 3 );
  test.identical( dst, [ 3,1,2,3 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, '1' );
  test.identical( dst, [ '1', 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, -1 );
  test.identical( dst, [ -1, 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayPrependedElement( dst, [ 1 ] );
  test.identical( dst, [ [ 1 ], 1 ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedElement();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedElement( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedElementOnce( dst, 3 );
  test.identical( dst, [ 1,2,3 ] );
  test.identical( got, undefined );

  var dst = [ false, true, false, true ];
  var got = _.arrayPrependedElementOnce( dst, true );
  test.identical( dst, [ false, true, false, true ] );
  test.identical( got, undefined );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, { num : 4 } );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, undefined );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedElementOnce( dst, 4, onEqualize );
  test.identical( dst, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 4 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayPrependedElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, undefined );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedElementOnce();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayPrependedElementOnce( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayPrependedElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 4 },{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, { num : 4 } );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayPrependedElementOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ 4,{ num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 4 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayPrependedElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayPrependedElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
     _.arrayPrependedElementOnceStrictly( [ 1,2,3 ], 3 );
  });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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
  var got = _.arrayPrependArray( dst,[ 4, 5 ] );
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
  test.shouldThrowError( function ()
  {
    _.arrayPrependArray( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayPrependArray( dst, [ undefined, 2 ] );
  test.identical( dst, [ undefined, 2, 1 ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependArray();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependArray( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrayOnceStrictly( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'one of elements is not unique';

  var dst = [ 1,2,3 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependArrayOnceStrictly( dst, [ 4, 5, 2 ] );
  })
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );

  var dst = [ 1, 1, 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependArrayOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArray();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArray( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'One of args is not unique';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrayOnceStrictly( [ 1, 1, 1 ], [ 1 ] );
  });

  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependArrays( dst,[ 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependArrays( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.is( got === dst );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4 ] ] ];
  var got = _.arrayPrependArrays( dst, insArray );
  test.identical( dst, [ 1, 2, 3, [ 4 ] ] );
  test.is( got === dst );

  var dst = [];
  var insArray = [ 1, 2, 3 ]
  var got = _.arrayPrependArrays( dst, insArray );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ 'a', 1, [ { a : 1 } ], { b : 2 } ];
  var got = _.arrayPrependArrays( dst, insArray );
  test.identical( dst, [  'a', 1, { a : 1 }, { b : 2 }, 1  ] );
  test.is( got === dst );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got;
  var got = _.arrayPrependArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ undefined, 2, 1 ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrays( 1, [ 2 ] );
  });

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowError( function()
  {
    _.arrayPrependArrays( [], 2 );
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'should keep sequence';

  var dst = [ 6 ];
  var src = [ [ 1,2 ], 3, [ 6,4,5,1,2,3 ] ];
  var srcCopy = [ [ 1,2 ], 3, [ 6,4,5,1,2,3 ] ];
  var got = _.arrayPrependArraysOnce( dst, src );
  test.identical( dst, [ 1, 2, 3, 4, 5, 6 ] );
  test.identical( src, srcCopy );
  test.is( got === dst );

  test.case = 'prepends only unique elements';

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependArraysOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', { a : 1 }, { b : 2 }, 1  ] );
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
  test.shouldThrowError( function ()
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
  test.identical( dst, [ undefined, 2, 1 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayPrependArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayPrependArraysOnce( [], [ 1, 2, 3 ], {} );
  });

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  test.case = 'should keep sequence';

  var dst = [ 6 ];
  var src = [ [ 1,2 ], 3, [ 4,5 ] ];
  var srcCopy = [ [ 1,2 ], 3, [ 4,5 ] ];
  var got = _.arrayPrependArraysOnceStrictly( dst, src );
  test.identical( dst, [ 1, 2, 3, 4, 5, 6 ] );
  test.identical( src, srcCopy );
  test.is( got === dst );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var insArray = [ [ 'a' ],[ { a : 1 } ], { b : 2 } ];
  var got = _.arrayPrependArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 'a', { a : 1 }, { b : 2 }, 1  ] );
  test.is( got === dst );

  var dst = [ 0 ];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ] ] ];
  var got = _.arrayPrependArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 1, 2, 3, [ 4, [ 5 ] ], 0 ] );
  test.is( got === dst );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }

  var dst = [ 4,5 ];
  var got = _.arrayPrependArraysOnceStrictly( dst, [ 1, 2, 3 ], onEqualize )
  test.identical( got, [ 1, 2, 3, 4, 5 ] );
  test.identical( dst, got );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, [ undefined, 2 ] );
  });
  test.identical( dst, [ undefined, 2, 1 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependArraysOnceStrictly();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayPrependArraysOnceStrictly( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayPrependArraysOnceStrictly( [], [ 1,2,3 ], {} );
  });

  test.case = 'Same element in insArray and in dstArray';
  var dst = [ 1, 2, 3 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, [ 4, 2, 5 ] );
  })
  test.identical( dst, [ 4, 5, 1, 2, 3 ] )

  var dst = [ 1, 1, 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayPrependedArrays( dst,[ 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArrays( dst, [ 1, 1 ] );
  test.identical( dst, [ 1, 1, 1, 1, 1 ] );
  test.identical( got, 2 );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4 ], 5 ] ];
  var got = _.arrayPrependedArrays( dst, insArray );
  test.identical( dst, [ 1, 2, 3, [ 4 ], 5 ] );
  test.identical( got, 5 );

  var dst = [];
  var got = _.arrayPrependedArrays( dst, [ 1, 2, 3 ]);
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArrays( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [  'a', 1, { a : 1 }, { b : 2 }, 1  ] );
  test.identical( got, 4 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayPrependedArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got;
  var got = _.arrayPrependedArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ undefined, 2, 1 ] );
  test.identical( got, 2 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrays( 1, [ 2 ] );
  });

  test.case = 'second arg is no a ArrayLike';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArrays( [], 2 );
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'should keep sequence';

  var dst = [ 6 ];
  var src = [ [ 1,2 ], 3, [ 6,4,5,1,2,3 ] ];
  var srcCopy = [ [ 1,2 ], 3, [ 6,4,5,1,2,3 ] ];
  var got = _.arrayPrependedArraysOnce( dst, src );
  test.identical( dst, [ 1, 2, 3, 4, 5, 6 ] );
  test.identical( src, srcCopy );
  test.identical( got, 5 );

  test.case = 'prepends only unique elements';

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 4, 5, 1, 2, 3 ] );
  test.identical( got, 2 );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );
  test.identical( got, 0 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 'a', 1, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', { a : 1 }, { b : 2 }, 1  ] );
  test.identical( got, 3 );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ] ] ];
  var got = _.arrayPrependedArraysOnce( dst, insArray );
  test.identical( dst, [ 1, 2, 3, [ 4, [ 5 ] ] ] );
  test.identical( got, 4 );

  var dst = [ 1, 3 ];
  var got = _.arrayPrependedArraysOnce( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 2, 1, 3 ] );
  test.identical( got, 1 );

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
  test.shouldThrowError( function ()
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
  test.identical( dst, [ undefined, 2, 1 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnce();
  });

  // test.case = 'dst is not a array';
  // test.shouldThrowError( function()
  // {
  //   _.arrayPrependedArraysOnce( 1, [ 2 ] );
  // });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnce( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'simple';

  var dst = [];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, 3 );

  test.case = 'prepends only unique elements';

  var dst = [ 1,2,3 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 4, 5, 6 ] );
  test.identical( dst, [ 4, 5, 6, 1, 2, 3 ] );
  test.identical( got, 3 );

  var dst = [ 0, 0, 0 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ 1, 0, 0, 0 ] );
  test.identical( got, 1 );

  test.case = 'mixed arguments types';
  var dst = [ 1 ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 'a', 0, [ { a : 1 } ], { b : 2 } ] );
  test.identical( dst, [ 'a', 0,{ a : 1 }, { b : 2 }, 1  ] );
  test.identical( got, 4 );

  var dst = [];
  var insArray = [ [ 1 ], [ 2 ], [ 3, [ 4, [ 5 ] ] ] ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, insArray );
  test.identical( dst, [ 1, 2, 3, [ 4, [ 5 ] ] ] );
  test.identical( got, 4 );

  var dst = [ '1', '3' ];
  var got = _.arrayPrependedArraysOnceStrictly( dst, [ 1, 2, 3 ] );
  test.identical( dst, [ 1, 2, 3, '1', '3' ] );
  test.identical( got, 3 );

  test.case = 'onEqualize';

  var onEqualize = function onEqualize( a, b )
  {
    return a === b;
  }
  var dst = [ 1, 3 ];
  var insArray = [ 0, 2, 4 ]
  var got = _.arrayPrependedArraysOnceStrictly( dst, insArray, onEqualize );
  test.identical( dst, [ 0, 2, 4, 1, 3 ] );
  test.identical( got, 3 );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
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
  test.identical( dst, [ undefined, 2, 1 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnceStrictly();
  });

  // test.case = 'dst is not a array';
  // test.shouldThrowError( function()
  // {
  //   _.arrayPrependedArraysOnceStrictly( 1, [ 2 ] );
  // }); sfkldb fiubds lkfbds gbkdsfb gkldsfg fdsbfkldsfbdsl gbjs,fn kgn d

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnceStrictly( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 1 ], 2 );
  });

  test.case = 'Elements must be unique';

  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 1, 1, 1 ], [ [ 1 ] ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 1, 2, 3 ], [ [ 4, 5 ], 2 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayPrependedArraysOnceStrictly( [ 6 ], [ [ 1,2 ], 3, [ 6,4,5,1,2,3 ] ] );
  });

}

//

function arrayAppendUnrolling( test )
{
  test.case = 'dstArray is null';
  var got = _.arrayAppendUnrolling( null );
  test.identical( got, [] );

  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayAppendUnrolling( null, unroll );
  test.identical( got, unroll );

  test.case = 'only dstArray';
  var got = _.arrayAppendUnrolling( [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'dstArray is empty';
  var got = _.arrayAppendUnrolling( [], null );
  test.identical( got, [ null ] );

  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayAppendUnrolling( [], unroll );
  test.identical( got, [ 1, 2, 3 ] );

  test.case = 'simple';
  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayAppendUnrolling( [ 1 ], unroll );
  test.identical( got, [ 1, 1, 2, 3 ] );

  test.case = 'few arguments';
  var unroll = _.unrollMake( [ 1, 2, 3 ] );
  var got = _.arrayAppendUnrolling( [ 1 ], unroll, [ 'a' ], 4 );
  test.identical( got, [ 1, 1, 2, 3, [ 'a' ], 4 ] );

  test.case = 'with undefined element';
  var unroll = _.unrollMake( [ 1, undefined, 3 ] );
  var got = _.arrayAppendUnrolling( [ 1 ], unroll, [ 'a' ], 4 );
  test.identical( got, [ 1, 1, undefined, 3, [ 'a' ], 4 ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendUnrolling();
  });

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendUnrolling( 1, 1 );
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
  test.identical( got, [ 1,2 ] );

  var got = _.arrayAppend( [ 1,2,3 ], 3 );
  test.identical( got, [ 1,2,3,3 ] );

  var got = _.arrayAppend( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppend( [ 1 ], -1 );
  test.identical( got, [  1, -1 ] );

  var got = _.arrayAppend( [ 1 ], [ 1 ] );
  test.identical( got, [  1,[ 1 ] ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppend();
  })

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppend( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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
  test.identical( got, [ 1,2 ] );

  var got = _.arrayAppendOnce( [ 1,2,3 ], 3 );
  test.identical( got, [ 1,2,3 ] );

  var got = _.arrayAppendOnce( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppendOnce( [ 1 ], -1 );
  test.identical( got, [ 1, -1 ] );

  var got = _.arrayAppendOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayAppendOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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
  test.identical( got, [ 1,2 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, '1' );
  test.identical( got, [ 1,'1' ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, -1 );
  test.identical( got, [ 1, -1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendOnceStrictly( dst, [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendOnceStrictly( dst,{ num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayAppendOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
    _.arrayAppendOnceStrictly( [ 1,2,3 ], 3 );
  });

  // test.case = 'onEqualize is not a routine';

  // test.shouldThrowError( function()
  // {
  //   _.arrayAppendOnceStrictly( [ 1,2,3 ], 3, 3 );
  // });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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

  var dst = [ 1,2,3 ];
  var got = _.arrayAppended( dst, 3 );
  test.identical( dst, [ 1,2,3,3 ] );
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

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppended();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppended( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedOnce( dst, 3 );
  test.identical( dst, [ 1,2,3 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, '1' );
  test.identical( dst, [ 1,'1' ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, -1 );
  test.identical( dst, [ 1,-1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnce( dst, [ 1 ] );
  test.identical( dst, [ 1,[ 1 ] ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );
  test.identical( got, 3 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );
  test.identical( got, 3 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayAppendedOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedOnce();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayAppendedOnce( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1,'1' ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnceStrictly( dst, -1 );
  test.identical( dst, [ 1,-1 ] );
  test.identical( got, 1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ 1,[ 1 ] ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );
  test.identical( got, 3 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );
  test.identical( got, 3 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedOnceStrictly();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayAppendedOnceStrictly( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedOnceStrictly( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
  {
    _.arrayAppendedOnceStrictly( 1, 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayAppendedOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
    _.arrayAppendedOnceStrictly( [ 1,2,3 ], 3 );
  });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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
  test.identical( got, [ 1,2 ] );

  var got = _.arrayAppendElement( [ 1,2,3 ], 3 );
  test.identical( got, [ 1,2,3,3 ] );

  var got = _.arrayAppendElement( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppendElement( [ 1 ], -1 );
  test.identical( got, [  1, -1 ] );

  var got = _.arrayAppendElement( [ 1 ], [ 1 ] );
  test.identical( got, [  1,[ 1 ] ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendElement();
  })

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendElement( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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
  test.identical( got, [ 1,2 ] );

  var got = _.arrayAppendElementOnce( [ 1,2,3 ], 3 );
  test.identical( got, [ 1,2,3 ] );

  var got = _.arrayAppendElementOnce( [ 1 ], '1' );
  test.identical( got, [ 1, '1' ] );

  var got = _.arrayAppendElementOnce( [ 1 ], -1 );
  test.identical( got, [ 1, -1 ] );

  var got = _.arrayAppendElementOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendElementOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayAppendElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendElementOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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
  test.identical( got, [ 1,2 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, '1' );
  test.identical( got, [ 1,'1' ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, -1 );
  test.identical( got, [ 1, -1 ] );
  test.is( got === dst );

  var dst = [ 1 ];
  var got = _.arrayAppendElementOnceStrictly( dst, [ 1 ] );
  test.identical( got, [ 1, [ 1 ] ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendElementOnceStrictly( dst,{ num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendElementOnceStrictly( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayAppendElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
    _.arrayAppendElementOnceStrictly( [ 1,2,3 ], 3 );
  });

  // test.case = 'onEqualize is not a routine';

  // test.shouldThrowError( function()
  // {
  //   _.arrayAppendOnceStrictly( [ 1,2,3 ], 3, 3 );
  // });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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

  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedElement( dst, 3 );
  test.identical( dst, [ 1,2,3,3 ] );
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

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElement();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElement( [], 1, 1 );
  });

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
  var got = _.arrayAppendedElementOnce( dst, 3 );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( got, false );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, '1' );
  test.identical( dst, [ 1, '1' ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, -1 );
  test.identical( dst, [ 1,-1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnce( dst, [ 1 ] );
  test.identical( dst, [ 1,[ 1 ] ] );
  test.identical( got, [ 1 ] );

  var dst = [ 0, 1, 2 ];
  var got = _.arrayAppendedElementOnce( dst, NaN );
  test.identical( dst, [ 0, 1, 2, NaN ] );
  test.identical( got, NaN );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );
  test.identical( got, { num : 4 } );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, false );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedElementOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );
  test.identical( got, 4 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayAppendedElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, false );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnce();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayAppendedElementOnce( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1,'1' ] );
  test.identical( got, '1' );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnceStrictly( dst, -1 );
  test.identical( dst, [ 1,-1 ] );
  test.identical( got, -1 );

  var dst = [ 1 ];
  var got = _.arrayAppendedElementOnceStrictly( dst, [ 1 ] );
  test.identical( dst, [ 1,[ 1 ] ] );
  test.identical( got, [ 1 ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayAppendedElementOnceStrictly( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 },{ num : 4 } ] );
  test.identical( got, { num : 4 } );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayAppendedElementOnceStrictly( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 }, 4 ] );
  test.identical( got, 4 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnceStrictly();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayAppendedOnceStrictly( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnceStrictly( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnceStrictly( 1, 1, 1 );
  })

  test.case = 'ins already exists in dst';

  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnceStrictly( [ 1 ], 1 );
  });

  test.shouldThrowError( function()
  {
    _.arrayAppendedElementOnceStrictly( [ 1,2,3 ], 3 );
  });

  test.shouldThrowError( function()
  {
    var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
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
//   test.shouldThrowError( function()
//   {
//     _.arrayAppendArray();
//   });
//
//   test.case = 'arguments[0] is wrong, has to be an array';
//   test.shouldThrowError( function()
//   {
//     _.arrayAppendArray( 'wrong argument', 'str', false, { a : 1 }, 42, [ 3, 7, 13 ] );
//   });
//
//   test.case = 'arguments[1] is undefined';
//   test.shouldThrowError( function()
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
  var got = _.arrayAppendArray( dst,[ 4, 5 ] );
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
  test.shouldThrowError( function ()
  {
    _.arrayAppendArray( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayAppendArray( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1,undefined, 2 ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendArray();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendArray( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
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

  test.case = 'appends only unique elements';

  var dst = [ 1,2,3 ];
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
  test.shouldThrowError( function ()
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
  test.identical( dst, [ 1,undefined, 2 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrayOnceStrictly( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'one of elements is not unique';

  var dst = [ 1,2,3 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendArrayOnceStrictly( dst, [ 4, 5, 2 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );

  var dst = [ 1, 1, 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendArrayOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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
  test.shouldThrowError( function ()
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
  test.identical( dst, [ 1,undefined, 2, ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArray();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArray( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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

  /* */

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArrayOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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
  var got = _.arrayAppendedArrayOnce( dst,[ { a : 'a' }, { a : 1 }, { a : [{ y : 2 }] } ], ( e ) => e.a );
  test.identical( dst, [ { a : 1 },{ a : 'a' },{ a : [{ y : 2 }] } ] );
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
  var got = _.arrayAppendedArrayOnce( dst,[ { b : 'a' }, { b : 1 }, { b : [{ y : 2 }] } ], ( e ) => e.a, ( e ) => e.b );
  test.identical( dst, [ { a : 1 },{ b : 'a' },{ b : [{ y : 2 }] } ] );
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
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArrayOnce( dst, undefined, ( e ) => e.a );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnce( [ 1, 2 ], 2, ( e ) => e.a );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
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
  test.shouldThrowError( function ()
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnceStrictly();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnceStrictly( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrayOnceStrictly( [ 1, 2 ], 2 );
  });

  test.case = 'one of elements is not unique';

  var dst = [ 1,2,3 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArrayOnceStrictly( dst, [ 4, 5, 2 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] );

  var dst = [ 1, 1, 1 ];
  test.shouldThrowError( function ()
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

  test.case = 'dstArray is null, src is array';
  var got = _.arrayAppendArrays( null, [ 1 ] );
  test.identical( got, [ 1 ] );

  // test.case = 'dstArray is undefined, src is scalar';
  // var got = _.arrayAppendArrays( undefined, 1 );
  // test.identical( got, 1 );
  //
  // test.case = 'dstArray is undefined, src is array';
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
  var got = _.arrayAppendArrays( dst,[ 4, 5 ] );
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
  var got = _.arrayAppendArrays( dst, [ 1, 2, 3 ]);
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
  test.shouldThrowError( function ()
  {
    _.arrayAppendArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  var got = _.arrayAppendArrays( dst, [ undefined, 2 ] );
  test.identical( dst, [ 1, undefined, 2 ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrays( 1, [ 2 ] );
  });

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
  {
    _.arrayAppendArrays( [], undefined );
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayAppendArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayAppendArraysOnce( [], [ 1, 2, 3 ], [] );
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
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
  var insArray = [ [ 'a' ],[ { a : 1 } ], { b : 2 } ];
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

  var dst = [ 4,5 ];
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendArraysOnceStrictly();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayAppendArraysOnceStrictly( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayAppendArraysOnceStrictly( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'One of ins elements is not unique';
  var dst = [ 1, 2, 3 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, [ 4, 2, 5 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] )

  var dst = [ 1, 1, 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
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
  var got = _.arrayAppendedArrays( dst,[ 4, 5 ] );
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrays();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrays( 1, [ 2 ] );
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArrays( [], undefined );
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArraysOnce( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArraysOnce( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
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
  var insArray = [ [ 'a' ],[ { a : 1 } ], { b : 2 } ];
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

  var dst = [ 4,5 ];
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArraysOnceStrictly();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArraysOnceStrictly( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayAppendedArraysOnceStrictly( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'One of ins elements is not unique';
  var dst = [ 1, 2, 3 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, [ 4, 2, 5 ] );
  })
  test.identical( dst, [ 1, 2, 3, 4, 5 ] )

  var dst = [ 1, 1, 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, [ 1 ] );
  })
  test.identical( dst, [ 1, 1, 1 ] );

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayAppendedArraysOnceStrictly( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not a ArrayLike entity';
  test.shouldThrowError( function()
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

  var dst = [ 2,2,1 ];
  var got = _.arrayRemove( dst, 2 );
  test.identical( dst, [ 1 ] );

  var dst = [ 2,2,1 ];
  var got = _.arrayRemove( dst, 1 );
  test.identical( dst, [ 2,2 ] );

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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemove( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemove( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemove( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemove( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );

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
  test.shouldThrowError( function()
  {
    _.arrayRemove();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemove( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var got = _.arrayRemoveOnce( [ 1,2,2 ], 2 );
  test.identical( got, [ 1,2 ] );

  var got = _.arrayRemoveOnce( [ 1,3,2,3 ], 3 );
  test.identical( got, [ 1,2,3 ] );

  var got = _.arrayRemoveOnce( [ 1 ], '1' );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveOnce( [ 1 ], -1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var onEqualize2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemoveOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 1 },{ num : 3 } ];
  var got = _.arrayRemoveOnce( dst, 1, onEqualize, onEqualize2 );
  test.identical( got, [ { num : 2 },{ num : 1 },{ num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
  {
    _.arrayRemoveOnce( 1, 1, 1 );
  })
}

//

function arrayRemoveOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1,2,3 ];
  var got = _.arrayRemoveOnceStrictly( dst, 2 );
  test.identical( got, [ 1,3 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveOnceStrictly( dst, 3, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveOnceStrictly( 1, 1 );
  })

  test.case = 'ins doesn´t exist';

  test.shouldThrowError( function()
  {
    _.arrayRemoveOnceStrictly( [ 1 ], 2 );
  });

  test.case = 'ins is not unique in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayRemoveOnceStrictly( [ 1, 2, 2 ], 2 );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowError( function()
  {
    _.arrayRemoveOnceStrictly( [ 1,2,3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];

  test.shouldThrowError( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemoveOnceStrictly( dst, { num : 4 }, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )


  test.shouldThrowError( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemoveOnceStrictly( dst, 4, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
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

  var dst = [ 2,2,1 ];
  var got = _.arrayRemoved( dst, 2 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 2 );

  var dst = [ 2,2,1 ];
  var got = _.arrayRemoved( dst, 1 );
  test.identical( dst, [ 2,2 ] );
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoved( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoved( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 1 );


  test.case = 'evaluator 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var evaluator1 = function( a )
  {
    return a.num;
  }
  var evaluator2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemoved( dst, 4, evaluator1 );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );


  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoved( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 1 );


  var dst = [ { num : 1 },{ num : 2 },{ num : 1 },{ num : 3 } ];
  var got = _.arrayRemoved( dst, 1, evaluator1, evaluator2 );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 2 );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoved();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemoved( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ 2,2,1 ];
  var got = _.arrayRemovedOnce( dst, 2 );
  test.identical( dst, [ 2,1 ] );
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemovedOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnce();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemovedOnce( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 } ] );
  test.identical( got, 2 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedOnceStrictly( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly();
  })

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( 1, 1 );
  })

  test.case = 'Simple no match element';
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ ], 1 );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], '1' );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], - 1 );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], [ 1 ] );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], 2 );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ 1 ], - 1 );
  })

  test.case = 'Ins several times in srcArray';
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( [ 2, 2, 1 ], 2 );
  })

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  test.shouldThrowError( function()
  {
    _.arrayRemovedOnceStrictly( dst, { num : 4 }, onEqualize );
  })

}

//

function arrayRemoveElement( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemoveElement( dst, 1 );
  test.identical( dst, [ ] );

  var dst = [ 1 ];
  var got = _.arrayRemoveElement( dst, 1 );
  test.identical( dst, [  ] );

  var dst = [ 2,2,1 ];
  var got = _.arrayRemoveElement( dst, 2 );
  test.identical( dst, [ 1 ] );

  var dst = [ 2,2,1 ];
  var got = _.arrayRemoveElement( dst, 1 );
  test.identical( dst, [ 2,2 ] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveElement( dst, 1 );
  test.identical( dst, [ ] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayRemoveElement( dst, [ 1 ] );
  test.identical( dst, [ 1, 1, 1 ] );

  var dst = [ 1 ];
  var got = _.arrayRemoveElement( dst, '1' );
  test.identical( dst, [ 1 ] );

  var dst = [ 1 ];
  var got = _.arrayRemoveElement( dst, -1 );
  test.identical( dst, [ 1 ] );

  var dst = [ 1 ];
  var got = _.arrayRemoveElement( dst, [ 1 ] );
  test.identical( dst, [ 1 ] );

  var dst = [ { x : 1 } ];
  var got = _.arrayRemoveElement( dst, { x : 1 } );
  test.identical( dst, [ { x : 1 } ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElement( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElement( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemoveElement( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveElement( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 1 arg';

  var dst = [ [ 1 ], [ 1 ], [ 1 ] ];
  var onEqualize = function( a )
  {
    return a[ 0 ];
  }
  var got = _.arrayRemoveElement( dst, [ 1 ], onEqualize );
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
  var got = _.arrayRemoveElement( dst, 1, onEqualize, onEqualize2 );
  test.identical( dst, [ ] );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveElement();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemoveElement( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveElement( 1, 1 );
  })
}

//

function arrayRemoveElementOnce( test )
{
  test.case = 'simple';

  var got = _.arrayRemoveElementOnce( [], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveElementOnce( [ 1 ], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveElementOnce( [ 1,2,2 ], 2 );
  test.identical( got, [ 1,2 ] );

  var got = _.arrayRemoveElementOnce( [ 1,3,2,3 ], 3 );
  test.identical( got, [ 1,2,3 ] );

  var got = _.arrayRemoveElementOnce( [ 1 ], '1' );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveElementOnce( [ 1 ], -1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveElementOnce( [ 1 ], [ 1 ] );
  test.identical( got, [ 1 ] );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( got, [ { num : 2 },{ num : 3 } ] );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var onEqualize2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemoveElementOnce( dst, 4, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 },{ num : 3 } ] );

  var dst = [ { num : 1 },{ num : 2 },{ num : 1 },{ num : 3 } ];
  var got = _.arrayRemoveElementOnce( dst, 1, onEqualize, onEqualize2 );
  test.identical( got, [ { num : 2 },{ num : 1 },{ num : 3 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnce();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnce( 1, 1 );
  })

  test.case = 'onEqualize is not a function';
  test.shouldThrowError( function()
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
//   test.shouldThrowError( function()
//   {
//     _.arrayRemoveElementOnce();
//   });
//
//   test.case = 'not enough arguments';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemoveElementOnce( [ 2, 4, 6 ] );
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemoveElementOnce( [ 2, 4, 6 ], 2, function( el, ins ) { return el > ins }, 'redundant argument' );
//   });
//
//   test.case = 'arguments[0] is wrong';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemoveElementOnce( 'wrong argument', 2 );
//   });
//
//   test.case = 'arguments[2] is wrong';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemoveElementOnce( [ 2, 4, 6 ], 2, 'wrong argument' );
//   });
//
// };

//

function arrayRemoveElementOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1,2,3 ];
  var got = _.arrayRemoveElementOnceStrictly( dst, 2 );
  test.identical( got, [ 1,3 ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveElementOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveElementOnceStrictly( dst, 3, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnceStrictly( 1, 1 );
  })

  test.case = 'ins doesn´t exist';

  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnceStrictly( [ 1 ], 2 );
  });

  test.case = 'ins is not unique in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnceStrictly( [ 1, 2, 2 ], 2 );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowError( function()
  {
    _.arrayRemoveElementOnceStrictly( [ 1,2,3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];

  test.shouldThrowError( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemoveElementOnceStrictly( dst, { num : 4 }, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )


  test.shouldThrowError( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemoveElementOnceStrictly( dst, 4, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
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

  var dst = [ 2,2,1 ];
  var got = _.arrayRemovedElement( dst, 2 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 2 );

  var dst = [ 2,2,1 ];
  var got = _.arrayRemovedElement( dst, 1 );
  test.identical( dst, [ 2,2 ] );
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

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElement( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElement( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 1 );


  test.case = 'evaluator 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var evaluator1 = function( a )
  {
    return a.num;
  }
  var evaluator2 = function( a )
  {
    return a;
  }
  var got = _.arrayRemovedElement( dst, 4, evaluator1 );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );


  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedElement( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 1 );


  var dst = [ { num : 1 },{ num : 2 },{ num : 1 },{ num : 3 } ];
  var got = _.arrayRemovedElement( dst, 1, evaluator1, evaluator2 );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 2 );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElement();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemovedElement( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ 2,2,1 ];
  var got = _.arrayRemovedElementOnce( dst, 2 );
  test.identical( dst, [ 2,1 ] );
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElementOnce( dst, { num : 4 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElementOnce( dst, { num : 1 }, onEqualize );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a )
  {
    return a.num;
  }
  var got = _.arrayRemovedElementOnce( dst, 4, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] );
  test.identical( got, -1 );

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedElementOnce( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, 0 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnce();
  })

  // test.case = 'third is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemovedElementOnce( [], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedElementOnceStrictly( dst, { num : 3 }, onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 } ] );
  test.identical( got, { num : 3 } );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedElementOnceStrictly( dst, 1, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 },{ num : 3 } ] );
  test.identical( got, { num : 1 } );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly();
  })

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [], 1, 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( 1, 1 );
  })

  test.case = 'Simple no match element';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ ], 1 );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], '1' );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], - 1 );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], [ 1 ] );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], 2 );
  })
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 1 ], - 1 );
  })

  test.case = 'Ins several times in srcArray';
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( [ 2, 2, 1 ], 2 );
  })

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  test.shouldThrowError( function()
  {
    _.arrayRemovedElementOnceStrictly( dst, { num : 4 }, onEqualize );
  })

}

//

// function arrayRemovedElementOnce( test )
// {
//
//   test.case = 'nothing';
//   var got = _.arrayRemovedElementOnce( [  ], 2 );
//   var expected = -1;
//   test.identical( got, expected );
//
//   test.case = 'second element removed';
//   var got = _.arrayRemovedElementOnce( [ 2, 4, 6 ], 4 );
//   var expected = 1;
//   test.identical( got, expected );
//
//   test.case = 'first element removed';
//   var got = _.arrayRemovedElementOnce( [ true, false, 6 ], true );
//   var expected = 0;
//   test.identical( got, expected );
//
//   /**/
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no arguments';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedElementOnce();
//   });
//
//   test.case = 'not enough arguments';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedElementOnce( [ 2, 4, 6 ] );
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedElementOnce( [ 2, 4, 6 ], 2, function( el ) { return el; }, 'redundant argument' );
//   });
//
//   test.case = 'arguments[0] is wrong';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedElementOnce( 'wrong argument', 2 );
//   });
//
//   test.case = 'arguments[2] is wrong';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedElementOnce( [ 2, 4, 6 ], 2, 'wrong argument' );
//   });
//
// };
//
//
//
// function arrayRemovedOnceStrictly( test )
// {
//   test.case = 'simple';
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceStrictly( dst, 1 );
//   test.identical( dst, [  ] );
//   test.identical( got, 0 );
//
//   var dst = [ 2,2,1 ];
//   var got = _.arrayRemovedOnceStrictly( dst, 2 );
//   test.identical( dst, [ 2,1 ] );
//   test.identical( got, 0 );
//
//   test.case = 'equalizer 2 args';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var onEqualize = function( a, b )
//   {
//     return a.num === b.num;
//   }
//   var got = _.arrayRemovedOnceStrictly( dst, { num : 3 }, onEqualize );
//   test.identical( dst, [ { num : 1 },{ num : 2 } ] );
//   test.identical( got, 2 );
//
//   test.case = 'equalizer 1 arg';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var got = _.arrayRemovedOnceStrictly( dst, 1, ( e ) => e.num, ( e ) => e );
//   test.identical( dst, [ { num : 2 },{ num : 3 } ] );
//   test.identical( got, 0 );
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no args';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly();
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( [], 1, 1 );
//   })
//
//   test.case = 'dst is not an array';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( 1, 1 );
//   })
//
//   test.case = 'ins not exists';
//
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( [ ], 1 );
//   });
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( [ 1 ], '1' );
//   });
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( [ 1 ], -1 );
//   });
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( [ 1 ], [ 1 ] );
//   });
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceStrictly( [ 1 ], 2 );
//   });
//
//   test.case = 'onEqualize';
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//
//   test.shouldThrowError( function()
//   {
//     var onEqualize = function( a, b )
//     {
//       return a.num === b.num;
//     }
//     _.arrayRemovedOnceStrictly( dst, { num : 4 }, onEqualize );
//   });
//   test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
//
//
//   test.shouldThrowError( function()
//   {
//     var onEqualize = function( a )
//     {
//       return a.num;
//     }
//     _.arrayRemovedOnceStrictly( dst, 4, onEqualize );
//   });
//   test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
//
// }

//
//
// function arrayRemovedElementOnce2( test )
// {
//   test.case = 'simple';
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceElement( dst, 1 );
//   test.identical( dst, [ ] );
//   test.identical( got, 1 );
//
//   var dst = [ 2,2,1 ];
//   var got = _.arrayRemovedOnceElement( dst, 2 );
//   test.identical( dst, [ 2,1 ] );
//   test.identical( got, 2 );
//
//   var dst = [ ];
//   var got = _.arrayRemovedOnceElement( dst, 1 );
//   test.identical( dst, [  ] );
//   test.identical( got, undefined );
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceElement( dst, '1' );
//   test.identical( dst, [ 1 ] );
//   test.identical( got, undefined );
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceElement( dst, - 1 );
//   test.identical( dst, [ 1 ] );
//   test.identical( got, undefined );
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceElement( dst, [ 1 ] );
//   test.identical( dst, [ 1 ] );
//   test.identical( got, undefined );
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceElement( dst, 2 );
//   test.identical( dst, [ 1 ] );
//   test.identical( got, undefined );
//
//
//   test.case = 'equalizer 2 args';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var onEqualize = function( a, b )
//   {
//     return a.num === b.num;
//   }
//   var got = _.arrayRemovedOnceElement( dst, { num : 3 }, onEqualize );
//   test.identical( dst, [ { num : 1 },{ num : 2 } ] );
//   test.identical( got, { num : 3 } );
//
//   var got = _.arrayRemovedOnceElement( dst, { num : 3 }, onEqualize );
//   test.identical( dst, [ { num : 1 },{ num : 2 } ] );
//   test.identical( got, undefined );
//
//   test.case = 'equalizer 1 arg';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var got = _.arrayRemovedOnceElement( dst, 1, ( e ) => e.num, ( e ) => e );
//   test.identical( dst, [ { num : 2 },{ num : 3 } ] );
//   test.identical( got, { num : 1 } );
//
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no args';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElement();
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElement( [], 1, 1 );
//   })
//
//   test.case = 'dst is not an array';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElement( 1, 1 );
//   })
//
// }

//
//
// function arrayRemovedOnceElementStrictly( test )
// {
//   test.case = 'simple';
//
//   var dst = [ 1 ];
//   var got = _.arrayRemovedOnceElementStrictly( dst, 1 );
//   test.identical( dst, [ ] );
//   test.identical( got, 1 );
//
//   var dst = [ 2,2,1 ];
//   var got = _.arrayRemovedOnceElementStrictly( dst, 2 );
//   test.identical( dst, [ 2,1 ] );
//   test.identical( got, 2 );
//
//   test.case = 'equalizer 2 args';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var onEqualize = function( a, b )
//   {
//     return a.num === b.num;
//   }
//   var got = _.arrayRemovedOnceElementStrictly( dst, { num : 3 }, onEqualize );
//   test.identical( dst, [ { num : 1 },{ num : 2 } ] );
//   test.identical( got, { num : 3 } );
//
//   test.case = 'equalizer 1 arg';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var got = _.arrayRemovedOnceElementStrictly( dst, 1, ( e ) => e.num, ( e ) => e );
//   test.identical( dst, [ { num : 2 },{ num : 3 } ] );
//   test.identical( got, { num : 1 } );
//
//
//   //
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'no args';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly();
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [], 1, 1 );
//   })
//
//   test.case = 'dst is not an array';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( 1, 1 );
//   })
//
//   test.case = 'Simple no match element';
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [ ], 1 );
//   })
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [ 1 ], '1' );
//   })
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [ 1 ], - 1 );
//   })
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [ 1 ], [ 1 ] );
//   })
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [ 1 ], 2 );
//   })
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( [ 1 ], - 1 );
//   })
//
//   test.case = 'equalizer 2 args';
//
//   var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
//   var onEqualize = function( a, b )
//   {
//     return a.num === b.num;
//   }
//   test.shouldThrowError( function()
//   {
//     _.arrayRemovedOnceElementStrictly( dst, { num : 4 }, onEqualize );
//   })
//
// }

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
  var got = _.arrayRemoveArray( dst,[ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArray( dst,[ 1,3 ] );
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArray( [ 1 ], undefined );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArray();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArray( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
  var got = _.arrayRemoveArrayOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1,3 ] );
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemoveArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });
}

//

function arrayRemoveArrayOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1,2,3 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 2 ] );
  test.identical( got, [ 1,3 ] );
  test.is( got === dst );

  test.case = 'ins has several values';

  var dst = [ 1, 2, 3, 4, 5, 6, 6 ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 1, 3, 5 ] );
  test.identical( got, [ 2, 4, 6, 6 ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ { num : 3 } ], onEqualize );
  test.identical( got, [ { num : 1 },{ num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 3 ], ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 1 },{ num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 2 args - ins several values';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemoveArrayOnceStrictly( dst, [ 3, 1 ], ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnceStrictly( [ 1, 2, 2 ], [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArrayOnceStrictly( [ 1,2,3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];

  test.shouldThrowError( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemoveArrayOnceStrictly( dst, [ { num : 4 } ], onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )


  test.shouldThrowError( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemoveArrayOnceStrictly( dst, [ 4 ], onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
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

  var dst = [ 1,2,3 ];
  var got = _.arrayRemovedArray( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1,3] );
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'argument is undefined';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArray( [ 1 ], undefined );
  });

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArray();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArray( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
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

  var dst = [ 1,2,3 ];
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnce();
  });

  test.case = 'too many args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnce( [ 1, 2 ],[ 1 ], [ 2 ] );
  });

  test.case = 'second args is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnce( [ 1, 2 ], 2 );
  });

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemovedArrayOnce( [ 1, 2 ], [ 2 ], 3 );
  // });

}

//

function arrayRemovedArrayOnceStrictly( test )
{
  test.case = 'simple';

  var dst = [ 1,2,3 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 2 ] );
  test.identical( dst, [ 1,3 ] );
  test.identical( got, 1 );

  test.case = 'ins has several values';

  var dst = [ 1, 2, 3, 4, 5, 6, 6 ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 1, 3, 5 ] );
  test.identical( dst, [ 2, 4, 6, 6 ] );
  test.identical( got, 3 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ { num : 3 } ], onEqualize );
  test.identical( dst, [ { num : 1 },{ num : 2 } ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 3 ], ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 1 },{ num : 2 } ] );
  test.identical( got, 1 );

  test.case = 'equalizer 2 args - ins several values';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var got = _.arrayRemovedArrayOnceStrictly( dst, [ 3, 1 ], ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 } ] );
  test.identical( got, 2 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnceStrictly( [ 1, 2, 2 ], [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArrayOnceStrictly( [ 1,2,3 ], 3, 3 );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];

  test.shouldThrowError( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    _.arrayRemovedArrayOnceStrictly( dst, [ { num : 4 } ], onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )


  test.shouldThrowError( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    _.arrayRemovedArrayOnceStrictly( dst, [ 4 ], onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
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
  var got = _.arrayRemoveArrays( dst,[ 4, 5 ] );
  test.identical( dst, [ 1, 2, 3 ] );
  test.is( got === dst );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayRemoveArrays( dst,[ 1,3 ] );
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArrays();
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayRemoveArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not longIs entity';
  test.shouldThrowError( function ()
  {
    _.arrayRemoveArrays( [], 1 );
  });

  test.case = 'too many args';
  test.shouldThrowError( function ()
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

  var dst = [ 1,2,3 ];
  var got = _.arrayRemoveArraysOnce( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1,3 ] );
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

  var dst = [ [ 5 ],[ 5 ] ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemoveArraysOnce( dst, insArray );
  test.identical( dst, [ [ 5 ],[ 5 ] ] );
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
  test.identical( got, [ [ 3 ] ]);
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var insArray = [ [ { num : 3 } ], { num : 1 } ];
  var got = _.arrayRemoveArraysOnce( dst, insArray, onEqualize )
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var insArray = [ [ 3 ], 1  ];
  var got = _.arrayRemoveArraysOnce( dst, insArray, ( e ) => e.num, ( e ) => e )
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnce( [  ], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not longIs entity';
  test.shouldThrowError( function ()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var insArray = [ [ { num : 3 } ], { num : 1 }  ]
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray, onEqualize )
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var insArray = [ [ 3 ], 1  ];
  var got = _.arrayRemoveArraysOnceStrictly( dst, insArray, ( e ) => e.num, ( e ) => e );
  test.identical( got, [ { num : 2 } ] );
  test.is( got === dst );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnceStrictly( [ 1, 2, 2 ], [ [ 2 ] ] );
  });

  test.case = 'ins element repeated';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnceStrictly( [ 1, 2, 3, 4, 5 ], [ [ 2, 3 ], 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowError( function()
  {
    _.arrayRemoveArraysOnceStrictly( [], [ 1, 2, 3 ], [] );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];

  test.shouldThrowError( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    var insArray = [ [ { num : 4 } ] ];
    _.arrayRemoveArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )

  test.shouldThrowError( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    var insArray = [ [ 4 ] ];
    _.arrayRemoveArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
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

  var dst = [ 1,2,3 ];
  var got = _.arrayRemovedArrays( dst, [ 2, 4, 5 ] );
  test.identical( dst, [ 1,3 ] );
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

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArrays();
  });

  test.case = 'argument is undefined';
  var dst = [ 1 ];
  test.shouldThrowError( function ()
  {
    _.arrayRemovedArrays( dst, undefined );
  });
  test.identical( dst, [ 1 ] );

  test.case = 'second arg is not longIs entity';
  test.shouldThrowError( function ()
  {
    _.arrayRemovedArrays( [], 1 );
  });

  test.case = 'too many args';
  test.shouldThrowError( function ()
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

  var dst = [ 1,2,3 ];
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

  var dst = [ [ 5 ],[ 5 ] ];
  var insArray = [ [ 5 ] ];
  var got = _.arrayRemovedArraysOnce( dst, insArray );
  test.identical( dst, [ [ 5 ],[ 5 ] ] );
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
  test.identical( dst, [ [ 3 ] ]);
  test.identical( got, 2 );

  test.case = 'array has undefined';
  var dst = [ 1 ];
  test.mustNotThrowError( function ()
  {
    var got = _.arrayRemovedArraysOnce( dst, [ undefined, 2 ] );
    test.identical( dst, [ 1 ] );
    test.identical( got, 0 );
  });

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnce();
  });

  test.case = 'dst is not a array';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnce( 1, [ 2 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnce( [], [ 1, 2, 3 ], [] )
  });

  test.case = 'second arg is not longIs entity';
  test.shouldThrowError( function ()
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

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var onEqualize = function( a, b )
  {
    return a.num === b.num;
  }
  var insArray = [ [ { num : 3 } ], { num : 1 }  ]
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray, onEqualize )
  test.identical( dst, [ { num : 2 } ] );
  test.identical( got, 2 );

  test.case = 'equalizer 1 arg';

  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];
  var insArray = [ [ 3 ], 1  ];
  var got = _.arrayRemovedArraysOnceStrictly( dst, insArray, ( e ) => e.num, ( e ) => e );
  test.identical( dst, [ { num : 2 } ] );
  test.identical( got, 2 );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnceStrictly();
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnceStrictly( 1, 1 );
  })

  test.case = 'ins not exists';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnceStrictly( [ 1 ], [ 2 ] );
  });

  test.case = 'ins repeated in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnceStrictly( [ 1, 2, 2 ], [ [ 2 ] ] );
  });

  test.case = 'ins element repeated';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnceStrictly( [ 1, 2, 3, 4, 5 ], [ [ 2, 3 ], 2 ] );
  });

  test.case = 'onEqualize is not a routine';

  test.shouldThrowError( function()
  {
    _.arrayRemovedArraysOnceStrictly( [], [ 1, 2, 3 ], [] );
  });

  test.case = 'onEqualize';
  var dst = [ { num : 1 },{ num : 2 },{ num : 3 } ];

  test.shouldThrowError( function()
  {
    var onEqualize = function( a, b )
    {
      return a.num === b.num;
    }
    var insArray = [ [ { num : 4 } ] ];
    _.arrayRemovedArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )

  test.shouldThrowError( function()
  {
    var onEqualize = function( a )
    {
      return a.num;
    }
    var insArray = [ [ 4 ] ];
    _.arrayRemovedArraysOnceStrictly( dst, insArray, onEqualize );
  });
  test.identical( dst, [ { num : 1 },{ num : 2 },{ num : 3 } ] )
}

//

function arrayRemoveAll( test )
{
  test.case = 'simple';

  var got = _.arrayRemoveAll( [], 1 );
  test.identical( got, [] );

  var got = _.arrayRemoveAll( [ 1 ], 1 );
  test.identical( got, [ ] );

  var got = _.arrayRemoveAll( [ 1,2,2,2 ], 2 );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveAll( [ 1 ], '1' );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveAll( [ 1 ], -1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayRemoveAll( [ 1 ], [ 1 ] );
  test.identical( got, [ 1 ] );

  function onEqualize( a, b )
  {
    return a.value === b;
  }
  var got = _.arrayRemoveAll( [ { value : 1 }, { value : 1 }, { value : 2 } ], 1, onEqualize );
  test.identical( got, [ { value : 2 } ] );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemoveAll();
  })

  // test.case = 'third argument is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemoveAll( [ 1 ], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveAll( 1, 1 );
  })
}

//

function arrayRemovedAll( test )
{
  test.case = 'simple';

  var dst = [];
  var got = _.arrayRemovedAll( dst, 1 );
  test.identical( dst, [] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedAll( dst, 1 );
  test.identical( dst, [] );
  test.identical( got, 1 );

  var dst = [ 1,2,2 ];
  var got = _.arrayRemovedAll( dst, 2 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 2 );

  var dst = [ 1 ];
  var got = _.arrayRemovedAll( dst, '1' );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedAll( dst, -1 );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  var dst = [ 1 ];
  var got = _.arrayRemovedAll( dst, [ 1 ] );
  test.identical( dst, [ 1 ] );
  test.identical( got, 0 );

  function onEqualize( a, b )
  {
    return a.value === b;
  }
  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayRemovedAll( dst, 1, onEqualize );
  test.identical( dst, [ { value : 2 } ] );
  test.identical( got, 2 );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayRemovedAll();
  })

  // test.case = 'third argument is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemoveAll( [ 1 ], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemovedAll( 1, 1 );
  })
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
  test.shouldThrowError( function()
  {
    _.arrayRemoveDuplicates();
  })

  // test.case = 'more than two args';
  // test.shouldThrowError( function()
  // {
  //   _.arrayRemoveDuplicates( [ 1 ], 1, 1 );
  // })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveDuplicates( 1 );
  })

  test.case = 'dst is not an array';
  test.shouldThrowError( function()
  {
    _.arrayRemoveDuplicates( new Uint8Array([1, 2, 3, 4, 5]) );
  })

  test.case = 'second arg is not a function';
  test.shouldThrowError( function()
  {
    _.arrayRemoveDuplicates( 1, 1 );
  })
}

//

function longRemoveDuplicates( test )
{

  // dst is an array

  test.case = 'empty';

  var dst = [];
  var got = _.longRemoveDuplicates( dst );
  var expected = [];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'No duplicates - One element';

  var dst = [ 1 ];
  var got = _.longRemoveDuplicates( dst );
  var expected = [ 1 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'No duplicates - Several elements';

  var dst = [ 1, 2, 3, '4', '5' ];
  var got = _.longRemoveDuplicates( dst );
  var expected = [ 1, 2, 3, '4', '5' ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'One duplicated element';

  var dst = [ 1, 2, 2 ];
  var got = _.longRemoveDuplicates( dst );
  var expected = [ 1, 2 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'One duplicated element - Several elements';

  var dst = [ 1, 2, 1, 1, 1 ];
  var got = _.longRemoveDuplicates( dst );
  var expected = [ 1, 2 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'Several duplicates several times';

  var dst = [ 1, 2, 3, '4', '4', 1, 2, 1, 5 ];
  var got = _.longRemoveDuplicates( dst );
  var expected = [ 1, 2, 3, '4', 5 ];
  test.identical( dst, expected );
  test.identical( got, expected );

  // dst is a typed array

  test.case = 'empty';

  var dst =  new Uint8Array( 0 );
  var got = _.longRemoveDuplicates( dst );
  var expected = new Uint8Array( [] );
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'No duplicates - One element';

  var dst = new Uint8ClampedArray( [ 300 ] );
  var got = _.longRemoveDuplicates( dst );
  var expected = new Uint8ClampedArray( [ 255 ] );
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'No duplicates - Several elements';

  var dst = new Int8Array( [ 1, 2, 3, '4', '5' ] );
  var got = _.longRemoveDuplicates( dst );
  var expected = new Int8Array( [ 1, 2, 3, '4', '5' ] );
  test.identical( dst, expected );
  test.identical( got, expected );

  test.case = 'One duplicated element - new returned instance';

  var dst = new Int8Array( [ 1, 2, 2 ] );
  var got = _.longRemoveDuplicates( dst );
  var expected = new Int8Array( [ 1, 2 ] );
  test.identical( got, expected );
  test.is( dst !== got );

  test.case = 'One duplicated element - Several elements';

  var dst =  new Uint8ClampedArray( [ -12, 2, - 1, 0, - 11 ] );
  var got = _.longRemoveDuplicates( dst );
  var expected =  new Uint8ClampedArray( [ 0, 2 ] );
  test.identical( got, expected );
  test.is( dst !== got );

  test.case = 'Several duplicates several times';

  var dst = new Int8Array( [ 1, 2, 3, '4', '4', 1, 2, 1, 5 ] );
  var got = _.longRemoveDuplicates( dst );
  var expected = new Int8Array( [ 1, 2, 3, '4', 5 ] );
  test.identical( got, expected );
  test.is( dst !== got );

    // dst is arguments

  function returnArgs( )
  {
    var got = _.longRemoveDuplicates( arguments );
    return got;
  }

  test.case = 'No duplicates';

  var got = returnArgs( 1, '2', 3 );
  var expected = [ 1, '2', 3 ];
  test.identical( got.length, expected.length );
  test.identical( got[ 0 ], expected[ 0 ] );
  test.identical( got[ 1 ], expected[ 1 ] );
  test.identical( got[ 2 ], expected[ 2 ] );

  test.case = 'Duplicates';

  var got = returnArgs( 1, '2', 3, 1, '2', 3 );
  var expected = [ 1, '2', 3 ];
  test.identical( got, expected );

  // Evaluators

  test.case = 'onEqualize';
  var dst =  new Int8Array( [ 1, 2, 3, '4', '4', 1, 2, 1, 5 ] );

  var got  = _.longRemoveDuplicates( dst, function( a, b )
  {
    return  a === b;
  });
  var expected =  new Int8Array( [ 1, 2, 3, '4', 5 ] );
  test.identical( got, expected );
  test.is( dst !== got );

  test.case = 'Evaluator';
  var dst =  new Float32Array( [ 1, 1.1, 1.48483, 1.5782920, 1.9 ] );

  var got  = _.longRemoveDuplicates( dst, function( a )
  {
    return  Math.floor( a );;
  });
  var expected =  new Float32Array( [ 1 ] );
  test.identical( got, expected );
  test.is( dst !== got );

  //

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.longRemoveDuplicates();
  })

  // test.case = 'more than two args';
  // test.shouldThrowError( function()
  // {
  //   _.longRemoveDuplicates( [ 1 ], 1, 1 );
  // })

  test.case = 'dst is not an long';
  test.shouldThrowError( function()
  {
    _.longRemoveDuplicates( 1 );
  })

  test.case = 'second arg is not a function';
  test.shouldThrowError( function()
  {
    _.longRemoveDuplicates( 1, 1 );
  })
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

  var got  = _.arrayFlatten( [], 1, 2, '3'  );
  test.identical( got, [ 1, 2, '3' ] );

  test.case = 'make array flat, dst is not empty';

  var got  = _.arrayFlatten( [ 1, 2, 3 ], [ 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlatten( [ 1, 2, 3 ], [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlatten( [ 1, 2, 3 ],[ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlatten( [ 1, 2, 3 ],[ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlatten( [ 1 ],[ [ [ [ [ 1 ] ] ] ] ]  );
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

  var got  =  _.arrayFlatten( null, 'str', {}, [ 1, 2 ], 5, true );
  test.identical( got, [ 'str', {}, 1, 2, 5, true ] );

  var got = _.arrayFlatten( [ 1,1,3,3, [ 5,5 ] ], 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( null, [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ [ 0 ], [ [ -1, -2 ] ] ], [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ [ 0 ], [ [ -1, -2 ] ], 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  //

  test.open( 'another criteria' );

  test.open( 'single argument' ); //

  var got = _.arrayFlatten([ 0,1,2,3 ])
  var expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ 0,1,0,1 ])
  var expected = [ 0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ [ 0,0 ],[ 1,1 ] ]);
  var expected = [ 0,0,1,1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ [ 0 ],0,1,[ 0,1 ] ]);
  var expected = [ 0,0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ [ [ 0 ] ] ]);
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,1,3,3,5,5 ];
  test.identical( got, expected );

  test.close( 'single argument' ); //

  test.open( 'two arguments' ); //

  var got = _.arrayFlatten([ 0,1,2,3 ])
  var expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ 0,1,0,1 ])
  var expected = [ 0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ [ 0,0 ],[ 1,1 ] ]);
  var expected = [ 0,0,1,1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ [ 0 ],0,1,[ 0,1 ] ]);
  var expected = [ 0,0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlatten([ [ [ 0 ] ] ]);
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlatten( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,1,3,3,5,5 ];
  test.identical( got, expected );

  test.close( 'two arguments' ); //

  test.close( 'another criteria' );

  //

  if( !Config.debug )
  return;

  test.case = 'Empty';
  test.shouldThrowError( function()
  {
    _.arrayFlatten( );
  });
  /*
  test.case = 'Undefined element ina array';
  test.shouldThrowError( function()
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

  var got  = _.arrayFlattenOnce( [ 1, 2, 3 ],[ [ 1 ], [ 2 ], [ 3 ], [ 4 ] ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnce( [ 1, 2, 3 ],[ [ 1, [ 2, [ 3 ] ] ], 4 ] );
  test.identical( got, [ 1, 2, 3, 4 ] );

  var got  = _.arrayFlattenOnce( [ 1 ],[ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
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

  debugger
  var got = _.arrayFlattenOnce( [], 1 );
  test.identical( got, [ 1 ] );

  var got = _.arrayFlattenOnce( [ 1, 1, 3, 3, [ 5,5 ] ], 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( null, [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,3,5 ];
  test.identical( got, expected );

  //

  test.open( 'single argument' );

  var got = _.arrayFlattenOnce([ 0,1,2,3 ]);
  var expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce([ 0,1,0,1 ]);
  var expected = [ 0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce([ [ 0,0 ],[ 1,1 ] ]);
  var expected = [ 0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce([ [ 0 ],0,1,[ 0,1 ] ]);
  var expected = [ 0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce([ 1,[ [ 0 ],1 ],1,0 ]);
  var expected = [ 1,0 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnce( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,3,5 ];
  test.identical( got, expected );

  test.close( 'single argument' );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayFlattenOnce();
  });

  test.case = 'first is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayFlattenOnce( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
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

  debugger

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

  var got = _.arrayFlattenOnceStrictly([ 0, 1, 2, 3 ]);
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly([ 0, [ 1 ] ]);
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly([ [ 0 ], [ 1 ] ]);
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly([ [ 0 ], 1, 2, [ 3, 4 ] ]);
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( got, expected );

  var got = _.arrayFlattenOnceStrictly([ 0,[ [ 2 ], 1 ], 3, 4 ]);
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
  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly();
  });

  test.case = 'first is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly( 1, [ 1 ] );
  });

  // test.case = 'second is not longIs';
  // test.shouldThrowError( function()
  // {
  //   _.arrayFlattenOnceStrictly( [], 1 );

  // });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly( [], [ 1 ], [] );
  });

  test.case = 'Elements must not be repeated';
  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly( [], [ 1, 1, 2, 2, 3, 3 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFlattenOnceStrictly( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 6 ] ] ], 2 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0 ], 0 );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 0 ] ] ], 7 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0, 1, 1 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0 ], 1 );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0, 1, 1 ], 2 );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenOnceStrictly( [ 0, 0 ], [ 1, 2 ] );
  });

  test.shouldThrowError( function()
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

  var dst = [];
  var got  = _.arrayFlattened( dst, 1, 2, '3' );
  test.identical( dst, [ 1, 2, '3' ] );
  test.identical( got, 3 );

  var dst = [ 1,1,3,3, [ 5,5 ] ];
  var got = _.arrayFlattened( dst, 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( dst, expected );
  test.identical( got, 1 );

  //

  test.open( 'single argument' );

  var got = _.arrayFlattened([ 0,1,2,3 ]);
  var expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  var got = _.arrayFlattened([ 0,1,0,1 ]);
  var expected = [ 0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattened([ [ 0,0 ],[ 1,1 ] ]);
  var expected = [ 0,0,1,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattened([ [ 0 ],0,1,[ 0,1 ] ]);
  var expected = [ 0,0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattened([ [ [ 0 ] ] ]);
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,1,3,3,5,5 ];
  test.identical( got, expected );

  var got = _.arrayFlattened( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,1,3,3,5,5 ];
  test.identical( got, expected );

  test.close( 'single argument' );

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayFlattened();
  });

  test.case = 'first is not longIs';
  test.shouldThrowError( function()
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

  var got = _.arrayFlattenedOnce([ 0,1,2,3 ]);
  var expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce([ 0,1,0,1 ]);
  var expected = [ 0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce([ [ 0,0 ],[ 1,1 ] ]);
  var expected = [ 0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce([ [ 0 ],0,1,[ 0,1 ] ]);
  var expected = [ 0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce([ 1,[ [ 0 ],1 ],1,0 ]);
  var expected = [ 1,0 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnce( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,3,5 ];
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
  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnce();
  });

  test.case = 'first is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnce( 1, [ 1 ] );
  });

/*
test.case = 'Too many args';
test.shouldThrowError( function()
{
  _.arrayFlattenedOnce( [ 1 ], 2, 3  );
});
*/

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
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

  var got = _.arrayFlattenedOnceStrictly([ 0, 1, 2, 3 ]);
  var expected = [ 0, 1, 2, 3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly([ 0, [ 1 ] ]);
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly([ [ 0 ], [ 1 ] ]);
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly([ [ 0 ], 1, 2, [ 3, 4 ] ]);
  var expected = [ 0, 1, 2, 3, 4 ];
  test.identical( got, expected );

  var got = _.arrayFlattenedOnceStrictly([ 0, [ [ 1 ], 2 ], 3, 4 ]);
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
  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly();
  });

  test.case = 'first is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly( 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ 1 ], [] );
  });

  test.case = 'Elements must not be repeated';
  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ 1, 1, 2, 2, 3 , 3 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ [ 1 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 3 ]  ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ [ 1, 1, [ 2, 2, [ 3, 3 ] ] ]  ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayFlattenedOnceStrictly( [], [ [ [ [ [ 1, 1, 1 ] ] ] ] ]  );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 6 ] ] ], 2 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0 ], 0 );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 1, 2, 3 ], [ [ 4, [ 5, [ 0 ] ] ], 7 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0, 1, 1 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0 ], 1 );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0, 1, 1 ], 2 );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0 ], [ 1, 2 ] );
  });

  test.shouldThrowError( function()
  {
     _.arrayFlattenedOnceStrictly( [ 0, 0, 1, 1 ], [ 3, 4, [ 5, [ 6 ] ] ] );
  });

}

//

function arrayFlatten2( test )
{

  test.case = 'array of the passed arguments';
  var got = _.arrayFlatten( [],[ 'str', {}, [ 1, 2 ], 5, true ] );
  var expected = [ 'str', {}, 1, 2, 5, true ];
  test.identical( got, expected );

  test.case = 'without undefined';
  var got = _.arrayFlatten( [ 1, 2, 3 ], [ 13, 'abc', null ] );
  var expected = [ 1, 2, 3, 13, 'abc', null ];
  test.identical( got, expected );

  test.case = 'Args are not long';
  var got = _.arrayFlatten( [ 1, 2 ], 13, 'abc', {} );
  var expected = [ 1, 2, 13, 'abc', {} ];
  test.identical( got, expected );


  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.arrayFlatten( [ 1, 2, 3 ], [ 13, 'abc', undefined, null ] ) );

}

function arrayFlattenDefined( test )
{
  test.case = 'make array flat, dst is empty';

  var got  = _.arrayFlattenDefined( null, [] );
  test.identical( got, [] );

  var got  = _.arrayFlattenDefined( [], [] );
  test.identical( got, [] );

  var got  = _.arrayFlattenDefined( null, [ 1, 2, 3 ] );
  test.identical( got, [ 1, 2, 3 ] );

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

  var got  = _.arrayFlattenDefined( [ 1, 2, 3 ],[ [ 1 ], [ 2 ], [ 3 ]  ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [ 1, 2, 3 ],[ [ 1, [ 2, [ 3 ] ] ]  ] );
  test.identical( got, [ 1, 2, 3, 1, 2, 3 ] );

  var got  = _.arrayFlattenDefined( [ 1 ],[ [ [ [ [ 1 ] ] ] ] ]  );
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

  var got = _.arrayFlattenDefined( [ 1,1,3,3, [ 5,5 ] ], 5 );
  var expected = [ 1, 1, 3, 3, [ 5, 5 ], 5 ];
  test.identical( got, expected );

  var got = _.arrayFlattenDefined( null, [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  var got = _.arrayFlattenDefined( [ [ 0 ], [ [ -1, -2 ] ] ], [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ [ 0 ], [ [ -1, -2 ] ], 1, 1, 3, 3, 5, 5 ];
  test.identical( got, expected );

  //

  test.case = 'single argument';

  var got = _.arrayFlattenDefined([ 0,1,2,3 ])
  var expected = [ 0,1,2,3 ];
  test.identical( got, expected );

  var got = _.arrayFlattenDefined([ [ 0,0 ], [ 1,1 ] ]);
  var expected = [ 0,0,1,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenDefined([ [ 0 ],0,1,[ 0,1 ] ]);
  var expected = [ 0,0,1,0,1 ];
  test.identical( got, expected );

  var got = _.arrayFlattenDefined([ [ [ 0 ] ] ]);
  var expected = [ 0 ];
  test.identical( got, expected );

  var got = _.arrayFlattenDefined( [ 1,1,3,3, [ 5,5 ] ] );
  var expected = [ 1,1,3,3,5,5 ];
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'Empty';
  test.shouldThrowError( function()
  {
    _.arrayFlattenDefined( );
  });

  test.case = 'dstArray is not array';
  test.shouldThrowError( function()
  {
    _.arrayFlattenDefined( 1, [ 1 ] );
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
  var expected = [ 1,2,3,4,5 ] ;
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
  test.shouldThrowError( function()
  {
    _.arrayReplace( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplace( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
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
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1,2,3 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'replace just first match';
  var dst = [ 0, 0, 0, 0, 0, 0 ];
  var got = _.arrayReplaceOnce( dst, 0, 1 );
  var expected = [ 1, 0, 0, 0, 0, 0 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'equalize';
  var dst = [ 1,2,3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ],2,3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'second element';
  var dst = [ 1, undefined, 3, 4, 5 ];
  var got = _.arrayReplaceOnceStrictly( dst, undefined, 2 );
  var expected = [ 1,2,3,4,5 ] ;
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
  var dst = [ 1,2,3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceOnceStrictly( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ],2,3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly( [], 0, 0 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly( [ 1,2,3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element two times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, 3, 1 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly( [ 0, 0, 0, 0, 0, 0 ], 0, 1 );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
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
  test.shouldThrowError( function()
  {
    _.arrayReplaced( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaced( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
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
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1,2,3 ];
  test.identical( dst, expected );
  test.identical( got, -1 );

  test.case = 'equalize';
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ],2,3 ];
  test.identical( dst, expected );
  test.identical( got,0 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnceStrictly( [], 0, 0 );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], 1, 4 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, 3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
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
  test.shouldThrowError( function()
  {
    _.arrayReplaceElement( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElement( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElement( 1, 1, 1, 1);
  })
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
  var expected = [ 1,2,3,4,5 ] ;
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
  var dst = [ 1,2,3 ];
  var got = _.arrayReplaceElementOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1,2,3 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'replace just first match';
  var dst = [ 0, 0, 0, 0, 0, 0 ];
  var got = _.arrayReplaceElementOnce( dst, 0, 1 );
  var expected = [ 1, 0, 0, 0, 0, 0 ];
  test.identical( got, expected );
  test.is( got === dst );

  test.case = 'equalize';
  var dst = [ 1,2,3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceElementOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ],2,3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
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
  var dst = [ 1,2,3 ];
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  };
  var got = _.arrayReplaceElementOnceStrictly( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ],2,3 ];
  test.identical( got, expected );
  test.is( got === dst );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly( [], 0, 0 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1,2,3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element two times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, 3, 1 ], [ 1 ], [ 4 ] );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 0, 0, 0, 0, 0, 0 ], 0, 1 );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceElementOnceStrictly( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  var expected = [ 1,2,3,4,5 ] ;
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
  test.shouldThrowError( function()
  {
    _.arrayReplacedElement( );
  })

  test.case = 'first arg is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElement( 1, 1, 1 );
  })

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElement( 1, 1, 1, 1);
  })
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
  var expected = [ 1,2,3,4,5 ] ;
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
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedElementOnce( dst, [ 1 ], [ 4 ] );
  var expected = [ 1,2,3 ];
  test.identical( dst, expected );
  test.identical( got, undefined );

  test.case = 'equalize';
  function onEqualize( a, b )
  {
    return a === b[ 0 ];
  }
  var dst = [ 1,2,3 ];
  var got = _.arrayReplacedElementOnce( dst, [ 1 ], [ 4 ], onEqualize );
  var expected = [ [ 4 ],2,3 ];
  test.identical( dst, expected );
  test.identical( got, [ 1 ] );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnce();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnce( [ 1, 2, undefined, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnce( [ 1, 2, undefined, 4, 5 ], undefined, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3, 4 ], 4, 1 );
  });
*/
  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly();
  });

  test.case = 'nothing';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( [], 0, 0 );
  });

  test.case = 'element several times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], 1, 4 );
  });

  test.case = 'element doesn´t exist';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3 ], [ 1 ], [ 4 ] );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( [ 1, 2, 0, 4, 5 ], 0, 3, 'argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
  {
    _.arrayReplacedElementOnceStrictly( 'wrong argument', 0, 3 );
  });

  test.case = 'second argument is undefined';
  test.shouldThrowError( function()
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
  test.identical( got, [ 1, 1, 1, 0, 0, 0, 1, 0 ] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c', false, 'c', 'b', 'a', true, 2 ];
  var got = _.arrayReplaceArray( dst, [ 'a', 'b', 'c', false, true ], [ 'c', 'a', 'b', true, false ] );
  test.identical( got, [ 'c', 'a', 'b', true, 'b', 'a', 'c', false, 2 ] );
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArray();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArray( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArray( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArray( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayReplaceArray( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'not equal length of ins and sub';
  test.shouldThrowError( function()
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnce();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnce( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnce( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnce( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayReplaceArrayOnce( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'not equal length of ins and sub';
  test.shouldThrowError( function()
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly();
  })

  test.shouldThrowError( function()
  {
    var dst = [ 1, 2, 3 ];
    _.arrayReplaceArrayOnceStrictly( dst, [ undefined ], 0 );
  })

  test.case = 'only one replaced';
  test.shouldThrowError( function()
  {
    var dst = [ 1, 2, 3 ];
    _.arrayReplaceArrayOnceStrictly( dst, [ 1, 0, 4 ], 3 );
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'ins element several times in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 1 ], 1, 2 );
  })
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 2, 3, 4, 1, 2, 3 ], [ 1, 2, 3 ], [ 6, 7, 8 ] );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  })

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dst, ins are empty, sub is not, dst does not has ins';

  test.shouldThrowError( function()
  {
    var dst = [];
    _.arrayReplaceArrayOnceStrictly( dst, [ undefined ], [ 'x' ] );
  });

  test.case = 'dst does not has ins';

  test.shouldThrowError( function()
  {
    var dst = [ 'b', 'c' ];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [ 'a' ], [ 'x' ] );
  });

  test.case = 'dst, sub are empty, ins is not';

  test.shouldThrowError( function()
  {
    var dst = [];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [ 'a', 'b' ], [] );
  });

  test.case = 'only ins is empty';

  test.shouldThrowError( function()
  {
    var dst = [ 'a', 'b', 'c', 'd' ];
    var got = _.arrayReplaceArrayOnceStrictly( dst, [], [ 'x', 'y' ] );
  });

  test.case = 'not equal length of ins and sub';

  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 'c', 3 ] );
  test.identical( got, 3 );

  test.case = 'ins and sub have mirror elements';
  var dst = [ 0, 0, 0, 1, 1, 1 ];
  var got = _.arrayReplacedArray( dst, [ 0, 1 ], [ 1, 0 ] );
  test.identical( dst, [ 1, 1, 1, 0, 0, 0 ] );
  test.identical( got, 6 );

  var dst = [ 0, 0, 0, 1, 1, 1, 0, 1 ];
  var got = _.arrayReplacedArray( dst, [ 1, 0 ], [ 0, 1 ] );
  test.identical( dst, [ 1, 1, 1, 0, 0, 0, 1, 0 ] );
  test.identical( got, 8 );

  var dst = [ 'a', 'b', 'c', false, 'c', 'b', 'a', true, 2 ];
  var got = _.arrayReplacedArray( dst, [ 'a', 'b', 'c', false, true ], [ 'c', 'a', 'b', true, false ] );
  test.identical( dst, [ 'c', 'a', 'b', true, 'b', 'a', 'c', false, 2 ] );
  test.identical( got, 8 );


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
  test.shouldThrowError( function()
  {
    _.arrayReplacedArray();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArray( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArray( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArray( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayReplacedArray( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
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

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnce();
  })

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnce( [ 1 ], [ 1 ], 1 );
  })

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnce( 1, [ 1 ], [ 1 ] );
  })

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnce( [ 1, 2 ], 1, [ 1 ] );
  })

  // test.case = 'onEqualize is not a routine';
  // test.shouldThrowError( function()
  // {
  //   _.arrayReplacedArrayOnce( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  // });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
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

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'onEqualize is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2 ], [ 1 ], [ 1 ], 1 );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

  test.case = 'Repeated elements in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], [ 1 ], [ 2 ] );
  });
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ 1, 2 ], [ 3, 4 ] );
  });
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.case = 'Element not found in dstArray';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrayOnceStrictly( [ 1, 2, 3 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });
  test.shouldThrowError( function()
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
  test.identical( got, [ 1, 1, 1, 2, 0, 1, 1 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 0, 1, 1 ] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 'b', 'a', 'c' ] );
  test.is( got === dst );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ false, true, false, true ] );
  test.is( got === dst );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplaceArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 1, 'b', false, 2, 'c', true, 'a', 0 ] );
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrays();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrays( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrays( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArrays( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
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
  test.identical( got, [ 1, 0, 0, 2, 0, 0, 0 ] );
  test.is( got === dst );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 0, 1, 1, 0 ] );
  test.is( got === dst );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 'b', 'a', 'c' ] );
  test.is( got === dst );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ false, true, true, false ] );
  test.is( got === dst );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplaceArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 1, 'b', false, 2, 'c', true, 'a', 0 ] );
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnce();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnce( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnce( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnce( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
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
  test.identical( got, [ 'b', 'a', 'c' ] );
  test.is( got === dst );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ true, false ] ], [ [ false, true ] ] );
  test.identical( got, [ false, true, true, false ] );
  test.is( got === dst );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( got, [ 1, 'b', false, 2, 'c', true, 'a', 0 ] );
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

  test.case = 'ins element is not in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3 ], [ undefined ], [ 0 ] );
  });

  test.case = 'Repeated elements in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], [ 1 ], [ 2 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ 1, 2 ], [ 3, 4 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayReplaceArraysOnceStrictly( [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 1, 1, 2, 0, 1, 1 ] );
  test.identical( got, 11 );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 0, 0, 1, 1 ] );
  test.identical( got, 4 );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 'b', 'a', 'c' ] );
  test.identical( got, 2 );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ false, true, false, true ] );
  test.identical( got, 4 );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplacedArrays( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 1, 'b', false, 2, 'c', true, 'a', 0 ] );
  test.identical( got, 6 );

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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrays();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrays( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrays( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArrays( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 1, 0, 0, 2, 0, 0, 0 ] );
  test.identical( got, 3 );

  test.case = 'ins and sub Array of arrays with mirror elements';
  var dst = [ 1, 1, 0, 0 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 0, 1, 1, 0 ] );
  test.identical( got, 2 );

  var dst = [ 'a', 'b', 'c' ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 'b', 'a', 'c' ] );
  test.identical( got, 2 );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ false, true, true, false ] );
  test.identical( got, 2 );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplacedArraysOnce( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 1, 'b', false, 2, 'c', true, 'a', 0 ] );
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnce();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnce( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnce( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnce( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
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
  test.identical( dst, [ 'b', 'a', 'c' ]  );
  test.identical( got, 2 );

  var dst = [ true, false, true, false ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ true, false ] ], [ [ false, true ] ] );
  test.identical( dst, [ false, true, true, false ]  );
  test.identical( got, 2 );

  var dst = [ 0, 'a', true, 2, 'c', false, 'b', 1 ];
  var got = _.arrayReplacedArraysOnceStrictly( dst, [ [ 0, 1 ], [ 'a', 'b' ], [ true, false ] ], [ [ 1, 0 ], [ 'b', 'a' ], [ false, true ] ] );
  test.identical( dst, [ 1, 'b', false, 2, 'c', true, 'a', 0 ]  );
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

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly();
  });

  test.case = 'sub is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1 ], [ 1 ], 1 );
  });

  test.case = 'dstArray is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( 1, [ 1 ], [ 1 ] );
  });

  test.case = 'ins is not a longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
  });

  test.case = 'ins and sub don´t have the same length ';
  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 'a', 'b', 'c', 'd' ], [ 'a', 'b', 'c' ], [ 'x', 'y' ] );
  });

  test.case = 'ins element is not in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3 ], [ undefined ], [ 0 ] );
  });

  test.case = 'Repeated elements in dstArray';

  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3, 1, 2, 3 ], [ 1 ], [ 2 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 1, 2, 3, 4, 3, 2, 1 ], [ 1, 2 ], [ 3, 4 ] );
  });

  test.shouldThrowError( function()
  {
    _.arrayReplacedArraysOnceStrictly( [ 0, 0, 1, 1, 2, 2, 3, 3, 4, 4 ], [ 1, 0, 4 ], [ 3, 5, 6 ] );
  });

  test.shouldThrowError( function()
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
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ],[ 3 ] ] );
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
//   var got = _.arrayReplaceArraysOnce( dst, [ [ 1, 2, 3 ] ], [ [ 3,3,3, ] ] );
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
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce();
//   })
//
//   test.case = 'dstArray is not a longIs';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( 1, [ [ 1 ] ], [ 1 ] );
//   })
//
//   test.case = 'ins is not a longIs';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1, 2 ], 1, [ 1 ] );
//   })
//
//   test.case = 'ins must be array of arrays';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1, 2 ],[ 1 ], [ 1 ] );
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1, 2 ], [ [ 1 ] ], [ 1 ], 1 );
//   })
//
//   test.case = 'ins and sub length are different';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1 ], [ [ 1 ] ], [ 10, 20 ] );
//   })
//
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1 ], [ [ 1, 2 ] ], [ 10,20 ] );
//   })
//
//   test.case = 'ins[ 0 ] and sub[ 0 ] length are different';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnce( [ 1 ], [ [ 1 ] ], [ [ 10,20 ] ] );
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
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ],[ 3 ] ] );
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
//   var got = _.arrayReplaceArraysOnceStrictly( dst, [ [ 1, 2, 3 ] ], [ [ 3,3,3, ] ] );
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
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly();
//   })
//
//   test.shouldThrowError( function()
//   {
//     var dst = [ 1, 2, 3 ];
//     _.arrayReplaceArraysOnceStrictly( dst, [ [ [ 1 ] ] ], [ 0 ] );
//   })
//
//   test.case = 'one element is not replaced';
//   test.shouldThrowError( function()
//   {
//     var dst = [ 1, 2, 3 ];
//     _.arrayReplaceArraysOnceStrictly( dst, [ [ 1, [ 2 ], 3 ] ], [ 0 ] );
//   })
//
//   test.case = 'dstArray is not a longIs';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( 1, [ [ 1 ] ], [ 1 ] );
//   })
//
//   test.case = 'ins is not a longIs';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], 1, [ 1 ] );
//   })
//
//   test.case = 'ins must be array of arrays';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1, 2 ],[ 1 ], [ 1 ] );
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1, 2 ], [ [ 1 ] ], [ 1 ], 1 );
//   })
//
//   test.case = 'ins and sub length are different';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1 ], [ [ 1 ] ], [ 10, 20 ] );
//   })
//
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1 ], [ [ 1, 2 ] ], [ 10,20 ] );
//   })
//
//   test.case = 'ins[ 0 ] and sub[ 0 ] length are different';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplaceArraysOnceStrictly( [ 1 ], [ [ 1 ] ], [ [ 10,20 ] ] );
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
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1 ], [ 2 ] ], [ [ 3 ],[ 3 ] ] );
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
//   var got = _.arrayReplacedArraysOnce( dst, [ [ 1, 2, 3 ] ], [ [ 3,3,3, ] ] );
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
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce();
//   })
//
//   test.case = 'dstArray is not a longIs';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( 1, [ [ 1 ] ], [ 1 ] );
//   })
//
//   test.case = 'ins is not a longIs';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1, 2 ], 1, [ 1 ] );
//   })
//
//   test.case = 'ins must be array of arrays';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1, 2 ],[ 1 ], [ 1 ] );
//   })
//
//   test.case = 'onEqualize is not a routine';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1, 2 ], [ [ 1 ] ], [ 1 ], 1 );
//   })
//
//   test.case = 'ins and sub length are different';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1 ], [ [ 1 ] ], [ 10, 20 ] );
//   })
//
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1 ], [ [ 1, 2 ] ], [ 10,20 ] );
//   })
//
//   test.case = 'ins[ 0 ] and sub[ 0 ] length are different';
//   test.shouldThrowError( function()
//   {
//     _.arrayReplacedArraysOnce( [ 1 ], [ [ 1 ] ], [ [ 10,20 ] ] );
//   })
// }
//
//

function arrayReplaceAll( test )
{
  test.case = 'replace all ins with sub';

  var dst = [];
  var got = _.arrayReplaceAll( dst, undefined, 0 );
  test.identical( got, [] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplaceAll( dst, 1, 0 );
  test.identical( got, [ 0, 0, 0 ] );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplaceAll( dst, 1, 0 );
  test.identical( got, [ 0, 2, 0 ] );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplaceAll( dst, 4, 0 );
  test.identical( got, [ 1, 2, 3 ] );

  function onEqualize( a, b )
  {
    return a.value === b;
  }

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplaceAll( dst, 1, { value : 0 }, onEqualize );
  test.identical( got, [ { value : 0 }, { value : 0 }, { value : 2 } ] );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayReplaceAll( );
  });

  test.case = 'first arg is not longIs';
  test.shouldThrowError( function()
  {
    _.arrayReplaceAll( 1, 1, 1 );
  });

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplaceAll( 1, 1, 1, 1);
  });
}

//

function arrayReplacedAll( test )
{
  test.case = 'replace all ins with sub';

  var dst = [];
  var got = _.arrayReplacedAll( dst, undefined, 0 );
  test.identical( got, 0 );
  test.identical( dst, [] );

  var dst = [ 1, 1, 1 ];
  var got = _.arrayReplacedAll( dst, 1, 0 );
  test.identical( got, 3 );
  test.identical( dst, [ 0, 0, 0 ] );

  var dst = [ 1, 2, 1 ];
  var got = _.arrayReplacedAll( dst, 1, 0 );
  test.identical( got, 2 );
  test.identical( dst, [ 0, 2, 0 ] );

  var dst = [ 1, 2, 3 ];
  var got = _.arrayReplacedAll( dst, 4, 0 );
  test.identical( got, 0 );
  test.identical( dst, [ 1, 2, 3 ] );

  function onEqualize( a, b )
  {
    return a.value === b;
  }

  var dst = [ { value : 1 }, { value : 1 }, { value : 2 } ];
  var got = _.arrayReplacedAll( dst, 1, { value : 0 }, onEqualize );
  test.identical( got, 2 );
  test.identical( dst, [ { value : 0 }, { value : 0 }, { value : 2 } ] );

  if( !Config.debug )
  return;

  test.case = 'no args';
  test.shouldThrowError( function()
  {
    _.arrayReplacedAll( );
  });

  test.case = 'first arg is not longIs';
  debugger;
  test.shouldThrowError( function()
  {
    debugger;
    _.arrayReplacedAll( 1, 1, 1 );
  });
  debugger;

  test.case = 'fourth argument is not a routine';
  test.shouldThrowError( function()
  {
    _.arrayReplacedAll( 1, 1, 1, 1 );
  });

}

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
  test.shouldThrowError( function()
  {
    _.arrayUpdate();
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arrayUpdate( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arrayUpdate( [ 1, 2, 3, 4, 5 ], 6, 6, 'redundant argument' );
  });

  test.case = 'arguments[0] is wrong';
  test.shouldThrowError( function()
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
    test.shouldThrowError( () => _.arraySetDiff( c.src1, c.src2 ) );
    else
    test.identical( _.arraySetDiff( c.src1, c.src2 ), c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySetDiff();
  });

  test.case = 'too few arguments';
  test.shouldThrowError( function()
  {
    _.arraySetDiff([ 1, 2, 3, 4 ]);
  });

  test.case = 'too many arguments';
  test.shouldThrowError( function()
  {
    _.arraySetDiff([ 1, 2, 3, 4 ], [ 5, 7, 8, 9 ], [ 13, 15, 17 ]);
  });


  test.case = 'one or both arguments are not longIs entities, numeric arguments';
  test.shouldThrowError( function()
  {
    _.arraySetDiff( 10, 15 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetDiff( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map arguments';
  test.shouldThrowError( function()
  {
    _.arraySetDiff( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
  {
    _.arraySetDiff( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'both arguments are null';
  test.shouldThrowError( function()
  {
    _.arraySetDiff( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowError( function()
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
  var a = [ 3,4,5 ];
  var got = _.arraySetBut( a );
  var expected = [ 3,4,5 ];
  test.identical( got, expected );
  test.is( got === a );

  test.case = 'single not empty argument';
  var a = [ 3,4,5 ];
  var got = _.arraySetBut( null, a );
  var expected = [ 3,4,5 ];
  test.identical( got, expected );
  test.is( got !== a );

  test.case = 'three arguments, same elements';
  var a = [ 3,4,5 ];
  var b = [ 3,4,5 ];
  var c = [ 3,4,5 ];
  var got = _.arraySetBut( a,b,c );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, same elements';
  var a = [ 3,4,5 ];
  var b = [ 3,4,5 ];
  var c = [ 3,4,5 ];
  var got = _.arraySetBut( null,a,b,c );
  var expected = [];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, differet elements';
  var a = [ 3,4,5 ];
  var b = [ 5 ];
  var c = [ 3 ];
  var got = _.arraySetBut( a,b,c );
  var expected = [ 4 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, differet elements';
  var a = [ 3,4,5 ];
  var b = [ 5 ];
  var c = [ 3 ];
  var got = _.arraySetBut( null,a,b,c );
  var expected = [ 4 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the second and third';
  var a = [ 3,4,5 ];
  var b = [];
  var c = [];
  var got = _.arraySetBut( a,b,c );
  var expected = [ 3,4,5 ];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the second and third';
  var a = [ 3,4,5 ];
  var b = [];
  var c = [];
  var got = _.arraySetBut( null,a,b,c );
  var expected = [ 3,4,5 ];
  test.identical( got, expected );
  test.is( got !== a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the first';
  var a = [];
  var b = [ 3,4,5 ];
  var c = [ 3,4,5 ];
  var got = _.arraySetBut( a,b,c );
  var expected = [];
  test.identical( got, expected );
  test.is( got === a );
  test.is( got !== b );
  test.is( got !== c );

  test.case = 'three arguments, no elements in the first';
  var a = [];
  var b = [ 3,4,5 ];
  var c = [ 3,4,5 ];
  var got = _.arraySetBut( null,a,b,c );
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
    test.shouldThrowError( () => _.arraySetBut( c.src, c.but ) );
    else
    test.identical( _.arraySetBut( c.src, c.but ), c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  /* bad arguments */

  test.case = 'not array';
  test.shouldThrowError( function()
  {
    _.arraySetBut( '3' );
  });

  test.case = 'no arguments, the count of arguments doesn\'t match 2';
  test.shouldThrowError( function()
  {
    _.arraySetBut();
  });

  test.case = 'one or both arguments are not longIs entities, numerical arguments';
  test.shouldThrowError( function()
  {
    _.arraySetBut( 5, 8 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetBut( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetBut( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
  {
    _.arraySetBut( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'both arguments are null';
  test.shouldThrowError( function()
  {
    _.arraySetBut( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowError( function()
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
  var got = _.arraySetIntersection( null,a );
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
  var got = _.arraySetIntersection( null,a, b );
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
    test.shouldThrowError( () => _.arraySetIntersection.apply( _,c.args ) );
    else
    test.identical( _.arraySetIntersection.apply( _,c.args ) , c.expected );
  }
  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIntersection();
  });

  test.case = 'one or several arguments are not longIs entities, numerical arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIntersection( 10, 15, 25 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIntersection( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIntersection( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
  {
    _.arraySetIntersection( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'one or more arguments are null';
  test.shouldThrowError( function()
  {
    _.arraySetIntersection( null, null );
  });

  test.case = 'one or more arguments are undefined';
  test.shouldThrowError( function()
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
  var got = _.arraySetUnion( null,a );
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
  var got = _.arraySetUnion( null,a, b );
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
  test.shouldThrowError( function()
  {
    _.arraySetUnion();
  });

  test.case = 'one or several arguments are not longIs entities, numerical arguments';
  test.shouldThrowError( function()
  {
    _.arraySetUnion( 10, 15, 25 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetUnion( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map arguments';
  test.shouldThrowError( function()
  {
    _.arraySetUnion( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
  {
    _.arraySetUnion( [ 1, 2, 3 ], "wrong argument" );
  });

  test.case = 'one or more arguments are null';
  test.shouldThrowError( function()
  {
    _.arraySetUnion( null, null );
  });

  test.case = 'one or more arguments are undefined';
  test.shouldThrowError( function()
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
  var got = _.arraySetContainAll( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, src empty';
  var a = [];
  var b = [ 1 ];
  var got = _.arraySetContainAll( a,b );
  var expected = false;
  test.identical( got, expected );

  test.case = '2 arguments, ins empty';
  var a = [ 1 ];
  var b = [];
  var got = _.arraySetContainAll( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = 'bigger second argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1, 1, 1 ];
  var got = _.arraySetContainAll( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = 'bigger third argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1 ];
  var c = [ 1, 1, 1, 1 ];
  var got = _.arraySetContainAll( a,b,c );
  var expected = true;
  test.identical( got, expected );

  test.case = '4 arguments';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a,b,c,d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 0 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a,b,c,d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 0, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a,b,c,d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 0 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAll( a,b,c,d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 0, 2 ];
  var got = _.arraySetContainAll( a,b,c,d );
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
    console.log( _.toStr( _case,{ levels : 3 } ) );
    if( _case.error )
    test.shouldThrowError( () => _.arraySetContainAll.apply( _,_case.args ) );
    else
    test.identical( _.arraySetContainAll.apply( _,_case.args ) , _case.expected );
  }

  /* special cases */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAll();
  });

  test.case = 'one or both arguments are not longIs entities, numerical arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAll( 5, 8 );
  });

  test.case = 'one or both arguments are not longIs entities, string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAll( 'a', 'c' );
  });

  test.case = 'one or both arguments are not longIs entities, map like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAll( { a : 1, b : 2 }, { c : 3 } );
  });

  test.case = 'wrong arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAll( [ 1, 2, 3, 4 ], 'wrong arguments' );
  });

  test.case = 'both arguments are null';
  test.shouldThrowError( function()
  {
    _.arraySetContainAll( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowError( function()
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
  var got = _.arraySetContainAny( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, src empty';
  var a = [];
  var b = [ 1 ];
  var got = _.arraySetContainAny( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, ins empty';
  var a = [ 1 ];
  var b = [];
  var got = _.arraySetContainAny( a,b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'bigger second argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1, 1, 1 ];
  debugger;
  var got = _.arraySetContainAny( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = 'bigger third argument';
  var a = [ 1, 3 ];
  var b = [ 1, 1 ];
  var c = [ 1, 1, 1, 1 ];
  var got = _.arraySetContainAny( a,b,c );
  var expected = true;
  test.identical( got, expected );

  test.case = '3 arguments, the first is empty';
  var a = [];
  var b = [ 1 ];
  var c = [ 2, 3];
  var got = _.arraySetContainAny( a,b,c );
  var expected = true;
  test.identical( got, expected );

  test.case = '4 arguments';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a,b,c,d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 0 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a,b,c,d );
  var expected = false;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 0, 1 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a,b,c,d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 0 ];
  var d = [ 4, 1, 3, 2 ];
  var got = _.arraySetContainAny( a,b,c,d );
  var expected = true;
  test.identical( got, expected );

  test.case = 'one argument have redundant element';
  var a = [ 1, 2, 3, 4 ];
  var b = [ 1 ];
  var c = [ 3, 1 ];
  var d = [ 4, 1, 0, 2 ];
  var got = _.arraySetContainAny( a,b,c,d );
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
  var got = _.arraySetContainAny([ 33, 4, 5, 'b', 'c' ]);
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
    test.shouldThrowError( () => _.arraySetContainAny.apply( _,c.args ) );
    else
    test.identical( _.arraySetContainAny.apply( _,c.args ) , c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAny();
  });

  test.case = 'one or several arguments are not longIs entities,numeric arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], 15, 25 );
  });

  test.case = 'one or several arguments are not longIs entities,string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], 'dfdf', 'ab' );
  });

  test.case = 'one or several arguments are not longIs entities,map like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetContainAny( [ 33, 4, 5, 'b', 'c' ], { a : 33 }, { b : 44 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
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
  var got = _.arraySetIdentical( a,b );
  var expected = true;
  test.identical( got, expected );

  test.case = '2 arguments, src empty';
  var a = [];
  var b = [ 1 ];
  var got = _.arraySetIdentical( a,b );
  var expected = false;
  test.identical( got, expected );

  test.case = '2 arguments, ins empty';
  var a = [ 1 ];
  var b = [];
  var got = _.arraySetIdentical( a,b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'repeats, bigger second argument';
  var a = [ 1 ];
  var b = [ 1, 1, 1, 1 ];
  var got = _.arraySetIdentical( a,b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'repeats, bigger first argument';
  var a = [ 1, 1, 1, 1 ];
  var b = [ 1 ];
  var got = _.arraySetIdentical( a,b );
  var expected = false;
  test.identical( got, expected );

  test.case = 'repeats';
  var a = [ 1, 3 ];
  var b = [ 1, 1, 1, 1 ];
  var got = _.arraySetIdentical( a,b );
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
    test.shouldThrowError( () => _.arraySetIdentical.apply( _,c.args ) );
    else
    test.identical( _.arraySetIdentical.apply( _,c.args ) , c.expected );
  }

  /* */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical();
  });

  test.case = 'one or 2 arguments are not longIs entities, numeric argument';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical( [ 1, 2, 4, 7, 5 ], 15 );
  });

  test.case = 'one or 2 arguments are not longIs entities, string like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical( 'a', 'a' );
  });

  test.case = 'one or 2 arguments are not longIs entities, map like arguments';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical( { a : 1 }, { b : 3, c : 8 } );
  });

  test.case = 'wrong argument';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical( [ 1, 2, 4, 7, 5 ], "wrong argument" );
  });

  test.case = 'both arguments are null';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical( null, null );
  });

  test.case = 'both arguments are undefined';
  test.shouldThrowError( function()
  {
    _.arraySetIdentical( undefined, undefined );
  });

}

//

var Self =
{

  name : 'Tools/base/l1/Array',
  silencing : 1,
  enabled : 1,
  // verbosity : 9,
  // routine : 'bufferRelen',

  tests :
  {

    // buffer

    bufferFrom : bufferFrom,
    bufferRelen : bufferRelen,
    bufferRetype : bufferRetype,
    bufferRawFrom : bufferRawFrom,
    bufferBytesFrom : bufferBytesFrom,
    bufferNodeFrom : bufferNodeFrom,
    bufferRawFromTyped : bufferRawFromTyped,

    // type test

    arrayIs : arrayIs,
    longIs : longIs,
    constructorLikeArray : constructorLikeArray,
    hasLength : hasLength,

    // producer

    argumentsArrayMake : argumentsArrayMake,
    argumentsArrayFrom : argumentsArrayFrom,

    unrollMake : unrollMake,
    unrollFrom : unrollFrom,

    longMake : longMake,
    longMakeZeroed : longMakeZeroed,

    arrayMake : arrayMake,
    arrayFrom : arrayFrom,
    arrayFromCoercing : arrayFromCoercing,

    scalarAppend : scalarAppend,

    arrayMakeRandom : arrayMakeRandom,
    scalarToVector : scalarToVector,
    arrayFromRange : arrayFromRange,
    arrayAs : arrayAs,

    arrayToMap : arrayToMap,
    arrayToStr : arrayToStr,

    // long

    longAreRepeatedProbe : longAreRepeatedProbe,
    longAllAreRepeated : longAllAreRepeated,
    longAnyAreRepeated : longAnyAreRepeated,
    longNoneAreRepeated : longNoneAreRepeated,

    // array transformer

    arraySub : arraySub,
    // arrayJoin : arrayJoin,
    arrayGrow : arrayGrow,
    arrayResize : arrayResize,
    longSlice : longSlice,
    arrayDuplicate : arrayDuplicate,

    arrayMask : arrayMask,

    arraySelect : arraySelect,

    // array manipulator

    arraySwap : arraySwap,
    arrayCutin : arrayCutin,
    arrayPut : arrayPut,
    // arrayFill : arrayFill,
    arrayFillTimes : arrayFillTimes,
    arrayFillWhole : arrayFillWhole,

    arraySupplement : arraySupplement,
    arrayExtendScreening : arrayExtendScreening,

    // array checker

    arrayCompare : arrayCompare,
    arrayIdentical : arrayIdentical,

    arrayHasAny : arrayHasAny,

    // array sequential search

    arrayLeftIndex : arrayLeftIndex,
    arrayRightIndex : arrayRightIndex,

    arrayLeft : arrayLeft,

    arrayCountElement : arrayCountElement,
    arrayCountTotal : arrayCountTotal,
    arrayCountUnique : arrayCountUnique,

    // array etc

    arraySum : arraySum,

    // array prepend

    arrayPrependUnrolling : arrayPrependUnrolling,

    arrayPrepend : arrayPrepend,
    arrayPrependOnce : arrayPrependOnce,
    arrayPrependOnceStrictly : arrayPrependOnceStrictly,
    arrayPrepended : arrayPrepended,
    arrayPrependedOnce : arrayPrependedOnce,
    arrayPrependedOnceStrictly : arrayPrependedOnceStrictly,

    arrayPrependElement : arrayPrependElement,
    arrayPrependElementOnce : arrayPrependElementOnce,
    arrayPrependElementOnceStrictly : arrayPrependElementOnceStrictly,
    arrayPrependedElement : arrayPrependedElement,
    arrayPrependedElementOnce : arrayPrependedElementOnce,
    arrayPrependedElementOnceStrictly : arrayPrependedElementOnceStrictly,

    arrayPrependArray : arrayPrependArray,
    arrayPrependArrayOnce : arrayPrependArrayOnce,
    arrayPrependArrayOnceStrictly : arrayPrependArrayOnceStrictly,
    arrayPrependedArray : arrayPrependedArray,
    arrayPrependedArrayOnce : arrayPrependedArrayOnce,
    arrayPrependedArrayOnceStrictly : arrayPrependedArrayOnceStrictly,

    arrayPrependArrays : arrayPrependArrays,
    arrayPrependArraysOnce : arrayPrependArraysOnce,
    arrayPrependArraysOnceStrictly : arrayPrependArraysOnceStrictly,
    arrayPrependedArrays : arrayPrependedArrays,
    arrayPrependedArraysOnce : arrayPrependedArraysOnce,
    arrayPrependedArraysOnceStrictly : arrayPrependedArraysOnceStrictly,

    // array append

    arrayAppendUnrolling : arrayAppendUnrolling,

    arrayAppend : arrayAppend,
    arrayAppendOnce : arrayAppendOnce,
    arrayAppendOnceStrictly : arrayAppendOnceStrictly,
    arrayAppended : arrayAppended,
    arrayAppendedOnce : arrayAppendedOnce,
    arrayAppendedOnceStrictly : arrayAppendedOnceStrictly,

    arrayAppendElement : arrayAppendElement,
    arrayAppendElementOnce : arrayAppendElementOnce,
    arrayAppendElementOnceStrictly : arrayAppendElementOnceStrictly,
    arrayAppendedElement : arrayAppendedElement,
    arrayAppendedElementOnce : arrayAppendedElementOnce,
    arrayAppendedElementOnceStrictly : arrayAppendedElementOnceStrictly,

    arrayAppendArray : arrayAppendArray,
    arrayAppendArrayOnce : arrayAppendArrayOnce,
    arrayAppendArrayOnceStrictly : arrayAppendArrayOnceStrictly,
    arrayAppendedArray : arrayAppendedArray,
    arrayAppendedArrayOnce : arrayAppendedArrayOnce,
    arrayAppendedArrayOnceWithSelector : arrayAppendedArrayOnceWithSelector,
    arrayAppendedArrayOnceStrictly : arrayAppendedArrayOnceStrictly,

    arrayAppendArrays : arrayAppendArrays,
    arrayAppendArraysOnce : arrayAppendArraysOnce,
    arrayAppendArraysOnceStrictly : arrayAppendArraysOnceStrictly,
    arrayAppendedArrays : arrayAppendedArrays,
    arrayAppendedArraysOnce : arrayAppendedArraysOnce,
    arrayAppendedArraysOnceStrictly : arrayAppendedArraysOnceStrictly,

    // array remove

    arrayRemove : arrayRemove,
    arrayRemoveOnce : arrayRemoveOnce,
    arrayRemoveOnceStrictly : arrayRemoveOnceStrictly,
    arrayRemoved : arrayRemoved,
    arrayRemovedOnce : arrayRemovedOnce,
    arrayRemovedOnceStrictly : arrayRemovedOnceStrictly,

    arrayRemoveElement : arrayRemoveElement,
    arrayRemoveElementOnce : arrayRemoveElementOnce,
    arrayRemoveElementOnceStrictly : arrayRemoveElementOnceStrictly,
    arrayRemovedElement : arrayRemovedElement,
    arrayRemovedElementOnce : arrayRemovedElementOnce,
    arrayRemovedElementOnceStrictly : arrayRemovedElementOnceStrictly,

    // arrayRemovedOnceStrictly : arrayRemovedOnceStrictly,

    // arrayRemovedElementOnce2 : arrayRemovedElementOnce2,
    // arrayRemovedOnceElementStrictly : arrayRemovedOnceElementStrictly,

    arrayRemoveArray : arrayRemoveArray,
    arrayRemoveArrayOnce : arrayRemoveArrayOnce,
    arrayRemoveArrayOnceStrictly : arrayRemoveArrayOnceStrictly,
    arrayRemovedArray : arrayRemovedArray,
    arrayRemovedArrayOnce : arrayRemovedArrayOnce,
    arrayRemovedArrayOnceStrictly : arrayRemovedArrayOnceStrictly,

    arrayRemoveArrays : arrayRemoveArrays,
    arrayRemoveArraysOnce : arrayRemoveArraysOnce,
    arrayRemoveArraysOnceStrictly : arrayRemoveArraysOnceStrictly,
    arrayRemovedArrays : arrayRemovedArrays,
    arrayRemovedArraysOnce : arrayRemovedArraysOnce,
    arrayRemovedArraysOnceStrictly : arrayRemovedArraysOnceStrictly,

    arrayRemoveAll : arrayRemoveAll,
    // arrayRemoveAll : arrayRemoveAll,
    arrayRemovedAll : arrayRemovedAll,

    arrayRemoveDuplicates : arrayRemoveDuplicates,
    longRemoveDuplicates : longRemoveDuplicates,

    // array flatten

    arrayFlatten : arrayFlatten,
    arrayFlattenOnce : arrayFlattenOnce,
    arrayFlattenOnceStrictly : arrayFlattenOnceStrictly,
    arrayFlattened : arrayFlattened,
    arrayFlattenedOnce : arrayFlattenedOnce,
    arrayFlattenedOnceStrictly : arrayFlattenedOnceStrictly,

    arrayFlatten2 : arrayFlatten2,

    arrayFlattenDefined : arrayFlattenDefined,

    // array replace

    arrayReplace : arrayReplace,
    arrayReplaceOnce : arrayReplaceOnce,
    arrayReplaceOnceStrictly : arrayReplaceOnceStrictly,
    arrayReplaced : arrayReplaced,
    arrayReplacedOnce : arrayReplacedOnce,
    arrayReplacedOnceStrictly : arrayReplacedOnceStrictly,

    arrayReplaceElement : arrayReplaceElement,
    arrayReplaceElementOnce : arrayReplaceElementOnce,
    arrayReplaceElementOnceStrictly : arrayReplaceElementOnceStrictly,
    arrayReplacedElement : arrayReplacedElement,
    arrayReplacedElementOnce : arrayReplacedElementOnce,
    arrayReplacedElementOnceStrictly : arrayReplacedElementOnceStrictly,

    arrayReplaceArray : arrayReplaceArray,
    arrayReplaceArrayOnce : arrayReplaceArrayOnce,
    arrayReplaceArrayOnceStrictly : arrayReplaceArrayOnceStrictly,
    arrayReplacedArray : arrayReplacedArray,
    arrayReplacedArrayOnce : arrayReplacedArrayOnce,
    arrayReplacedArrayOnceStrictly : arrayReplacedArrayOnceStrictly,

    arrayReplaceArrays : arrayReplaceArrays,
    arrayReplaceArraysOnce : arrayReplaceArraysOnce,
    arrayReplaceArraysOnceStrictly : arrayReplaceArraysOnceStrictly,
    arrayReplacedArrays : arrayReplacedArrays,
    arrayReplacedArraysOnce : arrayReplacedArraysOnce,
    arrayReplacedArraysOnceStrictly : arrayReplacedArraysOnceStrictly,

    arrayReplaceAll : arrayReplaceAll,
    arrayReplacedAll : arrayReplacedAll,

    arrayUpdate : arrayUpdate,

    // array set

    arraySetDiff : arraySetDiff,

    arraySetBut : arraySetBut,
    arraySetIntersection : arraySetIntersection,
    arraySetUnion : arraySetUnion,

    arraySetContainAll: arraySetContainAll,
    arraySetContainAny : arraySetContainAny,
    arraySetIdentical : arraySetIdentical

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
