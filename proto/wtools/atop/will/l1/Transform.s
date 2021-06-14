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

function interpreterParse( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  if( _.aux.is( src ) )
  return src;

  _.assert( _.str.is( src ) );

  let splits = _.strIsolateLeftOrAll( src, ' ' );
  _.assert( splits[ 1 ] !== undefined );
  return { [ splits[ 0 ] ] : splits[ 2 ] };
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

//

function willfileFromNpm( o )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument.' );
  _.routine.options( willfileFromNpm, o );
  _.assert( _.aux.is( o.config ), 'Expects options map {-o-}' );

  let config = o.config;
  let willfile = willfileStructureForm();

  let propertiesMap =
  {
    name :          { propertyAdd : propertyAdd, section : 'about', name : 'name' },
    version :       { propertyAdd : propertyAdd, section : 'about', name : 'version' },
    enabled :       { propertyAdd : propertyAdd, section : 'about', name : 'enabled' },
    description :   { propertyAdd : propertyAdd, section : 'about', name : 'description' },
    keywords :      { propertyAdd : propertyAdd, section : 'about', name : 'keywords' },
    license :       { propertyAdd : propertyAdd, section : 'about', name : 'license' },
    author :        { propertyAdd : aboutAuthorPropertyAdd, section : 'about', name : 'author' },
    contributors :  { propertyAdd : aboutContributorsPropertyAdd, section : 'about', name : 'contributors' },
    scripts :       { propertyAdd : propertyAdd, section : 'about', name : 'npm.scripts' },
    interpreters :  { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },
    engines :       { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },

    repository :    { propertyAdd : pathRepositoryPropertyAdd, section : 'path', name : 'repository' },
    bugs :          { propertyAdd : pathBugtrackerPropertyAdd, section : 'path', name : 'bugs' },
    main :          { propertyAdd : propertyAdd, section : 'path', name : 'entry' },
    files :         { propertyAdd : propertyAdd, section : 'path', name : 'npm.files' },

    dependencies :          { propertyAdd : submodulePropertyAdd, section : 'submodule', name : undefined },
    devDependencies :       { propertyAdd : submodulePropertyAdd, section : 'submodule', name : 'development' },
    optionalDependencies :  { propertyAdd : submodulePropertyAdd, section : 'submodule', name : 'optional' },
  };

  for( let key in config )
  if( key in propertiesMap )
  propertiesMap[ key ].propertyAdd( key, propertiesMap[ key ].name, propertiesMap[ key ].section );
  else
  willfile.about[ `npm.${ key }` ] = config[ key ];

  if( willfile.about.name )
  {
    if( !willfile.about[ 'npm.name' ] )
    willfile.about[ 'npm.name' ] = willfile.about.name;
    willfile.path.origins.push( `npm:///${ willfile.about[ 'npm.name' ] }` );
  }

  willfile = willfileFilterFields();

  return willfile;

  /* */

  function willfileStructureForm()
  {
    let willfile = Object.create( null );
    willfile.about = Object.create( null );
    willfile.path = Object.create( null );
    willfile.path.origins = [];
    willfile.submodule = Object.create( null );
    return willfile;
  }

  /* */

  function propertyAdd( property, name, section )
  {
    willfile[ section ][ name ] = config[ property ];
  }

  /* */

  function aboutAuthorPropertyAdd( property, name )
  {
    willfile.about.author = _.will.transform.authorRecordNormalize( config.author );
  }

  /* */

  function aboutContributorsPropertyAdd( property, name )
  {
    willfile.about.contributors = [];
    for( let i = 0 ; i < config.contributors.length ; i++ )
    willfile.about.contributors[ i ] = _.will.transform.authorRecordNormalize( config.contributors[ i ] );
  }

  /* */

  function interpretersAdd( property, name )
  {
    willfile.about.interpreters = [];
    for( let name in config.engines )
    if( name === 'node' )
    willfile.about.interpreters.push( `njs ${ config.engines[ name ] }` );
    else
    willfile.about.interpreters.push( `${ name } ${ config.engines[ name ] }` );
  }

  /* */

  function pathRepositoryPropertyAdd( property )
  {
    willfile.path.repository = _.git.path.normalize( config.repository );
    willfile.path.origins.push( willfile.path.repository );
  }

  /* */

  function pathBugtrackerPropertyAdd( property )
  {
    if( !_.strHas( config.bugs, '///' ) )
    willfile.path.bugtracker = _.strReplace( config.bugs, '//', '///' );
    else
    willfile.path.bugtracker = config.bugs;
  }

  /* */

  function submodulePropertyAdd( property, criterion )
  {
    addDependency( config[ property ], criterion );
  }

  /* */

  function addDependency( dependenciesMap, criterion )
  {
    for( let dependency in dependenciesMap )
    {
      if( _.strHas( dependenciesMap[ dependency ], /file:/ ) )
      willfile.submodule[ dependency ] = addHdDependency( dependenciesMap[ dependency ], criterion );
      else
      willfile.submodule[ dependency ] = addNpmDependency( dependency, dependenciesMap[ dependency ], criterion );
    }
  }

  /* */

  function addHdDependency( path, criterion )
  {
    let result = Object.create( null );
    result.path = `hd://${ _.strRemoveBegin( path, 'file:' ) }`;
    result.enabled = 1;
    if( criterion )
    {
      result.criterion = Object.create( null );
      result.criterion[ criterion ] = 1;
    }
    return result;
  }

  /* */

  function addNpmDependency( name, hash, criterion )
  {
    let result = Object.create( null );
    hash = hash === '' ? hash : `#${ hash }`;
    result.path = `npm:///${ name }${ hash }`;
    result.enabled = 1;
    if( criterion )
    {
      result.criterion = Object.create( null );
      result.criterion[ criterion ] = 1;
    }
    return result;
  }

  /* */

  function willfileFilterFields()
  {
    if( willfile.path.origins.length === 0 )
    delete willfile.path.origins;
    if( _.props.keys( willfile.submodule ).length === 0 )
    delete willfile.submodule;
    if( _.props.keys( willfile.path ).length === 0 )
    delete willfile.path;
    return willfile;
  }
}

willfileFromNpm.defaults =
{
  config : null,
};

// --
// declare
// --

let Extension =
{

  authorRecordParse,
  authorRecordStr,
  authorRecordNormalize,

  interpreterParse,

  submodulesSwitch,

  willfileFromNpm,
};

_.props.extend( Self, Extension );

})();
