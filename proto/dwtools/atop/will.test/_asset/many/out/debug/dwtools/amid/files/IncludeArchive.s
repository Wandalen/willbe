(function _IncludeArchive_s_() {

'use strict'; 

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wVerbal' );
  _.include( 'wFiles' );
  _.include( 'wStateStorage' );

  require( './l2/ArchiveRecord.s' );
  require( './l2/ArchiveRecordFactory.s' );

  require( './l8_filter/Archive.s' );

  require( './l9/Archive.s' );
  require( './l9/GraphOld.s' );
  require( './l9/GraphArchive.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
