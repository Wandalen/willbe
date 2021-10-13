( function _ModuleForTesting12ab_s_()
{

'use strict';

let _;
if( typeof module !== 'undefined' )
{
  _ = require( '../../Common.s' );
  require( 'wmodulefortesting1a' );
  require( 'wmodulefortesting1b' );
  require( 'wmodulefortesting2' );
  require( 'wmodulefortesting2a' );
  require( 'wmodulefortesting2b' );
  require( 'wmodulefortesting12' );
}

// --
// Routines
// --

function sumOfAll()
{
  let result = _.sumOfNumbers.apply( this, arguments );
  result += _.squareOfSum.apply( this, arguments );
  result += _.squareRootOfSum.apply( this, arguments );
  result += _.mulOfNumbers.apply( this, arguments );
  result += _.squareOfMul.apply( this, arguments );
  result += _.squareRootOfMul.apply( this, arguments );
  result += _.divideMulOnSum.apply( this, arguments );

  return result;
}

//

Object.assign( _, { sumOfAll } );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();


