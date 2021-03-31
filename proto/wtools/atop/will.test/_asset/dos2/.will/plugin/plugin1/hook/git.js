
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( !_.git.insideRepository( context.junction.dirPath ) )
  return null;

  if( o.verbosity )
  logger.log( `${context.junction.nameWithLocationGet()}` );

  context.start( `git ${context.request.original}` );

}

module.exports = onModule;
