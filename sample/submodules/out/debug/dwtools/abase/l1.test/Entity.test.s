( function _Entity_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  // _.include( 'wCloner' );
  // _.include( 'wStringsExtra' );

}

var _global = _global_;
var _ = _global_.wTools;
var Self = {};

// --
//
// --

function eachSample( test )
{

  test.case = 'simplest leftToRight : 1'; /* */

  var expected =
  [
    [ 0,2,5 ],[ 1,2,5 ],
    [ 0,3,5 ],[ 1,3,5 ],
    [ 0,4,5 ],[ 1,4,5 ],
  ];

  var got = _.eachSample
  ({
    sets : [ [ 0,1 ],[ 2,3,4 ],[ 5 ] ],
    leftToRight : 1,
  });

  test.identical( got, expected );

  test.case = 'simplest leftToRight : 0'; /* */

  var expected =
  [
    [ 0,2,5 ],[ 0,3,5 ],[ 0,4,5 ],
    [ 1,2,5 ],[ 1,3,5 ],[ 1,4,5 ],
  ];

  var got = _.eachSample
  ({
    sets : [ [ 0,1 ],[ 2,3,4 ],[ 5 ] ],
    leftToRight : 0,
  });

  test.identical( got, expected );

  test.case = 'simplest leftToRight : 1'; /* */

  var expected =
  [
    { a : 0,b : 2,c : 5 },{ a : 1,b : 2,c : 5 },
    { a : 0,b : 3,c : 5 },{ a : 1,b : 3,c : 5 },
    { a : 0,b : 4,c : 5 },{ a : 1,b : 4,c : 5 },
  ];

  var got = _.eachSample
  ({
    sets : { a : [ 0,1 ],b : [ 2,3,4 ], c : [ 5 ] },
    leftToRight : 1,
  });

  test.identical( got, expected );

  test.case = 'simplest leftToRight : 0'; /* */

  var expected =
  [
    { a : 0,b : 2,c : 5 },{ a : 0,b : 3,c : 5 },{ a : 0,b : 4,c : 5 },
    { a : 1,b : 2,c : 5 },{ a : 1,b : 3,c : 5 },{ a : 1,b : 4,c : 5 },
  ];

  var got = _.eachSample
  ({
    sets : { a : [ 0,1 ],b : [ 2,3,4 ], c : [ 5 ] },
    leftToRight : 0,
  });

  test.identical( got, expected );

  logger.log( 'expected',_.toStr( expected,{ levels : 5 } ) );
  logger.log( 'got',_.toStr( got,{ levels : 5 } ) );

}

//

function entityMap( test )
{

  var entity1 = [ 3, 4, 5 ],
    entity2 = { '3' : 3, '4' : 4, '5' : 5 },
    expected1 = [ 9, 16, 25 ],
    expected2 = { '3' : 9, '4' : 16, '5' : 25 },
    expected3 = entity1.slice();

  function constr1()
  {
    this.a = 1;
    this.b = 3;
    this.c = 4;
  }
  var entity4 = new constr1(),
    expected4 = { a : '1a', b : '9b', c : '16c' };


  function callback1(v, i, ent )
  {
    return v * v;
  };

  function callback2( v, i, ent )
  {
    return v * v + i;
  };

  function callback3( v, i, ent )
  {
    if( externEnt ) externEnt = ent;
    return v * v + i;
  };

  test.case = 'simple test with mapping array by sqr';
  var got = _.entityMap( entity1, callback1 );
  test.identical( got,expected1 );

  test.case = 'simple test with mapping array by sqr : source array should not be modified';
  var got = _.entityMap( entity1, callback1 );
  test.identical( entity1, expected3 );

  test.case = 'simple test with mapping object by sqr';
  var got = _.entityMap( entity2, callback1 );
  test.identical( got,expected2 );

  test.case = 'simple test with mapping object by sqr : using constructor';
  var got = _.entityMap( entity4, callback2 );
  test.identical( got, expected4 );

  test.case = 'simple test with mapping object by sqr : check constructor';
  test.identical( got instanceof constr1, true );

  test.case = 'simple test with mapping object by sqr : check callback arguments';
  var externEnt = {};
  var got = _.entityMap( entity4, callback3 );
  test.identical( externEnt, entity4 );

  if( Object.is )
  {
    test.case = 'simple test with mapping object by sqr : source object should be unmodified';
    test.identical( Object.is( got, entity4 ), false );
  }

  /**/

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( function()
  {
    _.entityMap();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.entityMap( [ 1,3 ], callback1, callback2 );
  });

  test.case = 'passed argument is not ArrayLike, ObjectLike';
  test.shouldThrowError( function()
  {
    _.entityFilter( 44, callback1 );
  });

  test.case = 'second argument is not routine';
  test.shouldThrowError( function()
  {
    _.entityMap( [ 1,3 ], 'callback' );
  });

};

