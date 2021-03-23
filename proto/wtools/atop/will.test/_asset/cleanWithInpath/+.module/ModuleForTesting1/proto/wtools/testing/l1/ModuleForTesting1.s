( function _ModuleForTesting1_s_()
{

'use strict';

// --
// Routines
// --

let Self = _global_._test_ = _global_._test_ || Object.create( null );

function sumOfNumbers()
{
  let result = Number( arguments[ 0 ] );
  for( let i = 1; i < arguments.length; i++ )
  result += Number( arguments[ i ] );
  return result;
}

// --
// export
// --

Self = Object.assign( Self, { sumOfNumbers } );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
