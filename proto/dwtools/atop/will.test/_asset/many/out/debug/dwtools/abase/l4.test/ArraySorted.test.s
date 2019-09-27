( function _ArraySorted_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../l4/ArraySorted.s' );

}

var _global = _global_;
var _ = _global_.wTools;
var Parent = wTester;

// --
// test
// --

function makeArray( length, density )
{
  var top = length / density;

  if( top < 1 ) top = 1;

  var array = [];
  for( var i = 0 ; i < length ; i += 1 )
  array[ i ] = Math.round( Math.random()*top );

  array.sort( function( a, b ){ return a-b } );

  return array;
}

//

function _lookUpAct( test )
{

  test.case = 'first argument is empty, so it returns the index from which it ended search at';
  var got = _.sorted._lookUpAct( [  ], 55, function( a, b ){ return a - b }, 0, 5 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'returns the last index of the first argument';
  var got = _.sorted._lookUpAct( [ 1, 2, 3, 4, 5 ], 5, function( a, b ){ return a - b }, 0, 5 );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'second argument was not found, so it returns the length of the first argument';
  var got = _.sorted._lookUpAct( [ 1, 2, 3, 4, 5 ], 55, function( a, b ){ return a - b }, 0, 5 );
  var expected = 5;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted._lookUpAct();
  });

};

//

