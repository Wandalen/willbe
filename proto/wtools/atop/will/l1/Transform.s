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

function interpreterNormalize( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );

  if( _.aux.is( src ) )
  return recordNormalize( src );
  else if( _.str.is( src ) )
  return recordNormalize( _.will.transform.interpreterParse( src ) );
  else
  _.assert( false, 'Unexpected type of {-src-}' );

  /* */

  function recordNormalize( record )
  {
    const [ name, version ] = _.props.pairs( record )[ 0 ];
    const versionPrefix = _.strHasAny( version, [ '=', '<', '>' ] ) ? '' : '= ';
    if( name === 'node' )
    return `njs ${ versionPrefix }${ version }`;
    else
    return `${ name } ${ versionPrefix }${ version }`;
  }
}

//

function engineNormalize()
{
  return _.strReplaceBegin( _.will.transform.interpreterNormalize.apply( this, arguments ), 'njs', 'node' );
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
      interpreters : { propertyAdd : enginesAdd, name : 'npm.engines' },
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
    dst[ name ] = Object.create( null );
    for( let key in willfile.about.interpreters )
    {
      const interpreter = _.strReplaceBegin( willfile.about.interpreters[ key ], 'njs', 'node' );
      const interpreterDescriptor = _.will.transform.interpreterParse( interpreter );
      for( let key in interpreterDescriptor )
      interpreterDescriptor[ key ] = interpreterDescriptor[ key ].replace( /^=\s*(\d)/, '$1' );
      _.props.extend( dst[ name ], interpreterDescriptor );
    }

    if( 'node' in dst[ name ] )
    dst.engine = _.will.transform.engineNormalize({ node : dst[ name ].node });
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
      if( _.bool.likeTrue( submodule.enabled ) || submodule.enabled === undefined || _.bool.likeTrue( o.withDisabledSubmodules ) )
      {
        const path = submodule.path;
        const parsedPath = _.git.path.parseFull( path );

        if( parsedPath.protocol === 'npm' )
        {
          const parsed = _.npm.path.parse( path );
          result[ sectionForSubmoduleGet( submodule ) ][ parsed.host ] = parsed.tag === 'latest' ? '' : parsed.tag;
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
  withDisabledSubmodules : 0,
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
    'name' :          { propertyAdd, section : 'about', name : 'name' },
    'version' :       { propertyAdd, section : 'about', name : 'version' },
    'enabled' :       { propertyAdd, section : 'about', name : 'enabled' },
    'description' :   { propertyAdd, section : 'about', name : 'description' },
    'keywords' :      { propertyAdd, section : 'about', name : 'keywords' },
    'license' :       { propertyAdd, section : 'about', name : 'license' },
    'author' :        { propertyAdd : aboutAuthorPropertyAdd, section : 'about', name : 'author' },
    'contributors' :  { propertyAdd : aboutContributorsPropertyAdd, section : 'about', name : 'contributors' },
    'scripts' :       { propertyAdd, section : 'about', name : 'npm.scripts' },
    'npm.engines' :   { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },
    'engines' :       { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },
    'engine' :        { propertyAdd : interpretersAdd, section : 'about', name : 'interpreters' },

    'repository' :    { propertyAdd : pathRepositoryPropertyAdd, section : 'path', name : 'repository' },
    'bugs' :          { propertyAdd : pathBugtrackerPropertyAdd, section : 'path', name : 'bugs' },
    'main' :          { propertyAdd, section : 'path', name : 'entry' },
    'files' :         { propertyAdd, section : 'path', name : 'npm.files' },

    'dependencies' : { propertyAdd : submoduleAdd_functor( undefined ), section : 'submodule', name : undefined },
    'devDependencies' : { propertyAdd : submoduleAdd_functor( 'development' ), section : 'submodule', name : 'development' },
    'optionalDependencies' : { propertyAdd : submoduleAdd_functor( 'optional' ), section : 'submodule', name : 'optional' },
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
    const interpreters = willfile.about.interpreters = willfile.about.interpreters || [];

    if( property === 'npm.engines' || property === 'engines' )
    for( let key in config[ property ] )
    _.arrayAppendOnce( interpreters, _.will.transform.interpreterNormalize({ [ key ] : config[ property ][ key ] }) );
    else
    _.arrayAppendOnce( interpreters, _.will.transform.interpreterNormalize( config[ property ] ) );
  }

  /* */

  function pathRepositoryPropertyAdd( property )
  {
    willfile.path.repository = _.git.path.normalize( config.repository.url || config.repository );
    willfile.path.origins.push( willfile.path.repository );
  }

  /* */

  function pathBugtrackerPropertyAdd( property )
  {
    const bugtrackerPath = config.bugs.url || config.bugs;
    if( _.strHas( bugtrackerPath, '///' ) )
    willfile.path.bugtracker = bugtrackerPath;
    else
    willfile.path.bugtracker = _.strReplace( bugtrackerPath, '//', '///' );
  }

  /* */

  function submoduleAdd_functor( criterion )
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

//

function willfilesMerge( o )
{
  _.assert( arguments.length === 1, 'Expexts exactly one argument.' );
  _.routine.options( willfilesMerge, o );
  _.assert( _.routine.is( o.onSection ), 'Expexts callback {-o.onSection-} to merge sections.' );
  _.assert( _.aux.is( o.dst ), 'Expexts map like {-o.dst-}.' );
  _.assert( _.aux.is( o.src ), 'Expexts map like {-o.src-}.' );

  /* */

  const willfileSectionsCallbackMap =
  {
    about : aboutSectionExtend,
    build : sectionExtend,
    path : sectionExtend,
    reflector : sectionExtend,
    step : sectionExtend,
    submodule : sectionExtend,
  };
  _.map.sureHasOnly( o.dst, willfileSectionsCallbackMap );
  _.map.sureHasOnly( o.src, willfileSectionsCallbackMap );

  for( let sectionName in o.src )
  o.dst[ sectionName ] = willfileSectionsCallbackMap[ sectionName ]( o.dst, o.src, sectionName );

  o.dst = dstSectionsFilter();

  return o.dst;

  /* */

  function aboutSectionExtend( dst, src, name )
  {
    if( !o.about )
    return dst.about;

    if( !o.dst.about )
    o.dst.about = Object.create( null );

    const aboutSectionCallbackMap =
    {
      'author' : authorFieldAdd,
      'contributors' : contributorsFieldAdd,
      'interpreters' : interpretersFieldAdd,
    };

    for( let key in o.src.about )
    {
      if( ( key in aboutSectionCallbackMap ) && o[ key ] )
      {
        aboutSectionCallbackMap[ key ]();
      }
      else if( o[ key ] )
      {
        if( _.primitive.is( o.src.about[ key ] ) || _.primitive.is( o.dst.about[ key ] ) )
        o.onSection( o.dst.about, { [ key ] : o.src.about[ key ] } );
        else if( _.array.is( o.src.about[ key ] ) )
        o.dst.about[ key ] = _.arrayAppendArrayOnce( o.dst.about[ key ] || null, o.src.about[ key ] );
        else if( _.aux.is( o.src.about[ key ] ) )
        o.onSection( o.dst.about[ key ] || Object.create( null ), o.src.about[ key ] );
      }
      else if( !( key in o ) )
      {
        o.onSection( o.dst.about, { [ key ] : o.src.about[ key ] } );
      }
    }

    return o.dst.about;
  }

  /* */

  function authorFieldAdd()
  {
    if( o.src.about.author )
    o.onSection( o.dst.about, { author : _.will.transform.authorRecordNormalize( o.src.about.author ) } );
  }

  /* */

  function contributorsFieldAdd()
  {
    if( !o.src.about.contributors )
    return;

    _.assert( _.array.is( o.src.about.contributors ), 'Expexts array of source contributors.' );

    const srcContributors = _.array.make( o.src.about.contributors.length );
    _.each( o.src.about.contributors, ( record, k ) => /* Dmytro : the `each` is used because the `map` does not exist at now */
    {
      srcContributors[ k ] = _.will.transform.authorRecordParse( record );
    });

    let dstContributors;
    if( o.dst.about.contributors )
    {
      _.assert( _.array.is( o.dst.about.contributors ), 'Expexts array of destination contributors.' );

      dstContributors = _.array.make( o.dst.about.contributors.length );
      _.each( o.dst.about.contributors, ( record, k ) =>
      {
        dstContributors[ k ] = _.will.transform.authorRecordParse( record );
      });
      _.each( srcContributors, ( record ) =>
      {
        const index = _.long.leftIndex( dstContributors, record, ( r ) => r.name );
        if( index === -1 )
        dstContributors.push( record );
        else
        dstContributors[ index ] = o.onSection( dstContributors[ index ], record )
      });
    }
    else
    {
      dstContributors = srcContributors;
    }

    o.dst.about.contributors = dstContributors;
    _.each( dstContributors, ( record, k ) =>
    {
      o.dst.about.contributors[ k ] = _.will.transform.authorRecordNormalize( record );
    });
  }

  /* */

  function interpretersFieldAdd( dst )
  {
    if( !o.src.about.interpreters )
    return;

    const srcInterpreters = Object.create( null );
    _.each( o.src.about.interpreters, ( e ) =>
    {
      o.onSection( srcInterpreters, _.will.transform.interpreterParse( e ) );
    });

    let dstInterpreters = Object.create( null );
    if( o.dst.about.interpreters )
    {
      _.each( o.dst.about.interpreters, ( e ) =>
      {
        o.onSection( dstInterpreters, _.will.transform.interpreterParse( e ) );
      });
    }

    o.onSection( dstInterpreters, srcInterpreters );
    if( dstInterpreters[ 'nodejs' ] !== undefined )
    {
      dstInterpreters[ 'njs' ] = dstInterpreters[ 'nodejs' ];
      delete dstInterpreters[ 'nodejs' ];
    }

    o.dst.about.interpreters = [];
    _.each( dstInterpreters, ( e, k ) => o.dst.about.interpreters.push( `${ k } ${ e }` ) );
  }

  /* */

  function sectionExtend( dst, src, name )
  {
    if( o[ name ] )
    return o.onSection( dst[ name ] || Object.create( null ), src[ name ] );
    return dst[ name ];
  }

  /* */

  function dstSectionsFilter()
  {
    for( let sectionName in willfileSectionsCallbackMap )
    if( !o.dst[ sectionName ] || _.props.keys( o.dst[ sectionName ] ).length === 0 )
    delete o.dst[ sectionName ];
    return o.dst;
  }
}

willfilesMerge.defaults =
{
  'about' : 1,
  'build' : 1,
  'path' : 1,
  'reflector' : 1,
  'step' : 1,
  'submodule' : 1,

  'name' : 1,
  'version' : 1,
  'author' : 1,
  'enabled' : 1,
  'description' : 1,
  'contributors' : 1,
  'interpreters' : 1,
  'license' : 1,
  'keywords' : 1,
  'npm.name' : 1,
  'npm.scripts' : 1,

  'dst' : null,
  'src' : null,
  'onSection' : null,
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
  interpreterNormalize,
  engineNormalize,

  submoduleMake,
  submodulesSwitch,

  npmFromWillfile,
  willfileFromNpm,

  willfilesMerge,

};

_.props.extend( Self, Extension );

})();
