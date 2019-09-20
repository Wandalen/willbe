( function _Changes_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

  require( '../changes/Changes.s' );
  require( '../changes/ChangeTransactor.s' );

}

var _ = _global_.wTools;

// --
// common
// --

var changesArray =
[

  {
    a : true,
    b : true,
  },

  {
    a : false,
    b : false,
  },

  {
    a : { a2 : true, a3 : false },
    b : { 1 : false, 2 : true },
  },

  {
    a : { a2 : true, a3 : true },
    b : { 1 : true, 2 : true },
  },

  {
    a : { a2 : false, a3 : false },
    b : { 1 : false, 2 : false },
  },

  {
    a :
    [
      { a2 : true, a3 : false },
      { a1 : false, a2 : false, a3 : true },
    ],
    b :
    [
      { 1 : false, 2 : true },
      { 1 : true, 2 : false },
    ],
  },

  {
    a :
    [
      false,
      { a2 : true, a3 : false, a4 : true },
      { a3 : true },
    ],
  },

  {
    a :
    [
      false,
      { a2 : true, a3 : false },
      { a1 : false, a2 : false, a3 : true },
    ],
    b :
    [
      false,
      { 1 : false, 2 : true },
      { 1 : true, 2 : false },
    ],
  },

  {
    a :
    [
      true,
      { a2 : true, a3 : false },
      { a1 : false, a2 : false, a3 : true },
    ],
    b :
    [
      true,
      { 1 : false, 2 : true },
      { 1 : true, 2 : false },
    ],
  },

  //

  {
    a :
    [
      false,
      true,
    ],
    b :
    [
      false,
      true,
    ],
  },

  //

  {
    a :
    [
      true,
      false,
    ],
    b :
    [
      true,
      false,
    ],
  },

];

// --
// test
// --

function changesExtend( test )
{
  var self = this;

  var srcData =
  {
    a : { a1 : 'src.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'src.a4' },
    b : [ 'src.b0', 'src.b1', 'src.b2', 'src.b3', 'src.b4' ],
    c : { c1 : 'src.c1', c2 : 'src.c2', c3 : 'src.c3', c4 : 'src.c4' },
    dsrc : { d1 : 'src.d1', d2 : 'src.d2', d3 : 'src.d3', d4 : 'src.d4' },
  }

  var _dstData =
  {
    a : { a1 : 'dst.a1', a2 : 'dst.a2', a3 : 'dst.a3', a4 : 'dst.a4' },
    b : [ 'dst.b0', 'dst.b1', 'dst.b2', 'dst.b3', 'dst.b4' ],
    c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
    ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
  }

  var samples =
  [

    // simplest

    {
      extend : [ 0,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 1,0 ],
      expected : changesArray[ 0 ],
    },

    // 0-ended

    {
      extend : [ 2,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 3,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 4,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 1,2,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 1,3,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 1,4,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 2,1,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 3,1,0 ],
      expected : changesArray[ 0 ],
    },

    {
      extend : [ 4,1,0 ],
      expected : changesArray[ 0 ],
    },

    // 1-ended

    {
      extend : [ 2,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 3,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 4,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 0,2,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 0,3,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 0,4,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 2,0,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 3,0,1 ],
      expected : changesArray[ 1 ],
    },

    {
      extend : [ 4,0,1 ],
      expected : changesArray[ 1 ],
    },

    // 0-x

    {
      extend : [ 0,2 ],
      expected :
      {
        a :
        [
          true,
          { a2 : true, a3 : false },
        ],
        b :
        [
          true,
          { 1 : false, 2 : true },
        ],
      },
    },

    {
      extend : [ 0,3 ],
      expected :
      {
        a :
        [
          true,
          { a2 : true, a3 : true },
        ],
        b :
        [
          true,
          { 1 : true, 2 : true },
        ],
      },
    },

    {
      extend : [ 0,4 ],
      expected :
      {
        a :
        [
          true,
          { a2 : false, a3 : false },
        ],
        b :
        [
          true,
          { 1 : false, 2 : false },
        ],
      },
    },

    // 1-x

    {
      extend : [ 1,2 ],
      expected :
      {
        a :
        [
          false,
          { a2 : true, a3 : false },
        ],
        b :
        [
          false,
          { 1 : false, 2 : true },
        ],
      },
    },

    {
      extend : [ 1,3 ],
      expected :
      {
        a :
        [
          false,
          { a2 : true, a3 : true },
        ],
        b :
        [
          false,
          { 1 : true, 2 : true },
        ],
      },
    },

    {
      extend : [ 1,4 ],
      expected :
      {
        a :
        [
          false,
          { a2 : false, a3 : false },
        ],
        b :
        [
          false,
          { 1 : false, 2 : false },
        ],
      },
    },

    //

  ];

  //

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];
    var expected = sample.expected;
    var extend = _.arraySelect( changesArray,sample.extend )
    var args = _.arrayAppendArray( [ {} ],extend );
    var got = _.changesExtend.apply( _,args );

    test.identical( got,expected );
  }

}

//

