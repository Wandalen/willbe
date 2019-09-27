( function IncludeTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

  require( './l3/Concatenator.s' );
  require( './l3/Multiple.s' );
  require( './l3/Single.s' );
  require( './l3/Stage.s' );
  require( './l3/Transpiler.s' );

  require( './l5_concatenator/JavaScript.s' );
  require( './l5_concatenator/Text.s' );

  require( './l5_transpiler/Babel.s' );
  require( './l5_transpiler/Closure.s' );
  require( './l5_transpiler/Nop.s' );
  require( './l5_transpiler/Prepack.s' );
  require( './l5_transpiler/Uglify.s' );

}

})();
