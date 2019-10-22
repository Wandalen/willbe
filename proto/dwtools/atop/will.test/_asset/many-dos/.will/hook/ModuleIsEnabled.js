
function onModule( it )
{
  if( it.module && !it.module.about.enabled )
  return false;
  let localPath = it.variant.localPath;
  let npmConfigPath = _.path.join( localPath, 'package.json' );
  let config = _.fileProvider.fileConfigRead( localPath );
  if( !config.name )
  return false;
  if( config.enabled !== undefined && !config.enabled )
  return false;
  return true;
}

module.exports = onModule;
