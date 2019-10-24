
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let inPath = it.module ? it.module.dirPath : it.opener.dirPath;
  let packagePath = _.path.join( inPath, 'package.json' );
  let wasPackagePath = _.path.join( inPath, 'was.package.json' );
  let oldPackagePath = _.path.join( inPath, 'package-old.json' );

  if( !o.dry )
  _.fileProvider.filesDelete( oldPackagePath );

  if( !_.fileProvider.fileExists( packagePath ) )
  return;

  if( o.verbosity )
  logger.log( it.variant.nameWithLocationGet() );
  if( o.verbosity )
  logger.log( `Renaming ${wasPackagePath} <- ${packagePath}` );

  if( o.dry )
  return;

  _.fileProvider.filesDelete( wasPackagePath );
  _.fileProvider.fileRename( wasPackagePath, packagePath );

}

module.exports = onModule;
