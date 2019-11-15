
let aboutCache = Object.create( null );
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let configPath = _.path.join( it.junction.dirPath, 'package.json' );
  let wasconfigPath = _.path.join( it.junction.dirPath, 'was.package.json' );

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  if( !it.junction.module )
  return;

  if( !it.junction.module.about.enabled )
  return;

  if( !o.tag )
  throw _.errBrief( 'Expects option tag' );

  if( !_.fileProvider.fileExists( wasconfigPath ) )
  throw _.errBrief( `Does not have ${wasconfigPath}` );

  if( o.verbosity )
  logger.log( `Publishing ${it.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  if( !isEnabled( it, wasconfigPath ) )
  return;

  _.assert( _.path.isTrailed( it.junction.localPath ), 'not tested' );

  it.start( 'local-will .export' );

  let bumped = _.npm.bump
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
    localPath : it.junction.dirPath,
    configPath : activeconfigPath,
    tag : o.tag,
    onDependency,
    verbosity : o.verbosity - 2,
  });

  {
    let it2 = it.will.hookItNew( it );
    it2.request.subject = `-am "version ${bumped.config.version}"`
    it2.request.original = it2.request.subject;
    it2.will.hooks.GitSync.call( it2 );
  }

  {
    let it2 = it.will.hookItNew( it );
    it2.request.subject = '';
    it2.request.original = '';
    it2.request.map = { name : bumped.config.version };
    it2.will.hooks.GitTag.call( it2 );
  }

  {
    let it2 = it.will.hookItNew( it );
    it2.request.subject = '';
    it2.request.original = '';
    it2.will.hooks.GitPush.call( it2 );
  }

  _.npm.publish
  ({
    localPath : it.junction.dirPath,
    tag : o.tag,
    ready : it.ready,
    verbosity : o.verbosity === 2 ? 2 : o.verbosity -1,
  })

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

var defaults = onModule.defaults = Object.create( null );

defaults.tag = null;
defaults.v = null;
defaults.dry = 0;
defaults.verbosity = 2;

module.exports = onModule;

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
