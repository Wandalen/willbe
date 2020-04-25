(function _Base_s_() {

'use strict';

if( typeof module !== 'undefined' && module !== null )
{

  require( './abase/Layer2.s' );
  var Self = _global_.wTools;
  var _ = _global_.wTools;

}

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
