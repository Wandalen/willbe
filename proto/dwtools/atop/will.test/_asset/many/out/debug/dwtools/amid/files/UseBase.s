( function _UseBase_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wSelector' );
  _.include( 'wAppBasic' );
  _.include( 'wRoutineBasic' );
  _.include( 'wProto' );

  _.include( 'wPathBasic' );
  _.include( 'wUriBasic' );
  _.include( 'wWebUriBasic' );
  _.include( 'wPathTools' );
  _.include( 'wLogger' );
  _.include( 'wRegexpObject' );
  _.include( 'wFieldsStack' );
  _.include( 'wConsequence' );
  _.include( 'wStringer' );
  _.include( 'wStringsExtra' );
  _.include( 'wVerbal' );

}

var Self = _global_.wTools;
var _global = _global_;
var _ = _global_.wTools;

_.assert( !!_.FieldsStack );

Self.FileProvider = Self.FileProvider || Object.create( null );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
