( function _IncludeBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }


  let _ = _global_.wTools;

  _.include( 'wExternalFundamentals' );
  _.include( 'wCopyable' );
  _.include( 'wVerbal' );
  _.include( 'wLogger' );
  _.include( 'wTemplateTreeEnvironment' );

  _.include( 'wFiles' );
  _.include( 'wFilesArchive' );
  _.include( 'wFilesTransformers' );

  _.include( 'wStateStorage' );
  _.include( 'wStateSession' );
  _.include( 'wCommandsAggregator' );
  _.include( 'wCommandsConfig' );

}

})();
