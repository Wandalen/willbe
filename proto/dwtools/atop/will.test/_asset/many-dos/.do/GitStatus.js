
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

  let status = _.git.infoStatus({ insidePath : it.variant.dirPath });

  if( !status.info )
  return null;

  logger.log( it.variant.locationExport() );
  logger.log( status.info );

}

module.exports = onEach;
