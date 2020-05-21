( function _fEntity_s_() {

'use strict'; 

let _global = _global_;
let _ = _global_.wModuleForTesting1;
let Self = _global_.wModuleForTesting1;

let _ArraySlice = Array.prototype.slice;
let _FunctionBind = Function.prototype.bind;
let _ObjectToString = Object.prototype.toString;
let _ObjectHasOwnProperty = Object.hasOwnProperty;

// --
// multiplier
// --

function dup( ins, times, result )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects two or three arguments' );
  _.assert( _.numberIs( times ) || _.longIs( times ), 'dup expects times as number or array' );

  if( _.numberIs( times ) )
  {
    if( !result )
    result = new Array( times );
    for( let t = 0 ; t < times ; t++ )
    result[ t ] = ins;
    return result;
  }
  else if( _.longIs( times ) )
  {
    _.assert( times.length === 2 );
    let l = times[ 1 ] - times[ 0 ];
    if( !result )
    result = new Array( times[ 1 ] );
    for( let t = 0 ; t < l ; t++ )
    result[ times[ 0 ] + t ] = ins;
    return result;
  }
  else _.assert( 0, 'unexpected' );

}

//

function multiple( src, times )
{
  _.assert( arguments.length === 2 );
  if( _.arrayLike( src ) )
  _.assert( src.length === times, () => 'Vecotr should have ' + times + ' elements, but have ' + src.length );
  else
  src = _.dup( src, times );
  return src;
}

//

function multipleAll( dsts )
{
  let length = undefined;

  _.assert( arguments.length === 1 );

  for( let d = 0 ; d < dsts.length ; d++ )
  if( _.arrayIs( dsts[ d ] ) )
  {
    length = dsts[ d ].length;
    break;
  }

  if( length === undefined )
  return dsts;

  for( let d = 0 ; d < dsts.length ; d++ )
  dsts[ d ] = _.multiple( dsts[ d ], length );

  return dsts;
}

// --
// entity iterator
// --

function eachSample( o )
{

  if( arguments.length === 2 || _.arrayLike( arguments[ 0 ] 