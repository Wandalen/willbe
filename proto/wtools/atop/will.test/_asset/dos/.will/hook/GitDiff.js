
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
  logger.log( `Diff ${context.junction.nameWithLocationGet()}` );

  /* Generates colored diff patch with minimal amount of context */

  let result = _.git.diff
  ({
    localPath : context.junction.dirPath,
    generatingPatch : 1,
    coloredPatch : 1,
    detailing : 1,
    explaining : 1,
    linesOfContext : 0,
    sync : 1,
  })

  if( !result.status && !result.patch )
  return;

  logger.log( `Status:\n${result.status}` );
  logger.log( `Patch:\n${result.patch}` );

}

var defaults = onModule.defaults = Object.create( null );
defaults.v = null;
defaults.verbosity = 2;
module.exports = onModule;
