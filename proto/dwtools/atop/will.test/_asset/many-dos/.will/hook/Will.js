
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;
  if( !it.module )
  {
    logger.log( it.variant.locationExport() );
    logger.error( `${it.variant.object.absoluteName} is not opened!` );
  }

  let status = _.git.infoStatus({ insidePath : it.variant.dirPath, checkingPrs : 0, checkingRemoteChanges : 0 });
  if( !status.isRepository )
  return null;

  logger.log( it.variant.locationExport() );

  it.startWill( `${it.request.original}` );

  // let relativeLocalPath = _.path.relative( it.variant.dirPath, it.variant.localPath );
  // it.start( `local-will .with ${relativeLocalPath} ${it.request.original}` );

}

module.exports = onEach;
