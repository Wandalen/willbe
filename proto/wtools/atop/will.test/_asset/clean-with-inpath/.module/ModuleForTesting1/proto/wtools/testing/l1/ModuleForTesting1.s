( function _ModuleForTesting1_s_() {

'use strict';

// --
// Routines
// --

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

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ].sumOfNumbers = sumOfNumbers;

})();
