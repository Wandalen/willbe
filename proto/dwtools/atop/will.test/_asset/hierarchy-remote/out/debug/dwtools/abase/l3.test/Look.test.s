( function _Looker_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l3/Looker.s' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

}

var _global = _global_;
var _ = _global_.wTools;

/*
cls && node builder\include\dwtools\abase\l3.test\Looker.test.s && node builder\include\dwtools\abase\l4.test\LookerExtra.test.s && node builder\include\dwtools\abase\l4.test\Replicator.test.s && node builder\include\dwtools\abase\l5.test\Selector.test.s && node builder\include\dwtools\abase\l6.test\SelectorExtra.test.s && node builder\include\dwtools\abase\l6.test\LookerComparator.test.s
*/

// --
// tests
// --

function look( test )
{

  function handleUp1( e, k, it )
  {
    debugger;
    gotUpPaths.push( it.path );
    gotUpIndinces.push( it.index );
  }

  function handleDown1( e, k, it )
  {
    gotDownPaths.push( it.path );
    gotDownIndices.push( it.index );
  }

  var structure1 =
  {
    a : 1,
    b : 's',
    c : [ 1,3 ],
    d : [ 1,{ date : new Date() } ],
    e : function(){},
    f : new ArrayBuffer( 13 ),
    g : new Float32Array([ 1,2,3 ]),
  }

  var expectedUpPaths = [ '/', '/a', '/b', '/c', '/c/0', '/c/1', '/d', '/d/0', '/d/1', '/d/1/date', '/e', '/f', '/g' ];
  var expectedDownPaths = [ '/a', '/b', '/c/0', '/c/1', '/c', '/d/0', '/d/1/date', '/d/1', '/d', '/e', '/f', '/g', '/' ];
  var expectedUpIndinces = [ null, 0, 1, 2, 0, 1, 3, 0, 1, 0, 4, 5, 6 ];
  var expectedDownIndices = [ 0, 1, 0, 1, 2, 0, 0, 1, 3, 4, 5, 6, null ];

  var gotUpPaths = [];
  var gotDownPaths = [];
  var gotUpIndinces = [];
  var gotDownIndices = [];

  var it = _.look( structure1, handleUp1, handleDown1 );

  test.case = 'iteration';
  test.is( _.Looker.iterationIs( it ) );
  test.is( _.lookIteratorIs( Object.getPrototypeOf( it ) ) );
  test.is( _.lookerIs( Object.getPrototypeOf( Object.getPrototypeOf( it ) ) ) );
  test.is( Object.getPrototypeOf( Object.getPrototypeOf( Object.getPrototypeOf( it ) ) ) === null );
  test.is( Object.getPrototypeOf( Object.getPrototypeOf( it ) ) === it.Looker );
  test.is( Object.getPrototypeOf( it ) === it.iterator );

  test.case = 'paths on up';
  test.identical( gotUpPaths, expectedUpPaths );
  test.case = 'paths on down';
  test.identical( gotDownPaths, expectedDownPaths );
  test.case = 'indices on up';
  test.identical( gotUpIndinces, expectedUpIndinces );
  test.case = 'indices on down';
  test.identical( gotDownIndices, expectedDownIndices );

}

//

