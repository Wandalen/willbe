( function _zSpace_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

}

//

var _ = _global_.wTools;

//

function execute()
{

  return;

  var pi = Math.PI;
  var e = Math.E;
  var cos = Math.cos;
  var sin = Math.sin;
  var arctan = Math.atan;
  var tan = Math.tan;
  var pow = Math.pow;
  var sqrt = _.sqrt;

  debugger;

  function calc( inre,inim )
  {

    console.log( 'in',inre,'+',inim + 'i' );

    var outre = 0;
    var outim = 0;

    outre += + ( inre**3 ) - 3*inre*( inim**2 );
    outim += - ( inim**3 ) + 3*( inre**2 )*inim;

    outre += 5*( ( inre**2 ) - ( inim**2 ) );
    outim += 5*( 2*inre*inim );

    outre += 8*pow( inre,1 );
    outim += 8*pow( inim,1 );

    outre += 6;

    console.log( 'out1',outre,'+',outim + 'i' );

    var outre = 0;
    var outim = 0;

    outre += 3*( ( inre**2 ) - ( inim**2 ) );
    outim += 3*( 2*inre*inim );

    outre += 10*pow( inre,1 );
    outim += 10*pow( inim,1 );

    outre += 8;

    console.log( 'out2',outre,'+',outim + 'i' );

  }

  calc( +1,0 );
  calc( -1,0 );
  calc( +3,0 );
  calc( -3,0 );
  calc( +1,+1 );
  calc( -1,+1 );

  debugger;
  console.log( '' );

  calc( +1,+1 );
  calc( -1,+1 );
  calc( -1,+3 );
  calc( +1,+3 );

  debugger;
  return;

/*

1 / ( 3-omega^2+i*omega*0.5 )



e^( w*t*i )
-
( 3-omega^2+i*omega*0.5 )

cos( w*t ) + i*sin( w*t )
-
( 3-omega^2+i*omega*0.5 )

cos( w*t ) + i*sin( w*t )*( 3-omega^2-i*omega*0.5 )
-
( 3-omega^2+i*omega*0.5 )*( 3-omega^2-i*omega*0.5 )


cos( w*t )*( 3-omega^2 ) + sin( w*t )*omega*0.5
-
( (3-omega^2)^2-(omega*0.5)^2 )


( cos( w*t )*( 3-omega^2 ) + sin( w*t )*omega*0.5 ) / ( ( (3-omega^2)^2-(omega*0.5)^2 )*cos( w*t ) )





mod = sqrt( ( 3-omega^2 )^2 + ( omega*0.5 )^2 )
arg = arctan( ( omega*0.5 ) / ( 3-omega^2 ) )

e^( omega*t*i - arg*i )
-
mod

e^( omega*t*i - arg*i )
-
mod

cos( omega*t - arg )
-
mod

cos( omega*t - arg )
-
mod

*/

  // function f( t )
  // {
  //   var fh = ( -1/sqrt( 20 ) ) * ( cos( -pi+arctan( 2 ) ) / cos( -arctan( 4 ) ) ) * e**(-t)*cos( t-arctan( 4 ) );
  //   var fp = ( 1/sqrt( 20 ) )*cos( 2*t-pi+arctan( 2 ) );
  //   return fh + fp;
  // }
  //
  // function df( t )
  // {
  //   var fh = t * ( -1/sqrt( 20 ) ) * ( cos( -pi+arctan( 2 ) ) / cos( -arctan( 4 ) ) ) * e**(-t)*sin( t-arctan( 4 ) );
  //   var fp = -2 * ( 1/sqrt( 20 ) )*sin( 2*t-pi+arctan( 2 ) );
  //   return fh + fp;
  // }

// lambda = - pi + arctan( 2 );
// phi = - arctan( 2*tan( lambda ) - 1 );
// c = ( -1/sqrt( 20 ) ) * cos( lambda ) / cos( -phi );
// fh = c * e**(-t)*cos( t-phi );
// fp = ( 1/sqrt( 20 ) )*cos( 2*t-pi+arctan( 2 ) );

  function f( t )
  {
    // return ( -1/sqrt( 20 ) ) * cos( -pi+arctan( 2 ) ) / cos( - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) ) * e**(-t)*cos( t - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) ) + ( 1/sqrt( 20 ) )*cos( 2*t-pi+arctan( 2 ) );

    var lambda = - pi + arctan( 2 );
    var phi = - arctan( 2*tan( lambda ) - 1 );
    var c = ( -1/sqrt( 20 ) ) * cos( lambda ) / cos( -phi );
    var fh = c * e**(-t)*cos( t-phi );
    var fp = ( 1/sqrt( 20 ) )*cos( 2*t-pi+arctan( 2 ) );
    return fh + fp;
  }

/*
    var phi = - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 );
    var c = ( -1/sqrt( 20 ) ) * cos( -pi+arctan( 2 ) ) / cos( - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) );
    var fh = ( -1/sqrt( 20 ) ) * cos( -pi+arctan( 2 ) ) / cos( - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) ) * e**(-t)*cos( t - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) );
    var fp = ( 1/sqrt( 20 ) )*cos( 2*t-pi+arctan( 2 ) );
    return ( -1/sqrt( 20 ) ) * cos( -pi+arctan( 2 ) ) / cos( - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) ) * e**(-t)*cos( t - arctan( 2*tan( -pi+arctan( 2 ) ) - 1 ) ) + ( 1/sqrt( 20 ) )*cos( 2*t-pi+arctan( 2 ) );
*/

  // function df( t )
  // {
  //   var lambda = - pi + arctan( 2 );
  //   var phi = - arctan( 2*tan( lambda ) - 1 );
  //   var c = ( -1/sqrt( 20 ) ) * cos( lambda ) / cos( -phi );
  //   var fh = - c * e**(-t)*sin( t-phi ) - c * e**(-t)*cos( t-phi );
  //   var fp = -2*( 1/sqrt( 20 ) )*sin( 2*t-pi+arctan( 2 ) );
  //   return fh + fp;
  // }

  // debugger;
  // var f0 = f( 0 );
  // var df0 = df( 0 );
  // debugger;

/*

-1/3-e^(t*pi/2)/( -6-pi^2+( pi^3)/2+pi^4/16 )

*/

}

//

// execute();
// _.timeReady( execute );

// Self = wTestSuite( Self );
// if( typeof module !== 'undefined' && !module.parent )
// wTester.test( Self.name );

} )( );
