( function _IncludeMid_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( './Base.s' );

  require( '../l1/Basic.s' );
  require( '../l1/Extra.s' );
  require( '../l1/File.s' );

  require( '../l2/Main.s' );
  require( '../l2/Transaction.s' );

  require( '../l3/About.s' );
  require( '../l3/BuildFrame.s' );
  require( '../l3/BuildRun.s' );
  require( '../l3/Predefined.s' );
  require( '../l3/Repository.s' );
  require( '../l3/Resolver.s' );
  require( '../l3/Willf.s' );

  require( '../l4/AbstractModule.s' );
  require( '../l4/Module.s' );
  require( '../l4/ModuleHandle.s' );
  require( '../l4/ModuleOpener.s' );
  require( '../l4/ModuleJunction.s' );

  require( '../l5/Resource.s' );

  require( '../l6_resource/Build.s' );
  require( '../l6_resource/Exported.s' );
  require( '../l6_resource/PathResource.s' );
  require( '../l6_resource/Reflector.s' );
  require( '../l6_resource/Step.s' );
  require( '../l6_resource/ModulesRelation.s' );
  // require( '../l6_resource/Willf.s' );

  module[ 'exports' ] = _global_.wTools;
}

})();
