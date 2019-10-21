
let _;
function onEach( it )
{
  _ = it.tools;
  let logger = it.logger;
  if( !it.module )
  {
    logger.log( it.variant.locationExport() );
    logger.error( `${it.variant.object.absoluteName} is not opened!` );
  }

  let configPath = _.path.join( it.variant.dirPath, 'package.json' );
  let wasconfigPath = _.path.join( it.variant.dirPath, 'was.package.json' );

  if( !it.request.map.tag )
  throw _.errBrief( 'Expects option tag' );

  if( !_.fileProvider.fileExists( wasconfigPath ) )
  return;

  if( it.request.map.verbosity )
  logger.log( `Publishing ${it.variant.locationExport()}` );

  if( it.request.map.dry )
  return;

  if( !isEnabled( wasconfigPath ) )
  return;

  _.assert( _.path.isTrailed( it.variant.localPath ), 'not tested' );

  npmBump
  ({
    dry : it.request.map.dry,
    configPath : wasconfigPath,
    verbosity : it.request.map.verbosity - 4,
  });

  let activeconfigPath = wasconfigPath;
  if( !it.request.map.dry )
  {
    _.fileProvider.fileCopy( configPath, wasconfigPath );
    activeconfigPath = configPath;
  }

  npmFixate
  ({
    dry : it.request.map.dry,
    localPath : it.variant.dirPath,
    configPath : activeconfigPath,
    tag : it.request.map.tag,
    onDependencyFilter,
    verbosity : it.request.map.verbosity - 2,
  });

  it.start( 'local-will .export' );

  npmPublish
  ({
    localPath : it.variant.dirPath,
    tag : it.request.map.tag,
    ready : it.ready,
    verbosity : it.request.map.verbosity - 1,
  })

  function onDependencyFilter( dep )
  {
    if( !_.strBegins( dep.name, 'w' ) )
    return false;
    return true;
  }

}

module.exports = onEach;

//

function isEnabled( localPath )
{
  if( !_.strEnds( _.path.fullName( localPath ), '.json' ) )
  localPath = _.path.join( localPath, 'package.json' );
  let config = _.fileProvider.fileConfigRead( localPath );
  if( !config.name )
  return false;
  if( config.enabled !== undefined && !config.enabled )
  return false;
  return true;
}

//

