( function _Quat_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  require( '../l8/Concepts.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var Parent = wTester;

var vector = _.vector;
var avector = _.avector;
var sqrt = _.sqrt;
var abs = Math.abs;
var pi = Math.PI;

_.assert( _.routineIs( sqrt ) );

// --
// routines
// --

function eachQuat( onQuat )
{

  // test.case = 'ordinary cases 1'; /* */

  var begin = [ -0.6,-0.5,-0.345 ];
  var end = [ +0.5,+0.7,+0.345 ];
  for( var i = 0 ; i < 1000 ; i++ )
  {

    var quat1 = _.avector.mix( null,begin,end,i/999 );
    quat1[ 3 ] = sqrt( 1 - quat1[ 0 ]**2 - quat1[ 1 ]**2 - quat1[ 2 ]**2 );

    // var axisAndAngle = _.quat.toAxisAndAngle( quat1,null );
    // var quat2 = _.quat.fromAxisAndAngle( null,axisAndAngle );
    // test.equivalent( quat1,quat2 );

    onQuat( quat1 );

    // logger.log( 'quat1',quat1 );
    // logger.log( 'quat2',quat2 );
    // logger.log( 'axisAndAngle',axisAndAngle );

  }

  // test.case = 'ordinary cases 2'; /* */

  var begin = [ -0.25,-0.7,-0.515 ];
  var end = [ +0.6,+0.3,+0.246 ];
  for( var i = 0 ; i < 1000 ; i++ )
  {

    var quat1 = _.avector.mix( null,begin,end,i/999 );
    quat1[ 3 ] = sqrt( 1 - quat1[ 0 ]**2 - quat1[ 1 ]**2 - quat1[ 2 ]**2 );

    onQuat( quat1 );

    // var axisAndAngle = _.quat.toAxisAndAngle( quat1,null );
    // var quat2 = _.quat.fromAxisAndAngle( null,axisAndAngle );
    // test.equivalent( quat1,quat2 );

    // logger.log( 'quat1',quat1 );
    // logger.log( 'quat2',quat2 );
    // logger.log( 'axisAndAngle',axisAndAngle );

  }

}

// --
// test
// --


function make( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.quat.make( src );
  var expected = [ 0,0,0,1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.quat.make( src );
  var expected = [ 0,0,0,1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,3 ];
  var got = _.quat.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.quat.make( src );
  var expected = [ 0,1,2,3 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.quat.make( 0 ) );
  test.shouldThrowErrorSync( () => _.quat.make( 4 ) );
  test.shouldThrowErrorSync( () => _.quat.make( '4' ) );
  test.shouldThrowErrorSync( () => _.quat.make( [ 0,0,0,1 ],2 ) );

}

//

function makeZero( test )
{

  test.case = 'trivial'; /* */

  var got = _.quat.makeZero();
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.quat.makeZero( undefined ) );
  test.shouldThrowErrorSync( () => _.quat.makeZero( null ) );
  test.shouldThrowErrorSync( () => _.quat.makeZero( 4 ) );
  test.shouldThrowErrorSync( () => _.quat.makeZero([ 0,0,0,1 ]) );
  test.shouldThrowErrorSync( () => _.quat.makeZero( '4' ) );
  test.shouldThrowErrorSync( () => _.quat.makeZero( [ 0,0,0,1 ],2 ) );

}

//

function makeUnit( test )
{

  test.case = 'trivial'; /* */

  var got = _.quat.makeUnit();
  var expected = [ 0,0,0,1 ];
  test.identical( got,expected );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.quat.makeUnit( undefined ) );
  test.shouldThrowErrorSync( () => _.quat.makeUnit( null ) );
  test.shouldThrowErrorSync( () => _.quat.makeUnit( 4 ) );
  test.shouldThrowErrorSync( () => _.quat.makeUnit([ 0,0,0,1 ]) );
  test.shouldThrowErrorSync( () => _.quat.makeUnit( '4' ) );
  test.shouldThrowErrorSync( () => _.quat.makeUnit( [ 0,0,0,1 ],2 ) );

}

//

function zero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.quat.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.quat.zero( src );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.quat.zero( dst );
  var expected = [ 0,0,0,0 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.quat.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,0 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.quat.zero( 4 ) );
  test.shouldThrowErrorSync( () => _.quat.zero([ 0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.quat.zero( '4' ) );
  test.shouldThrowErrorSync( () => _.quat.zero( [ 0,0,0,1 ],2 ) );

}

//

function unit( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.quat.unit( src );
  var expected = [ 0,0,0,1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.quat.unit( src );
  var expected = [ 0,0,0,1 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,3 ];
  var got = _.quat.unit( dst );
  var expected = [ 0,0,0,1 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,3 ]);
  var got = _.quat.unit( dst );
  var expected = _.vector.fromArray([ 0,0,0,1 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.quat.unit( 4 ) );
  test.shouldThrowErrorSync( () => _.quat.unit([ 0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.quat.unit( '4' ) );
  test.shouldThrowErrorSync( () => _.quat.unit( [ 0,0,0,1 ],2 ) );

}

//

function fromEuler( test )
{

  var accuracy = test.accuracy*0.1;
  var h = _.sqrt( 2 ) / 2;

  // debugger;
  // for( var order in _.euler.Order )
  // {
  //   var euler = _.arrayAppendArray( [ 1,1,1 ],_.euler.Order[ order ] );
  //   logger.log( order,_.quat.fromEuler( null,euler ) );
  // }
  // debugger;

  function sampleTest( signs )
  {

    euler1 = _.euler.fromQuat( euler1,quat1 );

    var quat2 = _.quat.fromEuler( null,euler1 );
    var euler2 = _.euler.fromQuat( euler1.slice(),quat2 );

    // var quat3 = _.quat.fromEuler( null,euler2 );
    var m1 = _.quat.toMatrix( quat1,null );
    var euler3 = _.euler.fromMatrix( euler1.slice(),m1 );
    var quat3 = _.quat.fromEuler( null,euler3 );

    var applied1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
    var applied2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );
    var applied3 = _.quat.applyTo( quat3,[ 0.25,0.5,1.0 ] );

    // test.equivalent( quat1,quat3 );
    // test.equivalent( quat2,quat3 );
    // test.equivalent( euler2,euler1 );

    test.equivalent( applied2,applied1 );
    // test.equivalent( applied3,applied1 );

    // logger.log( 'signs',signs );

    logger.log( 'quat1',quat1 );
    logger.log( 'quat2',quat2 );
    logger.log( 'quat3',quat3 );

    logger.log( 'applied1',applied1 );
    logger.log( 'applied2',applied2 );
    logger.log( 'applied3',applied3 );

    logger.log( 'euler1',euler1 );
    logger.log( 'euler2',euler2 );
    logger.log( 'euler3',euler3 );

    // [ x: -1.1460588, y: 0.4274791, z: -2.863293 ]

  }

  test.case = 'trivial xyz'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var euler1 = [ 0,0,0, 0,1,2 ];

  sampleTest();

  test.case = 'trivial xzy'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var euler1 = [ 0,0,0,0,2,1 ];

  sampleTest();

  test.case = 'trivial yxz'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var euler1 = [ 0,0,0,1,0,2 ];

  sampleTest();

  test.case = 'trivial yzx'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var euler1 = [ 0,0,0,1,2,0 ];

  sampleTest();

  test.case = 'trivial zxy'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var euler1 = [ 0,0,0,2,0,1 ];

  sampleTest();

  test.case = 'trivial zyx'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var euler1 = [ 0,0,0,2,1,0 ];

  sampleTest();

  // test.identical( 0,1 );
}

fromEuler.accuracy = 1e-15;

//

function fromAxisAndAngle( test )
{

  _.assert( test.accuracy > 0 );

  test.case = 'zero'; /* */

  var expected = [ 0,0,0,1 ];
  var got = _.quat.fromAxisAndAngle( null,[ 0,0,0 ],0 );
  test.equivalent( got,expected );
  var got = _.quat.fromAxisAndAngle( null,[ 1,0,0 ],0 );
  test.equivalent( got,expected );
  var got = _.quat.fromAxisAndAngle( null,[ 0,1,0 ],0 );
  test.equivalent( got,expected );
  var got = _.quat.fromAxisAndAngle( null,[ 0,0,1 ],0 );
  test.equivalent( got,expected );

  test.case = 'near zero'; /* */

  var angle = test.accuracy;
  var expected = [ 0.00000004999999873689376,0,0,1 ];
  var got = _.quat.fromAxisAndAngle( null,[ 1,0,0 ],angle );
  test.equivalent( got,expected );
  var expected = [ 0,0.00000004999999873689376,0,1 ];
  var got = _.quat.fromAxisAndAngle( null,[ 0,1,0 ],angle );
  test.equivalent( got,expected );
  var expected = [ 0,0,0.00000004999999873689376,1 ];
  var got = _.quat.fromAxisAndAngle( null,[ 0,0,1 ],angle );
  test.equivalent( got,expected );

  /* */

  var h = _.sqrt( 2 ) / 2;
  var samples =
  [

    { d : 'zero', angle : 0, tc : 0, oc : 0, w : 1 },

    { d : '+pi/2', angle : +pi/2, tc : +h, oc : 0, w : +h },
    { d : '-pi/2', angle : -pi/2, tc : -h, oc : 0, w : +h },

    { d : '+pi', angle : +pi, tc : +1, oc : 0, w : 0 },
    { d : '-pi', angle : -pi, tc : -1, oc : 0, w : 0 },

    { d : '+pi*2', angle : +pi*2, tc : 0, oc : 0, w : -1 },
    { d : '-pi*2', angle : -pi*2, tc : 0, oc : 0, w : -1 },

  ]

  /* */

  var axis, expected;

  function caseTest()
  {

    var quat = _.quat.fromAxisAndAngle( null,axis,angle );
    test.equivalent( quat, expected );

    axis[ 3 ] = angle;
    var quat = _.quat.fromAxisAndAngle( null,_.vector.from( axis ) );
    test.equivalent( quat, expected );

    axis[ 3 ] = angle;
    var quat = _.quat.fromAxisAndAngle( null,axis );
    test.equivalent( quat, expected );

    if( _.avector.mag( axis ) !== 0 && abs( angle ) <= test.accuracy )
    return;

    var axis2 = _.quat.toAxisAndAngle( quat,null );

    if( axis2[ 0 ]*axis[ 0 ] < 0 || axis2[ 1 ]*axis[ 1 ] < 0 || axis2[ 2 ]*axis[ 2 ] < 0 || axis2[ 3 ]*axis[ 3 ] < 0 )
    _.avector.mul( axis2,-1 );

    if( axis2[ 0 ]*axis[ 0 ] < 0 || axis2[ 1 ]*axis[ 1 ] < 0 || axis2[ 2 ]*axis[ 2 ] < 0 || axis2[ 3 ]*axis[ 3 ] < 0 )
    {
      var mod = abs( axis2[ 3 ] ) % ( 2*pi );
      if( abs( mod ) < 1e-4 || abs( abs( mod ) - 2*pi ) < 1e-4 )
      axis2[ 3 ] *= -1;
    }

    if( axis2[ 0 ]*axis[ 0 ] < 0 || axis2[ 1 ]*axis[ 1 ] < 0 || axis2[ 2 ]*axis[ 2 ] < 0 || axis2[ 3 ]*axis[ 3 ] < 0 )
    _.avector.mul( axis2,-1 );

    test.equivalent( axis, axis2, test.accuracy*10 );

  }

  /* */

  function allAxisesTest( d )
  {

    test.case = d + ' with axis ' + _.toStr( axis );
    expected = [ sample.oc, sample.oc, sample.oc, sample.w ];
    axis = [ 0,0,0 ];
    caseTest();

    test.case = d + ' with axis ' + _.toStr( axis );
    expected = [ sample.tc, sample.oc, sample.oc, sample.w ];
    axis = [ 1,0,0 ];
    caseTest();

    test.case = d + ' with axis ' + _.toStr( axis );
    expected = [ sample.oc, sample.tc, sample.oc, sample.w ];
    axis = [ 0,1,0 ];
    caseTest();

    test.case = d + ' with axis ' + _.toStr( axis );
    expected = [ sample.oc, sample.oc, sample.tc, sample.w ];
    axis = [ 0,0,1 ];
    caseTest();

    test.case = d + ' with axis ' + _.toStr( axis );
    expected = [ sample.tc, sample.tc, sample.tc, sample.w ];
    axis = [ 1,1,1 ];
    caseTest();

  }

  /* special cases */

  if( 0 )
  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];

    var angle = sample.angle;
    allAxisesTest( sample.d );

    var angle = sample.angle - test.accuracy;
    allAxisesTest( 'below ' + sample.d );

    var angle = sample.angle - test.accuracy*0.1;
    allAxisesTest( 'below ' + sample.d );

    var angle = sample.angle + test.accuracy;
    allAxisesTest( 'above ' + sample.d );

    var angle = sample.angle + test.accuracy*0.1;
    allAxisesTest( 'above ' + sample.d );

  }

  test.case = 'ordinary cases'; /* */

  eachQuat( function( quat1 )
  {

    var axisAndAngle = _.quat.toAxisAndAngle( quat1,null );
    var quat2 = _.quat.fromAxisAndAngle( null,axisAndAngle );

    test.equivalent( quat1,quat2 );

    // logger.log( 'quat1',quat1 );
    // logger.log( 'quat2',quat2 );
    // logger.log( 'axisAndAngle',axisAndAngle );

  });

  /* throwing error */

  return;
  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( 1 ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( undefined,[ 1,2,3 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( null,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1 ],undefined ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1 ],[ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1 ],[ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [],function(){} ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1,1 ],3 ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1,1,1 ],3,3 ) );
  test.shouldThrowErrorSync( () => _.quat.fromAxisAndAngle( [ 1,1,1 ],3,[ 1,2,3 ] ) );

}

fromAxisAndAngle.accuracy = [ _.accuracy * 1e+2, 1e-1 ];
fromAxisAndAngle.timeOut = 10000;

//

function eulerToQuatToAxisAndAngleToQuatSlow( test )
{
  debugger;

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var axisAngle = _.axisAndAngle.makeZero();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI/6 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked =  [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  /* */

  var o =
  {
    deltas : deltas,
    angles : angles,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    axisAngle = _.quat.toAxisAndAngle( quat1, axisAngle );
    quat2 = _.quat.fromAxisAndAngle( quat2, axisAngle );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToAxisAndAngleToQuatSlow.timeOut = 100000;
eulerToQuatToAxisAndAngleToQuatSlow.usingSourceCode = 0;
eulerToQuatToAxisAndAngleToQuatSlow.rapidity = 2;

//

function _fromVectors( test,r,normalized )
{

  var accuracy = test.accuracy*0.1;
  var h = _.sqrt( 2 ) / 2;

  test.case = 'same avectors'; /* */

  var expected = [ 0,0,0,normalized ? 1 : 0 ];
  var got = _.quat[ r ]( null,[ 0,0,0 ],[ 0,0,0 ] );
  test.equivalent( got,expected );

  var expected = [ 0,0,0,1 ];
  var got = _.quat[ r ]( null,[ 1,0,0 ],[ 1,0,0 ] );
  test.equivalent( got,expected );
  var got = _.quat[ r ]( null,[ 0,1,0 ],[ 0,1,0 ] );
  test.equivalent( got,expected );
  var got = _.quat[ r ]( null,[ 0,0,1 ],[ 0,0,1 ] );
  test.equivalent( got,expected );

  /* */

  var samples =
  [

    { d : 'from x', v1 : [ 1,0,0 ], v2 : [ 1,0,0 ], e : [ 0,0,0,1 ] },
    { d : 'from x', v1 : [ 1,0,0 ], v2 : [ 0,1,0 ], e : [ 0,0,+h,+h ] },
    { d : 'from x', v1 : [ 1,0,0 ], v2 : [ 0,0,1 ], e : [ 0,-h,0,+h ] },

    { d : 'from y', v1 : [ 0,1,0 ], v2 : [ 1,0,0 ], e : [ 0,0,-h,+h ] },
    { d : 'from y', v1 : [ 0,1,0 ], v2 : [ 0,1,0 ], e : [ 0,0,0,1 ] },
    { d : 'from y', v1 : [ 0,1,0 ], v2 : [ 0,0,1 ], e : [ +h,0,0,+h ] },

    { d : 'from z', v1 : [ 0,0,1 ], v2 : [ 1,0,0 ], e : [ 0,+h,0,+h ] },
    { d : 'from z', v1 : [ 0,0,1 ], v2 : [ 0,1,0 ], e : [ -h,0,0,+h ] },
    { d : 'from z', v1 : [ 0,0,1 ], v2 : [ 0,0,1 ], e : [ 0,0,0,1 ] },

    { d : 'from x', v1 : [ 1,0,0 ], v2 : [ -1,0,0 ], e : [ 0,0,1,0 ] },
    { d : 'from x', v1 : [ 1,0,0 ], v2 : [ 0,-1,0 ], e : [ 0,0,-h,+h ] },
    { d : 'from x', v1 : [ 1,0,0 ], v2 : [ 0,0,-1 ], e : [ 0,+h,0,+h ] },

    { d : 'from y', v1 : [ 0,1,0 ], v2 : [ -1,0,0 ], e : [ 0,0,+h,+h ] },
    { d : 'from y', v1 : [ 0,1,0 ], v2 : [ 0,-1,0 ], e : [ 0,1,0,0 ] },
    { d : 'from y', v1 : [ 0,1,0 ], v2 : [ 0,0,-1 ], e : [ -h,0,0,+h ] },

    { d : 'from z', v1 : [ 0,0,1 ], v2 : [ -1,0,0 ], e : [ 0,-h,0,+h ] },
    { d : 'from z', v1 : [ 0,0,1 ], v2 : [ 0,-1,0 ], e : [ +h,0,0,+h ] },
    { d : 'from z', v1 : [ 0,0,1 ], v2 : [ 0,0,-1 ], e : [ -1,0,0,0 ] },

  ]

  /* */

  function caseTest()
  {

    var got = _.quat[ r ]( null,v1,v2 );
    test.equivalent( got, sample.e );

  }

  /* */

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];

    test.case = sample.d;
    var v1 = sample.v1.slice();
    var v2 = sample.v2.slice();

    caseTest();

    test.case = 'near ' + sample.d;

    var v1 = sample.v1.slice();
    var v2 = sample.v2.slice();

    for( var i = 0 ; i < 3 ; i++ )
    v1[ i ] -= accuracy;

    for( var i = 0 ; i < 3 ; i++ )
    v2[ i ] -= accuracy;

    caseTest();

    var v1 = sample.v1.slice();
    var v2 = sample.v2.slice();

    for( var i = 0 ; i < 3 ; i++ )
    v1[ i ] -= accuracy;

    for( var i = 0 ; i < 3 ; i++ )
    v2[ i ] += accuracy;

    caseTest();

    var v1 = sample.v1.slice();
    var v2 = sample.v2.slice();

    for( var i = 0 ; i < 3 ; i++ )
    v1[ i ] += accuracy;

    for( var i = 0 ; i < 3 ; i++ )
    v2[ i ] -= accuracy;

    caseTest();

    var v1 = sample.v1.slice();
    var v2 = sample.v2.slice();

    for( var i = 0 ; i < 3 ; i++ )
    v1[ i ] += accuracy;

    for( var i = 0 ; i < 3 ; i++ )
    v2[ i ] += accuracy;

    caseTest();

  }

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.quat[ r ]( 1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( null,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],undefined ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],[ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],[ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [],function(){} ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1 ],3 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1 ],3,3 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1 ],3,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1 ],3,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1,1,1 ],[ 1,2,3 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1,1 ],[ 1,2,3,1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1,1 ],[ 1,2,3 ],[ 1,2,3,1 ] ) );

}

