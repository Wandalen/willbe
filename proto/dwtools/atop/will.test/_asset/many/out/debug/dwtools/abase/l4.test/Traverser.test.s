( function _Traverser_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../l4/Traverser.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// test
// --

function trivial( test )
{

  var a = { x : 1, dir : { y : 2, z : 'x' }, buffer : new Float32Array([ 1,2,3 ]), array : [ 3,4,5 ] };

  // onString : null,
  // onRoutine : null,
  // onBuffer : null,
  // onInstanceCopy : null,
  // onContainerUp : null,
  // onContainerDown : null,
  // onEntityUp : null,
  // onEntityDown : null,
//
  // onMapUp : () => true,
  // onMapElementUp : () => true,
  // onMapElementDown : () => true,
  // onArrayUp : () => true,
  // onBuffer : () => true,

  var onMapUpPaths = [];
  function onMapUp( it )
  {
    onMapUpPaths.push( it.path );
    return it;
  }

  var onMapElementUpPaths = [];
  function onMapElementUp( parent, child )
  {
    onMapElementUpPaths.push( child.path );
    return child;
  }

  var onMapElementDownPaths = [];
  function onMapElementDown( parent, child )
  {
    onMapElementDownPaths.push( child.path );
    return child;
  }

  var onArrayUpPaths = [];
  function onArrayUp( it )
  {
    onArrayUpPaths.push( it.path );
    return it;
  }

  var onBufferPaths = [];
  function onBuffer( src,it )
  {
    onBufferPaths.push( it.path );
    return it;
  }

  var r = _.traverse
  ({
    src : a,
    onBuffer,
    onMapElementUp,
    onMapElementDown,
    onArrayUp,
    onMapUp,
  })
  console.log( r );

  test.identical( onMapUpPaths,[ '/','/dir' ] );
  test.identical( onMapElementUpPaths,[ '/x', '/dir', '/dir/y', '/dir/z', '/buffer', '/array' ] );
  test.identical( onMapElementDownPaths,[ '/x', '/dir/y', '/dir/z', '/dir', '/buffer', '/array' ] );
  test.identical( onArrayUpPaths,[ '/array' ] );
  test.identical( onBufferPaths,[ '/buffer' ] );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.l4.Traverser',
  silencing : 1,

  tests :
  {

    trivial,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
