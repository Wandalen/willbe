
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( !context.module )
  return;

  // let status = _.git.statusFull({ insidePath : context.junction.dirPath, checkingPrs : 0, checkingRemoteChanges : 0 });
  // if( !status.isRepository )
  // return null;

  if( o.verbosity )
  logger.log( `${context.junction.nameWithLocationGet()}` );

  context.startWill( `${context.request.original}` );

  // let relativeLocalPath = path.relative( context.junction.dirPath, context.junction.localPath );
  // context.start( `will.local .with ${relativeLocalPath} ${context.request.original}` );

}

module.exports = onModule;
