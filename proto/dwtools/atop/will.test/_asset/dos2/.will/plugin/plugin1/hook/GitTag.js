
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( !it.module || it.module.repo.remotePath || !it.module.about.name )
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
  _.routineOptions( onModule, o );
  if( o.description === null )
  o.description = o.name;

  let localPath = _.git.localPathFromInside( it.junction.dirPath );
  let isRepository = _.git.isRepository({ localPath });

  if( !isRepository )
  return null;

  if( o.verbosity )
  logger.log( `Creating tag ${o.name}` );

  if( o.dry )
  return;

  if( o.light )
  it.start( `git tag ${o.name}` );
  else
  it.start( `git tag -a ${o.name} -m "${o.description}"` );

}

onModule.defaults =
{
  name : null,
  description : null,
  dry : 0,
  light : 0,
  verbosity : 1,
  v : null,
}

module.exports = onModule;
