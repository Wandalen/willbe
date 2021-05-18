( function _Property_s_()
{

'use strict';

const _ = _global_.wTools;
const Self = _.will.transform = _.will.transform || Object.create( null );

// --
// implementation
// --

function submodulesSwitch( src, enabled )
{
  _.assert( _.aux.is( src ), 'Expects aux like config' );
  _.assert( _.bool.like( enabled ), 'Expects bool value to switch submodule' );

  if( !src.submodule )
  return null;

  const submodules = src.submodule;

  _.assert( _.aux.is( submodules ), 'Expects aux map with submodules' );

  for( let dependencyName in submodules )
  {
    if( _.aux.is( submodules[ dependencyName ] ) )
    {
      submodules[ dependencyName ].enabled = enabled;
    }
    else if( _.str.is( submodules[ dependencyName ] ) )
    {
      let dependencyMap = Object.create( null );
      dependencyMap.path = submodules[ dependencyName ];
      dependencyMap.enabled = enabled;
      submodules[ dependencyName ] = dependencyMap;
    }
  }
}

// --
// declare
// --

let Extension =
{

  submodulesSwitch,

}

_.props.extend( Self, Extension );

})();
