function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;

  if( it.module )
  logger.log( it.module.exportString({ verbosity : 2 }) );
  else
  logger.log( `Info for ${it.junction.nameWithLocationGet()}` );

}
module.exports = onModule;
