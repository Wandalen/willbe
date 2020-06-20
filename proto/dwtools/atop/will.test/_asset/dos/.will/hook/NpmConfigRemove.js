
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let packagePath = path.join( inPath, 'package.json' );
  let wasPackagePath = path.join( inPath, 'was.package.json' );
  let oldPackagePath = path.join( inPath, 'package-old.json' );

  if( !o.dry )
  fileProvider.filesDelete( oldPackagePath );

  if( !fileProvider.fileExists( packagePath ) )
  return;

  if( o.verbosity )
  logger.log( context.junction.nameWithLocationGet() );
  if( o.verbosity )
  logger.log( `Renaming ${wasPackagePath} <- ${packagePath}` );

  if( o.dry )
  return;

  fileProvider.filesDelete( wasPackagePath );
  fileProvider.fileRename( wasPackagePath, packagePath );

}

module.exports = onModule;
