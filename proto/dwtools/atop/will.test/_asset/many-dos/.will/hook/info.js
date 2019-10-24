function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;

  if( it.module )
  logger.log( it.module.infoExport({ verbosity : 2 }) );
  else
  logger.log( `Info for ${it.variant.locationExport()}` );

}
module.exports = onModule;
