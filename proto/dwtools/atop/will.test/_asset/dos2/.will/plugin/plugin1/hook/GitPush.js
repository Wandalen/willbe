
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  let status = _.git.statusFull
  ({
    insidePath : it.junction.dirPath,
    local : 0,
    uncommitted : 0,
    unpushed : 1,
    unpushedTags : 1,
    remote : 0,
    prs : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.unpushed )
  return null;

  if( o.verbosity )
  logger.log( `Pushing ${it.junction.nameWithLocationGet()}` );

  it.start( `git push -u origin --all` );
  if( status.unpushedTags )
  it.start( `git push --tags` );

}

module.exports = onModule;