function lookUp( test )
{

  var arr = [ 0, 0, 1, 1, 2, 3, 3, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.lookUp( arr, -1 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.lookUp( arr, 0 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.lookUp( arr, 1 );
  var expected = { value : 1, index : 2 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.lookUp( arr, 2 );
  var expected = { value : 2, index : 4 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.lookUp( arr, 3 );
  var expected = { value : 3, index : 6 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.lookUp( arr, 4 );
  var expected = { value : 4, index : 7 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.lookUp( arr, 5 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  /* - */

  var arr = [ 0, 0, 2, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.lookUp( arr, -1 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.lookUp( arr, 0 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.lookUp( arr, 1 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.lookUp( arr, 2 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.lookUp( arr, 3 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.lookUp( arr, 4 );
  var expected = { value : 4, index : 4 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.lookUp( arr, 5 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  /* - */

  test.case = 'returns an object that containing the found value';
  var got = _.sorted.lookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = { value : 5, index : 4 };
  test.identical( got, expected );

  test.case = 'returns undefined';
  var got = _.sorted.lookUp( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = 'call without a callback function';
  var got = _.sorted.lookUp( [ 1, 2, 3, 4, 5 ], 3 );
  var expected = { value : 3, index : 2 };
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUp();
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUp( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUp( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};

//

function lookUpClosest( test )
{

  var arr = [ 0, 0, 1, 1, 2, 3, 3, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.lookUpClosest( arr, -1 );
  var expected = { value : 0, index : 0 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.lookUpClosest( arr, 0 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.lookUpClosest( arr, 1 );
  var expected = { value : 1, index : 2 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.lookUpClosest( arr, 2 );
  var expected = { value : 2, index : 4 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.lookUpClosest( arr, 3 );
  var expected = { value : 3, index : 6 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.lookUpClosest( arr, 4 );
  var expected = { value : 4, index : 7 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.lookUpClosest( arr, 5 );
  var expected = { value : undefined, index : 9 };
  test.identical( got, expected );

  /* - */

  var arr = [ 0, 0, 2, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.lookUpClosest( arr, -1 );
  var expected = { value : 0, index : 0 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.lookUpClosest( arr, 0 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.lookUpClosest( arr, 1 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.lookUpClosest( arr, 2 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.lookUpClosest( arr, 3 );
  var expected = { value : 4, index : 3 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.lookUpClosest( arr, 4 );
  var expected = { value : 4, index : 4 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.lookUpClosest( arr, 5 );
  var expected = { value : undefined, index : 5 };
  test.identical( got, expected );

  /* - */

  test.case = 'returns an object that containing the found value';
  var got = _.sorted.lookUpClosest( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = { value : 5, index : 4 };
  test.identical( got, expected );

  test.case = 'returns undefined';
  var got = _.sorted.lookUpClosest( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = { value : undefined, index : 5 };
  test.identical( got, expected );

  test.case = 'call without a callback function';
  var got = _.sorted.lookUpClosest( [ 1, 2, 3, 4, 5 ], 3 );
  var expected = { value : 3, index : 2 };
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUpClosest();
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUpClosest( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUpClosest( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.lookUpClosest( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};


//

function lookUpIndex( test )
{

  test.case = 'simples';

  // [16, 17, 34, 34, 37, 42, 44, 44, 5, 9]
  // [ 1, 2, 3 ]
  // 0 -1
  // 1 0, 1
  // 2 0, 1

  var a = [ 1, 2, 3 ];

  var i = _.sorted.lookUpIndex( a, 0 );
  test.identical( i, -1 );

  var i = _.sorted.lookUpIndex( a, 1 );
  test.identical( i, 0 );

  var i = _.sorted.lookUpIndex( a, 2 );
  test.identical( i, 1 );

  var i = _.sorted.lookUpIndex( a, 3 );
  test.identical( i, 2 );

  var i = _.sorted.lookUpIndex( a, 4 );
  test.identical( i, -1 );

  //

  var a = [ 1, 1, 3, 3, 5, 5 ];

  var i = _.sorted.lookUpIndex( a, 1 );
  test.identical( i, 1 );

  var i = _.sorted.lookUpIndex( a, 3 );
  test.identical( i, 3 );

  var i = _.sorted.lookUpIndex( a, 5 );
  test.identical( i, 5 );

  //

  var a = [ 5, 4, 3, 2, 1 ];

  var i = _.sorted.lookUpIndex( a, 5 );
  test.identical( i, -1 );

  //

  var i = _.sorted.lookUpIndex( [], 1 );
  test.identical( i, -1 );

  //

  var arr = [ 1.5, 2.6, 5.7, 9.8 ];

  var transformer = function( value )
  {
    return Math.floor( value );
  }

  var i = _.sorted.lookUpIndex( arr, 5, transformer );
  test.identical( i, 2 )

  //

  var arr = [{ value : 1 }, { value : 2 }, { value : 3 } ];

  var comparator = function( a, b )
  {
    return a.value - b.value;
  }

  var i = _.sorted.lookUpIndex( arr, { value : 2 }, comparator );
  test.identical( i, 1 )

  //

  function testArray( array, top )
  {

    for( var ins = -1 ; ins < top+1 ; ins++ )
    {
      var index = _.sorted.lookUpIndex( array, ins );

      if( 1 <= index && index <= array.length-1 )
      test.is( array[ index-1 ] <= array[ index ] );

      if( 0 <= index && index <= array.length-2 )
      test.is( array[ index ] <= array[ index+1 ] );

      if( ins !== array[ index ] )
      {

        if( 0 <= index && index <= array.length-1 )
        test.is( ins < array[ index ] );

        if( 1 <= index && index <= array.length-1 )
        test.is( array[ index-1 ] < ins );

      }

    }

  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 5 );
    testArray( array, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 0.2 );
    testArray( array, c/0.2 );
  }

  test.identical( true, true );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIndex( a, 0, function() {} );
  });

}

lookUpIndex.timeOut = 60000;

//

function lookUpClosestIndex( test )
{

  test.case = 'simples';

  // [16, 17, 34, 34, 37, 42, 44, 44, 5, 9]
  // [ 1, 2, 3 ]
  // 0 -1
  // 1 0, 1
  // 2 0, 1

  var a = [ 1, 2, 3 ];

  var i = _.sorted.lookUpClosestIndex( a, 0 );
  test.identical( i, 0 );

  var i = _.sorted.lookUpClosestIndex( a, 1 );
  test.identical( i, 0 );

  var i = _.sorted.lookUpClosestIndex( a, 2 );
  test.identical( i, 1 );

  var i = _.sorted.lookUpClosestIndex( a, 3 );
  test.identical( i, 2 );

  var i = _.sorted.lookUpClosestIndex( a, 4 );
  test.identical( i, 3 );

  //

  var a = [ 1, 3, 5, 7 ];

  var i = _.sorted.lookUpClosestIndex( a, 2 );
  test.identical( i, 1 );

  var i = _.sorted.lookUpClosestIndex( a, 6 );
  test.identical( i, 3 );

  var i = _.sorted.lookUpClosestIndex( a, -1 );
  test.identical( i, 0 );

  //

  var a = [ 1, 1, 3, 3, 5, 5 ];

  var i = _.sorted.lookUpClosestIndex( a, 1 );
  test.identical( i, 1 );

  var i = _.sorted.lookUpClosestIndex( a, 3 );
  test.identical( i, 3 );

  var i = _.sorted.lookUpClosestIndex( a, 5 );
  test.identical( i, 5 );

  var i = _.sorted.lookUpClosestIndex( a, -1 );
  test.identical( i, 0 );

  //

  var i = _.sorted.lookUpClosestIndex( [], 1 );
  test.identical( i, 0 );

  //

  var a = [ 5, 4, 3, 2, 1 ];

  var i = _.sorted.lookUpClosestIndex( a, 2 );
  test.identical( i, 0 );

  var i = _.sorted.lookUpClosestIndex( a, 1 );
  test.identical( i, 0 );

  var i = _.sorted.lookUpClosestIndex( a, 3 );
  test.identical( i, 2 );

  //

  var arr = [ 1.5, 2.6, 6.2, 9.8 ];

  var transformer = function( value )
  {
    return Math.floor( value );
  }

  var i = _.sorted.lookUpClosestIndex( arr, 5, transformer );
  test.identical( i, 2 )

  //

  var arr = [{ value : 1 }, { value : 3 }, { value : 4 } ];

  var comparator = function( a, b )
  {
    return a.value - b.value;
  }

  var i = _.sorted.lookUpClosestIndex( arr, { value : 2 }, comparator );
  test.identical( i, 1 )

  /**/

  function testArray( array, top )
  {

    for( var ins = -1 ; ins < top+1 ; ins++ )
    {
      var index = _.sorted.lookUpClosestIndex( array, ins );

      if( 1 <= index && index <= array.length-1 )
      test.is( array[ index-1 ] <= array[ index ] );

      if( 0 <= index && index <= array.length-2 )
      test.is( array[ index ] <= array[ index+1 ] );

      if( ins !== array[ index ] )
      {

        if( 0 <= index && index <= array.length-1 )
        test.is( ins < array[ index ] );

        if( 1 <= index && index <= array.length-1 )
        test.is( array[ index-1 ] < ins );

      }

    }

  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 5 );
    testArray( array, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 0.2 );
    testArray( array, c/0.2 );
  }

  test.identical( true, true );

  /* */

  if( !Config.debug )
  return;

  {
    test.shouldThrowErrorSync( function()
    {
      _.sorted.lookUpClosestIndex( a, 0, function() {} );
    })
    test.shouldThrowErrorSync( function()
    {
      _.sorted.lookUpClosestIndex( a, 0, 0 );
    })
  }

}

lookUpClosestIndex.timeOut = 60000;

//

function lookUpInterval( test )
{
  var self = this;

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.sorted.lookUpInterval( arr, [ 1, 1 ] );
  test.identical( range, [ 4, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ 1, 2 ] );
  test.identical( range, [ 4, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ 0, 0 ] );
  test.identical( range, [ 0, 4 ] );

  var range = _.sorted.lookUpInterval( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 4 ] );

  var range = _.sorted.lookUpInterval( arr, [ 0, 1 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.sorted.lookUpInterval( arr, [ 2, 3 ] );
  test.identical( range, [ 8, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ -1, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.sorted.lookUpInterval( arr, [ -1, 1 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ '0', 0 ] );
  test.identical( range, [ 0, 4 ] );

  var range = _.sorted.lookUpInterval( arr, [ '0', '1' ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ '-1', '1' ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpInterval( arr, [ 1, 0 ] );
  test.identical( range, [ 4, 4 ] );

  //

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 2, 3 ];

  var range = _.sorted.lookUpInterval( arr, [ '1', '2' ] );
  test.identical( range, [ 4, 8 ] );

  /* arr[ range[ 1 ] ] < range[ 1 ], increase by 1 */
  var arr = [ 0, 1, 0 ];
  var range = _.sorted.lookUpInterval( arr, [ 0, 3 ] );

  //

  var arr = [ 5, 4, 3, 2, 1 ];

  var range = _.sorted.lookUpInterval( arr, [ 5, 1 ] );
  test.identical( range, [ 5, 5 ] );

  var range = _.sorted.lookUpInterval( arr, [ 1, 5 ] );
  test.identical( range, [ 0, 5 ] );

  var range = _.sorted.lookUpInterval( arr, [ 5, 5 ] );
  test.identical( range, [ 5, 5 ] );

  //

  var range = _.sorted.lookUpInterval( [], [ 1, 1 ] );
  test.identical( range, [ 0, 0 ] );

  /* */

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];
  var range = _.sorted.lookUpInterval( arr, [ 7, 28 ] );
  test.identical( range, [ 3, 8 ] );

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.sorted.lookUpInterval( arr, interval );

      if( range[ 0 ] < arr.length )
      test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] < interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] > interval[ 1 ] );

      }

    }

  }

  /* */

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* */

  test.identical( true, true );

  /* - */

  if( !Config.debug )
  return;

  var arr = [ 1, 1, 1, 0, 0, 0 ];
  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpInterval( arr );
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpInterval( arr, [ 0, 1 ], function() {} );
  })
  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpInterval( arr, [ 0, 1], 1 );
  })
  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpInterval( arr, [ 0 ] );
  })

}

lookUpInterval.timeOut = 60000;

//

function lookUpIntervalNarrowest( test )
{
  var self = this;

  /* - */

  test.open( 'extreme' );

  var arr = [ 3, 8, 16, 17, 30, 35, 35, 36, 37, 47 ];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 42, 44 ] );
  test.identical( got, [ 9, 9 ] );

  var arr = [ 3, 8, 16, 17, 30, 35, 35, 36, 37, 47 ];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 10, 10 ] );

  var arr = [];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 0, 0 ] );

  var arr = [ 47 ];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 1, 1 ] );

  var arr = [ 48 ];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 0, 1 ] );

  var arr = [ 49 ];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 0, 1 ] );

  var arr = [ 50 ];
  var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 0, 0 ] );

  test.close( 'extreme' );

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 1, 1 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 1, 2 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 0, 0 ] );
  test.identical( range, [ 3, 4 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 1 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 0, 1 ] );
  test.identical( range, [ 3, 5 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 2, 3 ] );
  test.identical( range, [ 8, 8 ] );

  var arr = [ 0, 1, 2 ];
  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 3, 3 ] );
  test.identical( range, [ 3, 3 ] );

  /* */

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 7, 28 ] );
  test.identical( range, [ 3, 8 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 1, 0 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 25, 25 ] );
  test.identical( range, [ 6, 7 ] );

  var range = _.sorted.lookUpIntervalNarrowest( arr, [ 36, 37 ] );
  test.identical( range, [ 9, 10 ] );

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalNarrowest( arr );
  })

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.sorted.lookUpIntervalNarrowest( arr, interval );

      if( range[ 0 ] < arr.length )
      test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] >= interval[ 1 ] );

      }

    }

  }

  /* */

  debugger;

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* */

  test.identical( true, true );
  debugger;
}

