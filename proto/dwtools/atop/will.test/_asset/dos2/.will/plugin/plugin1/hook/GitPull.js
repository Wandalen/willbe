
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  let status = _.git.statusFull
  ({
    insidePath : it.junction.dirPath,
    unpushed : 0,
    prs : 0,
    remote : 1,
  });

  if( !status.isRepository || !status.remote )
  return null;

  if( o.verbosity )
  logger.log( `Pulling ${it.junction.nameWithLocationGet()}` );

  if( status.uncommitted )
  {
    throw _.errBrief( `${it.junction.nameWithLocationGet()} has local changes!` );
    return null;
  }

  let config = _.fileProvider.fileConfigUserRead();
  let provider = _.FileFilter.Archive();
  provider.archive.basePath = it.opener.dirPath;
  if( config && config.path && config.path.link )
  provider.archive.basePath = _.arrayAppendArraysOnce( _.arrayAs( provider.archive.basePath ), _.arrayAs( config.path.link ) );
  provider.archive.fileMapAutosaving = 1;
  provider.archive.verbosity = 2;
  provider.archive.restoreLinksBegin();
  it.start( `git pull` );

  it.ready.tap( () =>
  {
    provider.archive.restoreLinksEnd();
  });

  it.ready.catch( ( err ) =>
  {
    err = _.errBrief( err );
    logger.log( _.errOnce( err ) );
    throw err;
  });

}

module.exports = onModule;