//

function entityFilter( test )
{
  var entity1 = [ 9, -16, 25, 36, -49 ],
    entity2 = { '3' : 9, '4' : 16, '5' : 25 },
    expected1 = [ 3, 5, 6 ],
    expected2 = { '3' : 3, '4' : 4, '5' : 5 },
    expected3 = entity1.slice();

  function callback1( v, i, ent )
  {
    if( v < 0 ) return;
    return Math.sqrt( v );
  };

  function testFn1()
  {
    return _.entityFilter( arguments, callback1 );
  }

  test.case = 'simple test with mapping array by sqrt';
  var got = _.entityFilter( entity1, callback1 );
  test.identical( got,expected1 );

  /*
    TODO : need to check actuality of this test

    test.case = 'simple test with longIs';
    var got = null;
    try
    {
      got = testFn1( 9, -16, 25, 36, -49 );

    }
    catch(e)
    {
      console.log(' test throws errror, but should not ');
      console.log(e);
    }
    finally
    {
      test.identical( got, expected1 );
    }
  */

  test.case = 'simple test with mapping array by sqrt : source array should not be modified';
  var got = _.entityFilter( entity1, callback1 );
  test.identical( entity1, expected3 );

  test.case = 'simple test with mapping object by sqrt';
  var got = _.entityFilter( entity2, callback1 );
  test.identical( got,expected2 );

  test.case = 'simple test with mapping array by sqrt';
  var got = _.entityFilter( entity1, callback1 );
  test.identical( got,expected1 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'missed arguments';
  test.shouldThrowError( function()
  {
    _.entityFilter();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.entityFilter( [ 1,3 ], callback1, callback2 );
  });

  test.case = 'passed argument is not ArrayLike, ObjectLike';
  test.shouldThrowError( function()
  {
    _.entityFilter( 44, callback1 );
  });

  test.case = 'second argument is not routine';
  test.shouldThrowError( function()
  {
    _.entityFilter( [ 1,3 ], 'callback' );
  });

};

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
  var src = { src : 'string', num : 123, clone : function() { var clone = _.cloneObject( { src : this } ); return clone; } }
  var got = _.entityAssign( dst, src  );
  var expected = src;
  test.identical( got, expected );

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

function entityCoerceTo( test )
{

  test.case = 'string & num';
  var src = '5';
  var ins =  1
  var got = typeof( _.entityCoerceTo( src, ins ) );
  var expected = typeof( ins );
  test.identical( got, expected );

  test.case = 'num to string';
  var src = 1;
  var ins =  '5';
  var got = typeof( _.entityCoerceTo( src, ins ) );
  var expected = typeof( ins );
  test.identical( got, expected );

  test.case = 'to boolean';
  var src = 1;
  var ins =  true;
  var got = typeof( _.entityCoerceTo( src, ins ) );
  var expected = typeof( ins );
  test.identical( got, expected );

  test.case = 'object and num';
  var src = { a : 1 };
  var ins =  1;
  var got = typeof( _.entityCoerceTo( src, ins ) );
  var expected = typeof( ins );
  test.identical( got, expected );

  test.case = 'array and string';
  var src = [ 1, 2, 3 ];
  var ins =  'str';
  var got = typeof( _.entityCoerceTo( src, ins ) );
  var expected = typeof( ins );
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'argument missed';
  test.shouldThrowError( function()
  {
    _.entityCoerceTo( );
  });

  test.case = 'unknown type';
  test.shouldThrowError( function()
  {
    _.entityCoerceTo( 1, { a : 1 }  );
  });

}

//

function entityHasNan( test )
{

  test.case = 'undefined';
  var got = _.entityHasNan( undefined );
  var expected = true;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.entityHasNan( 150 );
  var expected = false;
  test.identical( got, expected );

  test.case = 'null';
  var got = _.entityHasNan( null );
  var expected = false;
  test.identical( got, expected );

  test.case = 'array';
  var got = _.entityHasNan( [ 1,'A2',3 ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.entityHasNan( { a : 1, b : 2 } );
  var expected = false;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'argument missed';
  test.shouldThrowError( function()
  {
    _.entityHasNan( );
  });

}

//

function entityHasUndef( test )
{

  test.case = 'undefined';
  var got = _.entityHasUndef( undefined );
  var expected = true;
  test.identical( got, expected );

  test.case = 'number';
  var got = _.entityHasUndef( 150 );
  var expected = false;
  test.identical( got, expected );

  test.case = 'array';
  var got = _.entityHasUndef( [ 1,'2',3 ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.entityHasUndef( { a : 1, b : 2 } );
  var expected = false;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'argument missed';
  test.shouldThrowError( function()
  {
    _.entityHasUndef( );
  });

}

//

function entitySize( test )
{

  test.case = 'string';
  var got = _.entitySize( 'str' );
  var expected = 3 ;
  test.identical( got, expected );

  test.case = 'atomic type';
  var got = _.entitySize( 6 );
  var expected = null;
  test.identical( got, expected );

  test.case = 'buffer';
  var got = _.entitySize( new ArrayBuffer( 10 ) );
  var expected = 10;
  test.identical( got, expected );

  test.case = 'arraylike';
  var got = _.entitySize( [ 1, 2, 3 ] );
  var expected = 3;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.entitySize( { a : 1, b : 2 } );
  var expected = null;
  test.identical( got, expected );

  test.case = 'empty call';
  var got = _.entitySize( undefined );
  var expected = null;
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

function entityValueWithIndex( test )
{
  test.case = 'array';
  var got = _.entityValueWithIndex( [ [ 1, 2, 3 ] ], 0 );
  var expected = [ 1, 2, 3 ] ;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.entityValueWithIndex( { a : 1, b : [ 1, 2, 3 ] }, 1 );
  var expected = [ 1, 2, 3 ] ;
  test.identical( got, expected );

  test.case = 'string';
  var got = _.entityValueWithIndex( 'simple string', 5 );
  var expected = 'e' ;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex();
  });

  test.case = 'no selector';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex( [ 1 ] );
  });

  test.case = 'bad selector';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex( [ 0 ],'1' );
  });

  test.case = 'bad arguments';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex( true,0 );
  });

  test.case = 'bad arguments';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex( 1,2 );
  });

  test.case = 'bad arguments';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex( 1,undefined );
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.entityValueWithIndex( [ 0 ],0,0 );
  });

}

