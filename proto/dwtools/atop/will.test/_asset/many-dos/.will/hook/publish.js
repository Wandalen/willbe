
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let configPath = _.path.join( it.variant.dirPath, 'package.json' );
  let wasconfigPath = _.path.join( it.variant.dirPath, 'was.package.json' );

  if( !o.tag )
  throw _.errBrief( 'Expects option tag' );

  if( !_.fileProvider.fileExists( wasconfigPath ) )
  return;

  if( o.verbosity )
  logger.log( `Publishing ${it.variant.nameWithLocationGet()}` );

  if( o.dry )
  return;

  if( !isEnabled( it, wasconfigPath ) )
  return;

  _.assert( _.path.isTrailed( it.variant.localPath ), 'not tested' );

  _.npm.bump
  ({
    dry : o.dry,
    configPath : wasconfigPath,
    verbosity : o.verbosity - 4,
  });

  let activeconfigPath = wasconfigPath;
  if( !o.dry )
  {
    _.fileProvider.fileCopy( configPath, wasconfigPath );
    activeconfigPath = configPath;
  }

  _.npm.fixate
  ({
    dry : o.dry,
    localPath : it.variant.dirPath,
    configPath : activeconfigPath,
    tag : o.tag,
    onDependency,
    verbosity : o.verbosity - 2,
  });

  it.start( 'local-will .export' );

  // _.npm.publish
  // ({
  //   localPath : it.variant.dirPath,
  //   tag : o.tag,
  //   ready : it.ready,
  //   verbosity : o.verbosity - 1,
  // })

  function onDependency( dep )
  {
    let about = aboutCache[ dep.name ];
    if( !about )
    about = aboutCache[ dep.name ] = _.npm.aboutFromRemote( dep.name );
    if( about && about.author && _.strIs( about.author.name ) && _.strHas( about.author.name, 'Kostiantyn Wandalen' ) )
    {
      dep.version = o.tag;
      return;
    }
    if( about && about.version )
    {
      dep.version = about.version;
    }
  }

}

module.exports = onModule;
let aboutCache = new Object.create( null );

//

function isEnabled( it, localPath )
{
  let _ = it.tools;
  if( !_.strEnds( _.path.fullName( localPath ), '.json' ) )
  localPath = _.path.join( localPath, 'package.json' );
  let config = _.fileProvider.fileConfigRead( localPath );
  if( !config.name )
  return false;
  if( config.enabled !== undefined && !config.enabled )
  return false;
  return true;
}