function changesSelect( test )
{
  var self = this;

  var srcData =
  {
    a : { a1 : 'src.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'src.a4' },
    b : [ 'src.b0', 'src.b1', 'src.b2', 'src.b3', 'src.b4' ],
    c : { c1 : 'src.c1', c2 : 'src.c2', c3 : 'src.c3', c4 : 'src.c4' },
    dsrc : { d1 : 'src.d1', d2 : 'src.d2', d3 : 'src.d3', d4 : 'src.d4' },
  }

  var _dstData =
  {
    a : { a1 : 'dst.a1', a2 : 'dst.a2', a3 : 'dst.a3', a4 : 'dst.a4' },
    b : [ 'dst.b0', 'dst.b1', 'dst.b2', 'dst.b3', 'dst.b4' ],
    c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
    ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
  }

  var expectedArray =
  [

    {
      a : { a1 : 'src.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'src.a4' },
      b : [ 'src.b0', 'src.b1', 'src.b2', 'src.b3', 'src.b4' ],
    },

    {
    },

    {
      a : { a2 : 'src.a2' },
      b : { 2 : 'src.b2' },
    },

    {
      a : { a2 : 'src.a2', a3 : 'src.a3' },
      b : { 1 : 'src.b1', 2 : 'src.b2' },
    },

    {
      a : {},
      b : {},
    },

    {
      a : { a3 : 'src.a3' },
      b : { 1 : 'src.b1' },
    },

    {
      a : { a2 : 'src.a2', a4 : 'src.a4', a3 : 'src.a3' }
    },

    {
      a : { a3 : 'src.a3' },
      b : { 1 : 'src.b1' },
    },

    {
      a : { a3 : 'src.a3', a4 : 'src.a4' },
      b : { 0 : 'src.b0', 1 : 'src.b1', 3 : 'src.b3', 4 : 'src.b4' },
    },

    {
      a : { a1 : 'src.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'src.a4' },
      b : [ 'src.b0', 'src.b1', 'src.b2', 'src.b3', 'src.b4' ],
    },

    {
    },

  ];

  for( var s = 0 ; s < changesArray.length ; s++ )
  {
    var changes = changesArray[ s ];
    var expected = _.cloneJust( expectedArray[ s ] );
    var dstData = _.cloneJust( _dstData );

    logger.log( s + ' changes\n',_.toStr( changes,{ levels : 3 } ) );

    var got = _.changesSelect( changes,srcData );
    test.identical( got,expected );

    // logger.log( 'got\n',_.toStr( got,{ levels : 3 } ) );

  }

}

//

function changesApply( test )
{
  var self = this;

  var srcData =
  {
    a : { a1 : 'src.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'src.a4' },
    b : [ 'src.b0', 'src.b1', 'src.b2', 'src.b3', 'src.b4' ],
    c : { c1 : 'src.c1', c2 : 'src.c2', c3 : 'src.c3', c4 : 'src.c4' },
    dsrc : { d1 : 'src.d1', d2 : 'src.d2', d3 : 'src.d3', d4 : 'src.d4' },
  }

  var _dstData =
  {
    a : { a1 : 'dst.a1', a2 : 'dst.a2', a3 : 'dst.a3', a4 : 'dst.a4' },
    b : [ 'dst.b0', 'dst.b1', 'dst.b2', 'dst.b3', 'dst.b4' ],
    c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
    ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
  }

  var expectedArray =
  [

    {
      a : { a1 : 'src.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'src.a4' },
      b : [ 'src.b0', 'src.b1', 'src.b2', 'src.b3', 'src.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a1 : 'dst.a1', a2 : 'src.a2', a4 : 'dst.a4' },
      b : [ 'dst.b0', undefined, 'src.b2', 'dst.b3', 'dst.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a1 : 'dst.a1', a2 : 'src.a2', a3 : 'src.a3', a4 : 'dst.a4' },
      b : [ 'dst.b0', 'src.b1', 'src.b2', 'dst.b3', 'dst.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a1 : 'dst.a1', a4 : 'dst.a4' },
      b : [ 'dst.b0', undefined, undefined, 'dst.b3', 'dst.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a3 : 'src.a3', a4 : 'dst.a4' },
      b : [ 'dst.b0', 'src.b1', undefined, 'dst.b3', 'dst.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a2 : 'src.a2', a4 : 'src.a4', a3 : 'src.a3' },
      b : [ 'dst.b0', 'dst.b1', 'dst.b2', 'dst.b3', 'dst.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a3 : 'src.a3' },
      b : [ undefined, 'src.b1', undefined, undefined, undefined ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a4 : 'src.a4' },
      b : [ 'src.b0', undefined, undefined, 'src.b3', 'src.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      a : { a4 : 'src.a4' },
      b : [ 'src.b0', undefined, undefined, 'src.b3', 'src.b4' ],
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

    {
      c : { c1 : 'dst.c1', c2 : 'dst.c2', c3 : 'dst.c3', c4 : 'dst.c4' },
      ddst : { d1 : 'dst.d1', d2 : 'dst.d2', d3 : 'dst.d3', d4 : 'dst.d4' },
    },

  ];

  for( var s = 0 ; s < changesArray.length ; s++ )
  {
    var expected = _.cloneJust( expectedArray[ s ] );
    var changes = changesArray[ s ];
    var dstData = _.cloneJust( _dstData );

    logger.log( s + ' changes\n',_.toStr( changes,{ levels : 3 } ) );

    var got = _.changesApply( changes,dstData,srcData );
    test.identical( got,expected );

  }

}

// --
// declare
// --

var Self =
{

  name : 'Tools.mid.Changes',
  silencing : 1,

  context :
  {
    changesArray : changesArray,
  },

  tests :
  {

    changesExtend : changesExtend,
    changesSelect : changesSelect,
    changesApply : changesApply,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
