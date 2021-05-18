( function _Property_s_()
{

'use strict';

const _ = _global_.wTools;
const Self = _.will.transform = _.will.transform || Object.create( null );

// --
// implementation
// --

function authorRecordNormalize( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  let result = src;
  if( _.str.is( src ) )
  {
    let validAuthorString = authorRecordVerify( src );
    if( !validAuthorString )
    throw _.err( `Author record::${ src } is not valid` );
  }
  else if( _.aux.is( src ) )
  {
    result = src.name;
    if( src.email )
    result += ` <${ src.email }>`;
    if( src.url )
    result += ` (${ src.url })`;
    return result;
  }
  else
  {
    _.assert( 0, 'Unexpected type of record' );
  }

  return result;

  /* */

  function authorRecordVerify()
  {
    let recordIsValid = false;
    let splits = split( src );
    if( splits[ 1 ] !== undefined )
    {
      _.assert( splits[ 0 ] !== '', 'Expects author' );

      if( uriIs( splits[ 2 ] ) )
      splits = split( splits[ 0 ] );

      if( splits[ 1 ] === undefined )
      recordIsValid = authorVerify( splits[ 0 ] );
      else if( emailIs( splits[ 2 ] ) )
      recordIsValid = authorVerify( splits[ 0 ] );
      else
      recordIsValid = authorVerify( splits.join( ' ' ) );
    }
    else
    {
      recordIsValid = authorVerify( src );
    }
    return recordIsValid;
  }

  /* */

  function split( src ) /* Dmytro : should I write it inplace? */
  {
    return _.strIsolateRightOrAll({ src, delimeter : /\s+/ });
  }

  /* */

  function uriIs( uri )
  {
    return /\(\S+\)/.test( uri );
  }

  /* */

  function emailIs( email )
  {
    return /\<\S+\>/.test( email );
  }

  /* */

  function authorVerify( author )
  {
    return !/(<|>|\(|\))/.test( author ) && author !== '';
  }
}

//

function submodulesSwitch( src, enabled )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
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
  authorRecordNormalize,

}

_.props.extend( Self, Extension );

})();
