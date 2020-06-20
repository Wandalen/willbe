
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  if( !_.git.isRepository({ localPath : context.junction.dirPath, sync : 1 }) )
  return;

  if( o.verbosity )
  logger.log( `Resetting ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  _.git.reset
  ({
    localPath : context.junction.dirPath,
    sync : 1,
  })

}

var defaults = onModule.defaults = Object.create( null );
defaults.tag = null;
defaults.dry = 0;
defaults.v = null;
defaults.verbosity = 2;
defaults.removingUntracked = null;
module.exports = onModule;