lookUpIntervalNarrowest.timeOut = 60000;

//

function lookUpIntervalHaving( test )
{

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ -1, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, -1 ];
  test.identical( got, expected );

  var range = [ -1, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, -1 ];
  test.identical( got, expected );

  var range = [ -1, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, 2 ];
  test.identical( got, expected );

  var range = [ -1, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, 2 ];
  test.identical( got, expected );

  var range = [ -1, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, 3 ];
  test.identical( got, expected );

  var range = [ -1, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, 3 ];
  test.identical( got, expected );

  var range = [ -1, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, 5 ];
  test.identical( got, expected );

  var range = [ -1, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ -1, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 0, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 0 ];
  test.identical( got, expected );

  var range = [ 0, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 0 ];
  test.identical( got, expected );

  var range = [ 0, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 2 ];
  test.identical( got, expected );

  var range = [ 0, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 2 ];
  test.identical( got, expected );

  var range = [ 0, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 3 ];
  test.identical( got, expected );

  var range = [ 0, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 3 ];
  test.identical( got, expected );

  var range = [ 0, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 5 ];
  test.identical( got, expected );

  var range = [ 0, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 0, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 1, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 1 ];
  test.identical( got, expected );

  var range = [ 1, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 1 ];
  test.identical( got, expected );

  var range = [ 1, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  var range = [ 1, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  var range = [ 1, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  var range = [ 1, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  var range = [ 1, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  var range = [ 1, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 2, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  var range = [ 2, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  var range = [ 2, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  var range = [ 2, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 3, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  var range = [ 3, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  var range = [ 3, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  var range = [ 3, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 4, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 3, 3 ];
  test.identical( got, expected );

  var range = [ 4, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 3, 5 ];
  test.identical( got, expected );

  var range = [ 4, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 3, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 5, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  var range = [ 5, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 6, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalHaving( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* - */

  test.open( 'special' );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 54 ];
  var expected = [ 3,4 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 55 ];
  var expected = [ 3,4 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 56 ];
  var expected = [ 3,5 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 0 ];
  var expected = [ 0, 0 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 1 ];
  var expected = [ 0, 1 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 2 ];
  var expected = [ 0, 2 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 3 ];
  var expected = [ 0, 2 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ -1, 0 ];
  var expected = [ -1, -1 ];
  var got = _.sorted.lookUpIntervalHaving( ranges, range );
  test.identical( got, expected );

  test.close( 'special' );

}

//

function lookUpIntervalEmbracingAtLeast( test )
{
  var self = this;

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ -1, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 1 ]; /* 0, 0 */
  test.identical( got, expected );

  var range = [ -1, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var range = [ -1, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 2 ]; /* 0, 3 */
  test.identical( got, expected );

  var range = [ -1, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 2 ]; /* 0, 3 */
  test.identical( got, expected );

  var range = [ -1, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 4 ];
  test.identical( got, expected );

  var range = [ -1, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 4 ];
  test.identical( got, expected );

  var range = [ -1, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 5 ];
  test.identical( got, expected );

  var range = [ -1, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 0, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 0, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ]; /* 1, 1 */
  test.identical( got, expected );

  var range = [ 0, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  var range = [ 0, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ]; /* 1, 3 */
  test.identical( got, expected );

  var range = [ 0, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ]; /* 1, 3 */
  test.identical( got, expected );

  var range = [ 0, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 0, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 0, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  var range = [ 0, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 1, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ]; /* 1, 2 */
  test.identical( got, expected );

  var range = [ 1, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  var range = [ 1, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ]; /* 1, 3 */
  test.identical( got, expected );

  var range = [ 1, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 2 ]; /* 1, 3 */
  test.identical( got, expected );

  var range = [ 1, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 1, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 1, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  var range = [ 1, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 2, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ]; /* 2, 2 */
  test.identical( got, expected );

  var range = [ 2, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ]; /* 2, 2 */
  test.identical( got, expected );

  var range = [ 2, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ]; /* 2, 2 */
  test.identical( got, expected );

  var range = [ 2, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ]; /* 2, 2 */
  test.identical( got, expected );

  var range = [ 2, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 2, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 2, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  var range = [ 2, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 3, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 3, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 3, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  var range = [ 3, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 4, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  var range = [ 4, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  var range = [ 4, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 5, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 4, 5 ]; /* 5, 5 */
  test.identical( got, expected );

  var range = [ 5, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 4, 5 ]; /* 5, 5 */
  test.identical( got, expected );

  /* */

  var range = [ 6, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( arr, range );
  var expected = [ 4, 5 ]; /* 5, 5 */
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* - */

  test.open( 'special' );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 54 ];
  var expected = [ 3, 4 ]; /* 3, 5 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 55 ];
  var expected = [ 3, 4 ]; /* 3, 5 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 56 ];
  var expected = [ 3, 5 ]; /* 3, 6 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 0 ];
  var expected = [ 0, 1 ];
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 1 ];
  var expected = [ 0, 1 ]; /* 0, 2 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 2 ];
  var expected = [ 0, 2 ]; /* 0, 2 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 3 ];
  var expected = [ 0, 2 ]; /* 0, 3 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ -1, 0 ];
  var expected = [ 0, 1 ]; /* -1, -1 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeast( ranges, range );
  test.identical( got, expected );

  test.close( 'special' );

  /* - */

  var arr = [ 0, 0, 5, 5, 9, 9 ];

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 5, 9 ] );
  test.identical( range, [ 3, 5 ] ); /* 3, 5 */

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 0, 5 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 0, 3 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 2, 5 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 2, 3 ] );
  test.identical( range, [ 1, 3 ] );

  var arr = [ 0, 0, 5, 5, 5, 9, 9 ];

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 2, 3 ] );
  test.identical( range, [ 1, 4 ] );

  /* - */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 1, 1 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 1, 2 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 0, 0 ] );
  test.identical( range, [ 3, 7 ] ); /* 3, 4 */

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 3 ] ); /* 0, 1 */

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 0, 1 ] );
  test.identical( range, [ 3, 7 ] ); /* 3, 5 */

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 3 ] ); /* 0, 0 */

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 2, 3 ] );
  test.identical( range, [ 7, 8 ] ); /* 8, 8 */

  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 1, 0 ] );
  test.identical( range, [ 7, 8 ] ); /* 7, 7 */

  test.case = 'empty';

  var arr = [];
  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 1, 0 ] );
  test.identical( range, [ 0, 0 ] );

  test.case = 'full';

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];
  var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, [ 7, 28 ] );
  test.identical( range, [ 2, 8 ] ); /* 2, 9 */

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.sorted.lookUpIntervalEmbracingAtLeast( arr, interval );

      if( range[ 0 ] > 0 )
      test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        // test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        // test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] >= interval[ 1 ] );
      }

    }

  }
  /* */

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalEmbracingAtLeast( [], [ 0, 1 ], function() {} );
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalEmbracingAtLeast( [], [ 0, 1 ], 0 );
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalEmbracingAtLeast( [ 3, 1, 2 ], [ 1, 2] );
  })

}

