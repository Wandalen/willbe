
function onModule( it )
{
  let o = it.request.map;
  if( it.module && !it.module.about.enabled )
  return end( false );
  let localPath = it.variant.localPath;
  let npmConfigPath = _.path.join( localPath, 'package.json' );
  let config = _.fileProvider.fileConfigRead( localPath );
  if( !config.name )
  return end( false );
  if( config.enabled !== undefined && !config.enabled )
  return end( false );
  return end( true );

  function end( result )
  {
    if( o.verbosity )
    {
      let enabled = enabled ? 'enabled' : 'disabled';
      logger.log( `${it.variant.object.qualifiedNameDecorated} is ${enabled} at ${it.variant.localPath}` );
    }
    return result;
  }

}

module.exports = onModule;
