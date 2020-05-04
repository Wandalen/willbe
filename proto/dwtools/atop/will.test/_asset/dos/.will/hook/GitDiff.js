
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  if( !_.git.isRepository({ localPath : it.junction.dirPath, sync : 1 }) )
  return;

  if( o.verbosity )
  logger.log( `Diff ${it.junction.nameWithLocationGet()}` );

  _.git.diff
  ({
    localPath : it.junction.dirPath,
    sync : 1,
  })

}

var defaults = onModule.defaults = Object.create( null );
defaults.v = null;
defaults.verbosity = 2;
module.exports = onModule;
