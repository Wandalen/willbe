
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  /* read stats to fix for windows to update edit time of hard linked files */
  if( process.platform === 'win32' )
  fileProvider.filesFind({ filePath : context.junction.dirPath + '**', safe : 0 });

  debugger;

  let status = _.git.statusFull
  ({
    insidePath : context.junction.dirPath,
    unpushed : 0,
    prs : 0,
    remote : 0,
  });

  if( !status.isRepository )
  return null;
  if( !status.status )
  return null;

  if( o.verbosity )
  logger.log( `Committing ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  context.start( `git add --all` );
  context.start( `git commit ${context.request.original}` );

}

module.exports = onModule;
