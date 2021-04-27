
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  // if( !context.module || context.module.repo.remotePath || !context.module.about.name )
  if( !context.module || !context.module.about.name )
  {
    debugger;
    throw _.errBrief( 'Module should be local, opened and have name' );
  }

  if( !_.strDefined( o.name ) )
  {
    debugger;
    throw _.errBrief( 'Expects name of tag defined' );
  }

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );
  if( o.description === null )
  o.description = o.name;

  let localPath = _.git.localPathFromInside( context.junction.dirPath );
  let isRepository = _.git.isRepository({ localPath });

  if( !isRepository )
  return null;

  if( o.verbosity )
  logger.log( `Creating tag ${o.name}` );

  if( o.dry )
  return;

  _.git.tagMake
  ({
    localPath,
    tag : o.name,
    description : o.description || '',
    light : o.light,
    sync : 1,
  });

  // if( o.light )
  // context.start( `git tag ${o.name}` );
  // else
  // context.start( `git tag -a ${o.name} -m "${o.description}"` );

}

onModule.defaults =
{
  name : null,
  description : '',
  dry : 0,
  light : 0,
  verbosity : 1,
  v : null,
}

module.exports = onModule;
