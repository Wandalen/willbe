( function _IncludeTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

  require( './l1/About.s' );
  require( './l1/BuildFrame.s' );
  require( './l1/Execution.s' );
  require( './l1/Predefined.s' );

  require( './l3/Module.s' );
  // require( './l3/Stager.s' );

  require( './l5/Resource.s' );

  require( './l7/Build.s' );
  require( './l7/Exported.s' );
  require( './l7/WillFile.s' );
  require( './l7/PathResource.s' );
  require( './l7/Reflector.s' );
  require( './l7/Step.s' );
  require( './l7/Submodule.s' );

}

})();
