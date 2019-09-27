( function _Euler_test_s_( ) {

'use strict';


/*

== Test cases calculations

= Common for all axis

Euler representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ]
Accuracy = epsilon, by default it is 1e-7

= Ordinary axis

Angle = set[ 0, PI / 6, PI / 4, PI / 3 ]
Delta = set[ -0.1, -sqrt( Accuracy ), -sqr( Accuracy ), 0, +sqr( Accuracy ), +sqrt( Accuracy ), +0.1 ]
Quadrant = set[ 0, 1, 2, 3 ]

= Locked axis

Angle = set[ 0, PI / 6, PI / 4, PI / 3 ]
Delta = set[ 0 ]
Quadrant = set[ 0 ]

= Total number of test cases

                      Angle + n*PI / 2 + Delta
        0.5 *       (  4   *   4      *   7   )     ^ 2         *    ( 4 )
excluding half cases                            for two angles    for locked axis

25 088 premutations * 12 representations = 301 056 test cases

*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );
  _.include( 'wLogger' );

  require( '../l8/Concepts.s' );

}

//

var _ = _global_.wTools.withArray.Float32;
var Space = _.Space;
var Parent = wTester;

var avector = _.avector;
var vector = _.vector;
var pi = Math.PI;
var sin = Math.sin;
var cos = Math.cos;
var atan2 = Math.atan2;
var asin = Math.asin;
var sqr = _.sqr;
var sqrt = _.sqrt;
var clamp = _.clamp;

_.assert( _.routineIs( sqrt ) );

// --
// test
// --

function is( test )
{

  test.case = 'array'; /* */

  test.is( !_.euler.is([]) );
  test.is( !_.euler.is([ 0 ]) );
  test.is( !_.euler.is([ 0,0 ]) );
  test.is( !_.euler.is([ 0,0,0 ]) );
  test.is( !_.euler.is([ 0,0,0,0 ]) );
  test.is( !_.euler.is([ 0,0,0,0,0 ]) );
  test.is( _.euler.is([ 0,0,0,0,0,0 ]) );
  test.is( _.euler.is([ 1,2,3,0,1,2 ]) );
  test.is( !_.euler.is([ 0,0,0,0,0,0,0 ]) );

  test.case = 'vector'; /* */

  test.is( !_.euler.is( _.vector.fromArray([]) ) );
  test.is( !_.euler.is( _.vector.fromArray([ 0 ]) ) );
  test.is( !_.euler.is( _.vector.fromArray([ 0,0 ]) ) );
  test.is( !_.euler.is( _.vector.fromArray([ 0,0,0 ]) ) );
  test.is( !_.euler.is( _.vector.fromArray([ 0,0,0,0 ]) ) );
  test.is( !_.euler.is( _.vector.fromArray([ 0,0,0,0,0 ]) ) );
  test.is( _.euler.is( _.vector.fromArray([ 0,0,0,0,0,0 ]) ) );
  test.is( _.euler.is( _.vector.fromArray([ 1,2,3,0,1,2 ]) ) );
  test.is( !_.euler.is( _.vector.fromArray([ 0,0,0,0,0,0,0 ]) ) );

  test.case = 'not euler'; /* */

  test.is( !_.euler.is( 'abcdef' ) );
  test.is( !_.euler.is( {} ) );
  test.is( !_.euler.is( function( a,b,c,d,e,f ){} ) );

}

//

function isZero( test )
{

  test.case = 'zero'; /* */

  debugger;
  test.is( _.euler.isZero([ 0,0,0,0,1,2 ]) );

  test.case = 'not zero'; /* */

  test.is( !_.euler.isZero([ 1,0,0,0,1,2 ]) );
  test.is( !_.euler.isZero([ 0,1,0,0,1,2 ]) );
  test.is( !_.euler.isZero([ 0,0,1,0,1,2 ]) );

  test.is( !_.euler.isZero([ 1,1,1,0,0,0 ]) );

}

//

function make( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.euler.make( src );
  var expected = [ 0,0,0,0,1,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.euler.make( src );
  var expected = [ 0,0,0,0,1,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src array'; /* */

  var src = [ 0,1,2,5,5,5 ];
  var got = _.euler.make( src );
  var expected = [ 0,1,2,5,5,5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src vector'; /* */

  var src = _.vector.fromArray([ 0,1,2,5,5,5 ]);
  var got = _.euler.make( src );
  var expected = [ 0,1,2,5,5,5 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.euler.make( 0 ) );
  test.shouldThrowErrorSync( () => _.euler.make( 4 ) );
  test.shouldThrowErrorSync( () => _.euler.make( '4' ) );
  test.shouldThrowErrorSync( () => _.euler.make( [ 0,0,0,0,1,2 ],2 ) );

}

//

function makeZero( test )
{

  test.case = 'trivial'; /* */

  var got = _.euler.makeZero();
  var expected = [ 0,0,0,0,1,2 ];
  test.identical( got,expected );

  var got = _.euler.makeZero( undefined );
  var expected = [ 0,0,0,0,1,2 ];
  test.identical( got,expected );

  if( !Config.debug )
  return;

  test.case = 'bad arguments'; /* */

  // test.shouldThrowErrorSync( () => _.euler.makeZero( undefined ) );
  test.shouldThrowErrorSync( () => _.euler.makeZero( null ) );
  test.shouldThrowErrorSync( () => _.euler.makeZero( 4 ) );
  test.shouldThrowErrorSync( () => _.euler.makeZero([ 0,0,0,0,1,2 ]) );
  test.shouldThrowErrorSync( () => _.euler.makeZero( '4' ) );
  test.shouldThrowErrorSync( () => _.euler.makeZero( [ 0,0,0,0,1,2 ],2 ) );

}

//

function zero( test )
{

  test.case = 'src undefined'; /* */

  var src = undefined;
  var got = _.euler.zero( src );
  var expected = [ 0,0,0,0,1,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'src null'; /* */

  var src = null;
  var got = _.euler.zero( src );
  var expected = [ 0,0,0,0,1,2 ];
  test.identical( got,expected );
  test.is( got !== src );

  test.case = 'dst array'; /* */

  var dst = [ 0,1,2,5,5,5 ];
  var got = _.euler.zero( dst );
  var expected = [ 0,0,0,5,5,5 ];
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'dst vector'; /* */

  var dst = _.vector.fromArray([ 0,1,2,5,5,5 ]);
  var got = _.euler.zero( dst );
  var expected = _.vector.fromArray([ 0,0,0,5,5,5 ]);
  test.identical( got,expected );
  test.is( got === dst );

  test.case = 'bad arguments'; /* */

  test.shouldThrowErrorSync( () => _.euler.zero( 4 ) );
  test.shouldThrowErrorSync( () => _.euler.zero([ 0,0,0 ]) );
  test.shouldThrowErrorSync( () => _.euler.zero( '4' ) );
  test.shouldThrowErrorSync( () => _.euler.zero( [ 0,0,0,5,5,5 ],2 ) );

}

//

function fromAxisAndAngle( test )
{

  function sampleTest()
  {

    // var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
    // var euler1 = [ 1.7518, 0.0004, 1.7926, 2, 1, 0 ];

    // var dst = [ 0,0,0,0,1,2 ]
    // var got = _.euler.fromAxisAndAngle( dst,axisAndAngle );
    // test.identical( got,expected );
    // test.is( got === dst );

    var dst = expected.slice();
    dst[ 0 ] = 0;
    dst[ 1 ] = 0;
    dst[ 2 ] = 0;

    var euler1 = _.euler.fromAxisAndAngle( dst,axisAndAngle1 );
    var quat1 = _.quat.fromEuler( null,euler1 );
    debugger;
    var quat2 = _.quat.fromAxisAndAngle( null,axisAndAngle1 );
    debugger;

    var appliedQuat1 = _.quat.applyTo( quat1,[ 0.25,0.5,1 ] );
    var appliedQuat2 = _.quat.applyTo( quat2,[ 0.25,0.5,1 ] );

    test.is( euler1 === dst );
    test.equivalent( euler1,expected );
    test.equivalent( appliedQuat1,appliedQuat2 );

    logger.log( 'quat1',quat1 );
    logger.log( 'quat2',quat2 );
    logger.log( 'euler1',euler1 );
    logger.log( 'axisAndAngle1',axisAndAngle1 );
    logger.log( 'expected',expected );

  }

  // test.case = 'trivial xyz';
  //
  // var axisAndAngle = [ 1 / sqrt( 3 ),1 / sqrt( 3 ),1 / sqrt( 3 ),0.5 ];
  // var expected = [ 0.25152005616932893, 0.32319976617576235, 0.25152005616932893, 0, 1, 2 ];
  // var dst = [ 0,0,0,0,1,2 ]
  // var got = _.euler.fromAxisAndAngle( dst,axisAndAngle );
  // test.identical( got,expected );
  // test.is( got === dst );

  test.case = 'trivial xyz';

  var axisAndAngle1 = [ 0.3, 0.7, 0.6480740698407861, 0.5 ];
  var expected = [ 0.25152005616932893, 0.32319976617576235, 0.25152005616932893, 0, 1, 2 ];
  sampleTest();

}

//

function fromQuat( test )
{

  function sampleTest()
  {

    // var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
    // var euler1 = [ 1.7518, 0.0004, 1.7926, 2, 1, 0 ];

    var dst = expected.slice();
    dst[ 0 ] = 0;
    dst[ 1 ] = 0;
    dst[ 2 ] = 0;

    var euler1 = _.euler.fromQuat( dst,quat1 );
    var quat2 = _.quat.fromEuler( null,euler1 );

    var appliedQuat1 = _.quat.applyTo( quat1,[ 0.25,0.5,1 ] );
    var appliedQuat2 = _.quat.applyTo( quat2,[ 0.25,0.5,1 ] );

    test.equivalent( euler1,expected );
    test.equivalent( appliedQuat1,appliedQuat2 );
    test.is( euler1 === dst );

    // logger.log( 'quat1',quat1 );
    // logger.log( 'quat2',quat2 );
    // logger.log( 'appliedQuat1',appliedQuat1 );
    // logger.log( 'appliedQuat2',appliedQuat2 );
    // logger.log( 'expected',expected );
    // logger.log( 'euler1',euler1 );

    // function variateRoutine( v )
    // {
    //
    //   if( !_.arrayHasAll( [ v.ox0, v.oy0, v.oz0, v.ow0, v.ox1, v.oy1, v.oz1, v.ow1 ], [ 0,1,2,3, 4,5,6,7 ] ) )
    //   return;
    //
    //   var q = _.quat.fromEuler( null, euler1.slice(), v );
    //   var r = _.quat.applyTo( q,[ 0.25,0.5,1 ] );
    //
    //   return r;
    // }
    //
    // function vtest( got,o )
    // {
    //   if( got === undefined )
    //   return false;
    //   return _.entityEquivalent( got,o.expected,{ accuracy : o.accuracy } );
    // }
    //
    // console.log( test.case );
    // _.diagnosticVariate
    // ({
    //   routine : variateRoutine,
    //   test : vtest,
    //   expected : appliedQuat1,
    //   variates : _.quat.fromEuler.variates,
    //   accuracy : 1e-4,
    // });

  }

  test.case = 'trivial xyz'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ -0.8768166446364086, 1.2855172555584793, 2.4682396612065283, 0, 1, 2 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ 0.07661016491652753, 0.73448367317603, 0.9774169729318261, 0, 1, 2 ];
  sampleTest();

  test.case = 'trivial xzy'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.611438122848755, 0.1764134071967898, 1.79616768779864, 0, 2, 1 ];

  sampleTest();

  test.case = 'trivial yxz'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.3853696932905102, -0.21805744508021838, 1.611777990662973, 1, 0, 2 ];

  sampleTest();

  test.case = 'trivial yzx'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ -3.139697893726683, 1.3489814514664218, -1.7536311318816715, 1, 2, 0 ];

  sampleTest();

  test.case = 'trivial zxy'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.7948888079254575, 1.3898093848622433, -0.0023158162419024777, 2, 0, 1 ];

  sampleTest();

  test.case = 'trivial zyx'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.7926108168855637, -0.0004168476808001178, 1.3898098596500965, 2, 1, 0 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ 1.1190534595035637, 0.31540765161226797, 0.6786858260419525, 2, 1, 0 ];
  sampleTest();

  //

  test.case = 'trivial xyx'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.5712236437976341, 1.792610797291691, -0.1808924573987528, 0, 1, 0 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ 1.2228685618221453, 1.1428535238213908, -0.7427188846725128, 0, 1, 0 ];
  sampleTest();

  test.case = 'trivial xzx'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 0.0004273170027373423, 1.792610797291691, 1.3899038693961439, 0, 2, 0 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ -0.3479277649727513, 1.1428535238213908, 0.8280774421223838, 0, 2, 0 ];
  sampleTest();

  test.case = 'trivial yxy'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ -0.17655619363859168, 1.6108070011488855, 1.7890312528560666, 1, 0, 1 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ -0.8006624116228127, 1.0297886775455747, 1.5044815828085223, 1, 0, 1 ];
  sampleTest();

  test.case = 'trivial yzy'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.394240133156305, 1.6108070011488855, 0.2182349260611697, 1, 2, 1 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ 0.770133915172084, 1.0297886775455747, -0.06631474398637426, 1, 2, 1 ];
  sampleTest();

  test.case = 'trivial zxz'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 1.7925345384125673, 1.389809875548349, 0.00042376926987936647, 2, 0, 2 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ 1.486244067362877, 0.7377259684532488, -0.47934337913178104, 2, 0, 2 ];

  sampleTest();

  test.case = 'trivial zyz'; /* */

  var quat1 = [ 0.4,0.5,0.6,0.4795831523312719 ];
  var expected = [ 0.22173821161767063, 1.389809875548349, 1.5712200960647762, 2, 1, 2 ];
  sampleTest();

  var quat1 = [ 0.2, 0.3, 0.45, 0.8170067319184096 ];
  var expected = [ -0.0845522594320196, 0.7377259684532488, 1.0914529476631156, 2, 1, 2 ];
  sampleTest();

  //

  test.case = 'trivial xzy';

  var quat1 = [ 1 / sqrt( 3 ),1 / sqrt( 3 ),1 / sqrt( 3 ),0 ];
  var expected = [ 2.0344439357957027, -0.7297276562269666, 2.0344439357957027, 0, 2, 1 ];
  sampleTest();

  /* */

  test.case = 'trivial yxz';

  var quat1 = [ 1 / sqrt( 3 ),1 / sqrt( 3 ),1 / sqrt( 3 ),0 ];
  var expected = [  2.0344439357957027, -0.7297276562269666,2.0344439357957027, 1, 0, 2 ];
  sampleTest();

  /* */

  test.case = 'trivial yzx';

  var quat1 = [ 1 / sqrt( 3 ),1 / sqrt( 3 ),1 / sqrt( 3 ),0 ];
  var expected = [ -2.0344439357957027, 0.7297276562269666, -2.0344439357957027, 1, 2, 0 ];
  sampleTest();

  /* */

  test.case = 'trivial zxy';

  var quat1 = [ 1 / sqrt( 3 ),1 / sqrt( 3 ),1 / sqrt( 3 ),0 ];
  var expected = [ -2.0344439357957027, 0.7297276562269666, -2.0344439357957027, 2, 0, 1 ];
  sampleTest();

  /* */

  test.case = 'trivial zyx';

  var quat1 = [ 1 / sqrt( 3 ),1 / sqrt( 3 ),1 / sqrt( 3 ),0 ];
  var expected = [ 2.0344439357957027, -0.7297276562269666, 2.0344439357957027, 2, 1, 0 ];
  sampleTest();

  //

  test.case = 'trivial xyx';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 2.5989535513401405, 2.636232143305636, 0.5426391022496527, 0, 1, 0 ];
  sampleTest();

  /* */

  test.case = 'trivial xzx';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 1.028157224545244, 2.636232143305636, 2.113435429044549, 0, 2, 0 ];
  sampleTest();

  /* */

  test.case = 'trivial yxy';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 0.2928427717285755, 2.0943951023931957, 2.8487498818612176, 1, 0, 1 ];
  sampleTest();

  /* */

  test.case = 'trivial yzy';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 1.8636390985234723, 2.0943951023931957, 1.277953555066321, 1, 2, 1 ];
  sampleTest();

  /* */

  test.case = 'trivial zxz';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 2.677945044588987, 1.1863995522992576, 0.4636476090008061, 2, 0, 2 ];
  sampleTest();

  /* */

  test.case = 'trivial zyz';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 1.1071487177940904, 1.1863995522992576, 2.0344439357957027, 2, 1, 2 ];
  sampleTest();

  //

  test.case = 'trivial xyz';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ -1.1460587478032058, 0.4274791332848927, -2.8632929945846817, 0, 1, 2 ];
  sampleTest();

  test.case = 'trivial xzy';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 2.113435429044549, -0.25268025514207865, 2.6991209725017002, 0, 2, 1 ];
  sampleTest();

  test.case = 'trivial yxz';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 0.8354818739782282, -0.9775965506452678, 2.677945044588987, 1, 0, 2 ];
  sampleTest();

  test.case = 'trivial yzx';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ -2.6991209725017002, 0.25268025514207865, -2.113435429044549, 1, 2, 0 ];
  sampleTest();

  test.case = 'trivial zxy';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ -2.677945044588987, 0.9775965506452678, -0.8354818739782282, 2, 0, 1 ];
  sampleTest();

  test.case = 'trivial zyx';

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var expected = [ 2.8632929945846817, -0.4274791332848927, 1.1460587478032058, 2, 1, 0 ];
  sampleTest();

}

