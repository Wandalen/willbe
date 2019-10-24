
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  let status = _.git.infoStatus({ insidePath : it.variant.dirPath, checkingPrs : 0, checkingRemoteChanges : 0 });
  if( !status.isRepository )
  return null;

  if( o.verbosity )
  logger.log( `${it.variant.locationExport()}` );

  it.start( `git ${it.request.original}` );

}

module.exports = onModule;
