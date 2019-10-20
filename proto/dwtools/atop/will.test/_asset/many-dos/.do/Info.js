function onEach( it )
{
  let _ = it.tools;
  if( !it.module )
  logger.error( `${it.variant.object.absoluteName} at ${it.variant.localPath} is not opened!` );
  logger.log( it.module.infoExport({ verbosity : 2 }) );
}
module.exports = onEach;
