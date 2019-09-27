( function _IncludeBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wAppBasic' );
  _.include( 'wCopyable' );
  _.include( 'wVerbal' );
  _.include( 'wLogger' );
  _.include( 'wTemplateTreeEnvironment' );
  _.include( 'wStager' );
  // _.include( 'wGraph' );
  _.include( 'wGraphBasic' );
  // _.include( 'wGraphTools' );
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