function npmPublish( o )
{

  _.routineOptions( npmPublish, arguments );
  if( !o.verbosity || o.verbosity < 0 )
  o.verbosity = 0;

  _.assert( _.path.isAbsolute( o.localPath ), 'Expects local path' );
  _.assert( _.strDefined( o.tag ), 'Expects tag' );

  if( !o.ready )
  o.ready = new _.Consequence().take( null );

  let start = _.process.starter
  ({
    currentPath : o.localPath,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : o.verbosity >= 2,
    inputMirroring : o.verbosity >= 2,
    mode : 'shell',
    ready : o.ready
  });

  return start( `npm publish --tag ${o.tag}` )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed publish ${o.localPath} with tag ${o.tag}` );
    return arg;
  });
}

npmPublish.defaults =
{
  localPath : null,
  tag : null,
  ready : null,
  verbosity : 0,
}

//

function _npmReadChangeWrite( o )
{

  o = _.routineOptions( _npmReadChangeWrite, o );
  if( !o.verbosity || o.verbosity < 0 )
  o.verbosity = 0;

  if( !o.configPath )
  o.configPath = _.path.join( o.localPath, 'package.json' );
  o.config = _.fileProvider.fileConfigRead( o.configPath );

  o.changed = o.onChange( o );

  _.assert( _.boolIs( o.changed ) );
  if( !o.changed )
  return o;

  let str = null;
  let encoder = _.Gdf.Select
  ({
    in : 'structure',
    out : 'string',
    ext : 'json',
  })[ 1 ]; /* xxx : workaround */
  _.assert( !!encoder, `No encoder` );
  str = encoder.encode({ data : o.config }).data;

  if( o.verbosity >= 2 )
  logger.log( str );

  if( o.dry )
  return o;

  if( str )
  _.fileProvider.fileWrite( o.configPath, str );
  else
  _.fileProvider.fileWrite( o.configPath, o.config );

  return o;
}

_npmReadChangeWrite.defaults =
{
  localPath : null,
  configPath : null,
  dry : 0,
  verbosity : 0,
  onChange : null,
}

//

function npmFixate( o )
{

  o = _.routineOptions( npmFixate, o );
  if( !o.verbosity || o.verbosity < 0 )
  o.verbosity = 0;

  try
  {
    let o2 = _.mapOnly( _.mapExtend( null, o ), _npmReadChangeWrite.defaults );
    o2.onChange = onChange;
    o.changed = _npmReadChangeWrite( o2 );
    o.config = o.config;
    return o;
  }
  catch( err )
  {
    throw _.err( err, `\nFailed to bump version of npm config ${o.configPath}` );
  }

  function onChange( op )
  {
    let o2 = Object.create( null );
    _.mapExtend( o2, _.mapOnly( o, npmStructureFixate.defaults ) );
    _.mapExtend( o2, _.mapOnly( op, npmStructureFixate.defaults ) );
    npmStructureFixate( o2 );
    return o2.changed;
  }

}

npmFixate.defaults =
{
  localPath : null,
  configPath : null,
  onDependencyFilter : null,
  dry : 0,
  tag : null,
  verbosity : 0,
}

//

function npmStructureFixate( o )
{

  let dependencySectionsNames =
  [
    'dependencies',
    'devDependencies',
    'optionalDependencies',
    'bundledDependencies',
    'peerDependencies',
  ];

  o = _.routineOptions( npmStructureFixate, o );
  o.changed = false;

  _.assert( _.strDefined( o.tag ) );

  dependencySectionsNames.forEach( ( s ) =>
  {
    if( o.config[ s ] )
    for( let depName in o.config[ s ] )
    {
      let depVersion = o.config[ s ][ depName ];
      let dep = Object.create( null );
      dep.name = depName;
      dep.version = depVersion;
      if( dep.version )
      continue;
      if( o.onDependencyFilter )
      if( !o.onDependencyFilter( dep ) )
      continue;
      o.changed = true;
      o.config[ s ][ depName ] = depVersionPatch( dep );
    }
  });

  return o.changed;

  function depVersionPatch( dep )
  {
    return o.tag;
  }

}

npmStructureFixate.defaults =
{
  config : null,
  onDependencyFilter : null,
  tag : null,
}

//

function npmBump( o )
{

  o = _.routineOptions( npmBump, o );
  if( !o.verbosity || o.verbosity < 0 )
  o.verbosity = 0;

  try
  {
    let o2 = _.mapOnly( _.mapExtend( null, o ), _npmReadChangeWrite.defaults );
    o2.onChange = onChange;
    o.changed = _npmReadChangeWrite( o2 );
    o.config = o.config;
  }
  catch( err )
  {
    throw _.err( err, `\nFailed to bump version of npm config ${o.configPath}` );
  }

  return o;

  function onChange( op )
  {
    let o2 = Object.create( null );
    _.mapExtend( o2, _.mapOnly( o, npmStructureFixate.defaults ) );
    _.mapExtend( o2, _.mapOnly( op, npmStructureFixate.defaults ) );
    npmStructureBump( o2 );
    return o2.changed;
  }

}

npmBump.defaults =
{
  localPath : null,
  configPath : null,
  dry : 0,
  verbosity : 0,
}

//

function npmStructureBump( o )
{

  let dependencySectionsNames =
  [
    'dependencies',
    'devDependencies',
    'optionalDependencies',
    'bundledDependencies',
    'peerDependencies',
  ];

  o = _.routineOptions( npmStructureBump, o );
  o.changed = false;

  let version = o.config.version || '0.0.0';
  let versionArray = version.split( '.' );
  versionArray[ 2 ] = Number( versionArray[ 2 ] );
  _.sure( _.intIs( versionArray[ 2 ] ), `Cant deduce current version : ${version}` );

  versionArray[ 2 ] += 1;
  version = versionArray.join( '.' );

  o.changed = true;
  o.config.version = version;

  return version;

  function depVersionPatch( dep )
  {
    return o.tag;
  }

}

npmStructureBump.defaults =
{
  config : null,
}