lookUpIntervalEmbracingAtLeast.timeOut = 60000;

//

function lookUpIntervalEmbracingAtLeastOld( test )
{
  var self = this;

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ -1, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 0 ];
  test.identical( got, expected );

  var range = [ -1, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 1 ];
  test.identical( got, expected );

  var range = [ -1, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 3 ]; /* xxx */
  test.identical( got, expected );

  var range = [ -1, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 3 ];
  test.identical( got, expected );

  var range = [ -1, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 4 ];
  test.identical( got, expected );

  var range = [ -1, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 4 ];
  test.identical( got, expected );

  var range = [ -1, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 5 ];
  test.identical( got, expected );

  var range = [ -1, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 0, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 0, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 1 ];
  test.identical( got, expected );

  var range = [ 0, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  var range = [ 0, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  var range = [ 0, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  var range = [ 0, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 0, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 0, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  var range = [ 0, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 1, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 1 ];
  test.identical( got, expected );

  var range = [ 1, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 2 ];
  test.identical( got, expected );

  var range = [ 1, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 3 ]; /* xxx */
  test.identical( got, expected );

  var range = [ 1, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 3 ];
  test.identical( got, expected );

  var range = [ 1, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 1, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 4 ];
  test.identical( got, expected );

  var range = [ 1, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  var range = [ 1, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 1, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 2, -1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 0 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 1 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 2 ];
  test.identical( got, expected );

  var range = [ 2, 2 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 3 ];
  test.identical( got, expected );

  var range = [ 2, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 2, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 2, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  var range = [ 2, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 3, 3 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 3, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 4 ];
  test.identical( got, expected );

  var range = [ 3, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  var range = [ 3, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 2, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 4, 4 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  var range = [ 4, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  var range = [ 4, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 4, 5 ];
  test.identical( got, expected );

  /* */

  var arr = [ 0, 0, 2, 4, 4 ];

  var range = [ 5, 5 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 5, 5 ];
  test.identical( got, expected );

  var range = [ 5, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 5, 5 ];
  test.identical( got, expected );

  /* */

  var range = [ 6, 6 ];
  test.case = _.toStr( range );
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, range );
  var expected = [ 5, 5 ];
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* - */

  test.open( 'special' );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 54 ];
  var expected = [ 3, 5 ]; /* 3, 4 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 55 ];
  var expected = [ 3, 5 ]; /* 3, 4 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 53, 56 ];
  var expected = [ 3, 6 ]; /* 3, 5 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 0 ];
  var expected = [ 0, 1 ]; /* 0, 0 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 1 ];
  var expected = [ 0, 2 ]; /* 0, 1 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 2 ];
  var expected = [ 0, 3 ]; /* 0, 2 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ 0, 3 ];
  var expected = [ 0, 3 ]; /* 0, 2 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  var ranges = [ 0, 1, 11, 12, 55, 56, 57, 58, 59, 65, 66, 68, 69 ];
  var range = [ -1, 0 ];
  var expected = [ 0, 1 ]; /* -1, -1 */
  var got = _.sorted.lookUpIntervalEmbracingAtLeastOld( ranges, range );
  test.identical( got, expected );

  test.close( 'special' );

  /* - */

  var arr = [ 0, 0, 5, 5, 9, 9 ];

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 5, 9 ] );
  test.identical( range, [ 3, 5 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 0, 5 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 0, 3 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 2, 5 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 2, 3 ] );
  test.identical( range, [ 1, 3 ] );

  /* - */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 1, 1 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 1, 2 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 0, 0 ] );
  test.identical( range, [ 3, 4 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 1 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 0, 1 ] );
  test.identical( range, [ 3, 5 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 2, 3 ] );
  test.identical( range, [ 8, 8 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 1, 0 ] );
  test.identical( range, [ 7, 7 ] );

  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr,[ '0','1' ] );
  test.identical( range, [ 3, 5 ] );

  test.case = 'empty';

  var arr = [];
  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 1, 0 ] );
  test.identical( range, [ 0, 0 ] );

  test.case = 'full';

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];
  var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, [ 7, 28 ] );
  test.identical( range, [ 2, 9 ] );

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.sorted.lookUpIntervalEmbracingAtLeastOld( arr, interval );

      if( range[ 0 ] > 0 )
      test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        // test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        // test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] >= interval[ 1 ] );
      }

    }

  }
  /* */

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* - */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalEmbracingAtLeastOld( [], [ 0, 1 ], function() {} );
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalEmbracingAtLeastOld( [], [ 0, 1 ], 0 );
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.lookUpIntervalEmbracingAtLeastOld( [ 3, 1, 2 ], [ 1, 2] );
  })

}

