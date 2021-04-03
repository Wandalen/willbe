
let _;
function onModule( context )
{
  let o = context.request.map;
  _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( !context.module )
  return;
  if( !context.opener.isValid() )
  return;
  if( context.opener.isRemote )
  return;
  if( !context.module.about.enabled )
  return;

  if( !npmConfigIsEnabled( context, 'package.json' ) )
  return;
  if( !npmConfigIsEnabled( context, 'was.package.json' ) )
  return;

  if( o.verbosity )
  logger.log( `Exporting ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  context.startWill( `.export ${context.request.original}` );

}

module.exports = onModule;

//

function npmConfigIsEnabled( context, fileName )
{
  let npmConfigPath = path.join( context.junction.dirPath, fileName );
  if( fileProvider.fileExists( npmConfigPath ) )
  if( !isEnabled( npmConfigPath ) )
  return false;
  return true;
}

//

function isEnabled( localPath )
{
  if( !_.strEnds( path.fullName( localPath ), '.json' ) )
  localPath = path.join( localPath, 'package.json' );
  let config = fileProvider.fileReadUnknown( localPath );
  if( !config.name )
  return false;
  if( config.enabled !== undefined && !config.enabled )
  return false;
  return true;
}
