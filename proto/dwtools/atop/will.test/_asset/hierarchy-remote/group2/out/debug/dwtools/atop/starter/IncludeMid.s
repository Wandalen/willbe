( function _IncludeMid_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

  require( './MainBase.s' );

  require( './legacy/StarterMaker.s' );

  if( Config.interpreter === 'njs' )
  require( './light/Servlet.ss' );

}

})();