//

function fromMatrix( test )
{

  test.case = 'trivial xyz'; /* */

  var quat1 = [ 0.25,0.5,0.82915619758885,0 ];
  var m1 = _.quat.toMatrix( quat1,null );
  var euler1 = _.euler.fromMatrix( [ 0,0,0, 0,1,2 ],m1 ); /* x */
  var euler2 = _.euler.fromQuat( [ 0,0,0, 0,1,2 ],quat1 ); /* x */
  var m2 = _.euler.toMatrix( euler1,null ); /* x */
  var euler3 = _.euler.fromMatrix( [ 0,0,0, 0,1,2 ],m2 ); /* x */

// m1
// 0.593, -0.634, 0.496,
// 0.647, 0.742, 0.175,
// -0.479, 0.217, 0.850,

  var quat2 = _.quat.fromEuler( null,euler1 );
  var quat3 = _.quat.fromEuler( null,euler2 );

  var quat1applied = _.quat.applyTo( quat1,[ 1.0,0.5,0.25 ] ); /* + */
  var quat2applied = _.quat.applyTo( quat2,[ 1.0,0.5,0.25 ] );
  var quat3applied = _.quat.applyTo( quat3,[ 1.0,0.5,0.25 ] );
  var m1applied = m1.matrixApplyTo([ 1.0,0.5,0.25 ]); /* + */
  var m2applied = m2.matrixApplyTo([ 1.0,0.5,0.25 ]);

  test.equivalent( m1applied,quat1applied );
  test.equivalent( m2applied,quat1applied );

  logger.log( 'm1',m1 );
  logger.log( 'm2',m2 );

  logger.log( 'quat1applied',quat1applied );
  logger.log( 'quat2applied',quat2applied );
  logger.log( 'quat3applied',quat3applied );
  logger.log( 'm1applied',m1applied );
  logger.log( 'm2applied',m2applied );

  logger.log( 'euler1',euler1 );
  logger.log( 'euler2',euler2 );
  logger.log( 'euler3',euler3 );

  logger.log( 'quat1',quat1 );
  logger.log( 'quat2',quat2 );
  logger.log( 'quat3',quat3 );

}

//

