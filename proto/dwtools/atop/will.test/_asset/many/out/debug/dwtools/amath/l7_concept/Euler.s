(function _Euler_s_(){

'use strict';

let _ = _global_.wTools;
let avector = _.avector;
let vector = _.vector;
let pi = Math.PI;
let sin = Math.sin;
let cos = Math.cos;
let atan2 = Math.atan2;
let asin = Math.asin;
let acos = Math.acos;
let abs = Math.abs;
let sqr = _.sqr;
let sqrt = _.sqrt;
let clamp = _.clamp;

_.assert( _.routineIs( clamp ) )
_.assert( !_.euler );

/**
 * @description
 * An Euler Angle is a set of three consecutive rotations around the axes of coordinates.
 *
 * For the following functions, Euler Angles must have the shape [ angle1, angle2, angle3, axis1, axis2, axis3 ],
 * where angle1, angle2 and angle3 are the value of the rotations ( in radians )
 * and axis1, axis2, axis3 the corresponding axes of rotation.
 * @namespace "wTools.euler"
 * @memberof module:Tools/math/Concepts 
 */

let Self = _.euler = _.euler || Object.create( _.avector );

/*

An Euler Angle is a set of three consecutive rotations around the axes of coordinates.

For the following functions, Euler Angles must have the shape [ angle1, angle2, angle3, axis1, axis2, axis3 ],
where angle1, angle2 and angle3 are the value of the rotations ( in radians )
and axis1, axis2, axis3 the corresponding axes of rotation.

*/

// --
//
// --

function is( euler )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  return ( _.longIs( euler ) || _.vectorAdapterIs( euler ) ) && ( euler.length === 6 );
}

//

function isZero( euler )
{

  _.assert( arguments.length === 1, 'Expects single argument' );

  let eulerView = _.euler._from( euler );

  for( let d = 0 ; d < 3 ; d++ )
  if( eulerView.eGet( d ) !== 0 )
  return false;

  return true;
}

//

function make( srcEuler, representation )
{
  let result = _.euler.makeZero();

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  _.assert( srcEuler === undefined || srcEuler === null || _.euler.is( srcEuler ) );
  _.assert( representation === undefined || representation );

  if( _.euler.is( srcEuler ) )
  _.avector.assign( result, srcEuler );

  if( representation )
  _.euler.representationSet( result, representation );

  return result;
}

//

function makeZero( representation )
{
  let result = _.dup( 0,6 );
  result[ 3 ] = 0;
  result[ 4 ] = 1;
  result[ 5 ] = 2;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( representation === undefined || representation );

  if( representation )
  _.euler.representationSet( result, representation );

  return result;
}

//

function zero( euler )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( euler === undefined || euler === null || _.euler.is( euler ) );

  if( _.euler.is( euler ) )
  {
    let eulerView = _.euler._from( euler );
    for( let i = 0 ; i < 3 ; i++ )
    eulerView.eSet( i,0 );
    return euler;
  }

  return _.euler.makeZero();
}

//

