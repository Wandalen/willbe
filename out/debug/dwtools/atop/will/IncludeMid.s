( function _IncludeTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

  require( './l1/About.s' );
  require( './l1/BuildFrame.s' );
  require( './l1/Execution.s' );
  require( './l1/Predefined.s' );
  require( './l1/Resolver.s' );

  require( './l3/AbstractModule.s' );
  require( './l3/OpenedModule.s' );
  require( './l3/OpenerModule.s' );

  require( './l5/Resource.s' );

  require( './l7/Build.s' );
  require( './l7/Exported.s' );
  require( './l7/Willfile.s' );
  require( './l7/PathResource.s' );
  require( './l7/Reflector.s' );
  require( './l7/Step.s' );
  require( './l7/Submodule.s' );

}

})();
