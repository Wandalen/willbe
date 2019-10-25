
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  debugger;

  let status = _.git.statusFull
  ({
    insidePath : it.variant.dirPath,
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
  logger.log( `Pushing ${it.variant.nameWithLocationGet()}` );

  debugger;

  // it.start( `git status` );
  // it.start( `git push --tags` );
  // it.start( `git push --follow-tags` );
  // it.start( `git push -u origin --all --follow-tags` );
  it.start( `git push -u origin --all` );
  if( status.unpushedTags )
  it.start( `git push --tags` );

}

module.exports = onModule;
