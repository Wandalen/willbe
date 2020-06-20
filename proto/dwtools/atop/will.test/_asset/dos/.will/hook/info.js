function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;

  if( context.module )
  logger.log( context.module.exportString({ verbosity : 2 }) );
  else
  logger.log( `Info for ${context.junction.nameWithLocationGet()}` );

}
module.exports = onModule;
