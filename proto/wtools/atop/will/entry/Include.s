( function _Include_s_()
{

'use strict';

/**
 * Utility to manage modules of complex modular systems.
  @module Tools/Willbe
*/

if( typeof module !== 'undefined' )
{

  const _ = require( '../include/Top.s' );
  module[ 'exports' ] = _global_.wTools;

  if( !module.parent )
  _global_.wTools.WillCli.Exec();

}

})();
