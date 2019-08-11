( function _IncludeBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wExternalFundamentals' );
  _.include( 'wCopyable' );
  _.include( 'wVerbal' );
  _.include( 'wLogger' );
  _.include( 'wTemplateTreeEnvironment' );
  _.include( 'wStager' );
  _.include( 'wGraph' );
  _.include( 'wSelector' );
  _.include( 'wResolver' );

  _.include( 'wFiles' );
  _.include( 'wFilesArchive' );
  _.include( 'wFilesEncoders' );

  _.include( 'wStateStorage' );
  _.include( 'wStateSession' );
  _.include( 'wCommandsAggregator' );
  _.include( 'wCommandsConfig' );
  _.include( 'wNameMapper' );

}

})();