lookUpIntervalEmbracingAtLeastOld.timeOut = 60000;

//

function add( test )
{
  var self = this;

  // 13.00 13.00 10.00 10.00 10.00 2.000 10.00 15.00 2.000 14.00 10.00 6.000 6.000 15.00 4.000 8.000

  var samples =
  [

    [],
    [ 0 ],

    [ 0,1 ],
    [ 1,0 ],

    [ 1,0,2 ],
    [ 2,0,1 ],
    [ 0,1,2 ],
    [ 0,2,1 ],
    [ 2,1,0 ],
    [ 1,2,0 ],

    [ 0,1,1 ],
    [ 1,0,1 ],
    [ 1,1,0 ],

    [ 0,0,1,1 ],
    [ 0,1,1,0 ],
    [ 1,1,0,0 ],
    [ 1,0,1,0 ],
    [ 0,1,0,1 ],

    //_.arrayFill({ times : 16 }).map( function(){ return Math.floor( Math.random() * 16 ) } ),

  ];

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var expected = samples[ s ].slice();
    var got = [];
    for( var i = 0 ; i < expected.length ; i++ )
    _.sorted.add( got, expected[ i ] );
    expected.sort( function( a, b ){ return a-b } );
    test.identical( got, expected );
  }

}

//

function addOnce( test )
{
  test.case = 'sorted.addOnce test';

  var arr = [];
  _.sorted.addOnce( arr, 1 );
  test.identical( arr, [ 1 ] );

  var arr = [ 1 ];
  _.sorted.addOnce( arr, 1 );
  test.identical( arr, [ 1 ] );

  var arr = [ 1, 3 ];
  _.sorted.addOnce( arr, 2 );
  test.identical( arr, [ 1, 2, 3 ] );

  var arr = [ 1, 3 ];
  _.sorted.addOnce( arr, 0 );
  test.identical( arr, [ 0, 1, 3 ] );

  var arr = [ 1, 3 ];
  _.sorted.addOnce( arr, 4 );
  test.identical( arr, [ 1, 3, 4 ] );

  var arr = [ 1 ];
  function comparator( a, b ){ return ( a - b ) + 1  }
  _.sorted.addOnce( arr, 2, comparator );
  test.identical( arr, [ 2, 1 ] );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.addOnce();
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.addOnce( 0, 0 );
  })

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.addOnce( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.addOnce( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });
}

