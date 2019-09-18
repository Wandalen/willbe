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
  test.shouldThrowErrorSync( function()
  {
    _.enityExtend();
  });

  test.case = 'extra argument';
  test.shouldThrowErrorSync( function()
  {
    _.enityExtend( [ 1,3 ], [ 1,3 ], [ 1,3 ] );
  });

  test.case = 'dst is undefined';
  test.shouldThrowErrorSync( function()
  {
    _.enityExtend( undefined, [ 0, 1 ] );
  });

  test.shouldThrowErrorSync( function()
  {
    _.enityExtend( undefined, { a : 1, b : 2 } );
  });

  test.shouldThrowErrorSync( function()
  {
    _.enityExtend( null, [ 0, 1 ] );
  });

  test.shouldThrowErrorSync( function()
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
qqq : improve test entityLength, normalize it, please
*/

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

  /* */

  test.case = 'string';
  var got = _.entityLength( 'string' )
  test.identical( got, 1 );

  test.case = 'null';
  var got = _.entityLength( null );
  test.identical( got, 1 );

  test.case = 'udefined';
  var got = _.entityLength( undefined );
  test.identical( got, 0 );

  test.case = 'symbol';
  var got = _.entityLength( Symbol.for( 'x' ) );
  test.identical( got, 1 );

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
  var got = _.entitySize( new BufferRaw( 10 ) );
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
  test.shouldThrowErrorSync( function()
  {
    _.entitySize();
  });

  test.case = 'redundant arguments';
  test.shouldThrowErrorSync( function()
  {
    _.entitySize( 1,2 );
  });

  test.case = 'redundant arguments';
  test.shouldThrowErrorSync( function()
  {
    _.entitySize( 1,undefined );
  });

  test.case = 'redundant arguments';
  test.shouldThrowErrorSync( function()
  {
    _.entitySize( [],undefined );
  });

};

//

var Self =
{

  name : 'Tools.base.l1.Entity',
  silencing : 1,

  tests :
  {

    enityExtend,

    entityAssign,
    entityAssignFieldFromContainer,

    entityLength,
    entitySize,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