function from( euler )
{

  _.assert( euler === null || _.euler.is( euler ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( euler === null )
  return _.euler.make();

  if( _.vectorAdapterIs( euler ) )
  {
    debugger;

    //throw _.err( 'not implemented' );
    // return euler.slice();
    return euler.toArray();
  }

  return euler;
}

//

function _from( euler )
{
  _.assert( _.euler.is( euler ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  return _.vector.from( euler );
}

//

function representationSet( dstEuler, representation )
{
  let dstEulerView = _.euler._from( dstEuler );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _.arrayIs( representation ) || _.longIs( representation ) )
  {
    _.assert( representation.length === 3 );
    let rep = true;
    for( let i = 0; i < 3; i++ )
    {
      if( representation[ i ] !== 0 && representation[ i ] !== 1 && representation[ i ] !== 2 )
      {
        rep = false;
      }
    }

    if( rep )
    {
      dstEulerView.eSet( 3, representation[ 0 ] );
      dstEulerView.eSet( 4, representation[ 1 ] );
      dstEulerView.eSet( 5, representation[ 2 ] );
    }
    else _.assert( 0, 'Not an Euler Representation' );
  }
  else if( _.strIs( representation ) )
  {

    if( representation === 'xyz' )
    {
      dstEulerView.eSet( 3, 0 );
      dstEulerView.eSet( 4, 1 );
      dstEulerView.eSet( 5, 2 );
    }
    else if( representation === 'xzy' )
    {
      dstEulerView.eSet( 3, 0 );
      dstEulerView.eSet( 4, 2 );
      dstEulerView.eSet( 5, 1 );
    }
    else if( representation === 'yxz' )
    {
      dstEulerView.eSet( 3, 1 );
      dstEulerView.eSet( 4, 0 );
      dstEulerView.eSet( 5, 2 );
    }
    else if( representation === 'yzx' )
    {
      dstEulerView.eSet( 3, 1 );
      dstEulerView.eSet( 4, 2 );
      dstEulerView.eSet( 5, 0 );
    }
    else if( representation === 'zxy' )
    {
      dstEulerView.eSet( 3, 2 );
      dstEulerView.eSet( 4, 0 );
      dstEulerView.eSet( 5, 1 );
    }
    else if( representation === 'zyx' )
    {
      dstEulerView.eSet( 3, 2 );
      dstEulerView.eSet( 4, 1 );
      dstEulerView.eSet( 5, 0 );
    }
    else if( representation === 'xyx' )
    {
      dstEulerView.eSet( 3, 0 );
      dstEulerView.eSet( 4, 1 );
      dstEulerView.eSet( 5, 0 );
    }
    else if( representation === 'xzx' )
    {
      dstEulerView.eSet( 3, 0 );
      dstEulerView.eSet( 4, 2 );
      dstEulerView.eSet( 5, 0 );
    }
    else if( representation === 'yxy' )
    {
      dstEulerView.eSet( 3, 1 );
      dstEulerView.eSet( 4, 0 );
      dstEulerView.eSet( 5, 1 );
    }
    else if( representation === 'yzy' )
    {
      dstEulerView.eSet( 3, 1 );
      dstEulerView.eSet( 4, 2 );
      dstEulerView.eSet( 5, 1 );
    }
    else if( representation === 'zxz' )
    {
      dstEulerView.eSet( 3, 2 );
      dstEulerView.eSet( 4, 0 );
      dstEulerView.eSet( 5, 2 );
    }
    else if( representation === 'zyz' )
    {
      dstEulerView.eSet( 3, 2 );
      dstEulerView.eSet( 4, 1 );
      dstEulerView.eSet( 5, 2 );
    }
    else _.assert( 0, 'Not an Euler Representation', _.strQuote( representation ) );
  }
  else _.assert( 0, 'unknown type of {-representation-}', _.strType( representation ) )

  return dstEuler;
}

//

/*
  double s=Math.sin(angle);
  double c=Math.cos(angle);
  double t=1-c;
  //  if axis is not already normalised then uncomment this
  // double magnitude = Math.sqrt(x*x + y*y + z*z);
  // if(magnitude==0) throw error;
  // x /= magnitude;
  // y /= magnitude;
  // z /= magnitude;
  if((x*y*t + z*s) > 0.998) { // north pole singularity detected
    heading = 2*atan2(x*Math.sin(angle/2),Math.cos(angle/2));
    attitude = Math.PI/2;
    bank = 0;
    return;
  }
  if((x*y*t + z*s) < -0.998) { // south pole singularity detected
    heading = -2*atan2(x*Math.sin(angle/2),Math.cos(angle/2));
    attitude = -Math.PI/2;
    bank = 0;
    return;
  }
  heading = Math.atan2(y * s- x * z * t , 1 - (y*y+ z*z ) * t);
  attitude = Math.asin(x * y * t + z * s) ;
  bank = Math.atan2(x * s - y * z * t , 1 - (x*x + z*z) * t);
*/

function fromAxisAndAngle( dst, axis, angle )
{

  dst = _.euler.from( dst );
  let dstv = _.vector.from( dst );
  let axisv = _.vector.from( axis );

  if( angle === undefined )
  angle = axis[ 3 ];

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( axis.length === 3 || axis.length === 4 );
  _.assert( _.numberIs( angle ) );
  _.assert( this.accuracy > 0 );

  let s = sin( angle );
  let c = cos( angle );
  let t = 1-c;

  let x = axisv.eGet( 0 );
  let y = axisv.eGet( 1 );
  let z = axisv.eGet( 2 );

  if( ( x*y*t + z*s ) > 1-this.accuracy )
  {
    xxx
    dstv.eSet( 0, 2*atan2( x*sin( angle/2 ),cos( angle/2 ) ) );
    dstv.eSet( 1, Math.PI/2 );
    dstv.eSet( 2, bank = 0 );
    return dst;
  }
  else if( ( x*y*t + z*s ) < -1+this.accuracy )
  {
    yyy
    dstv.eSet( 0, -2*atan2( x*sin( angle/2 ),cos( angle/2 ) ) );
    dstv.eSet( 1, -Math.PI/2 );
    dstv.eSet( 2, bank = 0 );
    return dst;
  }

  let x2 = x*x;
  let y2 = y*y;
  let z2 = z*z;

  // xyz

  dstv.eSet( 0, atan2( y*s - x*z*t , 1 - ( y2 + z2 ) * t ) );
  dstv.eSet( 1, asin( x*y*t + z*s ) );
  dstv.eSet( 2, atan2( x*s - y*z*t , 1 - ( x2 + z2 ) * t ) );

  // xzy

  dstv.eSet( 0, atan2( z*s - x*y*t , 1 - ( z2 + y2 ) * t ) );
  dstv.eSet( 1, atan2( x*s - z*y*t , 1 - ( x2 + y2 ) * t ) );
  dstv.eSet( 2, asin( x*z*t + y*s ) );

  return dst;
}

//

function fromQuat( dst, quat, v )
{
  let /*eps*/accuracy = 1e-9;
  let half = 0.5-/*eps*/accuracy;

  dst = _.euler.from( dst );
  let dstv = _.vector.from( dst );
  let quatv = _.quat._from( quat );

  // _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let ox = dstv.eGet( 3 );
  let oy = dstv.eGet( 4 );
  let oz = dstv.eGet( 5 );
  let same = ox === oz;

  let sign;

  // if( same )
  // {
  //   if( 0 !== ox && 0 !== oy )
  //   oz = 0;
  //   else if( 1 !== ox && 1 !== oy )
  //   oz = 1;
  //   else if( 2 !== ox && 2 !== oy )
  //   oz = 2;
  //   sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  // }
  // else
  // {
    sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  // }

  sign = sign ? -1 : + 1;
  // console.log( 'sign',sign );

  let ex,ey,ez;

  // let x = quatv.eGet( ox );
  // let y = quatv.eGet( oy );
  // let z = quatv.eGet( oz );
  // let w = quatv.eGet( 3 );

  let x = quatv.eGet( 0 );
  let y = quatv.eGet( 1 );
  let z = quatv.eGet( 2 );
  let w = quatv.eGet( 3 );

  let sqx = x*x;
  let sqy = y*y;
  let sqz = z*z;
  let sqw = w*w;

  //

  // xyx
  // psi = atan2((q[1] * q[2] + q[3] * q[0]), (q[2] * q[0] - q[1] * q[3]));
  // theta = acos(q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[2] - q[3] * q[0]), (q[1] * q[3] + q[2] * q[0]));

  // xzx
  // psi = atan2((q[1] * q[3] - q[2] * q[0]), (q[1] * q[2] + q[3] * q[0]));
  // theta = acos(q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[3] + q[2] * q[0]), (q[3] * q[0] - q[1] * q[2]));

  // yxy
  // psi = atan2((q[1] * q[2] - q[3] * q[0]), (q[1] * q[0] + q[2] * q[3]));
  // theta = acos(q[0] * q[0] - q[1] * q[1] + q[2] * q[2] - q[3] * q[3]);
  // phi = atan2((q[1] * q[2] + q[3] * q[0]), (q[1] * q[0] - q[2] * q[3]));

//   if( same )
//   {
//
//     // sign = 1;
//     dstv.eSet( 0, atan2( ( x * y + sign * z * w ) , ( y * w - sign * x * z ) ) );
//     dstv.eSet( 1, acos( sqw + sqx - sqy - sqz ) );
//     dstv.eSet( 2, atan2( ( x * y - sign * z * w ) , ( y * w + sign * x * z ) ) );
//
//   }
//   else
//   {
//
//     // let test = ( v.xz1*x*z + v.yw1*y*w );
//     let test = ( x*z - y*w );
//
//     if( test > +half )
//     {
//       xxx
//       dstv.eSet( ox, +2 * Math.atan2( z,w ) );
//       dstv.eSet( oy, +Math.PI / 2 );
//       dstv.eSet( oz, 0 );
//     }
//     else if( test < -half )
//     {
//       yyy
//       dstv.eSet( ox, -2 * Math.atan2( z,w ) );
//       dstv.eSet( oy, -Math.PI / 2 );
//       dstv.eSet( oz, 0 );
//     }
//     else
//     {
//       // dstv.eSet( ox, sign * atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, sign * asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( oz, sign * atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       dstv.eSet( 0, sign * atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       dstv.eSet( 2, sign * atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       // dstv.eSet( 0, atan2( 2 * ( v.xw0 * x * w + v.yz0 * y * z ) , ( v.sqw0*sqw + v.sqx0*sqx + v.sqy0*sqy + v.sqz0*sqz ) ) );
//       // dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( 2, atan2( 2 * ( v.zw2 * z * w + v.xy2 * x * y ) , ( v.sqw2*sqw + v.sqx2*sqx + v.sqy2*sqy + v.sqz2*sqz ) ) );
//
//       // dstv.eSet( 0, atan2( 2 * ( x * w + v.yz0 * y * z ) , ( v.sqw0*sqw + v.sqx0*sqx + v.sqy0*sqy + v.sqz0*sqz ) ) );
//       // dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( 2, atan2( 2 * ( v.zw2 * z * w + v.xy2 * x * y ) , ( v.sqw2*sqw + v.sqx2*sqx + v.sqy2*sqy + v.sqz2*sqz ) ) );
//
// // trivial xyz sample :
// // {
// //   xw0 : 1,
// //   yz0 : -1,
// //   xz1 : 1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : -1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial xzy sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : -1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial zyx sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : -1,
// //   yw1 : 1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
// //
// // trivial zyx sample :
// // {
// //   xw0 : 1,
// //   yz0 : 1,
// //   xz1 : 1,
// //   yw1 : -1,
// //   zw2 : 1,
// //   xy2 : 1,
// //   sqw0 : 1,
// //   sqx0 : -1,
// //   sqy0 : -1,
// //   sqz0 : 1,
// //   sqw2 : 1,
// //   sqx2 : 1,
// //   sqy2 : -1,
// //   sqz2 : -1
// // }
//
//       // let x = quatv.eGet( 0 );
//       // let y = quatv.eGet( 1 );
//       // let z = quatv.eGet( 2 );
//       // let w = quatv.eGet( 3 );
//
//       // dstv.eSet( ox, -sign * atan2( 2 * ( x * w + y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, -asin( clamp( 2 * test, - 1, 1 ) ) );
//       // dstv.eSet( oz, sign * atan2( 2 * ( z * w - x * y ) , ( sqw - sqx - sqy + sqz ) ) );
//
//       // dstv.eSet( ox, atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( x*z + y*w ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//       // dstv.eSet( ox, atan2( 2 * ( z*w - x*y ) , ( sqw + sqx - sqy - sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( x*w - y*z ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( ( sqw - sqx - sqy + sqz ) , 2 * ( x*z + w*y ) ) );
//
//       // /* xzy */
//       //
//       // let sign = 1;
//       // dstv.eSet( ox, atan2( 2 * ( x * w + y * z ) , ( sqw - sqx - sqy + sqz ) ) );
//       // dstv.eSet( oy, asin( clamp( 2 * ( w*y - x*z ), - 1, 1 ) ) );
//       // dstv.eSet( oz, atan2( 2 * ( z * w + x * y ) , ( sqw + sqx - sqy - sqz ) ) );
//
//     }
//
//   }

  // debugger;

  // ex = atan2( ( x * y + z * w ), ( y * w - x * z ) );
  // ey = acos( w * w + x * x - y * y - z * z );
  // ez = atan2( ( x * y - z * w ), ( x * z + y * w ) );

  if( ox === 0 && oy === 1 && oz === 2 ) // xyz
  {
    ex = atan2( 2 * ( x * w - y * z ), ( w * w - x * x - y * y + z * z ) );
    ey = asin( 2 * ( x * z + y * w ) );
    ez = atan2( 2 * ( z * w - x * y ), ( w * w + x * x - y * y - z * z ) );
  }
  else if( ox === 0 && oy === 2 && oz === 1 ) // xzy
  {
    ex = atan2( 2 * ( x * w + y * z ), ( w * w - x * x + y * y - z * z ) );
    ey = asin( 2 * ( z * w - x * y ) );
    ez = atan2( 2 * ( x * z + y * w ), ( w * w + x * x - y * y - z * z ) );
  }
  else if( ox === 1 && oy === 0 && oz === 2 ) // yxz
  {
    ex = atan2( 2 * ( x * z + y * w ), ( w * w - x * x - y * y + z * z ) );
    ey = asin( 2 * ( x * w - y * z ) );
    ez = atan2( 2 * ( x * y + z * w ), ( w * w - x * x + y * y - z * z ) );
  }
  else if( ox === 1 && oy === 2 && oz === 0 ) // yzx
  {
    ex = atan2( 2 * ( y * w - x * z ), ( w * w + x * x - y * y - z * z ) );
    ey = asin( 2 * ( x * y + z * w ) );
    ez = atan2( 2 * ( x * w - z * y ), ( w * w - x * x + y * y - z * z ) );
  }
  else if( ox === 2 && oy === 0 && oz === 1 ) // zxy
  {
    ex = atan2( 2 * ( z * w - x * y ), ( w * w - x * x + y * y - z * z ) );
    ey = asin( 2 * ( x * w + y * z ) );
    ez = atan2( 2 * ( y * w - z * x ), ( w * w - x * x - y * y + z * z ) );
  }
  else if( ox === 2 && oy === 1 && oz === 0 ) // zyx
  {
    ex = atan2( 2 * ( x * y + z * w ), ( w * w + x * x - y * y - z * z ) );
    ey = asin( 2 * ( y * w - x * z ) );
    ez = atan2( 2 * ( x * w + z * y ), ( w * w - x * x - y * y + z * z ) );
  }
  else if( ox === 0 && oy === 1 && oz === 0 ) // xyx
  {
    ex = atan2( ( x * y + z * w ), ( y * w - x * z ) );
    ey = acos( w * w + x * x - y * y - z * z );
    ez = atan2( ( x * y - z * w ), ( x * z + y * w ) );
  }
  else if( ox === 0 && oy === 2 && oz === 0 ) // xzx
  {
    ex = atan2( ( x * z - y * w ), ( x * y + z * w ) );
    ey = acos( w * w + x * x - y * y - z * z );
    ez = atan2( ( x * z + y * w ), ( z * w - x * y ) );
  }
  else if( ox === 1 && oy === 0 && oz === 1 ) // yxy
  {
    ex = atan2( ( x * y - z * w ), ( x * w + y * z ) );
    ey = acos( w * w - x * x + y * y - z * z );
    ez = atan2( ( x * y + z * w ), ( x * w - y * z ) );
  }
  else if( ox === 1 && oy === 2 && oz === 1 ) // yzy
  {
    ex = atan2( ( x * w + y * z ), ( z * w - x * y ) );
    ey = acos( w * w - x * x + y * y - z * z );
    ez = atan2( ( y * z - x * w ), ( x * y + z * w ) );
  }
  else if( ox === 2 && oy === 0 && oz === 2 ) // zxz
  {
    ex = atan2( ( x * z + y * w ), ( x * w - y * z ) );
    ey = acos( w * w - x * x - y * y + z * z );
    ez = atan2( ( x * z - y * w ), ( x * w + y * z ) );
  }
  else if( ox === 2 && oy === 1 && oz === 2 ) // zyz
  {
    ex = atan2( ( y * z - x * w ), ( x * z + y * w ) );
    ey = acos( w * w - x * x - y * y + z * z );
    ez = atan2( ( x * w + y * z ), ( y * w - x * z ) );
  }
  else _.assert( 0,'unexpected euler order',dst );

  dstv.eSet( 0, ex );
  dstv.eSet( 1, ey );
  dstv.eSet( 2, ez );

  // xyz
  //
  //  atan2
  //  (
  //    2 * (q[1] * q[0] - q[2] * q[3]),
  //    (q[0] * q[0] - q[1] * q[1] - q[2] * q[2] + q[3] * q[3])
  //  );
  // theta = asin(2 * ( q[2] * q[0]) + q[1] * q[3] );
  // phi = atan2
  // (
  //    2 * (q[3] * q[0] - q[1] * q[2]),
  //    (q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3])
  // );

  // xzy
  // psi =
  //   atan2
  //   (
  //    2 * (q[1] * q[0] + q[2] * q[3]),
  //    (q[0] * q[0] - q[1] * q[1] + q[2] * q[2] - q[3] * q[3])
  //   );
  // theta = asin(2 * (q[3] * q[0] - q[1] * q[2]));
  // phi = atan2
  // (
  //   2 * (q[1] * q[3] + q[2] * q[0]),
  //   (q[0] * q[0] + q[1] * q[1] - q[2] * q[2] - q[3] * q[3])
  // );

  // // case zyx:

  // (
  //  2*(q.y*q.z + q.w*q.x),
  //  q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
  //  -2*(q.x*q.z - q.w*q.y),
  //  2*(q.x*q.y + q.w*q.z),
  //  q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  // )

  // // case xyz:

  // (
  //   2*( - q.x*q.y + q.w*q.z),
  //   q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  //   2*( - q.y*q.z + q.w*q.x),
  //   q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
  //   +2*(q.x*q.z + q.w*q.y),
  // )
  //

  // // case xzy:

  // (
  //   +2*(q.x*q.z + q.w*q.y),
  //   q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
  //   +2*(q.y*q.z + q.w*q.x),
  //   +q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
  //   -2*(q.x*q.y - q.w*q.z),
  // )

  // void threeaxisrot(double r11, double r12, double r21, double r31, double r32, double res[])
  // {
  //   res[0] = atan2( r31, r32 );
  //   res[1] = asin ( r21 );
  //   res[2] = atan2( r11, r12 );
  // }

  // void threeaxisrot(double r11, double r12, double r21, double r31, double r32, double res[])
  // {
  //   res[0] = atan2( r11, r12 );
  //   res[1] = asin ( r21 );
  //   res[2] = atan2( r31, r32 );
  // }

  // {
  //
  //   let test = ( x * z + y * w );
  //   if( test > +half )
  //   {
  //     xxx
  //     dstv.eSet( 0, +2 * Math.atan2( z,w ) );
  //     dstv.eSet( 1, +Math.PI / 2 );
  //     dstv.eSet( 2, 0 );
  //   }
  //   else if( test < -half )
  //   {
  //     yyy
  //     dstv.eSet( 0, -2 * Math.atan2( z,w ) );
  //     dstv.eSet( 1, -Math.PI / 2 );
  //     dstv.eSet( 2, 0 );
  //   }
  //   else
  //   {
  //     dstv.eSet( 0, atan2( 2 * ( x * w - y * z ) , ( sqw - sqx - sqy + sqz ) ) );
  //     dstv.eSet( 1, asin( clamp( 2 * test, - 1, 1 ) ) );
  //     dstv.eSet( 2, atan2( 2 * ( z * w - x * y ) , ( sqw + sqx - sqy - sqz ) ) );
  //   }
  //
  // }

  return dst;
}

// fromQuat.variates =
// {
//
//   xw0 : [ +1,-1 ],
//   yz0 : [ +1,-1 ],
//   xz1 : [ +1,-1 ],
//   yw1 : [ +1,-1 ],
//   zw2 : [ +1,-1 ],
//   xy2 : [ +1,-1 ],
//
//   sqw0 : [ +1,-1 ],
//   sqx0 : [ +1,-1 ],
//   sqy0 : [ +1,-1 ],
//   sqz0 : [ +1,-1 ],
//
//   sqw2 : [ +1,-1 ],
//   sqx2 : [ +1,-1 ],
//   sqy2 : [ +1,-1 ],
//   sqz2 : [ +1,-1 ],
//
// }

// void quaternion2Euler(const Quaternion& q, double res[], RotSeq rotSeq)
// {
//     switch(rotSeq){
//     case zyx:
//       threeaxisrot( 2*(q.x*q.y + q.w*q.z),
//                      q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                     -2*(q.x*q.z - q.w*q.y),
//                      2*(q.y*q.z + q.w*q.x),
//                      q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                      res);
//       break;
//
//     case zyz:
//       twoaxisrot( 2*(q.y*q.z - q.w*q.x),
//                    2*(q.x*q.z + q.w*q.y),
//                    q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                    2*(q.y*q.z + q.w*q.x),
//                   -2*(q.x*q.z - q.w*q.y),
//                   res);
//       break;
//
//     case zxy:
//       threeaxisrot( -2*(q.x*q.y - q.w*q.z),
//                       q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                       2*(q.y*q.z + q.w*q.x),
//                      -2*(q.x*q.z - q.w*q.y),
//                       q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                       res);
//       break;
//
//     case zxz:
//       twoaxisrot( 2*(q.x*q.z + q.w*q.y),
//                   -2*(q.y*q.z - q.w*q.x),
//                    q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                    2*(q.x*q.z - q.w*q.y),
//                    2*(q.y*q.z + q.w*q.x),
//                    res);
//       break;
//
//     case yxz:
//       threeaxisrot( 2*(q.x*q.z + q.w*q.y),
//                      q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                     -2*(q.y*q.z - q.w*q.x),
//                      2*(q.x*q.y + q.w*q.z),
//                      q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                      res);
//       break;
//
//     case yxy:
//       twoaxisrot( 2*(q.x*q.y - q.w*q.z),
//                    2*(q.y*q.z + q.w*q.x),
//                    q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                    2*(q.x*q.y + q.w*q.z),
//                   -2*(q.y*q.z - q.w*q.x),
//                   res);
//       break;
//
//     case yzx:
//       threeaxisrot( -2*(q.x*q.z - q.w*q.y),
//                       q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                       2*(q.x*q.y + q.w*q.z),
//                      -2*(q.y*q.z - q.w*q.x),
//                       q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                       res);
//       break;
//
//     case yzy:
//       twoaxisrot( 2*(q.y*q.z + q.w*q.x),
//                   -2*(q.x*q.y - q.w*q.z),
//                    q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                    2*(q.y*q.z - q.w*q.x),
//                    2*(q.x*q.y + q.w*q.z),
//                    res);
//       break;
//
//     case xyz:
//       threeaxisrot( -2*(q.y*q.z - q.w*q.x),
//                     q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z,
//                     2*(q.x*q.z + q.w*q.y),
//                    -2*(q.x*q.y - q.w*q.z),
//                     q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                     res);
//       break;
//
//     case xyx:
//       twoaxisrot( 2*(q.x*q.y + q.w*q.z),
//                   -2*(q.x*q.z - q.w*q.y),
//                    q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                    2*(q.x*q.y - q.w*q.z),
//                    2*(q.x*q.z + q.w*q.y),
//                    res);
//       break;
//
//     case xzy:
//       threeaxisrot( 2*(q.y*q.z + q.w*q.x),
//                      q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z,
//                     -2*(q.x*q.y - q.w*q.z),
//                      2*(q.x*q.z + q.w*q.y),
//                      q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                      res);
//       break;
//
//     case xzx:
//       twoaxisrot( 2*(q.x*q.z - q.w*q.y),
//                    2*(q.x*q.y + q.w*q.z),
//                    q.w*q.w + q.x*q.x - q.y*q.y - q.z*q.z,
//                    2*(q.x*q.z + q.w*q.y),
//                   -2*(q.x*q.y - q.w*q.z),
//                   res);
//       break;
//     default:
//       std::cout << "Unknown rotation sequence" << std::endl;
//       break;
//    }
// }

//

function fromMatrix( euler,mat )
{
  let /*eps*/accuracy = 1e-7;
  let one = 1-/*eps*/accuracy;

  euler = _.euler.from( euler );
  let eulerView = _.vector.from( euler );

  let s00 = mat.atomGet([ 0,0 ]), s10 = mat.atomGet([ 1,0 ]), s20 = mat.atomGet([ 2,0 ]);
  let s01 = mat.atomGet([ 0,1 ]), s11 = mat.atomGet([ 1,1 ]), s21 = mat.atomGet([ 2,1 ]);
  let s02 = mat.atomGet([ 0,2 ]), s12 = mat.atomGet([ 1,2 ]), s22 = mat.atomGet([ 2,2 ]);

  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

// m1
// -0.875, 0.250, 0.415,
// 0.250, -0.500, 0.829,
// 0.415, 0.829, 0.375,
// m2
// -0.875, -0.476, 0.086,
// 0.250, -0.292, 0.923,
// -0.415, 0.829, 0.375,

  // debugger; xxx

  eulerView.eSet( 1,asin( clamp( s02, - 1, + 1 ) ) );

  if( abs( /*eps*/accuracy ) < one )
  {
    eulerView.eSet( 0,atan2( - s12, s22 ) );
    eulerView.eSet( 2,atan2( - s01, s00 ) );
    // eulerView.eSet( 0,atan2( s12, s22 ) );
    // eulerView.eSet( 2,atan2( s01, s00 ) );
  }
  else
  {
    bbb
    eulerView.eSet( 0,atan2( s21, s11 ) );
    eulerView.eSet( 2,0 );
  }

// rz*ry*rx
//
// [ cy*cz, cz*sx*sy - cx*sz, sx*sz + cx*cz*sy]
// [ cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx]
// [ -sy,   cy*sx,      cx*cy]
//
// ry*rz*rx
//
// [  cy*cz, sx*sy - cx*cy*sz, cx*sy + cy*sx*sz]
// [         sz,      cx*cz,     -cz*sx]
// [ -cz*sy, cy*sx + cx*sy*sz, cx*cy - sx*sy*sz]
//
// rz*rx*ry
//
// [ cy*cz - sx*sy*sz, -cx*sz, cz*sy + cy*sx*sz]
// [ cy*sz + cz*sx*sy,  cx*cz, sy*sz - cy*cz*sx]
// [     -cx*sy,         sx,      cx*cy]
//
// rx*rz*ry
//
// [      cy*cz,       -sz,      cz*sy]
// [ sx*sy + cx*cy*sz, cx*cz, cx*sy*sz - cy*sx]
// [ cy*sx*sz - cx*sy, cz*sx, cx*cy + sx*sy*sz]
//
// ry*rx*rz
//
// [ cy*cz + sx*sy*sz, cz*sx*sy - cy*sz, cx*sy]
// [      cx*sz,      cx*cz,       -sx]
// [ cy*sx*sz - cz*sy, sy*sz + cy*cz*sx, cx*cy]
//
// rx*ry*rz
//
// [      cy*cz,     -cy*sz,         sy]
// [ cx*sz + cz*sx*sy, cx*cz - sx*sy*sz, -cy*sx]
// [ sx*sz - cx*cz*sy, cz*sx + cx*sy*sz,  cx*cy]
//
// rxz*ry*rx
//
// [  cy,        sx*sy,          cx*sy]
// [  sy*sz, cx*cz - cy*sx*sz, - cz*sx - cx*cy*sz]
// [ -cz*sy, cx*sz + cy*cz*sx,   cx*cy*cz - sx*sz]

  // let sx = sin( x );
  // let sy = sin( y );
  // let sz = sin( z );
  //
  // let cx = cos( x );
  // let cy = cos( y );
  // let cz = cos( z );

  return euler;
}

//

function toMatrix( euler,mat,premutating )
{
  // let /*eps*/accuracy = 1e-9;
  // let half = 0.5-/*eps*/accuracy;

  if( mat === null || mat === undefined )
  mat = _.Space.make([ 3,3 ]);

  euler = _.euler.from( euler );
  let eulerView = _.vector.from( euler );

  if( premutating === undefined )
  premutating = true;

  _.assert( _.euler.is( euler ) );
  _.assert( _.Space.is( mat ) );
  _.assert( mat.dims[ 0 ] >= 3 );
  _.assert( mat.dims[ 1 ] >= 3 );
  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );

  // debugger;

  let ox = eulerView.eGet( 3 );
  let oy = eulerView.eGet( 4 );
  let oz = eulerView.eGet( 5 );

  // let ox = 0;
  // let oy = 1;
  // let oz = 2;

  let x = eulerView.eGet( ox );
  let y = eulerView.eGet( oy );
  let z = eulerView.eGet( oz );

  let sign = ( ( ox !== 0 ) + ( oy !== 1 ) + ( oz !== 2 ) ) === 2;
  sign = sign ? -1 : + 1;
  // console.log( 'sign',sign );

  // let sx = ( ox === 0 && sign === 1 ) ? sin( x ) : cos( x );
  let sx = sin( x );
  let sy = sin( y );
  let sz = sin( z );

  // let cx = ( ox === 0 && sign === 1 ) ? cos( x ) : sin( x );
  let cx = cos( x );
  let cy = cos( y );
  let cz = cos( z );

  let cx_sy = cx*sy;
  let sx_sy = sx*sy;
  let cx_sz = cx*sz;
  let sx_sz = sx*sz;
  let cx_cy = cx*cy;
  let sx_cy = sx*cy;
  let cx_cz = cx*cz;
  let sx_cz = sx*cz;
  let cy_sz = cy*sz;
  let sy_sz = sy*sz;
  let cy_cz = cy*cz;
  let sy_cz = sy*cz;

  let m00,m01,m02;
  let m10,m11,m12;
  let m20,m21,m22;

  if( premutating )
  {

    mat.atomSet( [ 0,0 ],+cy_cz );
    mat.atomSet( [ 1,0 ],+cy_sz*sign );
    mat.atomSet( [ 2,0 ],-sy*sign );

    mat.atomSet( [ 0,1 ],+( +sx_sy*cz - cx_sz*sign ) );
    mat.atomSet( [ 1,1 ],+cx_cz + sx_sy*sz*sign );
    mat.atomSet( [ 2,1 ],+sx_cy*sign );

    mat.atomSet( [ 0,2 ],+sx_sz + cx_sy*cz*sign );
    mat.atomSet( [ 1,2 ],+( +cx_sy*sz - sx_cz*sign ) );
    mat.atomSet( [ 2,2 ],+cx_cy );

  }
  else
  {

    mat.atomSet( [ ox,ox ],+cy_cz );
    mat.atomSet( [ oy,ox ],-cy_sz*sign );
    mat.atomSet( [ oz,ox ],sy*sign );

    mat.atomSet( [ ox,oy ],+( +sx_sy*cz + cx_sz*sign ) );
    mat.atomSet( [ oy,oy ],+cx_cz - sx_sy*sz*sign );
    mat.atomSet( [ oz,oy ],-sx_cy*sign );

    mat.atomSet( [ ox,oz ],+sx_sz - cx_sy*cz*sign );
    mat.atomSet( [ oy,oz ],+( +cx_sy*sz + sx_cz*sign ) );
    mat.atomSet( [ oz,oz ],+cx_cy );

    // /* */
    //
    // mat.atomSet( [ 0,0 ],+cy_cz );
    // mat.atomSet( [ 1,0 ],-cy_sz*sign );
    // mat.atomSet( [ 2,0 ],sy*sign );
    //
    // mat.atomSet( [ 0,1 ],+( +sx_sy*cz + cx_sz*sign ) );
    // mat.atomSet( [ 1,1 ],+cx_cz - sx_sy*sz*sign );
    // mat.atomSet( [ 2,1 ],-sx_cy*sign );
    //
    // mat.atomSet( [ 0,2 ],+sx_sz - cx_sy*cz*sign );
    // mat.atomSet( [ 1,2 ],+( +cx_sy*sz + sx_cz*sign ) );
    // mat.atomSet( [ 2,2 ],+cx_cy );

  }

  mat.atomSet( [ 0,0 ],+cy_cz );
  mat.atomSet( [ 1,0 ],-cy_sz*sign );
  mat.atomSet( [ 2,0 ],sy*sign );

  mat.atomSet( [ 0,1 ],+( +sx_sy*cz + cx_sz*sign ) );
  mat.atomSet( [ 1,1 ],+cx_cz - sx_sy*sz*sign );
  mat.atomSet( [ 2,1 ],-sx_cy*sign );

  mat.atomSet( [ 0,2 ],+sx_sz - cx_sy*cz*sign );
  mat.atomSet( [ 1,2 ],+( +cx_sy*sz + sx_cz*sign ) );
  mat.atomSet( [ 2,2 ],+cx_cy );

  // debugger;

// rx*ry*rz
//
// | cx*cy    cx*sy*sz - sx*cz    cx*sy*cz + sx*sz |
// | sx*cy    sx*sy*sz + cx*cz    sx*sy*cz - cx*sz |
// | -sy                 cy*sz               cy*cz |
//

  // if( ox === 0 && oy === 1 && oz === 2 ) /* xyz */
  // {
  //
  //   let m00 = +cy_cz;
  //   let m10 = +cy_sz;
  //   let m20 = -sy;
  //
  //   let m01 = +sx_sy*cz - cx_sz;
  //   let m11 = +cx_cz + sx_sy*sz;
  //   let m21 = +sx_cy;
  //
  //   let m02 = +sx_sz + cx_sy*cz;
  //   let m12 = +cx_sy*sz - sx_cz;
  //   let m22 = +cx_cy;
  //
  // }
  // else if( ox === 0 && oy === 2 && oz === 1 ) /* xzy */
  // {
  //
    // let m00 = +cy_cz;
    // let m10 = +sz;
    // let m20 = -sy_cz;
    //
    // let m01 = +sx_sy - cx_cy*sz;
    // let m11 = +cx_cz;
    // let m21 = +sx_cy + cx_sy*sz;
    //
    // let m02 = +cx_sy + sx_cy*sz;
    // let m12 = -sx_cz;
    // let m22 = +cx_cy - sx_sy*sz;
  //
  // }
  // else _.assert( 0 );
  //
  // /* */
  //
  // mat.atomSet( [ 0,0 ],m00 );
  // mat.atomSet( [ 1,0 ],m10 );
  // mat.atomSet( [ 2,0 ],m20 );
  //
  // mat.atomSet( [ 0,1 ],m01 );
  // mat.atomSet( [ 1,1 ],m11 );
  // mat.atomSet( [ 2,1 ],m21 );
  //
  // mat.atomSet( [ 0,2 ],m02 );
  // mat.atomSet( [ 1,2 ],m12 );
  // mat.atomSet( [ 2,2 ],m22 );

// rz*ry*rx
//
// [ cy*cz, cz*sx*sy - cx*sz, sx*sz + cx*cz*sy]
// [ cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx]
// [ -sy,   cy*sx,      cx*cy]
//
// ry*rz*rx
//
// [  cy*cz, sx*sy - cx*cy*sz, cx*sy + cy*sx*sz]
// [         sz,      cx*cz,     -cz*sx]
// [ -cz*sy, cy*sx + cx*sy*sz, cx*cy - sx*sy*sz]
//
// rz*rx*ry
//
// [ cy*cz - sx*sy*sz, -cx*sz, cz*sy + cy*sx*sz]
// [ cy*sz + cz*sx*sy,  cx*cz, sy*sz - cy*cz*sx]
// [     -cx*sy,         sx,      cx*cy]
//
// rx*rz*ry
//
// [      cy*cz,       -sz,      cz*sy]
// [ sx*sy + cx*cy*sz, cx*cz, cx*sy*sz - cy*sx]
// [ cy*sx*sz - cx*sy, cz*sx, cx*cy + sx*sy*sz]
//
// ry*rx*rz
//
// [ cy*cz + sx*sy*sz, cz*sx*sy - cy*sz, cx*sy]
// [      cx*sz,      cx*cz,       -sx]
// [ cy*sx*sz - cz*sy, sy*sz + cy*cz*sx, cx*cy]
//
// rx*ry*rz
//
// [      cy*cz,     -cy*sz,         sy]
// [ cx*sz + cz*sx*sy, cx*cz - sx*sy*sz, -cy*sx]
// [ sx*sz - cx*cz*sy, cz*sx + cx*sy*sz,  cx*cy]
//
// | cx*cy    cx*sy*sz - sx*cz    cx*sy*cz + sx*sz |
// | sx*cy    sx*sy*sz + cx*cz    sx*sy*cz - cx*sz |
// | -sy                  cy*sz              cy*cz |
//
// [ cy*cx, cx*sz*sy - cz*sx, sz*sx + cz*cx*sy ]
// [ cy*sx, cz*cx + sz*sy*sx, cz*sy*sx - cx*sz ]
// [ -sy,   cy*sz,            cz*cy ]

// rxz*ry*rx
//
// [  cy,        sx*sy,          cx*sy]
// [  sy*sz, cx*cz - cy*sx*sz, - cz*sx - cx*cy*sz]
// [ -cz*sy, cx*sz + cy*cz*sx,   cx*cy*cz - sx*sz]

  return mat;
}

// --
// let
// --

let Order =
{

  'xyz' : [ 0,1,2 ],
  'xzy' : [ 0,2,1 ],
  'yxz' : [ 1,0,2 ],
  'yzx' : [ 1,2,0 ],
  'zxy' : [ 2,0,1 ],
  'zyx' : [ 2,1,0 ],

}


/**
  * Create a set of euler angles from a quaternion. Returns the created euler angles.
  * Quaternion stay untouched, dst contains the euler angle representation.
  *
  * @param { Array } dstEuler - Destination representation of Euler angles with source euler angles code.
  * @param { Array } srcQuat - Source quaternion.
  *
  * @example
  * // returns [ 1, 0, 0, 0, 1, 2 ];
  * _.fromQuat2( [ 0.49794255, 0, 0, 0.8775826 ], [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0, 1, 0, 2, 1, 0 ];
  * _.fromQuat2( [ 0, 0.4794255, 0, 0.8775826 ], [ 0, 0, 0, 2, 1, 0 ] );
  *
  * @returns { Quat } Returns the corresponding quaternion.
  * @function fromQuat2
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( srcQuat ) is not quat.
  * @throws { Error } An Error if( dstEuler ) is not euler ( or null/undefined ).
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function fromQuat2( dstEuler, srcQuat )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dstEuler === undefined || dstEuler === null || _.euler.is( dstEuler ) );

  if( dstEuler === undefined || dstEuler === null )
  dstEuler = _.euler.makeZero();

  dstEuler = _.euler.from( dstEuler );
  let dstEulerView = _.euler._from( dstEuler );
  let srcQuatVector = _.quat._from( srcQuat );
  let accuracy =  _.accuracy;
  let accuracySqr = _.accuracySqr;

  let x = srcQuatVector.eGet( 0 ); let x2 = x*x;
  let y = srcQuatVector.eGet( 1 ); let y2 = y*y;
  let z = srcQuatVector.eGet( 2 ); let z2 = z*z;
  let w = srcQuatVector.eGet( 3 ); let w2 = w*w;

  let xy2 = 2*x*y; let xz2 = 2*x*z; let xw2 = 2*x*w;
  let yz2 = 2*y*z; let yw2 = 2*y*w; let zw2 = 2*z*w;

  let ox = dstEulerView.eGet( 3 );
  let oy = dstEulerView.eGet( 4 );
  let oz = dstEulerView.eGet( 5 );

  let lim;
  if( ox === 0 && oy === 1 && oz === 2 )
  {
    lim = xz2 + yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( -( xy2 - zw2 ) , w2  + x2 - z2 - y2 ) );
      dstEulerView.eSet( 1, asin( lim ) );
      dstEulerView.eSet( 0, atan2( - ( yz2 - xw2 ) , z2 - y2 - x2 + w2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerView.eSet( 0, - atan2( ( xy2 + zw2 ), ( xz2 - yw2 ) ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerView.eSet( 0, - atan2( -1*( xy2 + zw2 ), -1*( xz2 - yw2 ) ) );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    lim = xy2 - zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( xz2 + yw2 , x2 + w2 - z2 - y2 ) );
      dstEulerView.eSet( 1, - asin( lim ) );
      dstEulerView.eSet( 0, atan2( yz2 + xw2 , y2 - z2 + w2 - x2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerView.eSet( 0, atan2( (xz2 - yw2 ), ( xy2 + zw2 ) ) );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerView.eSet( 0, atan2( -1*( yz2 - xw2 ), 1-2*( x2 + y2 ) ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    lim = yz2 - xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( xy2 + zw2 , y2 - z2 + w2 - x2 ) );
      dstEulerView.eSet( 1, - asin( lim ) );
      dstEulerView.eSet( 0, atan2( xz2 + yw2 , z2 - y2 - x2 + w2 ) );
    }
    else if( lim <= -1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerView.eSet( 0, atan2( ( xy2 - zw2 ), ( yz2 + xw2 ) ) );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z = 0. ');
      dstEulerView.eSet( 0, atan2( -1*( xz2 - yw2 ), 1-2*( y2 + z2 ) ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    lim = xy2 + zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( - yz2 + xw2 , y2 - z2 + w2 - x2 ) );
      dstEulerView.eSet( 1, asin( lim ) );
      dstEulerView.eSet( 0, atan2( - xz2 + yw2 , x2 + w2 - z2 - y2  ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerView.eSet( 0, atan2( (xz2 + yw2 ), ( xy2 - zw2 ) ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( ( xy2 + zw2 ) >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerView.eSet( 0, atan2( xz2 + yw2, 1-2*( x2 + y2 ) ) );
      dstEulerView.eSet( 1, + pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    lim = yz2 + xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( - xz2 + yw2 , z2 - y2 - x2 + w2  ) );
      dstEulerView.eSet( 1, asin( lim ) );
      dstEulerView.eSet( 0, atan2( - xy2 + zw2 , y2 - z2 + w2 - x2  ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerView.eSet( 0, atan2( ( xy2 + zw2 ), ( yz2 - xw2 ) ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y = 0. ');
      dstEulerView.eSet( 0, atan2( xy2 + zw2, 1-2*( y2 + z2 ) ) );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    lim = xz2 - yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( yz2 + xw2 , z2 - y2 - x2 + w2 ) );
      dstEulerView.eSet( 1, asin( - lim ) );
      dstEulerView.eSet( 0, atan2( xy2 + zw2 , x2 + w2 - y2 - z2 ) );
    }
    else if( lim <= - 1 + accuracy*accuracy )
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerView.eSet( 0, - atan2( ( xy2 - zw2 ), ( xz2 + yw2 ) ) );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracy*accuracy)
    {
      // console.log('Indeterminate; We set angle x = 0. ');
      dstEulerView.eSet( 0, atan2( -1*( xy2 - zw2 ), -1*( xz2 + yw2 ) ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( xy2 - zw2 , xz2 + yw2 ) );
      dstEulerView.eSet( 1, acos( lim ) );
      dstEulerView.eSet( 0, atan2( xy2 + zw2 , -xz2 + yw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( yz2 - xw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( yz2 + xw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr)
    {
      dstEulerView.eSet( 2, atan2( xz2 + yw2 , -xy2 + zw2 ) );
      dstEulerView.eSet( 1, acos( lim ) );
      dstEulerView.eSet( 0, atan2( xz2 - yw2 , xy2 + zw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerView.eSet( 0, - atan2( ( yz2 + xw2 ), 1 - 2*( x2 + y2 ) ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle x2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( yz2 + xw2 ), 1 - 2*( x2 + y2 ) ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( xy2 + zw2 , -yz2 + xw2 ) );
      dstEulerView.eSet( 1, acos( lim ) );
      dstEulerView.eSet( 0, atan2( xy2 - zw2 , yz2 + xw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerView.eSet( 0, - atan2( ( xz2 - yw2 ), 1 - 2*( z2 + y2 ) ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( xz2 + yw2 ), 1 - 2*( z2 + y2 ) ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( yz2 - xw2 , xy2 + zw2 ) );
      dstEulerView.eSet( 1, acos( lim ) );
      dstEulerView.eSet( 0, atan2( yz2 + xw2 , -xy2 + zw2 ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( xz2 - yw2 ), 1 - 2*( y2 + x2 ) ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle y2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( xz2 + yw2 ), 1 - 2*( y2 + x2 ) ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( ( xz2 - yw2 ), ( yz2 + xw2 ) ) );
      dstEulerView.eSet( 1, acos( lim ) );
      dstEulerView.eSet( 0, atan2( ( xz2 + yw2 ), - ( yz2 - xw2 ) ) );
    }
    else if( lim <= - 1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( xy2 - zw2 ), 1 - 2*( y2 + z2 ) ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 - accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerView.eSet( 0, - atan2( ( xy2 - zw2 ), 1 - 2*( y2 + z2 ) ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      dstEulerView.eSet( 2, atan2( ( yz2 + xw2 ), ( - xz2 + yw2 ) ) );
      dstEulerView.eSet( 1, acos( lim ) );
      dstEulerView.eSet( 0, atan2( ( yz2 - xw2 ), ( xz2 + yw2 ) ) );
    }
    else if( lim <= -1 + accuracySqr )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerView.eSet( 0, atan2( -( xy2 - zw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( lim >= 1 )
    {
      // console.log('Indeterminate; We set angle z2 = 0. ');
      dstEulerView.eSet( 0, atan2( ( xy2 + zw2 ), 1 - 2*( x2 + z2 ) ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  /* */

  return dstEuler;
}

//

/**
  * Create the quaternion from a set of euler angles. Returns the created quaternion.
  * Euler angles stay untouched.
  *
  * @param { Array } srcEuler - Source representation of Euler angles.
  * @param { Array } dstQuat - Destination quaternion array.
  *
  * @example
  * // returns [ 0.49794255, 0, 0, 0.8775826 ];
  * _.toQuat2( [ 1, 0, 0, 0, 1, 2 ], null );
  *
  * @example
  * // returns [ 0, 0.4794255, 0, 0.8775826 ];
  * _.toQuat2( [ 0, 1, 0, 2, 1, 0 ], null );
  *
  * @returns { Quat } Returns the corresponding quaternion.
  * @function toQuat2
  * @throws { Error } An Error if( arguments.length ) is different than one.
  * @throws { Error } An Error if( srcEuler ) is not euler.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function toQuat2( srcEuler, dstQuat )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.euler.is( srcEuler ) );
  _.assert( dstQuat === undefined || dstQuat === null || _.quat.is( dstQuat ) );

  if( dstQuat === undefined || dstQuat === null )
  dstQuat = _.quat.makeUnit();

  srcEuler = _.euler.from( srcEuler );
  let srcEulerView = _.euler._from( srcEuler );
  dstQuat = _.quat.from( dstQuat );
  let dstQuatVector = _.quat._from( dstQuat );

  let e0 = srcEulerView.eGet( 0 );
  let e1 = srcEulerView.eGet( 1 );
  let e2 = srcEulerView.eGet( 2 );
  let ox = srcEulerView.eGet( 3 );
  let oy = srcEulerView.eGet( 4 );
  let oz = srcEulerView.eGet( 5 );

  let s0 = sin( e0/2 ); let c0 = cos( e0/2 );
  let s1 = sin( e1/2 ); let c1 = cos( e1/2 );
  let s2 = sin( e2/2 ); let c2 = cos( e2/2 );

  /* qqq : not optimal */
  let sum, dif;
  if( ox === 0 && oy === 1 && oz === 2 )
  {
    dstQuatVector.eSet( 0, s0*c1*c2 + c0*s1*s2 );
    dstQuatVector.eSet( 1, c0*s1*c2 - s0*c1*s2 );
    dstQuatVector.eSet( 2, c0*c1*s2 + s0*s1*c2 );
    dstQuatVector.eSet( 3, c0*c1*c2 - s0*s1*s2 );
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    dstQuatVector.eSet( 0, s0*c1*c2 - c0*s1*s2 );
    dstQuatVector.eSet( 1, c0*c1*s2 - s0*s1*c2 );
    dstQuatVector.eSet( 2, c0*s1*c2 + s0*c1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 + s0*s1*s2 );
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    sum = ( e0 + e2 )/2;
    dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, sin( sum )*c1 );
    dstQuatVector.eSet( 1, cos( dif )*s1 );
    dstQuatVector.eSet( 2, sin( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    sum = ( e0 + e2 )/2;
    dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, sin( sum )*c1 );
    dstQuatVector.eSet( 1, - sin( dif )*s1 );
    dstQuatVector.eSet( 2, cos( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    dstQuatVector.eSet( 0, c0*s1*c2 + s0*c1*s2 );
    dstQuatVector.eSet( 1, s0*c1*c2 - c0*s1*s2 );
    dstQuatVector.eSet( 2, c0*c1*s2 - s0*s1*c2 );
    dstQuatVector.eSet( 3, c0*c1*c2 + s0*s1*s2 );
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    dstQuatVector.eSet( 0, c0*c1*s2 + s0*s1*c2 );
    dstQuatVector.eSet( 1, s0*c1*c2 + c0*s1*s2 );
    dstQuatVector.eSet( 2, c0*s1*c2 - s0*c1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 - s0*s1*s2 );
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    sum = ( e0 + e2 )/2;
    dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, cos( dif )*s1 );
    dstQuatVector.eSet( 1, sin( sum )*c1 );
    dstQuatVector.eSet( 2, - sin( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    sum = ( e0 + e2 )/2;
    dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, sin( dif )*s1 );
    dstQuatVector.eSet( 1, sin( sum )*c1 );
    dstQuatVector.eSet( 2, cos( dif )*s1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    dstQuatVector.eSet( 0, c0*c1*s2 - s0*s1*c2 );
    dstQuatVector.eSet( 1, c0*s1*c2 + s0*c1*s2 );
    dstQuatVector.eSet( 2, s0*c1*c2 - c0*s1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 + s0*s1*s2 );
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    dstQuatVector.eSet( 0, c0*s1*c2 - s0*c1*s2 );
    dstQuatVector.eSet( 1, c0*c1*s2 + s0*s1*c2 );
    dstQuatVector.eSet( 2, s0*c1*c2 + c0*s1*s2 );
    dstQuatVector.eSet( 3, c0*c1*c2 - s0*s1*s2 );
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    sum = ( e0 + e2 )/2;
    dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, cos( dif )*s1 );
    dstQuatVector.eSet( 1, sin( dif )*s1 );
    dstQuatVector.eSet( 2, sin( sum )*c1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    sum = ( e0 + e2 )/2;
    dif = ( e0 - e2 )/2;

    dstQuatVector.eSet( 0, - sin( dif )*s1 );
    dstQuatVector.eSet( 1, cos( dif )*s1 );
    dstQuatVector.eSet( 2, sin( sum )*c1 );
    dstQuatVector.eSet( 3, cos( sum )*c1 );
  }
  else _.assert( 0 );

  return dstQuat;
}

//

/**
  * Create the euler angle from a rotation matrix. Returns the created euler angle.
  * Rotation matrix stays untouched.
  *
  * @param { Array } dstEuler - Destination array with euler angle source code.
  * @param { Space } srcMatrix - Source rotation matrix.
  *
  * @example
  * // returns [ 0.5, 0.5, 0.5, 0, 1, 2 ]
  *  srcMatrix  = _.Space.make( [ 3, 3 ] ).copy(
  *            [ 0.7701, -0.4207, 0.4794,
  *             0.6224, 0.6599, - 0.4207,
  *           - 0.1393, 0.6224, 0.7701 ] );
  * _.fromMatrix2( srcMatrix, [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @returns { Array } Returns the corresponding euler angles.
  * @function fromMatrix2
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( dstEuler ) is not euler.
  * @throws { Error } An Error if( srcMatrix ) is not matrix.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function fromMatrix2( dstEuler, srcMatrix )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( dstEuler === undefined || dstEuler === null || _.euler.is( dstEuler ) );

  if( dstEuler === undefined || dstEuler === null )
  dstEuler = _.euler.makeZero();

  dstEuler = _.euler.from( dstEuler );
  let dstEulerView = _.vector.from( dstEuler );

  _.assert( _.Space.is( srcMatrix ) );
  _.assert( srcMatrix.dims[ 0 ] >= 3 );
  _.assert( srcMatrix.dims[ 1 ] >= 3 );

  let ox = dstEulerView.eGet( 3 );
  let oy = dstEulerView.eGet( 4 );
  let oz = dstEulerView.eGet( 5 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    let m02 = srcMatrix.atomGet( [ 0, 2 ] );
    if( - 1 < m02 && m02 < 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerView.eSet( 0, atan2( - m12, m22 ) );
      dstEulerView.eSet( 1, atan2( m02, sqrt( 1 - m02*m02 ) ) );
      dstEulerView.eSet( 2, atan2( - m01, m00 ) );
    }
    else if( m02 <= - 1 )
    {
      let m10 = srcMatrix.atomGet( [ 1, 0 ] ); let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 0, - atan2( m10, m11 ) );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m02 >= 1 )
    {
      let m10 = srcMatrix.atomGet( [ 1, 0 ] ); let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 0, atan2( m10, m11 ) );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    let m01 = srcMatrix.atomGet( [ 0,1 ] );
    if( - 1 < m01 && m01 < 1 )
    {
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 0, atan2( m21, m11 ) );
      dstEulerView.eSet( 2, atan2( m02, m00 ) );
      dstEulerView.eSet( 1, asin( - m01) );
    }
    else if( m01 >= 1 )
    {
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 0, atan2( - m20, m22 ) );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 1, - pi/2 );
    }
    else if( m01 <= - 1 )
    {
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 0, - atan2( - m20, m22 ) );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 1, pi/2 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    let m12 = srcMatrix.atomGet( [ 1, 2 ] );
    if( - 1 < m12 && m12 < 1 )
    {
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 1, asin( -m12 ) );
      dstEulerView.eSet( 0, atan2( m02, m22 ) );
      dstEulerView.eSet( 2, atan2( m10, m11 ) );
    }
    else if( m12 >= 1 )
    {
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 0, atan2( - m01, m00 ) );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m12 <= - 1 )
    {
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerView.eSet( 1, pi/2);
      dstEulerView.eSet( 0, - atan2( - m01, m00 )  );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    let m10 = srcMatrix.atomGet( [ 1, 0 ] );
    if( - 1 < m10 && m10 < 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 2, atan2( - m12, m11 ) );
      dstEulerView.eSet( 0, atan2( - m20, m00 ) );
      dstEulerView.eSet( 1, asin( m10 ) );
    }
    else if( m10 <= - 1 )
    {
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 0, - atan2( m21, m22 ) );
      dstEulerView.eSet( 1, - pi/2 );
    }
    else if( m10 >= 1 )
    {
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 0, atan2( m21, m22 )  );
      dstEulerView.eSet( 1, pi/2 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    let m21 = srcMatrix.atomGet( [ 2, 1 ] );
    if( - 1 < m21 && m21 < 1 )
    {
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 1, asin( m21 ) );
      dstEulerView.eSet( 2, atan2( - m20, m22 ) );
      dstEulerView.eSet( 0, atan2( - m01, m11 ) );
    }
    else if( m21 <= - 1 )
    {
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 0, - atan2( m02, m00 ) );
    }
    else if( m21 >= 1 )
    {
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 0, atan2( m02, m00 ) );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    let m20 = srcMatrix.atomGet( [ 2, 0 ] );
    if( - 1 < m20 && m20 < 1 )
    {
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 2, atan2( m21, m22 ) );
      dstEulerView.eSet( 1, asin( - m20 ) );
      dstEulerView.eSet( 0, atan2( m10, m00 ) );
    }
    else if( m20 <= - 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 1, pi/2 );
      dstEulerView.eSet( 0, - atan2( - m12, m11 ) );
    }
    else if( m20 >= 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 2, 0 );
      dstEulerView.eSet( 1, - pi/2 );
      dstEulerView.eSet( 0, atan2( - m12, m11 ) );
    }
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    let m00 = srcMatrix.atomGet( [ 0, 0 ] );
    if( - 1 < m00 && m00 < 1 )
    {
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      dstEulerView.eSet( 0, atan2( m10, - m20 ) );
      dstEulerView.eSet( 1, acos( m00 ) );
      dstEulerView.eSet( 2, atan2( m01, m02 ) );
    }
    else if( m00 <= - 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 0, - atan2( - m12, m11 ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m00 >= 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 0, atan2( - m12, m11 ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    let m00 = srcMatrix.atomGet( [ 0, 0 ] );
    if( - 1 < m00 && m00 < 1 )
    {
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      dstEulerView.eSet( 0, atan2( m20, m10 ) );
      dstEulerView.eSet( 1, acos( m00 ) );
      dstEulerView.eSet( 2, atan2( m02, - m01 ) );
    }
    else if( m00 <= - 1 )
    {
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 0, - atan2( m21, m22 ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m00 >= 1 )
    {
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 0, atan2( m21, m22 ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    let m11 = srcMatrix.atomGet( [ 1, 1 ] );
    if( - 1 < m11 && m11 < 1 )
    {
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      dstEulerView.eSet( 0, atan2( m01, m21 ) );
      dstEulerView.eSet( 1, acos( m11 ) );
      dstEulerView.eSet( 2, atan2( m10, - m12 ) );
    }
    else if( m11 <= - 1 )
    {
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 0, - atan2( m02, m00 ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m11 >= 1 )
    {
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 0, atan2( m02, m00 ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    let m11 = srcMatrix.atomGet( [ 1, 1 ] );
    if( - 1 < m11 && m11 < 1 )
    {
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      dstEulerView.eSet( 0, atan2( m21, - m01 ) );
      dstEulerView.eSet( 1, acos( m11 ) );
      dstEulerView.eSet( 2, atan2( m12, m10 ) );
    }
    else if( m11 <= - 1 )
    {
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 0, atan2( m20, m22 ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m11 >= 1 )
    {
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m22 = srcMatrix.atomGet( [ 2, 2 ] );
      dstEulerView.eSet( 0, atan2( - m20, m22 ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    let m22 = srcMatrix.atomGet( [ 2, 2 ] );
    if( - 1 < m22 && m22 < 1 )
    {
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      dstEulerView.eSet( 0, atan2( m02, - m12 ) );
      dstEulerView.eSet( 1, acos( m22 ) );
      dstEulerView.eSet( 2, atan2( m20, m21 ) );
    }
    else if( m22 <= - 1 )
    {
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 0, atan2( m01, m00 ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m22 >= 1 )
    {
      let m01 = srcMatrix.atomGet( [ 0, 1 ] );
      let m00 = srcMatrix.atomGet( [ 0, 0 ] );
      dstEulerView.eSet( 0, - atan2( m01, m00 ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    let m22 = srcMatrix.atomGet( [ 2, 2 ] );
    if( - 1 < m22 && m22 < 1 )
    {
      let m12 = srcMatrix.atomGet( [ 1, 2 ] );
      let m02 = srcMatrix.atomGet( [ 0, 2 ] );
      let m21 = srcMatrix.atomGet( [ 2, 1 ] );
      let m20 = srcMatrix.atomGet( [ 2, 0 ] );
      dstEulerView.eSet( 0, atan2( m12, m02 ) );
      dstEulerView.eSet( 1, acos( m22 ) );
      dstEulerView.eSet( 2, atan2( m21, - m20 ) );
    }
    else if( m22 <= - 1 )
    {
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 0, - atan2( m10, m11 ) );
      dstEulerView.eSet( 1, pi );
      dstEulerView.eSet( 2, 0 );
    }
    else if( m22 >= 1 )
    {
      let m10 = srcMatrix.atomGet( [ 1, 0 ] );
      let m11 = srcMatrix.atomGet( [ 1, 1 ] );
      dstEulerView.eSet( 0, atan2( m10, m11 ) );
      dstEulerView.eSet( 1, 0 );
      dstEulerView.eSet( 2, 0 );
    }
  }

  return dstEuler;
}

//

function fromMatrix3( dstEuler, srcMatrix )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.euler.is( dstEuler ) );

  _.assert( _.Space.is( srcMatrix ) );
  _.assert( srcMatrix.dims[ 0 ] >= 3 );
  _.assert( srcMatrix.dims[ 1 ] >= 3 );

  let quat = _.quat.fromMatrixRotation( [ 0, 0, 0, 0 ], srcMatrix );

  dstEuler = _.euler.fromQuat2( dstEuler, quat );

  return dstEuler;
}

//

/**
  * Create the rotation matrix from a set of euler angles. Returns the created matrix.
  * Euler angles stay untouched.
  *
  * @param { Array } srcEuler - Source representation of Euler angles.
  * @param { Space } dstMatrix - Destination matrix.
  *
  * @example
  * // returns [ 0.7701, -0.4207, 0.4794,
  *              0.6224, 0.6599, - 0.4207,
  *              - 0.1393, 0.6224, 0.7701 ];
  * _.toMatrix2( null, [ 0.5, 0.5, 0.5, 0, 1, 2 ] );
  *
  * @example
  * // returns [ 0.4741, - 0.6142, 0.6307,
  * //           0.7384, 0.6675, 0.0950,
  * //           - 0.4794, 0.4207, 0.7701 ]
  * _.toMatrix2( null, [ 1, 0.5, 0.5, 2, 1, 0 ] );
  *
  * @returns { Space } Returns the corresponding rotation matrix.
  * @function toMatrix2
  * @throws { Error } An Error if( arguments.length ) is different than one.
  * @throws { Error } An Error if( srcEuler ) is not euler.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

/* qqq : make similar to other converters */
/* qqq : because of name dstMatrix should be the second argument */

function toMatrix2( srcEuler, dstMatrix )
{

  srcEuler = _.euler.from( srcEuler );
  let srcEulerView = _.vector.from( srcEuler );

  _.assert( _.Space.is( dstMatrix ) || dstMatrix === null || dstMatrix === undefined );
  if( dstMatrix === null || dstMatrix === undefined )
  dstMatrix = _.Space.makeZero( [ 3, 3 ] );

  _.assert( dstMatrix.dims[ 0 ] === 3 );
  _.assert( dstMatrix.dims[ 1 ] === 3 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let e1 = srcEulerView.eGet( 0 );
  let e2 = srcEulerView.eGet( 1 );
  let e3 = srcEulerView.eGet( 2 );
  let ox = srcEulerView.eGet( 3 );
  let oy = srcEulerView.eGet( 4 );
  let oz = srcEulerView.eGet( 5 );

  let ce1 = cos( e1 );
  let ce2 = cos( e2 );
  let ce3 = cos( e3 );
  let se1 = sin( e1 );
  let se2 = sin( e2 );
  let se3 = sin( e3 );

  if( ox === 0 && oy === 1 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - ce2*se3 );
    dstMatrix.atomSet( [ 0, 2 ], se2 );
    dstMatrix.atomSet( [ 1, 0 ], se1*se2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 1 ], -se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], -se1*ce2 );
    dstMatrix.atomSet( [ 2, 0 ], -ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 2, 1 ], ce1*se2*se3+ se1*ce3 );
    dstMatrix.atomSet( [ 2, 2 ], ce1*ce2 );
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - se2 );
    dstMatrix.atomSet( [ 0, 2 ], ce2*se3 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2 );
    dstMatrix.atomSet( [ 1, 2 ], ce1*se2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], se1*se2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se1*ce2 );
    dstMatrix.atomSet( [ 2, 2 ], se1*se2*se3 + ce1*ce3 );
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], se1*se2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 0, 2 ], se1*ce2 );
    dstMatrix.atomSet( [ 1, 0 ], ce2*se3 );
    dstMatrix.atomSet( [ 1, 1 ], ce2*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], -se2 );
    dstMatrix.atomSet( [ 2, 0 ], ce1*se2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 1 ], ce1*se2*ce3+ se1*se3 );
    dstMatrix.atomSet( [ 2, 2 ], ce1*ce2 );
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2 );
    dstMatrix.atomSet( [ 0, 1 ], - ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*se2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 0 ], se2 );
    dstMatrix.atomSet( [ 1, 1 ], ce2*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce2*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - se1*ce2 );
    dstMatrix.atomSet( [ 2, 1 ], se1*se2*ce3+ ce1*se3 );
    dstMatrix.atomSet( [ 2, 2 ], - se1*se2*se3 + ce1*ce3 );
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], - se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - se1*ce2 );
    dstMatrix.atomSet( [ 0, 2 ], se1*se2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*se2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - ce2*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se2 );
    dstMatrix.atomSet( [ 2, 2 ], ce2*ce3 );
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2 );
    dstMatrix.atomSet( [ 0, 1 ], ce1*se2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*se2*ce3 + se1*se3 );
    dstMatrix.atomSet( [ 1, 0 ], se1*ce2 );
    dstMatrix.atomSet( [ 1, 1 ], se1*se2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], se1*se2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - se2 );
    dstMatrix.atomSet( [ 2, 1 ], ce2*se3 );
    dstMatrix.atomSet( [ 2, 2 ], ce2*ce3 );
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2 );
    dstMatrix.atomSet( [ 0, 1 ], se2*se3 );
    dstMatrix.atomSet( [ 0, 2 ], se2*ce3 );
    dstMatrix.atomSet( [ 1, 0 ], se1*se2 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce3 - se1*ce2*se3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*se3 - se1*ce2*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], - ce1*se2 );
    dstMatrix.atomSet( [ 2, 1 ], se1*ce3 + ce1*ce2*se3  );
    dstMatrix.atomSet( [ 2, 2 ], - se1*se3 + ce1*ce2*ce3 );
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce2 );
    dstMatrix.atomSet( [ 0, 1 ], - se2*ce3 );
    dstMatrix.atomSet( [ 0, 2 ], se2*se3 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*se2 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*ce2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], se1*se2 );
    dstMatrix.atomSet( [ 2, 1 ], se1*ce2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 2, 2 ], - se1*ce2*se3 + ce1*ce3 );
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], - se1*ce2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], se1*se2 );
    dstMatrix.atomSet( [ 0, 2 ], se1*ce2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 0 ], se2*se3 );
    dstMatrix.atomSet( [ 1, 1 ], ce2 );
    dstMatrix.atomSet( [ 1, 2 ], - se2*ce3 );
    dstMatrix.atomSet( [ 2, 0 ], - ce1*ce2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 2, 1 ], ce1*se2 );
    dstMatrix.atomSet( [ 2, 2 ], ce1*ce2*ce3 - se1*se3 );
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 0, 1 ], - ce1*se2 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*ce2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 0 ], se2*ce3 );
    dstMatrix.atomSet( [ 1, 1 ], ce2 );
    dstMatrix.atomSet( [ 1, 2 ], se2*se3 );
    dstMatrix.atomSet( [ 2, 0 ], - se1*ce2*ce3 - ce1*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se1*se2 );
    dstMatrix.atomSet( [ 2, 2 ], - se1*ce2*se3 + ce1*ce3 );
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], - se1*ce2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 0, 1 ], - se1*ce2*ce3 - ce1*se3  );
    dstMatrix.atomSet( [ 0, 2 ], se1*se2 );
    dstMatrix.atomSet( [ 1, 0 ], ce1*ce2*se3 + se1*ce3 );
    dstMatrix.atomSet( [ 1, 1 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 1, 2 ], - ce1*se2 );
    dstMatrix.atomSet( [ 2, 0 ], se2*se3 );
    dstMatrix.atomSet( [ 2, 1 ], se2*ce3 );
    dstMatrix.atomSet( [ 2, 2 ], ce2 );
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    dstMatrix.atomSet( [ 0, 0 ], ce1*ce2*ce3 - se1*se3 );
    dstMatrix.atomSet( [ 0, 1 ], - ce1*ce2*se3 - se1*ce3 );
    dstMatrix.atomSet( [ 0, 2 ], ce1*se2 );
    dstMatrix.atomSet( [ 1, 0 ], se1*ce2*ce3 + ce1*se3 );
    dstMatrix.atomSet( [ 1, 1 ], - se1*ce2*se3 + ce1*ce3 );
    dstMatrix.atomSet( [ 1, 2 ], se1*se2 );
    dstMatrix.atomSet( [ 2, 0 ], - se2*ce3 );
    dstMatrix.atomSet( [ 2, 1 ], se2*se3 );
    dstMatrix.atomSet( [ 2, 2 ], ce2 );
  }
  else
  {
    throw _.err( 'Not an Euler Representation.' );
  }

  return dstMatrix;
}

