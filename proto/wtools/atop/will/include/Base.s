( function _Base_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../node_modules/Tools' );

  _.include( 'wSelector' );
  _.include( 'wResolver' );
  _.include( 'wResolverExtra' );
  _.include( 'wCopyable' );
  _.include( 'wProcess' );
  _.include( 'wLogger' );

  _.include( 'wVerbal' );
  _.include( 'wTemplateTreeEnvironment' );
  _.include( 'wStager' );
  _.include( 'wGraphBasic' );
  _.include( 'wGitTools' );
  _.include( 'wNpmTools' );
  _.include( 'wYamlTools' );

  _.include( 'wFiles' );
  _.include( 'wFilesArchive' );
  _.include( 'wFilesEncoders' );

  _.include( 'wNameMapper' );
  _.include( 'wTemplateFileWriter' );
  _.include( 'wCensorBasic' );

  module[ 'exports' ] = _global_.wTools;
}

})();