//

function addArray( test )
{
  test.case = 'sorted.addOnce test';

  var arr = [];
  _.sorted.addArray( arr, [ 1 ] );
  test.identical( arr, [ 1 ] );

  var arr = [ 1 ];
  _.sorted.addArray( arr, [ 1 ] );
  test.identical( arr, [ 1, 1 ] );

  var arr = [ 1, 3 ];
  _.sorted.addArray( arr, [ 2, 2, 2 ] );
  test.identical( arr, [ 1, 2, 2, 2, 3 ] );

  var arr = [ 1, 3 ];
  _.sorted.addArray( arr, [ 0, 1 ] );
  test.identical( arr, [ 0, 1, 1, 3 ] );

  var arr = [ 1, 3 ];
  _.sorted.addArray( arr, [ 1, 4 ]  );
  test.identical( arr, [ 1, 1, 3, 4 ] );

  var arr = [ 1 ];
  function comparator( a, b ){ return ( a - b ) + 1  }
  _.sorted.addArray( arr, [ 1, 2 ], comparator );
  test.identical( arr, [ 1, 2, 1 ] );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.addArray();
  });

  test.shouldThrowErrorSync( function()
  {
    _.sorted.addArray( 0, 0 );
  });

}

//

function remove( test )
{
  test.case = 'sorted.addOnce test';

  var arr = [];
  _.sorted.remove( arr, [ 1 ] );
  test.identical( arr, [ ] );

  var arr = [ 1 ];
  _.sorted.remove( arr, [ 1 ] );
  test.identical( arr, [ ] );

  var arr = [ 1, 3 ];
  _.sorted.remove( arr, 2 );
  test.identical( arr, [ 1, 3 ] );

  var arr = [ 1, 3 ];
  _.sorted.remove( arr, 3 );
  test.identical( arr, [ 1 ] );

  var arr = [ 1, 1, 1 ];
  _.sorted.remove( arr, 1 );
  test.identical( arr, [ 1, 1 ] );

  var arr = [ 1, 3 ];
  _.sorted.remove( arr, -1  );
  test.identical( arr, [ 1, 3 ] );

  test.case = 'nothing to remove';
  var got = _.sorted.remove( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'remove last index from first argument';
  var got = _.sorted.remove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.remove();
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.remove( 0, 0 );
  })

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.remove( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.remove( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.sorted.remove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });
}

//

