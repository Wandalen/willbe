
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( !it.module )
  return;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let fileProvider = new _.FileFilter.Archive();
  let config = _.fileProvider.fileConfigUserRead();

  /* basePath */

  let basePath = _.arrayAs( it.junction.dirPath );
  if( config && config.path && config.path.link )
  _.arrayAppendArrayOnce( basePath, _.arrayAs( config.path.link ) );
  basePath = _.path.s.join( it.will.withPath, basePath );
  _.assert( _.all( fileProvider.statsResolvedRead( basePath ) ) );

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
  logger.log( `Linking ${_.color.strFormat( _.path.commonTextualReport( basePath ), 'path' )}` );

  if( o.dry )
  return;

  /* run */

  if( o.verbosity < 2 )
  fileProvider.archive.verbosity = 0;
  else if( o.verbosity === 2 )
  fileProvider.archive.verbosity = 2;
  else
  fileProvider.archive.verbosity = o.verbosity - 1;

  fileProvider.archive.basePath = basePath;
  fileProvider.archive.mask = maskAll;
  fileProvider.archive.fileMapAutosaving = 1;
  fileProvider.archive.filesUpdate();
  fileProvider.archive.filesLinkSame();

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