//

function entityKeyWithValue( test )
{
  test.case = 'array';
  var got = _.entityKeyWithValue( [ 1, 2, 3 ], 3 );
  var expected =  2;
  test.identical( got, expected );

  test.case = 'array#2';
  var got = _.entityKeyWithValue( [ 1, 2, 3 ], 'a' );
  var expected =  null;
  test.identical( got, expected );

  test.case = 'object';
  var got = _.entityKeyWithValue( { a : 1, b : 'a' }, 'a' );
  var expected =  'b';
  test.identical( got, expected );

  test.case = 'value undefined';
  var got = _.entityKeyWithValue( [ 1, 2, 3 ], undefined );
  var expected =  null;
  test.identical( got, expected );

  test.case = 'value string';
  var got = _.entityKeyWithValue( [ 0 ],'1' );
  var expected =  null;
  test.identical( got, expected );

  test.case = 'value string';
  var got = _.entityKeyWithValue( [ 0 ],'1' );
  var expected =  null;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.entityKeyWithValue();
  });

  test.case = 'no selector';
  test.shouldThrowError( function()
  {
    _.entityKeyWithValue( [ 1 ] );
  });

  test.case = 'bad arguments';
  test.shouldThrowError( function()
  {
    _.entityKeyWithValue( true,0 );
  });

  test.case = 'bad arguments';
  test.shouldThrowError( function()
  {
    _.entityKeyWithValue( 1,2 );
  });

  test.case = 'bad arguments';
  test.shouldThrowError( function()
  {
    _.entityKeyWithValue( 1,undefined );
  });

  test.case = 'redundant arguments';
  test.shouldThrowError( function()
  {
    _.entityKeyWithValue( [ 0 ],0,0 );
  });

}

