
function status( it )
{
  let _ = it.tools;
  let logger = it.logger;
  if( !it.module )
  {
    logger.log( it.variant.locationExport() );
    logger.error( `${it.variant.object.absoluteName} is not opened!` );
  }

  let status = _.git.infoStatus({ insidePath : it.dirPath });

  if( !status.info )
  return null;

  logger.log( it.variant.locationExport() );
  logger.log( status.info );

}

module.exports = status;
