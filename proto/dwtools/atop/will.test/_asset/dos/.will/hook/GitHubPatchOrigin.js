
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( !it.module )
  return;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let config = _.fileProvider.configUserRead();

  if( !it.module.about.name )
  return;

  if( !_.git.isRepository({ localPath : it.junction.dirPath }) )
  return;

  _.sure( _.strDefined( config.about.user ), 'Expects {-config.about.user-}' );
  _.sure( _.strDefined( it.module.about.name ), 'Expects {-module.about.name-}' );

  /* basePath */

  it.startNonThrowing( `git remote show origin` )
  .then( ( op ) =>
  {
    debugger;
    if( !_.strHas( op.output, 'https://github.com/' ) )
    {
      logger.log( `Nothing to patch at ${_.ct.format( it.junction.dirPath, 'path' )}` );
      return op;
    }
    logger.log( `Patching ${_.ct.format( it.junction.dirPath, 'path' )}` );
    if( o.dry )
    return null;
    let ready = new _.Consequence().take( null );
    it.start({ execPath : `git remote set-url origin git+ssh://git@github.com/${config.about.user}/${it.module.name}.git`, ready });
    it.start({ execPath : `git remote show origin`, ready });
    return null;
  })

  if( o.beeping )
  _.diagnosticBeep();


}

onModule.defaults =
{
  v : null,
  verbosity : 2,
  dry : 0,
  beeping : 0,
}

module.exports = onModule;
