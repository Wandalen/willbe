
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;
  if( !it.module )
  {
    logger.log( it.variant.locationExport() );
    logger.error( `${it.variant.object.absoluteName} is not opened!` );
  }

  _.fileProvider.filesFind( it.variant.dirPath + '**' );

  let status = _.git.infoStatus
  ({
    insidePath : it.variant.dirPath,
    checkingUnpushedLocalChanges : 0,
    checkingPrs : 0,
    checkingRemoteChanges : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.hasLocalChanges )
  return null;

  logger.log( it.variant.locationExport() );

  // let willfPath = _.arrayAs( it.opener.willfilesPath );
  // willfPath.forEach( ( willfPath ) =>
  // {
  //   it.start({ execPath : `git checkout ${_.path.nativize( willfPath )}`, throwingExitCode : 0 });
  // });

  it.start( `git add --all` );
  it.start( `git commit ${it.request.original}` );

}

module.exports = onEach;