//

function eachInMultiRange( test )
{

  var o =
  {
    ranges : [ 1 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 1 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 0,0 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  _.eachInMultiRange( o );
  test.identical( o.result, [] )
  test.identical( o.ranges, [ 0,0 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 0,3 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  _.eachInMultiRange( o );
  test.identical( o.result, [] )
  test.identical( o.ranges, [ 0,3 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 3,0 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  _.eachInMultiRange( o );
  test.identical( o.result, [] )
  test.identical( o.ranges, [ 3,0 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 1,1 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 1,1 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 1,3 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 0,1 ],
    [ 0,2 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 1,3 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 2,2 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 1,0 ],
    [ 0,1 ],
    [ 1,1 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 2,2 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 3,Infinity ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 1,0 ],
    [ 2,0 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 3,Infinity ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ Infinity,3 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 0,1 ],
    [ 0,2 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ Infinity,3 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ Infinity,Infinity ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ Infinity,Infinity ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 1,2,3 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0, 0, 0 ],
    [ 0, 1, 0 ],
    [ 0, 0, 1 ],
    [ 0, 1, 1 ],
    [ 0, 0, 2 ],
    [ 0, 1, 2 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 1,2,3 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  /* array of arrays */

  var o =
  {
    ranges : [ [ 0,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,0 ], [ 0,0 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  _.eachInMultiRange( o );
  test.identical( o.result, [] )
  test.identical( o.ranges, [ [ 0,0 ], [ 0,0 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,0 ], [ 0,3 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  _.eachInMultiRange( o );
  test.identical( o.result, [] )
  test.identical( o.ranges, [ [ 0,0 ], [ 0,3 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,3 ], [ 0,0 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  _.eachInMultiRange( o );
  test.identical( o.result, [] )
  test.identical( o.ranges, [ [ 0,3 ], [ 0,0 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,1 ], [ 0,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,1 ], [ 0,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,1 ], [ 0,3 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 0,1 ],
    [ 0,2 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,1 ], [ 0,3 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,2 ], [ 0,2 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 1,0 ],
    [ 0,1 ],
    [ 1,1 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,2 ], [ 0,2 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,3 ], [ 0,Infinity ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 1,0 ],
    [ 2,0 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,3 ], [ 0,Infinity ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,Infinity ], [ 0,3 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
    [ 0,1 ],
    [ 0,2 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,Infinity ], [ 0,3 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,Infinity ], [ 0,Infinity ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,Infinity ], [ 0,Infinity ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  var o =
  {
    ranges : [ [ Infinity,Infinity ], [ Infinity,Infinity ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ Infinity,Infinity ], [ Infinity,Infinity ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ Infinity, 1 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ Infinity,1 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 1, Infinity ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0,0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 1,Infinity ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ Infinity, 2 ], Infinity ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 1,0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ Infinity, 2 ], Infinity ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ Infinity, 2 ], [ Infinity, 2 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 1,1 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ Infinity, 2 ], [ Infinity, 2 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ Infinity, 2 ], [ Infinity, 2 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 1,1 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ Infinity, 2 ], [ Infinity, 2 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,1 ],[ 0,2 ],[ 0,3 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0, 0, 0 ],
    [ 0, 1, 0 ],
    [ 0, 0, 1 ],
    [ 0, 1, 1 ],
    [ 0, 0, 2 ],
    [ 0, 1, 2 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,1 ],[ 0,2 ],[ 0,3 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0,Infinity ],[ 0,2 ],[ 0,3 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0, 0, 0 ],
    [ 0, 1, 0 ],
    [ 0, 0, 1 ],
    [ 0, 1, 1 ],
    [ 0, 0, 2 ],
    [ 0, 1, 2 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0,Infinity ],[ 0,2 ],[ 0,3 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  /* object */

  var o =
  {
    ranges : { a : 1, b : 2, c : 3 },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    { a : 0, b : 0, c : 0 },
    { a : 0, b : 1, c : 0 },
    { a : 0, b : 0, c : 1 },
    { a : 0, b : 1, c : 1 },
    { a : 0, b : 0, c : 2 },
    { a : 0, b : 1, c : 2 }
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, { a : 1, b : 2, c : 3 } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { a : [ 0,1 ], b : [ 0,2 ], c : [ 0,3 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    { a : 0, b : 0, c : 0 },
    { a : 0, b : 1, c : 0 },
    { a : 0, b : 0, c : 1 },
    { a : 0, b : 1, c : 1 },
    { a : 0, b : 0, c : 2 },
    { a : 0, b : 1, c : 2 }
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, { a : [ 0,1 ], b : [ 0,2 ], c : [ 0,3 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  /*  */

  var o =
  {
    ranges : [ 2,1 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 0, 0 ],
    [ 1, 0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 2,1 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  var o =
  {
    ranges : [ -1,1 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 )
  test.identical( o.result, expected )
  test.identical( o.ranges, [ -1,1 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 2,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 2,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  var o =
  {
    ranges : [ [ -1,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ -1 ],
    [ 0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ -1,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 1,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 1,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 1,2 ], [ 2,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 1,2 ], [ 2,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 1,2 ], [ -1,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    [ 1,-1 ],
    [ 1,0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 1,2 ], [ -1,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 1,2 ], [ 1,1 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 1,2 ], [ 1,1 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ 2,1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 2,1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  var o =
  {
    ranges : { 0 : [ 1,1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 1,1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  var o =
  {
    ranges : { 0 : [ 1,-1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 1,-1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : -1 },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : -1 } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ -1,1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    { 0 : -1 },
    { 0 : 0 }
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ -1,1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ 1,2 ], 1 : [ 2,1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 1,2 ], 1 : [ 2,1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ 1,2 ], 1 : [ -1,1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
    { 0 : 1, 1 : -1 },
    { 0 : 1, 1 : 0 }
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 1,2 ], 1 : [ -1,1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ 1,2 ], 1 : [ 1,1 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 0
  }
  var expected =
  [
  ]
  var got = _.eachInMultiRange( o );
  test.identical( got, 0 );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 1,2 ], 1 : [ 1,1 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 0 );

  /* delta */

  var o =
  {
    ranges : [ 6 ],
    onEach : null,
    result : [],
    delta : [ 2 ],
    estimate : 0
  }
  var expected =
  [
    [ 0 ],
    [ 2 ],
    [ 4 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 6 ] );
  test.identical( o.delta, [ 2 ] );
  test.identical( o.estimate, 0 );

  var o =
  {
    ranges : [ 6,2 ],
    onEach : null,
    result : [],
    delta : [ 2,1 ],
    estimate : 0
  }
  var expected =
  [
    [ 0, 0 ],
    [ 2, 0 ],
    [ 4, 0 ],
    [ 0, 1 ],
    [ 2, 1 ],
    [ 4, 1 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 6,2 ] );
  test.identical( o.delta, [ 2,1 ] );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0, 6 ] ],
    onEach : null,
    result : [],
    delta : [ 2 ],
    estimate : 0
  }
  var expected =
  [
    [ 0 ],
    [ 2 ],
    [ 4 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 0, 6 ] ] );
  test.identical( o.delta, [ 2 ] );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 0, 6 ], [ 0, 2 ] ],
    onEach : null,
    result : [],
    delta : [ 2,1 ],
    estimate : 0
  }
  var expected =
  [
    [ 0, 0 ],
    [ 2, 0 ],
    [ 4, 0 ],
    [ 0, 1 ],
    [ 2, 1 ],
    [ 4, 1 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges,  [ [ 0, 6 ], [ 0, 2 ] ] );
  test.identical( o.delta, [ 2,1 ] );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ 0, 6 ] },
    onEach : null,
    result : [],
    delta : { 0 : 2 },
    estimate : 0
  }
  var expected =
  [
    { 0 : 0 },
    { 0 : 2 },
    { 0 : 4 }
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 0, 6 ] } );
  test.identical( o.delta, { 0 : 2 } );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : { 0 : [ 0, 6 ], 1 : [ 0, 2 ] },
    onEach : null,
    result : [],
    delta : { 0 : 2, 1 : 1 },
    estimate : 0
  }
  var expected =
  [
    { 0 : 0, 1 : 0 },
    { 0 : 2, 1 : 0 },
    { 0 : 4, 1 : 0 },
    { 0 : 0, 1 : 1 },
    { 0 : 2, 1 : 1 },
    { 0 : 4, 1 : 1 }
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, { 0 : [ 0, 6 ], 1 : [ 0, 2 ] } );
  test.identical( o.delta, { 0 : 2, 1 : 1 } );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 6 ],
    onEach : null,
    result : [],
    delta : [ 3 ],
    estimate : 0
  }
  var expected =
  [
    [ 0 ],
    [ 3 ],
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 6 ] );
  test.identical( o.delta, [ 3 ] );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 6 ],
    onEach : null,
    result : [],
    delta : [ 10 ],
    estimate : 0
  }
  var expected =
  [
    [ 0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 6 ] );
  test.identical( o.delta, [ 10 ] );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ 5, 10, 15 ],
    onEach : null,
    result : [],
    delta : [ 6, 11, 16 ],
    estimate : 0
  }
  var expected =
  [
    [ 0, 0, 0 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ 5, 10, 15 ] );
  test.identical( o.delta, [ 6, 11, 16 ] );
  test.identical( o.estimate, 0 );

  //

  var o =
  {
    ranges : [ [ 1, 3 ], [ 2, 6 ], [ 4, 8 ] ],
    onEach : null,
    result : [],
    delta : [ 1, 3, 4 ],
    estimate : 0
  }
  var expected =
  [
    [ 1, 2, 4 ],
    [ 2, 2, 4 ],
    [ 1, 5, 4 ],
    [ 2, 5, 4 ]
  ]
  _.eachInMultiRange( o );
  test.identical( o.result, expected )
  test.identical( o.ranges, [ [ 1, 3 ], [ 2, 6 ], [ 4, 8 ] ] );
  test.identical( o.delta, [ 1, 3, 4 ] );
  test.identical( o.estimate, 0 );

  /* estimate */

  var o =
  {
    ranges : [ 6 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 6 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, [ 6 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : [],
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = 0;
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, [] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : [ 2,6 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 12 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, [ 2,6 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : [ -1,6 ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : -6 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, [ -1,6 ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : [ [ 0,6 ], [ 0,5 ] ],
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 30 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, [ [ 0,6 ], [ 0,5 ] ] );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : { 0 : 0 },
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 0 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, { 0 : 0 } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : { 0 : 6 },
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 6 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, { 0 : 6 } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : { 0 : 2, 1 : 2 },
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 4 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, { 0 : 2, 1 : 2 } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : { 0 : [ 0,2 ], 1 : [ 0,2 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 4 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, { 0 : [ 0,2 ], 1 : [ 0,2 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  //

  var o =
  {
    ranges : { 0 : [ 1,2 ], 1 : [ 1,2 ] },
    onEach : null,
    result : [],
    delta : null,
    estimate : 1
  }
  var estimate = _.eachInMultiRange( o );
  var expected = { length : 1 };
  test.identical( estimate,expected )
  test.identical( o.result, [] )
  test.identical( o.ranges, { 0 : [ 1,2 ], 1 : [ 1,2 ] } );
  test.identical( o.delta, null );
  test.identical( o.estimate, 1 );

  /**/

  if( !Config.debug )
  return;

  test.shouldThrowError( () => _.eachInMultiRange([]) );
  test.shouldThrowError( () => _.eachInMultiRange({ ranges : 0 }) );
  test.shouldThrowError( () => _.eachInMultiRange({ onEach : 0 }) );
  test.shouldThrowError( () => _.eachInMultiRange({ someProp : 0 }) );

  test.shouldThrowError( () =>
  {
    _.eachInMultiRange
    ({
      ranges : [ 2 ],
      delta : 1
    })
  });

  test.shouldThrowError( () =>
  {
    _.eachInMultiRange
    ({
      ranges : [ 2 ],
      delta : [ 1,2 ]
    })
  });

  test.shouldThrowError( () =>
  {
    _.eachInMultiRange
    ({
      ranges : [ [ 1,2 ] ],
      delta : [ 1,2 ]
    })
  });

  test.shouldThrowError( () =>
  {
    _.eachInMultiRange
    ({
      ranges : { 0 : 2 },
      delta : [ 1 ]
    })
  });

  test.shouldThrowError( () =>
  {
    _.eachInMultiRange
    ({
      ranges : { 0 : 2 },
      delta : { a : 1 }
    })
  });

  test.shouldThrowError( () =>
  {
    var o =
    {
      ranges : [ 6 ],
      onEach : null,
      result : [],
      delta : [ 0 ],
      estimate : 0
    }
    _.eachInMultiRange( o );
  });

  test.shouldThrowError( () =>
  {
    var o =
    {
      ranges : [ 6 ],
      onEach : null,
      result : [],
      delta : [ Infinity ],
      estimate : 0
    }
    _.eachInMultiRange( o );
  });

  test.shouldThrowError( () =>
  {
    var o =
    {
      ranges : [ 6 ],
      onEach : null,
      result : [],
      delta : [ -1 ],
      estimate : 0
    }
    _.eachInMultiRange( o );
  });
}

//

var Self =
{

  name : 'Tools/base/l1/Entity',
  silencing : 1,
  // verbosity : 4,
  // importanceOfNegative : 3,

  tests :
  {

    eachSample : eachSample,

    entityMap    : entityMap,
    entityFilter : entityFilter,

    _entityMost  : _entityMost,
    entityMin    : entityMin,
    entityMax    : entityMax,

    entityLength : entityLength,
    entityAssign : entityAssign,
    entityAssignFieldFromContainer : entityAssignFieldFromContainer,
    entityCoerceTo : entityCoerceTo,
    entityHasNan : entityHasNan,
    entityHasUndef : entityHasUndef,
    entitySize : entitySize,

    entityValueWithIndex : entityValueWithIndex,
    entityKeyWithValue : entityKeyWithValue,

    eachInMultiRange : eachInMultiRange,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
