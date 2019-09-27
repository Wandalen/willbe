( function _Replicator_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( '../l4/Replicator.s' );

  _.include( 'wTesting' );
  _.include( 'wStringer' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// tests
// --

function trivial( test )
{

  var structure1 =
  {
    a : 1,
    b : 's',
    c : [ 1, 3 ],
    d : [ 1, { date : new Date() } ],
    e : function(){},
    f : new ArrayBuffer( 13 ),
    g : new Float32Array([ 1,2,3 ]),
    h : false,
    i : true,
    j : { a : 1, b : 2 },
  }

  let expectedUpPaths = [ '/', '/a', '/b', '/c', '/c/0', '/c/1', '/d', '/d/0', '/d/1', '/d/1/date', '/e', '/f', '/g', '/h', '/i', '/j', '/j/a', '/j/b' ];
  let expectedUpIndices = [ null, 0, 1, 2, 0, 1, 3, 0, 1, 0, 4, 5, 6, 7, 8, 9, 0, 1 ];
  let expectedDownPaths = [ '/a', '/b', '/c/0', '/c/1', '/c', '/d/0', '/d/1/date', '/d/1', '/d', '/e', '/f', '/g', '/h', '/i', '/j/a', '/j/b', '/j', '/' ];
  let expectedDownIndices = [ 0, 1, 0, 1, 2, 0, 0, 1, 3, 4, 5, 6, 7, 8, 0, 1, 9, null ];

  let handleUpPaths = [];
  let handleUpIndices = [];
  let handleDownPaths = [];
  let handleDownIndices = [];

  function handleUp()
  {
    let it = this;
    handleUpPaths.push( it.path );
    handleUpIndices.push( it.index );
  }

  function handleDown()
  {
    let it = this;
    handleDownPaths.push( it.path );
    handleDownIndices.push( it.index );
  }

  // let expectedUpBeginPaths = [ '/', '/a', '/b', '/c', '/c/0', '/c/1', '/d', '/d/0', '/d/1', '/d/1/date', '/e', '/f', '/g', '/h', '/i', '/j', '/j/a', '/j/b' ];
  // let expectedUpBeginIndices = [ null, 0, 1, 2, 0, 1, 3, 0, 1, 0, 4, 5, 6, 7, 8, 9, 0, 1 ];
  // let expectedUpEndPaths = [ '/', '/a', '/b', '/c', '/c/0', '/c/1', '/d', '/d/0', '/d/1', '/d/1/date', '/e', '/f', '/g', '/h', '/i', '/j', '/j/a', '/j/b' ];
  // let expectedUpEndIndices = [ null, 0, 1, 2, 0, 1, 3, 0, 1, 0, 4, 5, 6, 7, 8, 9, 0, 1 ];
  // let expectedDownBeginPaths = [ '/a', '/b', '/c/0', '/c/1', '/c', '/d/0', '/d/1/date', '/d/1', '/d', '/e', '/f', '/g', '/h', '/i', '/j/a', '/j/b', '/j', '/' ];
  // let expectedDownBeginIndices = [ 0, 1, 0, 1, 2, 0, 0, 1, 3, 4, 5, 6, 7, 8, 0, 1, 9, null ];
  // let expectedDownEndPaths = [ '/a', '/b', '/c/0', '/c/1', '/c', '/d/0', '/d/1/date', '/d/1', '/d', '/e', '/f', '/g', '/h', '/i', '/j/a', '/j/b', '/j', '/' ];
  // let expectedDownEndIndices = [ 0, 1, 0, 1, 2, 0, 0, 1, 3, 4, 5, 6, 7, 8, 0, 1, 9, null ];
  //
  // let handleUpBeginPaths = [];
  // let handleUpBeginIndices = [];
  // let handleUpEndPaths = [];
  // let handleUpEndIndices = [];
  // let handleDownBeginPaths = [];
  // let handleDownBeginIndices = [];
  // let handleDownEndPaths = [];
  // let handleDownEndIndices = [];
  //
  // function handleUpBegin()
  // {
  //   let it = this;
  //   handleUpBeginPaths.push( it.path );
  //   handleUpBeginIndices.push( it.index );
  // }
  //
  // function handleUpEnd()
  // {
  //   let it = this;
  //   handleUpEndPaths.push( it.path );
  //   handleUpEndIndices.push( it.index );
  // }
  //
  // function handleDownBegin()
  // {
  //   let it = this;
  //   handleDownBeginPaths.push( it.path );
  //   handleDownBeginIndices.push( it.index );
  // }
  //
  // function handleDownEnd()
  // {
  //   let it = this;
  //   handleDownEndPaths.push( it.path );
  //   handleDownEndIndices.push( it.index );
  // }

  test.case = 'trivial'; /* */

  var got = _.replicate({ src : structure1 });
  test.identical( got, structure1 );
  test.is( got !== structure1 );
  test.is( got.a === structure1.a );
  test.is( got.b === structure1.b );
  test.is( got.c !== structure1.c );
  test.is( got.d !== structure1.d );
  test.is( got.e === structure1.e );
  test.is( got.f === structure1.f );
  test.is( got.g === structure1.g );
  test.is( got.h === structure1.h );
  test.is( got.i === structure1.i );
  test.is( got.j !== structure1.j );

  test.case = 'additional handlers'; /* */

  var got = _.replicate
  ({
    src : structure1,
    onUp : handleUp,
    onDown : handleDown,
  });
  test.identical( got, structure1 );
  test.is( got !== structure1 );
  test.is( got.a === structure1.a );
  test.is( got.b === structure1.b );
  test.is( got.c !== structure1.c );
  test.is( got.d !== structure1.d );
  test.is( got.e === structure1.e );
  test.is( got.f === structure1.f );
  test.is( got.g === structure1.g );
  test.is( got.h === structure1.h );
  test.is( got.i === structure1.i );
  test.is( got.j !== structure1.j );

  test.case = 'expectedUpPaths';
  test.identical( handleUpPaths, expectedUpPaths );
  test.case = 'expectedUpIndices';
  test.identical( handleUpIndices, expectedUpIndices );
  test.case = 'expectedUpPaths';
  test.identical( handleDownPaths, expectedDownPaths );
  test.case = 'expectedDownIndices';
  test.identical( handleDownIndices, expectedDownIndices );

  // test.case = 'additional handlers'; /* */
  //
  // var got = _.replicate
  // ({
  //   src : structure1,
  //   onUpBegin : handleUpBegin,
  //   onUpEnd : handleUpEnd,
  //   onDownBegin : handleDownBegin,
  //   onDownEnd : handleDownEnd,
  // });
  // test.identical( got, structure1 );
  // test.is( got !== structure1 );
  // test.is( got.a === structure1.a );
  // test.is( got.b === structure1.b );
  // test.is( got.c !== structure1.c );
  // test.is( got.d !== structure1.d );
  // test.is( got.e === structure1.e );
  // test.is( got.f === structure1.f );
  // test.is( got.g === structure1.g );
  // test.is( got.h === structure1.h );
  // test.is( got.i === structure1.i );
  // test.is( got.j !== structure1.j );
  //
  // test.case = 'expectedUpBeginPaths';
  // test.identical( handleUpBeginPaths, expectedUpBeginPaths );
  // test.case = 'expectedUpBeginIndices';
  // test.identical( handleUpBeginIndices, expectedUpBeginIndices );
  // test.case = 'expectedUpEndPaths';
  // test.identical( handleUpEndPaths, expectedUpEndPaths );
  // test.case = 'expectedUpEndIndices';
  // test.identical( handleUpEndIndices, expectedUpEndIndices );
  // test.case = 'expectedDownBeginPaths';
  // test.identical( handleDownBeginPaths, expectedDownBeginPaths );
  // test.case = 'expectedDownBeginIndices';
  // test.identical( handleDownBeginIndices, expectedDownBeginIndices );
  // test.case = 'expectedDownEndPaths';
  // test.identical( handleDownEndPaths, expectedDownEndPaths );
  // test.case = 'expectedDownEndIndices';
  // test.identical( handleDownEndIndices, expectedDownEndIndices );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l4.Replicate',
  silencing : 1,
  enabled : 1,

  context :
  {
  },

  tests :
  {
    trivial,
  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
