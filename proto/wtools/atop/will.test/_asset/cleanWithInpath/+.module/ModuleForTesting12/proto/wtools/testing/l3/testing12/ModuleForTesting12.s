( function _ModuleForTesting12_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  require( '../../Basic.s' );
  require( 'wmodulefortesting2' );
}

let test = _global_._test_;

// --
// Routines
// --

function divideMulOnSum()
{
  let sum = test.sumOfNumbers.apply( this, arguments );
  let mul = test.mulOfNumbers.apply( this, arguments );
  let result = mul / sum;

  return result;
}

//

test = Object.assign( test, { divideMulOnSum } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = test;

})();


