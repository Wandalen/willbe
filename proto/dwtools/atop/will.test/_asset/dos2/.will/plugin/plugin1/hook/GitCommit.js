
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind( it.junction.dirPath + '**' );

  let status = _.git.statusFull
  ({
    insidePath : it.junction.dirPath,
    unpushed : 0,
    prs : 0,
    remote : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.status )
  return null;

  if( o.verbosity )
  logger.log( `Committing ${it.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  it.start( `git add --all` );
  it.start( `git commit ${it.request.original}` );

}

module.exports = onModule;
