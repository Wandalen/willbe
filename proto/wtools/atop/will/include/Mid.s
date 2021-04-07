( function _IncludeMid_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( './Base.s' );

  require( '../l0/Namespace.s' );

  require( '../l1/Main.s' );
  require( '../l1/Transaction.s' );

  require( '../l2/About.s' );
  require( '../l2/BuildFrame.s' );
  require( '../l2/BuildRun.s' );
  require( '../l2/Predefined.s' );
  require( '../l2/Repository.s' );
  require( '../l2/Resolver.s' );

  require( '../l3/AbstractModule.s' );
  require( '../l3/Module.s' );
  require( '../l3/ModuleHandle.s' );
  require( '../l3/ModuleOpener.s' );
  require( '../l3/ModuleJunction.s' );

  require( '../l5/Resource.s' );

  require( '../l6/Build.s' );
  require( '../l6/Exported.s' );
  require( '../l6/Willf.s' );
  require( '../l6/PathResource.s' );
  require( '../l6/Reflector.s' );
  require( '../l6/Step.s' );
  require( '../l6/ModulesRelation.s' );

  module[ 'exports' ] = _global_.wTools;
}

})();
