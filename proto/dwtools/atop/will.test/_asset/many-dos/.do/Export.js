
let _;
function onEach( it )
{
  _ = it.tools;
  let logger = it.logger;
  if( !it.module )
  {
    logger.log( it.variant.locationExport() );
    logger.error( `${it.variant.object.absoluteName} is not opened!` );
  }

  if( !it.opener.isValid() )
  return;
  if( it.opener.isRemote )
  return;

  if( it.request.map.verbosity )
  logger.log( `Exporting ${it.variant.locationExport()}` );

  if( it.request.map.dry )
  return;

  // if( !isEnabled( wasconfigPath ) )
  // return;

  it.start( 'local-will .export' );

}

module.exports = onEach;

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
