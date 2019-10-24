
let _;
function onModule( it )
{
  let o = it.request.map;
  _ = it.tools;
  let logger = it.logger;

  if( !it.module )
  return;
  if( !it.opener.isValid() )
  return;
  if( it.opener.isRemote )
  return;
  if( !it.module.about.enabled )
  return;

  if( !npmConfigIsEnabled( it, 'package.json' ) )
  return;
  if( !npmConfigIsEnabled( it, 'was.package.json' ) )
  return;

  if( o.verbosity )
  logger.log( `Exporting ${it.variant.locationExport()}` );

  if( o.dry )
  return;

  it.startWill( `.export ${it.request.original}` );

}

module.exports = onModule;

//

function npmConfigIsEnabled( it, fileName )
{
  let npmConfigPath = _.path.join( it.variant.dirPath, fileName );
  if( _.fileProvider.fileExists( npmConfigPath ) )
  if( !isEnabled( npmConfigPath ) )
  return false;
  return true;
}

//

function isEnabled( localPath )
{
  if( !_.strEnds( _.path.fullName( localPath ), '.json' ) )
  localPath = _.path.join( localPath, 'package.json' );
  let config = _.fileProvider.fileConfigRead( localPath );
  if( !config.name )
  return false;
  if( config.enabled !== undefined && !config.enabled )
  return false;
  return true;
}