//

/**
  * Create the euler angle from an axis and angle rotation. Returns the created euler angle.
  * Axis and Angle stay unchanged.
  *
  * @param { Array } dstEuler - Destination array with euler angle source code.
  * @param { Axis } axis - Source rotation axis.
  * @param { Angle } angle - Source rotation angle.
  *
  * @example
  * // returns [ PI, PI/2, 0, 2, 1, 0 ]
  * _.fromaxisAndAngle2( [ 0, 0, 0, 1, 2, 0 ], [ 1, 1, 0 ], PI );
  *
  * @returns { Array } Returns the corresponding euler angles.
  * @function fromAxisAndAngle2
  * @throws { Error } An Error if( arguments.length ) is different than two or three.
  * @throws { Error } An Error if( dstEuler ) is not euler.
  * @throws { Error } An Error if( axis ) is not axis or axis and angle.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function fromAxisAndAngle2( dstEuler, axis, angle )
{

  dstEuler = _.euler.from( dstEuler );
  let dstEulerView = _.vector.from( dstEuler );
  let srcAxisVector = _.vector.from( axis );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( axis.length === 3 || axis.length === 4 );

  let quat;
  if( arguments.length === 2 )
  {
    quat = _.quat.fromAxisAndAngle( [ 0, 0, 0, 0 ], axis );
  }
  else
  {
    quat = _.quat.fromAxisAndAngle( [ 0, 0, 0, 0 ], axis, angle );
  }

  dstEulerView = _.euler.fromQuat2( dstEulerView, quat );
  return dstEuler;
}

//

/**
  * Create an axis and angle rotation from an euler angle. Returns the created AxisAndAngle.
  * Euler angle stay unchanged.
  *
  * @param { Array } euler - Source euler angle.
  * @param { Array } axisAndAngle - Destination rotation axis and angle.
  *
  * @example
  * // returns [ 1, 1, 0, PI ]
  * _.toAxisAndAngle2( [ PI, PI/2, 0, 2, 1, 0 ], [ 0, 0, 0, 0 ] );
  *
  * @returns { Array } Returns the corresponding axis and angle.
  * @function toAxisAndAngle2
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( euler ) is not euler.
  * @throws { Error } An Error if( axisAndAngle ) is not axis and angle.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function toAxisAndAngle2( euler, axisAndAngle )
{

  let srcEuler = _.euler.from( euler );

  _.assert( arguments.length === 2, 'Expects two arguments' );
  _.assert( axisAndAngle.length === 4 );

  let quat = _.euler.toQuat2( srcEuler, [ 0, 0, 0, 0 ] );

  axisAndAngle = _.quat.toAxisAndAngle( quat, axisAndAngle );
  return axisAndAngle;

}

//

/**
  * Changes the representation of an euler Angle in one of two format ( 'xyz' or [ 0, 1, 2 ] ).
  * Euler representation stay untouched, dstEuler changes.
  *
  * @param { Array } representation - Source representation of Euler angles.
  * @param { Array } dstEuler - Source and destination Euler angle.
  *
  * @example
  * // returns [ 0, 0, 0, 2, 0, 2 ]
  * _.represent( [ 0, 0, 0, 0, 0, 0 ], [ 2, 0, 2 ] );
  *
  * @example
  * // returns [ 0, 0, 0, 'yzx' ]
  * _.represent( [ 0, 0, 0, 1, 2, 0 ], 'yzx' );
  *
  * @returns { Array } Returns the destination Euler angle with the corresponding representation.
  * @function represent
  * @throws { Error } An Error if( arguments.length ) is different than two.
  * @throws { Error } An Error if( dstEuler ) is not euler.
  * @throws { Error } An Error if( representation ) is not an euler angle representation.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function represent( dstEuler, representation )
{
  _.assert( dstEuler === null || dstEuler === undefined || _.euler.is( dstEuler ) );
  _.assert( _.longIs( representation ) || _.arrayIs( representation ) || _.strIs( representation ) );
  _.assert( arguments.length === 2, 'Expects two arguments' );

  if( dstEuler === null || dstEuler === undefined )
  dstEuler = [ 0, 0, 0, 0, 1, 2 ];

  let eulerArray = dstEuler.slice();
  let dstEulerView = _.vector.from( dstEuler );
  let dstQuat = [ 0, 0, 0, 0 ];
  let gotQuaternion = _.euler.toQuat2( eulerArray, dstQuat );

  if( representation )
  {
    eulerArray = _.euler.make( eulerArray, representation );
  }

  eulerArray = _.euler.fromQuat2( eulerArray, gotQuaternion );
  _.vector.assign( dstEulerView, eulerArray );
  return dstEuler;

}

//


/**
  * Check if a set of Euler angles is in a Gimbal Lock situation. Returns true if there is Gimbal Lock.
  * The Euler angles stay untouched.
  *
  * @param { Array } srcEuler - Source set of Euler angles.
  *
  * @example
  * // returns true
  * _.isGimbalLock( [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @example
  * // returns false
  * _.isGimbalLock( [ 0, 0, 0, 0, 1, 2 ] );
  *
  * @returns { Bool } Returns true if there is Gimbal Lock, false if not.
  * @function isGimbalLock
  * @throws { Error } An Error if( arguments.length ) is different than one.
  * @throws { Error } An Error if( srcEuler ) is not an Euler angle.
  * @memberof module:Tools/math/Concepts.wTools.euler
  */

