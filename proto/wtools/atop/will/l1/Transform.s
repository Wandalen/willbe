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

function submoduleMake( o )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument.' );
  _.routine.options( submoduleMake, o );
  _.assert( _.strDefined( o.name ), 'Expects name {-o.name-}' );
  _.assert( _.str.is( o.path ), 'Expects path {-o.path-}' );
  _.assert( o.criterions === null || _.strsAreAll( o.criterions ) );

  /* */

  let result = Object.create( null );
  result.path = submodulePathMake( o.name, o.path );
  result.enabled = 1;
  if( o.criterions )
  {
    o.criterions = _.array.as( o.criterions );
    result.criterion = Object.create( null );
    for( let i = 0 ; i < o.criterions.length ; i++ )
    result.criterion[ o.criterions[ i ] ] = 1;
  }

  return result;

  /* */

  function submodulePathMake( name, path )
  {
    if( _.strBegins( path, 'file:' ) )
    return _.strReplace( path, 'file:', 'hd://' );

    const replaced = _.strReplace( path, _.git.path.hashToken, _.git.path.tagToken );
    const parsed = _.git.path.parse( replaced );
    if( parsed.protocols.length > 0 )
    {
      if( parsed.service )
      return _.git.path.normalize( replaced );
      else
      return _.uri.normalize( replaced );
    }

    if( _.strHas( replaced, _.git.path.upToken ) )
    return _.git.path.normalize( `https://github.com/${ replaced }` );

    let postfix = path === '' ? `${ path }` : `${ _.npm.path.tagToken }${ path }`;
    return `npm:///${ name }${ postfix }`;
  }
}

submoduleMake.defaults =
{
  name : null,
  path : null,
  criterions : null,
};

//

function npmFromWillfile( o )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument.' );
  _.routine.options( npmFromWillfile, o );
  _.assert( _.aux.is( o.config ), 'Expects options map {-o-}' );

  const willfile = o.config;
  const config = Object.create( null );

  /* */

  _.props.extend( config, aboutSectionTransform() );
  _.props.extend( config, pathSectionTransform() );
  _.props.extend( config, submoduleSectionTransform() );

  return config;

  /* */

  function aboutSectionTransform()
  {
    const result = Object.create( null );

    if( !willfile.about )
    return result;

    const propertiesMap =
    {
      name :         { propertyAdd, name : 'name' },
      version :      { propertyAdd, name : 'version' },
      enabled :      { propertyAdd, name : 'enabled' },
      description :  { propertyAdd, name : 'description' },
      keywords :     { propertyAdd, name : 'keywords' },
      license :      { propertyAdd, name : 'license' },
      author :       { propertyAdd : authorPropertyAdd, name : 'author' },
      contributors : { propertyAdd : contributorsPropertyAdd, name : 'contributors' },
      interpreters : { propertyAdd : enginesAdd, name : 'engines' },
    };

    for( let key in willfile.about )
    if( _.strBegins( key, 'npm.' ) )
    result[ _.strRemoveBegin( key, 'npm.' ) ] = willfile.about[ key ];
    else if( key in propertiesMap )
    propertiesMap[ key ].propertyAdd( result, key, propertiesMap[ key ].name );

    return result;
  }

  /* */

  function propertyAdd( dst, property, name )
  {
    dst[ property ] = willfile.about[ name ];
  }

  /* */

  function authorPropertyAdd( dst, property, name )
  {
    dst.author = _.will.transform.authorRecordNormalize( willfile.about.author );
  }

  /* */

  function contributorsPropertyAdd( dst, property, name )
  {
    dst.contributors = _.array.make( willfile.about.contributors );
    for( let i = 0 ; i < dst.contributors.length ; i++ )
    dst.contributors[ i ] = _.will.transform.authorRecordNormalize( dst.contributors[ i ] );
  }

  /* */

  function enginesAdd( dst, property, name )
  {
    dst.engines = Object.create( null );
    for( let key in willfile.about.interpreters )
    {
      const interpreter = _.strReplaceBegin( willfile.about.interpreters[ key ], 'njs', 'node' );
      const interpreterDescriptor = _.will.transform.interpreterParse( interpreter );
      for( let key in interpreterDescriptor )
      interpreterDescriptor[ key ] = interpreterDescriptor[ key ].replace( /^=\s*(\d)/, '$1' );
      _.props.extend( dst.engines, interpreterDescriptor );
    }
  }

  /* */

  function pathSectionTransform()
  {
    const result = Object.create( null );

    if( !willfile.path )
    return result;

    if( willfile.path.repository )
    result.repository = _.git.path.nativize( willfile.path.repository );
    if( willfile.path.bugtracker )
    result.bugs = _.git.path.nativize( willfile.path.bugtracker );
    if( willfile.path.entry )
    result.main = willfile.path.entry;

    for( let key in willfile.path )
    if( _.strBegins( key, 'npm.' ) )
    result[ _.strRemoveBegin( key, 'npm.' ) ] = willfile.path[ key ];

    return result;
  }

  /* */

  function submoduleSectionTransform()
  {
    const result = Object.create( null );

    if( !willfile.submodule )
    return result;

    dependenciesStructureForm( result );

    for( let name in willfile.submodule )
    {
      const submodule = willfile.submodule[ name ];
      if( _.bool.likeTrue( submodule.enabled ) || submodule.enabled === undefined || _.bool.likeTrue( o.withDisabled ) )
      {
        const path = submodule.path;
        const parsedPath = _.git.path.parseFull( path );

        if( parsedPath.protocol === 'npm' )
        {
          const tag = _.npm.path.parse( path ).tag;
          result[ sectionForSubmoduleGet( submodule ) ][ name ] = tag === 'latest' ? '' : tag;
        }
        else if( _.longHas( parsedPath.protocols, 'git' ) )
        {
          const gitPath = _.strReplace( _.git.path.nativize( path ), _.git.path.tagToken, _.git.path.hashToken );
          result[ sectionForSubmoduleGet( submodule ) ][ name ] = gitPath;
        }
        else if( parsedPath.protocol === 'hd' )
        {
          result[ sectionForSubmoduleGet( submodule ) ][ name ] = `file:${ _.fileProvider.path.localsFromGlobals( path ) }`;
        }
        else if( _.longHasAny( parsedPath.protocols, [ 'http', 'https' ] ) )
        {
          result[ sectionForSubmoduleGet( submodule ) ][ name ] = path;
        }
        else
        {
          _.assert( false, `Unexpected protocols : ${ _.entity.exportStringSolo( parsedPath.protocols ) }` );
        }
      }
    }

    return dependenciesSectionsFilter( result );
  }

  /* */

  function dependenciesStructureForm( src )
  {
    src.dependencies = Object.create( null );
    src.devDependencies = Object.create( null );
    src.optionalDependencies = Object.create( null );
    return src;
  }

  /* */

  function sectionForSubmoduleGet( submodule )
  {
    if( submodule.criterion )
    {
      if( submodule.criterion.development )
      return 'devDependencies';
      if( submodule.criterion.optional )
      return 'optionalDependencies';
    }
    return 'dependencies';
  }

  /* */

  function dependenciesSectionsFilter( src )
  {
    if( src.dependencies && _.props.keys( src.dependencies ).length === 0 )
    delete src.dependencies;
    if( src.devDependencies && _.props.keys( src.devDependencies ).length === 0 )
    delete src.devDependencies;
    if( src.optionalDependencies && _.props.keys( src.optionalDependencies ).length === 0 )
    delete src.optionalDependencies;
    return src;
  }
}