function leftMostAtLeast( test )
{

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  test.open( 'trivial repeats' );

  test.case = '-1';
  var got = _.sorted.leftMostAtLeast( arr, -1 );
  var expected = { value : 0, index : 0 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.leftMostAtLeast( arr, 0 );
  var expected = { value : 0, index : 0,  }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.leftMostAtLeast( arr, 1 );
  var expected = { value : 1, index : 4 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.leftMostAtLeast( arr, 2 );
  var expected = { value : undefined, index : 8 }
  test.identical( got, expected );

  test.case = 'empty';
  var got = _.sorted.leftMostAtLeast( [], 10 );
  var expected = { value : undefined, index : 0 }
  test.identical( got, expected );

  test.close( 'trivial repeats' );

  /* */

  test.open( 'repeats, no gaps' );

  var arr = [ 0, 0, 1, 1, 2, 3, 3, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.leftMostAtLeast( arr, -1 );
  var expected = { value : 0, index : 0 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.leftMostAtLeast( arr, 0 );
  var expected = { value : 0, index : 0 }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.leftMostAtLeast( arr, 1 );
  var expected = { value : 1, index : 2 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.leftMostAtLeast( arr, 2 );
  var expected = { value : 2, index : 4 }
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.leftMostAtLeast( arr, 3 );
  var expected = { value : 3, index : 5 }
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.leftMostAtLeast( arr, 4 );
  var expected = { value : 4, index : 7 }
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.leftMostAtLeast( arr, 5 );
  var expected = { value : undefined, index : 9 }
  test.identical( got, expected );

  test.close( 'repeats, no gaps' );

  /* - */

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.leftMostAtLeast( arr, -1 );
  var expected = { value : 0, index : 0 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.leftMostAtLeast( arr, 0 );
  var expected = { value : 0, index : 0 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.leftMostAtLeast( arr, 1 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.leftMostAtLeast( arr, 2 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.leftMostAtLeast( arr, 3 );
  var expected = { value : 4, index : 3 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.leftMostAtLeast( arr, 4 );
  var expected = { value : 4, index : 3 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.leftMostAtLeast( arr, 5 );
  var expected = { value : undefined, index : 5 };
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  function comparator( a, b )
  {
    return ( a + 1 ) - b;
  }
  var got = _.sorted.leftMostAtLeast( arr, 2, comparator  );
  var expected = { value : 1, index : 4 }
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.leftMostAtLeast();
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.leftMostAtLeast( 0, 0 );
  })

}

//

function leftMostAtMost( test )
{

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  test.open( 'trivial repeats' );

  test.case = '-1';
  var got = _.sorted.leftMostAtMost( arr, -1 );
  var expected = { value : undefined, index : -1 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.leftMostAtMost( arr, 0 );
  var expected = { value : 0, index : 0,  }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.leftMostAtMost( arr, 1 );
  var expected = { value : 1, index : 4 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.leftMostAtMost( arr, 2 );
  var expected = { value : 1, index : 7 }
  test.identical( got, expected );

  test.case = 'empty';
  var got = _.sorted.leftMostAtMost( [], 10 );
  var expected = { value : undefined, index : 0 }
  test.identical( got, expected );

  test.close( 'trivial repeats' );

  /* */

  test.open( 'repeats, no gaps' );

  var arr = [ 0, 0, 1, 1, 2, 3, 3, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.leftMostAtMost( arr, -1 );
  var expected = { value : undefined, index : -1 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.leftMostAtMost( arr, 0 );
  var expected = { value : 0, index : 0 }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.leftMostAtMost( arr, 1 );
  var expected = { value : 1, index : 2 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.leftMostAtMost( arr, 2 );
  var expected = { value : 2, index : 4 }
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.leftMostAtMost( arr, 3 );
  var expected = { value : 3, index : 5 }
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.leftMostAtMost( arr, 4 );
  var expected = { value : 4, index : 7 }
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.leftMostAtMost( arr, 5 );
  var expected = { value : 4, index : 8 }
  test.identical( got, expected );

  test.close( 'repeats, no gaps' );

  /* - */

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.leftMostAtMost( arr, -1 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.leftMostAtMost( arr, 0 );
  var expected = { value : 0, index : 0 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.leftMostAtMost( arr, 1 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.leftMostAtMost( arr, 2 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.leftMostAtMost( arr, 3 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.leftMostAtMost( arr, 4 );
  var expected = { value : 4, index : 3 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.leftMostAtMost( arr, 5 );
  var expected = { value : 4, index : 4 };
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  function comparator( a, b )
  {
    return ( a + 1 ) - b;
  }
  var got = _.sorted.leftMostAtMost( arr, 2, comparator  );
  var expected = { value : 1, index : 4 }
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.leftMostAtMost();
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.leftMostAtMost( 0, 0 );
  })

}

//

function rightMostAtLeast( test )
{

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  test.open( 'trivial repeats' );

  test.case = '-1';
  var got = _.sorted.rightMostAtLeast( arr, -1 );
  var expected = { value : 0, index : 0 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.rightMostAtLeast( arr, 0 );
  var expected = { value : 0, index : 3 }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.rightMostAtLeast( arr, 1 );
  var expected = { value : 1, index : 7 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.rightMostAtLeast( arr, 2 );
  var expected = { value : undefined, index : 8 }
  test.identical( got, expected );

  test.case = 'empty';
  var got = _.sorted.rightMostAtLeast( [], 10 );
  var expected = { value : undefined, index : 0 }
  test.identical( got, expected );

  test.close( 'trivial repeats' );

  /* */

  test.open( 'repeats, no gaps' );

  var arr = [ 0, 0, 1, 1, 2, 3, 3, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.rightMostAtLeast( arr, -1 );
  var expected = { value : 0, index : 0 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.rightMostAtLeast( arr, 0 );
  var expected = { value : 0, index : 1 }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.rightMostAtLeast( arr, 1 );
  var expected = { value : 1, index : 3 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.rightMostAtLeast( arr, 2 );
  var expected = { value : 2, index : 4 }
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.rightMostAtLeast( arr, 3 );
  var expected = { value : 3, index : 6 }
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.rightMostAtLeast( arr, 4 );
  var expected = { value : 4, index : 8 }
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.rightMostAtLeast( arr, 5 );
  var expected = { value : undefined, index : 9 }
  test.identical( got, expected );

  test.close( 'repeats, no gaps' );

  /* - */

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.rightMostAtLeast( arr, -1 );
  var expected = { value : 0, index : 0 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.rightMostAtLeast( arr, 0 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.rightMostAtLeast( arr, 1 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.rightMostAtLeast( arr, 2 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.rightMostAtLeast( arr, 3 );
  var expected = { value : 4, index : 3 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.rightMostAtLeast( arr, 4 );
  var expected = { value : 4, index : 4 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.rightMostAtLeast( arr, 5 );
  var expected = { value : undefined, index : 5 };
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  function comparator( a, b )
  {
    return ( a + 1 ) - b;
  }
  var got = _.sorted.rightMostAtLeast( arr, 2, comparator );
  var expected = { value : 1, index : 7 }
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.rightMostAtLeast();
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.rightMostAtLeast( 0, 0 );
  })

}

//

function rightMostAtMost( test )
{

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  test.open( 'trivial repeats' );

  test.case = '-1';
  var got = _.sorted.rightMostAtMost( arr, -1 );
  var expected = { value : undefined, index : -1 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.rightMostAtMost( arr, 0 );
  var expected = { value : 0, index : 3 }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.rightMostAtMost( arr, 1 );
  var expected = { value : 1, index : 7 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.rightMostAtMost( arr, 2 );
  var expected = { value : 1, index : 7 }
  test.identical( got, expected );

  test.case = 'empty';
  var got = _.sorted.rightMostAtMost( [], 10 );
  var expected = { value : undefined, index : 0 }
  test.identical( got, expected );

  test.close( 'trivial repeats' );

  /* */

  test.open( 'repeats, no gaps' );

  var arr = [ 0, 0, 1, 1, 2, 3, 3, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.rightMostAtMost( arr, -1 );
  var expected = { value : undefined, index : -1 }
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.rightMostAtMost( arr, 0 );
  var expected = { value : 0, index : 1 }
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.rightMostAtMost( arr, 1 );
  var expected = { value : 1, index : 3 }
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.rightMostAtMost( arr, 2 );
  var expected = { value : 2, index : 4 }
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.rightMostAtMost( arr, 3 );
  var expected = { value : 3, index : 6 }
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.rightMostAtMost( arr, 4 );
  var expected = { value : 4, index : 8 }
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.rightMostAtMost( arr, 5 );
  var expected = { value : 4, index : 8 }
  test.identical( got, expected );

  test.close( 'repeats, no gaps' );

  /* - */

  test.open( 'repeats, gaps' );

  var arr = [ 0, 0, 2, 4, 4 ];

  test.case = '-1';
  var got = _.sorted.rightMostAtMost( arr, -1 );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = '0';
  var got = _.sorted.rightMostAtMost( arr, 0 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '1';
  var got = _.sorted.rightMostAtMost( arr, 1 );
  var expected = { value : 0, index : 1 };
  test.identical( got, expected );

  test.case = '2';
  var got = _.sorted.rightMostAtMost( arr, 2 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '3';
  var got = _.sorted.rightMostAtMost( arr, 3 );
  var expected = { value : 2, index : 2 };
  test.identical( got, expected );

  test.case = '4';
  var got = _.sorted.rightMostAtMost( arr, 4 );
  var expected = { value : 4, index : 4 };
  test.identical( got, expected );

  test.case = '5';
  var got = _.sorted.rightMostAtMost( arr, 5 );
  var expected = { value : 4, index : 4 };
  test.identical( got, expected );

  test.close( 'repeats, gaps' );

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  function comparator( a, b )
  {
    return ( a + 1 ) - b;
  }
  var got = _.sorted.rightMostAtMost( arr, 2, comparator );
  var expected = { value : 1, index : 7 }
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.sorted.rightMostAtMost();
  })

  test.shouldThrowErrorSync( function()
  {
    _.sorted.rightMostAtMost( 0, 0 );
  })

}

//
//
// function lookUpIntervalNarrowestExperiment( test )
// {
//   var arr = [ 3, 8, 16, 17, 30, 35, 35, 36, 37, 47 ];
//
//   /**/
//
//   var got = _.sorted.lookUpIntervalNarrowest( arr, [ 42, 44 ] );
//   test.identical( got, [ 9, 9 ] );
//
//   /**/
//
//   var got = _.sorted.lookUpIntervalNarrowest( arr, [ 48, 49 ] );
//   test.identical( got, [ 10, 10 ] );
//
// }

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l4.ArraySorted',
  silencing : 1,

  tests :
  {

    _lookUpAct,

    lookUp,
    lookUpClosest,

    lookUpIndex,
    lookUpClosestIndex,

    lookUpInterval,
    lookUpIntervalNarrowest,
    lookUpIntervalHaving,
    lookUpIntervalEmbracingAtLeast,
    lookUpIntervalEmbracingAtLeastOld,

    add,
    remove,
    addOnce,
    addArray,

    leftMostAtLeast,
    leftMostAtMost,
    rightMostAtLeast,
    rightMostAtMost,

    // lookUpIntervalNarrowestExperiment

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
