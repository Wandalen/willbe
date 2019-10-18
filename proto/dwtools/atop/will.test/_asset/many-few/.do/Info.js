function info( it )
{
  let _ = it.tools;
  if( it.module )
  logger.log( it.module.infoExport({ verbosity : 2 }) );
  else
  logger.error( `${it.opener.absoluteName} at ${it.opener.localPath} is not opened!` );
}
module.exports = info;
