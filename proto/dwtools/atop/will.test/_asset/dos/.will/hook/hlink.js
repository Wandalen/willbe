
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
  _.routineOptions( onModule, o );

  let fileProvider2 = new _.FileFilter.Archive();
  let config = fileProvider2.configUserRead( _.censor.storageConfigPath );

  /* basePath */

  let basePath = _.arrayAs( context.junction.dirPath );
  if( config && config.path && config.path.hlink )
  _.arrayAppendArrayOnce( basePath, _.arrayAs( config.path.hlink ) );
  basePath = path.s.join( context.will.withPath, basePath );
  _.assert( _.all( fileProvider2.statsResolvedRead( basePath ) ) );

  /* mask */

  let excludeAny =
  [
    /(\W|^)node_modules(\W|$)/,
    /\.unique$/,
    /\.git$/,
    /\.svn$/,
    /\.hg$/,
    /\.tmp($|\/)/,
    /\.DS_Store$/,
    /(^|\/)-/,
  ]

  let maskAll = _.RegexpObject( excludeAny, 'excludeAny' );

  /* log */

  if( o.verbosity )
  logger.log( `Linking ${_.color.strFormat( path.commonTextualReport( basePath ), 'path' )}` );

  if( o.dry )
  return;

  /* run */

  if( o.verbosity < 2 )
  fileProvider2.archive.verbosity = 0;
  else if( o.verbosity === 2 )
  fileProvider2.archive.verbosity = 2;
  else
  fileProvider2.archive.verbosity = o.verbosity - 1;
  fileProvider2.archive.allowingMissed = 0;
  fileProvider2.archive.allowingCycled = 0;

  fileProvider2.archive.basePath = basePath;
  fileProvider2.archive.mask = maskAll;
  fileProvider2.archive.fileMapAutosaving = 1;
  fileProvider2.archive.filesUpdate();
  fileProvider2.archive.filesLinkSame();

  if( o.beeping )
  _.diagnosticBeep();

}

onModule.defaults =
{
  v : null,
  verbosity : 2,
  dry : 0,
  beeping : 1,
}

module.exports = onModule;
