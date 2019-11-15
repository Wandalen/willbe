
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( !_.git.insideRepository( it.junction.dirPath ) )
  return null;

  if( o.verbosity )
  logger.log( `${it.junction.nameWithLocationGet()}` );

  it.start( `git ${it.request.original}` );

}

module.exports = onModule;
