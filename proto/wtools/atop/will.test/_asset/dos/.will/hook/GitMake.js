
function onGitMake( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  // if( !context.module || context.module.repo.remotePath || !context.module.about.name )
  if( !context.module || !context.module.about.name )
  throw _.errBrief( 'Module should be local, opened and have name' );

  let localPath = context.junction.dirPath;
  let remotePath = null;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onGitMake, o );

  try
  {

    let config = fileProvider.configUserRead( _.censor.storageConfigPath );
    if( config && config.path && config.path.remoteRepository )
    {
      _.mapSupplement( config, context );
      remotePath = _.resolverAdv.resolve
      ({
        src : config,
        selector : config.path.remoteRepository,
      });
    }

    let token = null;
    if( config.about && config.about[ 'github.token' ] )
    token = config.about[ 'github.token' ];

    _.assert( !_.strEnds( context.junction.localPath, 'git/trunk/' ), 'guard' );

    if( o.verbosity )
    logger.log( `Making repository for ${context.junction.nameWithLocationGet()}` );
    if( o.verbosity >= 2 )
    logger.log( `localPath : ${_.color.strFormat( String( localPath ), 'path' )}` );
    if( o.verbosity >= 2 )
    logger.log( `remotePath : ${_.color.strFormat( String( remotePath ), 'path' )}` );

    return _.git.repositoryInit
    ({
      localPath,
      remotePath,
      token,
      local : o.local,
      remote : o.remote,
      logger : o.verbosity - 1,
      dry : o.dry,
    });

  }
  catch( err )
  {
    let error = _.err
    (
      err,
      `\nFailed to make an repository for ${context.junction.nameWithLocationGet()}`,
      `\nlocalPath : ${localPath}`,
      `\nremotePath : ${remotePath}`
    );
    throw _.err( error );
  }

}

onGitMake.defaults =
{
  dry : 0,
  local : 1,
  remote : 1,
  verbosity : 2,
  v : null,
};

module.exports = onGitMake;
