( function _ModuleForTesting12_s_() {

'use strict';

let test1 = require( '../../../Tools.s' );
let test2 = require( 'wmodulefortesting2' );

// --
// Routines
// --

function divideMulOnSum()
{
  let sum = test1.sumOfNumbers.apply( this, arguments );
  let mul = test2.mulOfNumbers.apply( this, arguments );
  let result = mul / sum;

  return result;
}

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ].divideMulOnSum = divideMulOnSum;

})();