npmFromWillfile.defaults =
{
  config : null,
  withDisabled : 0,
};

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
    name :          { propertyAdd, section : 'about', name : 'name' },
    version :       { propertyAdd, section : 'about', name : 'version' },
    enabled :       { propertyAdd, section : 'about', name : 'enabled' },
    description :   { propertyAdd, section : 'about', name : 'description' },
    keywords :      { propertyAdd, section : 'about', name : 'keywords' },
    license :       { propertyAdd, section : 'about', name : 'license' },
    author :        { propertyAdd : aboutAuthorPropertyAdd, section : 'about', name : 'author' },
    contributors :  { propertyAdd : aboutContributorsPropertyAdd, section : 'about', name : 'contributors' },
    scripts :       { propertyAdd, section : 'about', name : 'npm.scripts' },
    interpreters :  { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },
    engines :       { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },

    repository :    { propertyAdd : pathRepositoryPropertyAdd, section : 'path', name : 'repository' },
    bugs :          { propertyAdd : pathBugtrackerPropertyAdd, section : 'path', name : 'bugs' },
    main :          { propertyAdd, section : 'path', name : 'entry' },
    files :         { propertyAdd, section : 'path', name : 'npm.files' },

    dependencies :          { propertyAdd : submodulePropertyAdd_functor( undefined ), section : 'submodule', name : undefined },
    devDependencies :       { propertyAdd : submodulePropertyAdd_functor( 'development' ), section : 'submodule', name : 'development' },
    optionalDependencies :  { propertyAdd : submodulePropertyAdd_functor( 'optional' ), section : 'submodule', name : 'optional' },
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
    willfile.about.contributors = _.array.make( config.contributors.length );
    for( let i = 0 ; i < config.contributors.length ; i++ )
    willfile.about.contributors[ i ] = _.will.transform.authorRecordNormalize( config.contributors[ i ] );
  }

  /* */

  function interpretersAdd( property, name )
  {
    willfile.about.interpreters = [];
    for( let name in config.engines )
    {
      const version = config.engines[ name ];
      const versionPrefix = _.strHasAny( version, [ '=', '<', '>' ] ) ? '' : '=';
      if( name === 'node' )
      willfile.about.interpreters.push( `njs ${ versionPrefix }${ version }` );
      else
      willfile.about.interpreters.push( `${ name } ${ versionPrefix }${ version }` );
    }
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
    if( _.strHas( config.bugs, '///' ) )
    willfile.path.bugtracker = config.bugs;
    else
    willfile.path.bugtracker = _.strReplace( config.bugs, '//', '///' );
  }

  /* */

  function submodulePropertyAdd_functor( criterion )
  {
    const criterions = criterion ? criterion : null;
    return function( property )
    {
      let dependenciesMap = config[ property ];
      for( let name in dependenciesMap )
      willfile.submodule[ name ] = _.will.transform.submoduleMake
      ({
        name,
        path : dependenciesMap[ name ],
        criterions,
      });
    }
  }

  /* */

  function willfileFilterFields()
  {
    if( _.props.keys( willfile.about ).length === 0 )
    delete willfile.about;
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

  submoduleMake,
  submodulesSwitch,

  npmFromWillfile,
  willfileFromNpm,

};

_.props.extend( Self, Extension );

})();
