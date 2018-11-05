( function _IncludeTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

  require( './l3/About.s' );
  require( './l3/Execution.s' );
  require( './l3/Exported.s' );
  require( './l3/Inheritable.s' );
  require( './l3/Predefined.s' );

  require( './l5/Build.s' );
  require( './l5/BuildRun.s' );
  require( './l5/InFile.s' );
  require( './l5/Module.s' );
  require( './l5/PathObj.s' );
  require( './l5/Reflector.s' );
  require( './l5/Step.s' );
  require( './l5/Submodule.s' );

  require( './l6/OutFile.s' );

}

})();
