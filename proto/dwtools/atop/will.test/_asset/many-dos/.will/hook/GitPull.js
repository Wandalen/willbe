
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;
  if( !it.module )
  {
    logger.log( it.variant.locationExport() );
    logger.error( `${it.variant.object.absoluteName} is not opened!` );
  }

  let status = _.git.infoStatus
  ({
    insidePath : it.variant.dirPath,
    checkingUnpushedLocalChanges : 0,
    checkingPrs : 0,
    checkingRemoteChanges : 0,
  });
  if( !status.isRepository )
  return null;

  logger.log( it.variant.locationExport() );

  if( status.hasLocalChanges )
  {
    logger.log( _.errBrief( 'Has local changes!' ) );
    // return null;
  }

  let config = _.fileProvider.fileConfigUserRead();

  let provider = _.FileFilter.Archive();
  provider.archive.basePath = it.opener.dirPath;
  if( config && config.path && config.path.link )
  provider.archive.basePath = _.arrayAppendArraysOnce( _.arrayAs( provider.archive.basePath ), _.arrayAs( config.path.link ) );
  provider.archive.fileMapAutosaving = 1;
  provider.archive.restoreLinksBegin();

  // let willfPath = _.arrayAs( it.opener.willfilesPath );
  // willfPath.forEach( ( willfPath ) =>
  // {
  //   it.start({ execPath : `git checkout ${_.path.nativize( willfPath )}`, throwingExitCode : 0 });
  // });

  it.start( `git pull` );

  it.ready.tap( () =>
  {
    provider.archive.restoreLinksEnd();
  });

  it.ready.catch( ( err ) => logger.log( _.errOnce( _.errBrief( err ) ) ) || null );

}

module.exports = onEach;
