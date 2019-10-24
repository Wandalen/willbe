
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( !it.module || it.module.isRemote || !it.module.about.name )
  throw _.errBrief( 'Module should be local, opened and have name' );

  let localPath = it.variant.dirPath;
  let remotePath = null;

  debugger;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  try
  {

    let config = _.fileProvider.fileConfigUserRead();
    if( config && config.about && config.path.remoteRepository )
    {
      _.mapSupplement( config, it );
      remotePath = _.Resolver.resolve
      ({
        src : config,
        selector : config.path.remoteRepository,
      });
    }

    let token = null;
    if( config.about && config.about[ 'github.token' ] )
    token = config.about[ 'github.token' ];

    _.assert( !_.strEnds( it.variant.localPath, 'git/trunk/' ), 'guard' );

    if( o.verbosity )
    logger.log( `Making repository for ${it.variant.locationExport()}` );
    if( o.verbosity >= 2 )
    logger.log( `localPath : ${_.color.strFormat( String( localPath ), 'path' )}` );
    if( o.verbosity >= 2 )
    logger.log( `remotePath : ${_.color.strFormat( String( remotePath ), 'path' )}` );

    return _.git.repositoryInit
    ({
      localPath : localPath,
      remotePath : remotePath,
      token : token,
      local : o.local,
      remote : o.remote,
      verbosity : o.verbosity - 1,
      dry : o.dry,
    });

  }
  catch( err )
  {
    err = _.err
    (
        err
      , `\nFailed to make an repository for ${it.variant.locationExport()}`
      , `\nlocalPath : ${localPath}`
      , `\nremotePath : ${remotePath}`
    );
    throw _.err( err );
  }

}

onModule.defaults =
{
  dry : 0,
  local : 1,
  remote : 1,
  verbosity : 2,
  v : null,
}

module.exports = onModule;
