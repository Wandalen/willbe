
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  // let status = _.git.infoStatus
  // ({
  //   insidePath : it.variant.dirPath,
  //   checkingUnpushedLocalChanges : 0,
  //   checkingPrs : 0,
  //   checkingRemoteChanges : 0,
  // });
  // if( !status.isRepository )
  // return null;

  if( o.verbosity )
  logger.log( `Pulling ${it.variant.nameWithLocationGet()}` );

  // if( status.hasLocalChanges )
  // {
  //   logger.log( _.errBrief( `${it.variant.nameWithLocationGet()} has local changes!` ) );
  //   return null;
  // }

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

  it.ready.catch( ( err ) => logger.log( _.errOnce( _.errBrief( err ) ) ) || null );

}

module.exports = onModule;
