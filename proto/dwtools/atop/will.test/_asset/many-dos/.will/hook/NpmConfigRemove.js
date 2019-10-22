
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;
  let inPath = it.module ? it.module.dirPath : it.opener.dirPath;
  let packagePath = _.path.join( inPath, 'package.json' );
  let wasPackagePath = _.path.join( inPath, 'was.package.json' );
  let oldPackagePath = _.path.join( inPath, 'package-old.json' );

  if( !it.request.map.dry )
  _.fileProvider.filesDelete( oldPackagePath );

  if( !_.fileProvider.fileExists( packagePath ) )
  return;

  logger.log( it.variant.locationExport() );
  logger.log( `Renaming ${wasPackagePath} <- ${packagePath}` );

  if( it.request.map.dry )
  return;

  _.fileProvider.filesDelete( wasPackagePath );
  _.fileProvider.fileRename( wasPackagePath, packagePath );

}

module.exports = onEach;