//

function fromVectors( test )
{

  this._fromVectors( test,'fromVectors',0 );

}

fromVectors.accuracy = [ _.accuracy * 1e-3, 1e-3 ];

//

function fromNormalizedVectors( test )
{

  this._fromVectors( test,'fromNormalizedVectors',1 );

}

fromNormalizedVectors.accuracy = 1e-7;

//

function _fromMatrixRotation( test,precise,r )
{

  test.case = 'trivial';

  var axis = null;
  var h = _.sqrt( 2 ) / 2;
  var accuracy = precise ? test.accuracy*1e-1 : test.accuracy*1e-2;
  var samples =
  [

    { d : 'zero', angle : 0 },

    { d : '+pi/2', angle : +pi/2 },
    { d : '-pi/2', angle : -pi/2 },

    { d : '+pi', angle : +pi },
    { d : '-pi', angle : -pi },

    { d : '+pi*2', angle : +pi*2 },
    { d : '-pi*2', angle : -pi*2 },

  ]

  /* */

  function testSubCase()
  {

    var q1 = _.quat.fromAxisAndAngle( null,axis,angle );
    var m1 = _.Space.make([ 3,3 ]).fromAxisAndAngle( axis,angle );
    var q2 = _.quat[ r ]( null,m1 );
    var m2 = _.Space.make([ 3,3 ]).fromQuat( q1 );
    var q3 = _.quat[ r ]( null,m2 );

    // logger.log( 'q1',q1 );
    // logger.log( 'q2',q2 );
    // logger.log( 'q3',q3 );
    // logger.log( 'm1',m1 );
    // logger.log( 'm2',m2 );
    //
    // logger.log( 'q1',_.quat.applyTo( q1,[ 1,1,1 ] ) );
    // logger.log( 'q2',_.quat.applyTo( q2,[ 1,1,1 ] ) );
    // logger.log( 'q3',_.quat.applyTo( q3,[ 1,1,1 ] ) );

    var expected = _.quat.applyTo( q1,[ 1,1,1 ] );

    test.equivalent( _.quat.applyTo( q1,[ 1,1,1 ] ) , expected );
    test.equivalent( _.quat.applyTo( q2,[ 1,1,1 ] ) , expected );
    test.equivalent( _.quat.applyTo( q3,[ 1,1,1 ] ) , expected );

    test.equivalent( m1.matrixApplyTo([ 1,1,1 ]) , expected );
    test.equivalent( m2.matrixApplyTo([ 1,1,1 ]) , expected );

    // test.equivalent( q3, q1 );
    // test.equivalent( q2, q1 );

    test.equivalent( m2, m1 );

  }

  /* */

  function testAllAxis( postfix )
  {

    test.case = sample.d + postfix + '';

    axis = [ 1,0,0 ];
    testSubCase();

    axis = [ 0,1,0 ];
    testSubCase();

    axis = [ 0,0,1 ];
    testSubCase();

    axis = [ 1/sqrt( 3 ),1/sqrt( 3 ),1/sqrt( 3 ) ];
    testSubCase();

    axis = [ 0.25,0.5,0.82915619758885 ];
    testSubCase();

  }

  /* */

  if( 0 )
  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];

    var angle = sample.angle;
    testAllAxis( '' );

    var angle = sample.angle - accuracy;
    testAllAxis( 'below' );

    var angle = sample.angle + accuracy;
    testAllAxis( 'above' );

  }


  test.case = 'ordinary cases'; /* */

  eachQuat( function( quat1 )
  {

    var matrix = _.quat.toMatrix( quat1,null );
    var quat2 = _.quat.fromMatrixRotation( null,matrix );

    // if( _.avector.mul( null,quat1,quat2 ) <  )

    test.equivalent( quat1,quat2 );

    // logger.log( 'quat1',quat1 );
    // logger.log( 'quat2',quat2 );
    // logger.log( 'axisAndAngle',axisAndAngle );

  });

  test.case = 'bad arguments'; /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.quat[ r ]( 1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( null,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],undefined ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],[ 1 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1 ],[ 1 ],[ 1 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [],function(){} ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1 ],3 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1 ],3,3 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1 ],3,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1 ],3,[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1,1,1 ],[ 1,2,3 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1,1 ],[ 1,2,3,1 ],[ 1,2,3 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( [ 1,1,1,1 ],[ 1,2,3 ],[ 1,2,3,1 ] ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( null,[ 0,0 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( null,[ 0,0,0,0 ],1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( null,[ 0,0,0 ],1,1 ) );
  test.shouldThrowErrorSync( () => _.quat[ r ]( null,[ 0,0,0 ],'1' ) );

}

//

function fromMatrixRotation( test )
{

  this._fromMatrixRotation( test,1,'fromMatrixRotation' );

}

//

function fromMatrixRotation2( test )
{

  this._fromMatrixRotation( test,0,'fromMatrixRotation2' );

}

//

function toMatrix( test )
{

  test.case = 'trivial';

  var axis = null;
  var h = _.sqrt( 2 ) / 2;
  var accuracy = test.accuracy*1e-1;
  var samples =
  [

    { d : 'zero', angle : 0 },

    { d : '+pi/2', angle : +pi/2 },
    { d : '-pi/2', angle : -pi/2 },

    { d : '+pi', angle : +pi },
    { d : '-pi', angle : -pi },

    { d : '+pi*2', angle : +pi*2 },
    { d : '-pi*2', angle : -pi*2 },

  ]

  /* */

  function testSubCase()
  {

    var q1 = _.quat.fromAxisAndAngle( null,axis,angle );
    var m1 = _.Space.make([ 3,3 ]).fromAxisAndAngle( axis,angle );
    var m2 = _.quat.toMatrix( q1,null );

    // logger.log( 'm1',m1 );
    // logger.log( 'm2',m2 );

    var applied1 = _.quat.applyTo( q1,[ 0.25,0.5,1.0 ] );
    var applied2 = m1.matrixApplyTo([ 0.25,0.5,1.0 ] );
    var applied3 = m2.matrixApplyTo([ 0.25,0.5,1.0 ] );

    test.equivalent( applied2,applied1 );
    test.equivalent( applied3,applied1 );

  }

  /* */

  function testAllAxis( postfix )
  {

    test.case = sample.d + postfix + '';

    axis = [ 1,0,0 ];
    testSubCase();

    axis = [ 0,1,0 ];
    testSubCase();

    axis = [ 0,0,1 ];
    testSubCase();

    axis = [ 1/sqrt( 3 ),1/sqrt( 3 ),1/sqrt( 3 ) ];
    testSubCase();

    axis = [ 0.25,0.5,0.82915619758885 ];
    testSubCase();

  }

  /* */

  if( 0 )
  for( var s = 0 ; s < samples.length ; s++ )
  {
    var sample = samples[ s ];

    var angle = sample.angle;
    testAllAxis( '' );

    var angle = sample.angle - accuracy;
    testAllAxis( 'below' );

    var angle = sample.angle + accuracy;
    testAllAxis( 'above' );

  }

  /* */

  test.case = 'complicated';

  var axis = [ 0.25,0.5,0.82915619758885 ];
  var angle = pi/3;
  testSubCase();

  var q1 = [ 0.25,0.5,0.82915619758885,0 ];
  var m1 = _.quat.toMatrix( q1,null );
  var applied1 = _.quat.applyTo( q1,[ 0.25,0.5,1.0 ] );
  var applied2 = m1.matrixApplyTo([ 0.25,0.5,1.0 ] );
  test.equivalent( applied2, applied1 );

  logger.log( 'm1',m1 );

}

toMatrix.accuracy = [ _.accuracy, 1e-1 ];

//

function eulerToQuatToMatrixToQuatFast( test )
{
  debugger;

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var matrix = _.Space.makeZero( [ 3, 3 ] );
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  // var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  // var deltas = [ -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var deltas = [ -accuracySqr, 0, +accuracySqr, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked = [ Math.PI / 3 ];

  /* */

  var o =
  {
    deltas : deltas,
    angles : angles,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    matrix = _.quat.toMatrix( quat1, matrix );
    quat2 = _.quat.fromMatrixRotation( quat2, matrix );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToMatrixToQuatFast.timeOut = 20000;
eulerToQuatToMatrixToQuatFast.usingSourceCode = 0;
eulerToQuatToMatrixToQuatFast.rapidity = 3;

//

function eulerToQuatToMatrixToQuatSlow( test )
{
  debugger;

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler = _.euler.make();
  var quat1 = _.quat.make();
  var matrix = _.Space.makeZero( [ 3, 3 ] );
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI/6 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked =  [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  /* */

  var o =
  {
    deltas : deltas,
    angles : angles,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler )
  {
    quat1 = _.euler.toQuat2( euler, quat1 );
    matrix = _.quat.toMatrix( quat1, matrix );
    quat2 = _.quat.fromMatrixRotation( quat2, matrix );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToMatrixToQuatSlow.timeOut = 100000;
eulerToQuatToMatrixToQuatSlow.usingSourceCode = 0;
eulerToQuatToMatrixToQuatSlow.rapidity = 2;

//

function is( test )
{

  test.case = 'array'; /* */

  test.is( !_.quat.is([ 0 ]) );
  test.is( !_.quat.is([ 0,0 ]) );
  test.is( !_.quat.is([ 0,0,0 ]) );
  test.is( _.quat.is([ 0,0,0,0 ]) );
  test.is( !_.quat.is([ 0,0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( !_.quat.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.quat.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( !_.quat.is( _.vector.fromArray([ 0,0,0 ]) ) );
  test.is( _.quat.is( _.vector.fromArray([ 0,0,0,0 ]) ) );
  test.is( !_.quat.is( _.vector.fromArray([ 0,0,0,0,0 ]) ) );

  test.case = 'not quat'; /* */

  test.is( !_.quat.is( [] ) );
  test.is( !_.quat.is( _.vector.fromArray([]) ) );
  test.is( !_.quat.is( 'abc' ) );
  test.is( !_.quat.is( { center : [ 0,0,0 ], radius : 1 } ) );
  test.is( !_.quat.is( function( a,b,c ){} ) );

}

//

function isZero( test )
{

  test.case = 'zero'; /* */

  test.is( _.quat.isZero([ 0,0,0,0 ]) );

  test.case = 'not zero'; /* */

  test.is( !_.quat.isZero([ 0,0,0,1 ]) );
  test.is( !_.quat.isZero([ 0,0,0,1.1 ]) );
  test.is( !_.quat.isZero([ 0,0,0,Infinity ]) );

  test.is( !_.quat.isZero([ 1,0,0,0 ]) );
  test.is( !_.quat.isZero([ 0,1,0,0 ]) );
  test.is( !_.quat.isZero([ 0,0,1,0 ]) );

  test.is( !_.quat.isZero([ 1,0,0,1 ]) );
  test.is( !_.quat.isZero([ 0,1,0,1 ]) );
  test.is( !_.quat.isZero([ 0,0,1,1 ]) );

  test.is( !_.quat.isZero([ 0.1,0,0,0 ]) );
  test.is( !_.quat.isZero([ 0,0.1,0,0 ]) );
  test.is( !_.quat.isZero([ 0,0,0.1,0 ]) );

  test.is( !_.quat.isZero([ 0.1,0,0,1 ]) );
  test.is( !_.quat.isZero([ 0,0.1,0,1 ]) );
  test.is( !_.quat.isZero([ 0,0,0.1,1 ]) );

}

//

function isUnit( test )
{

  test.case = 'zero'; /* */

  test.is( _.quat.isUnit([ 0,0,0,1 ]) );

  test.case = 'not zero'; /* */

  test.is( !_.quat.isUnit([ 0,0,0,0 ]) );
  test.is( !_.quat.isUnit([ 0,0,0,1.1 ]) );
  test.is( !_.quat.isUnit([ 0,0,0,Infinity ]) );

  test.is( !_.quat.isUnit([ 1,0,0,0 ]) );
  test.is( !_.quat.isUnit([ 0,1,0,0 ]) );
  test.is( !_.quat.isUnit([ 0,0,1,0 ]) );

  test.is( !_.quat.isUnit([ 1,0,0,1 ]) );
  test.is( !_.quat.isUnit([ 0,1,0,1 ]) );
  test.is( !_.quat.isUnit([ 0,0,1,1 ]) );

  test.is( !_.quat.isUnit([ 0.1,0,0,0 ]) );
  test.is( !_.quat.isUnit([ 0,0.1,0,0 ]) );
  test.is( !_.quat.isUnit([ 0,0,0.1,0 ]) );

  test.is( !_.quat.isUnit([ 0.1,0,0,1 ]) );
  test.is( !_.quat.isUnit([ 0,0.1,0,1 ]) );
  test.is( !_.quat.isUnit([ 0,0,0.1,1 ]) );

}

//

function eachAngle( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.routineOptions( eachAngle, o );

  /**/

  // o.angles = o.angles.slice( 0, 1 );
  // o.quadrants = o.quadrants.slice( 0, 1 );
  // o.quadrantsLocked = o.quadrantsLocked.slice( 0, 1 );
  // o.deltas = o.deltas.slice( 0, 1 );
  // o.deltasLocked = o.deltasLocked.slice( 0, 1 );

  /**/

  // o.angles = o.angles;
  // o.quadrants = o.quadrants;
  // o.quadrantsLocked = o.quadrantsLocked;
  // o.deltas = o.deltas.slice( 0,1 );
  // o.deltasLocked = o.deltasLocked.slice( 0,1 );

  /**/

  var euler = _.euler.from( o.dst );
  for( var r = 0; r < o.representations.length; r++ )
  {
    var representation = o.representations[ r ];
    _.euler.representationSet( euler, representation );
    for( var ang1 = 0; ang1 < o.angles.length; ang1++ )
    {
      for( var quad1 = 0; quad1 < o.quadrants.length; quad1++ )
      {
        for( var d = 0; d < o.deltas.length; d++ )
        {
          euler[ 0 ] = o.angles[ ang1 ] + o.quadrants[ quad1 ]*Math.PI/2 + o.deltas[ d ];
          for( var ang2 = ang1; ang2 < o.angles.length; ang2++ )
          {
            for( var quad2 = quad1; quad2 < o.quadrants.length; quad2++ )
            {
              for( var d2 = 0; d2 < o.deltas.length; d2++ )
              {
                euler[ 1 ] = o.angles[ ang2 ] + o.quadrants[ quad2 ]*Math.PI/2 + o.deltas[ d2 ];
                for( var ang3 = 0; ang3 < o.anglesLocked.length; ang3++ )
                {
                  for( var quad3 = 0; quad3 < o.quadrantsLocked.length; quad3++ )
                  {
                    for( var d3 = 0; d3 < o.deltasLocked.length; d3++ )
                    {
                      euler[ 2 ] = o.anglesLocked[ ang3 ] + o.quadrantsLocked[ quad3 ]*Math.PI/2 + o.deltasLocked[ d3 ];
                      o.onEach( euler );
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

}

eachAngle.defaults =
{
  representations : [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ],
  angles : [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ],
  anglesLocked : [ 0, Math.PI / 3 ],
  quadrants : [ 0, 1, 2, 3 ],
  quadrantsLocked : [ 0 ],
  deltas : null,
  deltasLocked : [ 0 ],
  onEach : null,
  dst : null,
}

// --
// declare
// --

var Self =
{

  name : 'Tools.Math.Quaternion',
  silencing : 1,
  enabled : 1,
  // routine: 'eulerToQuatToMatrixToQuatFast',
  // accuracy : 1e-5,

  context :
  {
    _fromVectors : _fromVectors,
    _fromMatrixRotation : _fromMatrixRotation,
    eachAngle : eachAngle,
  },

  tests :
  {

    make : make,
    makeZero : makeZero,
    makeUnit : makeUnit,

    zero : zero,
    unit : unit,

    fromEuler : fromEuler,

    fromAxisAndAngle : fromAxisAndAngle,

    /* takes 79 seconds */
    eulerToQuatToAxisAndAngleToQuatSlow : eulerToQuatToAxisAndAngleToQuatSlow,

    fromVectors : fromVectors,
    fromNormalizedVectors : fromNormalizedVectors,

    // fromMatrixRotation : fromMatrixRotation,
    // fromMatrixRotation2 : fromMatrixRotation2,

    toMatrix : toMatrix,

    /* takes 6 seconds */
    eulerToQuatToMatrixToQuatFast: eulerToQuatToMatrixToQuatFast,
    /* takes 88 seconds */
    eulerToQuatToMatrixToQuatSlow: eulerToQuatToMatrixToQuatSlow,

    is : is,
    isZero : isZero,
    isUnit : isUnit,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
