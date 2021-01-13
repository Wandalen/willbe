
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  /* qqq : implement good coverage
    add test routine to cover broken link case
    add test routine to cover cycled link case
  */

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let status = _.git.statusFull
  ({
    insidePath : context.junction.dirPath,
    unpushed : 0,
    prs : 0,
    remote : 1,
  });

  if( !status.isRepository || !status.remote )
  {
    let context2 = context.will.hookContextNew( context );
    context2.request.map = { verbosity : 2 }
    context2.will.hooks.ProtoSync.call( context2 );
    return null;
  }

  if( o.verbosity )
  logger.log( `Pulling ${context.junction.nameWithLocationGet()}` );

  if( status.uncommitted )
  {
    throw _.errBrief( `${context.junction.nameWithLocationGet()} has local changes!` );
    return null;
  }

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let provider = _.FileFilter.Archive();
  provider.archive.basePath = context.opener.dirPath;
  if( config && config.path && config.path.hlink )
  provider.archive.basePath = _.arrayAppendArraysOnce( _.arrayAs( provider.archive.basePath ), _.arrayAs( config.path.hlink ) );
  provider.archive.fileMapAutosaving = 1;
  if( o.verbosity )
  provider.archive.verbosity = 2;
  else
  provider.archive.verbosity = 0;
  provider.archive.allowingMissed = 1;
  provider.archive.allowingCycled = 1;
  provider.archive.restoreLinksBegin();

  // context.start( `git pull` );
  context.ready.then( () =>
  {
    return _.git.pull
    ({
      localPath : context.junction.dirPath,
      sync : 0,
      throwing : 'full',
    });
  });

  context.ready.tap( () =>
  {
    provider.archive.restoreLinksEnd();
  });

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.map = { verbosity : 2 }
    context2.will.hooks.ProtoSync.call( context2 );
  }

  context.ready.catch( ( err ) =>
  {
    err = _.errBrief( err );
    logger.error( _.errOnce( err ) );
    throw err;
  });

}

onModule.defaults =
{
  v : null,
  verbosity : 2,
}
module.exports = onModule;
