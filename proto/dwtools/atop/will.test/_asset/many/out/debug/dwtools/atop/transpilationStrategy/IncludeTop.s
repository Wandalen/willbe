( function IncludeTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './IncludeMid.s' );

  let _ = wTools;

  _.include( 'wCommandsAggregator' );
  _.include( 'wCommandsConfig' );
  _.include( 'wStateStorage' );
  _.include( 'wStateSession' );

}

})();
