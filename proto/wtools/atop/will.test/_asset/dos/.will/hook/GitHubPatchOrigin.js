
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( !context.module )
  return;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();

  if( !context.module.about.name )
  return;

  if( !_.git.isRepository({ localPath : context.junction.dirPath }) )
  return;

  _.sure( _.strDefined( config.about.user ), 'Expects {-config.about.user-}' );
  _.sure( _.strDefined( context.module.about.name ), 'Expects {-module.about.name-}' );

  /* basePath */

  context.startNonThrowing( `git remote show origin` )
  .then( ( op ) =>
  {
    debugger;
    if( !_.strHas( op.output, 'https://github.com/' ) )
    {
      logger.log( `Nothing to patch at ${_.ct.format( context.junction.dirPath, 'path' )}` );
      return op;
    }
    logger.log( `Patching ${_.ct.format( context.junction.dirPath, 'path' )}` );
    if( o.dry )
    return null;
    let ready = _.take( null );
    context.start({ execPath : `git remote set-url origin git+ssh://git@github.com/${config.about.user}/${context.module.name}.git`, ready });
    context.start({ execPath : `git remote show origin`, ready });
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
