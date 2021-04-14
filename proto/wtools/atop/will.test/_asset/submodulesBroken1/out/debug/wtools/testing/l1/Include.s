( function _Include_s_()
{

'use strict';

let _ = null;

if( typeof module !== 'undefined' )
_ = require( './ModuleForTesting1.s' );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ].sumOfNumbers = _.sumOfNumbers;

})();