function isGimbalLock( srcEuler )
{

  _.assert( arguments.length === 1 );
  _.assert( _.euler.is( srcEuler ) );

  srcEuler = _.euler.from( srcEuler );
  let srcEulerView = _.vector.fromArray( srcEuler );
  let accuracy =  _.accuracy;
  let accuracySqr = _.accuracySqr;

  let srcQuatVector = _.vector.fromArray( _.euler.toQuat2( srcEuler, null ) );
  let x = srcQuatVector.eGet( 0 ); let x2 = x*x;
  let y = srcQuatVector.eGet( 1 ); let y2 = y*y;
  let z = srcQuatVector.eGet( 2 ); let z2 = z*z;
  let w = srcQuatVector.eGet( 3 ); let w2 = w*w;

  let xy2 = 2*x*y; let xz2 = 2*x*z; let xw2 = 2*x*w;
  let yz2 = 2*y*z; let yw2 = 2*y*w; let zw2 = 2*z*w;

  let ox = srcEulerView.eGet( 3 );
  let oy = srcEulerView.eGet( 4 );
  let oz = srcEulerView.eGet( 5 );

  let lim;
  if( ox === 0 && oy === 1 && oz === 2 )
  {
    lim = xz2 + yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 0 && oy === 2 && oz === 1 )
  {
    lim = xy2 - zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 0 && oz === 2 )
  {
    lim = yz2 - xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= -1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 2 && oz === 0 )
  {
    lim = xy2 + zw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( ( xy2 + zw2 ) >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 0 && oz === 1 )
  {
    lim = yz2 + xw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 1 && oz === 0 )
  {
    lim = xz2 - yw2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracy*accuracy )
    {
      return true;
    }
    else if( lim >= 1 - accuracy*accuracy)
    {
      return true;
    }
  }

  else if( ox === 0 && oy === 1 && oz === 0 )
  {
    lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 0 && oy === 2 && oz === 0 )
  {
    lim = x2 + w2 - z2 - y2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr)
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 0 && oz === 1 )
  {
    lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 1 && oy === 2 && oz === 1 )
  {
    lim = y2 - z2 + w2 - x2;
    if( - 1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 0 && oz === 2 )
  {
    lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= - 1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }

  else if( ox === 2 && oy === 1 && oz === 2 )
  {
    lim = z2 - x2 - y2 + w2;
    if( -1 + accuracySqr < lim && lim < 1 - accuracySqr )
    {
      return false;
    }
    else if( lim <= -1 + accuracySqr )
    {
      return true;
    }
    else if( lim >= 1 - accuracySqr )
    {
      return true;
    }
  }
  else
  {
    throw _.err( 'Not an Euler Representation.' );
  }

}


// --
// declare
// --

let Proto =
{

  is : is,
  isZero : isZero,

  make : make,
  makeZero : makeZero,

  zero : zero,

  from : from,
  _from : _from,
  representationSet : representationSet,

  fromAxisAndAngle : fromAxisAndAngle,
  fromQuat : fromQuat,
  fromMatrix : fromMatrix,
  toMatrix : toMatrix,

  fromQuat2 : fromQuat2,
  toQuat2 : toQuat2,
  fromMatrix2 : fromMatrix2,
  fromMatrix3 : fromMatrix3,
  toMatrix2 : toMatrix2,
  fromAxisAndAngle2 : fromAxisAndAngle2,
  toAxisAndAngle2 : toAxisAndAngle2,

  represent : represent,
  isGimbalLock : isGimbalLock,

  // Order : Order,

}

_.mapExtend( Self,Proto );

})();