function toMatrix( test )
{

  // test.case = 'special zyx'; /* */
  //
  // // var euler = [ -1.1460588,0.4274791,-2.863293,2,1,0 ];
  // // var euler = [ 0.50496801411559,-0.427479133284893,2.89661399046293,2,1,0 ];
  // // var euler = [ 0.25,0.5,0.82915619758885,2,1,0 ];
  //
  // var euler = [ 2.8633, -0.4275, 1.1461, 2,1,0 ]
  // var m1 = _.euler.toMatrix( euler,null );
  //
  // var expected = [ 0,0,0 ];
  // var applied = m1.matrixApplyTo([ 0.25,0.5,1.0 ]);
  //
  // var quat1 = _.quat.fromEuler( null,euler );
  // var quat2 = _.quat.fromMatrixRotation( null,m1 );
  // var m2 = _.quat.toMatrix( quat1 );
  //
  // var applied1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
  // var applied2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );
  //
  // test.equivalent( applied,expected );
  // test.equivalent( applied1,expected );
  // test.equivalent( applied2,expected );
  // test.equivalent( applied1,applied2 );
  //
  // logger.log( 'm',_.quat.toMatrix( [ 0.25,0.5,0.82915619758885,0 ],null ) );
  // logger.log( 'm1',m1 );
  // logger.log( 'm1',m2 );
  // logger.log( 'quat1',quat1 );
  // logger.log( 'quat2',quat2 );
  // logger.log( 'applied',applied );
  // logger.log( 'applied1',applied1 );
  // logger.log( 'applied2',applied2 );
  // return;

  function sampleTest()
  {

    var m1 = _.euler.toMatrix( euler,null );
    var applied = m1.matrixApplyTo([ 0.25,0.5,1.0 ]);

    // var quat1 = _.quat.fromEuler( null,euler );
    var quat2 = _.quat.fromMatrixRotation( null,m1 );
    // var appliedQuat1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
    var appliedQuat2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );

    var mq = _.quat.toMatrix( q,null );
    // var m3 = _.quat.toMatrix( quat1,null );

    test.equivalent( applied,expected );
    // test.equivalent( appliedQuat1,expected );
    test.equivalent( appliedQuat2,expected );
    // test.equivalent( appliedQuat1,appliedQuat2 );

    logger.log( 'euler',euler );
    logger.log( 'm1',m1 );
    logger.log( 'mq',mq );
    // logger.log( 'm3',m3 );
    // logger.log( 'quat1',quat1 );
    logger.log( 'quat2',quat2 );
    logger.log( 'expected',expected );
    logger.log( 'applied',applied );
    // logger.log( 'appliedQuat1',appliedQuat1 );
    logger.log( 'appliedQuat2',appliedQuat2 );

// [ -0.8749934, 0.2499915, 0.4145971;
// 0.2500373, -0.4999688, 0.8291638;
// 0.4145695, 0.8291776, 0.3749622 ]

  }

  // test.case = 'trivial zyx, not premutating'; /* */
  //
  // var q = [ 0.4,0.5,0.6,0.4795831523312719 ];
  // var euler = [ 1.7518, 0.0004, 1.7926, 2,1,0 ];
  // var expected = [ 0,0,0 ];
  //
  // sampleTest();

  test.case = 'trivial zyx, not premutating'; /* */

  var q = [ 0.25,0.5,0.82915619758885,0 ];
  var euler = [ 2.8633, -0.4275, 1.1461, 2,1,0 ];
  var expected = [ 0.32083976188534435, 0.6416910401663305, 0.893193402509267 ];

  //  -0.8750    0.2500    0.4146
  //   0.2500   -0.5000    0.8292
  //   0.4146    0.8292    0.3750

  sampleTest();

  return;
  // test.case = 'trivial xyz, not premutating'; /* */
  //
  // // var q = [ 0.25,0.5,0.82915619758885,0 ];
  // var euler = [ -1.1460588, 0.4274791, -2.863293, 0,1,2 ];
  // var expected = [ 0.32082808017730713,0.6416562497615814,0.8932226002216339 ];
  //
  // sampleTest();

  // test.case = 'trivial xzy, not premutating'; /* */
  //
  // var q = [ 0.25,0.5,0.82915619758885,0 ];
  // var euler = [ 2.1134354, 2.699121, -0.2526803, 0,2,1 ];
  // var expected = [ 0.32082808017730713,0.6416562497615814,0.8932226002216339 ];
  //
  // sampleTest();

  test.case = 'trivial yxz, not premutating'; /* */

  var euler = [ 0.25,0.5,0.82915619758885,1,0,2 ];
  var m1 = _.euler.toMatrix( euler,null );

  var expected = [ 0.2530621141195297, 0.7159013152122498, 0.8578723147511482 ];
  var applied = m1.matrixApplyTo([ 0.25,0.5,1.0 ] );

  var quat1 = _.quat.fromEuler( null,euler );
  var quat2 = _.quat.fromMatrixRotation( null,m1 );
  var applied1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
  var applied2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );

  test.equivalent( applied,expected );
  test.equivalent( applied1,expected );
  test.equivalent( applied2,expected );
  test.equivalent( applied1,applied2 );

  // logger.log( 'm1',m1 );
  // logger.log( 'quat1',quat1 );
  // logger.log( 'quat2',quat2 );
  // logger.log( 'applied',applied );
  // logger.log( 'applied1',applied1 );
  // logger.log( 'applied2',applied2 );

  test.equivalent( applied,expected );

  test.case = 'trivial yzx, not premutating'; /* */

  var euler = [ 0.25,0.5,0.82915619758885,1,2,0 ];
  var m1 = _.euler.toMatrix( euler,null );

  var expected = [  0.10337161687032922620704260170366, 0.63904984198111440718540503189963, 0.945214054217099848725599587179 ];
  var applied = m1.matrixApplyTo([ 0.25,0.5,1.0 ] );

  var quat1 = _.quat.fromEuler( null,euler );
  var quat2 = _.quat.fromMatrixRotation( null,m1 );
  var applied1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
  var applied2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );

  test.equivalent( applied,expected );
  test.equivalent( applied1,expected );
  test.equivalent( applied2,expected );
  test.equivalent( applied1,applied2 );

  // logger.log( 'm1',m1 );
  // logger.log( 'quat1',quat1 );
  // logger.log( 'quat2',quat2 );
  // logger.log( 'applied',applied );
  // logger.log( 'applied1',applied1 );
  // logger.log( 'applied2',applied2 );

  test.equivalent( applied,expected );

  test.case = 'trivial zxy, not premutating'; /* */

  var euler = [ 0.25,0.5,0.82915619758885,2,0,1 ];
  var m1 = _.euler.toMatrix( euler,null );

  var expected = [ 0.35110081948689522723014362674347, 0.25845504803910486458114577211113, 1.0594475931818121834782685936401 ];
  var applied = m1.matrixApplyTo([ 0.25,0.5,1.0 ] );

  var quat1 = _.quat.fromEuler( null,euler );
  var quat2 = _.quat.fromMatrixRotation( null,m1 );
  var applied1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
  var applied2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );

  test.equivalent( applied,expected );
  test.equivalent( applied1,expected );
  test.equivalent( applied2,expected );
  test.equivalent( applied1,applied2 );

  // logger.log( 'm1',m1 );
  // logger.log( 'quat1',quat1 );
  // logger.log( 'quat2',quat2 );
  // logger.log( 'applied',applied );
  // logger.log( 'applied1',applied1 );
  // logger.log( 'applied2',applied2 );

  test.case = 'trivial zyx, not premutating'; /* */

  var euler = [ 0.25,0.5,0.82915619758885,2,1,0 ];
  var m1 = _.euler.toMatrix( euler,null );

  var expected = [ 0.30407903473460450205181031365661, 0.26504222953334272978258325424794, 1.0722819392300077603778543592048 ];
  var applied = m1.matrixApplyTo([ 0.25,0.5,1.0 ] );

  var quat1 = _.quat.fromEuler( null,euler );
  var quat2 = _.quat.fromMatrixRotation( null,m1 );
  var applied1 = _.quat.applyTo( quat1,[ 0.25,0.5,1.0 ] );
  var applied2 = _.quat.applyTo( quat2,[ 0.25,0.5,1.0 ] );

  test.equivalent( applied,expected );
  test.equivalent( applied1,expected );
  test.equivalent( applied2,expected );
  test.equivalent( applied1,applied2 );

  logger.log( 'm1',m1 );
  logger.log( 'quat1',quat1 );
  logger.log( 'quat2',quat2 );
  logger.log( 'applied',applied );
  logger.log( 'applied1',applied1 );
  logger.log( 'applied2',applied2 );

  var m2 = _.Space.make([ 3,3 ]).copy
  ([
      0.8503,    0.1754,    0.4962,
      0.2171,    0.7420,   -0.6343,
     -0.4794,    0.6471,    0.5928,
  ]);

  logger.log( 'm2',m2 );
  var applied = m2.matrixApplyTo([ 0.25,0.5,1.0 ] );
  logger.log( 'applied',applied );

// 0.8503    0.1754    0.4962
// 0.2171    0.7420   -0.6343
// -0.4794    0.6471    0.5928

  debugger;
}

//

