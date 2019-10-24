
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind( it.variant.dirPath + '**' );

  let status = _.git.infoStatus
  ({
    insidePath : it.variant.dirPath,
    checkingUnpushedLocalChanges : 0,
    checkingPrs : 0,
    checkingRemoteChanges : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.hasLocalChanges )
  return null;

  if( o.verbosity )
  logger.log( `Committing ${it.variant.locationExport()}` );

  if( o.dry )
  return;

  it.start( `git add --all` );
  it.start( `git commit ${it.request.original}` );

}

module.exports = onModule;
