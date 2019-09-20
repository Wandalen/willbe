( function _Space_test_s_( ) {

'use strict';

/*
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../l5_space/Main.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var space = _.Space;
var vector = _.vector;
var vec = _.vector.fromArray;
var fvec = function( src ){ return _.vector.fromArray( new Float32Array( src ) ) }
var ivec = function( src ){ return _.vector.fromArray( new Int32Array( src ) ) }
var avector = _.avector;

var sqr = _.sqr;
var sqrt = _.sqrt;

//

function makeWithOffset( o )
{

  _.assert( _.longIs( o.buffer ) );
  _.assert( _.numberIs( o.offset ) )

  var buffer = new o.buffer.constructor( _.arrayAppendArrays( [],[ _.dup( -1,o.offset ),o.buffer ] ) )

  var m = new space
  ({
    dims : o.dims,
    buffer : buffer,
    offset : o.offset,
    inputTransposing : o.inputTransposing,
  });

  return m;
}

//

function experiment( test )
{
  test.case = 'experiment';
  test.identical( 1,1 );

  var m = space.makeSquare
  ([
    +3,+2,+10,
    -3,-3,-14,
    +3,+1,+3,
  ]);

}

//

function env( test )
{

  test.is( _.routineIs( space ) );
  test.is( _.objectIs( vector ) );
  test.is( _.objectIs( avector ) );

}

//

function clone( test )
{

  test.case = 'make'; /* */

  var buffer = new Float32Array([ 1,2,3,4,5,6 ]);
  var a = new _.Space
  ({
    buffer : buffer,
    dims : [ 3,2 ],
    inputTransposing : 0,
  });

  test.case = 'clone'; /* */

  var b = a.clone();
  test.identical( a,b );
  test.is( a.buffer !== b.buffer );
  test.is( a.buffer === buffer );

  test.identical( a.size,24 );
  test.identical( a.sizeOfElementStride,12 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,8 );
  test.identical( a.dims,[ 3,2 ] );
  test.identical( a.length,2 );

  test.identical( a._stridesEffective,[ 1,3 ] );
  test.identical( a.strideOfElement,3 );
  test.identical( a.strideOfCol,3 );
  test.identical( a.strideInCol,1 );
  test.identical( a.strideOfRow,1 );
  test.identical( a.strideInRow,3 );

  test.case = 'set buffer'; /* */

  a.buffer = new Float32Array([ 11,12,13 ]);

  test.identical( a.size,12 );
  test.identical( a.sizeOfElementStride,12 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );

  test.identical( a._stridesEffective,[ 1,3 ] );
  test.identical( a.strideOfElement,3 );
  test.identical( a.strideOfCol,3 );
  test.identical( a.strideInCol,1 );
  test.identical( a.strideOfRow,1 );
  test.identical( a.strideInRow,3 );

  logger.log( a );

  test.case = 'set dimension'; /* */

  a.dims = [ 1,3 ];

  test.identical( a.size,12 );
  test.identical( a.sizeOfElementStride,4 );
  test.identical( a.sizeOfElement,4 );
  test.identical( a.sizeOfCol,4 );
  test.identical( a.sizeOfRow,12 );
  test.identical( a.dims,[ 1,3 ] );
  test.identical( a.length,3 );

  test.identical( a._stridesEffective,[ 1,1 ] );
  test.identical( a.strideOfElement,1 );
  test.identical( a.strideOfCol,1 );
  test.identical( a.strideInCol,1 );
  test.identical( a.strideOfRow,1 );
  test.identical( a.strideInRow,1 );

  logger.log( a );

  test.case = 'copy buffer and dims'; /* */

  a.dims = [ 1,3 ];
  a.copyResetting({ buffer : new Float32Array([ 3,4,5 ]), dims : [ 3,1 ] });

  test.identical( a.size,12 );
  test.identical( a.sizeOfElementStride,12 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );

  test.identical( a._stridesEffective,[ 1,3 ] );
  test.identical( a.strideOfElement,3 );
  test.identical( a.strideOfCol,3 );
  test.identical( a.strideInCol,1 );
  test.identical( a.strideOfRow,1 );
  test.identical( a.strideInRow,3 );

  logger.log( a );

  test.case = 'copy dims and buffer'; /* */

  a.dims = [ 1,3 ];
  a.copyResetting({ dims : [ 3,1 ], buffer : new Float32Array([ 3,4,5 ]) });

  test.identical( a.size,12 );
  test.identical( a.sizeOfElementStride,12 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );

  test.identical( a._stridesEffective,[ 1,3 ] );
  test.identical( a.strideOfElement,3 );
  test.identical( a.strideOfCol,3 );
  test.identical( a.strideInCol,1 );
  test.identical( a.strideOfRow,1 );
  test.identical( a.strideInRow,3 );

  logger.log( a );
}

//

function construct( test )
{

  test.case = 'creating'; /* */

  var a = new _.Space
  ({
    buffer : new Float32Array([ 0, 1,2, 3,4, 5,6, 7 ]),
    offset : 1,
    atomsPerElement : 3,
    inputTransposing : 0,
    strides : [ 2,6 ],
    dims : [ 3,1 ],
  });

  logger.log( a );

  test.identical( a.size,12 );
  test.identical( a.sizeOfElementStride,24 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );

  test.identical( a._stridesEffective,[ 2,6 ] );
  test.identical( a.strideOfElement,6 );
  test.identical( a.strideOfCol,6 );
  test.identical( a.strideInCol,2 );
  test.identical( a.strideOfRow,2 );
  test.identical( a.strideInRow,6 );

  test.case = 'serializing clone'; /* */

  var cloned = a.cloneSerializing();

  test.identical( cloned.data.inputTransposing, 0 );

  var expected =
  {
    "data" :
    {
      "dims" : [ 3, 1 ],
      "growingDimension" : 1,
      "inputTransposing" : 0,
      "buffer" : `--buffer-->0<--buffer--`,
      "offset" : 0,
      "strides" : [ 1, 3 ]
    },
    "descriptorsMap" :
    {
      "--buffer-->0<--buffer--" :
      {
        "bufferConstructorName" : `Float32Array`,
        "sizeOfAtom" : 4,
        "offset" : 0,
        "size" : 12,
        "index" : 0
      }
    },
    "buffer" : ( new Uint8Array([ 0x0,0x0,0x80,0x3f,0x0,0x0,0x40,0x40,0x0,0x0,0xa0,0x40 ]) ).buffer
  }

  test.identical( cloned,expected );

    test.case = 'deserializing clone'; /* */

  var b = new _.Space({ buffer : new Float32Array(), inputTransposing : true });
  b.copyDeserializing( cloned );
  test.identical( b,a );
  test.is( a.buffer !== b.buffer );

  test.identical( a.buffer.length,8 );
  test.identical( a.size,12 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );
  test.identical( a.offset,1 );

  test.identical( a.strides,[ 2,6 ] );
  test.identical( a._stridesEffective,[ 2,6 ] );
  test.identical( a.strideOfElement,6 );
  test.identical( a.strideOfCol,6 );
  test.identical( a.strideInCol,2 );
  test.identical( a.strideOfRow,2 );
  test.identical( a.strideInRow,6 );

  test.identical( b.buffer.length,3 );
  test.identical( b.size,12 );
  test.identical( b.sizeOfElement,12 );
  test.identical( b.sizeOfCol,12 );
  test.identical( b.sizeOfRow,4 );
  test.identical( b.dims,[ 3,1 ] );
  test.identical( b.length,1 );
  test.identical( b.offset,0 );

  test.identical( b.strides,[ 1,3 ] );
  test.identical( b._stridesEffective,[ 1,3 ] );
  test.identical( b.strideOfElement,3 );
  test.identical( b.strideOfCol,3 );
  test.identical( b.strideInCol,1 );
  test.identical( b.strideOfRow,1 );
  test.identical( b.strideInRow,3 );

  test.case = 'creating'; /* */

  var a = new _.Space
  ({
    buffer : new Float32Array([ 0, 1,2, 3,4, 5,6, 7 ]),
    offset : 1,
    atomsPerElement : 3,
    inputTransposing : 1,
    strides : [ 2,6 ],
    // dims : [ 3,1 ],
  });

  logger.log( a );

  test.identical( a.size,12 );
  test.identical( a.sizeOfElementStride,24 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );

  test.identical( a._stridesEffective,[ 2,6 ] );
  test.identical( a.strideOfElement,6 );
  test.identical( a.strideOfCol,6 );
  test.identical( a.strideInCol,2 );
  test.identical( a.strideOfRow,2 );
  test.identical( a.strideInRow,6 );

  test.case = 'serializing clone'; /* */

  var cloned = a.cloneSerializing();

  test.identical( cloned.data.inputTransposing, 1 );

  var expected =
  {
    "data" :
    {
      "dims" : [ 3, 1 ],
      "growingDimension" : 1,
      "inputTransposing" : 1,
      "buffer" : `--buffer-->0<--buffer--`,
      "offset" : 0,
      "strides" : [ 1, 1 ]
    },
    "descriptorsMap" :
    {
      "--buffer-->0<--buffer--" :
      {
        "bufferConstructorName" : `Float32Array`,
        "sizeOfAtom" : 4,
        "offset" : 0,
        "size" : 12,
        "index" : 0
      }
    },
    "buffer" : ( new Uint8Array([ 0x0,0x0,0x80,0x3f,0x0,0x0,0x40,0x40,0x0,0x0,0xa0,0x40 ]) ).buffer
  }

  test.identical( cloned,expected );

  test.case = 'deserializing clone'; /* */

  var b = new _.Space({ buffer : new Float32Array(), inputTransposing : true });
  b.copyDeserializing( cloned );
  test.identical( b,a );
  test.is( a.buffer !== b.buffer );

  test.identical( a.buffer.length,8 );
  test.identical( a.size,12 );
  test.identical( a.sizeOfElement,12 );
  test.identical( a.sizeOfCol,12 );
  test.identical( a.sizeOfRow,4 );
  test.identical( a.dims,[ 3,1 ] );
  test.identical( a.length,1 );
  test.identical( a.offset,1 );

  test.identical( a.strides,[ 2,6 ] );
  test.identical( a._stridesEffective,[ 2,6 ] );
  test.identical( a.strideOfElement,6 );
  test.identical( a.strideOfCol,6 );
  test.identical( a.strideInCol,2 );
  test.identical( a.strideOfRow,2 );
  test.identical( a.strideInRow,6 );

  test.identical( b.buffer.length,3 );
  test.identical( b.size,12 );
  test.identical( b.sizeOfElement,12 );
  test.identical( b.sizeOfCol,12 );
  test.identical( b.sizeOfRow,4 );
  test.identical( b.dims,[ 3,1 ] );
  test.identical( b.length,1 );
  test.identical( b.offset,0 );

  test.identical( b.strides,[ 1,1 ] );
  test.identical( b._stridesEffective,[ 1,1 ] );
  test.identical( b.strideOfElement,1 );
  test.identical( b.strideOfCol,1 );
  test.identical( b.strideInCol,1 );
  test.identical( b.strideOfRow,1 );
  test.identical( b.strideInRow,1 );

}

//

function make( test )
{

  var o = Object.create( null );
  o.arrayMake = function arrayMake( src )
  {
    if( arguments.length === 0 )
    src = [];
    for( var i = 0 ; i < this.offset ; i++ )
    src.unshift( i );
    return new Int32Array( src );
  }
  o.vec = function vec( src )
  {
    return ivec( src );
  }

  o.offset = 0;
  this._make( test,o );

  return; xxx

  o.offset = undefined;
  this._make( test,o );

  o.offset = 13;
  this._make( test,o );

}

//

function _make( test,o )
{

  test.case = 'matrix with dimensions without stride, transposing'; /* */

  var m = new space
  ({
    inputTransposing : 1,
    dims : [ 2,3 ],
    offset : o.offset,
    buffer : o.arrayMake
    ([
      1,2,3,
      4,5,6,
    ]),
  });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 3,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,3 );
  test.identical( m.strideOfRow,3 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 2 );
  var c2 = m.lineVectorGet( 0,2 );
  var e = m.eGet( 2 );
  var a1 = m.atomFlatGet( 5 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,o.vec([ 4,5,6 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 3,6 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 3,6 ]) );
  test.identical( a1, 6 );
  test.identical( a2, 5 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  return; xxx

  test.case = 'matrix with dimensions without stride, non transposing'; /* */

  var m = new space
  ({
    inputTransposing : 0,
    dims : [ 2,3 ],
    offset : o.offset,
    buffer : o.arrayMake
    ([
      1,2,3,
      4,5,6,
    ]),
  });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,2 ] );
  test.identical( m.strideOfElement,2 );
  test.identical( m.strideOfCol,2 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,2 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 2 );
  var c2 = m.lineVectorGet( 0,2 );
  var e = m.eGet( 2 );
  var a1 = m.atomFlatGet( 5 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,o.vec([ 2,4,6 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 5,6 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 5,6 ]) );
  test.identical( a1, 6 );
  test.identical( a2, 4 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'column with dimensions without stride, transposing'; /* */

  var m = new space
  ({
    inputTransposing : 1,
    dims : [ 3,1 ],
    offset : o.offset,
    buffer : o.arrayMake
    ([
      1,
      2,
      3
    ]),
  });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,4 );
  test.identical( m.dims,[ 3,1 ] );
  test.identical( m.length,1 );

  test.identical( m._stridesEffective,[ 1,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 2 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,2,3 ]) );
  test.identical( a1, 3 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'column with dimensions without stride, non transposing'; /* */

  var m = new space
  ({
    inputTransposing : 0,
    dims : [ 3,1 ],
    offset : o.offset,
    buffer : o.arrayMake
    ([
      1,
      2,
      3
    ]),
  });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,4 );
  test.identical( m.dims,[ 3,1 ] );
  test.identical( m.length,1 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 2 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,2,3 ]) );
  test.identical( a1, 3 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'matrix with breadth, transposing'; /* */

  var m = new space
  ({
    inputTransposing : 1,
    breadth : [ 2 ],
    offset : o.offset,
    buffer : o.arrayMake
    ([
      1,2,3,
      4,5,6,
    ]),
  });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 3,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,3 );
  test.identical( m.strideOfRow,3 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 2 );
  var c2 = m.lineVectorGet( 0,2 );
  var e = m.eGet( 2 );
  var a1 = m.atomFlatGet( 5 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,o.vec([ 4,5,6 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 3,6 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 3,6 ]) );
  test.identical( a1, 6 );
  test.identical( a2, 5 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'matrix with breadth, non transposing'; /* */

  var m = new space
  ({
    inputTransposing : 0,
    breadth : [ 2 ],
    offset : o.offset,
    buffer : o.arrayMake
    ([
      1,2,3,
      4,5,6,
    ]),
  });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,2 ] );
  test.identical( m.strideOfElement,2 );
  test.identical( m.strideOfCol,2 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,2 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 2 );
  var c2 = m.lineVectorGet( 0,2 );
  var e = m.eGet( 2 );
  var a1 = m.atomFlatGet( 5 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,o.vec([ 2,4,6 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 5,6 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 5,6 ]) );
  test.identical( a1, 6 );
  test.identical( a2, 4 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'construct empty matrix with dims defined'; /* */

  var m = new space({ buffer : o.arrayMake(), offset : o.offset, inputTransposing : 0, dims : [ 1,0 ] });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,0 );
  test.identical( m.sizeOfElement,4 );
  test.identical( m.sizeOfCol,4 );
  test.identical( m.sizeOfRow,0 );
  test.identical( m.dims,[ 1,0 ] );
  test.identical( m.length,0 );

  test.identical( m._stridesEffective,[ 1,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 0 );
  var r2 = m.lineVectorGet( 1,0 );

  console.log( r1.toStr() );
  console.log( o.vec([]) );

  test.identical( r1,o.vec([]) );
  test.identical( r1,r2 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 1 );

  test.case = 'construct empty matrix'; /* */

  var m = new space({ buffer : o.arrayMake(), offset : o.offset, inputTransposing : 0/*, dims : [ 1,0 ]*/ });

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,0 );
  test.identical( m.sizeOfElement,4 );
  test.identical( m.sizeOfCol,4 );
  test.identical( m.sizeOfRow,0 );
  test.identical( m.dims,[ 1,0 ] );
  test.identical( m.length,0 );

  test.identical( m._stridesEffective,[ 1,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 0 );
  var r2 = m.lineVectorGet( 1,0 );

  console.log( r1.toStr() );
  console.log( o.vec([]) );

  test.identical( r1,o.vec([]) );
  test.identical( r1,r2 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 1 );

  if( Config.debug )
  {

    test.shouldThrowErrorSync( () => m.colVectorGet( 0 ) );
    test.shouldThrowErrorSync( () => m.lineVectorGet( 0,0 ) );
    test.shouldThrowErrorSync( () => m.eGet( 0 ) );

    test.shouldThrowErrorSync( () => m.rowVectorGet( 1 ) );
    test.shouldThrowErrorSync( () => m.colVectorGet( 1 ) );
    test.shouldThrowErrorSync( () => m.eGet( 1 ) );
    test.shouldThrowErrorSync( () => m.atomFlatGet( 1 ) );
    test.shouldThrowErrorSync( () => m.atomGet( 1 ) );

  }

  test.case = 'construct empty matrix with long column, non transposing'; /* */

  function checkEmptySpaceWithLongColNonTransposing( m )
  {

    test.identical( m.size,0 );
    test.identical( m.sizeOfElement,12 );
    test.identical( m.sizeOfCol,12 );
    test.identical( m.sizeOfRow,0 );
    test.identical( m.dims,[ 3,0 ] );
    test.identical( m.breadth,[ 3 ] );
    test.identical( m.length,0 );

    test.identical( m._stridesEffective,[ 1,3 ] );
    test.identical( m.strideOfElement,3 );
    test.identical( m.strideOfCol,3 );
    test.identical( m.strideInCol,1 );
    test.identical( m.strideOfRow,1 );
    test.identical( m.strideInRow,3 );

    var r1 = m.rowVectorGet( 0 );
    var r2 = m.rowVectorGet( 1 );
    var r3 = m.lineVectorGet( 1,0 );

    console.log( r1.toStr() );
    console.log( o.vec([]) );

    test.identical( r1,vec( new m.buffer.constructor([]) ) );
    test.identical( r1,r2 );
    test.identical( r1,r3 );
    test.identical( m.reduceToSumAtomWise(), 0 );
    test.identical( m.reduceToProductAtomWise(), 1 );
    test.identical( m.buffer.length-m.offset,0 );

    if( Config.debug )
    {
      test.shouldThrowErrorSync( () => m.colVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.lineVectorGet( 0,0 ) );
      test.shouldThrowErrorSync( () => m.eGet( 0 ) );
      test.shouldThrowErrorSync( () => m.colVectorGet( 1 ) );
      test.shouldThrowErrorSync( () => m.eGet( 1 ) );
      test.shouldThrowErrorSync( () => m.atomFlatGet( 1 ) );
      test.shouldThrowErrorSync( () => m.atomGet( 1 ) );
    }

  }

  var m = new space
  ({
    buffer : o.arrayMake(),
    offset : o.offset,
    /* strides : [ 1,3 ], */
    inputTransposing : 0,
    dims : [ 3,0 ],
  });
  logger.log( 'm\n' + _.toStr( m ) );
  // checkEmptySpaceWithLongColNonTransposing( m ); xxx

  var m = space.make([ 3,0 ]);
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongColNonTransposing( m );
  test.identical( m.strides, null );

  test.case = 'change by empty buffer of empty matrix with long column, non transposing'; /* */

  m.buffer = new Int32Array();
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongColNonTransposing( m );

  test.case = 'change by empty buffer of empty matrix with long column, non transposing, with copy'; /* */

  m.copy({ buffer : o.arrayMake(), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongColNonTransposing( m );

  test.case = 'change buffer of empty matrix with long column, non transposing'; /* */

  m.copy({ buffer : o.arrayMake([ 1,2,3 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,4 );
  test.identical( m.dims,[ 3,1 ] );
  test.identical( m.length,1 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'change buffer of not empty matrix with long column, non transposing'; /* */

  m.copy({ buffer : o.arrayMake([ 1,2,3,4,5,6 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,8 );
  test.identical( m.dims,[ 3,2 ] );
  test.identical( m.length,2 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 2,5 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'construct empty matrix with long column, transposing'; /* */

  function checkEmptySpaceWithLongColTransposing( m )
  {

    test.identical( m.size,0 );
    test.identical( m.sizeOfElement,12 );
    test.identical( m.sizeOfCol,12 );
    test.identical( m.sizeOfRow,0 );
    test.identical( m.dims,[ 3,0 ] );
    test.identical( m.length,0 );

    test.identical( m._stridesEffective,[ 0,1 ] );
    test.identical( m.strideOfElement,1 );
    test.identical( m.strideOfCol,1 );
    test.identical( m.strideInCol,0 );
    test.identical( m.strideOfRow,0 );
    test.identical( m.strideInRow,1 );

    var r1 = m.rowVectorGet( 0 );
    var r2 = m.rowVectorGet( 1 );
    var r3 = m.lineVectorGet( 1,0 );

    console.log( r1.toStr() );
    console.log( o.vec([]) );

    test.identical( r1,o.vec([]) );
    test.identical( r1,r2 );
    test.identical( r1,r3 );
    test.identical( m.reduceToSumAtomWise(), 0 );
    test.identical( m.reduceToProductAtomWise(), 1 );
    test.identical( m.buffer.length-m.offset,0 );

    if( Config.debug )
    {
      test.shouldThrowErrorSync( () => m.colVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.lineVectorGet( 0,0 ) );
      test.shouldThrowErrorSync( () => m.eGet( 0 ) );
      test.shouldThrowErrorSync( () => m.colVectorGet( 1 ) );
      test.shouldThrowErrorSync( () => m.eGet( 1 ) );
      test.shouldThrowErrorSync( () => m.atomFlatGet( 1 ) );
      test.shouldThrowErrorSync( () => m.atomGet( 1 ) );
    }

  }

  var m = new space
  ({
    buffer : o.arrayMake(),
    offset : o.offset,
    /* strides : [ 1,3 ], */
    inputTransposing : 1,
    dims : [ 3,0 ],
  });

  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongColTransposing( m );

  test.case = 'change by empty buffer of empty matrix with long column, transposing'; /* */

  var m = new space
  ({
    buffer : new Int32Array(),
    inputTransposing : 1,
    dims : [ 3,0 ],
  });
  m.buffer = new Int32Array();
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongColTransposing( m );

  test.case = 'change by empty buffer of empty matrix with long column, transposing, by copy'; /* */

  m.copy({ buffer : o.arrayMake([]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongColTransposing( m );

  test.case = 'change buffer of empty matrix with long column, transposing'; /* */

  m.copy({ buffer : o.arrayMake([ 1,2,3 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,4 );
  test.identical( m.dims,[ 3,1 ] );
  test.identical( m.length,1 );

  test.identical( m._stridesEffective,[ 1,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'change buffer of empty matrix with long column, transposing'; /* */

  m.copy({ buffer : o.arrayMake([ 1,2,3,4,5,6 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,8 );
  test.identical( m.dims,[ 3,2 ] );
  test.identical( m.length,2 );

  test.identical( m._stridesEffective,[ 2,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,2 );
  test.identical( m.strideOfRow,2 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 0,1 ]);

  test.identical( r1,o.vec([ 3,4 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,3,5 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,3,5 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'construct empty matrix with long row, transposing'; /* */

  function checkEmptySpaceWithLongRowTransposing( m )
  {

    test.identical( m.size,0 );
    test.identical( m.sizeOfElement,0 );
    test.identical( m.sizeOfCol,0 );
    test.identical( m.sizeOfRow,12 );
    test.identical( m.dims,[ 0,3 ] );
    test.identical( m.length,3 );

    test.identical( m._stridesEffective,[ 3,1 ] );
    test.identical( m.strideOfElement,1 );
    test.identical( m.strideOfCol,1 );
    test.identical( m.strideInCol,3 );
    test.identical( m.strideOfRow,3 );
    test.identical( m.strideInRow,1 );

    var c1 = m.colVectorGet( 0 );
    var c2 = m.colVectorGet( 1 );
    var c3 = m.lineVectorGet( 0,0 );
    var e = m.eGet( 2 );

    test.identical( c1,o.vec([]) );
    test.identical( c1,c2 );
    test.identical( c1,c3 );
    test.identical( e,o.vec([]) );
    test.identical( m.reduceToSumAtomWise(), 0 );
    test.identical( m.reduceToProductAtomWise(), 1 );
    test.identical( m.buffer.length-m.offset,0 );

    if( Config.debug )
    {

      test.shouldThrowErrorSync( () => m.rowVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.lineVectorGet( 1,0 ) );

      test.shouldThrowErrorSync( () => m.eGet( 3 ) );
      test.shouldThrowErrorSync( () => m.colVectorGet( 3 ) );

      test.shouldThrowErrorSync( () => m.atomFlatGet( 1 ) );
      test.shouldThrowErrorSync( () => m.atomGet( 1 ) );

    }

  }

  var m = new space
  ({
    buffer : o.arrayMake(),
    offset : o.offset,
    /* strides : [ 3,0 ], */
    inputTransposing : 1,
    dims : [ 0,3 ],
  });
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowTransposing( m );
  test.shouldThrowErrorSync( () => m.buffer = new Int32Array() );

  test.case = 'change by empty buffer of empty matrix with long row, transposing'; /* */

  var m = new space
  ({
    buffer : o.arrayMake(),
    inputTransposing : 1,
    growingDimension : 0,
    dims : [ 0,3 ],
  });

  m.buffer = new Int32Array();
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowTransposing( m );

  m.copy({ buffer : o.arrayMake([]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowTransposing( m );

  test.case = 'change by non empty buffer of empty matrix with long row, transposing'; /* */

  m.copy({ buffer : o.arrayMake([ 1,2,3 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,4 );
  test.identical( m.sizeOfCol,4 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 1,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 3,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,3 );
  test.identical( m.strideOfRow,3 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 0 );
  var r2 = m.lineVectorGet( 1,0 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 0,1 ]);

  test.identical( r1,o.vec([ 1,2,3 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 2 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 2 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'change by non empty buffer of non empty matrix with long row, transposing'; /* */

  m.copy({ buffer : o.arrayMake([ 1,2,3,4,5,6 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 3,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,3 );
  test.identical( m.strideOfRow,3 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 0,1 ]);

  test.identical( r1,o.vec([ 4,5,6 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 2,5 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 2,5 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'construct empty matrix with long row, non transposing'; /* */

  function checkEmptySpaceWithLongRowNonTransposing( m )
  {

    test.identical( m.size,0 );
    test.identical( m.sizeOfElement,0 );
    test.identical( m.sizeOfCol,0 );
    test.identical( m.sizeOfRow,12 );
    test.identical( m.dims,[ 0,3 ] );
    test.identical( m.length,3 );

    test.identical( m._stridesEffective,[ 1,0 ] );
    test.identical( m.strideOfElement,0 );
    test.identical( m.strideOfCol,0 );
    test.identical( m.strideInCol,1 );
    test.identical( m.strideOfRow,1 );
    test.identical( m.strideInRow,0 );

    var c1 = m.colVectorGet( 0 );
    var c2 = m.colVectorGet( 1 );
    var c3 = m.lineVectorGet( 0,0 );
    var e = m.eGet( 2 );

    test.identical( c1,vec( new m.buffer.constructor([]) ) );
    test.identical( c1,c2 );
    test.identical( c1,c3 );
    test.identical( e,vec( new m.buffer.constructor([]) ) );
    test.identical( m.reduceToSumAtomWise(), 0 );
    test.identical( m.reduceToProductAtomWise(), 1 );
    test.identical( m.buffer.length-m.offset,0 );

    if( Config.debug )
    {

      test.shouldThrowErrorSync( () => m.rowVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.lineVectorGet( 1,0 ) );

      test.shouldThrowErrorSync( () => m.eGet( 3 ) );
      test.shouldThrowErrorSync( () => m.colVectorGet( 3 ) );

      test.shouldThrowErrorSync( () => m.atomFlatGet( 1 ) );
      test.shouldThrowErrorSync( () => m.atomGet( 1 ) );

    }

  }

  var m = new space
  ({
    buffer : o.arrayMake(),
    offset : o.offset,
    /* strides : [ 3,0 ], */
    inputTransposing : 0,
    dims : [ 0,3 ],
  });
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowNonTransposing( m );

  var m = space.make([ 0,3 ]);
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowNonTransposing( m );
  test.identical( m.strides, null );

  var m = space.make([ 0,3 ]);
  test.shouldThrowErrorSync( () => m.buffer = new Int32Array() );

  test.case = 'change by empty buffer of empty matrix with long row, non transposing'; /* */

  var m = space.make([ 0,3 ]);
  m.growingDimension = 0;
  m.buffer = new Int32Array();
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowNonTransposing( m );

  test.case = 'change by empty buffer of empty matrix with long row, non transposing, by copy'; /* */

  m.copy({ buffer : o.arrayMake([]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );
  checkEmptySpaceWithLongRowNonTransposing( m );

  test.case = 'change by non empty buffer of empty matrix with long row, non transposing'; /* */

  m.growingDimension = 0;
  m.copy({ buffer : o.arrayMake([ 1,2,3 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,4 );
  test.identical( m.sizeOfCol,4 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 1,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 0 );
  var r2 = m.lineVectorGet( 1,0 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 0,1 ]);

  test.identical( r1,o.vec([ 1,2,3 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 2 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 2 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'change by non empty buffer of non empty matrix with long row, non transposing'; /* */

  m.growingDimension = 0;
  m.copy({ buffer : o.arrayMake([ 1,2,3,4,5,6 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,2 ] );
  test.identical( m.strideOfElement,2 );
  test.identical( m.strideOfCol,2 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,2 );

  var r1 = m.rowVectorGet( 0 );
  var r2 = m.lineVectorGet( 1,0 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 1,3,5 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 3,4 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 3,4 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'construct matrix with only buffer'; /* */

  var m = new space
  ({
    buffer : o.arrayMake([ 1,2,3 ]),
    offset : o.offset,
  });
  logger.log( 'm\n' + _.toStr( m ) );


  test.identical( m.atomsPerSpace,3 );
  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,4 );
  test.identical( m.dims,[ 3,1 ] );
  test.identical( m.length,1 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,o.vec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'construct matrix without buffer'; /* */

  if( Config.debug )
  {

    test.shouldThrowErrorSync( () => new space({ offset : o.offset, }) );

  }

  test.case = 'construct matrix with buffer and strides'; /* */

  if( Config.debug )
  {

    var buffer = new Int32Array
    ([
      1, 2, 3,
      4, 5, 6,
    ]);
    test.shouldThrowErrorSync( () => new space({ buffer : buffer, strides : [ 1,3 ] }) );

  }

  test.case = 'construct empty matrix with dimensions, non transposing'; /* */

  var m = new space
  ({
    buffer : o.arrayMake(),
    dims : [ 3,0 ],
    inputTransposing : 0,
    offset : o.offset,
  });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.atomsPerSpace,0 );
  test.identical( m.size,0 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,0 );
  test.identical( m.dims,[ 3,0 ] );
  test.identical( m.length,0 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 1 );

  m.copy({ buffer : o.arrayMake([ 1,2,3,4,5,6 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,8 );
  test.identical( m.dims,[ 3,2 ] );
  test.identical( m.length,2 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 4 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,o.vec([ 2,5 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 4,5,6 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 4,5,6 ]) );
  test.identical( a1, 5 );
  test.identical( a2, 5 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'construct empty matrix with dimensions, transposing'; /* */

  var m = new space
  ({
    buffer : o.arrayMake(),
    dims : [ 3,0 ],
    inputTransposing : 1,
    offset : o.offset,
  });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,0 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,0 );
  test.identical( m.dims,[ 3,0 ] );
  test.identical( m.length,0 );

  test.identical( m._stridesEffective,[ 0,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,0 );
  test.identical( m.strideOfRow,0 );
  test.identical( m.strideInRow,1 );

  m.copy({ buffer : o.arrayMake([ 1,2,3,4,5,6 ]), offset : o.offset });
  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,8 );
  test.identical( m.dims,[ 3,2 ] );
  test.identical( m.length,2 );

  test.identical( m._stridesEffective,[ 2,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,2 );
  test.identical( m.strideOfRow,2 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 3 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,o.vec([ 3,4 ]) );
  test.identical( r1,r2 );
  test.identical( c1,o.vec([ 2,4,6 ]) );
  test.identical( c1,c2 );
  test.identical( e,o.vec([ 2,4,6 ]) );
  test.identical( a1, 4 );
  test.identical( a2, 4 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.case = 'make then copy'; /* */

  var m = space.make([ 2,3 ]).copy
  ([
    1,2,3,
    4,5,6,
  ]);

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,2 ] );
  test.identical( m.strideOfElement,2 );
  test.identical( m.strideOfCol,2 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,2 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 3 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,vec( new Float32Array([ 4,5,6 ]) ) );
  test.identical( r1,r2 );
  test.identical( c1,vec( new Float32Array([ 2,5 ]) ) );
  test.identical( c1,c2 );
  test.identical( e,vec( new Float32Array([ 2,5 ]) ) );
  test.identical( a1, 5 );
  test.identical( a2, 5 );
  test.identical( m.reduceToSumAtomWise(), 21 );
  test.identical( m.reduceToProductAtomWise(), 720 );

  test.identical( m.strides, null );
  test.is( m.buffer instanceof Float32Array );

  test.case = 'copy buffer from scalar'; /* */

  var m = space.makeSquare([ 1,2,3,4 ]);
  var expected = space.makeSquare([ 13,13,13,13 ]);

  m.copy( 13 );
  test.identical( m,expected );

  var m = space.makeSquare([]);
  var expected = space.makeSquare([]);

  m.copy( 13 );
  test.identical( m,expected );

  test.case = 'copy buffer of different type'; /* */

  var b = new Float32Array
  ([
    1,2,3,
    4,5,6,
    7,8,9,
  ]);

  var m = makeWithOffset
  ({
    buffer : b,
    dims : [ 3,3 ],
    offset : o.offset||0,
    inputTransposing : 1,
  });

  test.is( m.buffer.length-( o.offset||0 ) === 9 );
  test.is( m.buffer instanceof Float32Array );

  var expected = space.make([ 3,3 ]).copy
  ([
    1,2,3,
    4,5,6,
    7,8,9,
  ]);

  m.copy
  ([
    1,2,3,
    4,5,6,
    7,8,9,
  ]);

  test.identical( m,expected );
  test.is( m.buffer.length === 9+( o.offset||0 ) );
  test.is( m.buffer instanceof Float32Array );

  m.copy
  ( new Uint32Array([
    1,2,3,
    4,5,6,
    7,8,9,
  ]));

  test.identical( m,expected );
  test.is( m.buffer.length === 9+( o.offset||0 ) );
  test.is( m.offset === ( o.offset||0 ) );
  test.is( m.buffer instanceof Float32Array );

  m.copy
  ({
    offset : 0,
    buffer : new Uint32Array
    ([
      1,2,3,
      4,5,6,
      7,8,9,
    ]),
  });

  test.notIdentical( m,expected );
  test.is( m.buffer.length === 9 );
  test.is( m.offset === 0 );
  test.is( m.buffer instanceof Uint32Array );

  test.case = 'bad buffer'; /* */

  test.shouldThrowErrorSync( function()
  {
    new space
    ({
      buffer : _.arrayFromRange([ 1,5 ]),
      dims : [ 3,3 ],
    });
  });

  test.shouldThrowErrorSync( function()
  {
    var m = space.make([ 2,3 ]).copy
    ([
      1,2,3,
      4,5,6,
      7,8,9,
    ]);
  });

}

//

function makeHelper( test )
{

  test.case = 'make'; /* */

  var m = space.make([ 3,2 ]);

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,8 );
  test.identical( m.dims,[ 3,2 ] );
  test.identical( m.length,2 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  test.identical( m.strides,null );
  test.is( m.buffer instanceof Float32Array );

  test.case = 'square with buffer'; /* */

  var buffer =
  [
    1, 2, 3,
    4, 5, 6,
    7, 8, 9,
  ];
  var m = space.makeSquare( buffer );

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,36 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 3,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 3,1 ] );
  test.identical( m.strideOfElement,1 );
  test.identical( m.strideOfCol,1 );
  test.identical( m.strideInCol,3 );
  test.identical( m.strideOfRow,3 );
  test.identical( m.strideInRow,1 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 4 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,fvec([ 4,5,6 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 2,5,8 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 2,5,8 ]) );
  test.identical( a1, 5 );
  test.identical( a2, 5 );
  test.identical( m.reduceToSumAtomWise(), 45 );
  test.identical( m.reduceToProductAtomWise(), 362880 );
  test.identical( m.determinant(),0 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  var buffer = new Uint32Array
  ([
    1, 2, 3,
    4, 5, 6,
    7, 8, 9,
  ]);
  var m = space.makeSquare( buffer );
  test.identical( m.determinant(),0 );
  test.is( m.buffer instanceof Uint32Array );

  test.case = 'square with length'; /* */

  var m = space.makeSquare( 3 );

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,36 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 3,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  test.case = 'diagonal'; /* */

  var m = space.makeDiagonal([ 1,2,3 ]);

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,36 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 3,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 4 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,fvec([ 0,2,0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,2,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,2,0 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 0 );
  test.identical( m.determinant(),6 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  test.case = 'identity'; /* */

  m = space.makeIdentity( 3 );

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,36 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 3,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 4 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,fvec([ 0,1,0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,1,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,1,0 ]) );
  test.identical( a1, 1 );
  test.identical( a2, 1 );
  test.identical( m.reduceToSumAtomWise(), 3 );
  test.identical( m.reduceToProductAtomWise(), 0 );
  test.identical( m.determinant(),1 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  test.case = 'identity, not square, 2x3'; /* */

  m = space.makeIdentity([ 2,3 ]);

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,8 );
  test.identical( m.sizeOfCol,8 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 2,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,2 ] );
  test.identical( m.strideOfElement,2 );
  test.identical( m.strideOfCol,2 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,2 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 3 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,fvec([ 0,1,0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,1 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,1 ]) );
  test.identical( a1, 1 );
  test.identical( a2, 1 );
  test.identical( m.reduceToSumAtomWise(), 2 );
  test.identical( m.reduceToProductAtomWise(), 0 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  test.case = 'identity, not square, 3x2'; /* */

  m = space.makeIdentity([ 3,2 ]);

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,24 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,8 );
  test.identical( m.dims,[ 3,2 ] );
  test.identical( m.length,2 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 4 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,fvec([ 0,1 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,1,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,1,0 ]) );
  test.identical( a1, 1 );
  test.identical( a2, 1 );
  test.identical( m.reduceToSumAtomWise(), 2 );
  test.identical( m.reduceToProductAtomWise(), 0 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  test.case = 'zeroed'; /* */

  m = space.makeZero( 3 );

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,36 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,12 );
  test.identical( m.dims,[ 3,3 ] );
  test.identical( m.length,3 );

  test.identical( m._stridesEffective,[ 1,3 ] );
  test.identical( m.strideOfElement,3 );
  test.identical( m.strideOfCol,3 );
  test.identical( m.strideInCol,1 );
  test.identical( m.strideOfRow,1 );
  test.identical( m.strideInRow,3 );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 1 );
  var c2 = m.lineVectorGet( 0,1 );
  var e = m.eGet( 1 );
  var a1 = m.atomFlatGet( 4 );
  var a2 = m.atomGet([ 1,1 ]);

  test.identical( r1,fvec([ 0,0,0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,0,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,0,0 ]) );
  test.identical( a1, 0 );
  test.identical( a2, 0 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 0 );
  test.identical( m.determinant(),0 );

  test.is( m.buffer instanceof Float32Array );
  test.identical( m.strides,null );

  //

  function checkNull( m )
  {

    logger.log( 'm\n' + _.toStr( m ) );

    test.identical( m.size,0 );
    test.identical( m.sizeOfElement,0 );
    test.identical( m.sizeOfCol,0 );
    test.identical( m.sizeOfRow,0 );
    test.identical( m.dims,[ 0,0 ] );
    test.identical( m.length,0 );

    test.identical( m._stridesEffective,[ 1,0 ] );
    test.identical( m.strideOfElement,0 );
    test.identical( m.strideOfCol,0 );
    test.identical( m.strideInCol,1 );
    test.identical( m.strideOfRow,1 );
    test.identical( m.strideInRow,0 );

    test.identical( m.reduceToSumAtomWise(), 0 );
    test.identical( m.reduceToProductAtomWise(), 1 );
    test.identical( m.determinant(),0 );
    test.is( m.buffer instanceof Float32Array );

    if( Config.debug )
    {

      test.shouldThrowErrorSync( () => m.colVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.lineVectorGet( 0,0 ) );
      test.shouldThrowErrorSync( () => m.eGet( 0 ) );
      test.shouldThrowErrorSync( () => m.rowVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.colVectorGet( 0 ) );
      test.shouldThrowErrorSync( () => m.eGet( 0 ) );
      test.shouldThrowErrorSync( () => m.atomFlatGet( 0 ) );
      test.shouldThrowErrorSync( () => m.atomGet( 0 ) );

    }

  }

  test.case = 'square null with buffer'; /* */

  var m = space.makeSquare([]);
  checkNull( m );

  test.case = 'square null with length'; /* */

  var m = space.makeSquare( 0 );
  checkNull( m );

  test.case = 'zeroed null'; /* */

  var m = space.makeZero([ 0,0 ]);
  checkNull( m );

  test.case = 'identity null'; /* */

  var m = space.makeIdentity([ 0,0 ]);
  checkNull( m );

  test.case = 'diagonal null'; /* */

  var m = space.makeDiagonal([]);
  checkNull( m );

}

//

function makeLine( test )
{

  function checkCol( m )
  {

    logger.log( 'm\n' + _.toStr( m ) );

    test.identical( m.size,12 );
    test.identical( m.sizeOfElement,12 );
    test.identical( m.sizeOfCol,12 );
    test.identical( m.sizeOfRow,4 );
    test.identical( m.dims,[ 3,1 ] );
    test.identical( m.length,1 );

    test.identical( m._stridesEffective,[ 1,3 ] );
    test.identical( m.strideOfElement,3 );
    test.identical( m.strideOfCol,3 );
    test.identical( m.strideInCol,1 );
    test.identical( m.strideOfRow,1 );
    test.identical( m.strideInRow,3 );

    test.identical( m.strides,null );
    test.is( m.buffer instanceof Float32Array );

  }

  function checkRow( m )
  {

    logger.log( 'm\n' + _.toStr( m ) );

    test.identical( m.size,12 );
    test.identical( m.sizeOfElement,4 );
    test.identical( m.sizeOfCol,4 );
    test.identical( m.sizeOfRow,12 );
    test.identical( m.dims,[ 1,3 ] );
    test.identical( m.length,3 );

    test.identical( m._stridesEffective,[ 1,1 ] );
    test.identical( m.strideOfElement,1 );
    test.identical( m.strideOfCol,1 );
    test.identical( m.strideInCol,1 );
    test.identical( m.strideOfRow,1 );
    test.identical( m.strideInRow,1 );

    test.identical( m.strides,null );
    test.is( m.buffer instanceof Float32Array );

  }

  test.case = 'make col'; /* */

  var m = space.makeCol( 3 );

  checkCol( m );

  var m = space.makeLine
  ({
    dimension : 0,
    buffer : 3,
  });

  checkCol( m );

  var m = space.makeLine
  ({
    dimension : 0,
    buffer : new Float32Array([ 1,2,3 ]),
  });

  checkCol( m );

  test.case = 'make col from buffer'; /* */

  var m = space.makeCol([ 1,2,3 ]);

  checkCol( m );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,fvec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.case = 'make col from vector with Array'; /* */

  var v = vector.fromSubArrayWithStride( [ -1,1,-1,2,-1,3,-1 ],1,3,2 );
  var m = space.makeCol( v );

  checkCol( m );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,fvec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.is( v._vectorBuffer !== m.buffer );

  test.case = 'make col from vector with Float32Array'; /* */

  var v = vector.fromSubArrayWithStride( new Float32Array([ -1,1,-1,2,-1,3,-1 ]),1,3,2 );
  var m = space.makeCol( v );

  logger.log( 'm\n' + _.toStr( m ) );

  test.identical( m.size,12 );
  test.identical( m.sizeOfElement,12 );
  test.identical( m.sizeOfCol,12 );
  test.identical( m.sizeOfRow,4 );
  test.identical( m.dims,[ 3,1 ] );
  test.identical( m.length,1 );

  test.identical( m._stridesEffective,[ 2,2 ] );
  test.identical( m.strideOfElement,2 );
  test.identical( m.strideOfCol,2 );
  test.identical( m.strideInCol,2 );
  test.identical( m.strideOfRow,2 );
  test.identical( m.strideInRow,2 );

  test.identical( m.strides,[ 2,2 ] );
  test.is( m.buffer instanceof Float32Array );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 2 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,fvec([ 2 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 1,2,3 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 1,2,3 ]) );
  test.identical( a1, 2 );
  test.identical( a2, 2 );
  test.identical( m.reduceToSumAtomWise(), 6 );
  test.identical( m.reduceToProductAtomWise(), 6 );

  test.is( v._vectorBuffer === m.buffer );

  test.case = 'make col zeroed'; /* */

  var m = space.makeColZeroed( 3 );

  checkCol( m );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,fvec([ 0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,0,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,0,0 ]) );
  test.identical( a1, 0 );
  test.identical( a2, 0 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 0 );

  test.case = 'make col zeroed from buffer'; /* */

  var m = space.makeColZeroed([ 1,2,3 ]);

  checkCol( m );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,fvec([ 0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,0,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,0,0 ]) );
  test.identical( a1, 0 );
  test.identical( a2, 0 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 0 );

  test.case = 'make col zeroed from vector'; /* */

  var v = vector.fromSubArrayWithStride( new Float32Array([ -1,1,-1,2,-1,3,-1 ]),1,3,2 );
  var m = space.makeColZeroed( v );

  checkCol( m );

  var r1 = m.rowVectorGet( 1 );
  var r2 = m.lineVectorGet( 1,1 );
  var c1 = m.colVectorGet( 0 );
  var c2 = m.lineVectorGet( 0,0 );
  var e = m.eGet( 0 );
  var a1 = m.atomFlatGet( 1 );
  var a2 = m.atomGet([ 1,0 ]);

  test.identical( r1,fvec([ 0 ]) );
  test.identical( r1,r2 );
  test.identical( c1,fvec([ 0,0,0 ]) );
  test.identical( c1,c2 );
  test.identical( e,fvec([ 0,0,0 ]) );
  test.identical( a1, 0 );
  test.identical( a2, 0 );
  test.identical( m.reduceToSumAtomWise(), 0 );
  test.identical( m.reduceToProductAtomWise(), 0 );

  test.case = 'make col from col'; /* */

  var om = space.makeCol([ 1,2,3 ]);
  var m = space.makeCol( om );

  checkCol( m );

  var r1 = m.rowVectorGet