function fromQuat2( test )
{

  test.case = 'Quaternion remains unchanged'; /* */

  var srcQuat = [ 0.29156656802867026, 0.17295479161025828, 0.29156656802867026, 0.89446325406638 ];
  var oldQuat = srcQuat.slice();
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );
  test.equivalent( srcQuat, oldQuat );
  test.is( gotEuler === dstEuler );

  test.case = 'Euler XYZ'; /* */

  var srcQuat =  [ 0.46990785942494523, 0.3649976887426158, 0.32407387953254757, 0.7354858336283155 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 1, 1, 0.25, 0, 1, 2 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY'; /* */

  var srcQuat = [ 0.43382795540572155, 0.15750930151157658, 0.22369733411737125, 0.8584542083038603 ];
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var expected = [ 1, 0.25, 0.5, 0, 2, 1 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ'; /* */

  var srcQuat = [ 0.3252921697349392, 0.39636481102592414, 0.09544332266900905, 0.8532118805123485 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var expected =  [ 1, 0.5, 0.5, 1, 0, 2 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX'; /* */

  var srcQuat = [ 0.7649936350495811, 0.3490809852398744, -0.3411592852710977, 0.4201637135104611 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var expected = [ 1, 0.25, 2, 1, 2, 0 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY'; /* */

  var srcQuat = [ 0.3649976887426158, 0.46990785942494523, 0.32407387953254757, 0.7354858336283155 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ]
  var expected = [ 0.25, 1, 1, 2, 0, 1 ] ;

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX'; /* */

  var srcQuat =  [ 0.09544332266900905, 0.3252921697349392, 0.39636481102592414, 0.8532118805123485 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var expected =  [ 1, 0.5, 0.5, 2, 1, 0 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYZ - Quat -> Euler -> Quat'; /* */

  var srcQuat = [ 0.46990785942494523, 0.3649976887426158, 0.32407387953254757, 0.7354858336283155 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 0.46990785942494523, 0.3649976887426158, 0.32407387953254757, 0.7354858336283155 ];

  var euler = _.euler.fromQuat2( dstEuler, srcQuat );
  var gotQuat = _.euler.toQuat2( euler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler XZY - Quat -> Euler -> Quat'; /* */

  var srcQuat = [ 0.43382795540572155, 0.15750930151157658, 0.22369733411737125, 0.8584542083038603 ];
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var expected = [ 0.43382795540572155, 0.15750930151157658, 0.22369733411737125, 0.8584542083038603 ];

  var euler = _.euler.fromQuat2( dstEuler, srcQuat );
  var gotQuat = _.euler.toQuat2( euler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler YXZ - Quat -> Euler -> Quat'; /* */

  var srcQuat = [ 0.3252921697349392, 0.39636481102592414, 0.09544332266900905, 0.8532118805123485 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var expected =  [ 0.3252921697349392, 0.39636481102592414, 0.09544332266900905, 0.8532118805123485 ];

  var euler = _.euler.fromQuat2( dstEuler, srcQuat );
  var gotQuat = _.euler.toQuat2( euler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler YZX - Quat -> Euler -> Quat'; /* */

  var srcQuat = [ 0.7649936350495811, 0.3490809852398744, -0.3411592852710977, 0.4201637135104611 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var expected = [ 0.7649936350495811, 0.3490809852398744, -0.3411592852710977, 0.4201637135104611 ];

  var euler = _.euler.fromQuat2( dstEuler, srcQuat );
  var gotQuat = _.euler.toQuat2( euler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler ZXY - Quat -> Euler -> Quat'; /* */

  var srcQuat = [ 0.3649976887426158, 0.46990785942494523, 0.32407387953254757, 0.7354858336283155 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ]
  var expected = [ 0.3649976887426158, 0.46990785942494523, 0.32407387953254757, 0.7354858336283155 ];

  var euler = _.euler.fromQuat2( dstEuler, srcQuat );
  var gotQuat = _.euler.toQuat2( euler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler ZYX - Quat -> Euler -> Quat'; /* */

  var srcQuat =  [ 0.09544332266900905, 0.3252921697349392, 0.39636481102592414, 0.8532118805123485 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var expected =  [ 0.09544332266900905, 0.3252921697349392, 0.39636481102592414, 0.8532118805123485 ];

  var euler = _.euler.fromQuat2( dstEuler, srcQuat );
  var gotQuat = _.euler.toQuat2( euler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler XYX - Euler -> Quat -> Euler'; /* */

  var euler = [ 1, 1, 0.25, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var expected =  [ 1, 1, 0.25, 0, 1, 0 ]; ;

  var srcQuat = _.euler.toQuat2( euler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX - Euler -> Quat -> Euler'; /* */

  var euler =  [ 1, 0.25, 0.5, 0, 2, 0 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var expected = [ 1, 0.25, 0.5, 0, 2, 0 ];

  var srcQuat = _.euler.toQuat2( euler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY - Euler -> Quat -> Euler'; /* */

  var euler = [ 1, 0.5, 0.5, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var expected =  [ 1, 0.5, 0.5, 1, 0, 1 ];

  var srcQuat = _.euler.toQuat2( euler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY - Euler -> Quat -> Euler'; /* */

  var euler = [ 1, 0.25, 2, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var expected = [ 1, 0.25, 2, 1, 2, 1 ];

  var gotQuat = _.euler.toQuat2( euler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ - Euler -> Quat -> Euler'; /* */

  var euler = [ 0.25, 1, 1, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ]
  var expected = [ 0.25, 1, 1, 2, 0, 2 ] ;

  var gotQuat = _.euler.toQuat2( euler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Euler -> Quat -> Euler'; /* */

  var euler =  [ 1, 0.5, 0.5, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var expected =  [ 1, 0.5, 0.5, 2, 1, 2 ];

  var gotQuat = _.euler.toQuat2( euler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'dstEuler undefined'; /**/

  var dstEuler = undefined;
  var srcQuat = [ 0.46990785942494523, 0.3649976887426158, 0.32407387953254757, 0.7354858336283155 ];
  var expected =  [ 1, 1, 0.25, 0, 1, 2 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );
  test.is( gotEuler !== dstEuler );

  test.case = 'dstEuler null'; /**/

  var dstEuler = null;
  var srcQuat = [ 0.46990785942494523, 0.3649976887426158, 0.32407387953254757, 0.7354858336283155 ];
  var expected =  [ 1, 1, 0.25, 0, 1, 2 ];

  var gotEuler = _.euler.fromQuat2( dstEuler, srcQuat );
  test.equivalent( gotEuler, expected );
  test.is( gotEuler !== dstEuler );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.euler.fromQuat2( ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [] ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [], [] ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [ 0, 0, 0, 0, 1, 2 ], [ 0, 0, 0, 1, 1 ] ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [ 0, 0, 0, 0, 2  ], [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [ 0, 0, 0, 1, 2, 0, 0 ], [ 0, 0, 0, 2 ] ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [ 0, 0, 0, 0, 1, 2 ], NaN ));
  test.shouldThrowErrorSync( () => _.euler.fromQuat2( [ 0, 0, 0, 0, 1, 2 ], null ));

}

//

function toQuat2( test )
{

  test.case = 'Euler remains unchanged'; /* */

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var oldEuler =   srcEuler.slice();
  var dstQuat = [ 0, 0, 0, 1 ];
  var expected = [ 0.29156656802867026, 0.17295479161025828, 0.29156656802867026, 0.89446325406638 ];

  var gotQuat = _.euler.toQuat2( srcEuler, dstQuat );
  test.equivalent( gotQuat, expected );
  test.equivalent( srcEuler, oldEuler );
  test.is( gotQuat === dstQuat );

  test.case = 'Euler XYZ'; /* */

  var srcEuler = [ 1, 1, 0.25, 0, 1, 2 ];
  var dstQuat = null;
  var expected = [ 0.46990785942494523, 0.3649976887426158, 0.32407387953254757, 0.7354858336283155 ];

  var gotQuat = _.euler.toQuat2( srcEuler, dstQuat );
  test.equivalent( gotQuat, expected );
  test.is( gotQuat !== dstQuat );

  test.case = 'Euler XZY'; /* */

  var srcEuler = [ 1, 0.25, 0.5, 0, 2, 1 ];
  var dstQuat = undefined;
  var expected = [ 0.43382795540572155, 0.15750930151157658, 0.22369733411737125, 0.8584542083038603 ];

  var gotQuat = _.euler.toQuat2( srcEuler, dstQuat );
  test.equivalent( gotQuat, expected );
  test.is( gotQuat !== dstQuat );

  test.case = 'Euler YXZ'; /* */

  var srcEuler = [ 1, 2, 0.25, 1, 0, 2 ];
  var expected = [ 0.7649936350495811, 0.1649463125283644, - 0.3411592852710977, 0.5207569436793306 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler YZX'; /* */

  var srcEuler = [ 1, 0.25, 2, 1, 2, 0 ];
  var expected = [ 0.7649936350495811, 0.3490809852398744, - 0.3411592852710977, 0.4201637135104611 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler ZXY'; /* */

  var srcEuler = [ 0.25, 1, 1, 2, 0, 1 ];
  var expected = [ 0.3649976887426158, 0.46990785942494523, 0.32407387953254757, 0.7354858336283155 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler ZYX'; /* */

  var srcEuler = [ 0.25, 1, 0.5, 2, 1, 0 ];
  var expected = [ 0.15750930151157658, 0.48796606341816057, -0.011675321619178877, 0.8584542083038603 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'Euler XYZ -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 1, 0.25, 0, 1, 2 ];
  var dst = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 1, 1, 0.25, 0, 1, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 0.25, 0.5, 0, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var expected =  [ 1, 0.25, 0.5, 0, 2, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ -> Quat -> Euler'; /* */

  var srcEuler = [ 2, 1, 0.25, 1, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var expected = [ 2, 1, 0.25, 1, 0, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 0.25, 2, 1, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var expected =  [ 1, 0.25, 2, 1, 2, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY -> Quat -> Euler'; /* */

  var srcEuler = [ 0.25, 1, 1, 2, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ];
  var expected =  [ 0.25, 1, 1, 2, 0, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX -> Quat -> Euler'; /* */

  var srcEuler = [ 0.25, 1, 0.5, 2, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var expected = [ 0.25, 1, 0.5, 2, 1, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYX -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 1, 0.25, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var expected = [ 1, 1, 0.25, 0, 1, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 0.25, 0.5, 0, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var expected =  [ 1, 0.25, 0.5, 0, 2, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 2, 0.25, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var expected = [ 1, 2, 0.25, 1, 0, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY -> Quat -> Euler'; /* */

  var srcEuler = [ 1, 0.25, 2, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var expected =  [ 1, 0.25, 2, 1, 2, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ -> Quat -> Euler'; /* */

  var srcEuler = [ 0.25, 1, 1, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ];
  var expected =  [ 0.25, 1, 1, 2, 0, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYZ -> Quat -> Euler'; /* */

  var srcEuler = [ 0.25, 1, 0.5, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var expected = [ 0.25, 1, 0.5, 2, 1, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'dstQuat null'; /* */

  var srcEuler = [ 1, 0, 0, 0, 1, 2 ];
  var expected =  [ 0.479425538604203, 0, 0, 0.8775825618903728 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  test.equivalent( gotQuat, expected );

  test.case = 'dstQuat undefined'; /* */

  var srcEuler = [ 1, 0, 0, 0, 1, 2 ];
  var expected =  [ 0.479425538604203, 0, 0, 0.8775825618903728 ];

  var gotQuat = _.euler.toQuat2( srcEuler, undefined );
  test.equivalent( gotQuat, expected );


  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.euler.toQuat2( ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( [], [] ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( [ 0, 0, 0, 1, 2 ] ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( [ 0, 0, 0, 1, 3 ], null ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( null, [ 0, 0, 0, 1 ] ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( [ 0, 0, 0, 1, 2, 0, 0 ], null ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( srcEuler, srcEuler ));
  test.shouldThrowErrorSync( () => _.euler.toQuat2( NaN, [ 0, 0, 0, 1 ]));

}

//

function eulerToQuatToEulerGimbalLock( test )
{

  test.case = 'Euler XYZ - Gimbal Lock angle y = pi/2'; /**/

  var srcEuler = [ - 0.1, Math.PI/2, 0, 0, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected =  [ - 0.1, Math.PI/2, 0, 0, 1, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYZ - Gimbal Lock angle y = -pi/2'; /**/

  var srcEuler = [ 0.1, - Math.PI/2, 0, 0, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 0.1, - Math.PI/2, 0, 0, 1, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY - Gimbal Lock angle z = pi/2'; /**/

  var srcEuler =  [ 0.1, Math.PI/2, 0, 0, 2, 1 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var expected = [ 0.1, Math.PI/2, 0, 0, 2, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY - Gimbal Lock angle z = - pi/2'; /**/

  var srcEuler =  [ 0.1, - Math.PI/2, 0, 0, 2, 1 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var expected = [ 0.1, - Math.PI/2, 0, 0, 2, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ - Gimbal Lock angle x = pi/2'; /**/

  var srcEuler = [ 0.1, Math.PI/2, 0, 1, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var expected =  [ 0.1, Math.PI/2, 0, 1, 0, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ - Gimbal Lock angle x = - pi/2'; /**/

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 1, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var expected =  [ - 0.1, - Math.PI/2, 0, 1, 0, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX - Gimbal Lock angle z = pi/2'; /**/

  var srcEuler = [ - 0.1, Math.PI/2, 0, 1, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var expected = [ - 0.1, Math.PI/2, 0, 1, 2, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX - Gimbal Lock angle z = - pi/2'; /**/

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 1, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var expected = [ - 0.1, - Math.PI/2, 0, 1, 2, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY - Gimbal Lock angle x = pi/2'; /**/

  var srcEuler = [ - 0.1, Math.PI/2, 0, 2, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ]
  var expected = [ - 0.1, Math.PI/2, 0, 2, 0, 1 ] ;

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY - Gimbal Lock angle x = - pi/2'; /**/

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 2, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ]
  var expected = [ - 0.1, - Math.PI/2, 0, 2, 0, 1 ] ;

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Gimbal Lock angle x = pi/2'; /**/

  var srcEuler =  [ - 0.1, Math.PI/2, 0, 2, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var expected =  [ - 0.1, Math.PI/2, 0, 2, 1, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Gimbal Lock angle x = - pi/2'; /**/

  var srcEuler =  [ - 0.1, - Math.PI/2, 0, 2, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var expected =  [ - 0.1, - Math.PI/2, 0, 2, 1, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYX - Gimbal Lock angle y = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var expected =  [ 0.1, 0, 0, 0, 1, 0 ]; ;

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYX - Gimbal Lock angle y = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var expected =  [ 0.1, Math.PI, 0, 0, 1, 0 ]; ;

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX - Gimbal Lock angle z = 0'; /**/

  var srcEuler =  [ 0.1, 0, 0, 0, 2, 0 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var expected = [ 0.1, 0, 0, 0, 2, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX - Gimbal Lock angle z = pi'; /**/

  var srcEuler =  [ 0.1, Math.PI, 0, 0, 2, 0 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var expected = [ 0.1, Math.PI, 0, 0, 2, 0 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY - Gimbal Lock angle z = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var expected =  [ 0.1, 0, 0, 1, 0, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY - Gimbal Lock angle z = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var expected =  [ 0.1, Math.PI, 0, 1, 0, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY - Gimbal Lock angle z = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var expected = [ 0.1, 0, 0, 1, 2, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY - Gimbal Lock angle z = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var expected = [ 0.1, Math.PI, 0, 1, 2, 1 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ - Gimbal Lock angle z = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ]
  var expected = [ 0.1, 0, 0, 2, 0, 2 ] ;

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ - Gimbal Lock angle z = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ]
  var expected = [ 0.1, Math.PI, 0, 2, 0, 2 ] ;

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYZ - Gimbal Lock angle z = 0'; /**/

  var srcEuler =  [ 0.1, 0, 0, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var expected =  [ 0.1, 0, 0, 2, 1, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYZ - Gimbal Lock angle z = pi'; /**/

  var srcEuler =  [ 0.1, Math.PI, 0, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var expected =  [ 0.1, Math.PI, 0, 2, 1, 2 ];

  var gotQuat = _.euler.toQuat2( srcEuler, null );
  var gotEuler = _.euler.fromQuat2( dstEuler, gotQuat );
  test.equivalent( gotEuler, expected );

}

//

function fromMatrix2( test )
{

  test.case = 'Matrix remains unchanged'; /* */

  var srcMatrix = _.Space.make([ 3, 3 ]).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );
  test.is( gotEuler === dstEuler );

  var oldMatrix = _.Space.make([ 3, 3 ]).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);
  test.equivalent( srcMatrix, oldMatrix );

  test.case = 'Euler XYZ'; /* */

  var srcMatrix = _.Space.make([ 3, 3 ]).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var expected = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY'; /* */

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.7701511383, -0.479425549507, 0.4207354784,
    0.5990789532, 0.7701511383, - 0.21902415156,
    - 0.21902415156, 0.4207354784, 0.8803465366
  ]);

  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var expected = [ 0.5, 0.5, 0.5, 0, 2, 1 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ'; /* */

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.6675710082, 0.095001988, 0.738460242,
    0.4207354784, 0.770151138, - 0.479425549,
    - 0.6142724156, 0.6307470202, 0.474159896
  ]);
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var expected =  [ 1, 0.5, 0.5, 1, 0, 2 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX'; /* */

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.5235056281089, 0.286113649, 0.802546501,
    0.2474039644002, 0.8503006696, - 0.464521348,
    - 0.8153116703033, 0.441732704, 0.374351501
  ]);
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var expected = [ 1, 0.25, 0.5, 1, 2, 0 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY'; /* */

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.7504922747, - 0.1336729228, 0.64721935987,
    0.607998669, 0.5235056281, - 0.5968915224,
    - 0.259034723, 0.8414709568, 0.47415989637
  ]);
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ]
  var expected = [ 0.25, 1, 0.5, 2, 0, 1 ] ;

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX'; /* */

  var srcMatrix =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0.4741598963737, - 0.6142724156, 0.6307470202,
    0.7384602427, 0.6675710082, 0.095001988,
    - 0.4794255495, 0.4207354784, 0.770151138
  ]);
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var expected =  [ 1, 0.5, 0.5, 2, 1, 0 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'dstEuler = null'; /* */

  var srcMatrix = _.Space.make([ 3, 3 ]).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);
  var dstEuler = null;
  var expected = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );
  test.is( gotEuler !== dstEuler );

  test.case = 'dstEuler = undefined'; /* */

  var srcMatrix = _.Space.make([ 3, 3 ]).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);
  var dstEuler = undefined;
  var expected =  [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );
  test.is( gotEuler !== dstEuler );

  test.case = 'Euler XYZ - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 1, 0.5, 0.5, 0, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 1, 0.5, 0.5, 0, 1, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 1, 0.5, 0.25, 0, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 1, 0.5, 0.25, 0, 2, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 1, 0.25, 0.25, 1, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 1, 0.25, 0.25, 1, 0, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 0.5, 0.25, - 0.25, 1, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.5, 0.25, - 0.25, 1, 2, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 0.5, 0.75, - 0.25, 2, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.5, 0.75, - 0.25, 2, 0, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 0.25, 0.75, - 0.25, 2, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.25, 0.75, - 0.25, 2, 1, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYX - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 1, 1, 0.25, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 1, 1, 0.25, 0, 1, 0 ]; ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX - Euler -> Matrix -> Euler'; /* */

  var srcEuler =  [ 1, 0.25, 0.5, 0, 2, 0 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 1, 0.25, 0.5, 0, 2, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 1, 0.5, 0.5, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 1, 0.5, 0.5, 1, 0, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 1, 0.25, 2, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 1, 0.25, 2, 1, 2, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ - Euler -> Matrix -> Euler'; /* */

  var srcEuler = [ 0.25, 1, 1, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.25, 1, 1, 2, 0, 2 ] ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Euler -> Matrix -> Euler'; /* */

  var srcEuler =  [ 1, 0.5, 0.5, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 1, 0.5, 0.5, 2, 1, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( [] ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( [ 0, 0, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( [ 0, 0, 0, 1, 2, 4 ] ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( [ 0, 0, 0, 1, 2, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( srcEuler, srcEuler ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( NaN ) );
  test.shouldThrowErrorSync( () => _.euler.fromMatrix2( null ) );

}

//

function toMatrix2( test )
{

  test.case = 'Euler remains unchanged'; /**/

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var oldEuler = srcEuler.slice();
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.is( gotMatrix === dstMatrix );
  test.equivalent( gotMatrix, expected );
  test.equivalent( srcEuler, oldEuler );

  test.case = 'Euler XYZ'; /**/

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.7701511383, -0.4207354784, 0.479425549507,
    0.6224468350, 0.65995573997, - 0.420735478401,
    - 0.13938128948, 0.622446835, 0.7701511383
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler XZY'; /**/

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.7701511383, -0.479425549507, 0.4207354784,
    0.5990789532, 0.7701511383, - 0.21902415156,
    - 0.21902415156, 0.4207354784, 0.8803465366
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler YXZ'; /**/

  var srcEuler =  [ 1, 0.5, 0.5, 1, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.6675710082, 0.095001988, 0.738460242,
    0.4207354784, 0.770151138, - 0.479425549,
    - 0.6142724156, 0.6307470202, 0.474159896
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler YZX'; /**/

  var srcEuler = [ 1, 0.25, 0.5, 1, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.5235056281089, 0.286113649, 0.802546501,
    0.2474039644002, 0.8503006696, - 0.464521348,
    - 0.8153116703033, 0.441732704, 0.374351501
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler ZXY'; /**/

  var srcEuler = [ 0.25, 1, 0.5, 2, 0, 1 ] ;
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.7504922747, - 0.1336729228, 0.64721935987,
    0.607998669, 0.5235056281, - 0.5968915224,
    - 0.259034723, 0.8414709568, 0.47415989637
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler ZYX'; /**/

  var srcEuler =  [ 1, 0.5, 0.5, 2, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0.4741598963737, - 0.6142724156, 0.6307470202,
    0.7384602427, 0.6675710082, 0.095001988,
    - 0.4794255495, 0.4207354784, 0.770151138
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'dstMatrix = null'; /**/

  var srcEuler =  [ 1, 0.5, 0.5, 2, 1, 0 ];
  var dstMatrix = null;
  var expected =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0.4741598963737, - 0.6142724156, 0.6307470202,
    0.7384602427, 0.6675710082, 0.095001988,
    - 0.4794255495, 0.4207354784, 0.770151138
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );
  test.is( dstMatrix !== gotMatrix );

  test.case = 'dstMatrix = undefined'; /**/

  var srcEuler =  [ 1, 0.5, 0.5, 2, 1, 0 ];
  var dstMatrix = undefined;
  var expected =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0.4741598963737, - 0.6142724156, 0.6307470202,
    0.7384602427, 0.6675710082, 0.095001988,
    - 0.4794255495, 0.4207354784, 0.770151138
  ]);

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );
  test.is( dstMatrix !== gotMatrix );

  test.case = 'Euler XYX - Matrix -> Euler -> Matrix'; /**/

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.877582550048, 0.229848861694, 0.42073550820,
    0.229848861694, 0.568439781665, - 0.789965629577,
    - 0.42073550820, 0.78996562957, 0.44602233171
  ]);
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var expected =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0.877582550048, 0.229848861694, 0.42073550820,
    0.229848861694, 0.568439781665, - 0.789965629577,
    - 0.42073550820, 0.78996562957, 0.44602233171
  ]);

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var gotMatrix = _.euler.toMatrix2( gotEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler XZX - Matrix -> Euler -> Matrix'; /**/

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.877582550048, - 0.42073550820, 0.229848861694,
    0.42073550820, 0.44602233171, - 0.789965629577,
    0.229848861694, 0.78996562957, 0.56843978166
  ]);
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.877582550048, - 0.42073550820, 0.229848861694,
    0.42073550820, 0.44602233171, - 0.789965629577,
    0.229848861694, 0.78996562957, 0.56843978166
  ]);

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var gotMatrix = _.euler.toMatrix2( gotEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler YXY - Matrix -> Euler -> Matrix'; /**/

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.56843978166, 0.229848861694, 0.789965629577,
    0.229848861694, 0.877582550048, - 0.42073550820,
    - 0.789965629577, 0.42073550820, 0.44602233171
  ]);
  var dstEuler =  [ 0, 0, 0, 1, 0, 1 ];
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.56843978166, 0.229848861694, 0.789965629577,
    0.229848861694, 0.877582550048, - 0.42073550820,
    - 0.789965629577, 0.42073550820, 0.44602233171
  ]);

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var gotMatrix = _.euler.toMatrix2( gotEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler YZY - Matrix -> Euler -> Matrix'; /**/

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.44602233171, - 0.42073550820, 0.789965629577,
    0.42073550820, 0.877582550048, 0.229848861694,
    - 0.789965629577, 0.229848861694, 0.56843978166
  ]);
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.44602233171, - 0.42073550820, 0.789965629577,
    0.42073550820, 0.877582550048, 0.229848861694,
    - 0.789965629577, 0.229848861694, 0.56843978166
  ]);

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var gotMatrix = _.euler.toMatrix2( gotEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler ZXZ - Matrix -> Euler -> Matrix'; /**/

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.568439841270, - 0.78996562957, 0.22984884679,
    0.789965629577, 0.44602236151, - 0.4207354784,
    0.229848867931, 0.4207354784, 0.877582550048
  ]);
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ] ;
  var expected = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.568439841270, - 0.78996562957, 0.22984884679,
    0.789965629577, 0.44602236151, - 0.4207354784,
    0.229848867931, 0.4207354784, 0.877582550048
  ]);

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var gotMatrix = _.euler.toMatrix2( gotEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  test.case = 'Euler ZYZ - Matrix -> Euler -> Matrix'; /**/

  var srcMatrix = _.Space.make( [ 3, 3 ] ).copy
  ([
    0.44602233171, - 0.789965629577, 0.42073550820,
    0.789965629577, 0.56843978166, 0.229848861694,
    - 0.42073550820, 0.229848861694, 0.877582550048
  ]);
  var dstEuler =  [ 0, 0, 0, 2, 1, 2 ];
  var expected =  _.Space.make( [ 3, 3 ] ).copy
  ([
    0.44602233171, - 0.789965629577, 0.42073550820,
    0.789965629577, 0.56843978166, 0.229848861694,
    - 0.42073550820, 0.229848861694, 0.877582550048
  ]);

  var gotEuler = _.euler.fromMatrix2( dstEuler, srcMatrix );
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var gotMatrix = _.euler.toMatrix2( gotEuler, dstMatrix );
  test.equivalent( gotMatrix, expected );

  /* */

  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.euler.toMatrix2( ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [], [] ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0, 0, 1, 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0, 0, 1, 0, 1, 2 ], dstMatrix, dstMatrix ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0.1, 0, 0, 1, 2, 0, 0 ], dstMatrix ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0.1, 0, 1, 1, 2, 3 ], dstMatrix ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0, 0, 1, 0, 1, 2 ], _.Space.makeZero( [ 4, 4 ] ) ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0, 0.2, 0, 1, 2, 0 ], [ 0, 0.2, 0, 1, 2, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( NaN, dstMatrix ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( 'euler', dstMatrix ) );
  test.shouldThrowErrorSync( () => _.euler.toMatrix2( [ 0, 1, 0.5, 0, 1, 2 ], 'dstMatrix' ) );

}

//

function eulerToRotationMatrixToEulerGimbalLock( test )
{

  test.case = 'Euler XYZ - Gimbal Lock angle y = pi/2'; /* */

  var srcEuler = [ - 0.1, Math.PI/2, 0, 0, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ - 0.1, Math.PI/2, 0, 0, 1, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYZ - Gimbal Lock angle y = -pi/2'; /* */

  var srcEuler = [ 0.1, - Math.PI/2, 0, 0, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, - Math.PI/2, 0, 0, 1, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY - Gimbal Lock angle z = pi/2'; /* */

  var srcEuler =  [ 0.1, Math.PI/2, 0, 0, 2, 1 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, Math.PI/2, 0, 0, 2, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZY - Gimbal Lock angle z = - pi/2'; /* */

  var srcEuler =  [ 0.1, - Math.PI/2, 0, 0, 2, 1 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, - Math.PI/2, 0, 0, 2, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ - Gimbal Lock angle x = pi/2'; /* */

  var srcEuler = [ 0.1, Math.PI/2, 0, 1, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, Math.PI/2, 0, 1, 0, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXZ - Gimbal Lock angle x = - pi/2'; /* */

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 1, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ - 0.1, - Math.PI/2, 0, 1, 0, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX - Gimbal Lock angle z = pi/2'; /* */

  var srcEuler = [ - 0.1, Math.PI/2, 0, 1, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ - 0.1, Math.PI/2, 0, 1, 2, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZX - Gimbal Lock angle z = - pi/2'; /* */

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 1, 2, 0 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ - 0.1, - Math.PI/2, 0, 1, 2, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY - Gimbal Lock angle x = pi/2'; /* */

  var srcEuler = [ - 0.1, Math.PI/2, 0, 2, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ - 0.1, Math.PI/2, 0, 2, 0, 1 ] ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXY - Gimbal Lock angle x = - pi/2'; /* */

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 2, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ - 0.1, - Math.PI/2, 0, 2, 0, 1 ] ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Gimbal Lock angle x = pi/2'; /* */

  var srcEuler =  [ - 0.1, Math.PI/2, 0, 2, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ - 0.1, Math.PI/2, 0, 2, 1, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYX - Gimbal Lock angle x = - pi/2'; /* */

  var srcEuler =  [ - 0.1, - Math.PI/2, 0, 2, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ - 0.1, - Math.PI/2, 0, 2, 1, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYX - Gimbal Lock angle y = 0'; /* */

  var srcEuler = [ 0.1, 0, 0, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, 0, 0, 0, 1, 0 ]; ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XYX - Gimbal Lock angle y = pi'; /* */

  var srcEuler = [ 0.1, Math.PI, 0, 0, 1, 0 ];
  var dstEuler = [ 0, 0, 0, 0, 1, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, Math.PI, 0, 0, 1, 0 ]; ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX - Gimbal Lock angle z = 0'; /* */

  var srcEuler =  [ 0.1, 0, 0, 0, 2, 0 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, 0, 0, 0, 2, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler XZX - Gimbal Lock angle z = pi'; /* */

  var srcEuler =  [ 0.1, Math.PI, 0, 0, 2, 0 ] ;
  var dstEuler = [ 0, 0, 0, 0, 2, 0 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, Math.PI, 0, 0, 2, 0 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY - Gimbal Lock angle z = 0'; /* */

  var srcEuler = [ 0.1, 0, 0, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, 0, 0, 1, 0, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YXY - Gimbal Lock angle z = pi'; /* */

  var srcEuler = [ 0.1, Math.PI, 0, 1, 0, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 0, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, Math.PI, 0, 1, 0, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY - Gimbal Lock angle z = 0'; /* */

  var srcEuler = [ 0.1, 0, 0, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, 0, 0, 1, 2, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler YZY - Gimbal Lock angle z = pi'; /* */

  var srcEuler = [ 0.2, Math.PI, 0, 1, 2, 1 ];
  var dstEuler = [ 0, 0, 0, 1, 2, 1 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.2, Math.PI, 0, 1, 2, 1 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ - Gimbal Lock angle z = 0'; /* */

  var srcEuler = [ 0.2, 0, 0, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.2, 0, 0, 2, 0, 2 ] ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZXZ - Gimbal Lock angle z = pi'; /* */

  var srcEuler = [ 0.1, Math.PI, 0, 2, 0, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 0, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected = [ 0.1, Math.PI, 0, 2, 0, 2 ] ;

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYZ - Gimbal Lock angle z = 0'; /* */

  var srcEuler =  [ 0.1, 0, 0, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, 0, 0, 2, 1, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

  test.case = 'Euler ZYZ - Gimbal Lock angle z = pi'; /* */

  var srcEuler =  [ 0.1, Math.PI, 0, 2, 1, 2 ];
  var dstEuler = [ 0, 0, 0, 2, 1, 2 ];
  var dstMatrix = _.Space.makeZero( [ 3, 3 ] );
  var expected =  [ 0.1, Math.PI, 0, 2, 1, 2 ];

  var gotMatrix = _.euler.toMatrix2( srcEuler, dstMatrix );
  var gotEuler = _.euler.fromMatrix2( dstEuler, gotMatrix );
  gotEuler = _.vector.toArray( gotEuler );
  test.equivalent( gotEuler, expected );

}

//

function eulerToQuatToEulerToQuatFast( test )
{
  debugger;

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var quat1 = _.quat.make();
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
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {
    euler2 = euler1.slice();
    quat1 = _.euler.toQuat2( euler1, quat1 );
    euler2 = _.euler.fromQuat2( euler2, quat1 );
    quat2 = _.euler.toQuat2( euler2, quat2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToEulerToQuatFast.timeOut = 20000;
eulerToQuatToEulerToQuatFast.usingSourceCode = 0;
eulerToQuatToEulerToQuatFast.rapidity = 3;

//

function eulerToQuatToEulerToQuatSlow( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var quat1 = _.quat.make();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  // var deltas = [ -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  // var deltas = [ -accuracySqr, 0, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
  var anglesLocked = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];

  /* */

  var o =
  {
    deltas : deltas,
    angles : angles,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {
    euler2 = euler1.slice();
    quat1 = _.euler.toQuat2( euler1, quat1 );
    euler2 = _.euler.fromQuat2( euler2, quat1 );
    quat2 = _.euler.toQuat2( euler2, quat2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
    test.is( eq );
  }

}

eulerToQuatToEulerToQuatSlow.timeOut = 120000;
eulerToQuatToEulerToQuatSlow.usingSourceCode = 0;
eulerToQuatToEulerToQuatSlow.rapidity = 2;
eulerToQuatToEulerToQuatSlow.accuracy = [ 1e-10, 1e-1 ];

//

function eulerToQuatToMatrixToQuatSlow( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var matrix1 = _.Space.makeZero( [ 3, 3 ] );
  var quat1 = _.quat.make();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI/6 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked =  [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  /* */

  var o =
  {
    //representations : representations,
    //angles : angles,
    //quadrants : quadrants,
    // quadrantsLocked : quadrantsLocked,
    deltas : deltas,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {
    quat1 = _.euler.toQuat2( euler1, quat1 );
    matrix1 = _.euler.toMatrix2( euler1, matrix1 );
    quat2 = _.quat.fromMatrixRotation( quat2, matrix1 );

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
eulerToQuatToEulerToQuatSlow.accuracy = [ 1e-10, 1e-1 ];

//

function eulerToQuatToMatrixToEulerSlow( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var matrix1 = _.Space.makeZero( [ 3, 3 ] );
  var quat1 = _.quat.make();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI/6 ];
  // var anglesLocked = [ 0, Math.PI / 3 ];
  var anglesLocked =  [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  // var representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx' ];
  // var deltas = [ -accuracySqrt ];
  // var angles = [ 0 ];
  // var quadrants = [ 1 ];

  /* */

  var o =
  {
    // representations : representations,
    angles : angles,
    // quadrants : quadrants,
    // quadrantsLocked : quadrantsLocked,
    deltas : deltas,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  var fails = 0;
  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {
    euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];
    quat1 = _.euler.toQuat2( euler1, quat1 );
    matrix1 = _.quat.toMatrix( quat1, matrix1 );
    euler2 = _.euler.fromMatrix2( euler2, matrix1 );
    quat2 = _.euler.toQuat2( euler2, quat2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );

    if( eq === false )
    {
      fails = fails+1;
      logger.log( 'quat1 :', quat1[ 0 ], quat1[ 1 ], quat1[ 2 ], quat1[ 3 ] );
      logger.log( 'quat2 :', quat2[ 0 ], quat2[ 1 ], quat2[ 2 ], quat2[ 3 ] );
      logger.log( 'euler1 :', euler1[ 0 ], euler1[ 1 ], euler1[ 2 ], euler1[ 3 ], euler1[ 4 ], euler1[ 5 ] );
      logger.log( 'euler2 :', euler2[ 0 ], euler2[ 1 ], euler2[ 2 ], euler2[ 3 ], euler2[ 4 ], euler2[ 5 ] );
      logger.log( matrix1 );
      logger.log( fails );
    }

    test.is( eq );

  }

}

eulerToQuatToMatrixToEulerSlow.timeOut = 180000;
eulerToQuatToMatrixToEulerSlow.usingSourceCode = 0;
eulerToQuatToMatrixToEulerSlow.rapidity = 2;
//eulerToQuatToMatrixToEulerSlow.accuracy = [ 1e-7, 1e-1 ];

//

function eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var axisAndAngle = _.axisAndAngle.makeZero( );
  var quat1 = _.quat.make();
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
    //representations : representations,
    angles : angles,
    // quadrants : quadrants,
    // quadrantsLocked : quadrantsLocked,
    deltas : deltas,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {
    euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];
    quat1 = _.euler.toQuat2( euler1, quat1 );
    axisAndAngle = _.euler.toAxisAndAngle2( euler1, axisAndAngle );
    euler2 = _.euler.fromAxisAndAngle2( euler2, axisAndAngle );
    quat2 = _.euler.toQuat2( euler2, quat2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );

    test.is( eq );

  }

}

eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast.timeOut = 60000;
eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast.usingSourceCode = 0;
eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast.rapidity = 3;
eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast.accuracy = [ 1e-10, 1e-1 ];

//

function eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var axisAndAngle = _.axisAndAngle.makeZero( );
  var quat1 = _.quat.make();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();

  var representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
  // var representations = [ 'xyz' ];
  // var angles = [ 0 ];
  // var quadrantsLocked = [ 0 ];
  var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  // var deltasLocked = [ 0 ];
  // var euler = [ 0, 0, 0, 0, 0, 0 ];
  var anglesLocked = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];

  /* */

  var o =
  {
    representations : representations,
    // angles : angles,
    // quadrants : quadrants,
    // quadrantsLocked : quadrantsLocked,
    deltas : deltas,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {
    euler2[ 3 ] = euler1[ 3 ]; euler2[ 4 ] = euler1[ 4 ]; euler2[ 5 ] = euler1[ 5 ];
    quat1 = _.euler.toQuat2( euler1, quat1 );
    axisAndAngle = _.euler.toAxisAndAngle2( euler1, axisAndAngle );
    euler2 = _.euler.fromAxisAndAngle2( euler2, axisAndAngle );
    quat2 = _.euler.toQuat2( euler2, quat2 );

    var positiveResult = quat2;
    var negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
    var eq = false;
    eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
    eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );

    test.is( eq );

  }

}

eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow.timeOut = 100000;
eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow.usingSourceCode = 0;
eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow.rapidity = 2;
eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow.accuracy = [ 1e-10, 1e-1 ];

//

function represent( test )
{

  test.case = 'Euler representation remains unchanged'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var representation = [ 0, 2, 1 ];
  var oldRepresentation = representation.slice();

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  test.equivalent( representation, oldRepresentation );

  test.case = 'Euler XYZ'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 2, 1 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 2, 1 ];
  var representation = [ 0, 1, 2 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XZY'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 0, 2, 1 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YXZ'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 1, 0, 2 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YZX'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 1, 2, 0 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZXY'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 2, 0, 1 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZYX'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 2, 1, 0 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XYX'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 2, 1 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 2, 1 ];
  var representation = [ 0, 1, 0 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XZX'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 0, 2, 0 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YXY'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 1, 0, 1 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YZY'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 1, 2, 1 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZXZ'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 2, 0, 2 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZYZ'; /**/

  var dstEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = [ 0, 1, 2 ];
  var representation = [ 2, 1, 2 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XYZ'; /**/

  var dstEuler = [ 1, 0.25, 0.75, 0, 2, 0 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzx';
  var representation = 'xyz';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XZY'; /**/

  var dstEuler = [ 1, 0.25, 0.75, 0, 2, 0 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzx';
  var representation = 'xzy';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YXZ'; /**/

  var dstEuler = [ 1, 0.25, 0.75, 0, 2, 0 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzx';
  var representation = 'yxz';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YZX'; /**/

  var dstEuler = [ 1, 0.25, 0.75, 0, 2, 0 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzx';
  var representation = 'yzx';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZXY'; /**/

  var dstEuler = [ 1, 0.25, 0.75, 0, 2, 0 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzx';
  var representation = 'zxy';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZYX'; /**/

  var dstEuler = [ 1, 0.25, 0.75, 0, 2, 0 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzx';
  var representation = 'zyx';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XYX'; /**/

  var dstEuler = [ - 0.5, 0.5, 1, 0, 2, 1 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xzy';
  var representation = 'xyx';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler XZX'; /**/

  var dstEuler = [ - 0.5, 0.5, 1, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xyz';
  var representation = 'xzx';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YXY'; /**/

  var dstEuler = [ - 0.5, 0.5, 1, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xyz';
  var representation = 'yxy';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler YZY'; /**/

  var dstEuler = [ - 0.5, 0.5, 1, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xyz';
  var representation = 'yzy';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZXZ'; /**/

  var dstEuler = [ - 0.5, 0.5, 1, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xyz';
  var representation = 'zxz';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler ZYZ'; /**/

  var dstEuler = [ - 0.5, 0.5, 1, 0, 1, 2 ];
  var srcEuler = dstEuler.slice();
  var oldRepresentation = 'xyz';
  var representation = 'zyz';

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( gotEuler === dstEuler );
  var result = _.euler.represent( gotEuler, oldRepresentation );
  test.equivalent( result, srcEuler );

  test.case = 'Euler null'; /**/

  var dstEuler = null;
  var representation = 'zyz';
  var expected = [ 0, 0, 0, 2, 1, 2 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( dstEuler !== gotEuler );
  test.equivalent(expected, gotEuler );

  test.case = 'Euler undefined'; /**/

  var dstEuler = undefined;
  var representation = 'zyz';
  var expected = [ 0, 0, 0, 2, 1, 2 ];

  var gotEuler = _.euler.represent( dstEuler, representation );
  test.is( dstEuler !== gotEuler );
  test.equivalent(expected, gotEuler );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.euler.represent( ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [] ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0, 0, 1, 2, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0, 0, 1, 2, 0 ], [ 1, 2, 0 ], 'zyx' ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 1, 2, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.represent( 'xyz' ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0.2, 0, 1, 2, 0 ], [ 0, 1, 2, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0.2, 0, 1, 2, 0 ], [ 0, 1, 3 ] ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0.2, 0, 1, 2, 0 ], 'not a good rep' ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0.2, 0, 0, 1, 2, 0 ], [ 0, 1, 2 ] ) );
  test.shouldThrowErrorSync( () => _.euler.represent( NaN, NaN ) );
  test.shouldThrowErrorSync( () => _.euler.represent( null, null ) );
  test.shouldThrowErrorSync( () => _.euler.represent( 'euler', 'representation' ) );
  test.shouldThrowErrorSync( () => _.euler.represent( [ 0, 0, 0, 1, 2, 0 ], 'representation' ) );
  test.shouldThrowErrorSync( () => _.euler.represent( 'euler', 'xyz' ) );

}

//

function representFullCoverageFast( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var accuracySqrt = Math.sqrt( test.accuracy );
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var quat1 = _.quat.make();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();
  var representation = [];
  var positiveResult = [];
  var negativeResult = [];
  var eq = false;
  var representationsFull = [ 'xyz', 'yzx', 'zxy', 'xyx', 'yzy', 'zyz', [ 0, 2, 1 ], [ 1, 0, 2 ], [ 2, 1, 0 ], [ 0, 2, 0 ], [ 1, 2, 1 ], [ 2, 0, 2 ] ];

  // var representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
  // var angles = [ 0, Math.PI / 6, Math.PI / 4, Math.PI / 3 ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4 ];
  // var quadrants = [ 0, 1, 2, 3 ];
  var quadrantsLocked = [ 0 ];
  // var deltas = [ -0.1, -accuracySqrt, -accuracySqr, 0, +accuracySqr, +accuracySqrt, +0.1 ];
  var deltas = [ -accuracySqr, +accuracySqr ];
  // var deltasLocked = [ 0 ];
  var anglesLocked = [ Math.PI / 3 ];

  /* */

  var o =
  {
    // representations : representations,
    angles : angles,
    // quadrants : quadrants,
    quadrantsLocked : quadrantsLocked,
    deltas : deltas,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {

    for( var i = 0; i < representationsFull.length; i++ )
    {
      euler2 = euler1.slice();
      quat1 = _.euler.toQuat2( euler2, quat1 );

      representation = representationsFull[ i ];
      euler2 = _.euler.represent( euler2, representation );
      quat2 = _.euler.toQuat2( euler2, quat2 );

      positiveResult = quat2;
      negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
      eq = false;
      eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
      eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
      test.is( eq );
    }
  }

}

representFullCoverageFast.timeOut = 100000;
representFullCoverageFast.usingSourceCode = 0;
representFullCoverageFast.rapidity = 3;

//

function representFullCoverageSlow( test )
{

  var accuracy =  test.accuracy;
  var accuracySqr = test.accuracy*test.accuracy;
  var euler1 = _.euler.make();
  var euler2 = _.euler.make();
  var quat1 = _.quat.make();
  var quat2 = _.quat.make();
  var quat2b = _.quat.make();
  var representation = [];
  var positiveResult = [];
  var negativeResult = [];
  var eq = false;
  var representationsFull = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz',
    [ 0, 1, 2 ], [ 0, 2, 1 ], [ 1, 0, 2 ], [ 1, 2, 0 ], [ 2, 0, 1 ], [ 2, 1, 0 ],
    [ 0, 1, 0], [ 0, 2, 0 ], [ 1, 0, 1], [ 1, 2, 1 ], [ 2, 0, 2 ], [ 2, 1, 2 ] ];

  // var representations = [ 'xyz', 'xzy', 'yxz', 'yzx', 'zxy', 'zyx', 'xyx', 'xzx', 'yxy', 'yzy', 'zxz', 'zyz' ];
  var angles = [ 0, Math.PI / 6, Math.PI / 4 ];
  // var quadrants = [ 0, 1, 2, 3 ];
  var quadrantsLocked = [ 0 ];
  // var deltas = [ -0.1, -Math.sqrt( accuracy ), -( accuracySqr ), 0, +( accuracySqr ), +Math.sqrt( accuracy ), +0.1 ];
  var deltas = [ -( accuracySqr ), 0, +Math.sqrt( accuracy ), +0.1 ];
  // var deltasLocked = [ 0 ];
  var anglesLocked = [ Math.PI / 3 ];

  /* */

  var o =
  {
    // representations : representations,
    angles : angles,
    // quadrants : quadrants,
    quadrantsLocked : quadrantsLocked,
    deltas : deltas,
    anglesLocked : anglesLocked,
    onEach : onEach,
    dst : euler1,
  }

  this.eachAngle( o );

  /* */

  function onEach( euler1 )
  {

    for( var i = 0; i < representationsFull.length; i++ )
    {
      euler2 = euler1.slice();
      quat1 = _.euler.toQuat2( euler2, quat1 );

      representation = representationsFull[ i ];
      euler2 = _.euler.represent( euler2, representation );
      quat2 = _.euler.toQuat2( euler2, quat2 );

      positiveResult = quat2;
      negativeResult = _.avector.mul( _.avector.assign( quat2b, quat2 ), -1 );
      eq = false;
      eq = eq || _.entityEquivalent( positiveResult, quat1, { accuracy : test.accuracy } );
      eq = eq || _.entityEquivalent( negativeResult, quat1, { accuracy : test.accuracy } );
      test.is( eq );
    }
  }

}

representFullCoverageSlow.timeOut = 150000;
representFullCoverageSlow.usingSourceCode = 0;
representFullCoverageSlow.rapidity = 2;

//

function isGimbalLock( test )
{

  test.case = 'Euler remains unchanged'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];
  var oldSrcEuler = srcEuler.slice();

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( oldSrcEuler, srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler XYZ'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 2, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler XZY'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler YXZ'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler YZX'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler ZXY'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler ZYX'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler XYX'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 2, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler XZX'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler YXY'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler YZY'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler ZXZ'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler ZYZ'; //

  var srcEuler = [ 0.5, 0.5, 0.5, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, false );

  test.case = 'Euler XYZ - Gimbal Lock angle y = pi/2'; /**/

  var srcEuler = [ - 0.1, Math.PI/2, 0, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XYZ - Gimbal Lock angle y = -pi/2'; /**/

  var srcEuler = [ 0.1, - Math.PI/2, 0, 0, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XZY - Gimbal Lock angle z = pi/2'; /**/

  var srcEuler =  [ 0.1, Math.PI/2, 0, 0, 2, 1 ] ;

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XZY - Gimbal Lock angle z = - pi/2'; /**/

  var srcEuler =  [ 0.1, - Math.PI/2, 0, 0, 2, 1 ] ;

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YXZ - Gimbal Lock angle x = pi/2'; /**/

  var srcEuler = [ 0.1, Math.PI/2, 0, 1, 0, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YXZ - Gimbal Lock angle x = - pi/2'; /**/

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 1, 0, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YZX - Gimbal Lock angle z = pi/2'; /**/

  var srcEuler = [ - 0.1, Math.PI/2, 0, 1, 2, 0 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YZX - Gimbal Lock angle z = - pi/2'; /**/

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 1, 2, 0 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZXY - Gimbal Lock angle x = pi/2'; /**/

  var srcEuler = [ - 0.1, Math.PI/2, 0, 2, 0, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZXY - Gimbal Lock angle x = - pi/2'; /**/

  var srcEuler = [ - 0.1, - Math.PI/2, 0, 2, 0, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZYX - Gimbal Lock angle x = pi/2'; /**/

  var srcEuler =  [ - 0.1, Math.PI/2, 0, 2, 1, 0 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZYX - Gimbal Lock angle x = - pi/2'; /**/

  var srcEuler =  [ - 0.1, - Math.PI/2, 0, 2, 1, 0 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XYX - Gimbal Lock angle y = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 0, 1, 0 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XYX - Gimbal Lock angle y = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 0, 1, 0 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XZX - Gimbal Lock angle z = pi'; /**/

  var srcEuler =  [ 0.1, Math.PI, 0, 0, 2, 0 ] ;

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler XZX - Gimbal Lock angle z = 0'; /**/

  var srcEuler =  [ 0.1, 0, 0, 0, 2, 0 ] ;

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YXY - Gimbal Lock angle z = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 1, 0, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YXY - Gimbal Lock angle z = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 1, 0, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YZY - Gimbal Lock angle z = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 1, 2, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler YZY - Gimbal Lock angle z = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 1, 2, 1 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZXZ - Gimbal Lock angle z = pi'; /**/

  var srcEuler = [ 0.1, Math.PI, 0, 2, 0, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZXZ - Gimbal Lock angle z = 0'; /**/

  var srcEuler = [ 0.1, 0, 0, 2, 0, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZYZ - Gimbal Lock angle z = pi'; /**/

  var srcEuler =  [ 0.1, Math.PI, 0, 2, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  test.case = 'Euler ZYZ - Gimbal Lock angle z = 0'; /**/

  var srcEuler =  [ 0.1, 0, 0, 2, 1, 2 ];

  var gotBool = _.euler.isGimbalLock( srcEuler );
  test.identical( gotBool, true );

  /* */

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( [] ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( [ 0, 0, 0, 1, 2, 0 ], [ 1, 2, 0, 1, 2, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( [ 0, 0, 0, 1, 2, 0, 0 ] ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( [ 1, 2, 0, 0, 1 ] ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( [ 0, 0.2, 0, 1, 2, 3 ] ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( 'eulerAngle' ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( NaN ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( null ) );
  test.shouldThrowErrorSync( () => _.euler.isGimbalLock( undefined ) );

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

//
//
//
// _.include( 'wConsequence' );
// function experiment( test )
// {
//   debugger;
//   return _.timeOut( 10000 );
// }

// --
// declare
// --

var Self =
{

  name : 'Tools.Math.Euler',
  silencing : 1,
  enabled : 1,
  // routine : 'eulerToQuatToMatrixToEulerSlow',

  context :
  {
    eachAngle : eachAngle,
  },

  tests :
  {

    is : is,
    isZero : isZero,

    make : make,
    makeZero : makeZero,

    zero : zero,

    //fromAxisAndAngle : fromAxisAndAngle,
    fromQuat : fromQuat,
    fromMatrix : fromMatrix,
    toMatrix : toMatrix,

    fromQuat2 : fromQuat2,
    toQuat2 : toQuat2,
    eulerToQuatToEulerGimbalLock : eulerToQuatToEulerGimbalLock,

    fromMatrix2 : fromMatrix2,
    toMatrix2 : toMatrix2,
    eulerToRotationMatrixToEulerGimbalLock : eulerToRotationMatrixToEulerGimbalLock,

    /* takes 6 seconds */
    eulerToQuatToEulerToQuatFast : eulerToQuatToEulerToQuatFast,
    /* takes 88 seconds - accuracy [ 1e-10, 1e-1 ] */
    eulerToQuatToEulerToQuatSlow : eulerToQuatToEulerToQuatSlow,

    /* takes 140 seconds */
    eulerToQuatToMatrixToQuatSlow : eulerToQuatToMatrixToQuatSlow,

    /* takes 50 seconds - accuracy is 1E-5 */
    eulerToQuatToMatrixToEulerSlow : eulerToQuatToMatrixToEulerSlow,

    /* takes 8 seconds */
    eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast : eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatFast,
    /* takes 94.4 seconds */
    eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow : eulerToQuatToAxisAndAngleToEulerToAxisAndAngleToQuatSlow,

    represent : represent,

    /* takes 16 seconds */
    representFullCoverageFast : representFullCoverageFast,

    /* takes 117 seconds */
    representFullCoverageSlow : representFullCoverageSlow,

    isGimbalLock : isGimbalLock,
  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
