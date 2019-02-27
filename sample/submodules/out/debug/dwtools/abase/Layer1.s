//#! /usr/bin/env node
(function _wToolsLayer1_s_(){

'use strict';

if( typeof module !== 'undefined' && module !== null )
{

  require( './Layer0.s' );

  require( './l1/cErr.s' );

  require( './l1/gBool.s' );
  require( './l1/gEntity.s' );
  require( './l1/gLong.s' );
  require( './l1/gMap.s' );
  require( './l1/gNumber.s' );
  // require( './l1/gProcedure.s' );
  require( './l1/gRange.s' );
  require( './l1/gRegexp.s' );
  require( './l1/gRoutine.s' );
  require( './l1/gString.s' );
  require( './l1/gTime.s' );

  require( './l1/rFundamental.s' );

  require( './l1/zSetup.s' );

  let _global = _global_;
  let _ = _global_.wTools;
  let Self = _global_.wTools;

}

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
