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
// tests
// --

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
  test.identical( got, 0 );

  test.case = 'array';
  var got = _.entitySize( [ 3, undefined, 34 ] );
  var exp = _.look ? 24 : 0;
  test.identical( got, exp );

  test.case = 'argumentsArray';
  var got = _.entitySize( _.argumentsArrayMake( [ 1, null, 4 ] ) );
  var exp = _.look ? 24 : 0;
  test.identical( got, exp );

  test.case = 'unroll';
  var got = _.entitySize( _.argumentsArrayMake( [ 1, 2, 'str' ] ) );
  var exp = _.look ? 19 : 0;
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
  var exp = _.look ? 32 : 0;
  test.identical( got, exp );

  test.case = 'map';
  var got = _.entitySize( { a : 1, b : 2, c : 'str' } );
  var exp = _.look ? 22 : 0;
  test.identical( got, exp );

  test.case = 'HashMap';
  var got = _.entitySize( new Map( [ [ undefined, undefined ], [ 1, 2 ], [ '', 'str' ] ] ) );
  var exp = _.look ? 35 : 0;
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
  var exp = _.look ? 14 : 0;
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
