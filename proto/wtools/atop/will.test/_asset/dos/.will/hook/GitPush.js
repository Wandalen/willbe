
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  let status = _.git.statusFull
  ({
    insidePath : context.junction.dirPath,
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
  logger.log( `Pushing ${context.junction.nameWithLocationGet()}` );

  context.start( `git push -u origin --all` );
  if( status.unpushedTags )
  context.start( `git push --tags -f` );

  // _.git.push
  // ({
  //   localPath : context.junction.dirPath,
  //   withTags : status.unpushedTags,
  //   sync : 0,
  //   throwing : 1,
  // });
}

module.exports = onModule;
