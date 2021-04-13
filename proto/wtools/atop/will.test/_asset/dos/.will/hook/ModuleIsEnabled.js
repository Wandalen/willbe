
function onModule( context )
{
  let o = context.request.map;
  if( context.module && !context.module.about.enabled )
  return end( false );
  let localPath = context.junction.localPath;
  let npmConfigPath = path.join( localPath, 'package.json' );
  let config = fileProvider.fileReadUnknown( localPath );
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
      logger.log( `${context.junction.object.qualifiedNameDecorated} is ${enabled} at ${context.junction.localPath}` );
    }
    return result;
  }

}

module.exports = onModule;
