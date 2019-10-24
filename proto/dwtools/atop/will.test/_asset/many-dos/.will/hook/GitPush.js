
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind( it.variant.dirPath + '**' );

  debugger;
  let status = _.git.infoStatus
  ({
    insidePath : it.variant.dirPath,
    local : 0,
    uncommitted : 0,
    unpushed : 1,
    remote : 0,
    prs : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.hasLocalChanges )
  return null;

  if( o.verbosity )
  logger.log( `Pushing ${it.variant.nameWithLocationGet()}` );

  // it.start( `git status` );
  // it.start( `git push --tags` );
  // it.start( `git push --follow-tags` );
  it.start( `git push -u origin --all --follow-tags` );

  /* xxx qqq : teach to push light tags if any */

}

module.exports = onModule;
