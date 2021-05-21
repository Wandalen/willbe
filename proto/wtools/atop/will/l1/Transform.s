( function _Property_s_()
{

'use strict';

const _ = _global_.wTools;
const Self = _.will.transform = _.will.transform || Object.create( null );

// --
// implementation
// --

function authorRecordParse( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  if( _.aux.is( src ) )
  return src;

  _.assert( _.str.is( src ), 'Expects string {-src-}' );

  /* */

  let result = Object.create( null );

  let splits = split( src );
  if( splits[ 1 ] === undefined )
  {
    result.name = src;
  }
  else
  {
    _.assert( splits[ 0 ] !== '', 'Expects author name' );

    if( uriIs( splits[ 2 ] ) )
    {
      result.url = _.strInsideOf_( splits[ 2 ], '(', ')' )[ 1 ];
      splits = split( splits[ 0 ] );
    }

    if( splits[ 1 ] === undefined )
    {
      result.name = splits[ 2 ];
    }
    else if( emailIs( splits[ 2 ] ) )
    {
      result.name = splits[ 0 ];
      result.email = _.strInsideOf_( splits[ 2 ], '<', '>' )[ 1 ];
    }
    else
    {
      result.name = splits.join( '' );
    }
  }

  return result;

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
}

//

function authorRecordStr( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  if( _.str.is( src ) )
  return src;

  _.map.assertHasOnly( src, [ 'name', 'email', 'url' ], 'Expects valid map with author fields' );

  let result = src.name;
  if( src.email )
  result += ` <${ src.email }>`;
  if( src.url )
  result += ` (${ src.url })`;
  return result;
}

//

function authorRecordNormalize( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  let nameIsValid;
  let result = src;

  if( _.str.is( src ) )
  {
    const parsed = _.will.transform.authorRecordParse( src );
    nameIsValid = nameVerify( parsed.name );
  }
  else if( _.aux.is( src ) )
  {
    nameIsValid = nameVerify( src.name );
    result = _.will.transform.authorRecordStr( src );
  }
  else
  {
    _.assert( 0, 'Unexpected type of record' );
  }

  if( !nameIsValid )
  throw _.err( `Author record::${_.entity.exportStringSolo( src ) } is not valid` );

  return result;

  /* */

  function nameVerify( name )
  {
    return name !== '' && !/(<|>|\(|\))/.test( name );
  }
}

//

function submodulesSwitch( src, enabled )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.aux.is( src ), 'Expects aux map with submodules' );
  _.assert( _.bool.like( enabled ), 'Expects bool value to switch submodule' );

  for( let dependencyName in src )
  {
    if( _.aux.is( src[ dependencyName ] ) )
    {
      src[ dependencyName ].enabled = enabled;
    }
    else if( _.str.is( src[ dependencyName ] ) )
    {
      let dependencyMap = Object.create( null );
      dependencyMap.path = src[ dependencyName ];
      dependencyMap.enabled = enabled;
      src[ dependencyName ] = dependencyMap;
    }
  }
  return src;
}

// --
// declare
// --

let Extension =
{

  submodulesSwitch,

  authorRecordParse,
  authorRecordStr,
  authorRecordNormalize,

};

_.props.extend( Self, Extension );

})();
