
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( !it.module )
  return;

  // let status = _.git.statusFull({ insidePath : it.junction.dirPath, checkingPrs : 0, checkingRemoteChanges : 0 });
  // if( !status.isRepository )
  // return null;

  if( o.verbosity )
  logger.log( `${it.junction.nameWithLocationGet()}` );

  it.startWill( `${it.request.original}` );

  // let relativeLocalPath = _.path.relative( it.junction.dirPath, it.junction.localPath );
  // it.start( `local-will .with ${relativeLocalPath} ${it.request.original}` );

}

module.exports = onModule;
