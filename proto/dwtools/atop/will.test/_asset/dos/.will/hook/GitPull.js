
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  /* qqq : implement good coverage
    add test routine to cover broken link case
    add test routine to cover cycled link case
  */

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let status = _.git.statusFull
  ({
    insidePath : it.junction.dirPath,
    unpushed : 0,
    prs : 0,
    remote : 1,
  });

  if( !status.isRepository || !status.remote )
  return null;

  if( o.verbosity )
  logger.log( `Pulling ${it.junction.nameWithLocationGet()}` );

  if( status.uncommitted )
  {
    throw _.errBrief( `${it.junction.nameWithLocationGet()} has local changes!` );
    return null;
  }

  let config = _.fileProvider.configUserRead();
  let provider = _.FileFilter.Archive();
  provider.archive.basePath = it.opener.dirPath;
  if( config && config.path && config.path.link )
  provider.archive.basePath = _.arrayAppendArraysOnce( _.arrayAs( provider.archive.basePath ), _.arrayAs( config.path.link ) );
  provider.archive.fileMapAutosaving = 1;
  if( o.verbosity )
  provider.archive.verbosity = 2;
  else
  provider.archive.verbosity = 0;
  provider.archive.allowingMissed = 1;
  provider.archive.allowingCycled = 1;
  provider.archive.restoreLinksBegin();

  it.start( `git pull` );

  it.ready.tap( () =>
  {
    provider.archive.restoreLinksEnd();
  });

  it.ready.catch( ( err ) =>
  {
    err = _.errBrief( err );
    logger.log( _.errOnce( err ) );
    throw err;
  });

}

onModule.defaults =
{
  v : null,
  verbosity : 2,
}
module.exports = onModule;
