
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );

  if( !_.git.isRepository({ localPath : context.junction.dirPath, sync : 1 }) )
  return;

  if( o.verbosity )
  logger.log( `Resetting ${context.junction.nameWithLocationGet()}` );

  // if( o.dry )
  // return;

  _.git.reset
  ({
    localPath : context.junction.dirPath,
    removingUntracked : o.removingUntracked,
    removingIgnored : o.removingIgnored,
    removingSubrepositories : o.removingSubrepositories,
    dry : o.dry,
    sync : 1,
  });

}

var defaults = onModule.defaults = Object.create( null );
defaults.dry = 0;
defaults.v = null;
defaults.verbosity = 2;
defaults.removingUntracked = 0;
defaults.removingIgnored = 0,
defaults.removingSubrepositories = 0,
module.exports = onModule;
