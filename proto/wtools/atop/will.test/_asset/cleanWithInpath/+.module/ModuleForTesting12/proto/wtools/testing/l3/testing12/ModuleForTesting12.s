( function _ModuleForTesting12_s_()
{

'use strict';

let _ = require( 'wmodulefortesting2' );

// --
// Routines
// --

function divideMulOnSum()
{
  let sum = _.sumOfNumbers.apply( this, arguments );
  let mul = _.mulOfNumbers.apply( this, arguments );
  let result = mul / sum;

  return result;
}

//

Object.assign( _, { divideMulOnSum } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ].divideMulOnSum = divideMulOnSum;
module[ 'exports' ] = _;

})();