function lookRecursive( test )
{

  function handleUp1( e, k, it )
  {
    gotUpPaths.push( it.path );
  }

  function handleDown1( e, k, it )
  {
    gotDownPaths.push( it.path );
  }

  var structure1 =
  {
    a1 :
    {
      b1 :
      {
        c1 : 'abc',
        c2 : 'c2',
      },
      b2 : 'b2',
    },
    a2 : 'a2',
  }

  /* */

  test.open( 'recursive : 0' );

  var expectedUpPaths = [ '/' ];
  var expectedDownPaths = [ '/' ];
  var gotUpPaths = [];
  var gotDownPaths = [];

  var it = _.look
  ({
    src : structure1,
    onUp : handleUp1,
    onDown : handleDown1,
    recursive : 0,
  });

  test.case = 'iteration';
  test.is( _.Looker.iterationIs( it ) );

  test.case = 'paths on up';
  test.identical( gotUpPaths, expectedUpPaths );
  test.case = 'paths on down';
  test.identical( gotDownPaths, expectedDownPaths );

  test.close( 'recursive : 0' );

  /* */

  test.open( 'recursive : 1' );

  var expectedUpPaths = [ '/', '/a1', '/a2' ];
  var expectedDownPaths = [ '/a1', '/a2', '/' ];
  var gotUpPaths = [];
  var gotDownPaths = [];

  var it = _.look
  ({
    src : structure1,
    onUp : handleUp1,
    onDown : handleDown1,
    recursive : 1,
  });

  test.case = 'iteration';
  test.is( _.Looker.iterationIs( it ) );

  test.case = 'paths on up';
  test.identical( gotUpPaths, expectedUpPaths );
  test.case = 'paths on down';
  test.identical( gotDownPaths, expectedDownPaths );

  test.close( 'recursive : 1' );

  /* */

  test.open( 'recursive : 2' );

  var expectedUpPaths = [ '/', '/a1', '/a1/b1', '/a1/b2', '/a2' ];
  var expectedDownPaths = [ '/a1/b1', '/a1/b2', '/a1', '/a2', '/' ];
  var gotUpPaths = [];
  var gotDownPaths = [];

  var it = _.look
  ({
    src : structure1,
    onUp : handleUp1,
    onDown : handleDown1,
    recursive : 2,
  });

  test.case = 'iteration';
  test.is( _.Looker.iterationIs( it ) );

  test.case = 'paths on up';
  test.identical( gotUpPaths, expectedUpPaths );
  test.case = 'paths on down';
  test.identical( gotDownPaths, expectedDownPaths );

  test.close( 'recursive : 2' );

  /* */

  test.open( 'recursive : Infinity' );

  var expectedUpPaths = [ '/', '/a1', '/a1/b1', '/a1/b1/c1', '/a1/b1/c2', '/a1/b2', '/a2' ];
  var expectedDownPaths = [ '/a1/b1/c1', '/a1/b1/c2', '/a1/b1', '/a1/b2', '/a1', '/a2', '/' ];
  var gotUpPaths = [];
  var gotDownPaths = [];

  var it = _.look
  ({
    src : structure1,
    onUp : handleUp1,
    onDown : handleDown1,
    recursive : Infinity,
  });

  test.case = 'iteration';
  test.is( _.Looker.iterationIs( it ) );

  test.case = 'paths on up';
  test.identical( gotUpPaths, expectedUpPaths );
  test.case = 'paths on down';
  test.identical( gotDownPaths, expectedDownPaths );

  test.close( 'recursive : Infinity' );

}

//

function testPaths( test )
{

  let upc = 0;
  function onUp()
  {
    let it = this;
    let expectedPaths = [ '/', '/a', '/d', '/d/b', '/d/c' ];
    test.identical( it.path, expectedPaths[ upc ] );
    upc += 1;
  }
  let downc = 0;
  function onDown()
  {
    let it = this;
    let expectedPaths = [ '/a', '/d/b', '/d/c', '/d', '/' ];
    test.identical( it.path, expectedPaths[ downc ] );
    downc += 1;
  }

  /* */

  var src =
  {
    a : 11,
    d :
    {
      b : 13,
      c : 15,
    }
  }
  var got = _.look
  ({
    src : src,
    upToken : [ '/', './' ],
    onUp,
    onDown,
  });
  test.identical( got, got );
  test.identical( upc, 5 );
  test.identical( downc, 5 );

  /* */

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l3.Look',
  silencing : 1,
  enabled : 1,

  context :
  {
  },

  tests :
  {

    look,
    lookRecursive,
    testPaths,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
