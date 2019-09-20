( function _IncludeBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( 'express' );

  _.include( 'wCopyable' );
  _.include( 'wVerbal' );
  _.include( 'wFiles' );
  _.include( 'wTemplateTreeEnvironment' );
  _.include( 'wServletTools' );

  require( './tools/Maker.s' );

}

})();
