
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  /* read stats to fix for windows to update edit time of hard linked files */
  if( process.platform === 'win32' )
  fileProvider.filesFind({ filePath : context.junction.dirPath + '**', safe : 0 });

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

  // if( fileProvider.fileExists( abs( '.eslintrc.yml' ) ) )
  // context.start( `git add --force .eslintrc.yml` );
  // if( fileProvider.fileExists( abs( '.github' ) ) )
  // context.start( `git add --force .github` );
  // if( fileProvider.fileExists( abs( '.circleci' ) ) )
  // context.start( `git add --force .circleci` );

  if( fileProvider.fileExists( abs( '.github' ) ) )
  context.start( `git add --force .github` );

  context.start( `git add --all` );
  context.start( `git commit ${context.request.subject}` );
  // context.start( `git commit ${context.request.original}` );

}

module.exports = onModule;
